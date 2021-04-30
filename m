Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAAF370216
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 22:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhD3Ua3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 16:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234115AbhD3Ua3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Apr 2021 16:30:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3019C61456;
        Fri, 30 Apr 2021 20:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619814580;
        bh=26khl576GRNVXRU+x8DHMPxF7eCf/fHA3siQs4nQSgw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KSE8MJzfIVVn5weVGXvQGubVyzl3VuRTaNJA+ImF5La3DgJUnFDGwjs0WH9wPZEVV
         UAj18dzDcBp2smP9r3lcjLlOFHkUC3Z2Dtx5DegHh4K7hv5J7xGAGzahBMkINMYRiY
         zPsnKQyfQPJ0AFSkZRkL5kaL17qPblvYEuMdozEhwpNQfrPXnrHO50NhmRBl7VpxqU
         XqI3pCXH9vXelLn8EAWT4gsx6VN5fIxwfE4963DZDJNIFQxJZHNy19cXg9agcIGY6Q
         C7p3cfhqtCrJOCHSJHzINduaWTD4XCsGt703lH802sVdzxSfZznet6354XE1RRQE9d
         Fn6aQvxzMImjQ==
Date:   Fri, 30 Apr 2021 15:29:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/VPD: Use unaligned access helper in pci_vpd_write
Message-ID: <20210430202933.GA678605@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79d337f4-25d6-9024-2cbd-63801cbd9992@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 18, 2021 at 11:19:29AM +0200, Heiner Kallweit wrote:
> Use helper get_unaligned_le32() to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/vpd.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 60573f27a..2888bb300 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -9,6 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/export.h>
>  #include <linux/sched/signal.h>
> +#include <asm/unaligned.h>
>  #include "pci.h"
>  
>  /* VPD access through PCI 2.2+ VPD capability */
> @@ -235,10 +236,9 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>  }
>  
>  static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
> -			     const void *arg)
> +			     const void *buf)
>  {
>  	struct pci_vpd *vpd = dev->vpd;
> -	const u8 *buf = arg;
>  	loff_t end = pos + count;
>  	int ret = 0;
>  
> @@ -264,14 +264,8 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>  		goto out;
>  
>  	while (pos < end) {
> -		u32 val;
> -
> -		val = *buf++;
> -		val |= *buf++ << 8;
> -		val |= *buf++ << 16;
> -		val |= *buf++ << 24;
> -
> -		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA, val);
> +		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA,
> +						  get_unaligned_le32(buf));

If I understand correctly, get_unaligned_le32() is equivalent to the
open-coded "val = *buf++; ..."  In other words, this doesn't fix a bug
on any platforms, and it doesn't change the bits written to VPD.
Right?

If so, this makes sense.  I'd like it better if we could also make
pci_vpd_read() look more symmetric, since it has similar byte
order-related code.  The read side is a little more complicated since
the size need not be 4-byte aligned.  But maybe there's a way?  Seems
like there should be other examples of this sort of thing, but my
quick look didn't find one.

>  		if (ret < 0)
>  			break;
>  		ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
> @@ -286,6 +280,7 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>  			break;
>  
>  		pos += sizeof(u32);
> +		buf += sizeof(u32);
>  	}
>  out:
>  	mutex_unlock(&vpd->lock);
> -- 
> 2.31.1
> 
