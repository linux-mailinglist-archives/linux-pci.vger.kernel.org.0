Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0966030D017
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 01:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBCAA3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 19:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:55316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231158AbhBCAA2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 19:00:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 118FA64F69;
        Tue,  2 Feb 2021 23:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612310387;
        bh=NKrcguAclK49uyiZmE7tdeu+vwgamjn4VJ8KbXZqfAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rZKKMeVZDfSrewe0CHn9ahM38/woR0C1o41+utOdSdXBZpMR29M4KE70NOXt+0nF+
         gDhMSXkbl7RujR9vRi1VwzyymOdtKy3Z7hD/ub3UYbqG8k8LKR6MjAqdMtSt3LyFXl
         cc2TB2PudqDqhpKIWJICDp/3pVb1raenf2hoRxyT1mXYOqz0Bn6N3Jpo6OzUGLVb3b
         b9EK+0IhYgXkYMD+1iQBabQU9b0dhJsk4ODeo9tzprgHCLfDeXJow7A5JgRdKjhZmz
         xJnoshWrEdyzDD9mmUlxR1gwpftBVygFppgRSDPyFKJlHdR/ZzAlJbborHRh4BcvEt
         sRwzKWNpciCUA==
Date:   Tue, 2 Feb 2021 17:59:45 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI/VPD: Remove dead code from sysfs access functions
Message-ID: <20210202235945.GA151272@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e78f346f-6196-157f-6b74-76e49c708ee0@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 07, 2021 at 10:48:15PM +0100, Heiner Kallweit wrote:
> Since 104daa71b396 ("PCI: Determine actual VPD size on first access")
> attribute size is set to 0 (unlimited). So let's remove this now
> dead code.

Doesn't the 104daa71b396 commit log say "attr->size == 0" means the
size is unknown (not unlimited)?

But I don't think vpd.c does anything at all with attr->size other
than set it to zero.  Is there some reason we can't remove the
"attr->size = 0" assignment, too?

Maybe the sysfs attribute code uses it?  But I don't see vpd.c doing
anything that would contribute to that.

Sorry, I'm just puzzled.

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pci/vpd.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 7915d10f9..a3fd09105 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -403,13 +403,6 @@ static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
>  {
>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
>  
> -	if (bin_attr->size > 0) {
> -		if (off > bin_attr->size)
> -			count = 0;
> -		else if (count > bin_attr->size - off)
> -			count = bin_attr->size - off;
> -	}
> -
>  	return pci_read_vpd(dev, off, count, buf);
>  }
>  
> @@ -419,13 +412,6 @@ static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
>  {
>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
>  
> -	if (bin_attr->size > 0) {
> -		if (off > bin_attr->size)
> -			count = 0;
> -		else if (count > bin_attr->size - off)
> -			count = bin_attr->size - off;
> -	}
> -
>  	return pci_write_vpd(dev, off, count, buf);
>  }
>  
> -- 
> 2.30.0
> 
> 
