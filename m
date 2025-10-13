Return-Path: <linux-pci+bounces-37917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF3BD5284
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 18:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF07B508A73
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95FE30FF06;
	Mon, 13 Oct 2025 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="em/ywoou"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDACE30FC27
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369733; cv=none; b=lvtookvDnB6u4UEVKaf8IXaWGMXHkC5fI1x4Dmj4E7gM2Pj4gbpaY50IBzpmIk3WIulMZBVagiX4CR8n1nR8b5y0unQgzinV7XVme/gRUXelxP7WLMwUDq1xsGyf9JKP5Hf1r9P8Y8Q6qwbdOFHfAcDOoSZ54Pz8/hgVYtrOpj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369733; c=relaxed/simple;
	bh=lQE08uJWLPHhEhaQeR1D11dMTBylx7XRz2HfPMzk03o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q439IC9gt2WiMjgfE3bINi/I1xnvfZWd9YaI3vu/hD2iNA7wvMLgfjdBAQxWDfFsQ7cPdBZzuTIe7jkdpwkjyZsYyUxwP6+E0xVnICOozN0ITC/bXdgjmlngejzrA1DcWPMrkDM1dnJYVu7AwX3+Yxzz+Cw+nsap08n7An5Q66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=em/ywoou; arc=none smtp.client-ip=209.85.166.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f194.google.com with SMTP id e9e14a558f8ab-42d8ad71a51so48759175ab.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760369731; x=1760974531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nbeq8htIVJsgPcvnZy6FQgEdm/DTZPuXtXg2N0Ndwqo=;
        b=em/ywoouTQlRiHcO01bobHWg5o6vVu/Kx8gKCLRKBM7DP7ABkKc1JJ1XXmv4VpbBX1
         6ZzYXXxNNxevfkTrpWjGom1snIISdJRCASbiEJZV5h/3LewOo+0V+B41dzAIkgmUwDXE
         74avfdHDCBLZ67B7SewmeKI03EmeY+9MXb0VX9wkxvoVYI9tYs/hepk33SCWkccfncKe
         TOFuH6fSaWEAKKBv2gQwWy82Fay25vTieN+Wx/ovAAIoNLPLZGivJz1LppGXMWu1TENh
         QLhBsXdWgkrPAxqselIhxnN3otqaOVa7vHncaH9E38VGlJZdUddmkTHZOnL5qJ8ggJ1o
         zaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369731; x=1760974531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbeq8htIVJsgPcvnZy6FQgEdm/DTZPuXtXg2N0Ndwqo=;
        b=pZqwb7alWp1KTu8/+D0kwNF9vxYyuEiYA/8YS0sF0FYabNcTIMETe3CZoVPPtg7je1
         IHL+DShj3aeBoyqjvLoLpQvgCasKoul9EVqqfKwYP3E7d1PeX6iQLgq0OcjnfjtmPJbV
         0Zin2gmtO4xlYshh8ZAJdABjgl+85WHqWAr+Tzq/E9ILVScrSVyOQ1Nztlh470MD+CVc
         ab5w+PtN+gsD5+UN2dM62fZpXNSgsFqB/MNRCKKpQc6HWdLCyhHbd4MG9OgdSsT04eZ8
         /bUNCSuRNt3FsYgF4V+ehqzvN9uf4VMAoSC/cYtVnQYdhLihTTt+688PmnAeAGoZR6uN
         mdVw==
X-Forwarded-Encrypted: i=1; AJvYcCVOHkdUQp/e7+VMEZ+YLuUKtzuBJOr49C1EgYm5RbgL2KdSqLGCS7eJhJANyq/M8p5lo/4GfyEvf+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+YtOsIfsNV6tAw1oOAEtX1W5ZRLor4J9WUyuQeWh0+a9mHjk
	q1+kjft5WxWqybqBuxNJwK+9btlS4JpW8LsjOkPMXtpZld7ByMJCRjTFC3ogUGADw3c=
X-Gm-Gg: ASbGncuLw3+/pwId+ojl7uYJeaa4+cJCZJ+8Lzi0OR1vNBxgG6ejwb2QfkilAK8d7yV
	2fNyayxdyejuxJwc9eUIjCVFgD04o8XlHeOt+zresQrJ4j/wZ5P1dA+t4LklQsd0jIuXiIGk9sz
	peHpvbgb3U+5vaOj3dRaIdwGMrwi0RAIYRVvPpN6jJTjSXVpA+uQZYpQzR4vE++mBz3qKjTSx5S
	ub643vp8rSTit5y50XqdlEd1fEmIzGLAztpfc1qMPmPNbjfmM/WDNp99B53hrp8Syxv8H3Sc0Wf
	eVAxqNt5+mf70tb2XrHjiJAzSDklpjoh69BhL64ooTj43GSz1i4fSET3QIPtq2yhstcLKolU7K7
	sHut2KQFDZlisWKCWMdoAb3UgctKYkVKRAQee4O+npYX16nUc6o+UqDySugQ4oJQSAKNNXZeiXc
	nqnlJdjglt
X-Google-Smtp-Source: AGHT+IGwhDgY1adEE+rYfro+kFlaDS5/FvDMA4RAEoQjxWvr5pWNWNsa0mX7bl3S4p/in4/RNtqUig==
X-Received: by 2002:a05:6e02:1608:b0:42e:7a5d:d7d6 with SMTP id e9e14a558f8ab-42f87346ffcmr235225235ab.2.1760369730674;
        Mon, 13 Oct 2025 08:35:30 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c49b522sm3910266173.1.2025.10.13.08.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:35:30 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	christian.bruel@foss.st.com,
	shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de,
	thippeswamy.havalige@amd.com,
	inochiama@gmail.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] Introduce SpacemiT K1 PCIe phy and host controller
Date: Mon, 13 Oct 2025 10:35:17 -0500
Message-ID: <20251013153526.2276556-1-elder@riscstar.com>
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
that PHY to be used for USB, the calibration step is performed by
the PHY driver automatically at probe time.  Once this step is done,
the PHY can be used for either PCIe or USB.

Version 2 of this series incorporates suggestions made during the
review of version 1.  Specific highlights are detailed below.

					-Alex

This series is available here:
  https://github.com/riscstar/linux/tree/outgoing/pcie-v2

Between version 1 and version 2:
  - General
    - VENDOR ID 0x201f is now registered with PCI SIG: "SpacemiT
      (Hangzhou) Technology Co. Ltd"
        https://pcisig.com/membership/member-companies?combine=201f
    - The PCIe host compatible string is now "spacemit,k1-pcie"
    - Reimplemented the PHY PLL as a clock registered with the
      common clock framework, driven by an external oscillator
    - Added the external oscillator clock to the PHY binding
    - Renamed the PCIe driver source file "pcie-spacemit-k1.c"
  - Kconfig
    - Renamed the PCIe driver Kconfig option PCIE_SPACEMIT_K1
    - The PCIe driver is now defined as tristate, not Boolean
    - Updated the PCIe host Kconfig based on Bjorn H's feedback
  - DT Bindings
    - Corrected PCIe node ranges properties
    - Replaced "interrupts-extended" property with just "interrupts"
      in the PCIe host binding
    - Named the single PCIe interrupt "msi" to clarify its purpose
    - Added a new vpcie3v3-supply property for PCIe ports
    - Renamed a syscon property to align with other SpacemiT bindings
    - Removed labels and status properties in DT binding examples
    - Added a '>' to DT binding descriptions to preserve formatting
    - Consistently ended DT binding descriptions with no period
    - Dropped ".yaml" from the PCIe host compatible string
    - Dropped unneeded max-link-speed property from PCIe binding,
      relying on the hardware default value instead
    - No longer require the bus-ranges PCIe property; if not
      provided, the default value used is exactly what's desired
  - Code
    - Renamed the symbols representing the PCI vendor and device IDs
      to align with <linux/pci_ids.h>
    - Use PCIE_T_PVPERL_MS rather than 100 to represent a standard
      delay period.
    - Use platform (not dev) driver-data access functions; assignment
      is done only after the private structure is initialized
    - Deleted some unneeded includes in the PCIe driver.
    - Dropped error checking when operating on MMIO-backed regmaps
    - Added a regmap_read() call in two places, to ensure a specified
      delay occurs *after* the a MMIO write has reached its target.
    - Used ARRAY_SIZE() (not a local variable value) in a few spots
    - Now use readl_relaxed()/writel_relaxed() when operating on
      the "link" I/O memory space in the PCIe driver
    - Updated a few error messages for consistency
    - No longer specify suppress_bind_attrs in the PCIe driver
    - Now specify PCIe driver probe type as PROBE_PREFER_ASYNCHRONOUS
  - Miscellany
    - Subject on the PCIe host binding includes "pci", not "phy"
    - Clarified that the DesignWare built-in MSI controller is used
    - Use "PCIe gen2" terminology (rather than "PCIe v2")
    - No longer use (void) cast to indicate ignored return values

Here is version 1 of this series:
  https://lore.kernel.org/lkml/20250813184701.2444372-1-elder@riscstar.com/


Alex Elder (7):
  dt-bindings: phy: spacemit: add SpacemiT PCIe/combo PHY
  dt-bindings: phy: spacemit: introduce PCIe PHY
  dt-bindings: pci: spacemit: introduce PCIe host controller
  phy: spacemit: introduce PCIe/combo PHY
  PCI: spacemit: introduce SpacemiT PCIe host driver
  riscv: dts: spacemit: add a PCIe regulator
  riscv: dts: spacemit: PCIe and PHY-related updates

 .../bindings/pci/spacemit,k1-pcie-host.yaml   | 156 ++++
 .../bindings/phy/spacemit,k1-combo-phy.yaml   | 114 +++
 .../bindings/phy/spacemit,k1-pcie-phy.yaml    |  59 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  38 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  33 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 151 ++++
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-spacemit-k1.c | 319 +++++++++
 drivers/phy/Kconfig                           |  11 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-spacemit-k1-pcie.c            | 672 ++++++++++++++++++
 12 files changed, 1565 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-spacemit-k1.c
 create mode 100644 drivers/phy/phy-spacemit-k1-pcie.c


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.48.1


