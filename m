Return-Path: <linux-pci+bounces-4494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFCE8717D1
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27AB1C2120C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 08:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0F98062D;
	Tue,  5 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6771nRi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF980620;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626486; cv=none; b=oseavRNZC+w9U6xfT73qMvLFuI41GIo9pZZOjiUXWcZvuiTLT5ntw2v+xSumn0M+9jdN80tUzGgqrk+6eiABdYcOBC+W4gXYa9UtjzhO/LUXFQkXZhwWo1ILTytoC+OaPaPdb0KYNnMF7m1SLZZseEq0C9chBm7Vce232rVQcXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626486; c=relaxed/simple;
	bh=bz1gXOES0RIAkOKF6ua3EaiEwnFlMnYADUJVvZk8C9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rsxi5G7wYTeRfwcvS3FmChgYhuzqVvwSAHqEuaIUOCnanGria4FMoCMpQE/IvIzloDIL8KMwIhPC8kS9hOGsyhD7sepbSlGnFOfUMMOq1zxFC+RCmsUY/cWqteDEpQodzd4BZ4V4mWco6NC7kZUp/wVBCAh1B5630UlsVzLOGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6771nRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DAE9C43399;
	Tue,  5 Mar 2024 08:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626485;
	bh=bz1gXOES0RIAkOKF6ua3EaiEwnFlMnYADUJVvZk8C9U=;
	h=From:To:Cc:Subject:Date:From;
	b=J6771nRi2xyn/nMZnbhEGrcDZ+Pfem9XccK0J/zEtO2BSB0UcUJNsuIUD+Axxf7v/
	 npLbvPU1nlKvrpu1hN5spe7umykP8zFKNo4C1mWxbr+OLZtdRaL2gD6+zU7agRvYdd
	 gYu3GwykVpynAB2sxnBk+i0ToHIaqhJSVFutXAjWsQb9+LHLC1L4K1IdmKez5kM49D
	 aWMN1mJ9E61vwmaTJnOXgDvlNa6+3YxU5+f78rBol6DUKrG7YWh8ynjOK7iKrVV+oW
	 ztqHQwZaBHKdCR1NNNV+gPQDyO92wRriuUMygK9p9g1tdt+vuAKCpIUeJ/sf4UrrWu
	 gPnGaGna/CDOQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rhPwo-0000000037n-4AX1;
	Tue, 05 Mar 2024 09:14:51 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 00/10] arm64: dts: qcom: sc8280xp: PCIe fixes and GICv3 ITS enable
Date: Tue,  5 Mar 2024 09:10:55 +0100
Message-ID: <20240305081105.11912-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses a few problems with the sc8280xp PCIe
implementation.

The DWC PCIe controller can either use its internal MSI controller or an
external one such as the GICv3 ITS. Enabling the latter allows for
assigning affinity to individual interrupts, but results in a large
amount of Correctable Errors being logged on both the Lenovo ThinkPad
X13s and the sc8280xp-crd reference design.

It turns out that these errors are always generated, but for some yet to
be determined reason, the AER interrupts are never received when using
the internal MSI controller, which makes the link errors harder to
notice.

On the X13s, there is a large number of errors generated when bringing
up the link on boot. This is related to the fact that UEFI firmware has
already enabled the Wi-Fi PCIe link at Gen2 speed and restarting the
link at Gen3 generates a massive amount of errors until the Wi-Fi
firmware is restarted. This has now also been shown to cause the Wi-Fi
to sometimes not start at all on boot for some users.

A recent commit enabling ASPM on certain Qualcomm platforms introduced
further errors when using the Wi-Fi on the X13s as well as when
accessing the NVMe on the CRD. The exact reason for this has not yet
been identified, but disabling ASPM L0s makes the errors go away. This
could suggest that either the current ASPM implementation is incomplete
or that L0s is not supported with these devices.

Note that the X13s and CRD use the same Wi-Fi controller, but the errors
are only generated on the X13s. The NVMe controller on my X13s does not
support L0s so there are no issues there, unlike on the CRD which uses a
different controller. The modem on the CRD does not generate any errors,
but both the NVMe and modem keeps bouncing in and out of L0s/L1 also
when not used, which could indicate that there are bigger problems with
the ASPM implementation. I don't have a modem on my X13s so I have not
been able to test whether L0s causes any trouble there.

Enabling AER error reporting on sc8280xp could similarly also reveal
existing problems with the related sa8295p and sa8540p platforms as they
share the base dtsi.

After discussing this with Bjorn Andersson at Qualcomm we have decided
to go ahead and disable L0s for all controllers on the CRD and the
X13s.

Note that disabling ASPM L0s for the X13s Wi-Fi does not seem to have a
significant impact on the power consumption (and there are indications
that this applies generally for L0s on these platforms).

***

As we are now at 6.8-rc7, I've rebased this series on the Qualcomm PCIe
binding rework in linux-next so that the whole series can be merged for
6.9 (the 'aspm-no-l0s' support and devicetree fixes are all marked for
stable backport anyway).

The DT bindings and PCI patch are expected to go through the PCI tree,
while Bjorn A takes the devicetree updates through the Qualcomm tree.

Johan


Changes in v3
 - drop the two wifi link speed patches which have been picked up for
   6.8
 - rebase on binding rework in linux-next and add the properties also to
   the new qcom,pcie-common.yaml
   - https://lore.kernel.org/linux-pci/20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org/
 - fix an 'L0s' typo in one commit message

Changes in v2
 - drop RFC from ASPM patches and add stable tags
 - reorder patches and move ITS patch last
 - fix s/GB/MB/ typo in Gen2 speed commit messages
 - fix an incorrect Fixes tag
 - amend commit message X13 wifi link speed patch after user
   confirmation that this fixes the wifi startup issue
 - disable L0s also for modem and wifi on CRD
 - disable L0s also for nvme and modem on X13s


Johan Hovold (10):
  dt-bindings: PCI: qcom: Allow 'required-opps'
  dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
  dt-bindings: PCI: qcom: Allow 'aspm-no-l0s'
  PCI: qcom: Add support for disabling ASPM L0s in devicetree
  arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
  arm64: dts: qcom: sc8280xp-crd: disable ASPM L0s for NVMe
  arm64: dts: qcom: sc8280xp-crd: disable ASPM L0s for modem and Wi-Fi
  arm64: dts: qcom: sc8280xp-x13s: disable ASPM L0s for Wi-Fi
  arm64: dts: qcom: sc8280xp-x13s: disable ASPM L0s for NVMe and modem
  arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe

 .../bindings/pci/qcom,pcie-common.yaml        |  6 +++++-
 .../devicetree/bindings/pci/qcom,pcie.yaml    |  6 +++++-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  5 +++++
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  5 +++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 17 +++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 20 +++++++++++++++++++
 6 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.43.0


