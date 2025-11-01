Return-Path: <linux-pci+bounces-40033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBEBC2820C
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 17:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6929E3493BB
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 16:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC362F9DA7;
	Sat,  1 Nov 2025 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XLT4nuyE"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488211DED42;
	Sat,  1 Nov 2025 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013168; cv=none; b=BRxyt4BRV6RHhwiaMDSX1ZKvSjvKAjUUT4gfmc4UU123LoczBuuENpiHr6AkfZmNlol9rEcoMcnJFEx8NNwXeFXnT+JFd9nmkEKs9EoL5CGTqdje1FEsCPE1scJDGoQSjhZkyEf03Rv1k0Eq73nxDhcloErFbH/8gf84BtpNNMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013168; c=relaxed/simple;
	bh=qGBRO2c6Apw9WL+MuNeqKXnc+l5yjmXHbbw5ebuF9ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fBfdEtV5TWpVtUaepb/m6DlKjj48ZQcK+9Ya+uLToQ2T1CKg/rGcT4vs9YIiisFXyZeQlMf0EHY8lwNNYxYLlMBI0/mh/0KeqhKl3fJQbj+wvw1Md+bdNA6LorI1R0OJKN5VDBI828elEkOEBNvi1bh9kx6XmLiqs4zRQ/baXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XLT4nuyE; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=i+
	y4KPWUsBAQQaupLuRxWCTWo46ly/Fkjsxz8IWvoFo=; b=XLT4nuyEViRet9kwtx
	o4avf3gLD+k9Jax7H0j0LNkGj5ICyk/gMssGs6l0JiSs12mQvJxeFHULoFgdvbjl
	jHFo/HwkIlbIriP32NpdXoJMioRrXcCvIiBgtpnNWg2Go2k0bOeKB/zvg1H4Fapc
	l+I7wOVYb4M0QEn0DBTWcQAZo=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXL4nTLwZp3qOtAw--.844S6;
	Sun, 02 Nov 2025 00:05:42 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v4 4/4] PCI/DPC: Add macro for RP busy check delay
Date: Sun,  2 Nov 2025 00:05:38 +0800
Message-Id: <20251101160538.10055-5-18255117159@163.com>
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
X-CM-TRANSID:_____wDXL4nTLwZp3qOtAw--.844S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrykKrW8CF4UZF18Kw17Jrb_yoWkAwb_uF
	yFvryIyrW5CF97C3yYy3ySy34UA3Z7Zr1xWa1FyFWfZr17trnrJrZ2vw15trZ8W3y5XFy5
	Aw4DJ34Yyr9rGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRK9a95UUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhn4o2kGKs1hDAAAsd

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
2.34.1


