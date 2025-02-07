Return-Path: <linux-pci+bounces-20884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AB5A2C102
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 11:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE73188BA71
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7951DE4CD;
	Fri,  7 Feb 2025 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mIe9r0wW"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564C21917E7;
	Fri,  7 Feb 2025 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925726; cv=none; b=aN7VNPDHrbi/saThegJBBW44oC2U84WAFIXVzI1s3vxjH1FDKJZtu6PpnRfO43kWX6U4YDjDlbqC7RAkvxLQh77pLOMM+mLJSzPelYNwe+MMbQ9Gurf0i923ZBXSIABsforQiFUc8DyUl9DgDHxxVgXne/C61AeZdvXZHXlzN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925726; c=relaxed/simple;
	bh=obIqY0/XN9sbohlHOwbKCfTquO4ffPXgpLP6r4bIqQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fRNzc5YlxeurQ74uHxNHTBwedmP9AhFKJ953hI1zP88IT9cG7LmFMONsh993P9Vk0bAS1peetEv4x40mkVYsQ/7R0Hnzn/sxBck3KQGY4cRfIn4Ry6eTdK+mbecGdU4QP+F2t4TPWswj4hlQ9xE8gLV/Q7QfQHpiWyt6tYyFs6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mIe9r0wW; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=X426/
	64hLrjfj7tVVW14NBw1XM3ctlLoME4jKljk7WE=; b=mIe9r0wWfUGWn4TVPJmjv
	slaK7y6dq3DPC0+F3nvoXtasa8dw7H6sjzvSL9OlejqZNg06DvPfI+ErCfBNYGDx
	DWFyplynwm2/H3jRn0VCTU2OjYfPfTW066h0WPfyirRIdwR3CKeYPKm9rwXy98g7
	NwQpIgY4/9xi3ZvDhnmNyI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wB3ZQTc4qVnGANSKQ--.60365S2;
	Fri, 07 Feb 2025 18:39:26 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org
Cc: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	bwawrzyn@cisco.com,
	cassel@kernel.org,
	wojciech.jasko-EXT@continental-corporation.com,
	a-verma1@ti.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rockswang7@gmail.com,
	Hans Zhang <18255117159@163.com>
Subject: [v3] PCI: cadence: Fix sending message with data or without data
Date: Fri,  7 Feb 2025 18:39:23 +0800
Message-Id: <20250207103923.32190-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3ZQTc4qVnGANSKQ--.60365S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1xZr1fJrWrWrW5WryDKFg_yoW8CF43pF
	yUGrySy3WxXrWavan5Z3WDuF13t3ZayF9rXw4v934fuF17u34UGFy7KFyrJFW5GrWvqr17
	Zw1DtF9rGF4fA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEFksDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwLso2el3JZ1hwAAs4

View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
Registers below:

axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.

Signed-off-by: hans.zhang <18255117159@163.com>
---
Changes since v1-v2:
- Change email number and Signed-off-by
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
 drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index e0cc4560dfde..0bf4cde34f51 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
 	spin_unlock_irqrestore(&ep->lock, flags);
 
 	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
-		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
-		 CDNS_PCIE_MSG_NO_DATA;
+		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
 	writel(0, ep->irq_cpu_addr + offset);
 }
 
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index f5eeff834ec1..39ee9945c903 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
 #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
 #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
 	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
-#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
+#define CDNS_PCIE_MSG_DATA			BIT(16)
 
 struct cdns_pcie;
 

base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
-- 
2.47.1


