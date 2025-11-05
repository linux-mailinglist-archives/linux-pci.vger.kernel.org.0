Return-Path: <linux-pci+bounces-40346-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBCFC35EBC
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 14:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BFE03B1543
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F803218B3;
	Wed,  5 Nov 2025 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qSfGALDT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377C3191C2;
	Wed,  5 Nov 2025 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350454; cv=none; b=PR2rKAKmQOeywyBuYF+sSFP6QJP9FRd9IStcu+lXlF3IbUNh1utYSDP3zlvR5MYAlYgfCrG3qsdeYRvd8mSqKlxrXKvlU3Qa+sw9cKSeEMV/b0eudKs0ogpXs7ivGOMMvU1EUcYCW4Hlya3Y6NP5ATVr3KailuvYiUTC8mxES8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350454; c=relaxed/simple;
	bh=XI5O9LpKPoy/YgSBuwZY9xA2+uNRdL30absnR1Qof1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VtV9bPkGvkWjAl9P5ENFCAXqzdhxzJ5vza/1bmu5yjOzj01fCXGeELhL5ZbzY7ndexEyFMHUBSevkJAkoW4KRRdRCdSf3YKOuoWOxS8kYI0yTw/aHL9gJvTbd3l8JZYMNKi8kdaqx9t7zqnA9T12AUskqr9nqR5/HiEvw7Bfdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qSfGALDT; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Z3
	2LpAam2B1kwg80ZeQUZWdYRrvt4C39UiG2b3lNhxk=; b=qSfGALDTR+c40KgnuF
	c8Srng3Yhlmi/cPkUZ+F165YQnC1P02m4sv0wq2N4kAuam5+8ZaSGN0kgTBTz/Eu
	8y23FXf3aSlpjqFZCTRHALjIOxSbqYbD2RX9olBr4LgxONi6km/zC25Kbfnk0SBU
	uqiK+dO7EBBY8+oW/wXtXGqCA=
Received: from zhb.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDHJK5XVQtp4K9lCw--.24277S2;
	Wed, 05 Nov 2025 21:47:04 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org
Cc: mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 1/1] PCI: of: Relax max-link-speed check to support PCIe Gen5/Gen6
Date: Wed,  5 Nov 2025 21:47:01 +0800
Message-Id: <20251105134701.182795-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDHJK5XVQtp4K9lCw--.24277S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWDuFWxuFy3Gr1fuF15urg_yoW5Gw1xpa
	y7CryrZry8JF4fXr4kX3Z5ZFyYgas3GrWUtrWrW3sxuFnxJay3tFyYqF43Xr1I9rsxZr17
	XFsxtrWUCw42yaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p__-BDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxiILGkLVViDywAA3Y

The existing code restricted max-link-speed to values 1~4 (Gen1~Gen4),
but current SOCs using Synopsys/Cadence IP may require Gen5/Gen6 support.
While DT binding validation already checks this property, the code-level
validation in of_pci_get_max_link_speed still lags behind, needing an
update to accommodate newer PCIe generations.

Hardcoded literals in such validation logic create maintainability
challenges, as they are difficult to track and update when adding
support for future PCIe link speeds.  To address this, a helper function
pcie_max_supported_link_speed() is added in drivers/pci/pci.h, which
calculates the maximum supported link speed generation using existing
PCIe capability macros (PCI_EXP_LNKCAP_SLS_*). This ensures alignment
with the kernel's generic PCIe link speed definitions and avoids
standalone hardcoded values.

The previous hardcoded "4" in the validation check is replaced with a
call to this helper function, eliminating the need to modify this specific
code path when extending support for future PCIe generations. The
implementation maintains full backward compatibility with existing
configurations, while enabling seamless extension for newer link
speeds, future updates will only require updating the relevant PCI
capability macros without changing the validation logic here.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/of.c  | 3 ++-
 drivers/pci/pci.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 3579265f1198..de1fe6b9ba6a 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -890,7 +890,8 @@ int of_pci_get_max_link_speed(struct device_node *node)
 	u32 max_link_speed;
 
 	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
-	    max_link_speed == 0 || max_link_speed > 4)
+	    max_link_speed == 0 ||
+	    max_link_speed > pcie_max_supported_link_speed())
 		return -EINVAL;
 
 	return max_link_speed;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4492b809094b..2f0f319e80ce 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -548,6 +548,11 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 	return -EINVAL;
 }
 
+static inline int pcie_max_supported_link_speed(void)
+{
+	return PCI_EXP_LNKCAP_SLS_64_0GB - PCI_EXP_LNKCAP_SLS_2_5GB + 1;
+}
+
 u8 pcie_get_supported_speeds(struct pci_dev *dev);
 const char *pci_speed_string(enum pci_bus_speed speed);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
-- 
2.34.1


