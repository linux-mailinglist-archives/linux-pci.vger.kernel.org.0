Return-Path: <linux-pci+bounces-40935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21987C4FF47
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 23:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040D01897C0E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 22:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A2428D829;
	Tue, 11 Nov 2025 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDBZpZr8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E5A27A107;
	Tue, 11 Nov 2025 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762899393; cv=none; b=AifjeZ99++9HEQCu/aUyJ2dzrBA2XXxtt9fmW4jS922brQsWLjoHhv2N3UKCM3i+NSmazPUeXyvq62GY/4Qh4iPidUByQ4VbTV8VO5RA7mxYS4HlSRJIF9g0gNk3QW+W3FfP0BQ353FxAci7mlShZcVIPoUvcRqgbjUYuRsVnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762899393; c=relaxed/simple;
	bh=o7bQ4BiteNEBflYFO9xS4aNpUQ3/uiKdReJRD+W/Xs8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnxgNjPrd4QrY7nhFZJOUzd9bnHeWn0Nbr/rXPKzbbbe1Sko5whvprkTcBnHs/qsONy/yzQsdKfnkfYSqQa2OeAhb0ghzHnEKsFlY+GJg5j2GitY4BcvYpoyz2EIGtPSd7WEn+H9uni6ShcLif3zctzzFP/BXrRnob1e2p0upf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDBZpZr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984B1C113D0;
	Tue, 11 Nov 2025 22:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762899392;
	bh=o7bQ4BiteNEBflYFO9xS4aNpUQ3/uiKdReJRD+W/Xs8=;
	h=From:To:Cc:Subject:Date:From;
	b=jDBZpZr8VayAjbfjTI+vVLb8YkruhItc0a4znA0U/zzvGzz4nwGj2WujwIHv6tJhu
	 3zK9UwoSXHXCY2IYV1iIFM8qRjItU5+ItVPJNXe61erfMUTIaFr57RLFEZfkhP1cmG
	 qXFeO/b9aNrXBVUjqVZpr2qNh53RNDFjQr5rtXCZiUU+D/PalgvHAD9HE/vINwuARB
	 8Yo11/gdkbCw/OwRlraXtp9KO0EBubd/rEBiwhNSQGhSCSCglAU1HxyPgnCNTKsSK3
	 0+DlnEZxblC37ydwYRVQDFMN1e+G5a2ueAKmKjhXJfY+c/G0ZMoDD6v/bVlRHuvL3H
	 IwX4vosCfAEvg==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.li@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hans Zhang <hans.zhang@cixtech.com>,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/4] PCI: dwc: Advertise L1 PM Substates only if driver requests it
Date: Tue, 11 Nov 2025 16:16:07 -0600
Message-ID: <20251111221621.2208606-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

This is a follow-up to Niklas's patch at
https://lore.kernel.org/r/20251017163252.598812-2-cassel@kernel.org.  That
patch clears the L1 PM Substate Supported bits for the dw-rockchip driver,
which doesn't yet do the device configuration to support the L1 Substates.

This series does the same thing, but in the DWC core so it applies to all
DWC-based drivers.  Drivers that do support L1 Substates (currently
tegra194 and qcom) indicate that by setting "dw_pcie.l1ss_support", and the
DWC core will leave the L1 PM Substate Supported bits alone.

This also includes Shawn's patches to add the dw-rockchip support for L1
Substates.

The problem this fixes is that users are currently able to enable L1
Substates, e.g., by

  - building with with CONFIG_PCIEASPM_POWER_SUPERSAVE=y
  - booting with "pcie_aspm.policy=powersupersave"
  - echo powersupersave > /sys/module/pcie_aspm/parameters/policy
  - echo 1 > /sys/bus/pci/devices/.../link/l1_1_aspm

but this breaks devices if the platform doesn't support CLKREQ# or lacks
Root Port configuration.  This series avoids that problem by preventing the
kernel from enabling L1.x in the first place.

Bjorn Helgaas (2):
  PCI: dwc: Advertise L1 PM Substates only if driver requests it
  PCI: tegra194: Remove unnecessary L1SS disable code

Shawn Lin (2):
  PCI: dw-rockchip: Configure L1sub support
  arm64: dts: rockchip: Add PCIe clkreq stuff for RK3588 EVB1

 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |  7 +++-
 .../pci/controller/dwc/pcie-designware-ep.c   |  2 +
 .../pci/controller/dwc/pcie-designware-host.c |  2 +
 drivers/pci/controller/dwc/pcie-designware.c  | 24 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 38 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c        |  2 +
 drivers/pci/controller/dwc/pcie-tegra194.c    | 35 ++---------------
 8 files changed, 78 insertions(+), 34 deletions(-)

-- 
2.43.0


