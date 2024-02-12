Return-Path: <linux-pci+bounces-3354-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D9F851A1D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 17:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502F01F24182
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCF93D57A;
	Mon, 12 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCSJub/z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B373D3BC;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756819; cv=none; b=O5n3kHed5DvBQ3R+tgTTfBfQqHnpMb20Mx49bZ/r/etcGXgq6MrCgPWRusf4i2A81rXWOqRQKSzqOLTJhgzAlYQzr/mFdfTeuuibNslCnsSehkcm9LVt/vI2uS6Xvwlzuxjd3v5MqMvJFuNumb6NRAlc0FgZ2aceWm7zmoHN34g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756819; c=relaxed/simple;
	bh=Lcwh9oBaUlbIJIUDyERFA6U/A3CwBvNwqmxbv7vqjcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+L353M1/afzvH90AHJEtLaHJ4FXOQcimMfkpcfP7VaF831oda3qAptDlQZEh1xM46Zj6dtQHa27UvEiT7zF4EGR2f933TLMSNf57Ad05wsDZRfH943nJ0qGdkXLOVAS4cYZ9jGmWXVCvBkvgaCXiDOPo+V+YZdu6A3Z6FBSCK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCSJub/z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1ABC433A6;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707756818;
	bh=Lcwh9oBaUlbIJIUDyERFA6U/A3CwBvNwqmxbv7vqjcY=;
	h=From:To:Cc:Subject:Date:From;
	b=rCSJub/zIPFFAM8/y0sjGaoc1aoHaLB4akvR3z1UCkPSmfbdf2Y0mbZrRqVt7u7MT
	 1T1vwvsrtdGPsirrJo/ZcU7lBGb/lK4OsQL9WwMXZpDSIdeWlRUn7i7010+rX2cGoT
	 p34MYWWKmdsqshE9HFLCecZfOWB8B2EKUCmAB7Q3j8Z1etlBPbxnQSG6CP99DPKCOi
	 4KuSz8PQ3Sy6fNnvGKWFLhHg1mJCtcrwNzUru24sQxxteh4CSA0s29ZU1Eyw2qLDAL
	 FICIb1YikFVSXgRubXFjvew+7c2Dq+sXsqlrQfqtGVLGrzaVTJa7Gk9NF74K5eky5h
	 4dQkGd8UKnhLg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rZZZ2-000000007Mx-0uIS;
	Mon, 12 Feb 2024 17:53:52 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
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
Subject: [PATCH 00/10] arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe
Date: Mon, 12 Feb 2024 17:50:33 +0100
Message-ID: <20240212165043.26961-1-johan+linaro@kernel.org>
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
firmware is restarted.

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
been able to test whether L0s causes an trouble there.

Enabling AER error reporting on sc8280xp could similarly also reveal
existing problems with the related sa8295p and sa8540p platforms as they
share the base dtsi.

The last four patches, marked as RFC, adds support for disabling ASPM
L0s in the devicetree and disables it selectively for the X13s Wi-Fi
and CRD NVMe. If it turns out that the Qualcomm PCIe implementation is
incomplete, we may need to disable ASPM (L0s) completely in the driver
instead.

Note that disabling ASPM L0s for the X13s Wi-Fi does not seem to have a
significant impact on the power consumption 

The DT bindings and PCI patch are expected to go through the PCI tree,
while Bjorn A takes the devicetree updates through the Qualcomm tree.

Johan


Johan Hovold (10):
  dt-bindings: PCI: qcom: Allow 'required-opps'
  dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
  arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
  arm64: dts: qcom: sc8280xp-crd: limit pcie4 link speed
  arm64: dts: qcom: sc8280xp-x13s: limit pcie4 link speed
  arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe
  dt-bindings: PCI: qcom: Allow 'aspm-no-l0s'
  PCI: qcom: Add support for disabling ASPM L0s in devicetree
  arm64: dts: qcom: sc8280xp-crd: disable ASPM L0s for NVMe
  arm64: dts: qcom: sc8280xp-x13s: disable ASPM L0s for Wi-Fi

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  6 +++++-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  4 ++++
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  3 +++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 17 +++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 20 +++++++++++++++++++
 5 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.43.0


