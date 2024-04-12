Return-Path: <linux-pci+bounces-6161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB3A8A23D1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 04:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201631F23AC6
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 02:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B813010957;
	Fri, 12 Apr 2024 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/dYubeg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CE7EF
	for <linux-pci@vger.kernel.org>; Fri, 12 Apr 2024 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889447; cv=none; b=VXW71ZJrz0KhAoG5zmvDR6X9H5TuU4ttTOvNiEyGdJFTQTOe73brZLXTFmx6082TziMaELQjRJ5GDbKJWOgOtSeoA+Xe2h+jd0MQDQST1r617KdvEayfGnzKhoML4mncuUgsfErQkuCQdHzoUGQ7LIYZRzcvQKJlm9jjqDQBDL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889447; c=relaxed/simple;
	bh=I7Um91ihJEBjAcgbJPQ4e+rjRLE/Ij77urBAYeI8Q6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQNmEjKbZuKDqDOGHiHc1pSKJMA0M12THYYr/O3qLtKJebiedGhYr3wEcL5GN1rhPfe0lZMhzs6bpW1163mBDepJ5Vbfwh32bWWmez84oEHdiALetByDAnmMz0F6jWdKqZA+4BXTnr0uqnR/f2W3cWkJjgDY1V9W5gC0b2fAE2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/dYubeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1ECC072AA;
	Fri, 12 Apr 2024 02:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712889447;
	bh=I7Um91ihJEBjAcgbJPQ4e+rjRLE/Ij77urBAYeI8Q6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/dYubegiZ4gf3MSr9DjSLRSlMwresgXdJBUh8US9olY4PxM6bGUT+2r3CDlmo6mU
	 BKOgJ50S5Ak/DUl5d03Tb01FyRn1DdkY1bvuAdQhM9cwnq042n8n8jgCo9lLdXug9g
	 DTIKap5eXU9RycMKbgnXldtKP8NqKBtn0hOQ7R+bkuABT4PwaCowYpdBAYYXyg1Pb8
	 48T+yh69oeEzAEqPkSDSKCPxo+iuhISC2LL2Yj+SbDjZMa8jeFfd5r4zGa1twRXV3l
	 /PGgpdTeYmzwV/MBZJ+34trEPIfePCa03cn5vsjkaFLWiwLoCBbmqhotNXp4jpvjRG
	 mUAMThciy507A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/2] PCI: rockchip-host: Wait 100ms after reset before starting configuration
Date: Fri, 12 Apr 2024 11:37:21 +0900
Message-ID: <20240412023721.1049303-3-dlemoal@kernel.org>
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

The PCI Express Base Specification r6.0, section 6.6.1, states that the
host should wait for at least 100 msec from the end of a conventional
reset (PERST# is de-asserted) before sending a configuration request to
ensure that the device is able to respond with a "Request Retry Status"
completion.

Add the PCIE_T_RRS_READY_MS macro to define this wait time and modify
rockchip_pcie_host_init_port() to add this 100ms sleep after bringing
back PESRT# signal to high using the ep_gpio GPIO.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-host.c | 2 ++
 drivers/pci/pci.h                           | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index fc868251e570..cbec71114825 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -325,6 +325,8 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	msleep(PCIE_T_PVPERL_MS);
 	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
 
+	msleep(PCIE_T_RRS_READY_MS);
+
 	/* 500ms timeout value should be enough for Gen1/2 training */
 	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
 				 status, PCIE_LINK_UP(status), 20,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846847..c93ffc5e6e1f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -16,6 +16,13 @@
 /* Power stable to PERST# inactive from PCIe card Electromechanical Spec */
 #define PCIE_T_PVPERL_MS		100
 
+/*
+ * End of conventional reset (PERST# de-asserted) to first configuration
+ * request (device able to respond with a "Request Retry Status" completion),
+ * from PCI Express Base Specification r6.0, section 6.6.1.
+ */
+#define PCIE_T_RRS_READY_MS	100
+
 /*
  * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
  * Recommends 1ms to 10ms timeout to check L2 ready.
-- 
2.44.0


