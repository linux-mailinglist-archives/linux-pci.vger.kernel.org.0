Return-Path: <linux-pci+bounces-39478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C202C11F13
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 00:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7270B1899ADE
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 23:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347C32779A;
	Mon, 27 Oct 2025 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJn6tTZB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664C2F692C;
	Mon, 27 Oct 2025 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761606770; cv=none; b=IzE+C8O/ql/Ij7ma2ctxE8Bteqs7LVjrgSRwbECnr6lmbwBVpPifNkOcRze0wvsrQ1qvKTRGchypZ/23+NuravnUH0HYw+Za9XVDURBB6/pwjzYnUsTjQp/m1qMLjROeqLea2k2TDV+lJhih0XgTR2A8o/rX9bLsF3qqYS25W5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761606770; c=relaxed/simple;
	bh=Mx3p5zNalpC9MUWdOnA7g5eVCMu0dog1BvFeTo03sQA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J1GWicIPRWWY4dpWTjUbvli+c3HWDgqs2ZFjfnFCHnQUcT8kvBh2hqXmxWVmdgscWRGpBExAVow9eRi0b8wZrGWjHUhnHdsWkn4iiD2hlssb3V6lxMUFlbYy35zUZDGzQ/uMTEMKVG5PvdwlRVty2fTnfwKbICFVjVf+aLE/X00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJn6tTZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37729C4CEF1;
	Mon, 27 Oct 2025 23:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761606770;
	bh=Mx3p5zNalpC9MUWdOnA7g5eVCMu0dog1BvFeTo03sQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qJn6tTZBrzolhoGPvFDtIMzFB4iWvXJA/2UHzeT3Ip4aLUEHQa1JMyhfKp9wdOOmr
	 /DYMeI7gNoJfP8lJGQjJmcFL2AT908Jk4TaFewYx8n0XPmdJVVopb3QUIbItrD8ooc
	 3pCW/P/DIRXyiYpxHMhCi9bZSzPWmlL2z72nbl+AScIwJI2sBNs4l9ev7Wmnt+t4vr
	 1u2nPeYe2UpMdy49ymoycuiSiLJ+8k2HIQRMI2BzbQrPLTPrOBSQX2IUqTnVkst7ip
	 15vOByQbFaFX/gPMEwh5QrPJaxKd63AlGZGQ4y6oqzix50oec6x1Tv7I4/+QiaCYZ5
	 xiYB1Ur0hkprQ==
Date: Mon, 27 Oct 2025 18:12:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Johan Hovold <johan@kernel.org>, Frank Li <Frank.li@nxp.com>,
	Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh@kernel.org>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Han Jingoo <jingoohan1@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Revert "PCI: qcom: Remove custom ASPM enablement code"
Message-ID: <20251027231249.GA1487641@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024210514.1365996-1-helgaas@kernel.org>

On Fri, Oct 24, 2025 at 04:04:57PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This reverts commit a729c16646198872e345bf6c48dbe540ad8a9753.
> 
> Prior to a729c1664619 ("PCI: qcom: Remove custom ASPM enablement code"),
> the qcom controller driver enabled ASPM, including L0s, L1, and L1 PM
> Substates, for all devices powered on at the time the controller driver
> enumerates them.
> 
> ASPM was *not* enabled for devices powered on later by pwrctrl (unless the
> kernel was built with PCIEASPM_POWERSAVE or PCIEASPM_POWER_SUPERSAVE, or
> the user enabled ASPM via module parameter or sysfs).
> 
> After f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> devicetree platforms"), the PCI core enabled all ASPM states for all
> devices whether powered on initially or by pwrctrl, so a729c1664619 was
> unnecessary and reverted.
> 
> But f3ac2ff14834 was too aggressive and broke platforms that didn't support
> CLKREQ# or required device-specific configuration for L1 Substates, so
> df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> enabled only L0s and L1.
> 
> On Qualcomm platforms, this left L1 Substates disabled, which was a
> regression.  Revert a729c1664619 so L1 Substates will be enabled on devices
> that are initially powered on.  Devices powered on by pwrctrl will be
> addressed later.
> 
> Fixes: df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/for-linus for v6.18.

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 32 ++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6948824642dc..c48a20602d7f 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -247,6 +247,7 @@ struct qcom_pcie_ops {
>  	int (*get_resources)(struct qcom_pcie *pcie);
>  	int (*init)(struct qcom_pcie *pcie);
>  	int (*post_init)(struct qcom_pcie *pcie);
> +	void (*host_post_init)(struct qcom_pcie *pcie);
>  	void (*deinit)(struct qcom_pcie *pcie);
>  	void (*ltssm_enable)(struct qcom_pcie *pcie);
>  	int (*config_sid)(struct qcom_pcie *pcie);
> @@ -1038,6 +1039,25 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
> +{
> +	/*
> +	 * Downstream devices need to be in D0 state before enabling PCI PM
> +	 * substates.
> +	 */
> +	pci_set_power_state_locked(pdev, PCI_D0);
> +	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> +
> +	return 0;
> +}
> +
> +static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
> +{
> +	struct dw_pcie_rp *pp = &pcie->pci->pp;
> +
> +	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_aspm, NULL);
> +}
> +
>  static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> @@ -1312,9 +1332,19 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
>  	pcie->cfg->ops->deinit(pcie);
>  }
>  
> +static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +
> +	if (pcie->cfg->ops->host_post_init)
> +		pcie->cfg->ops->host_post_init(pcie);
> +}
> +
>  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>  	.init		= qcom_pcie_host_init,
>  	.deinit		= qcom_pcie_host_deinit,
> +	.post_init	= qcom_pcie_host_post_init,
>  };
>  
>  /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
> @@ -1376,6 +1406,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>  	.get_resources = qcom_pcie_get_resources_2_7_0,
>  	.init = qcom_pcie_init_2_7_0,
>  	.post_init = qcom_pcie_post_init_2_7_0,
> +	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  	.config_sid = qcom_pcie_config_sid_1_9_0,
> @@ -1386,6 +1417,7 @@ static const struct qcom_pcie_ops ops_1_21_0 = {
>  	.get_resources = qcom_pcie_get_resources_2_7_0,
>  	.init = qcom_pcie_init_2_7_0,
>  	.post_init = qcom_pcie_post_init_2_7_0,
> +	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
> -- 
> 2.43.0
> 

