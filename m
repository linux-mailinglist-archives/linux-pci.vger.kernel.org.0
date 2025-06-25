Return-Path: <linux-pci+bounces-30605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB2BAE7F25
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 12:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002F07B4750
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3914428E607;
	Wed, 25 Jun 2025 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSDzvOOt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB4927FD74;
	Wed, 25 Jun 2025 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847047; cv=none; b=Rwx7Kd6wkHeuYerd/brQhvV6drC2xGFMQDQwdXbzvztrXdgxy1TEiahUt3ly5CIKxL/W4XFDMcXQAm9/F/JxQMAB3Eo9QU1r+WLcmG0hvyj5I6+6RpvwGYFOX9HKtf2HM8JyCu8MmhtLyTnhZxGdCzy7X6bzznN22k5IEz9DjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847047; c=relaxed/simple;
	bh=lz4N5vzyJfYNDcEemSYn52O1R2oIT0tnhkw8QrN40KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgE13/BmOIVy48iwmhvolk3ZmQjvttLvFsX35iMW+Rqi+0+djktnr30lfxIFbeTHjVDxW4FG6+N1DK9PgvLUGK1AActxCnajyLvuzUKpCup8sqM3ctHiUYNVlP03Vz3tz8il8IzaJq1OsekdVOy1TNNdQ/bC4zkB8oa895QD9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSDzvOOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8C6C4CEEA;
	Wed, 25 Jun 2025 10:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750847046;
	bh=lz4N5vzyJfYNDcEemSYn52O1R2oIT0tnhkw8QrN40KI=;
	h=From:To:Cc:Subject:Date:From;
	b=HSDzvOOt9QZbS5sSeRxHGHrTd0sVPRkyhyqCW7IKD2PNZ1YzXJPHMfg8IYKi3sMpo
	 j548/ZgmsJ7BslOPqlVlZYPBwqg6TjQcwogidxU51Au8pV2SfffpUYMuRpoWDn8mgd
	 SKl76C1UHM+Hpxgv7lcBBdf6McMMjDq6GK+e8N+YZsbSgov2/srVckeCLyYs67zMkX
	 iUW7jgc8Hytdj98nvWO3Z+DZjIfZFNUI/ajjzvy4BEzzuW3Oci55OtylUob6uf/Zo+
	 w2zrhh0TOmSHcCac0MrnUyXet9ZChvtZfCVmRzvmSyYb3mXWapNBwuQD1d+Z1iAlLu
	 UOsM4AVRsD8Cw==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Simon Xue <xxm@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 0/7] PCI: dwc: Do not enumerate bus before endpoint devices are ready
Date: Wed, 25 Jun 2025 12:23:46 +0200
Message-ID: <20250625102347.1205584-9-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=cassel@kernel.org; h=from:subject; bh=lz4N5vzyJfYNDcEemSYn52O1R2oIT0tnhkw8QrN40KI=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKizxk/Urnx8TPnvbnLnkcwKCgxv3jWYLPqsYZuQPTEv d+8/tQ0d5SyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAi7M8Y/ocbbdYsPTl7z+zN d9fZBVcKMboJlm67/mwNc3B8QeOROS8ZGaZ1Rf9wLPh41sPfj7/z8ckMxYfG6yp59Ixa32zzWF+ vxAgA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

The DWC PCIe controller driver currently does not follow the PCIe
specification with regards to the delays after link training, before
sending out configuration requests. This series fixes this.

At the same time, PATCH 3/7 addresses a regression where a Plextor
NVMe drive fails to be configured correctly. With this series, the
Plextor NVMe drive works once again.


Kind regards,
Niklas


Changes since v3:
-Move LINK_WAIT_MAX_RETRIES and LINK_WAIT_SLEEP_MS to pci.h (Mani)
-Only wait PCIE_RESET_CONFIG_WAIT_MS if > 5 GT/s (Mani)
-Fix nit in commit log (Mani)


Niklas Cassel (7):
  PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to
    PCIE_RESET_CONFIG_WAIT_MS
  PCI: rockchip-host: Use macro PCIE_RESET_CONFIG_WAIT_MS
  PCI: dw-rockchip: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
  PCI: qcom: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
  PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link
    up
  PCI: Move link up wait time and max retries macros to pci.h
  PCI: Reduce PCIE_LINK_WAIT_SLEEP_MS

 drivers/pci/controller/dwc/pcie-designware.c  | 20 +++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.h  |  4 ----
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c        |  1 +
 drivers/pci/controller/pcie-rockchip-host.c   |  2 +-
 drivers/pci/controller/plda/pcie-starfive.c   |  2 +-
 drivers/pci/pci.h                             | 18 +++++++++--------
 7 files changed, 30 insertions(+), 18 deletions(-)

-- 
2.49.0


