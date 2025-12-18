Return-Path: <linux-pci+bounces-43303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E53CCBFC3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 14:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A92DC30DEE7D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 13:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A549330328;
	Thu, 18 Dec 2025 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UlYCEHc5"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934B335082;
	Thu, 18 Dec 2025 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766064077; cv=none; b=KcMdQfNil18zXlk3pn2D5EgtfFEPiEWRByXxl7qT9IBmnsIk1U5vby6zfb9Xb8laqiNnY/oQifDjQSLjyl7p0inI+m6OxhemuHHj+zOBlZAkunzo8vNXiK162a/dblWpVObyrc1xwdAnHWcVIBtgC4zEhVoOYudZdUI778GXP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766064077; c=relaxed/simple;
	bh=Oh4giTYjMDoOP7XQT4CNnufbBB2AN3QI/6R6l4EqNfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aBkv0w7JOv+qOjHMkY+T2gyd7A83mDZgtFUI2rqWWol3ucbO65T0woIggmSKCtDpI6Ksi09Dt9t08ECDaxfExmagj8b318MBJ6s2Rba4B0XW2F5IB6Omn2dF4bvybGZA3soKUl6i5fQUnw7MZiTa4xvt8sHPknCQJXOTzDrS3u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UlYCEHc5; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=GE
	W2DxQzGv371kePYo30ZIQjp5o3OyZ455peCQTkkuY=; b=UlYCEHc5TMCunInQDW
	/RivqPmnxb17GgCwLTOJMhmJ5Ykbb9K2p4OlCIM2uJVFFxuPucUjdLJ7mun3w5Co
	KkJWryT0AIkhRpXf17ofe6qeaQnkWTTxaIugCPwTvL8fY2pPZJCxeeLkG4ABHQT3
	l55eeDG6XRnaowWaMqXS5ixDU=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3Nz2y_0NpUNA+BA--.49994S2;
	Thu, 18 Dec 2025 21:20:50 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org
Cc: mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v6 1/1] PCI: of: Remove max-link-speed generation validation
Date: Thu, 18 Dec 2025 21:20:36 +0800
Message-Id: <20251218132036.308094-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Nz2y_0NpUNA+BA--.49994S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF1xGr47GrWrKr4UAF4Dtwb_yoW5Xw48pa
	yYk34F9rWxWr1rWw4DJ3WUZFyYg3Z3WrWUtryrGwnFvF17JFyaqFySqF4YvFnF9Fs5CF47
	Za42qF47G34jkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRSeH3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBJX+mlD-7KNwgAA3T

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
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
---
Changes for v6:
- It'd be good to return the actual errno as of_property_read_u32() can return
  -EINVAL, -ENODATA and -EOVERFLOW. (Mani)

Changes for v5:
https://patchwork.kernel.org/project/linux-pci/patch/20251218125909.305300-1-18255117159@163.com/

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
 drivers/pci/of.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..b56fdbcb3d72 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -888,10 +888,11 @@ bool of_pci_supply_present(struct device_node *np)
 int of_pci_get_max_link_speed(struct device_node *node)
 {
 	u32 max_link_speed;
+	int ret;
 
-	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
-	    max_link_speed == 0 || max_link_speed > 4)
-		return -EINVAL;
+	ret = of_property_read_u32(node, "max-link-speed", &max_link_speed);
+	if (ret)
+		return ret;
 
 	return max_link_speed;
 }
-- 
2.34.1


