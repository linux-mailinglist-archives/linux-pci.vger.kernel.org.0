Return-Path: <linux-pci+bounces-36700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C004B922AF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 18:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 980274E26E1
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 16:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14D830CB26;
	Mon, 22 Sep 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7i2Gev0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A623112A0;
	Mon, 22 Sep 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557814; cv=none; b=KFVkEuWUU0PSK9fUgYAnJpyce1L73ZWtbu+WLStd62QKnNU33ta1jehUIP6dSpFymTn89KtQLs9ZMMGryou719qjMIMzcK9ul84vZxFDdXy+3jCTv2V+i7mkRE8eYYNjaRFcrpvtquYL3P87ahBRs0HC87fiBhmFD3AEQ07tFJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557814; c=relaxed/simple;
	bh=VrVbBbAkZX7N6X1ZFNXfWGktbwkiMT+UGCeuD3oUrho=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lp32ebrrYPJGo2zcl535LEKkStKLLXOu1ntAtEyF+GLRxXvwRjxKHo/Q5Vw6hWEcWZVdgRpNV7f8UvhX2tyS1URzQVGpzyAJS1NPYecr0lCF6CdhD7uJZd8I02Zr9ICqONY0xI340ufFBlD4TJjxnQc8SdlHodZpepWyHkZeQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7i2Gev0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C56FC4CEF0;
	Mon, 22 Sep 2025 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758557814;
	bh=VrVbBbAkZX7N6X1ZFNXfWGktbwkiMT+UGCeuD3oUrho=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=P7i2Gev0VGA8NR+yumibcm0pfP6+ow6+3LtqZVorClFlTSK9PzXgHN4DYBL7Jdq/z
	 /2Vg0HbIH2h5MJbCAnuU9q4QG0vVUCYzdqip63OV5doerOe+sj1Pd5GAcGr6lnmSml
	 gXT5/Q0ZhHWp76O581v3CKvPg+KRHWfkc36KFX7HMFYSG4piK8FL/S5V6nEfFZtVhV
	 1HfDxpslQCvAn1Uha5ya7kTXIXfwVdcA9s4hhZ1AQC0qIgjD4AngXn6lNvTjua2Gau
	 qcBVj5gBqQJ1tFjCT+Wnd/Mfd1lPDHmthWi8lqRhYu+HJLDowTJ5bLvS9FzCBaXAho
	 ZwT4TlQcofuug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9F5CAC5AA;
	Mon, 22 Sep 2025 16:16:54 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v2 0/2] PCI/ASPM: Enable ASPM and Clock PM by default on
 devicetree platforms
Date: Mon, 22 Sep 2025 21:46:43 +0530
Message-Id: <20250922-pci-dt-aspm-v2-0-2a65cf84e326@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGt20WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Mz3YLkTN2UEt3E4oJcXYsk40TzVIsUo+Q0QyWgjoKi1LTMCrBp0bG
 1tQDLM5X6XQAAAA==
X-Change-ID: 20250916-pci-dt-aspm-8b3a7e8d2cf1
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
 Kai-Heng Feng <kai.heng.feng@canonical.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Chia-Lin Kao <acelan.kao@canonical.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=VrVbBbAkZX7N6X1ZFNXfWGktbwkiMT+UGCeuD3oUrho=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBo0XZu+sVRoNvesArpOMqAyXXGDhGGtiBu/MQrC
 MvA5UcMprqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaNF2bgAKCRBVnxHm/pHO
 9VDDB/sGzXZBIjGWh/XLdq/tQ505y4S/Iy0tr4X9enEgJMfKDwizHblZ0/OjDhcDJ4qttRLcAQQ
 edMyfOVWIT/+4phq0V9wGr2AcK7doEsmeey6eUZ1qtgXMfneNJQs/rIwrChVwQnisPvk4RznPik
 7h6HM8osZeYqGg63mDgjTEubQQtSriUer9Wljb8c0gM97uzk0EFwi9JB43AboMx7VstKUgf2Gkr
 yT0NVk2UQ/oaZDf6XVaG/u9OJ1jaJqwLaifSVDFF+DXnv4Mh2o8BCpXMbhVhCkPRpRolgyJjXDe
 9VZlILCw1RGL+zqjcHJTBOaEyOiBX4dYTJawC/ElVg+MXX4a
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series is one of the 'let's bite the bullet' kind, where we have decided to
enable all ASPM and Clock PM states by default on devicetree platforms [1]. The
reason why devicetree platforms were chosen because, it will be of minimal
impact compared to the ACPI platforms. So seemed ideal to test the waters.

Problem Statement
=================

Historically, PCI subsystem relied on the BIOS to enable ASPM and Clock PM
states for PCI devices before the kernel boot if the default states are
selected using:

* Kconfig: CONFIG_PCIEASPM_DEFAULT=y, or
* cmdline: "pcie_aspm=off", or
* FADT: ACPI_FADT_NO_ASPM

This was done to avoid enabling ASPM for the buggy devices that are known to
create issues with ASPM (even though they advertise the ASPM capability). But
BIOS is not at all a thing on most of the non-x86 platforms. For instance, the
majority of the Embedded and Compute ARM based platforms using devicetree have
something called bootloader, which is not anyway near the standard BIOS used in
x86 based platforms. And these bootloaders wouldn't touch PCIe at all, unless
they boot using PCIe storage, even then there would be no guarantee that the
ASPM states will get enabled. Another example is the Intel's VMD domain that is
not at all configured by the BIOS. But, this series is not enabling ASPM/Clock
PM for VMD domain. I hope it will be done similarly in the future patches.

Solution
========

So to avoid relying on BIOS, it was agreed [2] that the PCI subsystem has to
enable ASPM and Clock PM states based on the device capability. If any devices
misbehave, then they should be quirked accordingly.

First patch of this series introduces two helper functions to enable all ASPM
and Clock PM states if of_have_populated_dt() is true. Second patch drops the
custom ASPM enablement code from the pcie-qcom driver as it is no longer needed.

Testing
=======

This series is tested on Lenovo Thinkpad T14s based on Snapdragon X1 SoC. All
supported ASPM states are getting enabled for both the NVMe and WLAN devices by
default.

[1] https://lore.kernel.org/linux-pci/a47sg5ahflhvzyzqnfxvpk3dw4clkhqlhznjxzwqpf4nyjx5dk@bcghz5o6zolk
[2] https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelgaas

Changes in v2:

- Used of_have_populated_dt() instead of CONFIG_OF to identify devicetree
  platforms
- Renamed the override helpers and changed the override print
- Moved setting the default state back to the original place and only kept the
  override in helpers

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (2):
      PCI/ASPM: Override the ASPM and Clock PM states set by BIOS for devicetree platforms
      PCI: qcom: Remove the custom ASPM enablement code

 drivers/pci/controller/dwc/pcie-qcom.c | 32 --------------------------
 drivers/pci/pcie/aspm.c                | 42 ++++++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 34 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250916-pci-dt-aspm-8b3a7e8d2cf1

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



