Return-Path: <linux-pci+bounces-36274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3B7B59D41
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 18:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF87C324507
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 16:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35562BEC3D;
	Tue, 16 Sep 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="em9iyQsb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C44283142;
	Tue, 16 Sep 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039190; cv=none; b=VFwnCNMvI3NYhNUMBdgjnxCAMBiDVO2w9IaGG6tzyLJqAbHY+DztyKvRvhVQ6mFNmBqdyT04/Olw7NW0dxPc+kuSAG/s3q0gAfqzvA0woF2qUsEA1zfZW72dxVurBfq0K9yLPE5hxUmtrUjuq3ygUDJGpBXPqwASqENfqXBrtU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039190; c=relaxed/simple;
	bh=L2+ZDh3UGreX3UT53788BxJ/PaPdkpBoEUyyO5eDBek=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p25x/dSyX9gvFWHd1zezfA/A53zuigZVfgWvWtf3Rj0mpUCJIohRfn9Zu/VItdcaDIidOFspP6P0r364tGc80TVsmi2x/fBT0SL2SagUx4lH0/NdEkHapuJMlLkPz1S9pYqsAf4pgxZZi3t0rMbR3pAGpMx140jTTl4ayEE/QpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=em9iyQsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29DDFC4CEF0;
	Tue, 16 Sep 2025 16:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758039190;
	bh=L2+ZDh3UGreX3UT53788BxJ/PaPdkpBoEUyyO5eDBek=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=em9iyQsb3XIEqV3s9LQpZxpUX01BNd3cbIwxrA2If9oozzA8ZzN4U6XFpbnEHLbLf
	 0fStgU3ERKJDBWRFS5/SJP+Kz3Om4QYeANv0zAtp+Plei5wc2JXy7t64CNvcc2MKno
	 UVuqUjFdbIjLDnWo3gXIKlZLriGlsp2C2gZr4NTcgAxeRNbOO6hAvQMOuGE3S7flER
	 gmNm1rV/h6aui47bet8+7LYR4Tk0Xh8b/6WunkQd8AFjIptw4ain4B6aD1NLe3f6ZQ
	 jJaHurm+Lg0JOUW+ddbJ1Wp+H9mfSBepcdkdCALVBEvp9K3toBHH1pPza44lLXoW8b
	 N3eMh7dfq7o9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18919CAC598;
	Tue, 16 Sep 2025 16:13:10 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH 0/2] PCI/ASPM: Enable ASPM and Clock PM by default on
 devicetree platforms
Date: Tue, 16 Sep 2025 21:42:51 +0530
Message-Id: <20250916-pci-dt-aspm-v1-0-778fe907c9ad@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOMyWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0Mz3YLkTN2UEt3E4oJcXYsk40TzVIsUo+Q0QyWgjoKi1LTMCrBp0bG
 1tQAOseteXQAAAA==
X-Change-ID: 20250916-pci-dt-aspm-8b3a7e8d2cf1
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2777;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=L2+ZDh3UGreX3UT53788BxJ/PaPdkpBoEUyyO5eDBek=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoyYyPvSVBLAP3nba8usDeBa0NE5WcMNjGOq/ub
 Mjyq9RkIRWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaMmMjwAKCRBVnxHm/pHO
 9Uv7B/47zt08wW4RzxQU+B4SGa3xwsCAdTj+VZfow21WgNXFQlT3NJ+iKL0WmbJswMJqFO4JWm7
 QD0G9WlwjPaKC72uV/iAhROjUDsDW8BCHF+9y6/KUdyRLGOIe0vbj0P4Hd+Lao2FY1lKo1EhrRk
 QUVvbz63nUDLC6r44EvxHsflVFhDknIS0voUmMyh6SOEdMX4d11tdq4CDxLIoALHXzRPuE6jR/R
 8eYnuhCv26L8VcIRLQ5CdUzs2u+OEI1eLxXouBXCyLdxSbSbjr1Y21oBbRJYhNCWHTqkq3PMObE
 MK1sudLBIUcSxsxStNXlR2tyvDzRMDhJMyjXXFFVkILdMIIc
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
states for PCI devices before the kernel boot. This was done to avoid enabling
ASPM for the buggy devices that are known to create issues with ASPM (even
though they advertise the ASPM capability). But BIOS is not at all a thing on
most of the non-x86 platforms. For instance, the majority of the Embedded and
Compute ARM based platforms using devicetree have something called bootloader,
which is not anyway near the standard BIOS used in x86 based platforms. And
these bootloaders wouldn't touch PCIe at all, unless they boot using PCIe
storage, even then there would be no guarantee that the ASPM states will get
enabled. Another example is the Intel's VMD domain that is not at all configured
by the BIOS. But, this series is not enabling ASPM/Clock PM for VMD domain. I
hope it will be done similarly in the future patches.

Solution
========

So to avoid relying on BIOS, it was agreed [2] that the PCI subsystem has to
enable ASPM and Clock PM states based on the device capability. If any devices
misbehave, then they should be quirked accordingly.

First patch of this series introduces two helper functions to enable all ASPM
and Clock PM states if CONFIG_OF is enabled. Second patch drops the custom ASPM
enablement code from the pcie-qcom driver as it is no longer needed.

Testing
=======

This series is tested on Lenovo Thinkpad T14s based on Snapdragon X1 SoC. All
supported ASPM states are getting enabled for both the NVMe and WLAN devices by
default.

[1] https://lore.kernel.org/linux-pci/a47sg5ahflhvzyzqnfxvpk3dw4clkhqlhznjxzwqpf4nyjx5dk@bcghz5o6zolk
[2] https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelgaas

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (2):
      PCI/ASPM: Override the ASPM and Clock PM states set by BIOS for devicetree platforms
      PCI: qcom: Remove the custom ASPM enablement code

 drivers/pci/controller/dwc/pcie-qcom.c | 32 -----------------------
 drivers/pci/pcie/aspm.c                | 48 ++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 37 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250916-pci-dt-aspm-8b3a7e8d2cf1

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



