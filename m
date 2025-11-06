Return-Path: <linux-pci+bounces-40452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE3C393D9
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 07:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541BA1A25FC5
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 06:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B061F2F6922;
	Thu,  6 Nov 2025 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m8e8NzQK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fI0u6VHp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D32DE6E3
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 06:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762409632; cv=none; b=armPeINIYRcNjV4KyCKroZGVgL+emravIjp5a/Uz6gu1nRU5FXEHKaHQQPBWN1ySxGMvm/OPhD9X73Y4ghkqwnwesbRQuCIf11pSjkJLr2CvGTbqq4lLg1xwDDbl+ydk93XUexqtCASp30uq7AWARTb5qIj+A2xhlor2ce0v/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762409632; c=relaxed/simple;
	bh=HT4nVZpTKboMb5Or5J5uvYygpZjM94QiOo9HruFPObM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpo+eVQEHZ+lenmEm8/fx67gK8SGhKqYOUJaDiJEoJjR6Sy+1k4pN5WCZ3D8UYPQJ1EGT/LuyqeuOEHVN2ZwaLl7WZCGmgWOCnGfcVTx99enRNm8gADnwu0h1OtugW9TsTwoN/Kr7rza3uFBn5mJtGTiFz6sPS1LvCLAqaTdc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m8e8NzQK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fI0u6VHp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A60b8FI2389024
	for <linux-pci@vger.kernel.org>; Thu, 6 Nov 2025 06:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Bz+iT1VU6DH
	p66xQoSXUMGHnHJ4BKJqm5XqeWac1BUU=; b=m8e8NzQKKakKGqJjDHdtOgtO3pM
	x+Wp/kgg0tgZcAg+Crii+FPwgqatmRMDTH4ZkAZE86FWVYliTOKyUA94WsY7R7Uf
	DpT2gchyflovf1f/mDDt6JAh5Auw/CJUrwZCbWohyAy6HS45kxlZ8zTwYFJJcaLC
	njzqSuMJHMW4umEiSSL0DR7A50nked+s4EdxUzHqsxx1nmhS10wH0cFYyxsGP2IU
	TxWJJvclvJxEKh2EqnTaaDCEhTqIxdW2+pAilQ5+T1Sj2nPmQI+BJMsTCAWd8tq+
	JKzvNc09Uq5hmX09cCeUZ2oDW/RjJMwCx7bOEq+hImzkuKpXSkgncZxF1uQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h9ursnd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 06:13:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2930e2e8e7fso8540585ad.2
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 22:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762409629; x=1763014429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz+iT1VU6DHp66xQoSXUMGHnHJ4BKJqm5XqeWac1BUU=;
        b=fI0u6VHpwWk2yho/VsFO1tD0BmnbZ546rFsSDigV7EPbN8meSD+CM2mcbrOmdioxFL
         FokI+uai2TNyDsSf5k6EOY3KkXFQI8FwvtR4XgWwgt6lH31Uwa8/TguAqDtA9Ke3CMXr
         TKqTx53LU0aZojkz4ugU0Nkp+k7BxlkfbNU6+XDWLRykJxh0vgyqgUp92GXpDRKXRVZM
         njg44dOHP+Q4eFYg/FwJb6O8m6SYM9mgkYT3SuUrftsHQZa0RHLR44fsUOchtBgzsZWe
         BEqI0A8lcKAPaxForuVqIe1FdHLzD07zmSL8WeQkBoxdZ8Gt9HnCdxjFmn3LHS/9N6FD
         eKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762409629; x=1763014429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz+iT1VU6DHp66xQoSXUMGHnHJ4BKJqm5XqeWac1BUU=;
        b=L1axkWo8LlxGeYGnAFvb5HDni3OSTOyGpDrWyrVKPYqgDa9PBiwYId8lvfrGtVKicn
         uEz5XjIVTE7rXMKsW0BrOZE31els4J0G/qjwNsRtj6xAO/UKTEuj8lLGlJMqYz8ykfrM
         1mpoLmWStQhCtFecz2oxOEHlL2YK0WyneuyKnGN2UhiJkMzurWTxkrdVklpO30EDLBPN
         2jyEwiSnLu4vou+YMFA5+CF9wBrYOKAhkw91lRGB+622bAg6ClkFjZjz5rEBKjsSWWWf
         /t0Py1ttp+tAgfU1Ro2mTKWY96A9hLB51WXrh/Fxm11g2lvD0tW6mWMl+0adNNTZhrPu
         zawA==
X-Forwarded-Encrypted: i=1; AJvYcCVDSR5YEaxZ7PRJwcLI36OXVqyTCLQNVNTajWyjwp1bKNL3C60w3A1O74RCFMAGZEdbwSaGs4l95vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhdnMK3YMmC8mXYokm+56RetIOxGmpfxl1PkRZ2oCx3OZG7dey
	r907jmvoKn6v4WapZ5s2t5NOvLgkxEAHTHkyc6KUXKW5/TQ3MHue5eB+7H75fjRCfGiYnwwzTrC
	WBMy3brKpaJz8bnbGDma5fnfjjrPNjtT9wUqLHTrtxBAmfse+4hjF36KihTOg5bs=
X-Gm-Gg: ASbGncu53Ftsq4DZE13fpJVYl4zsf/n5Y2j+OntAsD11xmw0WI2fAwZpNtJlQ2JGbk/
	pDnUZekN72repl1uCyCs0S7oc0ytNckibdnIUWLVrBAmf6GwAXL07OAcxxszgly3OYjagOY4Ff3
	g1umlVtDPPVbelYyFz0D62ZVjUzP1BucI/x8uo4m/0Vm55lgRpSyqdmLIOAoYaT6B4LTUsmvjCL
	KJriHXxVLqXHWKFohBeNTpEKyQUf3jtnfhK5kdJyv0wcEPFyW1m4BRu4iWeJXZh4bc5f0EWNAWw
	fLqRK1DP9K8Y6NaYC88QpZdCeNRbSdNAV4S1gb6M4/+D7IP+LtaEIhA5/xhTQoFDbbfIai/H8Cl
	GzSXxk/CX78bEiXtU
X-Received: by 2002:a17:902:e88b:b0:276:d3e:6844 with SMTP id d9443c01a7336-2962ae5588cmr78077485ad.33.1762409628778;
        Wed, 05 Nov 2025 22:13:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFchEuYKBu/vaO0ZLZ+TJY4t+sNboV0WKWOxuZqochr7Tk3bduN0PaUyD9tfuSGWl7zbKBjiQ==
X-Received: by 2002:a17:902:e88b:b0:276:d3e:6844 with SMTP id d9443c01a7336-2962ae5588cmr78077195ad.33.1762409628250;
        Wed, 05 Nov 2025 22:13:48 -0800 (PST)
Received: from work.. ([120.60.59.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c73382sm15036305ad.69.2025.11.05.22.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 22:13:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
        bhelgaas@google.com
Cc: will@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, linux-arm-msm@vger.kernel.org,
        zhangsenchuan@eswincomputing.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 1/3] PCI: host-common: Add an API to check for any device under the Root Ports
Date: Thu,  6 Nov 2025 11:43:24 +0530
Message-ID: <20251106061326.8241-2-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20251106061326.8241-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R5UO2NRX c=1 sm=1 tr=0 ts=690c3c9e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=tomDxdmRQcfPzRosr6lsLA==:17
 a=X544SMn2G6euAj6E:21 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=dVeha9RqDf-OwfEDNMwA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 80Gg7OMSZNnS5mic_1B3OVzfHd6WZFnA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA0OCBTYWx0ZWRfX5X7GYs+8ksoz
 kh8QoKo4glpjMcZzJB00UkXXSVS5Z+CiZ8E/tlPjveyx3rO2ClVLf6SpRGQ5mldmp92oTZHFDSs
 mgZOdhtGeHbzvkBDEy2h7KLkChix3RnH07Dqq9xQN+lty3hMlRXwL2urvTB0rr4Hqx4p9rNwamW
 jS53/MyCBgTtVI+xAyTFvv7glQvMSTmhmTA1QdTbKjAHZz2cEyli1KDQlAT+dsNX4PKqGEQU1bS
 ZEwXneG7+T8xqb8RmwGBWjpfLiyuoSj2ZM4TutHESmSPPg0voEizXCu8XZ4Qhy/gX32FVe3l4di
 k+IPNpiCMISIEmLQERijKC5tGAh2b+3NztPEu753YCwA2DnmkKUB8sR0KrPRBzK5cZf/A24hlp3
 AiXhwr47+xoGmefGXJ0g6TnChGGhlg==
X-Proofpoint-GUID: 80Gg7OMSZNnS5mic_1B3OVzfHd6WZFnA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060048

Some controller drivers need to check if there is any device available
under the Root Ports. So add an API that returns 'true' if a device is
found under any of the Root Ports, 'false' otherwise.

Controller drivers can use this API for usecases like turning off the
controller resources only if there are no devices under the Root Ports,
skipping PME_Turn_Off broadcast etc...

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 21 +++++++++++++++++++++
 drivers/pci/controller/pci-host-common.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index 810d1c8de24e..6b4f90903dc6 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -17,6 +17,27 @@
 
 #include "pci-host-common.h"
 
+/**
+ * pci_root_ports_have_device - Check if the Root Ports under the Root bus have
+ *				any device underneath
+ * @dev: Root bus
+ *
+ * Return: true if a device is found, false otherwise
+ */
+bool pci_root_ports_have_device(struct pci_bus *root_bus)
+{
+	struct pci_bus *child;
+
+	/* Iterate over the Root Port busses and look for any device */
+	list_for_each_entry(child, &root_bus->children, node) {
+		if (list_count_nodes(&child->devices))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_root_ports_have_device);
+
 static void gen_pci_unmap_cfg(void *ptr)
 {
 	pci_ecam_free((struct pci_config_window *)ptr);
diff --git a/drivers/pci/controller/pci-host-common.h b/drivers/pci/controller/pci-host-common.h
index 51c35ec0cf37..ff1c2ff98043 100644
--- a/drivers/pci/controller/pci-host-common.h
+++ b/drivers/pci/controller/pci-host-common.h
@@ -19,4 +19,6 @@ void pci_host_common_remove(struct platform_device *pdev);
 
 struct pci_config_window *pci_host_common_ecam_create(struct device *dev,
 	struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
+
+bool pci_root_ports_have_device(struct pci_bus *root_bus);
 #endif
-- 
2.48.1


