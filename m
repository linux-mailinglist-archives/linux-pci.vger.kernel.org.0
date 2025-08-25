Return-Path: <linux-pci+bounces-34634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C711B338B1
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 10:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178AC202664
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 08:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354BF29B8C6;
	Mon, 25 Aug 2025 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0VJKRv5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07862299928;
	Mon, 25 Aug 2025 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110299; cv=none; b=Qvmb0mIzVGYxbi3+ueb8n1iXv0QPphHxMMZZwaMgW1zSqr51C8qXasUzb9QJU+MYUKzdD6vVMeLlZPVc0nIqBwqseZFX2U41wPLUdCfUXoHqMIoiZUIt7iU2R5AyXHSmXRVyuION1Be9pEk+B/NujxxgmFAyxZZd6bJAbszzX7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110299; c=relaxed/simple;
	bh=nHpQS/11IFzIvGGv5DJGaQWsuEb8DTT68eQqsqfwU9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGrCG49janRUubTceKhDKxiRMgmQZrK6BW84COGXy0SxvEvvvRPqm6oW/DBpQ1dJC+/gd7N+o6hdTwO5fAlfS8C7HFJhlLBzJVGhJ0jiH5z8O0jEsuMlQor1KmUY8jOiIgscoBR8+//UcRoWnHDpbuGirAhRg6UaKLBIS9Ge8tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0VJKRv5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EC6C4CEED;
	Mon, 25 Aug 2025 08:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756110298;
	bh=nHpQS/11IFzIvGGv5DJGaQWsuEb8DTT68eQqsqfwU9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0VJKRv51EgX9G1PLwl+Riu3PYsALnc6oK9BMDGclYFx2zC4U5QxfenZjbz7/T3c2
	 rKgUgPnlnHss7cM4AVriepcd9HioKd5dU5RwWS/AWYuRbAcYDPe53HORJKaFyFonZK
	 tLPvA/f5jt90WZ/+Iql1o8yxRISbENlKX8hWQaGKN4p/kb9WSzEfWoFgkYaKvmYF4o
	 myDnfT+s81HhlOuFGwORjkvjI7yHizUJWD7nteGxNBdWS6bDa7SLLUW8gncEHVXAhF
	 bkb3faCq4+0c00M+9RkIlSLeAOHtdT5A+W28JyqhDypzoHY0asOdSYQuWDmqiahh8v
	 xDFvU9jxZZPKQ==
Date: Mon, 25 Aug 2025 13:54:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"David E. Box" <david.e.box@linux.intel.com>, Johan Hovold <johan@kernel.org>, stable+noautosel@kernel.org
Subject: Re: [PATCH v2] PCI: qcom: Use pci_host_set_default_pcie_link_state()
 API to enable ASPM for all platforms
Message-ID: <4vw4fmucrwejqogvagpujfedis7e6ivldk7iymlalnfcleelo6@wr7ylee46ee4>
References: <20250823-qcom_aspm_fix-v2-1-7cef4066663c@oss.qualcomm.com>
 <7deae6e0-44ad-4b2c-9657-e83ffc77b4f7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7deae6e0-44ad-4b2c-9657-e83ffc77b4f7@oss.qualcomm.com>

On Mon, Aug 25, 2025 at 09:56:41AM GMT, Krishna Chaitanya Chundru wrote:
> 
> 
> On 8/23/2025 11:14 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
> > ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
> > enumerated at the time of the controller driver probe. It proved to be
> > useful for devices already powered on by the bootloader, as it allowed
> > devices to enter ASPM without user intervention.
> > 
> > However, it could not enable ASPM for the hotplug capable devices i.e.,
> > devices enumerated *after* the controller driver probe. This limitation
> > mostly went unnoticed as the Qcom PCI controllers are not hotplug capable
> > and also the bootloader has been enabling the PCI devices before Linux
> > Kernel boots (mostly on the Qcom compute platforms which users use on a
> > daily basis).
> > 
> > But with the advent of the commit b458ff7e8176 ("PCI/pwrctl: Ensure that
> > pwrctl drivers are probed before PCI client drivers"), the pwrctrl driver
> > started to block the PCI device enumeration until it had been probed.
> > Though, the intention of the commit was to avoid race between the pwrctrl
> > driver and PCI client driver, it also meant that the pwrctrl controlled PCI
> > devices may get probed after the controller driver and will no longer have
> > ASPM enabled. So users started noticing high runtime power consumption with
> > WLAN chipsets on Qcom compute platforms like Thinkpad X13s, and Thinkpad
> > T14s, etc...
> > 
> > Obviously, it is the pwrctrl change that caused regression, but it
> > ultimately uncovered a flaw in the ASPM enablement logic of the controller
> > driver. So to address the actual issue, use the newly introduced
> > pci_host_set_default_pcie_link_state() API, which allows the controller
> > drivers to set the default ASPM state for *all* devices. This default state
> > will be honored by the ASPM driver while enabling ASPM for all the devices.
> > 
> > So with this change, we can get rid of the controller driver specific
> > 'qcom_pcie_ops::host_post_init' callback.
> > 
> > Also with this change, ASPM is now enabled by default on all Qcom
> > platforms as I haven't heard of any reported issues (apart from the
> > unsupported L0s on some platorms, which is still handled separately).
> > 
> > Cc: stable+noautosel@kernel.org # API dependency
> > Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
> > Reported-by: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > 
> > * Used the new API introduced in this patch instead of bus notifier:
> > https://lore.kernel.org/linux-pci/20250822031159.4005529-1-david.e.box@linux.intel.com/
> > 
> > * Enabled ASPM on all platforms as there is no specific reason to limit it to a
> > few.
> > ---
> >   drivers/pci/controller/dwc/pcie-qcom.c | 34 ++--------------------------------
> >   1 file changed, 2 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..71f14bc3a06ade1da1374e88b0ebef8c4e266064 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -247,7 +247,6 @@ struct qcom_pcie_ops {
> >   	int (*get_resources)(struct qcom_pcie *pcie);
> >   	int (*init)(struct qcom_pcie *pcie);
> >   	int (*post_init)(struct qcom_pcie *pcie);
> > -	void (*host_post_init)(struct qcom_pcie *pcie);
> >   	void (*deinit)(struct qcom_pcie *pcie);
> >   	void (*ltssm_enable)(struct qcom_pcie *pcie);
> >   	int (*config_sid)(struct qcom_pcie *pcie);
> > @@ -1040,25 +1039,6 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
> >   	return 0;
> >   }
> > -static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
> > -{
> > -	/*
> > -	 * Downstream devices need to be in D0 state before enabling PCI PM
> > -	 * substates.
> > -	 */
> > -	pci_set_power_state_locked(pdev, PCI_D0);
> > -	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> > -
> > -	return 0;
> > -}
> > -
> > -static void qcom_pcie_host_post_init_2_7_0(struct qcom_pcie *pcie)
> > -{
> > -	struct dw_pcie_rp *pp = &pcie->pci->pp;
> > -
> > -	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_aspm, NULL);
> > -}
> > -
> >   static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
> >   {
> >   	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
> > @@ -1358,19 +1338,9 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
> >   	pcie->cfg->ops->deinit(pcie);
> >   }
> > -static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
> > -{
> > -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > -	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > -
> > -	if (pcie->cfg->ops->host_post_init)
> > -		pcie->cfg->ops->host_post_init(pcie);
> > -}
> > -
> >   static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
> >   	.init		= qcom_pcie_host_init,
> >   	.deinit		= qcom_pcie_host_deinit,
> > -	.post_init	= qcom_pcie_host_post_init,
> >   };
> >   /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
> > @@ -1432,7 +1402,6 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
> >   	.get_resources = qcom_pcie_get_resources_2_7_0,
> >   	.init = qcom_pcie_init_2_7_0,
> >   	.post_init = qcom_pcie_post_init_2_7_0,
> > -	.host_post_init = qcom_pcie_host_post_init_2_7_0,
> >   	.deinit = qcom_pcie_deinit_2_7_0,
> >   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> >   	.config_sid = qcom_pcie_config_sid_1_9_0,
> > @@ -1443,7 +1412,6 @@ static const struct qcom_pcie_ops ops_1_21_0 = {
> >   	.get_resources = qcom_pcie_get_resources_2_7_0,
> >   	.init = qcom_pcie_init_2_7_0,
> >   	.post_init = qcom_pcie_post_init_2_7_0,
> > -	.host_post_init = qcom_pcie_host_post_init_2_7_0,
> >   	.deinit = qcom_pcie_deinit_2_7_0,
> >   	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> >   };
> > @@ -1979,6 +1947,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >   	if (pcie->mhi)
> >   		qcom_pcie_init_debugfs(pcie);
> > +	pci_host_set_default_pcie_link_state(pp->bridge, PCIE_LINK_STATE_ALL);
> > +
> It is better to call this before starting link training,

Not after link training, but before enumeration... But you are right to spot the
issue.

> if the endpoint
> is already powered on by the time execution comes here link enumeration
> and ASPM init might be already done. This might not have any impact.
> 

I've sent v3 after moving this call to qcom_pcie_host_init() which gets called
before attempting the enumeration.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

