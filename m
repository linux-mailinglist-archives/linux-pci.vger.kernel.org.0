Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6B8467BB9
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 17:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbhLCQtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 11:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382108AbhLCQtC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 11:49:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF7BC061353
        for <linux-pci@vger.kernel.org>; Fri,  3 Dec 2021 08:45:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0270DB82893
        for <linux-pci@vger.kernel.org>; Fri,  3 Dec 2021 16:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB2CC53FD0;
        Fri,  3 Dec 2021 16:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638549935;
        bh=svbs9GqA6dkAlNwZDfu7jpwcurU889J/EYm/I9bT80I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fvgoueNZ40MEB1fDUb9f0p3mvszqykUncQimY5/jSqRdmGfUZnzUNFNn+qpS03XyD
         c2fkut9Ak9l0Sw4bDj5yq3c5OKpZI2mbSd4dN16ag2Q3MnCJM70gaa6g/m9OfpJHKD
         7UIkn31BB/m9KvlikmPPcWWY/5w0X4ES7QowDbg4Q5NvMveLsAZfBnVF+4uo7PW8E1
         Q1iNOFn2vmKZfpiq5p6/cAdy6XfG7RKghb97R2YQryiqN1TsaiqX6tHNtIrlUvJJ+2
         A0hBXYXJMJpkbin9tcJsDT3to2vEhtzvr7FdWGBKjMD1T878PqH6raNqUu6OK54Fa+
         W7D3ryQtW0vEg==
Date:   Fri, 3 Dec 2021 10:45:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, pali@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 02/11] PCI: pci-bridge-emul: Add definitions for
 missing capabilities registers
Message-ID: <20211203164534.GA3004622@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211130172913.9727-3-kabel@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 30, 2021 at 06:29:04PM +0100, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> pci-bridge-emul driver already allocates buffer for capabilities up to the
> PCI_EXP_SLTSTA2 register, but does not define bit access behavior for these
> registers. Add these missing definitions.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/pci/pci-bridge-emul.c | 43 +++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
> index a4af1a533d71..0d1177e52a43 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -251,6 +251,49 @@ struct pci_bridge_reg_behavior pcie_cap_regs_behavior[PCI_CAP_PCIE_SIZEOF / 4] =
>  		.ro = GENMASK(15, 0) | PCI_EXP_RTSTA_PENDING,
>  		.w1c = PCI_EXP_RTSTA_PME,
>  	},
> +
> +	[PCI_EXP_DEVCAP2 / 4] = {
> +		/*
> +		 * Device capabilities 2 register has reserved bits [30:27].
> +		 * Also bits [26:24] are reserved for non-upstream ports.
> +		 */
> +		.ro = BIT(31) | GENMASK(23, 0),
> +	},
> +
> +	[PCI_EXP_DEVCTL2 / 4] = {
> +		/*
> +		 * Device control 2 register is RW. Bit 11 is reserved for
> +		 * non-upstream ports.
> +		 *
> +		 * Device status 2 register is reserved.
> +		 */
> +		.rw = GENMASK(15, 12) | GENMASK(10, 0),
> +	},
> +
> +	[PCI_EXP_LNKCAP2 / 4] = {
> +		/* Link capabilities 2 register has reserved bits [30:25] and 0. */

Rewrap (also below).

> +		.ro = BIT(31) | GENMASK(24, 1),
> +	},
> +
> +	[PCI_EXP_LNKCTL2 / 4] = {
> +		/*
> +		 * Link control 2 register is RW.
> +		 *
> +		 * Link status 2 register has bits 5, 15 W1C;
> +		 * bits 10, 11 reserved and others are RO.
> +		 */
> +		.rw = GENMASK(15, 0),
> +		.w1c = (BIT(15) | BIT(5)) << 16,
> +		.ro = (GENMASK(14, 12) | GENMASK(9, 6) | GENMASK(4, 0)) << 16,
> +	},
> +
> +	[PCI_EXP_SLTCAP2 / 4] = {
> +		/* Slot capabilities 2 register is reserved. */
> +	},
> +
> +	[PCI_EXP_SLTCTL2 / 4] = {
> +		/* Both Slot control 2 and Slot status 2 registers are reserved. */
> +	},
>  };
>  
>  /*
> -- 
> 2.32.0
> 
