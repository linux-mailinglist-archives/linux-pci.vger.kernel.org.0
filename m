Return-Path: <linux-pci+bounces-28249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BE4AC0143
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 02:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB011BC46D7
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 00:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E74079D0;
	Thu, 22 May 2025 00:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XOwByoAD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7E64D
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872882; cv=none; b=rryD+L2PAG1HY0FmlnlQmOaD9/0slmOfjIE57ZpT9xZpBbgxtwSviuzVmrr3zD3PmG4g5GtNlnUpncN4WU/RPPJJPIGhaIOn1GsZyg4P9Qg3DS9g9zccK993rq9mGLn7i6YXkaOefb4o3Nq4cb8/q/6etqrWXjkYbNr5a958fQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872882; c=relaxed/simple;
	bh=ivanWCDxAyUNMe++VyZ7GD/aarva+/WzhjR97HqQYr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B+N4sZ8oTe0F57HOwhp2lrljb2Dit0KrfEwH+jWX+nGDRx/MoKSuk9AhIP1GXC1OPn0CqyFfCV870BS4dyQ9HrlS0jGNjydPlt8pr+HEtRMeqkX21IZLL41Uzg7zPik2zqP4xvPIHsgwqDffGfPhfojBt1yYgsgh4KGrtuZSW4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XOwByoAD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LHSdeq024849
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 00:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FZ7KZa0KoNH
	4FU/NXhvLV/fsJzac7wy5NniQVOsYewQ=; b=XOwByoADN6FkAhDCF4uHDHqW474
	grzxxJmPlanTriqR4sVnpO/y+bV8g+o5/SPAe35J6QEu0O+/irlOeANEM7GA7Mue
	cbabsEPNV8RUVvTV/mMcAim/Ik4iWziPhQv1RkAyC2ObjCGy9Xj2jeM5FeubTSlb
	pfrlwOLvocCOQs7eK++wwpHGZlAp0dRbrQ7JHzompvQXJ4iwZ5ZvFFxclylHda5E
	+RBFtZXNQFc0+9IuBMekfX7h4c8Qzkbl8rix+BQnQzyHPlUFu87a3WJuwBnYycOo
	SHLVnMaHd57Rgq+VnYBToU4GrVDGV8I0JqMzm7mMMsazeoM6CHeOLfk+SSA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4vgfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 00:14:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30e810d6901so4696959a91.3
        for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 17:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747872878; x=1748477678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZ7KZa0KoNH4FU/NXhvLV/fsJzac7wy5NniQVOsYewQ=;
        b=VItyWa9eYJkQ0Q773S0ZOcw4wxqanz9mu/g/EE1onmpAdtSds8Gl4fKKNwKCgNQbXf
         z3BIpJ6otaMx6nQl4XSQX431y6M78a2rtdLX1TqqEZBY7FSItbkbnY/Hr2YnOchjL8/9
         CG2tvujAt6LOHOXTrrOIzHb4ysF99N1qiDVaqGI3zMnddigDA9+P8h9ibM1XfIZdsHgs
         iW2rULv6KHQh+/9EY1UWVxU7RN9QmWhD/hKovKnTaALLpwThZy6BPdlKFjFn+oF4v1Wo
         MvGnpx+y2Nny29r+uOYsvn9O+Iuu2gsR+RdHhayr+/maNGWY60To9RIzbihxJgW0UQ+O
         aDUw==
X-Gm-Message-State: AOJu0Yzs+/wD1mNuPIYJc4ZSdKAnssuJ2XPwhywCx6lMZtp1RwTgP9JB
	Y01sZMhmGsaTLrrLSI7nWqffQzKfZilnKnUFbxZCA7s3IRmV955Sgon3ijVmEAENLszrqhhwuV8
	yWLbCZOiYoVKTpQntQxW9QvG3EvRr/yhClJkmRm67HAi5kDJRZcOAe7RCBR1jbkHZnxylvhc=
X-Gm-Gg: ASbGnctnv7gi+kovEDnpMmo7wZ3jfpAMeX/xG/Ee5WvdmQxLAbW/2PiN5Poos9Gan9W
	771pxAMcpIJy4W8gu7ZaDymd044s01r3dRJEnwuH9vL19069ABvRrKkIfwVumjjQ/oSyidHDT38
	iIqNs1GmnZBdwyLt6kK5SY/Il4bOYxqkt8AsWOnohmkMfCd9QZRrb9xhwAl2UMZjFw9E5ciBd1u
	l51012Ci/IN7NPKYGzDB15dVCP4KC31mkEv87BcVGWItDpQJVHvHynsjDcQhe8HOJqZpp0nHwGR
	RyR2ttXmm86FBeB5xUNg5tcEQACrGvAqHV255gzYearhigPmVjWJczAH+XwMlQ==
X-Received: by 2002:a17:90b:4b0f:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-30e7d52af9cmr35158308a91.11.1747872877615;
        Wed, 21 May 2025 17:14:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIhxrvdKq2jpiMU4/Qrc4I266FB6s0eWca3c5BFMOwa8ldeGp7OH5zlEgYlmPG0aNtuKZVsA==
X-Received: by 2002:a17:90b:4b0f:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-30e7d52af9cmr35158254a91.11.1747872877145;
        Wed, 21 May 2025 17:14:37 -0700 (PDT)
Received: from hu-mrana-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f3651611bsm4617101a91.49.2025.05.21.17.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 17:14:36 -0700 (PDT)
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, andersson@kernel.org,
        manivannan.sadhasivam@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
        quic_nkela@quicinc.com, quic_shazhuss@quicinc.com,
        quic_msarkar@quicinc.com, quic_nitegupt@quicinc.com,
        Mayank Rana <mayank.rana@oss.qualcomm.com>
Subject: [PATCH v4 2/4] PCI: host-generic: Rename and export gen_pci_init() to allow ECAM creation
Date: Wed, 21 May 2025 17:14:23 -0700
Message-Id: <20250522001425.1506240-3-mayank.rana@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250522001425.1506240-1-mayank.rana@oss.qualcomm.com>
References: <20250522001425.1506240-1-mayank.rana@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZXqsg3rEZbtkPtiVlMnGNgmbNUhy-YxY
X-Proofpoint-ORIG-GUID: ZXqsg3rEZbtkPtiVlMnGNgmbNUhy-YxY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDAwMCBTYWx0ZWRfX/ocm09Xk9bNY
 1pFydclZBpIzWV68872EoLrFDwuYTvIBpCLsmVDHDg78LqWxrJyvJk0rYiRXfsw9PpnJam986H6
 aJ5e22zGxKoQOfl6k22nG+1v5vK7KI2OVo4Flzyv7gsx+ip8G03gsDFi7Zsfv84ifwMB4hRmWsK
 CZ9HaeQ3SveOh9LM/15VaIJ+J4reVlKfp4ZnTGw6lF2XBQmUvyB3nDOIbEE+x/b6oUvtGDEIukZ
 gW3yVKg8zgbip48B7AA4vKgjA8oUnJGG7V942sIy2++J02jXc3NDtL/HyPBcHVGA/JBxD+BZUW5
 5a8IrEyNrrFr3xKiWBYySy9IN+MT4AB+kYuBc/CJLkALuRBV2BWIvh4VOXBXNhS72JftBr5mvhu
 KTviKKUrs8gAoa0yC0ZnwuYFTmQ5M6kpILHBdWmBtD1HebjxO48qKRATIzNC1KioXppJaSZS
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682e6c6f cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=dt9VzEwgFbYA:10 a=sWKEhP36mHoA:10 a=EUspDBNiAAAA:8 a=CFJw4oUWcMUjKlMiYBEA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220000

Rename gen_pci_init() API as pci_host_common_init() and export it to create
ECAM and initialized ECAM OPs from PCIe driver which don't have way to
populate driver_data as just ECAM ops.

Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
---
 drivers/pci/controller/pci-host-common.c | 5 +++--
 include/linux/pci-ecam.h                 | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index cf5f59a745b3..6e68c66382fa 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -20,7 +20,7 @@ static void gen_pci_unmap_cfg(void *ptr)
 	pci_ecam_free((struct pci_config_window *)ptr);
 }
 
-static struct pci_config_window *gen_pci_init(struct device *dev,
+struct pci_config_window *pci_host_common_init(struct device *dev,
 		struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops)
 {
 	int err;
@@ -48,6 +48,7 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 
 	return cfg;
 }
+EXPORT_SYMBOL_GPL(pci_host_common_init);
 
 int pci_host_common_probe(struct platform_device *pdev)
 {
@@ -69,7 +70,7 @@ int pci_host_common_probe(struct platform_device *pdev)
 	of_pci_check_probe_only();
 
 	/* Parse and map our Configuration Space windows */
-	cfg = gen_pci_init(dev, bridge, ops);
+	cfg = pci_host_common_init(dev, bridge, ops);
 	if (IS_ERR(cfg))
 		return PTR_ERR(cfg);
 
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index 3a4860bd2758..ad6a6170ff26 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -94,5 +94,7 @@ extern const struct pci_ecam_ops loongson_pci_ecam_ops; /* Loongson PCIe */
 /* for DT-based PCI controllers that support ECAM */
 int pci_host_common_probe(struct platform_device *pdev);
 void pci_host_common_remove(struct platform_device *pdev);
+struct pci_config_window *pci_host_common_init(struct device *dev,
+		struct pci_host_bridge *bridge, const struct pci_ecam_ops *ops);
 #endif
 #endif
-- 
2.25.1


