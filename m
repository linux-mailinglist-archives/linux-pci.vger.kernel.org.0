Return-Path: <linux-pci+bounces-34606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C89B32012
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 18:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3CCFBA4A21
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6E92EDD43;
	Fri, 22 Aug 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WbftlpqF"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD1A2EE619;
	Fri, 22 Aug 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878593; cv=none; b=VTTDVi2ijRVJRoaEpkZaSgVIrz6YPZHbcmc/Zf7Tq64LijACB7utHPp0RDKg0qQyNKpjl0gvIFsk+zxPzuM8Mvr5iED+tnxfgteLfF7wHwPOo9+kThOPfxwy01ARw+jmlMC4ECinAjpU/zWMWbVzko6Ir9Gx5sEdWH9EDQUERtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878593; c=relaxed/simple;
	bh=nr3Ae750UOQEzP08Bo69gzr0P07LB02KeF46y/lUPf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZyPWEDkiAc1+oI4Wajp42OTFRFiYyvSzjppovzFs07SjEbV2kMZRRoFPvOKxVXtQZQgH/8+AoU3mBZBdQJR3T33rbweM1IwB2wfp1mlpkOkFN7BlQQwh7YyVRShPlGXGf/ITWAnAWOhNH8FqrFBZOIkElPskyKSdglnhxyYYWi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WbftlpqF; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pj
	MLZ/AH8cr5pUt0a3faTC4a4e2/NRtUHfVcVQQjNps=; b=WbftlpqFe34I90sWWf
	9oIKlki2wlIN1mGtVu2QYVe8uMdOgnDFnWPKe2qg4Zz/FVAmRIbc4rzmNi1A4bhQ
	jWKOLv0tm6E6Ba47Af5/0VDQ4YuKXKhYSullyrsl+6TuNF6SUyQrvKq2NwkZ5rOh
	MSHNeNbmIKPP7C2WHxX1W5Wlk=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnxDaplKho3jnHAA--.18200S9;
	Sat, 23 Aug 2025 00:02:54 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>
Subject: [PATCH v2 7/7] PCI/DPC: Replace msleep(10) with usleep_range() for precise RP busy checking
Date: Fri, 22 Aug 2025 23:59:08 +0800
Message-Id: <20250822155908.625553-8-18255117159@163.com>
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
X-CM-TRANSID:PygvCgBnxDaplKho3jnHAA--.18200S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFyxZFWfAr17Zr47Ar45trb_yoW8GF47pF
	WfG345A3WrXFyYkan8Xas5u3Z8tFnFkFyUGr97W3Z3ua4Ykw1UCF10ka4DXw1FqrZ5Xry5
	XF1ktrn8X3WYvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR8wIDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOh6xo2iokEFcmwAAsg

The msleep(10) in dpc_wait_rp_inactive() may sleep longer than intended
due to timer granularity, which can cause unnecessary delays in downstream
port containment recovery. Replace it with usleep_range() for a more
precise delay of approximately 10ms.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/pcie/dpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index fc18349614d7..ff0884d669b7 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -21,6 +21,8 @@
 #define PCI_EXP_DPC_CTL_EN_MASK	(PCI_EXP_DPC_CTL_EN_FATAL | \
 				 PCI_EXP_DPC_CTL_EN_NONFATAL)
 
+#define PCIE_EXP_DPC_BUSY_CHECK_US	10000
+
 static const char * const rp_pio_error_string[] = {
 	"Configuration Request received UR Completion",	 /* Bit Position 0  */
 	"Configuration Request received CA Completion",	 /* Bit Position 1  */
@@ -135,7 +137,8 @@ static int dpc_wait_rp_inactive(struct pci_dev *pdev)
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	while (status & PCI_EXP_DPC_RP_BUSY &&
 					!time_after(jiffies, timeout)) {
-		msleep(10);
+		usleep_range(PCIE_EXP_DPC_BUSY_CHECK_US,
+			     PCIE_EXP_DPC_BUSY_CHECK_US + 100);
 		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	}
 	if (status & PCI_EXP_DPC_RP_BUSY) {
-- 
2.25.1


