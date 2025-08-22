Return-Path: <linux-pci+bounces-34604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A24F3B32031
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 18:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7905626A09
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CAF2FC02E;
	Fri, 22 Aug 2025 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bMHMUVwT"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610652ECE89;
	Fri, 22 Aug 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878591; cv=none; b=E3+Xqq8DBctO3Zb+4DvyxHPUq07NZYCkNjVlf3uYP5HE9EFj6f7T59hJVk2UW7v4suJYAZTFcJFzgeoCtbroqqR6+P7Lm9jhABhlF1ng5fwr35hVPZlsRmRFLRueJvqNa+3WO0EfMayTVfevRCGqfDE02EBT/sPGig1/m8lmP/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878591; c=relaxed/simple;
	bh=nDMml1t/oal1TjSK/YIWHUoJL2zcYpk6pKuTr1mAois=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwaY/sto6ZZlT7/X0Z6OdEr4YvDVS81+rFH5Ln9HzJLLCvdVtSsS3vPjufAb73GieJeH6+geM4P7IqhGvUNbNKv4pg7/Z/cknbtuhc0FBzueT3gXy17oanN6Jy2DRXMDfqMS1TWeuz/asUSYAa2WRLiPRAuSoN+WsS8CD7xjqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bMHMUVwT; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=T9
	4mJCk8hkOexzssDr7cq6HVn2dwwdGw0IOiDmrMQpQ=; b=bMHMUVwTNEHKAOaXi1
	crNavquTJdHfT3erOOp1iRuYQlYhUlfMn6jn4EDmZoK1P+UXjk1W2zXfekz897T4
	E0+7ug1j/ELD76V8n+lPPO/rd5FABUHZmp3thbDkewNkTZiERSa5MFNq9i6fAO+b
	0X0rTJ/8JXXC7aTWoviQeuUHw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnxDaplKho3jnHAA--.18200S8;
	Sat, 23 Aug 2025 00:02:53 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 6/7] PCI: pciehp: Replace msleep(10) with usleep_range() for precise delays
Date: Fri, 22 Aug 2025 23:59:07 +0800
Message-Id: <20250822155908.625553-7-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822155908.625553-1-18255117159@163.com>
References: <20250822155908.625553-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBnxDaplKho3jnHAA--.18200S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyfCw17Wr18Wr1fXFW8Zwb_yoW8Xr4fp3
	yxCrWjyF4rK398CwsavaykW3Z8CF9xCFWDCrW7u3s3ZF93A3ykCa1ftayjqryavrWUCryU
	WayrtF95JF4UAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR8wIDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQxixo2iokINY4QAAsj

The msleep(10) in pcie_poll_cmd() and pcie_wait_for_presence() may sleep
longer than intended due to timer granularity, which can cause unnecessary
delays in hotplug operations. Replace them with usleep_range() calls using
macros for more precise delays of approximately 10ms.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bcc51b26d03d..f9ae48b7b6ad 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -28,6 +28,9 @@
 #include "../pci.h"
 #include "pciehp.h"
 
+#define WAIT_PDS_TIMEOUT_US	10000
+#define POLL_CMD_TIMEOUT_US	10000
+
 static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
 	/*
 	 * Match all Dell systems, as some Dell systems have inband
@@ -103,7 +106,7 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
 			smp_mb();
 			return 1;
 		}
-		msleep(10);
+		usleep_range(POLL_CMD_TIMEOUT_US, POLL_CMD_TIMEOUT_US + 100);
 		timeout -= 10;
 	} while (timeout >= 0);
 	return 0;	/* timeout */
@@ -284,6 +287,7 @@ static void pcie_wait_for_presence(struct pci_dev *pdev)
 		if (slot_status & PCI_EXP_SLTSTA_PDS)
 			return;
 		msleep(10);
+		usleep_range(WAIT_PDS_TIMEOUT_US, WAIT_PDS_TIMEOUT_US + 100);
 		timeout -= 10;
 	} while (timeout > 0);
 }
-- 
2.25.1


