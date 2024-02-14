Return-Path: <linux-pci+bounces-3462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 187A98552FC
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 20:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AE028F4C9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 19:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9611413A27C;
	Wed, 14 Feb 2024 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4cChNzy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E9E171A2;
	Wed, 14 Feb 2024 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937971; cv=none; b=RonN0RFG4MqY5frDfXQvAwL40KBDqiN8ysMU6CCFmO82ZxJJd4uwhdFNzpU+JOzhdXdYFrtVoRLHDrIB4kDjUNQdNhQqTJlM7KeAu2+HNeWVXTSh1LgOeURUQWDQ2u86nFsZuz2u8bOVumeDvSbjz44V7GkNT5nuNRj2p96SNPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937971; c=relaxed/simple;
	bh=GaNW4qJLhcZQPDq6m88xXy4RMPI4Vwk6x2NaA/U2ssA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rfu/R8oEsHNsg5jT43ErftGqK55ynG+Xp0u2CdFgKb3w142evcuNErpmLJm2bP+X0bxkdsJal2GQ120EramZPR2DuyI4ee+v3hpRHHd5LgAqeqqnlllnfHF6vkJM6F5Hha48hlu7QJi8KjVBC5H2aeJZThOdJMHrVd3xkjzEkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4cChNzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C9DC433C7;
	Wed, 14 Feb 2024 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707937970;
	bh=GaNW4qJLhcZQPDq6m88xXy4RMPI4Vwk6x2NaA/U2ssA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=F4cChNzyKBXOwwfxXYohSyCAMg1dlwLd7cLrxNDuPtwGDI382Mp2mpUlZQn8prFf/
	 NdIU32bTxG4qoylo01LS3cDpCML72NtUL+SNhUdTb+GZev1zuUtUCZi8Zy+LNtKy4z
	 tDEhQZZmpodutqmmBYham8OPm8HxdjIaaNgDx72vr/VowZGVFLXa4fOGHEl8cnUFXt
	 EpU6rWFIc7mrdCoeTkIrjPPgXfFkXD6jMz4T8kFCmOoLHIZuQ9fJISSddWwaMewxMA
	 n8Ox+OnzOe4tapu+/U0GoqEvw13IhuXjYdVFhTAy6fJU6pcSA/PFN+h1Op4gvLaT4S
	 h7NGbTQbsSSFA==
Date: Wed, 14 Feb 2024 13:12:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, bhelgaas@google.com,
	robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, Kishon Vijay Abraham I <kishon@kernel.org>,
	catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	digetx@gmail.com, mperttunen@nvidia.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V16 13/13] PCI: tegra: Add Tegra194 PCIe support
Message-ID: <20240214191249.GA1263222@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813113627.27251-14-vidyas@nvidia.com>

Hi Vidya, question about ancient history:

On Tue, Aug 13, 2019 at 05:06:27PM +0530, Vidya Sagar wrote:
> Add support for Synopsys DesignWare core IP based PCIe host controller
> present in Tegra194 SoC.
> ...

> +static int tegra_pcie_dw_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
> +	u32 val, tmp, offset, speed;
> +
> +	tegra_pcie_prepare_host(pp);
> +
> +	if (dw_pcie_wait_for_link(pci)) {
> +		/*
> +		 * There are some endpoints which can't get the link up if
> +		 * root port has Data Link Feature (DLF) enabled.
> +		 * Refer Spec rev 4.0 ver 1.0 sec 3.4.2 & 7.7.4 for more info
> +		 * on Scaled Flow Control and DLF.
> +		 * So, need to confirm that is indeed the case here and attempt
> +		 * link up once again with DLF disabled.

This comment suggests that there's an issue with *Endpoints*, not an
issue with the Root Port.  If so, it seems like this problem could
occur with all Root Ports, not just Tegra194.  Do you remember any
details about this?

I don't remember hearing about any similar issues, and this driver is
the only place PCI_EXT_CAP_ID_DLF is referenced, so maybe it is
actually something related to Tegra194?

> +		val = appl_readl(pcie, APPL_DEBUG);
> +		val &= APPL_DEBUG_LTSSM_STATE_MASK;
> +		val >>= APPL_DEBUG_LTSSM_STATE_SHIFT;
> +		tmp = appl_readl(pcie, APPL_LINK_STATUS);
> +		tmp &= APPL_LINK_STATUS_RDLH_LINK_UP;
> +		if (!(val == 0x11 && !tmp)) {
> +			/* Link is down for all good reasons */
> +			return 0;
> +		}
> +
> +		dev_info(pci->dev, "Link is down in DLL");
> +		dev_info(pci->dev, "Trying again with DLFE disabled\n");
> +		/* Disable LTSSM */
> +		val = appl_readl(pcie, APPL_CTRL);
> +		val &= ~APPL_CTRL_LTSSM_EN;
> +		appl_writel(pcie, val, APPL_CTRL);
> +
> +		reset_control_assert(pcie->core_rst);
> +		reset_control_deassert(pcie->core_rst);
> +
> +		offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_DLF);
> +		val = dw_pcie_readl_dbi(pci, offset + PCI_DLF_CAP);
> +		val &= ~PCI_DLF_EXCHANGE_ENABLE;
> +		dw_pcie_writel_dbi(pci, offset, val);
> +
> +		tegra_pcie_prepare_host(pp);
> +
> +		if (dw_pcie_wait_for_link(pci))
> +			return 0;
> +	}
> +
> +	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
> +		PCI_EXP_LNKSTA_CLS;
> +	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
> +
> +	tegra_pcie_enable_interrupts(pp);
> +
> +	return 0;
> +}

