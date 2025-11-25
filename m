Return-Path: <linux-pci+bounces-42025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F909C84A76
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 12:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CCC3AA77C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 11:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9E3314B86;
	Tue, 25 Nov 2025 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Om/MXhBE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF423101C9;
	Tue, 25 Nov 2025 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069153; cv=none; b=u+ZVlpiMBoJFAbGdi9ACV+ziWoySU8OWFnuuOOZg7kv5nbT1xfMWHFN6w1aqC75H2D94XnC1/nJughykVsVMIgM2hcVl8niKwYQdXd1NrYgb5dr9e9KsvSYDONoldVC83UGeKSjln14TR60N2CFa80TMYhAwVJEQTcUMELHg9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069153; c=relaxed/simple;
	bh=4W5N3HFT9XqK9ao5zUtwS6grnw6Chec77zAq2yGW/nQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K9uu75j5VlaSjT68X+eEpSych4vl5hvcHggDtxAEeIm2LAR0oR/To3wq5f2+r43Jp1Ez6wXNWAxWLXZszisJzZpRcls/qV3NrltSlEI/jqLPIU0rTd/qha7GF3YVKf9+wqOIkYhMLa8ZPEDKte3i3jzkGiQQywcV0necYrVRr2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Om/MXhBE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86319C4CEF1;
	Tue, 25 Nov 2025 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764069152;
	bh=4W5N3HFT9XqK9ao5zUtwS6grnw6Chec77zAq2yGW/nQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Om/MXhBEbDdzbE4dTjNnsYIax+1nxg+rxybxE/PLRzbmODm9uq4pupnr03IpRwkzC
	 W+0kyxCdfbf+nKh1gpmd+kQsCv37mug/AL1b+Eld4fDVPRXl1WJqECyn5UC9nB6uwC
	 XSuiH9auHE5zDziScucBxmS3ORJs0OwTMK6+emaB3T6ZqwMj413Luec5BkVcQjNL+v
	 uevVF0YntTyRxoktHJ6Rek+luQhmYW+QrfYtyOD2ItkP5dr8AmBudR7CBW88sveQDq
	 YGmVwG00issU2Tbs213ajLB2Y2DNn+lSB1epsShVKH/8dzD53/vqXn+gDT1iqAqJuD
	 N2qmR6KID3Wkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71145CFD368;
	Tue, 25 Nov 2025 11:12:32 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Subject: [PATCH v3 0/4] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Date: Tue, 25 Nov 2025 16:42:25 +0530
Message-Id: <20251125-pci-m2-v3-0-c528042aea47@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABmPJWkC/22MQQ6CMBBFr0JmbQltKTSuvIdx0ZapNBGKrTYaw
 t0tJBgXbiZ5k//eDBGDwwjHYoaAyUXnxwz8UIDp1XhF4rrMwComKK04mYwjAyNtw3nDqW6sUpD
 HU0DrXlvofMncu/jw4b11E12/e0LsiURJRWSthaWWokB58jGW96e6GT8MZT6wlhL7teXXZtlGq
 U3dtdrWrPtjL8vyAQcd/ifhAAAA
X-Change-ID: 20251103-pci-m2-7633631b6faa
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3890;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=4W5N3HFT9XqK9ao5zUtwS6grnw6Chec77zAq2yGW/nQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpJY8dErVC8h8htWvNiDSqBzHfQ3sLVCilBhBXK
 hUvQA1ST2uJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaSWPHQAKCRBVnxHm/pHO
 9bb6CACMnk1JcvfM0PgRT7maZnabMUcVjF/crON1hr1C+sNZx9zlvXNhu1vTVkN8hY/Sw3ujP2a
 KmoZaypYTZEAM3+n/w3yO0eZlgCte1/DWtevGEJ0s5pN+t0VfsoWav2GTk084ImlfeYaP4UJSiN
 Q1fCSa0DFfGl19p1iygp10MDI5zDllfjHIFc+6oi1d+7nN/YP1XgjM7UStTEetfsUDSRGY1aGYC
 R4LpdZzyTSMNX3yBFBtA63yROanfGNqBlgZFphWjKr4E2B5DpkKLUjjd7Q/yG1RgBD/x8c4cb6V
 4IdEA3KXMN41G9jD57PA0aZEmUg8wNx9Mr6YkfcyPu3bqGxo
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

Hi,

This series is an initial attempt to support the PCIe M.2 connectors in the
kernel and devicetree binding. The PCIe M.2 connectors as defined in the PCI
Express M.2 Specification are widely used in Notebooks/Tablet form factors (even
in PCs). On the ACPI platforms, power to these connectors are mostly handled by
the firmware/BIOS and the kernel never bothered to directly power manage them as
like other PCIe connectors. But on the devicetree platforms, the kernel needs to
power manage these connectors with the help of the devicetree description. But
so far, there is no proper representation of the M.2 connectors in devicetree
binding. This forced the developers to fake the M.2 connectors as PMU nodes [1]
and fixed regulators in devicetree.

So to properly support the M.2 connectors in devicetree platforms, this series
introduces the devicetree binding for Mechanical Key M connector as an example
and also the corresponding pwrseq driver and PCI changes in kernel to driver the
connector.

The Mechanical Key M connector is used to connect SSDs to the host machine over
PCIe/SATA interfaces. Due to the hardware constraints, this series only adds
support for driving the PCIe interface of the connector in the kernel.

Also, the optional interfaces supported by the Key M connectors are not
supported in the driver and left for the future enhancements.

Future work
===========

I'm planning to submit the follow-up series to add support for the Mechanical
Key A connector for connecting the WiFI/BT cards, once some initial review
happens on this series.

Testing
=======

This series, together with the devicetree changes [2] [3] were tested on the
Qualcomm X1e based Lenovo Thinkpad T14s Laptop which has the NVMe SSD connected
over PCIe.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts?h=v6.18-rc4&id=d09ab685a8f51ba412d37305ea62628a01cbea57
[2] https://github.com/Mani-Sadhasivam/linux/commit/40120d02219f34d2040ffa6328f0d406b1e4c04d
[3] https://github.com/Mani-Sadhasivam/linux/commit/ff6c3075836cc794a3700b0ec6a4a9eb21d14c6f

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Changes in v3:
- Changed the VIO supply name as per dtschema
- Added explicit endpoint properties to port 0 node for host I/F
- Used scope based cleanup for OF node in pwrseq driver
- Collected review tags
- Link to v2: https://lore.kernel.org/r/20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com

Changes in v2:
- Incorporated comments from Bartosz and Frank for pwrseq and dt-binding
  patches, especially adding the pwrseq match() code.
- Link to v1: https://lore.kernel.org/r/20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com

---
Manivannan Sadhasivam (4):
      dt-bindings: connector: Add PCIe M.2 Mechanical Key M connector
      PCI/pwrctrl: Add support for handling PCIe M.2 connectors
      PCI/pwrctrl: Create pwrctrl device if the graph port is found
      power: sequencing: Add the Power Sequencing driver for the PCIe M.2 connectors

 .../bindings/connector/pcie-m2-m-connector.yaml    | 141 ++++++++++++++++++
 MAINTAINERS                                        |   7 +
 drivers/pci/probe.c                                |   3 +-
 drivers/pci/pwrctrl/Kconfig                        |   1 +
 drivers/pci/pwrctrl/slot.c                         |  35 ++++-
 drivers/power/sequencing/Kconfig                   |   8 ++
 drivers/power/sequencing/Makefile                  |   1 +
 drivers/power/sequencing/pwrseq-pcie-m2.c          | 160 +++++++++++++++++++++
 8 files changed, 350 insertions(+), 6 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251103-pci-m2-7633631b6faa

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>



