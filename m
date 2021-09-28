Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA0841B690
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 20:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbhI1StE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 14:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236720AbhI1StE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 14:49:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 684BF60ED7;
        Tue, 28 Sep 2021 18:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632854844;
        bh=pFigxhX2RA6De4xqi56TGE6YxgO2OiuJ5+7X8oiZJBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tA/OqfgZOke9o0eqgm6nl5BHAZvMAOVJ+kfEmfxXZu9tnRzHw/vJm8pqPNtH0MR3m
         3RcCwgryE5dpIAAlTLAMJ3dRosFZatM0xyvF6T7hwJZOhkDnmmo4QEk5tOLM/pJ3G3
         VcmSDfzFcC3hNvI4Nw7C6dkuY4+wp4eSM8Ow5RziB6cIjbhTfr3pTX17W0nnFW3QJa
         MIRdplNPZPeKElhPkBPIIUPXtF9qitExNX+Xp1jUoxzBx1fCx2ZBISH8pIhDALk8xR
         tOpC82y6NUPBv53EnFdpOV4wGU8W4UwdYHKUFcFeMj8QhZWU5UJCAEhWxZxJByG00E
         6n/k7TgFU6u0Q==
Date:   Tue, 28 Sep 2021 13:47:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pranay Sanghai <pranaysanghai@gmail.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/pci/setup-irq.c: Fix up comments.
Message-ID: <20210928184723.GA717133@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUZJenW2UCA4Qu0O@pranay-desktop>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 18, 2021 at 01:18:02PM -0700, Pranay Sanghai wrote:
> Make comments follow multi-line comment conventions. No functional change intended.
> 
> Signed-off-by: Pranay Sanghai <pranaysanghai@gmail.com>

Applied to pci/misc for v5.16, with the changes below, thanks!

  - Updated subject line to follow the convention (see "git log
    --oneline drivers/pci/setup-irq.c").

  - Rewrapped commit log to fit in 75 columns so it fits in 80 when
    "git log" indents it.

  - Rewrapped comments to fill 80 columns like the rest of the file.

  - Replaced "'cos" with "because".

> ---
>  drivers/pci/setup-irq.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
> index 7129494754dd..ed628771250b 100644
> --- a/drivers/pci/setup-irq.c
> +++ b/drivers/pci/setup-irq.c
> @@ -28,12 +28,13 @@ void pci_assign_irq(struct pci_dev *dev)
>  		return;
>  	}
>  
> -	/* If this device is not on the primary bus, we need to figure out
> -	   which interrupt pin it will come in on.   We know which slot it
> -	   will come in on 'cos that slot is where the bridge is.   Each
> -	   time the interrupt line passes through a PCI-PCI bridge we must
> -	   apply the swizzle function.  */
> -
> +	/*
> +	 * If this device is not on the primary bus, we need to figure out
> +	 * which interrupt pin it will come in on. We know which slot it
> +	 * will come in on 'cos that slot is where the bridge is. Each
> +	 * time the interrupt line passes through a PCI-PCI bridge we must
> +	 * apply the swizzle function.
> +	 */
>  	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
>  	/* Cope with illegal. */
>  	if (pin > 4)
> @@ -56,7 +57,9 @@ void pci_assign_irq(struct pci_dev *dev)
>  
>  	pci_dbg(dev, "assign IRQ: got %d\n", dev->irq);
>  
> -	/* Always tell the device, so the driver knows what is
> -	   the real IRQ to use; the device does not use it. */
> +	/*
> +	 * Always tell the device, so the driver knows what is
> +	 * the real IRQ to use; the device does not use it.
> +	 */
>  	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, irq);
>  }
> -- 
> 2.33.0
> 
