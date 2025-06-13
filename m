Return-Path: <linux-pci+bounces-29686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6F2AD8C77
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5010E160E25
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 12:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D679F5;
	Fri, 13 Jun 2025 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FW65r17W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93D275B1C;
	Fri, 13 Jun 2025 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749818942; cv=none; b=tM6TFq1PET2NzGjnZfpBmWnZKBfCSeRuR+ocgfPTVhAjZKwfk3s4mhCIURX1qBvfwe00np3NhOAxOp/QqgEbeixGXh2TAEmJBow9MQd/a+qqyWIPgkJBzg4h31EzqF5mDbzvLhfjR0lgbYHk2Vvt2H5sBk3iWSUni8nL2LrD5hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749818942; c=relaxed/simple;
	bh=lY5lvyrHBT8EJhIYRpQOHfrFcbIbm6kOsukAGhdT2Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QgDuGwmcTJUYCHZ10x/vTm5vBUVkI0ZjVnBaz6ZcYt8zKDWz9vneT3mQMmyxkCM8YNmvAVimyI3yGrD8IidNoB3hLbhtWWn1aqCUXJ/w8V+PztlnNYQqIMSPp3S9ctRXnaadKYigg9SEQqZnheZlwFJklkcVhaxaLb/JThkjpBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FW65r17W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D874C4CEE3;
	Fri, 13 Jun 2025 12:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749818942;
	bh=lY5lvyrHBT8EJhIYRpQOHfrFcbIbm6kOsukAGhdT2Iw=;
	h=From:To:Cc:Subject:Date:From;
	b=FW65r17WdfE6MjArMQkRm2oxVaGHClYP3au0iY0ESm8NFdHCdHTkpaX8zT/5tDSUq
	 ruQq5dTqczynLIxxiw+xOdqMlqFYESrYBtJlV4vqB/LXH82lyLRb3JhG9LZ9leNSS8
	 qGPKog3L9/qaSzPlWccN/IGphxzBjLeHGcuHowsDgH2Mezh6MrSTxCKDuV2FAnjOod
	 inBkUPIPSYyJ8rI0xzogm2Fdl43W7/LvGHZ5MDL7UCnbUSplDINyr3VUcx5j5inM3U
	 IvDVHZlHzg28GtVUUN3/Nax3EBvQoEUyaUXeI3bVw2LGiq4bEFhFLqvusO7EfPJcx4
	 CfW9ECGFl2vaQ==
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
	Kever Yang <kever.yang@rock-chips.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Niklas Cassel <cassel@kernel.org>,
	Simon Xue <xxm@rock-chips.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 0/6] PCI: dwc: Do not enumerate bus before endpoint devices are ready
Date: Fri, 13 Jun 2025 14:48:39 +0200
Message-ID: <20250613124839.2197945-8-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417; i=cassel@kernel.org; h=from:subject; bh=lY5lvyrHBT8EJhIYRpQOHfrFcbIbm6kOsukAGhdT2Iw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJ85NRffhTk2R4SM+P3h8I+tijv6m7n4w13Euerrpk9f e9XZ9/tHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhIRSjD/6j9+h0uZlbzp8pb 7j19de6r57L8sntMOdLKTyn/P1+7Opfhf+66vkW8cgGmrUqLNlW6JG01mpDXmtxhuEOwaEOSjLs HPwA=
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


Changes since v2:
-Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS.


Niklas Cassel (6):
  PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to
    PCIE_RESET_CONFIG_WAIT_MS
  PCI: rockchip-host: Use macro PCIE_RESET_CONFIG_WAIT_MS
  PCI: dw-rockchip: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
  PCI: qcom: Wait PCIE_RESET_CONFIG_WAIT_MS after link-up IRQ
  PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after link
    up
  PCI: dwc: Reduce LINK_WAIT_SLEEP_MS

 drivers/pci/controller/dwc/pcie-designware.c  | 13 ++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h  | 13 +++++++++----
 drivers/pci/controller/dwc/pcie-dw-rockchip.c |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c        |  1 +
 drivers/pci/controller/pcie-rockchip-host.c   |  2 +-
 drivers/pci/controller/plda/pcie-starfive.c   |  2 +-
 drivers/pci/pci.h                             |  9 +--------
 7 files changed, 26 insertions(+), 15 deletions(-)

-- 
2.49.0


