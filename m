Return-Path: <linux-pci+bounces-21394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83ADA351AC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 23:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C04616C9D2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 22:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F932753ED;
	Thu, 13 Feb 2025 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="mfDFaQVa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9672753EA
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 22:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.183.30.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487261; cv=none; b=KQwhfGBgwxv32w59bN8mZhymU0hmXdQRMN+H0ce/av43vsLNEsTguo8X5SjpSvR/nwoDwEjPT1V3UKdMGKemjXkXfh4KBrCbLwrBzrquJwGR/7KoKfD4kSv3RLQHqqZhZCZgIjdWZyKaq6aV4Aqr/5qTkvjDByWtClogwzboVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487261; c=relaxed/simple;
	bh=4sJVtUSZV5DCbBYo/FKqwGWgbqjpBe4x5gnO3LMl4ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1bkmbFYJQydnBQ2XEKNK/iCPkbOs5rRDCmDSb1ZElDexvUgOFNjum+6nKg36uBAod778U3pm9VKc1irUpaB4FUWxEis8r419pM0Gc9QQevu5V/FDpQvw5HLaewf6OX2itLD3qaAGePoJq7DblZS0eYzCXLlpH0b9jfX0G7vrwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=mfDFaQVa; arc=none smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DMPH01005547;
	Thu, 13 Feb 2025 22:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=S1; bh=k+yvTWxEteJcSK2IF9
	7K9DbxdiD+0v96dCzvMfoC4Rg=; b=mfDFaQVaCkSt6sXERbGdq6UzNOq7vXjbhv
	YgfIIKtq/J+6HN1FUtYvhD8Y2VU2fEgBVWxtLXm7Xql3FE+z7jVudwB3b6rxsCx7
	Khu3NQk+MfYxjfd3BGWuxU3gucnDDfXvluPZsxtPgY5qHUqKFtoijHstX8TTVmcI
	+Qgp4C/1Tga5v2VZQc0kcWa80lReHf1T6RdVr+e6D0zamOOsBsB8HjAcGR4FGZLx
	czCsgSTwXwS1XYPMOMBPFGJwV3zkfpD5Oe19y2jhfC8CYuC42Icqe3/P6E54T7kw
	XLzQOcT+oO6CEjTq+f6oWQdyUlqdn1Z50ltkM52mmp6Cv6ocMjaw==
Received: from usculxsnt01v.am.sony.com (usculxsnt01v.am.sony.com [160.33.194.232])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44p0ngn0ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 13 Feb 2025 22:53:58 +0000 (GMT)
Received: from pps.filterd (USCULXSNT01v.am.sony.com [127.0.0.1])
	by USCULXSNT01v.am.sony.com (8.17.1.19/8.17.1.19) with ESMTP id 51DKrJgP027746;
	Thu, 13 Feb 2025 22:53:57 GMT
Received: from usculxsnt14v.am.sony.com ([146.215.230.38])
	by USCULXSNT01v.am.sony.com (PPS) with ESMTPS id 44nxhfthwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 22:53:57 +0000
Received: from pps.filterd (usculxsnt14v.am.sony.com [127.0.0.1])
	by USCULXSNT14V.am.sony.com (8.17.1.19/8.17.1.19) with ESMTP id 51DM62Vx025105;
	Thu, 13 Feb 2025 22:53:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by USCULXSNT14V.am.sony.com (PPS) with ESMTPS id 44pnhvvph1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 13 Feb 2025 22:53:57 +0000
Received: from usculxsnt14v.am.sony.com (usculxsnt14v.am.sony.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51DMriAp125634;
	Thu, 13 Feb 2025 22:53:56 GMT
Received: from cronos-ws00.ad.gaikai.biz ([10.10.10.214])
	by USCULXSNT14V.am.sony.com (PPS) with ESMTP id 44pnhvvpg7-3;
	Thu, 13 Feb 2025 22:53:56 +0000
From: Maciej Grochowski <Maciej.Grochowski@sony.com>
To: kurt.schwemmer@microsemi.com, logang@deltatee.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        linux-pci@vger.kernel.org, ntb@lists.linux.dev,
        Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: [PATCH 2/3] [PATCH 2/3] ntb: ntb_hw_switchtec: Fix array-index-out-of-bounds access
Date: Thu, 13 Feb 2025 14:53:18 -0800
Message-Id: <20250213225319.1965-3-Maciej.Grochowski@sony.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250213225319.1965-1-Maciej.Grochowski@sony.com>
References: <20250213225319.1965-1-Maciej.Grochowski@sony.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Sony-BusinessRelay-GUID: qfs6c7YoaYPJF44IJ2MG_YZNCsRjYjmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Sony-EdgeRelay-GUID: hwZkNV2y2D-3l8_37FgVK5GIMHBVvEDc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-GUID: zpuSiJ7hHGTx41ppE8y8BWQXGEFnm_94
X-Proofpoint-ORIG-GUID: zpuSiJ7hHGTx41ppE8y8BWQXGEFnm_94
X-Sony-Outbound-GUID: zpuSiJ7hHGTx41ppE8y8BWQXGEFnm_94
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01

Number of MW LUTs depends on NTB configuration and can be set to MAX_MWS,
This patch protects against invalid index out of bounds access to mw_sizes
When invalid access print message to user that configuration is not valid.

Signed-off-by: Maciej Grochowski <Maciej.Grochowski@sony.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 6ab094b0850a..51a3766b3f67 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1316,6 +1316,11 @@ static void switchtec_ntb_init_shared(struct switchtec_ntb *sndev)
 	for (i = 0; i < sndev->nr_lut_mw; i++) {
 		int idx = sndev->nr_direct_mw + i;
 
+		if (idx >= MAX_MWS) {
+			dev_err(&sndev->stdev->dev,
+				"Total number of MW cannot be bigger than %d", MAX_MWS);
+			break;
+
 		sndev->self_shared->mw_sizes[idx] = LUT_SIZE;
 	}
 }
-- 
2.20.1


