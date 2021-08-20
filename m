Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73F3F35E6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 23:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240060AbhHTVLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 17:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239997AbhHTVLI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 17:11:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FFD6610CC;
        Fri, 20 Aug 2021 21:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629493830;
        bh=+hXcMODXmnsZlbnLMh0KDBhttdVnm9VF04ICSlE6y/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Wc3lbFqBp/ga2gYVJUcvVnKaIVTy9wuWBTSPu0ly+aE+kXI66EQsxUIRrrZnJDBQ1
         /H8LYcYu4veYC2ftqRF8jrAOrIVH1ULlcDEIjkEdv2lbrkCF+j1yUnmEBJqt1krx+X
         t1iK+nbJGIou5bOa+2aUpiC+OPGNz77+WcEbvlL0tyhZjjpM/YxiZIWvctg/O9Ay1m
         KY+HXJo3Dx77TSws1l3ZgsoggOsG2ompVf3b1E1HMvtD6dd5TP2nD1kFfIvbujTFMy
         t65mVWIbcN0N2C2fRg6Qc1vOJdG9mQ/mUjua0WJ1iyJRG/E1SiXMBJ+1uzZc6x1GEn
         cSBwXo38+yZTA==
Date:   Fri, 20 Aug 2021 16:10:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     bhelgaas@google.com, david.e.box@linux.intel.com,
        linux-pci@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: Re: [PATCH] pci: ptm: remove error message at boot
Message-ID: <20210820211028.GA3358973@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811185955.3112534-1-kuba@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 11, 2021 at 11:59:55AM -0700, Jakub Kicinski wrote:
> Since commit 39850ed51062 ("PCI/PTM: Save/restore Precision
> Time Measurement Capability for suspend/resume") devices
> which have PTM capability but don't enable it see this
> message on calls to pci_save_state():
> 
>   "no suspend buffer for PTM"
> 
> Drop the message, it's perfectly fine not to use a capability.
> 
> Fixes: 39850ed51062 ("PCI/PTM: Save/restore Precision Time Measurement Capability for suspend/resume")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Applied to pci/misc for v5.15, thanks!

I fixed your subject line to match previous ones and converted David's
informal ack to an actual "Acked-by".

> ---
>  drivers/pci/pcie/ptm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 95d4eef2c9e8..4810faa67f52 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -60,10 +60,8 @@ void pci_save_ptm_state(struct pci_dev *dev)
>  		return;
>  
>  	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
> -	if (!save_state) {
> -		pci_err(dev, "no suspend buffer for PTM\n");
> +	if (!save_state)
>  		return;
> -	}
>  
>  	cap = (u16 *)&save_state->cap.data[0];
>  	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
> -- 
> 2.31.1
> 
