Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4312EAD3
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 04:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfE3Cxr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 May 2019 22:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfE3Cxr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 May 2019 22:53:47 -0400
Received: from localhost (15.sub-174-234-174.myvzw.com [174.234.174.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD91824436;
        Thu, 30 May 2019 02:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559184826;
        bh=dJjuutwlsJWuUYPVvoDzC466oY9mTX65HsTocKaKpX8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CT7nsMzkVlj7qrxFjlzjbuNUsiSynp6AbLR2KteSpLjoX4qaJJ6QiSMnK26RocgwC
         eH322GNECCspD6RXNH5ZHrS5zx/kAFMB+ochp++NjmDE/hYzWsRxNA1oJ1guY7HjBd
         XEL5uMqI3v/6yPyST67OkEHjBAcw7cfyYUkH03Lg=
Date:   Wed, 29 May 2019 21:53:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v2 3/5] PCI/ATS: Skip VF ATS initialization if PF does
 not implement it
Message-ID: <20190530025344.GG28250@google.com>
References: <cover.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <21d93b3312418c1e28aeec238ef855c72efeb96a.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d93b3312418c1e28aeec238ef855c72efeb96a.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 06, 2019 at 10:20:05AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> If PF does not implement ATS and VF implements/uses it, it might lead to
> runtime issues. Also, as per spec r4.0, sec 9.3.7.8, PF should implement
> ATS if VF implements it. So add additional check to confirm given device
> aligns with the spec.

"might lead to runtime issues" is pretty wishy-washy.  I really don't
want to prevent some device from working merely because it has
something in config space that doesn't follow the spec exactly but we
never touch.

> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Reviewed-by: Keith Busch <keith.busch@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/ats.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index e7a904e347c3..718e6f414680 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -19,6 +19,7 @@
>  void pci_ats_init(struct pci_dev *dev)
>  {
>  	int pos;
> +	struct pci_dev *pdev;
>  
>  	if (pci_ats_disabled())
>  		return;
> @@ -27,6 +28,17 @@ void pci_ats_init(struct pci_dev *dev)
>  	if (!pos)
>  		return;
>  
> +	/*
> +	 * Per PCIe r4.0, sec 9.3.7.8, if VF implements Address Translation
> +	 * Services (ATS) Extended Capability then corresponding PF should
> +	 * also implement it.
> +	 */
> +	if (dev->is_virtfn) {
> +		pdev = pci_physfn(dev);
> +		if (!pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS))
> +			return;
> +	}
> +
>  	dev->ats_cap = pos;
>  }
>  
> -- 
> 2.20.1
> 
