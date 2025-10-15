Return-Path: <linux-pci+bounces-38121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD63BDC5AA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 05:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1183AE4AC
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 03:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288AC258CF2;
	Wed, 15 Oct 2025 03:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DWE0tTWW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158F186E40;
	Wed, 15 Oct 2025 03:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499342; cv=none; b=eMj1Hdm5teBcI98ct6o3PiNmGbxxLs77qNhLNcU+NKtYFLgWDH/3ygT0MrQfiC4dqkjhc8bbBfxtwTLHbDMZB9lIXhyUPugbVJnaEVkTVdQo4zW3aB7MPrrdPdLTTSqXHJXoe9XpV+SpY4fyBHFgkKDGS4oYzWBBpALgjtJ1I2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499342; c=relaxed/simple;
	bh=jGco9AT5kCGcY76eM7VJ/hYgdU5/apACNaSLPEy/Y+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gzxy5Qcq3dxXiCzfdIOSzhB7TiVrfvbFLafr3G1MfdGekLsq4Tj6LkXEakSmXfuoFBlK/S5zrdcCfnvQDv63y8k96LtpwTILjjwVJn9JOM0aFxv1zKHS/sT9BBAC7El+gbwWnNnwF1Aa9+4gxcvXXOYUqorwpDdV/c9h3WGPmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DWE0tTWW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F1uL2M006345;
	Wed, 15 Oct 2025 03:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=Nsz/n3MJDgumfFy+sGm4rKM6nmsNC
	bqUDUHCE0nojDs=; b=DWE0tTWWYLDJ+ZFhLHT9H8LXKUMHFv57v6wR13NXm1Tvg
	lIGElKBZRDaI7fRv7an72i0LoktZoCrxCTP9CezExG+GOoGjfIW0O09n6XPSLG2z
	UdJn0tZG4v2WjBy8FRCZvWbZ/PNf8tfkZnpy4BrVBL1oA2zqM+jsBqnqcIVsjNZx
	xcwHv4y+ggNmWCLULHJ6uwyUwhy+/v2lEQadsteWlGMhIqsOHQJlSF8YtTPHADwx
	LFPntHgZJjdVWIyBwO4aSa7ckRR8PJx7iGlEew2Vl9ykOC+Diz6a45P+I1lLMQJ0
	yTrffHb9Sh4pOVTwHaqh8SVHYp9UKlNyoOFh33A2A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtynnw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 03:35:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2f7cc037444;
	Wed, 15 Oct 2025 03:35:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp9sndu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 03:35:34 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59F3ZYQC021912;
	Wed, 15 Oct 2025 03:35:34 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49qdp9sndn-1;
	Wed, 15 Oct 2025 03:35:34 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: bhelgaas@google.com, alex@shazbot.org, linux-pci@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, alok.a.tiwarilinux@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Correct MPC register write to use dword access
Date: Tue, 14 Oct 2025 20:35:28 -0700
Message-ID: <20251015033532.1545707-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510150024
X-Proofpoint-GUID: UcpxVHbrYPlLS9bVgAg07v1h1ZYGs8to
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfX5QAqYYIN4Lmx
 SMkrHTTcOXUCbhvsLog5YVQtje5s9ExY7LAofv6/bvq8j/oehWoaoIeVvX4iDSS56L7qlWGJhZr
 5yJwb53OfNegJHxmOQW/QBYszpCJ6Qzlm9th4Gdsam52IK7gZzIO212qoE1JXfEGge7OsK+VQXU
 LCUkQpFv2vZt7QuvcZhJXheD+7Y2XLx1LFDdERys12mg5BrKJNhPRnN/1EaUjY2+F/eOrdCH/qm
 lc4XBlUR6trE6igI5vVd5eTstA77t7uOB+OkFaVKzscjm3LPr9fCr58ufwC6IN6l7SOClU6UHoN
 vg7dtSh60QNN3z0CnTtURf2fyqk5V3dlz722X4YA7yS0llYOM7n7l9RmY5V4VZUXbtjVDX6ODKC
 CRpf9L4m42Hs2agcwPiB7N5mRB/8+A==
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68ef1687 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=ggRezBupM3_mbdqZsHsA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: UcpxVHbrYPlLS9bVgAg07v1h1ZYGs8to

The function pci_quirk_enable_intel_rp_mpc_acs() reads a 32-bit value
from INTEL_MPC_REG using pci_read_config_dword(), but writes it back
using pci_write_config_word().

Fix the incorrect use of pci_write_config_word() for the 32-bit
MPC register.

Fixes: d99321b63b1f ("PCI: Enable quirks for PCIe ACS on Intel PCH root ports")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 214ed060ca1b..1bd6e70058b5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5312,7 +5312,7 @@ static void pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
 	if (!(mpc & INTEL_MPC_REG_IRBNCE)) {
 		pci_info(dev, "Enabling MPC IRBNCE\n");
 		mpc |= INTEL_MPC_REG_IRBNCE;
-		pci_write_config_word(dev, INTEL_MPC_REG, mpc);
+		pci_write_config_dword(dev, INTEL_MPC_REG, mpc);
 	}
 }
 
-- 
2.50.1


