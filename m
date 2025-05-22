Return-Path: <linux-pci+bounces-28277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C50EAC10DC
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1B050274F
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 16:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3254F154BFE;
	Thu, 22 May 2025 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bYYy3qhY"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F305C1494DF;
	Thu, 22 May 2025 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747930576; cv=none; b=ODxVjnY8MXBvQ9gJZPZqw75ONLg2w6vJ9JJ0IXi32Nz7pLQE2NFxitXaV714DGEaQKKqxOV8Nv6e2toBhqfou3zO1j/roISQavXdy1wZye66fJo6dHlCH6uBvHYDkV2bvC8fh8tm+KjFVsc/qykYwBwLvC/FhG0AuoFrp4C9keQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747930576; c=relaxed/simple;
	bh=RKlmtOOjNUTn5OKb3TiOdJBECxNOmYVWkOdgZzFFWsk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tpf6MB6nAA39Dz2wP93n6Hd5iQI22xUQrjl/3rqP4rZaSxF8CZtluYQwiUgEayWbwyZ3htAjdbSwSLCBwfuI6DqtVF2M3mNsBKSyKvgkyycvHtM327AIBdW73qhY1tvWH/xbtgDACopp9+vIK5Npfuj7ScuHOHsBm2m8El3SK6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bYYy3qhY; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2e
	AsPXra0w35Puc8JmmnT+ZNd7jxaOPWj/+mEfcYg9A=; b=bYYy3qhYKYuhXx9pQL
	6++Kp9XVN4s1wVoKN6g7RGgz1/xWGyoRTLFExRQ7Uj1AkZUpRpOadWB8n+jU4fD8
	3N7HFnHKd5bS7zYDgSlETRrDniwy5NF33oZym9rLTswWXRd9g5WeFqNqiLPiVVdB
	Qd+YKjeuZ49BsR5YfaH84uDnY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wC3_jamTS9opM81DQ--.53642S2;
	Fri, 23 May 2025 00:15:35 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
	manivannan.sadhasivam@linaro.org
Cc: ajayagarwal@google.com,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI/ASPM: consolidate variable declaration and initialization
Date: Fri, 23 May 2025 00:15:33 +0800
Message-Id: <20250522161533.394689-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3_jamTS9opM81DQ--.53642S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWDZw1DCF47Wr4kZFy5Jwb_yoWDWFc_ua
	47Krs2kF40kF4akr1a9a13AasY9ayvqF17Wwn7K3ySka9rCr1UZ3ZY9ry5XayxWw43AFyf
	ur1qyr4UCry7tjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_yv3UUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhhVo2gvTRkNowAAsp

Merge the declaration and initialization of val into a single statement
for clarity. This eliminates a redundant assignmentoperation and improves
code readability while maintaining the same functionality.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pcie/aspm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 98b3022802b2..919a05b97647 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -884,10 +884,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 /* Configure the ASPM L1 substates. Caller must disable L1 first. */
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
-	u32 val;
+	u32 val = 0;
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 
-	val = 0;
 	if (state & PCIE_LINK_STATE_L1_1)
 		val |= PCI_L1SS_CTL1_ASPM_L1_1;
 	if (state & PCIE_LINK_STATE_L1_2)
-- 
2.25.1


