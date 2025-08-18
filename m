Return-Path: <linux-pci+bounces-34208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23824B2ADE0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 18:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016723BFFB8
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 16:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFB41D5174;
	Mon, 18 Aug 2025 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nyVfvql5"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC74322546;
	Mon, 18 Aug 2025 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755533722; cv=none; b=kQiIZQk8wwr0FrHEjd6ASrBEz8O6t5W+vrSBEpFb2y+blug1MkEpImkCjMiq+8L2sAqk4cnbp3QRFlbwLVQOACUE6MNGzG4syO+QPCIcC8b1k0Qo2ZcmJWLc/qlHciDkKaOAqKLl7h8XFKzrNwkxkny0oj3S7n7RhLHPo8qPS9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755533722; c=relaxed/simple;
	bh=9Ud/LeNIcKwL0efzQzPowgMKrjbEYWLDeh1PO30vwtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UL2IyCm5OmKuP6oOu7NpOoGeQXHU+U1c+8XW0q7trnNfct2iDNNKaM1dXus12uoulGbCQLLcuuve/hbOQKtOL9bJ/Mts0ns5I5oBIgfpCCfeCNxIMo/2SMkr7wWWhap1N5t9gYP38oI2DovWuvTtW5VxKdZ6e4W4Z1NNWEs12cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nyVfvql5; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3V
	QIEWJRrZqUWBIlYJxpy6ioV+MlB2SKV2d469TV62M=; b=nyVfvql5VzH3VYcRvZ
	HkByrzNJt+wvtJLajSfmebqiaWrMCh+O1OhoMshxkui7bwmRW8C37rdAdQLG3CHc
	ErE9jMHHVtQZRysrgFi4w0XpKv4u7/H7j/zL1I9HXRHnrkW6V/t4B+axJGkompxS
	bdlMw+1Tx6z08riI6+hCCouAg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3b8FtUaNopYAWCw--.8667S3;
	Tue, 19 Aug 2025 00:14:41 +0800 (CST)
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
Subject: [PATCH v4 1/2] PCI: Introduce pci_clear/set_config_dword()
Date: Tue, 19 Aug 2025 00:14:30 +0800
Message-Id: <20250818161431.372590-2-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250818161431.372590-1-18255117159@163.com>
References: <20250818161431.372590-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b8FtUaNopYAWCw--.8667S3
X-Coremail-Antispam: 1Uf129KBjvJXoWrKw4rWrWxKrWxAFykCry7Awb_yoW8Jr15pF
	Z8CFyfGFyxGFnIk3WDXay8Aw18WrWkXFWIgrW3K3s8ZFW2ya4vvF909r17Jwn3GrWvvr45
	A393KFZY9r4qya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR5rcfUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw6to2ijSyq4ngAAsX

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


