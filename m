Return-Path: <linux-pci+bounces-21485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E606A363B8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9125170317
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EA0262816;
	Fri, 14 Feb 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BhocEcok"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00AE267AE8;
	Fri, 14 Feb 2025 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552290; cv=none; b=pVWwAcY5UAzUenAP9gFvGAIGzPQu1D6r9XV+3nQD9C/QJo490JuWx/ghs94evZJ/lNuNeCuC7/86q6K8zlp+dtgU6ITWXD7Mk1UpuSX2O6aqAZ1c4pO3Wh+2XRK2+l99s++yv2CZuCNygUiQjDqffXJwH/NdByXSbdLf65uhX6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552290; c=relaxed/simple;
	bh=pSe80PMMGCIlXIiJ/T3xmK0UbzGta0NRATEdIDVst1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RRaLVjSD72v4zxvfUhcHteVH3NQdgnL0ELbNbKh7+DWF1QCICfkek5YgSTR1mUdG9oeM0sjalWkgL8AOnh24HaIh6VazpoWzqJESAIkTFZXnB2DxuZwze6CWcBMGu7xYImedQe3rgg1hRMFWXtGXP105tMYb8Old92MemqaXyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BhocEcok; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Y2T2I
	Ora8hm8MNeTBECuFgUROwdd06PyTIT6wKcB394=; b=BhocEcokkrJDY0VRb0EpI
	q7hkk/oxXfmf0QpVtJqBD7+snSi/wuFFP5G9/MeTbkbywNw75MSf35W3NaeQ8biX
	oMnFDm2QklBtrMSc17vh4Qaey03rS0/noMLE3J9gEVgDmcrIUHqY10liz6RDzm5f
	E8+XBcCtKdp9QdK+tiCVU8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDn7731da9n74fnMA--.13986S2;
	Sat, 15 Feb 2025 00:57:26 +0800 (CST)
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
Subject: [v4] PCI: cadence-ep: Fix the driver to send MSG TLP for INTx without data payload
Date: Sat, 15 Feb 2025 00:57:24 +0800
Message-Id: <20250214165724.184599-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7731da9n74fnMA--.13986S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF47ZF13Kr13Ww1xJF1fJFb_yoW8tw48pF
	WUGrySkF1xXrWa9an5Za1UCF13tanxtas7Gw4v9w1fZF13u34UGry3KFyrXFWUGrWvgr17
	Aw1DtF9rGFsxA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEGNtDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw7zo2evaI68SwAAsc

Cadence reference manual cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf, section
9.1.7.1 'AXI Subordinate to PCIe Address Translation' mentions that
axi_s_awaddr bits 16 when set, corresponds to MSG with data and when not
set, MSG without data.

But the driver is doing the opposite and due to this, INTx is never
received on the host. So fix the driver to reflect the documentation and
also make INTx work.

Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes since v3:
https://lore.kernel.org/linux-pci/20250207103923.32190-1-18255117159@163.com/

- Add Fixes: tag.
- The patch subject and commit message were modified.

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
 

-- 
2.25.1


