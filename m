Return-Path: <linux-pci+bounces-40599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2CCC41679
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 20:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEE918832FA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E31E2F12DE;
	Fri,  7 Nov 2025 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="OWx5EK4c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636762D0C83
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542967; cv=none; b=LDYWFDdJfPsfVyXK3iPFHxgErswTZOdj4PnIKranvNmM965XPSJdslDffOGY9OCfXHq2jbUVIGlnzvbCOwyuABEgibMoe2pwtCw9LqKm5dNQi3x5WEq29GajBgbtpfgrDlurMcBHm9Ez7MJ+tjJVF6gcl/VtGGGI2GM9o25yPBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542967; c=relaxed/simple;
	bh=q8z9+PmjzZ8xWRRUGOEKAikoRbeoaeKm1pXl4fitFcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJxC1u10uY8HJ27ZWAMLnxvxf0zSpRRowPJmtMDOvf65EQPQK1xxd3f33kZ5FHw/GmHoB4qT83d9iHyzbNGfAjH/VUDKThySPqOI8uLSrm06QRKWx/0bEpiKhk8Gnditl+YrSMRvIPtaxzpPAnKjHJgPQmvV7gdIAiiarF3y17Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=OWx5EK4c; arc=none smtp.client-ip=209.85.166.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f66.google.com with SMTP id ca18e2360f4ac-940d327df21so30075339f.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 11:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762542963; x=1763147763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6n9WzDNQaPD3sJObWy9/wpMh9WA3E6Erilh18wQKqfc=;
        b=OWx5EK4cW11RU++avdrrUtRe1oNPfeh7QN6cSD6GdqROfFE+E8bb+ijlFpeM2P52Nm
         TQeCyHhU7mUaGFbeLJB2GhA7ywqgNYoRHyCL+mGboFSJDXBkgFhIl7jpZ6m3OgZRS2cu
         lJqR+WN5nCkG/diEc4efTmJrbNqwP2Qm7vFJkq+Kg083tzSWwx9hQBwfbHcVb4DKSd9+
         hp5rwooAE2AWo1ZEe88LyPoq1GM7SyC4M7PWzob4titHgB1k7EAygVhmQpKKYTcc0y2B
         XND1mi0TdhZSS9pnAl6fPsj+t18kkDxNjgQ05WGuHFQPAIkDpp6aTccnrMpPylt6dgwJ
         FeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762542963; x=1763147763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n9WzDNQaPD3sJObWy9/wpMh9WA3E6Erilh18wQKqfc=;
        b=NE22RZ7+H2jjQUdzXMl1ghUXN0g7MLDdAuTD0qI114pGL933iebPHvquzhCY9S9AKs
         88Xyt6RGSo5/LMelbpmQatb8GfOliAYFPHoO1NM6OvVvOKtGY4SHvq6NoudHsnHfMQCm
         bqs4sk/OoGN+9SaGmyAUMhOAfDyZZExdiRyuhnGaEZQiYl2NJuKv5MFijFNhrZwCOk9C
         I0poRGnaDpBp1xplNGbDpZwmFLL3NvnoSgPFcWlieq5UnJ720yI73LcXqS9AzgGgNgN1
         9sYOZXpn9iVcvFufq/kkpvH1AWdxgySXgidRatSmMYTMpqxyxAw4xgFvmzLw039SG8Nn
         tZpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiPpUSY/kLfAm8LJkEH5rAI2TvZw52/8LQ248IgzXjXkSf+N3y7D0mAwVWCOMK/7JLKlqGOo6jkQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLsmGsMaa0QYWBElYNxUp3uVOpblUrweaye2AhxUz10Zfdpo9w
	ErVhAaZhFCbV0aFhAOlIX6u8X22+xrugQagYoy0bQqkkk1wHJ/Q9uphaiF8rBBn3tI4=
X-Gm-Gg: ASbGncuw7IeqNlkXb2Hf2rgqffEl8y99ezEEQUBJanEC3P1uoRYX+Ev+U6heH44Ko4g
	YrHAc/SinwzysfajmqwKXbIsI0PnqA20LwjuEEwSzrSfuGUmIRmP/+j0Os2OdLJMSMO00KFnK+H
	seGBF0evTc6M+VxxgOrAfFfFdjkTgEEwi6++adkWCRoL6ZFeYtau7+zzKjNpQV2Uffxk/52gVNr
	d3HYPOS1le4itlKnlrjMiJMdfArnxKcC53fpVIj73LqXt50we59/D+FRy/u7aXkacyA/Nl9trcB
	/dM+5DtAMM55Frn58HGWjI0xUmcpQKTHDf9o4BsRldnORQl8FL64Q2YPTySoi23fwQAutO+mt8S
	DTz8RWSpyXtO26SbSqtrMJ6UcaWU4yEh+XeoZam59hox4OIfpfVx98s7qFvjONX+8cA365H1Abx
	vy5TNS2jePu3Qq8aaZQAA9X8ULezzlprLy54uR0iorP90Mxno9GsQxng==
X-Google-Smtp-Source: AGHT+IHzW2i2JPY8Wetr24eEJmqYYe9Yl8l6cwzTHxWm6YorX15rRz+Oc0kP8V7OeF++pSW10dZrTw==
X-Received: by 2002:a05:6602:3e81:b0:945:ac8e:fcb9 with SMTP id ca18e2360f4ac-9489602f282mr55483139f.17.1762542963188;
        Fri, 07 Nov 2025 11:16:03 -0800 (PST)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94888c34c6asm118772939f.10.2025.11.07.11.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:16:02 -0800 (PST)
From: Alex Elder <elder@riscstar.com>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org
Cc: ziyao@disroot.org,
	aurelien@aurel32.net,
	johannes@erdfelt.com,
	mayank.rana@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com,
	shradha.t@samsung.com,
	inochiama@gmail.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	christian.bruel@foss.st.com,
	thippeswamy.havalige@amd.com,
	krishna.chundru@oss.qualcomm.com,
	guodong@riscstar.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Date: Fri,  7 Nov 2025 13:15:49 -0600
Message-ID: <20251107191557.1827677-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a PHY driver and a PCIe driver to support PCIe
on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
one PCIe lane, and the other two ports each have two lanes.  All PCIe
ports operate at 5 GT/second.

The PCIe PHYs must be configured using a value that can only be
determined using the combo PHY, operating in PCIe mode.  To allow
that PHY to be used for USB, the needed calibration step is performed
by the PHY driver automatically at probe time.  Once this step is done,
the PHY can be used for either PCIe or USB.

This initial version of the driver supports 32 MSIs, and does not
support PCI INTx interrupts.  The hardware does not support MSI-X.

Version 5 of this series incorporates suggestions made during the
review of version 4.  Specific highlights are detailed below.

Note:
Aurelien Jarno and Johannes Erdfelt have reported seeing ASPM errors
accessing NVMe drives when using earlier versions of this series.
The Kconfig files they used were very different from the RISC-V
default configuration.

Aurelien has since reported the errors do not occur when using
defconfig.  Johannes has not reported back about this.

I do not claim these issues are resolved, however this version
of the series does address all other feedback received to date.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/pcie-v5

Between version 3 and version 4:
- Clarify that INTx interrupts are not currently supported
- Add Rob Herring's Reviewed-by on patch 3
- The name of the PCIe root port will always begin with "pcie"
- Lines in the bindings are now wrapped at 80 columns
- Subject lines are all captialized (after subsystem tags)
- Place the PCIe Kconfig option in the proper location based on
  vendor name (not Kconfig symbol); expand its description
- Drop two PCIe controller Kconfig dependencies
- Use dw_pcie_readl_dbi() and dw_pcie_writel_dbi() when turning
  off ASPM L1
- The dw_pcie_host_ops->init callback has been rearranged a bit:
    - The vendor and device IDs are now set early
    - PERST# is asserted separate from putting the controller in RC mode
      and indicating power is detected
    - phy_init() is now called later, just before deasserting PERST#
- Because of timing issues involved in having the root port enable power,
  getting and enabling the regulator is back to being done in the PCIe
  controller probe function
- The regulator definition is moved back to the PCIe controller DT node,
  out of the root port sub-node (in "k1-bananapi-f3.dts")

Here is version 4 of this series:
  https://lore.kernel.org/lkml/20251030220259.1063792-1-elder@riscstar.com/

Between version 3 and version 4:
  - In the DT binding for the PCIe host controlloller, add a new
    sub-node representing the root port
  - Move the phys and supply properties out of the PCIe host controller
    and into the root port node
  - Define the spacemit,apmu property later in the binding and DTS files
  - Define the device_type property first in the binding examples and
    DTS files
  - Add root port sub-nodes in the examples and the DTS files
  - Select the PCI_PWRCTRL_SLOT config option when PCIE_SPACEMIT_K1 is
    enabled
  - Parse the root port node in the driver, and get the PHY
  - Leverage the PCI pwrctrl slot driver to get and enable the regulator
  - Don't set num_vectors to 256; just use the default (32)
  - Cleaned up some comments, white space, and symbol names based on
    feedback from Mani
  - Add some runtime PM calls to ensure it works propertly
  - Add a new post_init callback, which disables ASPM L1 for the link

Here is version 3 of this series:
  https://lore.kernel.org/lkml/20251017190740.306780-1-elder@riscstar.com/

Between version 2 and version 3:
  - Reviewed-by from Rob added to the first two patches
  - The "num-viewport" property has been removed
  - The "phy" reset is listed first in the combo PHY binding
  - The PHY now requires a resets property to specify the "phy" reset
  - The PCIe driver no longer requires a "phy" reset
  - The PHY driver now gets and deasserts the reset for all PHYs
  - Error handling and "put" of clocks in the PHY driver has been
    corrected (for clk_bulk_get() rather than clk_bulk_get_all())

Here is version 2 of this series:
  https://lore.kernel.org/lkml/20251013153526.2276556-1-elder@riscstar.com/


Alex Elder (7):
  dt-bindings: phy: spacemit: Add SpacemiT PCIe/combo PHY
  dt-bindings: phy: spacemit: Introduce PCIe PHY
  dt-bindings: pci: spacemit: Introduce PCIe host controller
  phy: spacemit: Introduce PCIe/combo PHY
  PCI: spacemit: Add SpacemiT PCIe host driver
  riscv: dts: spacemit: Add a PCIe regulator
  riscv: dts: spacemit: PCIe and PHY-related updates

 .../bindings/pci/spacemit,k1-pcie-host.yaml   | 157 ++++
 .../bindings/phy/spacemit,k1-combo-phy.yaml   | 114 +++
 .../bindings/phy/spacemit,k1-pcie-phy.yaml    |  71 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  44 ++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  33 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 176 +++++
 drivers/pci/controller/dwc/Kconfig            |  13 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 353 +++++++++
 drivers/phy/Kconfig                           |  11 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-spacemit-k1-pcie.c            | 670 ++++++++++++++++++
 12 files changed, 1644 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-spacemit-k1.c
 create mode 100644 drivers/phy/phy-spacemit-k1-pcie.c


base-commit: 9c0826a5d9aa4d52206dd89976858457a2a8a7ed
-- 
2.48.1


