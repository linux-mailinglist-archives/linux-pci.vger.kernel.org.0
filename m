Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12054334A53
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 23:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhCJWAe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 17:00:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231759AbhCJWAc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Mar 2021 17:00:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7296B64EF6;
        Wed, 10 Mar 2021 22:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615413631;
        bh=ReSp2zP54RJS1AahxWZa0ePgAMVlaJXyfLVs8JQqAT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Lqsk+FRi+f/exKF4sZcYF4/Z31p02Sh8HKyOz/RA7OezaDfWe4iJZqIiGtGOtYQH2
         qS9V+ceFH0war3SM2erKFzXrT2D/heVQYgCiBIjnn51Mr6idLVSyHpC5X1UHDCD5oW
         2jXtCMyUIjLk2MM5Gb5yuJ04dkoF4jTwt3yfxq6/EViW9O0KpBt2ftOAQkA3XUVu6l
         co1b35paBosdrQkZYh3uQ8qn5CQF0Ps0XOvDy5tliHBJ+/nFnxuoUpGys1GhykHcSV
         2C87kq9nBLzlcPy84T6HgMrVZCRrbJJNK54Z7wIUJ+XfYvOo6IpSiyiPy2gR5reWvs
         pAfxPRTeU2wLg==
Date:   Wed, 10 Mar 2021 16:00:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Jin, Wen" <wen.jin@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI/RCEC: Fix RCiEP capable devices RCEC
 association
Message-ID: <20210310220030.GA2068330@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222011717.43266-1-qiuxu.zhuo@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 22, 2021 at 09:17:17AM +0800, Qiuxu Zhuo wrote:
> Function rcec_assoc_rciep() incorrectly used "rciep->devfn" (a single
> byte encoding the device and function number) as the device number to
> check whether the corresponding bit was set in the RCiEPBitmap of the
> RCEC (Root Complex Event Collector) while enumerating over each bit of
> the RCiEPBitmap.
> 
> As per the PCI Express Base Specification, Revision 5.0, Version 1.0,
> Section 7.9.10.2, "Association Bitmap for RCiEPs", p. 935, only needs to
> use a device number to check whether the corresponding bit was set in
> the RCiEPBitmap.
> 
> Fix rcec_assoc_rciep() using the PCI_SLOT() macro and convert the value
> of "rciep->devfn" to a device number to ensure that the RCiEP devices
> associated with the RCEC are linked when the RCEC is enumerated.
> 
> Fixes: 507b460f8144 ("PCI/ERR: Add pcie_link_rcec() to associate RCiEPs")
> Reported-and-tested-by: Wen Jin <wen.jin@intel.com>
> Reviewed-by: Sean V Kelley <sean.v.kelley@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

I think 507b460f8144 appeared in v5.11, so not something we broke in
v5.12.  Applied to pci/error for v5.13, thanks!

If I understand correctly, we previously only got this right in one
case:

   0 == PCI_SLOT(00.0)    # correct
   1 == PCI_SLOT(00.1)    # incorrect
   2 == PCI_SLOT(00.2)    # incorrect
   ...
   8 == PCI_SLOT(01.0)    # incorrect
   9 == PCI_SLOT(01.1)    # incorrect
   ...
  31 == PCI_SLOT(03.7)    # incorrect

> ---
> v2->v3:
>  Drop "[ Krzysztof: Update commit message. ]" from the commit message
> 
>  drivers/pci/pcie/rcec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> index 2c5c552994e4..d0bcd141ac9c 100644
> --- a/drivers/pci/pcie/rcec.c
> +++ b/drivers/pci/pcie/rcec.c
> @@ -32,7 +32,7 @@ static bool rcec_assoc_rciep(struct pci_dev *rcec, struct pci_dev *rciep)
>  
>  	/* Same bus, so check bitmap */
>  	for_each_set_bit(devn, &bitmap, 32)
> -		if (devn == rciep->devfn)
> +		if (devn == PCI_SLOT(rciep->devfn))
>  			return true;
>  
>  	return false;
> -- 
> 2.17.1
> 
