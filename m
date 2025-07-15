Return-Path: <linux-pci+bounces-32123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBD2B0539B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 09:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54661AA7AED
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 07:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FC4271456;
	Tue, 15 Jul 2025 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IujMx2tD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A981FCFE7;
	Tue, 15 Jul 2025 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565715; cv=none; b=D2wXCeonL2VqU6CVc/W5zlr73DxqhomlRWBm8yDlLpxjJiItThzJhghDVZtBEPi18N0mcUtmh2yJAHCR9/PwbWKsLp2bv/xT5UEzvw3VzPicTNHpxzSNIriJ+T0DTcow0ngKTZhkUBqrrgIoB/KlBcAlFredhzLrt9Zu9uTORuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565715; c=relaxed/simple;
	bh=8IZw6C/De6dakx9xAilap331+SFJiu/Fzpfs3jm/iXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0PJNMnsmxWu19s0fzQoVdK+m/6hAUOcQX0KU51ihaf+dP00AiygcuOSVXKGACezRGOb8mwI7oSGECQ5fbgcXHjB46SBtecIWa2hd1b1Z7LpNkaZhg+Y27Wuw4uQvizKeBnW9EnAda1TW5Lw+HeSBYxRwSGaVeGrigOQgyEVLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IujMx2tD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C81C4CEE3;
	Tue, 15 Jul 2025 07:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752565714;
	bh=8IZw6C/De6dakx9xAilap331+SFJiu/Fzpfs3jm/iXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IujMx2tDnehjf8dlyyA/zZSt93i5CX1ytyp423HSEsFXh4Tb0rlLDC7Jc0laL6ogO
	 JzhUhMZ+JwPHW4GJXEWIXJiry9mCLGTxOYoehzqCbE9vreeNl2pa2Ue3HGK8erKKxU
	 FsJpuebZZUVApC34IMrcfaYKcDKUWnDxxW/zZeRDtXUJoorm0V2xL4V9S3uf2+aCF4
	 +fM3+uhkIUCRH5omjEykO9NbwZ59QpsqL3qgGNNRQJtUK7cooXT2ZJcTltEacoIdRU
	 JbRWTGksPpuTaEugbGcyIfBO2j7P5QsDL/2trmkwDuy6HKsNBvbeHay2Q3e6IKhLvI
	 HA6GTogyaqJEg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ubaOs-000000002aI-09Td;
	Tue, 15 Jul 2025 09:48:30 +0200
Date: Tue, 15 Jul 2025 09:48:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: qcom: Switch to bus notifier for enabling ASPM
 of PCI devices
Message-ID: <aHYHzrl0DE2HV86S@hovoldconsulting.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-1-7d04b8c140c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-aspm_fix-v1-1-7d04b8c140c8@oss.qualcomm.com>

On Mon, Jul 14, 2025 at 11:31:04PM +0530, Manivannan Sadhasivam wrote:
> Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
> ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
> enumerated at the time of the controller driver probe. It proved to be
> useful for devices already powered on by the bootloader as it allowed
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
> driver. So to address the actual issue, switch to the bus notifier for
> enabling ASPM of the PCI devices. The notifier will notify the controller
> driver when a PCI device is attached to the bus, thereby allowing it to
> enable ASPM more reliably. It should be noted that the
> 'pci_dev::link_state', which is required for enabling ASPM by the
> pci_enable_link_state_locked() API, is only set by the time of
> BUS_NOTIFY_BIND_DRIVER stage of the notification. So we cannot enable ASPM
> during BUS_NOTIFY_ADD_DEVICE stage.

A problem with this approach is that ASPM will never be enabled (and
power consumption will be higher) in case an endpoint driver is missing.

I think that's something we should try to avoid.

> So with this, we can also get rid of the controller driver specific
> 'qcom_pcie_ops::host_post_init' callback.
> 
> Cc: stable@vger.kernel.org # v6.7
> Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
> Reported-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Note that the patch fails to apply to 6.16-rc6 due to changes in
linux-next. Depending on how fast we can come up with a fix it may be
better to target 6.16.

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

I think you should consider leaving this helper in place here to keep
the size of the diff down (e.g. as you intend to backport this).

> +static int qcom_pcie_enable_aspm(struct pci_dev *pdev)
> +{
> +	/*
> +	 * Downstream devices need to be in D0 state before enabling PCI PM
> +	 * substates.
> +	 */
> +	pci_set_power_state_locked(pdev, PCI_D0);
> +	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);

You need to use the non-locked helpers here since you no longer hold the
bus semaphore (e.g. as reported by lockdep).

Maybe this makes the previous comment about not moving the helper moot.

> +
> +	return 0;
> +}
> +
> +static int pcie_qcom_notify(struct notifier_block *nb, unsigned long action,
> +			      void *data)
> +{
> +	struct qcom_pcie *pcie = container_of(nb, struct qcom_pcie, nb);

This results in an unused variable warning (presumably until the next
patch in the series is applied).

> +	struct device *dev = data;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	switch (action) {
> +	case BUS_NOTIFY_BIND_DRIVER:
> +		qcom_pcie_enable_aspm(pdev);
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}

Missing newline.

>  static int qcom_pcie_probe(struct platform_device *pdev)
>  {
>  	const struct qcom_pcie_cfg *pcie_cfg;

Johan

