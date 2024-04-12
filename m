Return-Path: <linux-pci+bounces-6197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AACF18A36FF
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 22:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486201F22378
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 20:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7C41509AF;
	Fri, 12 Apr 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBBFqL53"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7295614F9C6;
	Fri, 12 Apr 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712953338; cv=none; b=rD+7R/cTcxggeN7Awxc9EjklxDZVOtT0hKxrXgtD8ZXwlp4HYkyv4rNUjoGYq0LmcH/bRF4/D4Bnl0rGcarv509W4ie82iVObDbAOW9B0XgnkYR1t3wWMCMjHskqx3XdlVa5GFRZXKvf+5ud21ooNu1pXMoQavpa4qqI5dCxC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712953338; c=relaxed/simple;
	bh=sn2OmynqMr6J7esZV94bEU0Yo+Dr7urRItKlgNXXkk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qhh+DVzwfvS1HMMy8VucMrmyNMPMbNMtnFnDrb2d2Auc/7qKpJ3fL2Oj8fkgMv2GmcoIn+KbmYz7B9d/r3WaFNzNwkGA8FHov+iv55PmjED/boSTRTexFMl3QSAo6BDO9qDBCUIsmTY+nQPIeT2dDcsIVjXNwASA39EblkdidJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBBFqL53; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A70C113CC;
	Fri, 12 Apr 2024 20:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712953338;
	bh=sn2OmynqMr6J7esZV94bEU0Yo+Dr7urRItKlgNXXkk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mBBFqL53k8d8ZRiCErYU+z9y7mNs9HHDllT10pZ3ClqXZjEuN0B8ebU0XrYAbSEpa
	 QIQCzjz9kSUPV2Gm101R8qF0Fzm/d2ECYeTqOYdngkP0oFGR/IEq1gIF5QqZJLwFLh
	 FwyDBuniceg4diUmqI1tezD9L6IV7P6ymG4dV/PcGZyQNp9isKFZpILhe3DRxFroRZ
	 kl6wGt76+5I0oZFe7K9D9ea7a2c8J3M7XvW75EVELJ4xyJA6ycIRtQUiukrwLyTuh2
	 Hbb4UXqrYyQamtx23jHin0qc0HsDUuz6DG1NpfKAu+Ky81T3wDDvRZtoadLACzqpGp
	 0K71g/atBsARQ==
Date: Fri, 12 Apr 2024 15:22:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v12 8/8] PCI: endpoint: Remove "core_init_notifier" flag
Message-ID: <20240412202216.GA14590@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-pci-dbi-rework-v12-8-082625472414@linaro.org>

On Wed, Mar 27, 2024 at 02:43:37PM +0530, Manivannan Sadhasivam wrote:
> "core_init_notifier" flag is set by the glue drivers requiring refclk from
> the host to complete the DWC core initialization. Also, those drivers will
> send a notification to the EPF drivers once the initialization is fully
> completed using the pci_epc_init_notify() API. Only then, the EPF drivers
> will start functioning.
> 
> For the rest of the drivers generating refclk locally, EPF drivers will
> start functioning post binding with them. EPF drivers rely on the
> 'core_init_notifier' flag to differentiate between the drivers.
> Unfortunately, this creates two different flows for the EPF drivers.
> 
> So to avoid that, let's get rid of the "core_init_notifier" flag and follow
> a single initialization flow for the EPF drivers. This is done by calling
> the dw_pcie_ep_init_notify() from all glue drivers after the completion of
> dw_pcie_ep_init_registers() API. This will allow all the glue drivers to
> send the notification to the EPF drivers once the initialization is fully
> completed.

Thanks for doing this!  I think this is a significantly nicer
solution than core_init_notifier was.

One question: both qcom and tegra194 call dw_pcie_ep_init_registers()
from an interrupt handler, but they register that handler in a
different order with respect to dw_pcie_ep_init().

I don't know what actually starts the process that leads to the
interrupt, but if it's dw_pcie_ep_init(), then one of these (qcom, I
think) must be racy:

  qcom_pcie_ep_probe
    dw_pcie_ep_init                                             <- A
    qcom_pcie_ep_enable_irq_resources
      devm_request_threaded_irq(qcom_pcie_ep_perst_irq_thread)  <- B

  qcom_pcie_ep_perst_irq_thread
    qcom_pcie_perst_deassert
      dw_pcie_ep_init_registers

  tegra_pcie_dw_probe
    tegra_pcie_config_ep
      devm_request_threaded_irq(tegra_pcie_ep_pex_rst_irq)      <- B
      dw_pcie_ep_init                                           <- A

  tegra_pcie_ep_pex_rst_irq
    pex_ep_event_pex_rst_deassert
      dw_pcie_ep_init_registers

Whatever the right answer is, I think qcom and tegra194 should both
order dw_pcie_ep_init() and the devm_request_threaded_irq() the same
way.

Bjorn

