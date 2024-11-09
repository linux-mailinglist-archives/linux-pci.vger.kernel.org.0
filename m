Return-Path: <linux-pci+bounces-16369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5129C2B5A
	for <lists+linux-pci@lfdr.de>; Sat,  9 Nov 2024 10:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4DD71C20F17
	for <lists+linux-pci@lfdr.de>; Sat,  9 Nov 2024 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E50D145A16;
	Sat,  9 Nov 2024 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQLPw9EK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1068D145B27
	for <linux-pci@vger.kernel.org>; Sat,  9 Nov 2024 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144560; cv=none; b=AkVORKcawhl83teH1Im6ccliAJ1dowfx80nfgoaPng6MG1jR4RNZN4wPd8IsBRTU04i+aQiM0pdhqghwwIK8nKmBIUMiGEdwB/wTdjjX+IR/r5phn6JEcWWTq8bIphuDKxJyrG+T5z6tEWFCAAPTwZK+sLs+IMN3tBuLy54drhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144560; c=relaxed/simple;
	bh=dDj9mrjWKbOOETt8VRpVNkCmAIG4TU3oYP0/ohENJWs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CPHsOpDGBrM0N9o/GtT5UQr6N33siI0WYaWK5eTfgkebR68aUJ4wYYBhkBuQT8VOci09lTp7d6uzJ5A590+cD4Npc56VAI8faNw6xa4FmNj/oOG1NUppnZ+j4iE6mP/fWEKTpG/DSjkoBBsOKnGpb9UiJWvesQpQ7ki30VQWJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQLPw9EK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF91C4CECE;
	Sat,  9 Nov 2024 09:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731144559;
	bh=dDj9mrjWKbOOETt8VRpVNkCmAIG4TU3oYP0/ohENJWs=;
	h=From:Subject:Date:To:Cc:From;
	b=DQLPw9EKEfEtQmtv+k/c+ds8BRCFi29dZxoKL2WohYN1LEcsjY4dhh1LQJosaJhhQ
	 KxuTaaHAbktGJrDokEv8HS3DY+3tScMkptNXkrNQgIwP7MmZOSmUtza0t/l2TToOoe
	 IOTn7rHBaN7J3JsPzl59wV0eL0duon5JoHbPzTx6lZhUzfLzX2XAy+4SOpRLOf3MjM
	 5IQgTaz1UJsqninxOi+stL+IjJRXG/8DWGH1CT20eEPZ6m+6hijVgeKRJkiwo+R3Ii
	 oYEpybXeo+B7UdTihddN8IoUYmWE2ZK87qQ+kh5cGx/gpj3QifiGET6NNF5NTvfL2x
	 b5xitrXCBAGMQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2 0/4] PCI: mediatek-gen3: mtk_pcie_en7581_power_up() code
 refactoring
Date: Sat, 09 Nov 2024 10:28:36 +0100
Message-Id: <20241109-pcie-en7581-fixes-v2-0-0ea3a4af994f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQrL2cC/32NQQrCMBBFr1Jm7UgyMaa68h7SRUkn7aAkJZGil
 N7d2AO4fP/z/l+hcBYucG1WyLxIkRQr0KEBP/VxZJShMpCik9bK4eyFkaOzrcYgby5Il7NVNgx
 krIHqzZn3omr3rvIk5ZXyZ79Y9C/9t7ZoVNgH5VtHhox3twfnyM9jyiN027Z9AekVyfazAAAA
X-Change-ID: 20241107-pcie-en7581-fixes-296505fd2353
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Minor fixes and code refactoring in mtk_pcie_en7581_power_up() routine

---
Changes in v2:
- added trivial patch 4/4
- improved commit logs and comments
- introduced PCIE_MTK_RESET_TIME_US macro
- Link to v1: https://lore.kernel.org/r/20241107-pcie-en7581-fixes-v1-0-af0c872323c7@kernel.org

---
Lorenzo Bianconi (4):
      PCI: mediatek-gen3: Add missing reset_control_deassert() for mac_rst in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: rely on clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up()
      PCI: mediatek-gen3: Move reset/assert callbacks in .power_up()
      PCI: mediatek-gen3: Add comment about initialization order in mtk_pcie_en7581_power_up()

 drivers/pci/controller/pcie-mediatek-gen3.c | 50 ++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 19 deletions(-)
---
base-commit: 3102ce10f3111e4c3b8fb233dc93f29e220adaf7
change-id: 20241107-pcie-en7581-fixes-296505fd2353

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


