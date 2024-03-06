Return-Path: <linux-pci+bounces-4560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B37DB87335A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 11:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7001128B67E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E0A5FB86;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEWVWWBz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5F5F482;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719189; cv=none; b=MNtL2RIeX1JRyHAGfbqmoo68rK7VJrLJs4RiM3ZHsU2tmYOUFKfc8TaiK8olycT0fleaaH9vfN18uSCIjOhCL4bq07cUzTckoOJl/wIhMg9XEvUMEcp2Mqbux2KiUjy5sI57I7eyO4sgs8+9tw+6KEqpzbHcVYJVl6S0y97renA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719189; c=relaxed/simple;
	bh=CkVlOtbBCGKlct96p/xjRge+byzee+ClIJzlL6rvceM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/dl8Ej5p81nU5QeOuMFSmX76F2ue3Am8fuyJE9wwqPtoH+NTeQfO+/svAAwPw9RfenN6H/qkBESGmGlfkiBZZwCK+QSY51UluUZGuWeqfv8iEMUc7UKJRRUmBkbfFb/Y+0dzakZcBgSNB/RWMP4KHH+73oVl1A4v4XUep/ua8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEWVWWBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F88C43394;
	Wed,  6 Mar 2024 09:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709719189;
	bh=CkVlOtbBCGKlct96p/xjRge+byzee+ClIJzlL6rvceM=;
	h=From:To:Cc:Subject:Date:From;
	b=gEWVWWBz453XeUJDcMKoHaXBNOECoIQnxxtJ0oIGQiSXYyZi9xWUDIJfEAUVCIGQ4
	 /8DvSDQKMwWp1T3ov6cNApRVfPxVS68RfpY967lYss8V+I06WVEc05rlv6yxO4NmtA
	 QEp+MNUZ2NF0eyxF9fa9KJSPMe14ZgnkDU5xYyQLPp7SPT9eFnmBq4DUz4eWqSPz5D
	 qNGYl6MxmmnOwn6YjQlQDgnG5GUmYjxkqMLYfyp7LFL1jVrdsWmx2JWEM97HcnEYP4
	 g71NPPgrCT8NQUN9MdkL+6TLpvrmtYacKrbpLzhVL2nI2arXym3LdDp2UkZx4Cg5kH
	 lCkSTq0u/ahmA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rho44-000000001ax-21Ue;
	Wed, 06 Mar 2024 10:59:56 +0100
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
Subject: [PATCH v4 0/5] arm64: dts: qcom: sc8280xp: PCIe fixes and GICv3 ITS enable
Date: Wed,  6 Mar 2024 10:56:46 +0100
Message-ID: <20240306095651.4551-1-johan+linaro@kernel.org>
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

Note that disabling ASPM L0s for the X13s Wi-Fi does not seem to have a
significant impact on the power consumption (and there are indications
that this applies generally for L0s on these platforms).

***

Qualcomm has now confirmed that this is an issue on sc8280xp and its
derivate platforms. Specifically, the PHY configuration used on these
platforms is not correctly tuned for L0s and there is currently no
updated configuration available.

As we are now at 6.8-rc7, I've rebased this series on the Qualcomm PCIe
binding rework in linux-next so that the whole series can be merged for
6.9 (the patch to disable l0s and the devicetree fix are both marked for
stable backport anyway).

The DT bindings and PCI patch are expected to go through the PCI tree,
while Bjorn A takes the devicetree updates through the Qualcomm tree.

Johan


Changes in v4
 - drop the 'aspm-no-l0s' DT property and disable L0s for all sc8280xp
   derivative platforms based on the compatible string for now

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


Johan Hovold (5):
  dt-bindings: PCI: qcom: Allow 'required-opps'
  dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
  PCI: qcom: Disable ASPM L0s for sc8280xp, sa8540p and sa8295p
  arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
  arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe

 .../bindings/pci/qcom,pcie-common.yaml        |  4 ++-
 .../devicetree/bindings/pci/qcom,pcie.yaml    |  4 ++-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 17 +++++++++-
 drivers/pci/controller/dwc/pcie-qcom.c        | 31 +++++++++++++++++--
 4 files changed, 51 insertions(+), 5 deletions(-)

-- 
2.43.0


