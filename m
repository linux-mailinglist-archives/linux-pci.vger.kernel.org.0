Return-Path: <linux-pci+bounces-6209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5C58A396B
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 02:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064071F22887
	for <lists+linux-pci@lfdr.de>; Sat, 13 Apr 2024 00:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9D917FE;
	Sat, 13 Apr 2024 00:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+2QEfe6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383FD2FB2
	for <linux-pci@vger.kernel.org>; Sat, 13 Apr 2024 00:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712968886; cv=none; b=qErNoSMxNsVUT4X89Ck47GucTNxp4tawNoTAbSL3NdKFptP13MjgEK5BPVimVzIAfeuVLrtmywvNMwMXZcRfa+Bwk3QsboolybE5DT5ocGriQ4gwUm79kEBRMHO+Z/F9oQpK0TZK4U1eQqPKkMcJXQAblrBQr2VjivITTfkrDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712968886; c=relaxed/simple;
	bh=NtNcpT66BU8hBTnj7sbWjZt20HoXWq77pHUKJT0WyEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OaBYneh6GdRDzxYM86FdO8Gknff/Mr/8f6Yfxcrfcw0cumiF0p591Iuoj7+CrqMzVF1yv3Q+tQ8Y1k4J/A5t4MkYOUL/+zDUslxs2KeO55h6azmIy/P3WGf5GoqvR1xt+JaxqRGEmZczcYPWbZZULUELQq1XUSkb1ixKe4ez8GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+2QEfe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC1BC113CC;
	Sat, 13 Apr 2024 00:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712968885;
	bh=NtNcpT66BU8hBTnj7sbWjZt20HoXWq77pHUKJT0WyEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+2QEfe6PxLVwEr9KiLSOqwZ4M4N6nqMKDmOPS+fyvLfkpzdjyltMMw1xkaepxEwx
	 56E2rlaJr3E4Yy172dUmpBgH5rNUJCzKkmhv1Y+pLFm6mHtThCCRrJeRFUl1Iwd8ks
	 giTcQsmnjQeN15K3cPPrmfV/ydLSes44NFELbVyOX10DGow4ExLSI2vmUQJWheCjVx
	 XolSjVGTv9rzg+U3oRszT2z6kKFZk8CyDVV4MbUXkHJHXcgvzUfYy5lIS8zZtJ2sv7
	 Qrgn9y1wVLM/CH/pAOQYvsqjO9kdBq4Ir5z1qojtyr0XD/shAhsZ02p8OaVkSXkb6b
	 vTuTVIvHNYYEQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/2] PCI: rockchip-host: Wait 100ms after reset before starting configuration
Date: Sat, 13 Apr 2024 09:41:20 +0900
Message-ID: <20240413004120.1099089-3-dlemoal@kernel.org>
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

The PCI Express Base Specification r6.0, section 6.6.1, states that the
host should wait for at least 100 msec from the end of a conventional
reset (PERST# is de-asserted) before sending a configuration request to
ensure that the device is able to respond with a "Request Retry Status"
completion.

Add the PCIE_T_RRS_READY_MS macro to define this wait time and modify
rockchip_pcie_host_init_port() to add this 100ms sleep after deasserting
PERST# using the ep_gpio GPIO.

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


