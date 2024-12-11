Return-Path: <linux-pci+bounces-18085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8479EC42B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 06:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC428168614
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 05:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BB91BCA19;
	Wed, 11 Dec 2024 05:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="eBxC/n1f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49240.qiye.163.com (mail-m49240.qiye.163.com [45.254.49.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876BD1514F8
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 05:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733894163; cv=none; b=YV+oEw9fnIiJCZpaecWHX7Zy1alwd6U4Q+1vl24sCfXT1ofMWPU00YeGQhaJpjzONK13W7+HzpuVjU00rx5kkp5+UFpdT8dUjMrz/PFtrlKFC8aHC1TYpkddS7oYLE21WokosEdiJGE8b7eJlUmxfCJ3cYbcoemrjknnZPjsYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733894163; c=relaxed/simple;
	bh=x1rGXrrI3iwYwRyxGs+U+H1jTTHiEl+zuwVEPD8uRJU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KjV6QdTdLjWRCuD4SJgmyUhqmERBtyDjaS4DB7zSKmcHUOz0wHxwKkV/2g3qJyhphVTtdKuzXWV+O5fk+sx1AYZsOkVctRWT+LOeMtEOZEJXeRO2eSobod50PtczJIwoog730dDyEx4/tlVwkr42/byHkksnY1SxFFzPteJH7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=eBxC/n1f; arc=none smtp.client-ip=45.254.49.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 55b785b5;
	Wed, 11 Dec 2024 10:53:28 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] PCI: Add Rockchip vendor ID
Date: Wed, 11 Dec 2024 10:53:17 +0800
Message-Id: <1733885598-107771-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJIH1YfTBgdSEwfHR9DGBlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a93b3a2c26509cckunm55b785b5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KxQ6SBw6OTISNjMUSQ0KOBNR
	NE8aCkJVSlVKTEhIQ0NOTUtCTkpIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQU9CSjcG
DKIM-Signature:a=rsa-sha256;
	b=eBxC/n1fTcKvkQGnRrXMzdcY86BkG/ilLIBC3nD28iMGl2y/OlJWV15Sgp9pt5SU4NFdSWgcetST1x5mqYlR8mAhCNZYMEGxbEUA7Kpe4qig2NefDvKz2J7kFRUvbr6pirAH7fpMmI5Q94He2zt5x0k7NzQTpqDt1ZFHulVgFb0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Y7JhKEyKePyArX5jUi7ZvQjtrgAlC9eGaY2NefVrR28=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d2402bf..6f68267 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2604,6 +2604,8 @@
 
 #define PCI_VENDOR_ID_ZHAOXIN		0x1d17
 
+#define PCI_VENDOR_ID_ROCKCHIP		0x1d87
+
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
 #define PCI_VENDOR_ID_META		0x1d9b
-- 
2.7.4


