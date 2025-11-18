Return-Path: <linux-pci+bounces-41538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD38DC6BBD4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 22:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E95F4E30C4
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A3B3093C9;
	Tue, 18 Nov 2025 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fyr+5b1i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2E305067;
	Tue, 18 Nov 2025 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502198; cv=none; b=W9rqFfObfMOezzZqVb4QseQl3F8Xj5fZLTfh+uxITW0F7sLQeOAsjT2AvVmsC1r2fLinKzabyI//eyiBkmQBlXrxip/e2Nb+Se0A/vZ8jCjerF1FlFb5VR/skAlEMk+1NPkXKW2VUr9doVKVPed140C/fJMrYtAwFUIX1qycEn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502198; c=relaxed/simple;
	bh=/DccbKxo0GnChl0C4CIrCj7Yv1sCs/9h37/YbO1FOhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4By+T9LN6g5tAnAl3pRipIcE6kYkbtqbxg2tpkcnI+ZYXD3JjgHrHHHGMst8xkSTYI5tQYMVkolH21kFj21YSQgnmnj4xYPTgJ4h9ucnWP57kuteNxtVTf0fO5z4rzzqGWVE/j8/LlD3/GThhDAq0e00esn6uAwteHuicVSXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fyr+5b1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA5EC116D0;
	Tue, 18 Nov 2025 21:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502197;
	bh=/DccbKxo0GnChl0C4CIrCj7Yv1sCs/9h37/YbO1FOhc=;
	h=From:To:Cc:Subject:Date:From;
	b=Fyr+5b1ioHIeLhruTgMZkGBFVJxUB2oLgyjAaqAPof7E+l81wsBvvAgQXLALgur/G
	 sdW6SzakuazlI7jfz2o5EuyliPlZI6jtYVOvzZeN5HKcGvTugn36M5q/fV5ryci2w6
	 5MEx/1IFXpP79/mxWJmTYfsdqdQIvXT1GeqblkeXq0nC0x5jWRCUEfasZX8esesa1A
	 V1BuZOGMemWf22F8MxLOrtf6WmBJzO2gnKNuCo8MoGgXZFYI2y5erH5z64T1PsSOl/
	 QFA6uRjpV66DA7FnPvvxl3m4wRVtlU0o4aLqM/Kmra9OYsqFThkLSmuqfzTVaTNXLF
	 VGTfqqAvccj4Q==
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
Subject: [PATCH v2 0/4] PCI: dwc: Advertise L1 PM Substates only if driver requests it
Date: Tue, 18 Nov 2025 15:42:14 -0600
Message-ID: <20251118214312.2598220-1-helgaas@kernel.org>
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
  PCI: dw-rockchip: Configure L1SS support
  arm64: dts: rockchip: Add PCIe clkreq stuff for RK3588 EVB1

 .../boot/dts/rockchip/rk3588-evb1-v10.dts     |  7 ++-
 .../pci/controller/dwc/pcie-designware-ep.c   |  2 +
 .../pci/controller/dwc/pcie-designware-host.c |  2 +
 drivers/pci/controller/dwc/pcie-designware.c  | 24 ++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  2 +
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 40 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom.c        |  2 +
 drivers/pci/controller/dwc/pcie-tegra194.c    | 48 ++++---------------
 8 files changed, 85 insertions(+), 42 deletions(-)

-- 
2.43.0


