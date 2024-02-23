Return-Path: <linux-pci+bounces-3933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1868615A2
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 16:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42CA6B2483A
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7325986151;
	Fri, 23 Feb 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwTHzWzs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6EC83A0D;
	Fri, 23 Feb 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701788; cv=none; b=KrpR8ER9dWc1xcw4ynpZ2+Pzekv6t77dOxm1UfSFxYxO6KALrvi4Ya+Lodn6hhEeV4qQaTdr1Uand3bEq58wg8UTcG1tSTULkIvbVNm53aqm9kNLVWjr+QQrfEB/2VMrSGcxyWhPkHFNt7Oblh4u0CEdtKsluhs/UHPnYPRjkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701788; c=relaxed/simple;
	bh=9shxrV37X/hKYhC7+xafRBxXkbpYRJ8dJYB3wBS8aq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BLOL9n7tF5+le8pZTh8ROqBCKTFXlXowQNGZNIwNz/fxBdIk5uEy+9BPJBi8JObhNuXAaDNKrmdtSw8TLb5Jr6/+ZuZPooX/4ZMTk8+/sU2v+DndfIzVAfwYWtUzjod83UyUShpJ5SOuGxXq3AGoXaiNRhzXHxnY3iQWesc0f5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwTHzWzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0DFC433B2;
	Fri, 23 Feb 2024 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701786;
	bh=9shxrV37X/hKYhC7+xafRBxXkbpYRJ8dJYB3wBS8aq0=;
	h=From:To:Cc:Subject:Date:From;
	b=BwTHzWzsu/Zd0FkgYEt+VHXbuKOy5OgClB6+XaV77LhCiG9PBCZEJSKEHkrmIK+Wf
	 BYa+b8S/A4inKzgNzR6f8Q58lkxDXjPL60D1qxqVFHC8raTHfuiPBwzhIIWw6RJzl1
	 Vc3DrZWsRQseLG/eRus7+GfMAQbdeHRR9gHwhxx2V1euwi0wrVDRwp1ZzRDepbvcj3
	 84k8dfFLc/xbsPA9emz04nCyG/95jqxWDRj5LHy2yfqXhwWJIavpBhIlWJj9ewSvlq
	 wgvtR3xw0ssPqYPpQZWnnez0cCIwStZ/r8bZZQ1eJlDu7ngNu6XiBpQxf+ZEM9bw+1
	 IXsRPM0H507SA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rdXOI-000000005FT-0JA2;
	Fri, 23 Feb 2024 16:23:10 +0100
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
Subject: [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and GICv3 ITS enable
Date: Fri, 23 Feb 2024 16:21:12 +0100
Message-ID: <20240223152124.20042-1-johan+linaro@kernel.org>
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

As this series fixes a regression in 6.7 (which enabled ASPM) and fixes
a user-reported problem with the Wi-Fi often not starting at boot, I
think we should merge this series for the 6.8 cycle. The final patch
enabling the GIC ITS should wait for 6.9.

The DT bindings and PCI patch are expected to go through the PCI tree,
while Bjorn A takes the devicetree updates through the Qualcomm tree.

Note that the devicetree binding updates will conflict with the
following series which was just merged for 6.9 today:

	https://lore.kernel.org/lkml/513dfb69-aea1-4848-8755-613e03c65843@linaro.org/

The resolution is simply to add 'required-opps' and 'aspm-no-l0s' to the
new 'qcom,pcie-common.yaml' schema file instead of 'qcom,pcie.yaml',
while removing 'msi-map-mask'.

***

Johan


Changes in v2
 - drop RFC from ASPM patches and add stable tags
 - reorder patches and move ITS patch last
 - fix s/GB/MB/ typo in Gen2 speed commit messages
 - fix an incorrect Fixes tag
 - amend commit message X13 wifi link speed patch after user
   confirmation that this fixes the wifi startup issue
 - disable L0s also for modem and wifi on CRD
 - disable L0s also for nvme and modem on X13s


Johan Hovold (12):
  dt-bindings: PCI: qcom: Allow 'required-opps'
  dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
  dt-bindings: PCI: qcom: Allow 'aspm-no-l0s'
  PCI: qcom: Add support for disabling ASPM L0s in devicetree
  arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
  arm64: dts: qcom: sc8280xp-crd: limit pcie4 link speed
  arm64: dts: qcom: sc8280xp-x13s: limit pcie4 link speed
  arm64: dts: qcom: sc8280xp-crd: disable ASPM L0s for NVMe
  arm64: dts: qcom: sc8280xp-crd: disable ASPM L0s for modem and Wi-Fi
  arm64: dts: qcom: sc8280xp-x13s: disable ASPM L0s for Wi-Fi
  arm64: dts: qcom: sc8280xp-x13s: disable ASPM L0s for NVMe and modem
  arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe

 .../devicetree/bindings/pci/qcom,pcie.yaml    |  6 +++++-
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  7 +++++++
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  7 +++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 17 +++++++++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 20 +++++++++++++++++++
 5 files changed, 55 insertions(+), 2 deletions(-)

-- 
2.43.0


