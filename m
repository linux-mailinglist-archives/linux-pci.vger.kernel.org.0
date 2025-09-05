Return-Path: <linux-pci+bounces-35578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 555F7B46545
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 23:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34BC3B2725
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 21:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912012EDD7A;
	Fri,  5 Sep 2025 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dKugqIPh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A94284886;
	Fri,  5 Sep 2025 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106891; cv=none; b=dNzKa7Y9oNDdfu3Iw5Z0d8aQFs4RGgFwBRUo5791QvSXa0eMffE/ILe8+Kab/ZBmHzJDwuPBdOXBQUlQ2i6SBaaritqSQS3PCYI1okpYyR0mftyO1MN2eD70lB0HQfdUKUwqv4mz9IDVE9WDaQWyhzM1+ax603Uzd0Xx0cBuG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106891; c=relaxed/simple;
	bh=wT8x2IGgVEao6/cCmkDlAreApT8kXJlKNuy8RcfE5kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dii/bb7O3pUynsskugGgtSXH09/ogzpCHWnOJutVkuvb5M8gazPH4sDeVInDLIFC68RIT68Hcg5GSKBpKLL1XGLNuDLY9ubzCmWJzjpOG+pBS3UgIVQthS4mPJ/87aZwmu0d8ejD/u3I4jTpdKb1CyTkcAOdSCm1WDAyPoYXSWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dKugqIPh; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585LEe1h000688;
	Fri, 5 Sep 2025 21:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=MNTVaRidqIqXgAKjCzr+BWLK86N6w
	+7fH73KgXvjBA0=; b=dKugqIPhq9ZC+89Ri9k61+v/Yno3dFKMTAsRVWZHfTcQW
	j6VnbAulUJW4u6GsEP4VG9nbIWCLrhJEFevcbtHge8ppYtqASWh2BifrpqNRITaS
	hE8RFhZUVZDk0wulv+mxPtTvUHIrK5rAWb/FXkc3xrDakp2u3F8GTeK7Ux4Bd56T
	1hMZpR+buEhGlmgZINmDiB7TVNPT63icoryfDQPO6alWbcfOxSwi1K1gnL6y2OHT
	NcnNvqRf5Y3wKA7aKylL6oceZhF16jnb+QJRT3GuPadC8/S88sVeZc6vZAxKZbrX
	trnovOtZUBlrox6fNfbqOfv/SAkmgHmuyyiufEkOQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4907ktg004-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 21:14:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585JoCav033333;
	Fri, 5 Sep 2025 21:14:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrd4qvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 21:14:39 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585LEcuq038219;
	Fri, 5 Sep 2025 21:14:38 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrd4quv-1;
	Fri, 05 Sep 2025 21:14:38 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: vigneshr@ti.com, s-vadapalli@ti.com, lpieralisi@kernel.org,
        kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
        bhelgaas@google.com, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: j721e: Fix incorrect error message in probe
Date: Fri,  5 Sep 2025 14:14:34 -0700
Message-ID: <20250905211436.3048282-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509050209
X-Proofpoint-GUID: yjoYByN9Zdo31DNY6AEfeu0WOeY1RLep
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDIwOSBTYWx0ZWRfX7Dv9FNCmvvf3
 in+cAPNtPOam6g7FcUOaEcgI3VwbLkiSCe/oFlLyTSltTsosiFhdfA3mlqQ1W2qnIIyYLNaA9lA
 EUMuGNdm7e7yy8MzV7ZQbOH+g9C124Njm6iHHx7Z1UgzM3sFb6kIre95FiPEeY0JmSgkuYxZuu8
 U6RqbJ3t8zpLiONRxnpHnfCXu9NS6AHIr4pE2fZMvxKLY3Y1PQnpotyD2D6ZyUTJ0tZg9ywein3
 MyHxJR2gsfsDorJy6WdkkHk+sKyofb9KEcdz9fsZzIeJ5IqfFsGpWplyjKYsHK2+osRVJh3bauL
 eC1maQsYSv0c71zxSdAXCe7QBP2c66EXq/PweM4Y/U+UGJmRNl9Cpf+w2qrcMXUrFcac0f7BQzG
 qlybUAoN
X-Proofpoint-ORIG-GUID: yjoYByN9Zdo31DNY6AEfeu0WOeY1RLep
X-Authority-Analysis: v=2.4 cv=P9Y6hjAu c=1 sm=1 tr=0 ts=68bb52c0 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=kyFhivpCSvuUZvO-LAYA:9

The probe function printed "pm_runtime_get_sync failed" when
j721e_pcie_ctrl_init() returned an error. This is misleading since
the failure was not from pm_runtime but from the controller init
routine. Update the error message to correctly reflect the source.

No functional changes.

Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
Not sure if a Fixes tag is required here
---
 drivers/pci/controller/cadence/pci-j721e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 6c93f39d0288..5e445a7bda33 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -549,7 +549,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	ret = j721e_pcie_ctrl_init(pcie);
 	if (ret < 0) {
-		dev_err_probe(dev, ret, "pm_runtime_get_sync failed\n");
+		dev_err_probe(dev, ret, "j721e_pcie_ctrl_init failed\n");
 		goto err_get_sync;
 	}
 
-- 
2.50.1


