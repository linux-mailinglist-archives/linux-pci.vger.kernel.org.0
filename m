Return-Path: <linux-pci+bounces-40031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B28EC28203
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 17:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45FF1895B49
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D61DED63;
	Sat,  1 Nov 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WHf4live"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD91494CC;
	Sat,  1 Nov 2025 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013162; cv=none; b=oQtPaunysXszlS93BRWoCwb8elKM4uvN5gIJUlQg6tlVPFnE38jUC55Amu7il2D/XrIKxn4FgNT03Lm/8pnBJRsEehfBSg4nGmht9NQHwOCQ/B2ExhwgI8eCpwyo6tN39lFfDCJ/xjUJrlGm4D4uoG/kjr9gXdAjJ/lo9gQq6Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013162; c=relaxed/simple;
	bh=Xz4GbbMrxXO/VGD0EMSdSfVU9wYMOZseAX78Xf98CFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nPFPT6S9h6TleAdTToS01ql96cyd13u0MqrdgyCwgsSe2oeJm8oLVF15i0flUjZyc1getgk55301dTUyt940aWN9pYA3/F/jIF4cCHbCdADMX4D7NzcZHvHhN07bUTQ5kGoemArdMARcomb9oBUfqCD83kNTCGtGPRV1ucX2c/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WHf4live; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ad
	vzvJzLxncRb/7kkrk+KLmis5Xz44JXtV/sPH0U9AQ=; b=WHf4liveF5ip+ckPzc
	YG2WvcGapo8eYxxe5T3ckincsjL1FUJ8lDZzCK7QRY3TP+aLaze5DQKViOIbdtEb
	c922f1WHvYQ3ySkhOltzNrVv6NzUgl+B4KACkj0AqRy0LYCaya2Qa8ZlEvF3xHcJ
	btpqC05ogKQIB3bbhw9ZKmgOk=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXL4nTLwZp3qOtAw--.844S5;
	Sun, 02 Nov 2025 00:05:41 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 3/4] PCI: pciehp: Add macros for hotplug operation delays
Date: Sun,  2 Nov 2025 00:05:37 +0800
Message-Id: <20251101160538.10055-4-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101160538.10055-1-18255117159@163.com>
References: <20251101160538.10055-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXL4nTLwZp3qOtAw--.844S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWrZr1ruw17Ar4kJr4UCFg_yoW8JFW7p3
	yfArWUtF1rKrs8Cws5Za1DWr98CasxCrZrCrWUu3s3ZF97Aw4DA3WfKa4jqFyfArW5Cr15
	WFWrAFy5Ja1UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFXdnUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxXcgGkGL9Xu7QAA3c

Add WAIT_PDS_TIMEOUT_MS and POLL_CMD_TIMEOUT_MS macros for hotplug
operation delays to improve code readability.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bcc51b26d03d..15b09c6a8d6b 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -28,6 +28,9 @@
 #include "../pci.h"
 #include "pciehp.h"
 
+#define WAIT_PDS_TIMEOUT_MS	10
+#define POLL_CMD_TIMEOUT_MS	10
+
 static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
 	/*
 	 * Match all Dell systems, as some Dell systems have inband
@@ -103,7 +106,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 			smp_mb();
 			return 1;
 		}
-		msleep(10);
+		msleep(POLL_CMD_TIMEOUT_MS);
 		timeout -= 10;
 	} while (timeout >= 0);
 	return 0;	/* timeout */
@@ -283,7 +286,7 @@ static void pcie_wait_for_presence(struct pci_dev *pdev)
 		pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
 		if (slot_status & PCI_EXP_SLTSTA_PDS)
 			return;
-		msleep(10);
+		msleep(WAIT_PDS_TIMEOUT_MS);
 		timeout -= 10;
 	} while (timeout > 0);
 }
-- 
2.34.1


