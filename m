Return-Path: <linux-pci+bounces-29144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55411AD0E63
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 18:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66F71890E13
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 16:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C7A13AD05;
	Sat,  7 Jun 2025 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Yoq6TCtq"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB4B184F;
	Sat,  7 Jun 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749312316; cv=none; b=n2qJwJ+ba3yH3XgN9zYbVa92ZJ4byAck47ZeT0rdg0Z2zMEm/REngY+lKUqSzFE95cKOTHOt7WrcL3Q8uFTyAfTrq675WtnFHsl9Luq4oMnCp+bRkupmTs0jue9rynBNNuUDJ+QtYsV6u0WCt7kezn38ygmY/7Lup6wKCOSydJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749312316; c=relaxed/simple;
	bh=TdjSTlUdgP4LXrNuClt9rd2nGipjznUd5ZXNwClX9iY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uyLoInV/GK+eNa/CPbCfKzDaw9iJaxaaZq5AvvnqSyoCrUqQ9ZoHtURJfbx644W/h7YcqNQ9xJqlwz93fghj2BQQ77sWsj687zFWadap821lP/426uW5lRK1bzVurKrnFQ4QyUnUXjfOthHNzZWGtaiuER2sbDSHb/nISewZeGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Yoq6TCtq; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Q5
	Ms93Khz/oAEynWixPmT3I+2jyhZg/bPBQtyT4UV60=; b=Yoq6TCtqv3swQV5HpA
	43HND+U/e1hn+2zn94r44R5j5TG2Qv6yWIWfdRI6ZOY8fxLlA/1oDhsGFKuMt2R3
	n/7G6nM+ZoOsRGOpd4M7l0D38ctOBsiGsXOIAmHcxZhBsQxeVOsm9RLIbDpmgQSm
	XFTUsjll2M+cMT8XDtrIZvHqM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnzz17X0RoTZo8Gw--.4221S4;
	Sat, 07 Jun 2025 23:49:17 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	shawn.lin@rock-chips.com,
	heiko@sntech.de
Cc: robh@kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 2/2] PCI: rockchip: Remove redundant PCIe message routing definitions
Date: Sat,  7 Jun 2025 23:49:13 +0800
Message-Id: <20250607154913.805027-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250607154913.805027-1-18255117159@163.com>
References: <20250607154913.805027-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnzz17X0RoTZo8Gw--.4221S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr48KFWxXr1xtFWfXFWDurg_yoW8Zry8pr
	WUJ3y0yF4xKw43u3W3XF4fXa17Xa9rtF4qvrn29a13KF1fW34rGa4UZF43Grn8JrW8Xrn2
	k390kayDtrZ8GrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEWrWrUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxRlo2hEXgkg6gAAs4

The Rockchip driver contained duplicated message routing and INTx code
definitions (e.g., ROCKCHIP_PCIE_MSG_ROUTING_TO_RC,
ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTA). These are already provided by the
PCI core in drivers/pci/pci.h as PCIE_MSG_TYPE_R_RC and
PCIE_MSG_CODE_ASSERT_INTA, respectively.

Remove the driver-specific definitions and use the common PCIe macros
instead. This aligns the driver with the PCIe specification and reduces
maintenance overhead.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/pcie-rockchip.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 5864a20323f2..12bc8da59d73 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -215,20 +215,6 @@
 #define RC_REGION_0_TYPE_MASK			GENMASK(3, 0)
 #define MAX_AXI_WRAPPER_REGION_NUM		33
 
-#define ROCKCHIP_PCIE_MSG_ROUTING_TO_RC		0x0
-#define ROCKCHIP_PCIE_MSG_ROUTING_VIA_ADDR		0x1
-#define ROCKCHIP_PCIE_MSG_ROUTING_VIA_ID		0x2
-#define ROCKCHIP_PCIE_MSG_ROUTING_BROADCAST		0x3
-#define ROCKCHIP_PCIE_MSG_ROUTING_LOCAL_INTX		0x4
-#define ROCKCHIP_PCIE_MSG_ROUTING_PME_ACK		0x5
-#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTA		0x20
-#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTB		0x21
-#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTC		0x22
-#define ROCKCHIP_PCIE_MSG_CODE_ASSERT_INTD		0x23
-#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTA		0x24
-#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTB		0x25
-#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTC		0x26
-#define ROCKCHIP_PCIE_MSG_CODE_DEASSERT_INTD		0x27
 #define ROCKCHIP_PCIE_MSG_ROUTING_MASK			GENMASK(7, 5)
 #define ROCKCHIP_PCIE_MSG_ROUTING(route) \
 	(((route) << 5) & ROCKCHIP_PCIE_MSG_ROUTING_MASK)
-- 
2.25.1


