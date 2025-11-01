Return-Path: <linux-pci+bounces-40041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2275BC2831C
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 17:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83D01349D90
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90AD26A0E0;
	Sat,  1 Nov 2025 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hFU03DG9"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E1269AEE;
	Sat,  1 Nov 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762015320; cv=none; b=Kp/8s4iE661tuDR53C8v/0myOL6XBIZuavpgRquF2w+1aJEDU9PNDA6NmsCb5Nm79/mV1rFYGfYGWSef8GcGW9nSZVwmok4sJDScG+wxjO1ILSTkDBdz9s+34J+YzG14Jlgxj5T0P8kCUuLnveKA0OqJynO1IVIvGwzPMQq8Eck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762015320; c=relaxed/simple;
	bh=/Lmtqv2YdFzMKD+tU35ni0Evtp/XjGnVQdRIqfQxcXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f3ihGKaqKGiYw6Nve6OVIXknMS3E4zlr84OrbWhei6yEOsg2EndVyNKkrCGETVK1ZvJdHIFvJhLAXVVAk5d+uD8pBFh/zuCniO0j5aZjZcV5W4Z8g/vCWWi35a/ZUOy24yB0+zUnoyF8emJIDW87oWTv0/m9dKare7Ghcbe8Dec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hFU03DG9; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=9w
	Up7u3My76G+R/WLPGyk/WkzbItLsUENPV0fn3j5Pw=; b=hFU03DG9YqxprWd8g9
	o6LU3NwjxRNyuxl96ki11m69KzgEen+Ho6qMFhsEtJbt1aW5Kd0XIX3HAJf1EZf9
	L1xIKitgFZbjT6SX4Xksx6sFp23Oa7sOB4tcVUBgwxsicI4TYEAKgHgHZU74+hVB
	dOE8FEMBhtp6oa7wFN2E/sIKw=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnofBAOAZpIs11CQ--.54784S2;
	Sun, 02 Nov 2025 00:41:37 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v3 1/1] PCI: of: Relax max-link-speed check to support PCIe Gen5/Gen6
Date: Sun,  2 Nov 2025 00:41:32 +0800
Message-Id: <20251101164132.14145-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnofBAOAZpIs11CQ--.54784S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWUGFW8Jr15uw4fKF4fGrg_yoW8GFW8pa
	y7AryrWry8WF43Zw4DX3WruFyjgasxXrWDtry5W3ZruF43GF4aqFySvF4fXFn29rWkZr17
	XF13tr47Jw4jyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEVc_wUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiFR-4o2kGMU6GewAAs8

The existing code restricted `max-link-speed` to values 1~4 (Gen1~Gen4),
but current SOCs using Synopsys/Cadence IP may require Gen5/Gen6 support.

While DT binding validation already checks this property, the code-level
validation in `of_pci_get_max_link_speed` also needs to be updated to allow
values up to 6, ensuring compatibility with newer PCIe generations.

Signed-off-by: Hans Zhang <18255117159@163.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
Changes for v3:
- Modify the commit message.
- Add Reviewed-by tag.

Changes for v2:
https://patchwork.kernel.org/project/linux-pci/cover/20250529021026.475861-1-18255117159@163.com/
- The following files have been deleted:
  Documentation/devicetree/bindings/pci/pci.txt

  Update to this file again:
  dtschema/schemas/pci/pci-bus-common.yaml
---
 drivers/pci/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..53928e4b3780 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -890,7 +890,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
 	u32 max_link_speed;
 
 	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
-	    max_link_speed == 0 || max_link_speed > 4)
+	    max_link_speed == 0 || max_link_speed > 6)
 		return -EINVAL;
 
 	return max_link_speed;
-- 
2.34.1


