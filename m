Return-Path: <linux-pci+bounces-26377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1875A96755
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666493AF840
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329F527C162;
	Tue, 22 Apr 2025 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="L8dAlQh2"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B29253F1F;
	Tue, 22 Apr 2025 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321362; cv=none; b=EwJFax799ghwhS5K9Ha2mngF1KVqnQuZ00lAOUHp6oRHFbNQihhwVRmPZ6C6LSA6G0u8ST7f/sS7JSvCaJtn/8yKxrw5cyMssIAfG5Y0plwJwfG9pwbuPBl/c/kRA6hoeWhxb5Mkwa6uh4jXieVoYMwk6F+9V9VxVcKUpfgTTds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321362; c=relaxed/simple;
	bh=J0oq7i7+aOrHk41A4h85D/OoJCN2A5trbCjlIZf4VXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=US6nfgxgYYr75H93Mgg94Xx3v8LiD9pXO/9GPBUgpL9VuLtXOKZHhdcxIRg94tHf6gJ7o69H70wKuyK9yzyQyh7z6FednxlA+2gyB2zIdLwkQb/Ec4MqWO6yiV4Q2v0evY6TJv0na7uuPq4i5nI7rrUDkd/fW4D1KZ3sf3schs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=L8dAlQh2; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2RWjK
	PWv82UStMG6NIWMhcWrtvVJa7KMbvU2NcwBt1g=; b=L8dAlQh2CfbwxNHys0yEf
	IyXb8FFHE7WoFP0CX+ElrJ4conoHMiQzEuzceikbUdiO40V85jXcw9JTz7gQKZm8
	UsK5HBVt17CF/MUSs0GZrAiYAKsiN+gc3jp5g3GAxsFgYIO1qk2GX0kkf0HQOIBZ
	N7qC9KSp46kAG1aLsMUskU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCXbK1gfQdoRW2NBg--.44191S4;
	Tue, 22 Apr 2025 19:28:37 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	heiko@sntech.de
Cc: manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	jingoohan1@gmail.com,
	shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 2/3] PCI: dw-rockchip: Reorganize register and bitfield definitions
Date: Tue, 22 Apr 2025 19:28:29 +0800
Message-Id: <20250422112830.204374-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422112830.204374-1-18255117159@163.com>
References: <20250422112830.204374-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXbK1gfQdoRW2NBg--.44191S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWFWxWryktw1DKF48uFyfJFb_yoW5Zrykpa
	98AFyakrs8tayakwnYgF15AF17tF13KFWjgrsIg3yUu3Z5Aw18Gr18WF1Sgry7tr4kWrW3
	uwn8Gw1xWF9xCrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEJ3kiUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwU3o2gHegppMgABsb

Register definitions were scattered with ambiguous names (e.g.,
PCIE_RDLH_LINK_UP_CHGED in PCIE_CLIENT_INTR_STATUS_MISC) and lacked
hierarchical grouping. Magic values for bit operations reduced code
clarity.

Group registers and their associated bitfields logically. This improves
maintainability and aligns the code with hardware documentation.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 42 +++++++++++--------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index fd5827bbfae3..cdc8afc6cfc1 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -8,6 +8,7 @@
  * Author: Simon Xue <xxm@rock-chips.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
 #include <linux/irqchip/chained_irq.h>
@@ -34,30 +35,35 @@
 
 #define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
 
-#define PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
-#define PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
-#define PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
-#define PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
-#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
+#define PCIE_CLIENT_GENERAL_CONTROL	0x0
+#define  PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
+#define  PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
+#define  PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
+#define  PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
+
+#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x4
+#define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
+
 #define PCIE_CLIENT_INTR_STATUS_MISC	0x10
+#define  PCIE_RDLH_LINK_UP_CHGED	BIT(1)
+#define  PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
+
+#define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
 #define PCIE_CLIENT_INTR_MASK_MISC	0x24
+
 #define PCIE_CLIENT_POWER		0x2c
+#define  PME_READY_ENTER_L23		BIT(3)
+
 #define PCIE_CLIENT_MSG_GEN		0x34
-#define PME_READY_ENTER_L23		BIT(3)
-#define PME_TURN_OFF			(BIT(4) | BIT(20))
-#define PME_TO_ACK			(BIT(9) | BIT(25))
-#define PCIE_SMLH_LINKUP		BIT(16)
-#define PCIE_RDLH_LINKUP		BIT(17)
-#define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
-#define PCIE_RDLH_LINK_UP_CHGED		BIT(1)
-#define PCIE_LINK_REQ_RST_NOT_INT	BIT(2)
-#define PCIE_CLIENT_GENERAL_CONTROL	0x0
-#define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
-#define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
+#define  PME_TURN_OFF			HIWORD_UPDATE_BIT(BIT(4))
+#define  PME_TO_ACK			HIWORD_UPDATE_BIT(BIT(9))
+
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
+#define  PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
+
 #define PCIE_CLIENT_LTSSM_STATUS	0x300
-#define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
-#define PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
+#define  PCIE_LINKUP_MASK		GENMASK(17, 16)
+#define  PCIE_LTSSM_STATUS_MASK		GENMASK(5, 0)
 
 struct rockchip_pcie {
 	struct dw_pcie pci;
-- 
2.25.1


