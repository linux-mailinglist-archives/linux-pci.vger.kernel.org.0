Return-Path: <linux-pci+bounces-43297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D7ECCBE36
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 14:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13FA13022A40
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640C033B94B;
	Thu, 18 Dec 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RDY3fHA4"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7326933A9E3;
	Thu, 18 Dec 2025 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766062784; cv=none; b=lUEAjf4oDSNxBK6PtoiUC3DJid2SFusMRcpA7g20osgUmg48KMatcSKhkcMv0ZjOTTX6sr06w71nq0HyuB9yEIjaKuAk3xxJuXOd3WBWCS9+hRXx7N+H9MCHy67fIaBeldlTpfwv+IeBTUy0vjhKunWbVJSmTPmlq0FSh0FesMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766062784; c=relaxed/simple;
	bh=Sh420sFdY/KufJVurtZzcBxT/xtLO96BpSQCDkXpMH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W0MBwXD9OlVIpyMcEIQp4ILGAb57PjOY7ys4P/T1gHdWnM1BtQdWdhw2LwC5DQx3YY36A+8nUbhPvWHwPNembCw0acsib4lj3CHaeAstPWUap2vl/SyebAuX07bokCYDHswqyJ+xVtEY85KTi96Pc8dBNB/TWJrgSlxxLf8Ycfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RDY3fHA4; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1V
	dBXWk5zzRuJ/x+KgT0bv4xbjhLcBWDASxHrVJsBDo=; b=RDY3fHA4MYijrgjbRG
	45YkILKw/KnMFHPUjzXydgev8jdOulotOAz9avsfxod40ao4sxc4RbDaYQ1v2+HP
	hla+fKQQDzHa7J1Y5MK2Y+uXAbqbbyrizY2yqNNcf12776dj7jHxBA7XkrolRAaK
	FjxsL5ylQK0IAcbCTbJfGkQHQ=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3_xGf+kNpfJifBA--.27126S2;
	Thu, 18 Dec 2025 20:59:11 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org
Cc: mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 1/1] PCI: of: Remove max-link-speed generation validation
Date: Thu, 18 Dec 2025 20:59:09 +0800
Message-Id: <20251218125909.305300-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_xGf+kNpfJifBA--.27126S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF48Xw13urW5Gw1xKFy3Jwb_yoW8KF1kpF
	WjkryF9rWxGr15Xw4DJ3W8ZFyYg3Z3WrWDtryrWwnrZF1UGFyaqa4SqF42qF929Fs5ur47
	X3W2qr47G3yjkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRSeH3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AEStWlD+qGa4wAA3C

The current implementation of of_pci_get_max_link_speed() validates
max-link-speed property values to be in the range 1~4 (Gen1~Gen4).
However, this creates maintenance overhead as each new PCIe generation
requires updating this validation logic.

Since device tree binding validation already enforces the allowed
values through the schema, and the callers of this function perform
their own validation checks, this intermediate validation becomes
redundant.

Furthermore, with upcoming SOCs using Synopsys/Cadence IP requiring
Gen5/Gen6 support, removing this hardcoded check enables seamless
support for future PCIe generations without requiring kernel updates
for each new speed grade.

Remove the max-link-speed > 4 validation check while retaining the
property existence and non-zero check. This simplifies maintenance
and aligns with the existing validation architecture where DT binding
and driver-level checks provide sufficient validation.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
Changes for v5:
- Delete the check for speed. (Mani)

Changes for v4:
https://patchwork.kernel.org/project/linux-pci/patch/20251105134701.182795-1-18255117159@163.com/

- Add pcie_max_supported_link_speed.(Ilpo)

Changes for v3:
https://patchwork.kernel.org/project/linux-pci/patch/20251101164132.14145-1-18255117159@163.com/

- Modify the commit message.
- Add Reviewed-by tag.

Changes for v2:
https://patchwork.kernel.org/project/linux-pci/cover/20250529021026.475861-1-18255117159@163.com/
- The following files have been deleted:
  Documentation/devicetree/bindings/pci/pci.txt

  Update to this file again:
  dtschema/schemas/pci/pci-bus-common.yaml
---
 drivers/pci/of.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..1f8435780247 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -889,8 +889,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
 {
 	u32 max_link_speed;
 
-	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
-	    max_link_speed == 0 || max_link_speed > 4)
+	if (of_property_read_u32(node, "max-link-speed", &max_link_speed))
 		return -EINVAL;
 
 	return max_link_speed;
-- 
2.34.1


