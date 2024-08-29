Return-Path: <linux-pci+bounces-12400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5481496381D
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 04:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AB41F22A0F
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 02:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9491BF2B;
	Thu, 29 Aug 2024 02:16:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F6A18B1A
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 02:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724897801; cv=none; b=Y2Q+6mzYHLPNOCEAiDnbARqX5ZG7MsnKrjrKcOiw9wWiKX2PrUaz58zuy689B4tEMpzKnK2QLaD4nV1f9OF/Q4AwlH5lyhzP2i/P18X+mGY8IVpqLQZv1DDTBuWtXBJRAKTECfSheqEQ7gbHojHkNoyc5h2IWupHwM1VPXyIBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724897801; c=relaxed/simple;
	bh=6M9DJa+BeOCP9cxzO15+c9v1rJYVnBV58F06/myUqmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jqMugD3d83eukN3+pTrLdzdnZ67ontN5nVneBd1rJmzBq22KYNUN56X62iOC7OpgCWbE7PT3d2PbwrTY/OoKW2m2xNc5SeXUREbJNrZoeW6GwWA5mMIsVJ+QS7XKQQ8+g4gEoXgiIwuCGA3fzsL5vZ/tjj8vI0HmGQWR5HFVCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WvPsr6mcdzQr18;
	Thu, 29 Aug 2024 10:11:44 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 701A6180AE6;
	Thu, 29 Aug 2024 10:16:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 10:16:33 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bhelgaas@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-pci@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2] PCI/AER: Use PCI_DEVID() macro to simplify the code
Date: Thu, 29 Aug 2024 10:24:35 +0800
Message-ID: <20240829022435.4145181-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The macro PCI_DEVID() can be used instead of compose it manually.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Add the missing space.
---
 drivers/pci/pcie/aer_inject.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index f81b2303bf6a..91acc7b17f68 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -430,7 +430,7 @@ static int aer_inject(struct aer_error_inj *einj)
 		else
 			rperr->root_status |= PCI_ERR_ROOT_COR_RCV;
 		rperr->source_id &= 0xffff0000;
-		rperr->source_id |= (einj->bus << 8) | devfn;
+		rperr->source_id |= PCI_DEVID(einj->bus, devfn);
 	}
 	if (einj->uncor_status) {
 		if (rperr->root_status & PCI_ERR_ROOT_UNCOR_RCV)
@@ -443,7 +443,7 @@ static int aer_inject(struct aer_error_inj *einj)
 			rperr->root_status |= PCI_ERR_ROOT_NONFATAL_RCV;
 		rperr->root_status |= PCI_ERR_ROOT_UNCOR_RCV;
 		rperr->source_id &= 0x0000ffff;
-		rperr->source_id |= ((einj->bus << 8) | devfn) << 16;
+		rperr->source_id |= PCI_DEVID(einj->bus, devfn) << 16;
 	}
 	spin_unlock_irqrestore(&inject_lock, flags);
 
-- 
2.34.1


