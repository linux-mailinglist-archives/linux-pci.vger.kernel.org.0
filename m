Return-Path: <linux-pci+bounces-27876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 410E6ABA10F
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 18:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1CA4170B8B
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994A21D63FC;
	Fri, 16 May 2025 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mfbsT3ko"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D952AD0F;
	Fri, 16 May 2025 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414392; cv=none; b=kJuSby9qjU4ZZuPl3z0PoYGFR6lHBBhTsBYzIjijWFQSEmxOz4KxQ2s7dZAlJ9IrICxd/cW6/ZEnL35/yQuP47SF23qJbVTZiQ0bdX+CasqEB09AQNIt3VaaRqgmHu7PF+HkpINJwDtzaYmtoardBB/BPlywvH73lJdb9FG+F0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414392; c=relaxed/simple;
	bh=71V2WD5iJ1/cS/2PgOjbEu21WKvPBUiTc4SL8cYGR2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2kVU2ruZQ+iB/UIb7hZYJP/qFM6FMo1crV1v8zbiDONNBy4MJh0JQC7ZlTmdCpeGoeZtv9w7mria9RiPZ25oRBQrwdgPvB4cJ4PzVnDN34QFxIRU+eRmu4X/tvsOtPo5qaOg4w2M4Qhwp6PbV7E2WeMvtY/KkBMPSjB1w+YIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mfbsT3ko; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qY
	XamXMCEiPr/RpJK9bkK+Cvqo2tYDscATM5TdHK+B4=; b=mfbsT3koj4pL2eQgt5
	ThcfNFwpvyuWE5VC3SHViLKE4U0YRfhOaDVFJTEdyk4vdwNy7eEKXEknn51Xj5DO
	Yji5EnRnFQBB+vMeyhwdITCrme9CHAvoYPPLw4/CSUSYA4kcGwSVZ/OiU+5W7bW4
	vnoRFXqXCh0YdKNyY1sVovn/U=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDn1+RLbSdo12CoBw--.59952S4;
	Sat, 17 May 2025 00:52:29 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	tglx@linutronix.de,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	mahesh@linux.ibm.com
Cc: oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH 2/2] PCI/AER: Use bool for AER disable state tracking
Date: Sat, 17 May 2025 00:52:23 +0800
Message-Id: <20250516165223.125083-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250516165223.125083-1-18255117159@163.com>
References: <20250516165223.125083-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn1+RLbSdo12CoBw--.59952S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr4kCrWDXrW7ZrWfAw1rCrg_yoWfWFg_ur
	yY9a17Gr4Y9rsxur1YkrsxZry0va4qvFWIgF40qa4fCFy2kr15tF9rZr1fAF4DWryfJFyD
	u3ZrAF13CryjkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8aFAJUUUUU==
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxVPo2gnaDZ9cQAAsr

From: Hans Zhang <hans.zhang@cixtech.com>

Change pcie_aer_disable variable to bool and update pci_no_aer()
to set it to true. Improves code readability and aligns with modern
kernel practices.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 drivers/pci/pcie/aer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a1cf8c7ef628..ade98c5a19b9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -111,12 +111,12 @@ struct aer_stats {
 					PCI_ERR_ROOT_MULTI_COR_RCV |	\
 					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
 
-static int pcie_aer_disable;
+static bool pcie_aer_disable;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
 void pci_no_aer(void)
 {
-	pcie_aer_disable = 1;
+	pcie_aer_disable = true;
 }
 
 bool pci_aer_available(void)
-- 
2.25.1


