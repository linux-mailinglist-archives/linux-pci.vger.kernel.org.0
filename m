Return-Path: <linux-pci+bounces-34311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC3CB2C804
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 17:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026EB3B91F4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28F7263C7F;
	Tue, 19 Aug 2025 15:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b5VQ9xd6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F79253B43;
	Tue, 19 Aug 2025 15:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615896; cv=none; b=f6kfMfpdbdIMeNAxW5wCaqvA4eJOrxfOfdl+0z+r4FbANoaX0Qlj32ysSvIDuhTguXUs3GVRcLExQZxfWCRid3ogctmd0yQZ7keh5lV3IWNGCZKnr+MaUPnp/0ChSZdDi191ZNHYssi9CqWdwoha5MqhyP+OSAgWpyi8ea2c4mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615896; c=relaxed/simple;
	bh=ILPotQqZ85MxrbibnWJjp1VU8yBCgoUBh7O0xDtRAQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OKbLMpQZC8cI5uwEuAsme+bcfFfBFwg3JlExfcIna0HaEZ0vfbm935BafjfgVKZ5Yk7AMw1+pd8hMtZFLDNiDfKZrvgNFRsffpM69FcYc7N/pPQYLW35SppTfbtrES6sT4p/QviWNDhfcb2onsIQQYW+wjm3pqptvH08peA5xP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b5VQ9xd6; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JDiwT3029537;
	Tue, 19 Aug 2025 15:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=6lO4ci5ORzCJ3X9hQWjZfIn59t+ff
	am7eIKMx47CEIQ=; b=b5VQ9xd6XBlvQWU7eejWavd0SKtcvr/+59b2HtFDf2Sva
	Gl+oykszGorzP8OjsP2/IvPfVL0s/dAAGOMyeRcAAlOXg9NKrBraPu3angC/hnvQ
	ReGBjInNGJC6yHOCB4jds6eBjrCZgJRQsxiBYJSYSFMdG2vDkCOGaIC4NXanGijb
	ynpyIck4BDDNDG4crX6TxISpg+QjzKlG0VpsUH87Fxj0TCrgYa3vh/WGRnNtexp/
	wx5qgWkAfzgAGThUCNczaJ6Ujyc5TIc+H1Zlp5/TGipgsVudwxXQHM2PA7pU6fYr
	5d4RkBgSI5TzCzvrsitmDGcH0Hz/p2QNZrDIKUKYw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jjhwwj13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 15:04:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JEYnx6037155;
	Tue, 19 Aug 2025 15:04:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48jgeb2cha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 15:04:43 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57JF4g23006487;
	Tue, 19 Aug 2025 15:04:43 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48jgeb2cgj-1;
	Tue, 19 Aug 2025 15:04:42 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: thierry.reding@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: tegra: fix devm_kcalloc argument order for port->phys allocation
Date: Tue, 19 Aug 2025 08:04:08 -0700
Message-ID: <20250819150436.3105973-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508190140
X-Proofpoint-GUID: viilppAg9P98f_t09kS6ZO04SU-0_wrc
X-Proofpoint-ORIG-GUID: viilppAg9P98f_t09kS6ZO04SU-0_wrc
X-Authority-Analysis: v=2.4 cv=G4wcE8k5 c=1 sm=1 tr=0 ts=68a4928c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=Rk0mUcj0OZC_4IGjiYgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE0MCBTYWx0ZWRfX9crAVmjNTpx+
 xMg2tSaHiVCM95yUklPxOgZMs72pTkf2vogjSKgb0C7cm6DnFZsj4cSvuCw2LH8Kyvx/yyk6dMg
 OTFgkYodsNUjQYdGJaKgqDObPHGINQCU1ASI8Rqsl1XTLDpB5YAcMPQV5ULVRfcm4G2fYzrn5fQ
 Y1Jz6x7jOqoUHcnOP++Uw06tEfIoGoYlF7g0Yv+9kK/a2/27y0Ik8u1SZqH2mCEjAD3DjhF1yv+
 PNXdOvtp98I41BQOYrjxQYzVyuR5BH7yGAyA5QDXBXUjE6u2MJdbIYNWOiZAWRP2bfQq8ti2n6q
 iSYcTVy1zuAmL3WRxToMnDiDnMtl0RoKEVBQPSy6HLTnm+jS/k/9i5SjvqAQ7OhkVS752iD671s
 717vT3IaINjuADIs3gguIEpor3YuaKpiZP95v1Fz01IQWexL9x2MQAeUX9lKpN8P+LG0dXAR

Fix incorrect argument order in devm_kcalloc() when allocating
port->phys, The original call used sizeof(phy) as the number of
elements and port->lanes as the element size, which is reversed.
While this happens to produce the correct total allocation size with
current pointer size and lane counts, the argument order is wrong.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/pci/controller/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 467ddc701adc..bb88767a3797 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1344,7 +1344,7 @@ static int tegra_pcie_port_get_phys(struct tegra_pcie_port *port)
 	unsigned int i;
 	int err;
 
-	port->phys = devm_kcalloc(dev, sizeof(phy), port->lanes, GFP_KERNEL);
+	port->phys = devm_kcalloc(dev, port->lanes, sizeof(phy), GFP_KERNEL);
 	if (!port->phys)
 		return -ENOMEM;
 
-- 
2.50.1


