Return-Path: <linux-pci+bounces-34777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D254CB370EB
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 19:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B7A8E4162
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26636C06E;
	Tue, 26 Aug 2025 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hu/amXSM"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CBC2E1C6B;
	Tue, 26 Aug 2025 17:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227846; cv=none; b=scfXp8gJuYUHtgkb4CPoEOMHY8nv31/z4T9c8GkNWdVLc/NS3FzH5Jn10He3NOx/pCmaRLSZIjA3hBpwnkxfat2yxgsD5sWkv2reLx7cYIOmh/hkEB3T4g+FulKNM6LE8Ca70hZu4yJIAY6pgnj4/uUnIma0GucGiVfIHwc0EwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227846; c=relaxed/simple;
	bh=RxbC6PRS5UWfVRhBWgHNMi2OVDBcE6RBrjCc4GiojgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LbuL0z01oZrTeBr+OYWO7rwxqp1evxfubyQsgbyNfb2l6f5hnYIONGjgTwacX2t0PcvfQtJPpMJrSFollLSB/+uhB0BdDmlO7rg5zqHgFC6qtlyZRqjuWx2v+wcLwqpv7mK1L8U1AkVMeI5g0316jLLSRRZzwh6Ot5mXX/1dopk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hu/amXSM; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Uo
	wts4zfhr1/6N6PWGm/8Hg/npgCEGN+e6f6uoDvA5c=; b=hu/amXSM7XLdQPpe7l
	i+P+6dog+H2WCavBl60be1kawaf193WAkTdk28pVOiztE7/0kUCk3jXfUuvubFvc
	YVDBf+FsgvoX8CToIx9YVTnJChoWRdr/MrmiXDKKWOWrvtMEYaMxGlcQHbrZ1Kt1
	5rIPolhigc+gGNdkRRtwdX8uE=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH5Svt6K1o9DIiEg--.25085S10;
	Wed, 27 Aug 2025 01:03:45 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v3 8/8] PCI/DPC: Add macro for RP busy check delay
Date: Wed, 27 Aug 2025 01:03:15 +0800
Message-Id: <20250826170315.721551-9-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826170315.721551-1-18255117159@163.com>
References: <20250826170315.721551-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH5Svt6K1o9DIiEg--.25085S10
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrykKrW8CF4UZF18Kw17Jrb_yoWkAwb_uF
	yFvryIyrW5CF97C3yYv3ySy34UA3Z7Zr1xWa1FyFWfZr17trnrJrZ2vw15trZ8W3y5XFy5
	Aw4DJ34Yyr9rGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_wvtJUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgC1o2it5y8lTQABsI

Add PCIE_EXP_DPC_BUSY_CHECK_MS macro for RP busy check delay.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pcie/dpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index fc18349614d7..bd5e8cd9e43e 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -21,6 +21,8 @@
 #define PCI_EXP_DPC_CTL_EN_MASK	(PCI_EXP_DPC_CTL_EN_FATAL | \
 				 PCI_EXP_DPC_CTL_EN_NONFATAL)
 
+#define PCIE_EXP_DPC_BUSY_CHECK_MS	10
+
 static const char * const rp_pio_error_string[] = {
 	"Configuration Request received UR Completion",	 /* Bit Position 0  */
 	"Configuration Request received CA Completion",	 /* Bit Position 1  */
@@ -135,7 +137,7 @@ static int dpc_wait_rp_inactive(struct pci_dev *pdev)
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	while (status & PCI_EXP_DPC_RP_BUSY &&
 					!time_after(jiffies, timeout)) {
-		msleep(10);
+		msleep(PCIE_EXP_DPC_BUSY_CHECK_MS);
 		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	}
 	if (status & PCI_EXP_DPC_RP_BUSY) {
-- 
2.25.1


