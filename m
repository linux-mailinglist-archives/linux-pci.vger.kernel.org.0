Return-Path: <linux-pci+bounces-34603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC82B32010
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 18:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2C92BA6A3D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8B72FB631;
	Fri, 22 Aug 2025 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Y7/J4YPV"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB452EC55A;
	Fri, 22 Aug 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878591; cv=none; b=PbVlZzY7U17xOazlMbHWmNfTRE+w+O8O5lBe6mNq/8mzKoSuuBQVllsh2uR2hDYzA5KmT1xmSWoc3bJjaq0Wcryy7RqGVHv090FIqLgroHQ5xbZJSPb/dW7j3H4zmnSJvvXur+776+o6WHYP2dO7mPbW0L6g+7+pByJINCcpInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878591; c=relaxed/simple;
	bh=qVtS6Oax7AvmoJvDAdQ3sWbGANOQPPBZ1eYryTUFhNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgqziANcsiuGQaUU9o1hwDfmjyRmsrjTBY7Do/5HJhQPt3ivPFCDm/ptVsDLayDHR3z4ZRNhqf3Lhs+4HC39BD2jtdXfKf+9rYfwbPhuhvOqLUHur1XzV+Fe+PeONBWNigPRC1ZnbWvJC7qZDwiasr4pUI65bRtr2oKnAotPfRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Y7/J4YPV; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=WH
	hy8pVWYEgSZDMbifm3Z6i7fna8qFoPzMa2cr1YMAE=; b=Y7/J4YPVdDliUGWqmm
	PsIE1oJwFNJJ2iBZS1+6se/V4o2Usarj7UAVCoHWkqAXtgU4L1ztQnY3wdzahDTx
	P1FcnV9M2K/zgL/Yh43ZBm14BxANB7HB7UY4k9Eh8rKodS4B6alyqc33k81OJj9p
	Gkajey4W+KIZ7Ze0xLZ2feows=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnxDaplKho3jnHAA--.18200S4;
	Sat, 23 Aug 2025 00:02:52 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 2/7] PCI: Replace msleep(1) with fsleep() for precise link status checking
Date: Fri, 22 Aug 2025 23:59:03 +0800
Message-Id: <20250822155908.625553-3-18255117159@163.com>
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
X-CM-TRANSID:PygvCgBnxDaplKho3jnHAA--.18200S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4kCryUGFW3JF4UuF4kZwb_yoW8JF4xpF
	W7Ca42yryrJa17Zws8Za18uF15t3ZFyFW7CFWUu3sxua43Cr47Ja13tayaqrn2vrZ7Grya
	v3Z0yw1UGay5JwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRY2NNUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhCxo2iokEFcYAAAsV

The msleep(1) in pcie_wait_for_link_status() may sleep longer than
intended due to timer granularity, which can cause unnecessary delays in
link status monitoring. Replace it with fsleep() for a more precise delay
of exactly 1ms.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pci.c | 2 +-
 drivers/pci/pci.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fb4aff520f64..fff49982b2a9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4683,7 +4683,7 @@ static int pcie_wait_for_link_status(struct pci_dev *pdev,
 		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
 		if ((lnksta & lnksta_mask) == lnksta_match)
 			return 0;
-		msleep(1);
+		fsleep(PCIE_LINK_STATUS_CHECK_US);
 	} while (time_before(jiffies, end_jiffies));
 
 	return -ETIMEDOUT;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 471dae45e46a..e9360d8ff81d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -16,6 +16,7 @@ struct pcie_tlp_log;
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
 #define PCIE_LINK_RETRAIN_TIMEOUT_MS	1000
+#define PCIE_LINK_STATUS_CHECK_US	1000
 
 /*
  * Power stable to PERST# inactive.
-- 
2.25.1


