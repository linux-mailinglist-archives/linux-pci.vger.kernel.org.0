Return-Path: <linux-pci+bounces-16956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E33B59CFD3B
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 09:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CDA280FCB
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 08:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30F438382;
	Sat, 16 Nov 2024 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1ukALJL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942520DF4;
	Sat, 16 Nov 2024 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731745153; cv=none; b=uG6Gh6+czUIytIGREvUKkXMJPnCFK42jwYAy0W8ue+c5aMup+sG29WkeSa0xppAQ5YVjZFFi6KK4K5EqCcn6YvNDkXjiZ5srvbDqxXVDzmCnij6ftGlHZHHhoc0pdk63hdnTrTDVCHFkowuhGwpMzQIUtPynxyrOR6QIUyPgTkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731745153; c=relaxed/simple;
	bh=ZPcVkadjDBIH9KyjVVtehzPEyudewRBoJZnsUiPtHcs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mg2TpPsmLB/S+iAIXBQugV2ogrT2jWDu7k+uDEjrtavBimiSO3PgWAEENqmkSc3Yf0V+8DDMcm1B0m0zCUoyJUfyNplsKkhy1cvV41WKCA0mC+XxGpkP6SIZvoKBIjA70KlMEBx88lkKIxxX1U14n0NkEveOhtpQiRzzee4Xoc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1ukALJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBA0C4CEC3;
	Sat, 16 Nov 2024 08:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731745153;
	bh=ZPcVkadjDBIH9KyjVVtehzPEyudewRBoJZnsUiPtHcs=;
	h=From:Subject:Date:To:Cc:From;
	b=l1ukALJLq9djPcjX4RZX6DMrZfpGgYA09IdhhK6+OGzRNAWhBAYxuUwR8TkLIWtFH
	 WrcgAkmJjiUqu3r1inlGlPL3/7NlwBASO3o+yn/e2lsLIawTCLuwQKfXZvyj0e7WM5
	 3K57zhPE7Q1ILvzovVtOpgja7vLQE09/xfq/cIzkk+MQ+q9DQCrgDswoCqOGfXTPp3
	 MUkrXzCIUfJZXl6dQxjzNazcDuhZCe9lEGc0JN6vaMqx0r1MkXp8AL77GXJUchvN5s
	 nFPnp2wwKEvo7BtDIASih/0/TdE9mtX4C+z1gaNT/iY4JHUjUnB/TE2/q2EN/LgCO2
	 4Lzqrl6Ovd+4Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v3 0/6] PCI: mediatek-gen3: mtk_pcie_en7581_power_up() code
 refactoring
Date: Sat, 16 Nov 2024 09:18:21 +0100
Message-Id: <20241116-pcie-en7581-fixes-v3-0-f7add3afc27e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1VOGcC/33NQQ7CIBAF0KuYWYuBoUhx5T2MC0KHlmhoA4Zom
 t5d2pUmxuX/k/9mhkwpUIbTboZEJeQwxhrkfgdusLEnFrqaATk2QnDNJheIUdSqFcyHJ2WG5qi
 48h1KJaHupkTboc4u15qHkB9jem0viljbf1oRjDPruWs1SpROn2+UIt0PY+ph5Qp+EuYXgZXgZ
 KVtrDem8V/Esixv6F0A+PYAAAA=
X-Change-ID: 20241107-pcie-en7581-fixes-296505fd2353
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Minor fixes and code refactoring in mtk_pcie_en7581_power_up() routine

---
Changes in v3:
- add trivial patches 5/6 and 6/6 to the series
- rename err_clk_init in err_clk_prepare_enable
- fix commit log for patches 2/6 and 3/6
- Link to v2: https://lore.kernel.org/r/20241109-pcie-en7581-fixes-v2-0-0ea3a4af994f@kernel.org

Changes in v2:
- added trivial patch 4/4
- improved commit logs and comments
- introduced PCIE_MTK_RESET_TIME_US macro
- Link to v1: https://lore.kernel.org/r/20241107-pcie-en7581-fixes-v1-0-af0c872323c7@kernel.org

---
Lorenzo Bianconi (6):
      PCI: mediatek-gen3: Add missing reset_control_deassert() for mac_rst in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: rely on clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: Move reset/assert callbacks in .power_up()
      PCI: mediatek-gen3: Add comment about initialization order in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: Add reset delay in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: rely on msleep() in mtk_pcie_en7581_power_up()

 drivers/clk/clk-en7523.c                    |  1 -
 drivers/pci/controller/pcie-mediatek-gen3.c | 60 +++++++++++++++++++----------
 2 files changed, 39 insertions(+), 22 deletions(-)
---
base-commit: ac9626f643ea9cde795811d924388fa49f2c4c0c
change-id: 20241107-pcie-en7581-fixes-296505fd2353

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


