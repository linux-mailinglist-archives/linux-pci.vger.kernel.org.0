Return-Path: <linux-pci+bounces-29540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442FAD6F72
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B48097A853D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 11:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB0F221F34;
	Thu, 12 Jun 2025 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR2f9CzX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9158D1E1A16;
	Thu, 12 Jun 2025 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728988; cv=none; b=ng8Q2VvKibMJxFIoepc2CraommvbCN4NUBLOah7maYTqFpFIhvewTZS+K4WwkR8xksPjDSCzxenKrvNds4GrILrlpLabgRRnZR1xf0CJdbbnul1c0LkKQUA2ffKO41oyQ4vxbkFNLP8rL5rREHMq5UFglBL+cnnvAppnfGk2NaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728988; c=relaxed/simple;
	bh=njIe3vfl/yf5a86Ak2CvrAcNRqdijy5GYXgG3V1TR/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aqR7+L37H7q6DQ7s+KYDNgcMxLyoWVYwHIBDAVtFouGbUFpTSLzpTnKu4BtAC0q0Vv/BBkRCccU+gG68ASd2gxaoy5FUu8G7Zdln7J2/+Hnh9TzraumnTZjYItdYa0nDf8Kes+lCD+CrDkTcwiRkr3cT2J14nc1ZBo04uFZOCH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR2f9CzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61258C4CEEA;
	Thu, 12 Jun 2025 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749728988;
	bh=njIe3vfl/yf5a86Ak2CvrAcNRqdijy5GYXgG3V1TR/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=aR2f9CzX4sSdrcF01pGjRWKZr3p5X2TCpNofdfzPk+Whcf3aQIjbaVvLHASzaA8VR
	 Ahg5SQQTsjzoYwwndIrmsZJ6bhIVUH8WWsSBUgKyeN3lIabuKC4Tf7K74Ioqk1471x
	 AOw6553PZud0t0e23XIFz4uJujc1WAvGx1pkz6nIHaP2SvG3xBXUQqbVWZFP7Rq/a5
	 UCTpG3aw8C4bbWTW/CaHPTMHIKX9ngyp1qN9Y6PSYhQSLi8VM+duuZBcVuhJtRB5E7
	 FQ3ce7GO/0If2ta0VEmtQx/XLCTfgdXwisiGIqvB8xldCdqGEvTqUmOReDhv6MQCCp
	 cEhVg2r91nWoQ==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/5] PCI: dwc: Do not enumerate bus before endpoint devices are ready
Date: Thu, 12 Jun 2025 13:49:23 +0200
Message-ID: <20250612114923.2074895-7-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=cassel@kernel.org; h=from:subject; bh=njIe3vfl/yf5a86Ak2CvrAcNRqdijy5GYXgG3V1TR/Q=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDK89h3m2vVR+7+JaGj15ilvzx6Pt/HZqLl0zfpvcXVTK 76sln64raOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQAT2cLB8JutaP6tsqf56uE9 wuVTp1tNPtR5+TjbPw+7z1/Xs+9c5fqf4b/rVptpMlkFh7W2Wa4/pV9cHFEqwLR0+iI12RXOHJ/ /zWUDAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

The DWC PCIe controller driver currently does not follow the PCIe
specification with regards to the delays after link training, before
sending out configuration requests. This series fixes this.

At the same time, PATCH 1/4 addresses a regression where a Plextor
NVMe drive fails to be configured correctly. With this series, the
Plextor NVMe drive works once again.


Kind regards,
Niklas


Changes since v1:
-Put msleep() before the dev_dbg() that says "Enumerating bus" (Damien)
-Rewrite comment above LINK_WAIT_MAX_RETRIES / LINK_WAIT_SLEEP_MS (Damien)
-Remove comments above PCIE_RESET_CONFIG_DEVICE_WAIT_MS (Bjorn)
-Use different Fixes-tags (Bjorn)
-Shamelessly took Bjorn's commit message for patch 1 and 2 (Bjorn)
-Use PCIE_RESET_CONFIG_DEVICE_WAIT_MS rather than PCIE_T_RRS_READY_MS
-Add new patch (5/5) that drops PCIE_T_RRS_READY_MS


Niklas Cassel (5):
  PCI: dw-rockchip: Wait PCIE_RESET_CONFIG_DEVICE_WAIT_MS after link-up
    IRQ
  PCI: qcom: Wait PCIE_RESET_CONFIG_DEVICE_WAIT_MS after link-up IRQ
  PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link
    up
  PCI: dwc: Reduce LINK_WAIT_SLEEP_MS
  PCI: rockchip-host: Use macro PCIE_RESET_CONFIG_DEVICE_WAIT_MS

 drivers/pci/controller/dwc/pcie-designware.c  | 13 ++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  | 13 +++++++++----
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c        |  1 +
 drivers/pci/controller/pcie-rockchip-host.c   |  2 +-
 drivers/pci/pci.h                             |  7 -------
 6 files changed, 24 insertions(+), 13 deletions(-)

-- 
2.49.0


