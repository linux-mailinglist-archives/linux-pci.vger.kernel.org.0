Return-Path: <linux-pci+bounces-36757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AD0B95A63
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 13:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE373A8A6E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83453218DB;
	Tue, 23 Sep 2025 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dacKl6Ps"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B42DCF44;
	Tue, 23 Sep 2025 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626819; cv=none; b=p5ye/NORxU3IGc4IEUYt4jeBQMkMYrY3yTnd8crm4frVy1aMQ/MXaNyPEqIjzB11uhVkHpwzP9HeIirVuwV+I+D/KZ1rm4ASkuqi4y3p4HFwUpfk+nD/+7pOdFwD2pIAh0qzt1luBRms7yo483nWdwKCADxwVRK0b560b5EcVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626819; c=relaxed/simple;
	bh=IpaBRdasnDHpzr3HxE+/OTJ26uvSLSqswF1CIRDtBCQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VjUPBPuKcJD1dokKbZIpAcm8C/OlKNQj0uWzndDvleM03v9Lo/ovZ9/VQ6NfzsIHxRMgaY3bVsACrlHINoM8IU6QUykH7UqyCY7jedBgNf+qBsqxJn876bwfF34jNfIF3jwKMH4eWxWO+LTKBm9KAHUmzFDhO5yxJtRp62uYNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dacKl6Ps; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C25C4CEF5;
	Tue, 23 Sep 2025 11:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758626819;
	bh=IpaBRdasnDHpzr3HxE+/OTJ26uvSLSqswF1CIRDtBCQ=;
	h=From:Subject:Date:To:Cc:From;
	b=dacKl6PsYA4kqWF3ywX7LoRb5A0Gv6EOQQw6F9Tg/ANRiI1szo40LC7Mkt5e/YeK7
	 OONZWOXnBAFKMFLZ68dqNoJnVmmIGblajdSJ2p5BzTxXIzuEyKHMlo59H6/9CE6PkS
	 Y1W/zpo58Zp+xOrYIoy1U1woksLIjtqGvAcNL79yeVH24AAw/GHGp2tedeAjIQC0xg
	 whO3PJvZOzJhLL7nODEuiPzQ5QJTqsP+ybCVEq1OVX4ZjqFGwFzBOrnRHa2LseCTrb
	 atemI+uZ2z7WelY9KUwchCyVNmCG/cDRXAShqrelcW3tOIruA679CAy+3jjHk1iMUi
	 kH7JHN+86LSsQ==
From: Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v10 0/4] PCI: dwc: Add ECAM support with iATU configuration
Date: Tue, 23 Sep 2025 16:56:50 +0530
Message-Id: <20250923-controller-dwc-ecam-v10-0-e84390ba75fa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPqD0mgC/22Nyw6CMBBFf4XM2jEtlEdZ+R+GBbYjNGJrpgQ1h
 H+3krhzeU5yz10hEjuK0GYrMC0uuuATSHHIwIy9HwidTQJykZdCiwZN8DOHaSJG+zRIpr+jMrU
 pZFFZkgrS8sF0da89e+4Sjy7Ogd/7y6K/9tfTf3uLRoG1LS9VKRslrD3diD1Nx8ADdNu2fQBoh
 tH+uAAAAA==
X-Change-ID: 20250908-controller-dwc-ecam-4c7c3136de14
To: Jingoo Han <jingoohan1@gmail.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Jonathan Chocron <jonnyc@amazon.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3739; i=mani@kernel.org;
 h=from:subject:message-id; bh=IpaBRdasnDHpzr3HxE+/OTJ26uvSLSqswF1CIRDtBCQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBo0oP+agCPD5sI9myrKqi+guGHohOWmsjTBZyxl
 YrrHBL6SJCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaNKD/gAKCRBVnxHm/pHO
 9fxsCACHK7T3Irtv+RCeEVOWqHNrHTj3d/OzhEtl/dBmBv9I2LC29DOb29Ingrf6quZjSfFV2h4
 t+8iV/01xvHfwjM6B27MhmqvMXc0j/KgKaK7QclQStDkchpt4hKtWsQJ6BByPvl8adRk5bjYgnc
 wATZtnJcI4YyFaDOnt6WYrBu7crfh/lFpcgXY9OoOKDRS73QBXFlYBL9JEkoF0GPPV1InNjpfzp
 GeLdKBIwaF5DPw40zVCNmft8Ap7V5ne6ou/0ZH/7jAwG2lOcg2JPWcXfgrNQOHtRB/0Wk/sihGd
 LsKfoEx6eR1L5w7pyQ9MCOhbPvw3Jv2nm3nfSZUiEAp2tZ97
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

The current implementation requires iATU for every configuration
space access which increases latency & cpu utilization.

Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
would be matched against the Base and Limit addresses) of the incoming
CfgRd0/CfgWr0 down to bits[27:12]of the translated address.

Configuring iATU in config shift mode enables ECAM feature to access the
config space, which avoids iATU configuration for every config access.

Add cfg_shft_mode into struct dw_pcie_ob_atu_cfg to enable config shift mode.

As DBI comes under config space, this avoids remapping of DBI space
separately. Instead, it uses the mapped config space address returned from
ECAM initialization. Change the order of dw_pcie_get_resources() execution
to acheive this.

Enable the ECAM feature if the config space size is equal to size required
to represent number of buses in the bus range property.

ELBI registers are optional registers which are part of dwc. So move
ELBI resource mapping to dwc. Also change the dtbinding and devicetree
to make the elbi registers as optional one. Having ELBI as the required
one is making the ecam feature complicated.

The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
gives us the offset from which ELBI starts. so use this offset and cfg
win to map these regions instead of doing the ioremap again.

On root bus, we have only the root port. Any access other than that
should not go out of the link and should return all F's. Since the iATU
is configured for the buses which starts after root bus, block the
transactions starting from function 1 of the root bus to the end of
the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
outside the link through ECAM blocker through PARF registers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
Changes in v10:
- Moved qcom_pci_config_ecam() to qcom_pcie_host_init()
- Reworded the comment in patch 3
- Rebased on top of pci/controller/qcom 
- Link to v9: https://lore.kernel.org/r/20250909-controller-dwc-ecam-v9-0-7d5b651840dd@kernel.org

Changes in v9:
 - Splitted the ECAM enablement change to avoid bisect hole and excluded pcie-al
   driver from DWC ECAM since it uses its own ECAM mechanism.
 - Squashed the patches 2 and 3 as patch 2 won't work without 3.

For the rest of the history, please refer v8 changeset:
https://lore.kernel.org/linux-pci/20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com

---
Krishna Chaitanya Chundru (4):
      PCI: dwc: Add support for ELBI resource mapping
      PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'
      PCI: qcom: Prepare for the DWC ECAM enablement
      PCI: dwc: Support ECAM mechanism by enabling iATU 'CFG Shift Feature'

 drivers/pci/controller/dwc/Kconfig                |   1 +
 drivers/pci/controller/dwc/pci-exynos.c           |  62 ++++-----
 drivers/pci/controller/dwc/pcie-al.c              |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 148 ++++++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.c      |  10 +-
 drivers/pci/controller/dwc/pcie-designware.h      |   7 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c         |  15 +--
 drivers/pci/controller/dwc/pcie-qcom.c            |  84 ++++++++++--
 8 files changed, 261 insertions(+), 67 deletions(-)
---
base-commit: af8df709bf365f5583d31091280354e1ef0b201f
change-id: 20250908-controller-dwc-ecam-4c7c3136de14

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


