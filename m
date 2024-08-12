Return-Path: <linux-pci+bounces-11607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2694594F834
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 22:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9E71F20C3D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 20:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D865D186E30;
	Mon, 12 Aug 2024 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JfSMggBx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED716C854
	for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723494426; cv=none; b=gIut+b6aam8wCG1i4oJXn74AEcK6ve/qLKLVE2bEdNKT5rp54ADRHw8BZ8ZOeExlubH1qF+te3H0wgsTLhJ/8cXoPAZ1xylycYdQknN8OWXequNaw4anyT5UMAd347UEyNQvB1ETxvvPH9+OtwGkWKWBs7vHMmvcIExXuDVeDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723494426; c=relaxed/simple;
	bh=15hlsMYUK4tTZOgMf+gv8fiNu46JX8SSNLb2fpVdU1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6ElbXO6D8WnaV8dbchhkK19/F3f/hixa2A2QXys03RXctfh1XXZLuKmF30k/4TZP2eTZy+fZcqad7UdauwRv7y1TvKXLxajjzdlWGZzTo+WCCQTFDTWSMvAj9zjOcZTTrnGchNiz3n/6mYeeT0zKFo/wccxGZu7+SfxIFagHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JfSMggBx; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CKE2DT024101;
	Mon, 12 Aug 2024 20:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=a8Us0De3jWs9nJ
	//JzjhcHVbbn8VmikypXrDyzYxRkU=; b=JfSMggBxQ2mIle1s6mrFlYnzGrH8A7
	dwVgypHwgfc28LsCnr/LKYtQsiPFj42JpJc3uHu4YTQnzvLbpvqr4gH9taPSBkFW
	UfrO1XhjGnmbw3RJA+7HKoJa1gSeS1h44nrQGuzFEvbV44cWGvxUdzz2awrfcNDx
	rAoA9eXfGCXDSVIbwRb4jAZDocYzf1VLXStTS4GPGEwYEep6IkvM/vh9itV8ONme
	tpXb4gFvYWnHpCjMpQeUOUbbne6eDWGMlPMwUfIG4jfSN+HSwDTMLfOEwSiy/6dp
	8ANt7fLEr5TQfKyxfdbguDO5dQO0QoBDFX0NOLD4kAmwB/n0VT71WKbQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x08cm9qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 20:27:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47CJoAj1000737;
	Mon, 12 Aug 2024 20:27:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn7n4rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 20:27:00 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47CKQxFW031431;
	Mon, 12 Aug 2024 20:26:59 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40wxn7n4rd-1;
	Mon, 12 Aug 2024 20:26:59 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, samasth.norway.ananda@oracle.com
Subject: [PATCH] x86/PCI: Fix Null pointer dereference after call to pcie_find_root_port()
Date: Mon, 12 Aug 2024 13:26:59 -0700
Message-ID: <20240812202659.1649121-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408120151
X-Proofpoint-ORIG-GUID: NTL2e8lErAeXN0KquqMcGuy9P3BmPhh2
X-Proofpoint-GUID: NTL2e8lErAeXN0KquqMcGuy9P3BmPhh2

If pcie_find_root_port() is unable to locate a root port, it will return
NULL. This NULL pointer needs to be handled before trying to dereference.

Fixes: 7d08f21f8c63 ("x86/PCI: Avoid PME from D3hot/D3cold for AMD Rembrandt and Phoenix USB4")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 arch/x86/pci/fixup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index b33afb240601..98a9bb92d75c 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -980,7 +980,7 @@ static void amd_rp_pme_suspend(struct pci_dev *dev)
 		return;
 
 	rp = pcie_find_root_port(dev);
-	if (!rp->pm_cap)
+	if (!rp || !rp->pm_cap)
 		return;
 
 	rp->pme_support &= ~((PCI_PM_CAP_PME_D3hot|PCI_PM_CAP_PME_D3cold) >>
@@ -994,7 +994,7 @@ static void amd_rp_pme_resume(struct pci_dev *dev)
 	u16 pmc;
 
 	rp = pcie_find_root_port(dev);
-	if (!rp->pm_cap)
+	if (!rp || !rp->pm_cap)
 		return;
 
 	pci_read_config_word(rp, rp->pm_cap + PCI_PM_PMC, &pmc);
-- 
2.45.2


