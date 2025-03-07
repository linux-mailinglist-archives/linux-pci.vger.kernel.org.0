Return-Path: <linux-pci+bounces-23171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C4A57632
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 00:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F1A1894ED2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 23:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBA8208990;
	Fri,  7 Mar 2025 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLya8N82"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B833DF;
	Fri,  7 Mar 2025 23:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390672; cv=none; b=SFw4VK6n108FlxLaajK1HdmV4TZaVnMEmoYWEf3/QqCSWMKueKOBdo5vHqIIoL1HG+y3GDsA6zSviMkBgTzDsl6QPrA2Cji5iet3SEQNwAO14lW6ez4pIeNrj1X/n/5DYIFUDLD6KGBDejQrYtPTw6sbpN1aKzuSriimu3PjtNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390672; c=relaxed/simple;
	bh=ntJVwAlnC7PYrvIOC5jK7B6yxVs/a1jXq1ba53Gp12E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=usx/nWkpFcLVDx0gKqT+J/2ZjQtm66Xh5MY/PwpXSEdh5jQg9rIVbAlY+qmnMHUKrmEs9M6IpJjMQ4FsFuwQ7ItQXUtJGeTzWr2HnDtMRS4YU4uYV0ztp41FeOglINdapaurkCP9ZAuIIIRN/Pp6+oR7YGR3P39ifDvmDRQPLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLya8N82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A26C4CED1;
	Fri,  7 Mar 2025 23:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741390672;
	bh=ntJVwAlnC7PYrvIOC5jK7B6yxVs/a1jXq1ba53Gp12E=;
	h=From:To:Cc:Subject:Date:From;
	b=uLya8N82ynikuLeVwl0uwksI1eaD3k60c8OjDE2TxI/rfoZC6qD9odpBM2qVC4tSv
	 0t42V9ybYVU1PznQs3ZBnY8c/MKiauAjGnQz8dAlQo095PH1h9l1UNSsuMpFndvpWD
	 CaUsPUNvOLBT8joky0bNXIuxaQnK5hB6xJ4288VdQ7VwPgVhlOyoBKM49S4cV+Y0Z9
	 ISDeTw3g2z+CCbPhu2IzM5YAOQouFxRBh7pT3w0jqN7DybrRjxHufkgB/2OTr+JuD5
	 XvCkZcpq3OdmFfjdoZ4DKBwY5hhtJpLAkarFmedPmTw4cm1LC4Gpm3vhTVadTMzdJg
	 xAagsnBPxfhOw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/4] PCI: dwc: .cpu_addr_fixup() sketch
Date: Fri,  7 Mar 2025 17:37:40 -0600
Message-Id: <20250307233744.440476-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This is not complete or ready to merge at all.  It's just a sketch to see
if this approach to moving away from the .cpu_addr_fixup() approach is
feasible.

This is based on Frank's series at
https://lore.kernel.org/r/20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com,
and these apply on top of these patches from that series, which applies on
v6.15-rc1:

      PCI: dwc: Use resource start as iomap() input in dw_pcie_pme_turn_off()
      PCI: dwc: Rename cpu_addr to parent_bus_addr for ATU configuration
      PCI: Add parent_bus_offset to resource_entry

The idea is that on some systems the PCI controller lives in a different
address space (an "intermediate" address space) than the CPU physical
address space.  Frank has a beautiful picture of this at
https://lore.kernel.org/r/20250128-pci_fixup_addr-v9-4-3c4bb506f665@nxp.com

The devicetree *should* describe the fabric address translation between the
CPU and intermediate address spaces, but historically we haven't taken
advantage of that and have used .cpu_addr_fixup() functions to convert CPU
to intermediate addresses each time we program the ATU.

What I tried to do here was to:

  - Try to extract the offset from devicetree using the 'reg' property
    (this is from Frank's patch at the link above)

  - If a .cpu_addr_fixup() function exists, run that as well and compare
    with the offset from devicetree

  - Save the offset in struct dw_pcie_rp and apply that instead of calling
    .cpu_addr_fixup() in the future

  - Emit messages about devicetree offsets that don't match what
    .cpu_addr_fixup() did, or about .cpu_addr_fixup() methods that are
    superfluous because they *do* match the devicetree offset

I only looked at the RC side and didn't do anything at all with the EP
side.

Bjorn Helgaas (4):
  PCI: dwc: Move cfg0 setup to dw_pcie_cfg0_setup()
  PCI: dwc: Delay cfg0 setup until after discovering bridge windows
  PCI: dwc: Look up 'config' address
  PCI: dwc: Use parent_bus_offset

 .../pci/controller/dwc/pcie-designware-host.c | 88 +++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c  |  3 -
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 3 files changed, 72 insertions(+), 20 deletions(-)

-- 
2.34.1


