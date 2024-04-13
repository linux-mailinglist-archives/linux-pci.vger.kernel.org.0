Return-Path: <linux-pci+bounces-6208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFBB8A396A
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 02:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1131C211CE
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 00:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135CE1847;
	Sat, 13 Apr 2024 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4r5SxP6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E464517FE
	for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2024 00:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712968885; cv=none; b=gjtvgqH2IiH8ZYgZrfy4Z+0diWLL9mso3QHSHosuHpnn4FZDQpv65fcZZ9Uvopf23PjD0UrS/leS3eyT8OkNF3aByXhkqQ3g9W1DzwaNv4FSUdIx0jyfdPQ1y63rpFuHg869Lx9H3row1xkRQnKKvWfhVW8FlrKbEceHn6JWRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712968885; c=relaxed/simple;
	bh=XpYhNOv4ZHsSL532m9ktfz4Uqkztrb/PULdnHkhHXSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTD/uLLWmybnKJ1BxiFEQlSwCV9XdadGAIJzi33LBsNvxVVAlwHXBdVstoc5OrO+0U8PNQLPciTDM1q468S/f1AFOroJzR6UmxkL18KSK1IGNaBlFY8PhxvNlVkmBKSa2od+ruAn0fLtwIpHzljJqV+hPUSong3kVuZIByW1a6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4r5SxP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63620C2BD10;
	Sat, 13 Apr 2024 00:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712968884;
	bh=XpYhNOv4ZHsSL532m9ktfz4Uqkztrb/PULdnHkhHXSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4r5SxP62X6JE4fUhs5yNnHIfrZy75SUM1MNtonnbzhKUAW3oYbKH2AhoxBYRZNgY
	 arclyENZfljBegg9gEnS/N1RxmWef0toYsmRtXT9jAvcQPTO82PKczPVIr98nlu+8n
	 U8WRtt9vwTuOIjE2rC7RSxDS00BTC2emIPONu6x/8BgfM90mSZoeYKuaaY9Bc5pz7Z
	 7h7Mi9c3hW3fphmz/dFH1ddSdccM5xkJip5aRXmS8f0ySI6AfofS5/U6HJDbd6rp9k
	 ojue8bHQkJgrK7xVu65ZfATou3Lx11bWloe17vAz06HqOEAdfCZLNLE/s1O/hEpWxu
	 ojxrb2i/5ro5w==
From: Damien Le Moal <dlemoal@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/2] PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST# handling
Date: Sat, 13 Apr 2024 09:41:19 +0900
Message-ID: <20240413004120.1099089-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240413004120.1099089-1-dlemoal@kernel.org>
References: <20240413004120.1099089-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe specifications (PCIe CEM r5.1, sec 2.9.2) mandate that the
PERST# signal must remain asserted for at least 100 usec (Tperst-clk)
after the PCIe reference clock becomes stable (if a reference clock is
supplied), and for at least 100 msec after the power is stable (Tpvperl,
defined by the macro PCIE_T_PVPERL_MS).

Modify rockchip_pcie_host_init_port() to satisfy these constraints by
adding a sleep period before deasserting PERST# using the ep_gpio GPIO.
Since Tperst-clk is the shorter wait time, add an msleep() call for the
longer PCIE_T_PVPERL_MS milliseconds to handle both timing requirements.

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


