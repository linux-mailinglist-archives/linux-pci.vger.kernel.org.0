Return-Path: <linux-pci+bounces-34039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09842B2614B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 11:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E001CE225D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 09:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1437B2EBB96;
	Thu, 14 Aug 2025 09:39:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690BF2EACE7;
	Thu, 14 Aug 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164385; cv=none; b=VEA6OtG9dyywdR4IVDsniD3p8dpcnmGf8pv+HCDuOuDOTPdVCfSi5istG0TIqkexL/T3PPHlAztoX+8XiEgr5neZPXPSp7su8dBrmyfxAakqS34lWQ3BRi+t5a9VfubFCg7PVlqTIqJ9mBHxGMncqapztmrnuFoWyWsIrhAR1sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164385; c=relaxed/simple;
	bh=PphOKgCVg1ij/u5zEePdGoeIcFXzNrvWI/xh76qw4Ec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C0lpd5M2j/MHsjH4dAjL1zd6wLG8h/dlLmwWGt7N4W1/pKyF+++pjRf5bzEYIWNqoNHPiDpW4a/UtNceVtRAn7xu9qfxAK0RcAfsDh/ELXaa53oLqkkUTvvUvtBiaYZXk42aV98JrYJ4bkncO6dsKnq2un0AZ0It6E9EEnAghME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57E5bOD21474607;
	Thu, 14 Aug 2025 02:39:41 -0700
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48fvk22wrk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 14 Aug 2025 02:39:41 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Thu, 14 Aug 2025 02:39:35 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Thu, 14 Aug 2025 02:39:33 -0700
From: Rui He <rui.he@windriver.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Prashant.Chikhalkar@windriver.com>, <Jiguang.Xiao@windriver.com>,
        <Rui.He@windriver.com>
Subject: [PATCH 1/1] pci: Add subordinate check before pci_add_new_bus()
Date: Thu, 14 Aug 2025 17:39:37 +0800
Message-ID: <20250814093937.2372441-1-rui.he@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDA3OSBTYWx0ZWRfXz245HfK7SlOY
 DDeqLuZe8aAzP2/LDucucVEYobtdYhMd3ZdYyz7oCjkruHC/3PtZDm1XRjMlWbVxldIT8uxyy4R
 6eSIZp92YhXiK6VR4/3YTa2ITbplLyoRWudHi6RqRu6sEaWyi16V6y8VlKHCOP9bftyMBzyNBYC
 eju1Cd+4PaZ6OC0SU1LqPdvVMh5/YBH0NsyDQkuiZDxPzMfSCJ0ENUD5xYxB4pCdvubnlGIXa9q
 HbwIBT48wGCRqlbTy6UiDzONwOVrQSp9f4hDcpzA6YKt08DhQTbT9nCeDFv6+juZAp7jf0RRQW1
 YccoViS/EB3nkO1CnYkV/Ye+4ntLR5aEweR+Zk637X48cHAGVd00fw6YWIBuHs=
X-Proofpoint-ORIG-GUID: opu1I4NEu_CSml5-GNIvxABnQ7SlxkyM
X-Proofpoint-GUID: opu1I4NEu_CSml5-GNIvxABnQ7SlxkyM
X-Authority-Analysis: v=2.4 cv=PsOTbxM3 c=1 sm=1 tr=0 ts=689daedd cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=2OwXVqhp2XgA:10 a=t7CeM3EgAAAA:8 a=KwTOwRFcXMM_fQDvAMoA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

For preconfigured PCI bridge, child bus created on the first scan.
While for some reasons(e.g register mutation), the secondary, and subordiante
register reset to 0 on the second scan, which caused to create
PCI bus twice for the same PCI device.

Following is the related log:
[Wed May 28 20:38:36 CST 2025] pci 0000:0b:01.0: PCI bridge to [bus 0d]
[Wed May 28 20:38:36 CST 2025] pci 0000:0b:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[Wed May 28 20:38:36 CST 2025] pci 0000:0b:01.0: PCI bridge to [bus 0e-10]
[Wed May 28 20:38:36 CST 2025] pci 0000:0b:05.0: PCI bridge to [bus 0f-10]

Here PCI device 000:0b:01.0 assigend to bus 0d and 0e.

This patch checks if child PCI bus has been created on the second scan
of bridge. If yes, return directly instead of create a new one.

Signed-off-by: Rui He <rui.he@windriver.com>
---
 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f41128f91ca76..ec67adbf31738 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1444,6 +1444,9 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 			goto out;
 		}
 
+		if(pci_has_subordinate(dev))
+			goto out;
+
 		/* Clear errors */
 		pci_write_config_word(dev, PCI_STATUS, 0xffff);
 
-- 
2.43.0


