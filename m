Return-Path: <linux-pci+bounces-12335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39ED9624F2
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 12:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9DA1F2146D
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 10:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C9515445E;
	Wed, 28 Aug 2024 10:31:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A11465AC;
	Wed, 28 Aug 2024 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841099; cv=none; b=KypaNNUPMu0uKFFGSmPSi0Pmx3QVIk6EWDS9KSL5YqXBvMUrdwEf4vHtLOCsw10J3zQ8Q2Hsa7KrztICrrYJhQm9SjetwolXYC6trA/vjH1L4Ff5UAALDD2mwVc0KIWbv5fo1D5TpYe7N8v3IIqVZenhXtgogRM2FfK8MtZ642M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841099; c=relaxed/simple;
	bh=QRAwYgh9eGHdoE/47Rrh+DFUgXs1BqJ099KnqecGjL4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tsddw2zTxXgHbhZlzpP0MoQb/hv61ubRGjnyUuXuW2FKdn89qhsRL8624HrqEzhup0FSs3Y33+WObMjxFXwWgQMJVgHAa05vJ8xNO4QlVdXhJAusBoKXmF1Lsk1I1EZ+jzQF9i9kfNZgi0/O8We05tly5k+AnOarw/GXA1oFFbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wv10q0bt7z1j7bK;
	Wed, 28 Aug 2024 18:31:23 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 33CE714013B;
	Wed, 28 Aug 2024 18:31:34 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 18:31:33 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <bhelgaas@google.com>, <ruanjinjie@huawei.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] PCI/AER: Use PCI_DEVID() macro to simplify the code
Date: Wed, 28 Aug 2024 18:39:28 +0800
Message-ID: <20240828103928.3683377-1-ruanjinjie@huawei.com>
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
 drivers/pci/pcie/aer_inject.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index f81b2303bf6a..7383e9f69faf 100644
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
+		rperr->source_id |= PCI_DEVID(einj->bus,devfn) << 16;
 	}
 	spin_unlock_irqrestore(&inject_lock, flags);
 
-- 
2.34.1


