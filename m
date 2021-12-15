Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52A44763C7
	for <lists+linux-pci@lfdr.de>; Wed, 15 Dec 2021 21:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhLOUxY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Dec 2021 15:53:24 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56492 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhLOUxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Dec 2021 15:53:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D58FC61A11
        for <linux-pci@vger.kernel.org>; Wed, 15 Dec 2021 20:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E601EC36AE3;
        Wed, 15 Dec 2021 20:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639601603;
        bh=qslj5YDJT/oziXcGFmt8xCHZmUTsCgb8jHBhRsYSXDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P0jQKoE+XdsOHo60qoB7J+yCaElAF4sq/kuA17Jkr/BH7hyUpNy6RRvVrNLCDBpFh
         b73XtBAAGyLbqTQgHYLkvxv5oE0X/1MJzOoGI/q9Svku69Q13Qev/bSCAxRfW9xQ6f
         yeVJJbhC0QKBhcpZMbnKz7LqYbTHSvPUoHPu/E+q/hr5jpb+Wfi+k7d1ZKdSgNWBNO
         hlvHQXkblR6hZo2tFbwP2kd5B0Klt89+kCPU85Wl/FlFXfNyuoWsEbe0sTfb+Iq5ld
         R5ahvTJeAgOrG+UYGbil3pnPtgxZLdSec87UZEtyXBI8mDyhZEt6K7n2fkDWxyjBxN
         CSBWd7W9yJ1sw==
Date:   Wed, 15 Dec 2021 14:53:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH RESEND] PCI/VPD: Add simple VPD read cache
Message-ID: <20211215205321.GA711087@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd245a0-c088-c5e1-a2be-913c96f44bc9@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 18, 2021 at 10:10:20PM +0100, Heiner Kallweit wrote:
> VPD reads can be time-consuming operations, and when reading bytes
> sequentially then worst-case we may read the same VPD dword four times.
> Typically it happens in pci_vpd_size() already that the same VPD dword
> is read more than once. Therefore let's add a simple read cache that
> caches the last read VPD dword.

This adds 8 more bytes to pci_dev for everybody.  Can you quantify the
benefit?  It seems like well-formed VPD typically has 3-4 tags, so
we'd be talking about maybe optimizing 20ish reads (4 bytes per tag,
reading the same dword 4 times per tag) down to 3-4 dword reads.  Not
sure the cost/benefit really pays off here.

For crappy devices with junk in their VPD, I certainly see how we
could do a huge number of reads.  But that doesn't seem like it would
be worth optimizing.

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/vpd.c   | 13 +++++++++++++
>  include/linux/pci.h |  2 ++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 75e48df2e..2315e45f6 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -194,6 +194,11 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>  			break;
>  		}
>  
> +		if (vpd->cached_offset == (pos & ~3)) {
> +			val = vpd->cached_val;
> +			goto process;
> +		}
> +
>  		ret = pci_user_write_config_word(dev, vpd->cap + PCI_VPD_ADDR,
>  						 pos & ~3);
>  		if (ret < 0)
> @@ -206,6 +211,9 @@ static ssize_t pci_vpd_read(struct pci_dev *dev, loff_t pos, size_t count,
>  		if (ret < 0)
>  			break;
>  
> +		vpd->cached_val = val;
> +		vpd->cached_offset = pos & ~3;
> +process:
>  		skip = pos & 3;
>  		for (i = 0;  i < sizeof(u32); i++) {
>  			if (i >= skip) {
> @@ -242,6 +250,10 @@ static ssize_t pci_vpd_write(struct pci_dev *dev, loff_t pos, size_t count,
>  		return -EINTR;
>  
>  	while (pos < end) {
> +		/* invalidate read cache */
> +		if (vpd->cached_offset == pos)
> +			vpd->cached_offset = -1;
> +
>  		ret = pci_user_write_config_dword(dev, vpd->cap + PCI_VPD_DATA,
>  						  get_unaligned_le32(buf));
>  		if (ret < 0)
> @@ -270,6 +282,7 @@ void pci_vpd_init(struct pci_dev *dev)
>  
>  	dev->vpd.cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
>  	mutex_init(&dev->vpd.lock);
> +	dev->vpd.cached_offset = -1;
>  }
>  
>  static ssize_t vpd_read(struct file *filp, struct kobject *kobj,
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cd8aa6fce..fb123c248 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -297,6 +297,8 @@ enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);
>  struct pci_vpd {
>  	struct mutex	lock;
>  	unsigned int	len;
> +	u32		cached_val;
> +	int		cached_offset;
>  	u8		cap;
>  };
>  
> -- 
> 2.33.0
> 
