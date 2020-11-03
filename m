Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5101D2A5043
	for <lists+linux-pci@lfdr.de>; Tue,  3 Nov 2020 20:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKCTiS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 14:38:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbgKCTiS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Nov 2020 14:38:18 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA9520732;
        Tue,  3 Nov 2020 19:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604432297;
        bh=ChrancI84uudo7GBf/psMLVpwHUgYOr9PFAAEf5CnNg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ohtt544WSZo+m4CG+tHrJLecJvikZ5VBMlgxuvozkeAMRRYXAqkYcjoVMpUgMmsnS
         FO/7/hgmpDQ7ekY5wpI4I/8dv/255Bk1VIJaFCXhJtxnwhtl/NrNP3d4U7G6pOOKW0
         bN4klNRDQ2bGTmE0n7mqk27i/vORvVIa8Ja++bCk=
Date:   Tue, 3 Nov 2020 13:38:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: brcmstb: variable is missing proper
 initialization
Message-ID: <20201103193816.GA258457@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102205712.23332-1-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 02, 2020 at 03:57:12PM -0500, Jim Quinlan wrote:
> The variable 'tmp' is used multiple times in the brcm_pcie_setup()
> function.  One such usage did not initialize 'tmp' to the current value of
> the target register.  By luck the mistake does not currently affect
> behavior;  regardless 'tmp' is now initialized properly.

This is so trivial that there's probably no reason to post this again,
but if you post a v2 for some reason, please update the subject to
match the convention ("PCI: brcmstb: Verb ..."), e.g.,

  PCI: brcmstb: Initialize "tmp" before use

The commit log does not say what the patch does, leaving it to the
reader to infer it.

Lorenzo will likely fix this up when he applies it.

Incidental curiosity: where should I look to see what
u32p_replace_bits() does?  "git grep u32p_replace_bits" shows several
calls, but no definitions.

> Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")
> Suggested-by: Rafał Miłecki <zajec5@gmail.com>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index bea86899bd5d..9c3d2982248d 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -893,6 +893,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  		burst = 0x2; /* 512 bytes */
>  
>  	/* Set SCB_MAX_BURST_SIZE, CFG_READ_UR_MODE, SCB_ACCESS_EN */
> +	tmp = readl(base + PCIE_MISC_MISC_CTRL);
>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK);
>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK);
>  	u32p_replace_bits(&tmp, burst, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
> -- 
> 2.17.1
> 


