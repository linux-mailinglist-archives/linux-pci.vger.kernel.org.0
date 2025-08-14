Return-Path: <linux-pci+bounces-34047-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D33DB26ABC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C317BBE8A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C6720FAB6;
	Thu, 14 Aug 2025 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNWpmuQK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C132746C;
	Thu, 14 Aug 2025 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184908; cv=none; b=A0P7PCVJxWv+2zgGfqEp6UpmyQpschxY/yM5HxpDQi2/0bobQyeuyfGbf9RHnOblaZ0TlWdpvcUd8VGNVVPYyZdsgT2nocwbNuKtuacrr64BFS7j8lo9EzHTN5bMGT3tiggtrRG/FQYGxaEPc3WPl3Df59AvzEUQ2Rgt2Hvzo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184908; c=relaxed/simple;
	bh=BxH6frzEx2Nl3V2ClnA48ry3Dd7sJkgks2idYBbkBRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0yvrtelycN5FO52UIXcQj+nEbyhl/3TCMQdFiwNsdWW14Rj7NYPhL2YZOBmxO0SdoxE66jvVETCVZuTHMnp0iKJImF6mwjc7hSR2OFwLqKtmYb8MuOUdgfy99fQojE7fBOUU52dKj1tG9Cu5dosQwz2l40MKXfaOg4E/MSgvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNWpmuQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CBDC4CEED;
	Thu, 14 Aug 2025 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184908;
	bh=BxH6frzEx2Nl3V2ClnA48ry3Dd7sJkgks2idYBbkBRI=;
	h=From:To:Cc:Subject:Date:From;
	b=iNWpmuQKfgFHOHkXVDC2foQTi3+J+peXo2P1+gHRDe4BfU1c99GqsNMzEY/U6LPvH
	 50j+Wm0cqy3iul7p7cdbh9W/VRa220LYzlGK/JGMnJU2p65iwV+8Y2TJcocMZqYT/y
	 CbuMvlQWDwQmzyQJvQm1uNz/fo9Sbz5j4/mPSIMjdrbHf4UnKCAbH1TF8yqAtB2Ckd
	 1k16TQ4se2ILx02IeaOKovaGBCaWbFJ8/fGmCudak3Q6z1MpiZVgE8pIgCabCYJQbo
	 0jG10pkamtAmu/qxmbaKY7kfqDCjaPS8Tgns41D5X1Yfljr2OMr/40zY/QZL2hijLS
	 TyPbFNyxu1orw==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-arm-kernel@axis.com,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: [PATCH 00/13] PCI: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:19 +0200
Message-ID: <20250814152119.1562063-15-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2026; i=cassel@kernel.org; h=from:subject; bh=BxH6frzEx2Nl3V2ClnA48ry3Dd7sJkgks2idYBbkBRI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vvApNE/bZPy/8YKh26Pres/ct7tSfT5wTUv13x/f 99CNZ1vHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZiIJR8jw/ZnrL9lb2jOOcXT LTbpfry0xJMNyfXGl2/+3bF76tk7VtsZGZ4cq779xajRP4xPaPftGJbfzr+WH3wo5bTo2sEIvbs LfvIBAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Series is based on pci/next.

Feel free to squash to a single commit if that is preferable.

Kind regards,
Niklas


Niklas Cassel (13):
  PCI: cadence-ep: Drop superfluous pci_epc_features initialization
  PCI: rcar-ep: Drop superfluous pci_epc_features initialization
  PCI: rockchip-ep: Drop superfluous pci_epc_features initialization
  PCI: dra7xx: Drop superfluous pci_epc_features initialization
  PCI: imx6: Drop superfluous pci_epc_features initialization
  PCI: keystone: Drop superfluous pci_epc_features initialization
  PCI: artpec6: Drop superfluous pci_epc_features initialization
  PCI: designware-plat: Drop superfluous pci_epc_features initialization
  PCI: dw-rockchip: Drop superfluous pci_epc_features initialization
  PCI: keembay: Drop superfluous pci_epc_features initialization
  PCI: qcom-ep: Drop superfluous pci_epc_features initialization
  PCI: rcar-gen4: Drop superfluous pci_epc_features initialization
  PCI: tegra194: Drop superfluous pci_epc_features initialization

 drivers/pci/controller/cadence/pcie-cadence-ep.c  | 2 --
 drivers/pci/controller/dwc/pci-dra7xx.c           | 1 -
 drivers/pci/controller/dwc/pci-imx6.c             | 4 ----
 drivers/pci/controller/dwc/pci-keystone.c         | 1 -
 drivers/pci/controller/dwc/pcie-artpec6.c         | 2 --
 drivers/pci/controller/dwc/pcie-designware-plat.c | 1 -
 drivers/pci/controller/dwc/pcie-dw-rockchip.c     | 2 --
 drivers/pci/controller/dwc/pcie-keembay.c         | 1 -
 drivers/pci/controller/dwc/pcie-qcom-ep.c         | 1 -
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 2 --
 drivers/pci/controller/dwc/pcie-tegra194.c        | 2 --
 drivers/pci/controller/pcie-rcar-ep.c             | 2 --
 drivers/pci/controller/pcie-rockchip-ep.c         | 1 -
 13 files changed, 22 deletions(-)

-- 
2.50.1


