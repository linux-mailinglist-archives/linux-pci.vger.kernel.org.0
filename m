Return-Path: <linux-pci+bounces-34926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4177B386E8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 17:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE67346071C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 15:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC562D781E;
	Wed, 27 Aug 2025 15:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy5aSNrp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15E62D0C91;
	Wed, 27 Aug 2025 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309662; cv=none; b=b41O+YqrKgq0Ulfb13JXbQYvDsmuXmXVNFkdJuHGP+7y4Oa01GK6yp8ZjyhosIko+1XusgM8UNqg0mXEEczVdA4JTzWueLo8ePZuq2wTBKZ5VLvjPkx8CXfNo2KvrU7yHYxzqp96lvVwczBopSPC4K/+DmGXS/ixWEAFeXBsT2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309662; c=relaxed/simple;
	bh=mxcSBMoTgvmfaOSxlDt3Ox0+FxehjBeucQjS9ZMt4Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ARQ8DfT/MKIfdh5l93O6MbdTgFrzQB7l0rflfjisnD3BeqjuqI206R318lIU3HP6OcKHPfcX0YZDArTBUMjlnfm9lNWYxZSsswiidEw9tHvxoz3xfmOkLrK1tAuVhMPm/J4mlMzezjXPPV7vYOCB/u2CbiQ8mM6E0G+B/JbCxsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy5aSNrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19337C4CEEB;
	Wed, 27 Aug 2025 15:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756309661;
	bh=mxcSBMoTgvmfaOSxlDt3Ox0+FxehjBeucQjS9ZMt4Vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Hy5aSNrpVl9JJiC7+Fn+wg/YyEXijF4qSZVVsyE+Nzi73/WJPkyGa/uuLSnT7jIil
	 UYX7BIuOwFtt46+zzCaLT8+efOun0PhBIOMPHqqBzwEz/Z6qAYPVKpRv/3LUkjRO/Y
	 WremwAVlL0Fw0ximwz0CRJtiUhbHeqqPtDmRkQKkE5BPcVksOpuWE2Gq3lRn96BDmY
	 oi1Qv5TBv1iXTjb8D7eqywVfyk47C0ImyqeTZnuh+SRdZw1p3SKvDoVASNzqS2OyPS
	 BAqi00srxf3olPrSaB3JiLNn+s8kBWp+Gz/MX254IhOwaYocbGS5baiu486a8N5obs
	 OydAgF1r3nRbw==
Date: Wed, 27 Aug 2025 10:47:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Johan Hovold <johan@kernel.org>, stable+noautosel@kernel.org
Subject: Re: [PATCH v3] PCI: qcom: Use pci_host_set_default_pcie_link_state()
 API to enable ASPM for all platforms
Message-ID: <20250827154739.GA888232@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-qcom_aspm_fix-v3-1-02c8d414eefb@oss.qualcomm.com>

On Mon, Aug 25, 2025 at 01:52:57PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
> ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
> enumerated at the time of the controller driver probe. It proved to be
> useful for devices already powered on by the bootloader, as it allowed
> devices to enter ASPM without user intervention.
> 
> However, it could not enable ASPM for the hotplug capable devices i.e.,
> devices enumerated *after* the controller driver probe. This limitation
> mostly went unnoticed as the Qcom PCI controllers are not hotplug capable
> and also the bootloader has been enabling the PCI devices before Linux
> Kernel boots (mostly on the Qcom compute platforms which users use on a
> daily basis).
> 
> But with the advent of the commit b458ff7e8176 ("PCI/pwrctl: Ensure that
> pwrctl drivers are probed before PCI client drivers"), the pwrctrl driver
> started to block the PCI device enumeration until it had been probed.
> Though, the intention of the commit was to avoid race between the pwrctrl
> driver and PCI client driver, it also meant that the pwrctrl controlled PCI
> devices may get probed after the controller driver and will no longer have
> ASPM enabled. So users started noticing high runtime power consumption with
> WLAN chipsets on Qcom compute platforms like Thinkpad X13s, and Thinkpad
> T14s, etc...
> 
> Obviously, it is the pwrctrl change that caused regression, but it
> ultimately uncovered a flaw in the ASPM enablement logic of the controller
> driver. So to address the actual issue, use the newly introduced
> pci_host_set_default_pcie_link_state() API, which allows the controller
> drivers to set the default ASPM state for *all* devices. This default state
> will be honored by the ASPM driver while enabling ASPM for all the devices.

So I guess this fixes a power consumption regression that became
visible with b458ff7e8176 ("PCI/pwrctl: Ensure that pwrctl drivers are
probed before PCI client drivers").  Arguably we should have a Fixes:
tag for that, and maybe even skip the tag for 9f4f3dfad8cf, since if
you have 9f4f3dfad8cf but not b458ff7e8176, it doesn't sound like you
would need to backport this change?

I *love* getting rid of the bus walk and solving the hotplug issue.

> So with this change, we can get rid of the controller driver specific
> 'qcom_pcie_ops::host_post_init' callback.
> 
> Also with this change, ASPM is now enabled by default on all Qcom
> platforms as I haven't heard of any reported issues (apart from the
> unsupported L0s on some platorms, which is still handled separately).

If ASPM hasn't been enabled by default, how would you hear about
issues?  Is ASPM commonly enabled in some other way?

If you think the risk of ASPM issues is nil, I guess it's OK to do at
the same time.  From a maintenance perspective it might be nice to
separate that change so if there happened to be a regression, we could
identify and revert that part by itself if necessary.  It looks like
previously, ASPM was only enabled for one part:

  ops_2_7_0   # cfg_2_7_0 qcom,pcie-sdm845

But after this patch, ASPM will be enabled for many more parts:

  ops_2_1_0   # cfg_2_1_0 qcom,pcie-apq8064 qcom,pcie-ipq8064 qcom,pcie-ipq8064-v2
  ops_1_0_0   # cfg_1_0_0 qcom,pcie-apq8084
  ops_2_3_2   # cfg_2_3_2 qcom,pcie-msm8996
  ops_2_4_0   # cfg_2_4_0 qcom,pcie-ipq4019 qcom,pcie-qcs404
  ops_2_3_3   # cfg_2_3_3 qcom,pcie-ipq8074
  ops_1_9_0   # cfg_1_9_0 qcom,pcie-sc7280 qcom,pcie-sc8180x qcom,pcie-sdx55 qcom,pcie-sm8150 qcom,pcie-sm8250 qcom,pcie-sm8350 qcom,pcie-sm8450-pcie0 qcom,pcie-sm8450-pcie1 qcom,pcie-sm8550
	      # cfg_1_34_0 qcom,pcie-sa8775p
  ops_1_21_0  # cfg_sc8280xp qcom,pcie-sa8540p qcom,pcie-sc8280xp qcom,pcie-x1e80100
  ops_2_9_0   # cfg_2_9_0 qcom,pcie-ipq5018 qcom,pcie-ipq6018 qcom,pcie-ipq8074-gen3 qcom,pcie-ipq9574

> Cc: stable+noautosel@kernel.org # API dependency
> Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
> Reported-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Changes in v3:
> 
> - Moved the ASPM change to qcom_pcie_host_init()
> - Link to v2: https://lore.kernel.org/r/20250823-qcom_aspm_fix-v2-1-7cef4066663c@oss.qualcomm.com
> 
> Changes in v2:
> 
> * Used the new API introduced in this patch instead of bus notifier:
> https://lore.kernel.org/linux-pci/20250822031159.4005529-1-david.e.box@linux.intel.com/
> 
> * Enabled ASPM on all platforms as there is no specific reason to limit it to a
> few.
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 34 ++--------------------------------
>  1 file changed, 2 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..0c6741b9a9585bd5566b23ba68ef12f1febab56b 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -247,7 +247,6 @@ struct qcom_pcie_ops {
>  	int (*get_resources)(struct qcom_pcie *pcie);
>  	int (*init)(struct qcom_pcie *pcie);
>  	int (*post_init)(struct qcom_pcie *pcie);
> -	void (*host_post_init)(struct qcom_pcie *pcie);
>  	void (*deinit)(struct qcom_pcie *pcie);
>  	void (*ltssm_enable)(struct qcom_pcie *pcie);
>  	int (*config_sid)(struct qcom_pcie *pcie);
> @@ -1040,25 +1039,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> -static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
> -{
> -	/*
> -	 * Downstream devices need to be in D0 state before enabling PCI PM
> -	 * substates.
> -	 */
> -	pci_set_power_state_locked(pdev, PCI_D0);
> -	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> -
> -	return 0;
> -}
> -
> -static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
> -{
> -	struct dw_pcie_rp *pp = &pcie->pci->pp;
> -
> -	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_aspm, NULL);
> -}
> -
>  static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> @@ -1336,6 +1316,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_assert_reset;
>  	}
>  
> +	pci_host_set_default_pcie_link_state(pp->bridge, PCIE_LINK_STATE_ALL);
> +
>  	return 0;
>  
>  err_assert_reset:
> @@ -1358,19 +1340,9 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
>  	pcie->cfg->ops->deinit(pcie);
>  }
>  
> -static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
> -{
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> -
> -	if (pcie->cfg->ops->host_post_init)
> -		pcie->cfg->ops->host_post_init(pcie);
> -}
> -
>  static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
>  	.init		= qcom_pcie_host_init,
>  	.deinit		= qcom_pcie_host_deinit,
> -	.post_init	= qcom_pcie_host_post_init,
>  };
>  
>  /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
> @@ -1432,7 +1404,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
>  	.get_resources = qcom_pcie_get_resources_2_7_0,
>  	.init = qcom_pcie_init_2_7_0,
>  	.post_init = qcom_pcie_post_init_2_7_0,
> -	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  	.config_sid = qcom_pcie_config_sid_1_9_0,
> @@ -1443,7 +1414,6 @@ static const struct qcom_pcie_ops ops_1_21_0 = {
>  	.get_resources = qcom_pcie_get_resources_2_7_0,
>  	.init = qcom_pcie_init_2_7_0,
>  	.post_init = qcom_pcie_post_init_2_7_0,
> -	.host_post_init = qcom_pcie_host_post_init_2_7_0,
>  	.deinit = qcom_pcie_deinit_2_7_0,
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
> 
> ---
> base-commit: 681accdad91923ef4938b96ff3eea62e29af74c3
> change-id: 20250823-qcom_aspm_fix-3264926b5b14
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> 

