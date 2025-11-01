Return-Path: <linux-pci+bounces-40038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57636C28285
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 17:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156113B38ED
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11392264DC;
	Sat,  1 Nov 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TtEq1vpD"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B23017A2F0;
	Sat,  1 Nov 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014257; cv=none; b=faG2zyz9JrlknPBrmY+8YCUgwMVv7dzPSEpTWD8LCr4qzgQ+4bIJo0p6t6wRHyqs1/XltU4h1puP0lLCi12wBJpmqfbw6VVP/UrsAZ6DLYlGrwQhb1ANjybmEMWpq14jFlQlszYaSb9T9S4Zy3FsD6X1bC77N3qxekx4/gsN5Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014257; c=relaxed/simple;
	bh=9Ud/LeNIcKwL0efzQzPowgMKrjbEYWLDeh1PO30vwtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q5MZjoRrpxuzkWE7Py6xMxKrKDn2aRc5MO7RXqql/9JIak6Aln79R0GRgqJxDO4oa9BO6Bg4XGk9kPwk4gJ4YB442YfKLQuQut99VE4bn428gHKcCM5VwpV/c97XUVI8L52J52yLPOC5b4G8l9nVb/vb+7QUZgh1XOsgUIrVkX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TtEq1vpD; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3V
	QIEWJRrZqUWBIlYJxpy6ioV+MlB2SKV2d469TV62M=; b=TtEq1vpDhxs+q/92BZ
	xkUuxYPlpDFf25bJsffU+uROyvaSorqXGl9WnzgmfkTVimFjkYX6Y5Kya7oj3jVb
	4lNS8IlxoijbYUzhUe0rYnMIXrbdUUIcUBHZIn6jYTjrRb6GLfZdM+UG7uFqWQ/e
	X1tU0zJzAwgjeu/ilXAywoEyY=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCHBDkQNAZpNmGwAw--.59274S3;
	Sun, 02 Nov 2025 00:23:47 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: mahesh@linux.ibm.com,
	bhelgaas@google.com
Cc: oohall@gmail.com,
	mani@kernel.org,
	lukas@wunner.de,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [RESEND PATCH v4 1/2] PCI: Introduce pci_clear/set_config_dword()
Date: Sun,  2 Nov 2025 00:22:18 +0800
Message-Id: <20251101162219.12016-2-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251101162219.12016-1-18255117159@163.com>
References: <20251101162219.12016-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHBDkQNAZpNmGwAw--.59274S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrKw4rWrWxKrWxAFykCry7Awb_yoW8Jr15pF
	Z8CFyfGFyxGFnIk3WDXay8Aw18WrWkXFWIgrW3K3s8ZFW2ya4vvF909r17Jwn3GrWvvr45
	A393KFZY9r4qya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pipBT5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiFR-4o2kGMU41FgAAsi

Add helper functions to clear or set bits in PCI config space.
These helpers reduce code duplication and improve readability for config
space modifications by encapsulating common read-modify-write patterns.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 include/linux/pci.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 59876de13860..bb0dba2b7aee 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1341,6 +1341,18 @@ static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
 	return pcie_capability_clear_and_set_dword(dev, pos, clear, 0);
 }
 
+static inline void pci_clear_config_dword(const struct pci_dev *dev, int pos,
+					  u32 clear)
+{
+	pci_clear_and_set_config_dword(dev, pos, clear, 0);
+}
+
+static inline void pci_set_config_dword(const struct pci_dev *dev, int pos,
+					u32 set)
+{
+	pci_clear_and_set_config_dword(dev, pos, 0, set);
+}
+
 /* User-space driven config access */
 int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
 int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
-- 
2.25.1


