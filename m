Return-Path: <linux-pci+bounces-6160-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B198A23D0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 04:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EE61F23AD1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 02:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACD2322B;
	Fri, 12 Apr 2024 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtw3AC77"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E4E7EF
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889446; cv=none; b=FjW3Ynnwxami0S2TKjUzlpiaDst8Zjmbs/Ng8CJtuIpgN+AFpzeIAju3jt713LZBUIkfNwsny8wxxqrsgr7Qe/Z4EHUNPUzg9ns9QoCwvW4Bv+GkuzYmtYafWWKKL1L21Ncw8z2K/wSAkbl4+Hgll4dtooKlZn6ZXofSaa6d8kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889446; c=relaxed/simple;
	bh=2Pm+KvVtx+Rp3GxiSajmnx2imcEuNTM/DMGG9mYaQDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWhyPAGpb9E7kdKmKQgjHLVYgeN4ezjNJjKfOhpBW9gL6dZDilvPzWvna3R34FBqt4Trxn0/g1sZ3bwjz5zE/mxPxaYx77KvcUF9o373eMXSzZOnS06fvvQgsELeY/xftNZuwd2mF4IwTLiXP0fWo7G7acxWQxune7DyiwQ2/3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtw3AC77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046D5C2BD10;
	Fri, 12 Apr 2024 02:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712889446;
	bh=2Pm+KvVtx+Rp3GxiSajmnx2imcEuNTM/DMGG9mYaQDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtw3AC77hdVPhPhnSGFX+Pq+rVHdX4/izbfWTNrU7/ZYbJ/1FYg64KF8PuxTQNIMI
	 3V3YgKHQp/hP3iwZGGSFMYNkzZ/WqsIw8UusWKoR5RNBM+ASRVz86WMXO25EfUEpL0
	 oa0RAhZtMjfK7gN1r21bv80bZsTNNjoaBe9nQy4VP98M+jteI66g4CxUE+wkVJ18F0
	 WJac1DWu2pA6FrC/Jgxe0SBu52L4soK29D6wnMQJoXfXf4Jq6XXAqKw59waF9HFr1F
	 AXJ7sAdhhSqNXpXKn7dNFZb6hM0CoOYAtHY2IHM+efrGw3Yx4YY7w7PxZcxIlyxrNX
	 qQ2NT7OOn3SMQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST# handling
Date: Fri, 12 Apr 2024 11:37:20 +0900
Message-ID: <20240412023721.1049303-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412023721.1049303-1-dlemoal@kernel.org>
References: <20240412023721.1049303-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe specifications (PCI Express Electromechanical Specification rev
2.0, section 2.6.2) mandate that the PERST# signal must remain asserted
for at least 100 usec (Tperst-clk) after the PCIe reference clock
becomes stable (if a reference clock is supplied), and for at least
100 msec after the power is stable (Tpvperl, defined by the macro
PCIE_T_PVPERL_MS).

Modify rockchip_pcie_host_init_port() to satisfy these constraints by
adding a sleep period before bringing back PESRT# signal to high using
the ep_gpio GPIO. Since Tperst-clk is the shorter wait time, add an
msleep() call for the longer PCIE_T_PVPERL_MS milliseconds to handle
both timing requirements.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 300b9dc85ecc..fc868251e570 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -322,6 +322,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
+	msleep(PCIE_T_PVPERL_MS);
 	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
 
 	/* 500ms timeout value should be enough for Gen1/2 training */
-- 
2.44.0


