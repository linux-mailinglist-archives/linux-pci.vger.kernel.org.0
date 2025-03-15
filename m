Return-Path: <linux-pci+bounces-23853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 680F3A63247
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 21:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6231896E41
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDABD199238;
	Sat, 15 Mar 2025 20:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9skukOw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C8D376;
	Sat, 15 Mar 2025 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742069757; cv=none; b=Ichyx1EF0Jf1N3RCQAfW5E/ylcDEOOKZ7BVxw/Jnwnj4UptN24rDFrvPsqTo3YhqnsfGXIiSfy5jXIDEKdkG7OOhMmZhR9oSSF07/1DtIExBq3QXUYtoLL9qMvO9qEpt2dhJffeTUp6/1ryUYN4/vGFncY8bqYQb5G0PSrCRmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742069757; c=relaxed/simple;
	bh=XEoOzG46XXSFCigErs0BgukJPEtc5flcUfkUJgOgzIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gm+reKvm4mvAP7StI433FtIeSXOetPCjvJv4dxSM4G0ACHzMn7LbQbFCnZ1/75jKXRCunMV82FZQYpsRNmfcPtDEsJct4Zke35eoFsnWvuLcEnAtaATMkLV6q42CO1PNFF0OkCZATaJJQ3ZrbgiepTwB64CGkKmuB102/IpTWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9skukOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6D7C4CEE5;
	Sat, 15 Mar 2025 20:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742069755;
	bh=XEoOzG46XXSFCigErs0BgukJPEtc5flcUfkUJgOgzIc=;
	h=From:To:Cc:Subject:Date:From;
	b=S9skukOwLYXwPWenoQ6yvLO7gET2V/b7mOX1ISf1RLNNW/Ym5CZ711TUYjp4DlpnA
	 ssV40YFRIJs4wYy+hhVzK7bEmm8GG9NLXEYSSTUWn+wLgTN6rIFPVIugDZhAA6qZPX
	 0nrODQlFO0hMfnqP8Og7F7TVXsWCw417DXBsYv6niXAmU4EdTZIDCiZ5BX3gShNz6Y
	 I1h3Syv/c4p1o5zLAMABoQvznM6i25Ec4JFXEG25mwHig2uP4IgPVfEjU2GgIYXZm9
	 ADL619FMCnMX+swWKpoVHA2jbjEz2DwqdVUWlfXjWyBn9dONEVuOOX8mx0t8h6ek8O
	 N3jmR2OBoMWUQ==
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
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 00/13] PCI: Use device bus range info to cleanup RC Host/EP pci_fixup_addr()
Date: Sat, 15 Mar 2025 15:15:35 -0500
Message-Id: <20250315201548.858189-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This is a v12 based on Frank's v11 series.

v11 https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com
    
Changes from v11:
  - Call devm_pci_alloc_host_bridge() early in dw_pcie_host_init(), before
    any devicetree-related code
  - Call devm_pci_epc_create() early in dw_pcie_ep_init(), before any
    devicetree-related code
  - Consolidate devicetree-related code in dw_pcie_host_get_resources() and
    dw_pcie_ep_get_resources()
  - Integrate dw_pcie_cfg0_setup() into dw_pcie_host_get_resources()
  - Convert dw_pcie_init_parent_bus_offset() to dw_pcie_parent_bus_offset()
    which returns the offset rather than setting it internally
  - Split the debug comparison of devicetree info with .cpu_addr_fixup() to
    separate patch so we can easily revert it later
  - Drop "cpu_addr_fixup() usage detected" warning since we always warn
    about something in that case anyway

Any comments welcome.


Bjorn Helgaas (3):
  PCI: dwc: Consolidate devicetree handling in
    dw_pcie_host_get_resources()
  PCI: dwc: ep: Call epc_create() early in dw_pcie_ep_init()
  PCI: dwc: ep: Consolidate devicetree handling in
    dw_pcie_ep_get_resources()

Frank Li (10):
  PCI: dwc: Use resource start as iomap() input in
    dw_pcie_pme_turn_off()
  PCI: dwc: Rename cpu_addr to parent_bus_addr for ATU configuration
  PCI: dwc: Call devm_pci_alloc_host_bridge() early in
    dw_pcie_host_init()
  PCI: dwc: Add dw_pcie_parent_bus_offset()
  PCI: dwc: Add dw_pcie_parent_bus_offset() checking and debug
  PCI: dwc: Use devicetree 'reg[config]' to derive CPU -> ATU addr
    offset
  PCI: dwc: ep: Use devicetree 'reg[addr_space]' to derive CPU -> ATU
    addr offset
  PCI: dwc: ep: Ensure proper iteration over outbound map windows
  PCI: dwc: Use parent_bus_offset to remove need for .cpu_addr_fixup()
  PCI: imx6: Remove cpu_addr_fixup()

 drivers/pci/controller/dwc/pci-imx6.c         | 18 +---
 .../pci/controller/dwc/pcie-designware-ep.c   | 74 +++++++++++------
 .../pci/controller/dwc/pcie-designware-host.c | 57 ++++++++-----
 drivers/pci/controller/dwc/pcie-designware.c  | 82 ++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  | 24 +++++-
 5 files changed, 171 insertions(+), 84 deletions(-)

-- 
2.34.1


