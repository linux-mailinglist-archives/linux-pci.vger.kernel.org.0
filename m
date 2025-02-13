Return-Path: <linux-pci+bounces-21403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E253A3527B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 01:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DF407A451D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 00:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EA380B;
	Fri, 14 Feb 2025 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Qwi3OBhl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EB2173;
	Fri, 14 Feb 2025 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.183.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739492000; cv=none; b=s3Dn/cO4UKMNZZpYCkCUCiK9I8VSB7cw6E4/21fi5GAXR3iMLlqMfItH4NWEMlV5mlD8i8jL/YJhKvHM42fdgkPUAaBJETw/1Cc/3ggX0jnZGZYGr1TsL2n+0PT7iPJRjS/LnTBKmQu3OZY/ExsOdsf6BAXK37VRw0YKDcpT+OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739492000; c=relaxed/simple;
	bh=J8lfdNURsyQQwG/brZwueVqAFyDlbQLxSQQj/vw6JCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WGDP8FGwvenyU+dPyBEdQG8zjswMkgI81l2fKV7mM6nXHHdnxsX/jVBiiBDBLYvAKhmyhmGlGRy5Vb78oGKsDlFKy2SsPyfGd1yb935gvcEJvHBt5Cbveb9DJZVeUkjTytzeS/tOH4IUgbi9bUU7faW+UWLYlvumxbP62HqEMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Qwi3OBhl; arc=none smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DMBVvD005865;
	Thu, 13 Feb 2025 22:54:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=S1; bh=dOVBIbU7CeccHBPHc4
	No+HRUbQGRhXCcN5B0Wo/jQuE=; b=Qwi3OBhlguoApGv8LQIo9Eou0g/iyJtTMG
	v57yXxZlwBeExXzri/f7pWhN/ygW34pL+m/Z0PeYQwcsgFqa8cyybg3vmgIpI8Z9
	T+k+xZ40rPzWJjPxKsM6ADDBHmO3iofZafIul+yGECTbD6uEWRJIa8XP8abZXAU5
	RCAtzf7AGz2OlusO+VjluqZavAYIrf/fCfGiPsBhcoYhnPjSdftIyySqyKVLctub
	QyEbdSnUa2+HWi/KT0Do6KQQ11fnGvHGffv1hqABX1wQbfnpsS+I57svIp9cpCP5
	FnhHFTXxvlV7vmyNtInvG5SteQoRAAtbexRh04We7C8of53iV49A==
Received: from sgppsea02v.sg.gdce.sony.com.sg ([121.100.43.226])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 44p0rfngwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 13 Feb 2025 22:54:04 +0000 (GMT)
Received: from pps.filterd (SGPPSEA02v.sg.gdce.sony.com.sg [127.0.0.1])
	by SGPPSEA02v.sg.gdce.sony.com.sg (8.17.1.19/8.17.1.19) with ESMTP id 51DLDKQ9012983;
	Thu, 13 Feb 2025 22:54:02 GMT
Received: from usculxsnt14v.am.sony.com ([146.215.230.38])
	by SGPPSEA02v.sg.gdce.sony.com.sg (PPS) with ESMTPS id 44p0bn0de2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 22:54:02 +0000
Received: from pps.filterd (usculxsnt14v.am.sony.com [127.0.0.1])
	by USCULXSNT14V.am.sony.com (8.17.1.19/8.17.1.19) with ESMTP id 51DM62W1025105;
	Thu, 13 Feb 2025 22:53:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by USCULXSNT14V.am.sony.com (PPS) with ESMTPS id 44pnhvvph4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 13 Feb 2025 22:53:59 +0000
Received: from usculxsnt14v.am.sony.com (usculxsnt14v.am.sony.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51DMriAr125634;
	Thu, 13 Feb 2025 22:53:59 GMT
Received: from cronos-ws00.ad.gaikai.biz ([10.10.10.214])
	by USCULXSNT14V.am.sony.com (PPS) with ESMTP id 44pnhvvpg7-4;
	Thu, 13 Feb 2025 22:53:58 +0000
From: Maciej Grochowski <Maciej.Grochowski@sony.com>
To: kurt.schwemmer@microsemi.com, logang@deltatee.com
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
        linux-pci@vger.kernel.org, ntb@lists.linux.dev,
        Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: [PATCH 3/3] [PATCH 3/3] ntb: ntb_hw_switchtec: Increase MAX_MWS limit to 256
Date: Thu, 13 Feb 2025 14:53:19 -0800
Message-Id: <20250213225319.1965-4-Maciej.Grochowski@sony.com>
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
X-Sony-BusinessRelay-GUID: lpVoi5jRH5ThVpzvoGqDa1eB7_8pkQaN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Sony-EdgeRelay-GUID: dFo13wMvq61BJ-C2DEfQBC13pO0DgY9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-GUID: 1E1q9M_0U7ij98JiPvEw6bVKFEwhnpdp
X-Proofpoint-ORIG-GUID: 1E1q9M_0U7ij98JiPvEw6bVKFEwhnpdp
X-Sony-Outbound-GUID: 1E1q9M_0U7ij98JiPvEw6bVKFEwhnpdp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01

Microchip NTB switchtec devices supports up to 512 LUT's across all
NT partitions. This patch enable symmetric NTB configuration to utilize 
all 512 memory windows across 2 peers partitions.

Signed-off-by: Maciej Grochowski <Maciej.Grochowski@sony.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 51a3766b3f67..98cd4121bef2 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -29,7 +29,7 @@ MODULE_PARM_DESC(use_lut_mws,
 		 "Enable the use of the LUT based memory windows");
 
 #define SWITCHTEC_NTB_MAGIC 0x45CC0001
-#define MAX_MWS     128
+#define MAX_MWS     256
 
 struct shared_mw {
 	u32 magic;
-- 
2.20.1


