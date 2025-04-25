Return-Path: <linux-pci+bounces-26722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39256A9BD58
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 05:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670441B67BBD
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 03:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2835D1AE005;
	Fri, 25 Apr 2025 03:48:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2817597;
	Fri, 25 Apr 2025 03:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745552912; cv=none; b=pYBOz/8pnSEemE61FObhjL2yV+hLO6DVGZE+xm6HSB0s5kbHqbcNMv/jCDlEWSSd8Hq/O92oEVn1CF1cCj3vcdAS/q+fuIrYDqS8iAZ5/htR+8maqHUmBuUUT7eAZL4FNh4wxLxHys7tVcyxUoHDQ/Y1u8LYbuViGR1qkbbZkIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745552912; c=relaxed/simple;
	bh=Z0dMxFVexGbQ2wF6mhtuCcGEoCqG3J60URgpBHBQSvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mx+2ZJtnYjyYjDtxnGk48JtS3qdbz7pLGwiRk7diG6kqETIRJm8KuWhAeB+Rm9NseuVez4QzNcJzuqHyXsnAAeJG1pQVhhZdxJlj2r6SHEpWWANBQpQDYCNoXJgSR5VFNPSVn8aWNiPteygbqF9Ki+E2OnEhMobVW3ot3jJJdY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1dceb0f4218811f0a216b1d71e6e1362-20250425
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f1b78c75-04d9-4f04-9152-1f5f29580cbb,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:25
X-CID-INFO: VERSION:1.1.45,REQID:f1b78c75-04d9-4f04-9152-1f5f29580cbb,IP:0,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:6493067,CLOUDID:4c8db667924b65262568c25bcabdc8ce,BulkI
	D:25042511481553MNVM22,BulkQuantity:0,Recheck:0,SF:19|38|66|72|78|102,TC:n
	il,Content:0|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: 1dceb0f4218811f0a216b1d71e6e1362-20250425
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1810698183; Fri, 25 Apr 2025 11:48:14 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: bhelgaas@google.com,
	rafael@kernel.org,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] ACPI: pci_root: Constify fwnode_handle in acpi_pci_root_remap_iospace
Date: Fri, 25 Apr 2025 11:48:08 +0800
Message-Id: <7ae7866ab8b897253703ecee44c688b6832d49a3.1745552799.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fwnode_handle passed into pci_register_io_range is not modified,
so make it const.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/acpi/pci_root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d0b6a024daae..74ade4160314 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -858,7 +858,7 @@ static void acpi_pci_root_validate_resources(struct device *dev,
 	}
 }
 
-static void acpi_pci_root_remap_iospace(struct fwnode_handle *fwnode,
+static void acpi_pci_root_remap_iospace(const struct fwnode_handle *fwnode,
 			struct resource_entry *entry)
 {
 #ifdef PCI_IOBASE
-- 
2.25.1


