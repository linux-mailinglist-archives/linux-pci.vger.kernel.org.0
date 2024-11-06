Return-Path: <linux-pci+bounces-16173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2C99BF901
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 23:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE2E1C21DD5
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 22:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB90220E300;
	Wed,  6 Nov 2024 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jlJ6rgur"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B920E00C;
	Wed,  6 Nov 2024 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931259; cv=none; b=WSzLHPmxbMSK4U+4EVJSaUrgUlQX+6rmByTXrR20YzwZCWI468dIbaqrwaLsBDR2BFZzKL15dR1GTdEQ2WPfErWCSNZZFkm0GbbZM5zN1T1cFcW/AxP/hiM54KYGjkprYkKrm8DfyzfSIPXgUuIGi6SCmOB5NIKhu0jzMYpxNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931259; c=relaxed/simple;
	bh=Y6LScksg2j214FZ2e3xWv+35HKasJ2WnUvOLl4WuLSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjPA21Kh48yREfn2hlQdWD3QkIR4iTWUxjshcqpmflwONEfjBJTR/gSTXIfLfbNLJHkohVV59N31b7mJOhqT1V4Vp6Lizdd0mOlUNTdbdqCVhABPhtctNAIIZeXzFAoHGRqaDfSOnnP2ACyDg7CYZ3PsMMAi916jJeaPlk/KWTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jlJ6rgur; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A69plnL015613;
	Wed, 6 Nov 2024 22:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4HHoFSioX8ZCazDOVUQkvJrNCnJaYY5Xp1d5eH1BtVQ=; b=jlJ6rgurSHUbvoZs
	B0sm4HXHv1Xsw1TZzq1VFov3stno9FSn6IfBPTiOqpRDPQDhL53SVqBkTmlOVCEQ
	KW0qk0Gvc8I9yQnWfz0AHmQ9IRiGQurmMCrZ3n8FA0uWeRzj81WghLaHbQimdDva
	AGv1u3lxd6XpCMJS0URogfnN7+VifYf4vUxqNoJa3r7i9VAhmqSxpDqBLokwW0PS
	FoQA9yKybJZF4b3j18Drh+gkOY5eFiP1X/S6icFTbZjreJbJ/FBYKUBq9d+FWKOY
	ysLuLoXiI5avIAg5vN4FATRPtKUk/RA7nC938RmL/bUf/Ta/tQ2VQi8beHBMeAQg
	IXmSyw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42q5n8q0yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 22:14:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6ME56a011643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 22:14:05 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 6 Nov 2024 14:14:04 -0800
From: Mayank Rana <quic_mrana@quicinc.com>
To: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_krichai@quicinc.com>,
        Mayank Rana
	<quic_mrana@quicinc.com>
Subject: [PATCH v3 2/4] PCI: host-generic: Export gen_pci_init() API to allow ECAM creation
Date: Wed, 6 Nov 2024 14:13:39 -0800
Message-ID: <20241106221341.2218416-3-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106221341.2218416-1-quic_mrana@quicinc.com>
References: <20241106221341.2218416-1-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ccNrpXjmagCKBYi2_Etdkoaus7xo4kJX
X-Proofpoint-ORIG-GUID: ccNrpXjmagCKBYi2_Etdkoaus7xo4kJX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060170

Export gen_pci_init() API to create ECAM and initialized ECAM OPs
from PCIe driver which don't have way to populate driver_data as
just ECAM ops.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 drivers/pci/controller/pci-host-common.c | 3 ++-
 include/linux/pci-ecam.h                 | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index cf5f59a745b3..b9460a4c5b7e 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -20,7 +20,7 @@ static void gen_pci_unmap_cfg(void *ptr)
 	pci_ecam_free((struct pci_config_window *)ptr);
 }
 
-static struct pci_config_window *gen_pci_init(struct device *dev,
+struct pci_config_window *gen_pci_init(struct device *dev,
 		struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops)
 {
 	int err;
@@ -48,6 +48,7 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 
 	return cfg;
 }
+EXPORT_SYMBOL_GPL(gen_pci_init);
 
 int pci_host_common_probe(struct platform_device *pdev)
 {
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 3a4860bd2758..386c08349169 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -94,5 +94,7 @@ extern const struct pci_ecam_ops loongson_pci_ecam_ops; /* Loongson PCIe */
 /* for DT-based PCI controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev);
 void pci_host_common_remove(struct platform_device *pdev);
+struct pci_config_window *gen_pci_init(struct device *dev,
+		struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
 #endif
 #endif
-- 
2.25.1


