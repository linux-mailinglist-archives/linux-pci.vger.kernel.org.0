Return-Path: <linux-pci+bounces-12336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB32962508
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 12:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D357F1C21A19
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 10:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A89916B3BA;
	Wed, 28 Aug 2024 10:34:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A4158DC2;
	Wed, 28 Aug 2024 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724841261; cv=none; b=JWIklL1TLNIG77IIP9aBsSXPUke31U3vXGeIp3ZJtDMnUVyJMiKBkLOQ5XeVoVdQXGUncuJ8mK+0cwk+zmjv/q7D3X8Az4xy2uUgtPnsg/CkNH0smxglzVqUBStM7QA22ciVB0mJEozNVm+Q6OWsPx9vZGzgQ34ob0kX4An70ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724841261; c=relaxed/simple;
	bh=IsciTWXLRKrtdbV5tFK0VLAe3jzCVMg6faAKX1mHmPA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sGDk5ZWRytT7nAEqaGiX5rYKvco97xACEnzGiXS+ahfe7T0j8JMk0AgLxH0/R3eXMpl4fSrPxQ8RCgrG2VUmM8XiaTlcPw9vPql+qzg2qbRZXUy0gF+12hK1ByF2Va9/6ZBXudhgQ7PzhOXH29ukUrvHwFTVGmn154Avahydsu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wv13v6wR7z2DbZw;
	Wed, 28 Aug 2024 18:34:03 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 464AC1A0188;
	Wed, 28 Aug 2024 18:34:15 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 28 Aug
 2024 18:34:02 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <joyce.ooi@intel.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<manivannan.sadhasivam@linaro.org>, <robh@kernel.org>, <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] PCI: altera: Replace TLP_REQ_ID() with macro PCI_DEVID()
Date: Wed, 28 Aug 2024 18:42:02 +0800
Message-ID: <20240828104202.3683491-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The TLP_REQ_ID's function is same as current PCI_DEVID()
macro, replace it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/pci/controller/pcie-altera.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index ef73baefaeb9..650b2dd81c48 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -55,12 +55,11 @@
 #define TLP_READ_TAG			0x1d
 #define TLP_WRITE_TAG			0x10
 #define RP_DEVFN			0
-#define TLP_REQ_ID(bus, devfn)		(((bus) << 8) | (devfn))
 #define TLP_CFG_DW0(pcie, cfg)		\
 		(((cfg) << 24) |	\
 		  TLP_PAYLOAD_SIZE)
 #define TLP_CFG_DW1(pcie, tag, be)	\
-	(((TLP_REQ_ID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
+	(((PCI_DEVID(pcie->root_bus_nr,  RP_DEVFN)) << 16) | (tag << 8) | (be))
 #define TLP_CFG_DW2(bus, devfn, offset)	\
 				(((bus) << 24) | ((devfn) << 16) | (offset))
 #define TLP_COMP_STATUS(s)		(((s) >> 13) & 7)
-- 
2.34.1


