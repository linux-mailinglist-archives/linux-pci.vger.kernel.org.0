Return-Path: <linux-pci+bounces-32789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD394B0F0E9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 13:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809DB1884CA3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 11:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CF629B8C0;
	Wed, 23 Jul 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ROB5W2Ny"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A52C08C8
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269101; cv=none; b=PPTIksx+TKKLqZVv5ZiTcVH7b5oTJK70/QJhyvtMbjUaK0hpWHp2DRLdAkewVNRkdDCEmIMcZvks/I2pzFIEH47XeQA0XGN550SJ2x4yjJWY6WKzUaa6xh+BqraRj1TU17NiSe/V0lx9WzAS1spBlXofewhr30KfN0Wgz9XwqfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269101; c=relaxed/simple;
	bh=hCquMW8hz+iGzu9b5ro7FBBb12naHRGKWpeOqXGXr+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJDlKJgGc1lNaSVP3oKlj91Df5IZ0ZudLXt+se02hoBJOJfLryIE6LtFThXPj6EWyp5IkbI8mSRBoJde34Vj6OFQwsl+PNIhaEXXrdHm1CNezBYxUu3GR8zYw8sN+a4p7GNJUVmsfBiBAKFwD8nI+75OAxePaK0D9aEvHozj9SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ROB5W2Ny; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9RPYR012787
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 11:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=LjfOncO1vv2+YN0yh1RQX1suHT8F+x0/La6
	1z5ZuOPs=; b=ROB5W2NyRYVBz0VN44Oavxo+AXMs9X1Hi6gLpmZO0qDBjtGP020
	sop6q57ZlOcEgb4GO/UKjXpO2fS8UsqUdyNaEcP29HRjCI/lKaATMMuJ2G11ajHx
	XHoEs+U5Xq/57VBXycXYdFzIfyIe90rEp+oA6eNo/kj6wdtY9l4E4YH2sh9JlhEJ
	bLtXVyDDTe0Ll0YjoB5YV/AbK6+FcmIuPGf9l8lt96YAQKjyuPLZCRYMt258vhmn
	y+eXmAbKCNAenUVnI8PMAswfPQU4Y9McQ/V1xTQ34JYb8gToKS2pRGGFCfXATk/q
	NdkBa/K1P2aNbejyYFYJl1uwV0AkMGQKenw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na3aw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 11:11:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748f13ef248so6148841b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 04:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269096; x=1753873896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjfOncO1vv2+YN0yh1RQX1suHT8F+x0/La61z5ZuOPs=;
        b=nj9BpSLpt1FUMp/eBGTaga1vot1vCFrWNOmcMqj+1hxrvHWc3DFCTm7X8GxQMith9n
         eT3zhrG6pjbGPTO7CUmOd+X/1e+0/uutAoiAocRRqwliM88IYB8GCeqOT/i8Q7fQ8zOJ
         vOtUvdPtNwp/ZECjykXfrIUk5wuhQgrUwsBxmn5TqnxnzB5/FCntB8FM7CWo9xpjyhH2
         65qTlY+NdmNkuWdSnUb/v2QtgLa/F68wC0E8swTp3CKCj09jlwbGdm/BysSX5id+OSaF
         6CpzVbWxJPK2fCJY9u0UZzPp0LuK9lVEOvqm9aI/JB5iZJNUWRVlF+ie4vutuamOqSjY
         sDiw==
X-Gm-Message-State: AOJu0YyaP0JCFO+pVsj4mBVhQ2pKqZZeAxkwimqzgZ4js8NUnNdkuiYp
	kVraYyWJ+4tWSQzusSBjwPdisCqEDp5j1Cpe7hnNuWOsSWNxFU4TQK8jYXDtyYGgEyKcaTpXL1e
	YEtniWnfNuIS1FZTUrKizUC3U665mQUPPHUZDmlTvq+VGer1vEzHC8W1MT29PaBobmtiHWWQ=
X-Gm-Gg: ASbGncsKTF/gSuSjoofUXr2l7QowsJILcr3r3+R4H9Nzjck/5yTCZSJKrJt3Kicy5bW
	fJ3Wd3OqLN74tvqQTH5sHnJxjndYFMK2k8ztZ20K5MeCm3eXmvohrMMX9hw0J7RkqE9S0sa3lqf
	vCHlkDCnfLa4OjnDJ5xiNuyx2uFLrOGhP04/gPNuCGcV+yREjyf8oyQKv6uodKSiUmJCdlAnnh5
	4p1sBg8DydH9ZogGCPZRTUqAM5vd9TdoytpcJhKrrf6fhvkRgJq1d4FlJCOxOaxah8dFpgWoIAr
	ioJvl4mkEubepSa6heEGv97AqTASngyAW+DzS6fzzJJL8QELlJ7w4UY=
X-Received: by 2002:a05:6a20:1584:b0:220:e5e:5909 with SMTP id adf61e73a8af0-23d4906e5d7mr4082927637.20.1753269096490;
        Wed, 23 Jul 2025 04:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh3QrEmtBPfOc+uqORMvCzZ0j+Ls2REYh19xcaNQaRKIguYCvkAOkdIMlzRkqSP0UAb/qhgg==
X-Received: by 2002:a05:6a20:1584:b0:220:e5e:5909 with SMTP id adf61e73a8af0-23d4906e5d7mr4082892637.20.1753269096075;
        Wed, 23 Jul 2025 04:11:36 -0700 (PDT)
Received: from work.. ([61.2.112.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519f69ddsm1431836a91.11.2025.07.23.04.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:11:35 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Shuan He <heshuan@bytedance.com>
Subject: [PATCH] PCI: Remove redudant calls to pci_create_sysfs_dev_files() and pci_proc_attach_device()
Date: Wed, 23 Jul 2025 16:41:24 +0530
Message-ID: <20250723111124.13694-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bdmggF7a9hedHXWabFAdXzmVLjZTpoCP
X-Proofpoint-ORIG-GUID: bdmggF7a9hedHXWabFAdXzmVLjZTpoCP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5NCBTYWx0ZWRfX9TBt/+GWweXQ
 Ej8+/Im9MrcTnzqn9X8NjdDsb07g+gT8bK84l2lxxxoL0abb3J3ZJs7yHscNsxwjRKKs94xeKS8
 /ZpIeUywDb8S5OZCLgWxoTpfzgXWFXSCmEJIoGl5PnpN/KcOaueaquG0H0Hr2m4ONoqOuL8zbnL
 HEJD/OR5AW4mLXjnPU1fgONkGHWEK6YK1PHzsZAYELog1q6rUD1/p6A+bGfghUiHgVu0IPPcUaH
 B2pFMIbRW16Y+pamclPVjfz+7bbOtzn/mItQxv0agVAA/h4YELoZzGNqkDLv+k0JG9H3Gvt/coT
 4YKBqVrEcWX4llwo3VCdy/cVlFuDbmdpsYrMt0yCiMuVSEg6jt6O5h7D3w1e6GMgCrNc7UgDLMM
 4B9718EA1BtGCJCT89RN/oUyHCNMA4vCOqOEujPlsB6h23m0De6QNPTVNtvLy08zddbx+RGl
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=6880c369 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=L2vWZV9GmkZVUxua0bORKQ==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=968KyxNXAAAA:8 a=EUspDBNiAAAA:8
 a=vtPyk3adPmH_jGOTQ7gA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=766
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230094

Both pci_create_sysfs_dev_files() and pci_proc_attach_device() are called
from pci_bus_add_device(). Calling these APIs from other places is prone to
a race condition as nothing prevents the callers from racing against
each other.

Moreover, the proper place to create SYSFS and PROCFS entries is during
the 'pci_dev' creation. So there is no real need to call these APIs
elsewhere.

Hence, remove the calls from pci_sysfs_init() and pci_proc_init().

Reported-by: Shuan He <heshuan@bytedance.com>
Closes: https://lore.kernel.org/linux-pci/20250702155112.40124-1-heshuan@bytedance.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pci-sysfs.c | 9 ---------
 drivers/pci/proc.c      | 3 ---
 2 files changed, 12 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 268c69daa4d5..8e712c14e6ea 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1676,18 +1676,9 @@ void pci_remove_sysfs_dev_files(struct pci_dev *pdev)
 
 static int __init pci_sysfs_init(void)
 {
-	struct pci_dev *pdev = NULL;
 	struct pci_bus *pbus = NULL;
-	int retval;
 
 	sysfs_initialized = 1;
-	for_each_pci_dev(pdev) {
-		retval = pci_create_sysfs_dev_files(pdev);
-		if (retval) {
-			pci_dev_put(pdev);
-			return retval;
-		}
-	}
 
 	while ((pbus = pci_find_next_bus(pbus)))
 		pci_create_legacy_files(pbus);
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 9348a0fb8084..b78286afe18e 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -463,13 +463,10 @@ int pci_proc_detach_bus(struct pci_bus *bus)
 
 static int __init pci_proc_init(void)
 {
-	struct pci_dev *dev = NULL;
 	proc_bus_pci_dir = proc_mkdir("bus/pci", NULL);
 	proc_create_seq("devices", 0, proc_bus_pci_dir,
 		    &proc_bus_pci_devices_op);
 	proc_initialized = 1;
-	for_each_pci_dev(dev)
-		pci_proc_attach_device(dev);
 
 	return 0;
 }
-- 
2.45.2


