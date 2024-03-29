Return-Path: <linux-pci+bounces-5373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF41A89153B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 09:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1381F1C2234F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 08:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C9C6AC2;
	Fri, 29 Mar 2024 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIpxnTV3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466EDE545
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 08:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711701851; cv=none; b=MjZfPZVyhoufFHF2EIJ9d9oBS6sWqU/6Eorb7ZK8z2OrzxLN/LDNHMhU4RI0PiEdbZMBlA9+Oh2vOVY85ocud/twiH30VHzhLdUm1VtI/IHk4oFD7H1HC0jpSBzf4Tp+BudyLhzQHAMjapusQdJlzkFe5fwL7WijNogQ4xRZ2+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711701851; c=relaxed/simple;
	bh=b6rn6CCukcXUENMWI2jflkbWvCdoMCgXAAuXqt6upD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNVJre9xfUwG4U+7Sf0upd91NE6F/B1i8Y/2plyWqrnJL97Lnl4BrvHew5hYrhuVpqkPTz8cq79/Ik1K7cm+wCvTuZnLUCYvbOUWrqujEFbWK7/0ILknn6aMqSWENgqZjo+LhPyApIYmOfl1qqoWZmhWEhN9EsFD0J6Q3PcjcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIpxnTV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA49C433C7;
	Fri, 29 Mar 2024 08:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711701849;
	bh=b6rn6CCukcXUENMWI2jflkbWvCdoMCgXAAuXqt6upD0=;
	h=From:To:Cc:Subject:Date:From;
	b=dIpxnTV3O6ShgwfSYQMGIX9zsZ73Ft2dFsUQUP4HpbfZR9FKo+UMCUlSfr3AvQRR/
	 eWquhL8swJg2Zq4tOfCoF8p3ZfWBsYp03RWdgWs10JjNbx3l+IhjAdiMhdmcTl0vO/
	 t7Gyr+o/fCPs6niNq/EDMcrlGdYFLtuJRgBckUxjqf/0f82mjWcsv+uDHe8bLSheUV
	 10L1pcjEBdGXZ6sj5Al7k0l4oJEh4r2b783aT+OnG3HP3sJ2dIQABDU+aVHX/XhKEJ
	 y7oRNepdpaYhai0XzbLfzk9dVuDL3E2CFYZETFs10wf26SUDRcowgYIJQcyc3GXvPA
	 KatP+d0CmWtpQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Subject: [PATCH] PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST handling
Date: Fri, 29 Mar 2024 17:44:07 +0900
Message-ID: <20240329084407.1050307-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI specifications mandate that PERST be asserted for at least
100ms. Make sure that is done in rockchip_pcie_host_init_port() by
adding a 100ms sleep before bringing back PESRT signal to high using the
ep_gpio GPIO. Comments are also added to clarify this behavior.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 300b9dc85ecc..d526b9d26c18 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -294,6 +294,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	int err, i = MAX_LANE_NUM;
 	u32 status;
 
+	/* Assert PERST */
 	gpiod_set_value_cansleep(rockchip->ep_gpio, 0);
 
 	err = rockchip_pcie_init_port(rockchip);
@@ -322,6 +323,11 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
+	/*
+	 * PCIe specifications mandate that PERST be asserted for at
+	 * least 100ms.
+	 */
+	msleep(100);
 	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
 
 	/* 500ms timeout value should be enough for Gen1/2 training */
-- 
2.44.0


