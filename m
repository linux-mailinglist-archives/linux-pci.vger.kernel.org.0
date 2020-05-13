Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9341E1D2067
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 22:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgEMUuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 May 2020 16:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgEMUuT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 May 2020 16:50:19 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4C792054F;
        Wed, 13 May 2020 20:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589403019;
        bh=dcCEwjcmXsZipKu0fxi6DCqJF6S8rR4Y/Myi70ei5T0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jLHAfIi1m2dkEe4PXv94mLbiEXUF9PK4KstC1B916Ts0uqFsCcBYB55WWUjFJFbd3
         3JnE+iDn3C1s17D04SLvEDcFLa0fgI2p2eza/HeWELK7OOUhkF90KPyMR/s/TFDb3Y
         0uxC7hWn3IPPg9Nnf7jqCvmDnDL/4irPLXdaXgLs=
Date:   Wed, 13 May 2020 15:50:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] PCI/DPC: print IRQ number used by DPC port
Message-ID: <20200513205016.GA346608@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589018214-52752-1-git-send-email-yangyicong@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, May 09, 2020 at 05:56:54PM +0800, Yicong Yang wrote:
> Add print of IRQ number used by DPC port, like AER/PME does. It
> provides convenience to track DPC interrupts counts of certain
> port from /proc/interrupts.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Applied to pci/error for v5.8, thanks!

> ---
>  drivers/pci/pcie/dpc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 7621704..ae6b553 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -301,6 +301,7 @@ static int dpc_probe(struct pcie_device *dev)
> 
>  	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>  	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
> +	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
> 
>  	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
>  		 cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
> --
> 2.8.1
> 
