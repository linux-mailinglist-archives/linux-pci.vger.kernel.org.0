Return-Path: <linux-pci+bounces-18462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899DC9F2513
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 18:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88ADA165C7D
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 17:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0034C19048D;
	Sun, 15 Dec 2024 17:32:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814F21EB48;
	Sun, 15 Dec 2024 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734283926; cv=none; b=ehn4dtf7Krq/rR8CgtmFhOWuCWAVYfxNNCIIHmihNT6DTE3AMbJQXASESo2uPyZA5BJXzg2i+Vy068eRQW3j+UPMN3wXZ2LR4krVgOeDbQxeCHOHyqYG1JBy1TfbX4cZzSAa0zj4tWS45TO9jDZOelUgdUvjMY+RohiFCnTdqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734283926; c=relaxed/simple;
	bh=3nScF0VsYpNmrjY7vUKpNDzRjSzzr6uKxKptSD4MOhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnc5qh6XlOLrn8lOg0YjaozIWv8I0PX03Xi1khFAqeXMtGJRfK2SNrSqTRBrAL252XbvYX9C8sP7MHRVbAbNSrdlmGPiqTKbTrFm52bIsaAWPJJngT0tMslTQr233QuWNpwMdPJ6MMHKxNJfXzjQtXt/DaylMf/+qFjBQkOuX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id CA3AA100D9403;
	Sun, 15 Dec 2024 18:32:02 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A2134335398; Sun, 15 Dec 2024 18:32:02 +0100 (CET)
Date: Sun, 15 Dec 2024 18:32:02 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH 0/4] PCI/pwrctrl: Rework pwrctrl driver integration and
 add driver for PCI slot
Message-ID: <Z18SkkuPbVgTYD8k@wunner.de>
References: <20241210-pci-pwrctrl-slot-v1-0-eae45e488040@linaro.org>
 <c5c9b7fc-a484-438a-aa97-35785f25d576@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c9b7fc-a484-438a-aa97-35785f25d576@quicinc.com>

On Wed, Dec 11, 2024 at 05:55:48PM +0800, Qiang Yu wrote:
> PCIe3 is able to link up after applying your patch. Slot power is turned on
> correctly.
> But see "NULL pointer dereference" when I try to remove device.

There's a WARN splat occurring before the NULL pointer deref.
Was this happening before or is it new?  Probably makes sense
to debug that first before looking into the NULL pointer deref,
which could be a result of it.


> [   38.757726] WARNING: CPU: 1 PID: 816 at drivers/regulator/core.c:5857
> regulator_unregister+0x13c/0x160
> [   38.767288] Modules linked in: phy_qcom_qmp_combo aux_bridge
> drm_kms_helper drm nvme backlight pinctrl_sm8550_lpass_lpi pci_pwrctl_slot
> pci_pwrctrl_core nvme_core phy_qcom_edp phy_qcom_eusb2_repeater
> dispcc_x1e80100 pinctrl_lpass_lpi phy_qcom_snps_eusb2 lpasscc_sc8280xp typec
> gpucc_x1e80100 phy_qcom_qmp_pcie
> [   38.795279] CPU: 1 UID: 0 PID: 816 Comm: bash Not tainted
> 6.12.0-next-20241128-00005-g6178bf6ce3c2-dirty #50
> [   38.805359] Hardware name: Qualcomm IDP, BIOS
> 6.0.240607.BOOT.MXF.2.4-00348.1-HAMOA-1.67705.7 06/ 7/2024
> [   38.815088] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS
> BTYPE=--)
> [   38.822239] pc : regulator_unregister+0x13c/0x160
> [   38.827081] lr : regulator_unregister+0xc0/0x160

The WARN splat seems to be caused by:

	WARN_ON(rdev->open_count);

So the regulator is unregistered although it's still in use.
Is there maybe a multifunction PCIe device in your system
so that multiple devices are using the same regulator?

Thanks,

Lukas

