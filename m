Return-Path: <linux-pci+bounces-712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F13F80AD60
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 20:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1987B2818A9
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 19:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB92F50262;
	Fri,  8 Dec 2023 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAc7dxAv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108B481D4
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 19:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22F6C433C7;
	Fri,  8 Dec 2023 19:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702065241;
	bh=W7BRZluTdR9O9RPqOJrs5LIq7KXHrEpCq4+CAsseqCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mAc7dxAvYRSBUqZcvd7zQccXSyahXMQGK+AVUTLgsqTil1PAfbnetTTZcFCupf84E
	 Jr3eLLx+/wmfmTQTebgCiBkcV7FnAhTzdLk7LDCBuJwbhNAmIKWRbX9BdCOR0Xf1pz
	 bEhgUreHrPTAEiujHMzMHFhFb93QoJ8IgqBdEmmwThLQn19y1E9vkJIxw4Tt7d7XGr
	 qi64Mibw+YUw+C1PXm0Yt0I7Zh48Jtyh1J+yxviDHo4e7zKudg/Dus6Q18o2pEppPs
	 1oWEwHhZ1ABuvBL64JaZqbFcLBqLPY0MU5zTqU92ozYnmtcFoY3bUHkchzlI7teowE
	 qgLA6zgqAjyCQ==
Date: Fri, 8 Dec 2023 13:53:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>, Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
	Philipp Rosenberger <p.rosenberger@kunbus.com>,
	Cyril Brulebois <kibi@debian.org>
Subject: Re: [PATCH] PCI: brcmstb: Avoid downstream access during link
 training
Message-ID: <20231208195359.GA808176@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385baf9dbfb6b65112803998dfc0cd6f84a5e6ba.1691296765.git.lukas@wunner.de>

On Sun, Aug 06, 2023 at 06:44:50AM +0200, Lukas Wunner wrote:
> The Broadcom Set Top Box PCIe controller signals an Asynchronous SError
> Interrupt and thus causes a kernel panic when non-posted transactions
> time out.  This differs from most other PCIe controllers which return a
> fabricated "all ones" response instead.
> 
> To avoid gratuitous kernel panics, the driver reads the link status from
> a proprietary PCIE_MISC_PCIE_STATUS register and skips downstream
> accesses if the link is down.
> 
> However the bits in the proprietary register may purport that the link
> is up even though link training is still in progress (as indicated by
> the Link Training bit in the Link Status register).
> 
> This has been observed with various PCIe switches attached to a BCM2711
> (Raspberry Pi CM4):  The issue is most pronounced with the Pericom
> PI7C9X2G404SV, but has also occasionally been witnessed with the Pericom
> PI7C9X2G404SL and ASMedia ASM1184e.
> 
> Check the Link Training bit in addition to the PCIE_MISC_PCIE_STATUS
> register before performing downstream accesses.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: <stable@vger.kernel.org>

Since there was a fair bit of discussion and no obvious conclusion,
I'm dropping this for now.  Please repost if appropriate and maybe we
can get some testing/reviews/acks.

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index f593a422bd63..b4abfced8e9b 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -679,8 +679,10 @@ static bool brcm_pcie_link_up(struct brcm_pcie *pcie)
>  	u32 val = readl(pcie->base + PCIE_MISC_PCIE_STATUS);
>  	u32 dla = FIELD_GET(PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK, val);
>  	u32 plu = FIELD_GET(PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK, val);
> +	u16 lnksta = readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKSTA);
> +	u16 lt = FIELD_GET(PCI_EXP_LNKSTA_LT, lnksta);
>  
> -	return dla && plu;
> +	return dla && plu && !lt;
>  }
>  
>  static void __iomem *brcm_pcie_map_bus(struct pci_bus *bus,
> -- 
> 2.39.2
> 

