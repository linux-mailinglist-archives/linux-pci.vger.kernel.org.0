Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B5A444BA8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 00:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhKCXdG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 19:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhKCXdF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Nov 2021 19:33:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A373D61106;
        Wed,  3 Nov 2021 23:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635982228;
        bh=7d/S4PKHh5BjgsWH9oW8QND3gTFHBsCnsBmyV42Jt2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UiZpRXk4ZuAg7XsO2NrmzPchHR3tzGZoDm90ziWbXv/x734FXpkyzfGstUzoq+krg
         x23zr8GfxMH7oUxjM5y0z0zjbExRYWVx0EMg6fdA4r81SHLztEitUaQ9b/XN+PH0YJ
         6sPPoHvTwUqGsVuls+6SsO8ib5hMBm/9xcootPivFTGuZ6qwWaa+sLKjSfP7ox2HKV
         5667w2eh3OuhVJ1iGqTFx1XprXM1Qfr33zX0v+PZ8CPCFsf7jG3p1KTTAj13RaZBVT
         qbm2T7Wl2L6HCFGWgyedhHhBsoh++69ketpnp+ZzvBDYQu02GouHe0AIEFEeJDSrxn
         iNUqNwcy0vxDw==
Received: by pali.im (Postfix)
        id 50C087F0; Thu,  4 Nov 2021 00:30:26 +0100 (CET)
Date:   Thu, 4 Nov 2021 00:30:26 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 4/7] PCI: pci_alloc_child_bus() return NULL if
 ->add_bus() returns -ENOLINK
Message-ID: <20211103233026.trzas3cwrb26mqb3@pali>
References: <20211103184939.45263-1-jim2101024@gmail.com>
 <20211103184939.45263-5-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103184939.45263-5-jim2101024@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 03 November 2021 14:49:34 Jim Quinlan wrote:
> Currently, if the call to the pci_ops add_bus() method returns an error, a
> WARNING and dev_err() occurs.  We keep this behavior for all errors except
> -ENOLINK; for -ENOLINK we want to skip the WARNING and immediately return
> NULL.  The argument for this case is that one does not want to continue
> enumerating if pcie-link has not been established.  The real reason is that
> without doing this the pcie-brcmstb.c driver panics when the dev/id is
> read, as this controller panics on such accesses rather than returning
> 0xffffffff.

I think that this is something which should be fixed in the driver, not
in the pci core code. Check in driver code that you can touch HW and if
not return fabricated value 0xffffffff.

> It appears that there are only a few uses of the pci_ops add_bus() method
> in the kernel and none of them currently return -ENOLINK so it should be
> safe to do this.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/probe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index d9fc02a71baa..fdc3f42634b7 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1122,6 +1122,9 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  
>  	if (child->ops->add_bus) {
>  		ret = child->ops->add_bus(child);
> +		/* Don't return the child if w/o pcie link-up */
> +		if (ret == -ENOLINK)

In my opinion ENOLINK is not the correct errno code for signaling
"no link-up" error. IIRC ENOLINK was defined for file/inode links. For
network connections there is ENETDOWN errno code which is more similar
to "no link-up" than inode link.

Anyway, I still do not think if it is a good idea to have this check in
core pci code.

(This is just my opinion... wait for Bjorn with maintainer's hat what
will say that is the best way to handle above issue)

> +			return NULL;
>  		if (WARN_ON(ret < 0))
>  			dev_err(&child->dev, "failed to add bus: %d\n", ret);
>  	}
> -- 
> 2.17.1
> 
