Return-Path: <linux-pci+bounces-29900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D47ADBD0B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 00:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08805172B5C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 22:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2C6218E91;
	Mon, 16 Jun 2025 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g3SQC4Wr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ABE21C176
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113788; cv=none; b=ZCblFknljkugH8Wkk5PYYwvKDkzIork2M4+zrK8t8/67FReEbOvbgD3fBrSLbt59rXCLuf2KreYprBj3cHZ1KEWJdajaM7L0RevpLkoA+mqdVD73m9WmQm766lhOCn8Z2WunPc7D4UIDDjr5yLNFboo+zSjVcNrupTJylnQEMD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113788; c=relaxed/simple;
	bh=kbCDTVvV1hptfdSWgxjuH8VVDcvDx+p8AHAKNymii/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tDtavGVMoGOwp6EEOPoHceVlHkn46okCpPLEfGzCpeXLJx5UABq7JTK4Po3MV6DseWEZNNDBgAbbR2fEYJykVeAkAL4SxRpmgugC0V2ylAk8RTpF44K74rsbTyE0gKiZSiJvFp+6RhSRj4RH7TavbYgDzagmg4M32+xMkVDbY7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g3SQC4Wr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GKAvjv027438
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+7rUATnUgHw
	XSUUqHkvZgzdmOmf9U8vfsrfGqwxA5/0=; b=g3SQC4WrBo9K1vteGiyiBGZVdZH
	8Y54Ew19qBq8SQIVbe5zsQmwihHDN9sfwntKU4QGZQ62b6ubfP/igTU7GRck2cWy
	airinKUTeSxDgFfMcP3KFISmrDQCBfUvCe/I4zXS8zdg1V/RbIiMpSz0y5kwf8h3
	XTfqvyii7jvtiXDVgZV87EOX6XcJipD8wlD+CYkx0SX5iX69Pzar6HQBNKl0s48H
	J+n1aIYnj4z5WBL6XnQyG+4naM4B1UKDW2lXUJBRyznImsKjw9scI5TFvGLErbE2
	7uSoLVRTgsvNffQ1dnyBdLaC28kDrh88/8xbypngQoZX4LaIAdfS1LH58Tw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hcx3n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 22:43:06 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7489d1f5e9fso3609617b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 15:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750113785; x=1750718585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7rUATnUgHwXSUUqHkvZgzdmOmf9U8vfsrfGqwxA5/0=;
        b=MB8gCwVAZ/JP5/BfMmlaGMZpGt5fVAPYKGmXkxBukQ453VedCEPVQriCE9y3rRhAIS
         ERaoaeOvMn2fQkOvpJMOBxhGBJP20C/0gLmcopzgQ1H3lgwQOovj/zG5hBIVsekYinln
         mwiMUv4BhG2TII0RYnMho4rHXH6HzBnu8QQh+uhNmcFzHotHGrzYo4ODLYQDLfZXinir
         rpeixmIiCC5kmxdixEGSfsL7xYo4IHcqf7+QGu58C6zOJEzWce2eyXjpCqWWTAgeavds
         Vdgecwk7uo2y5w2MmMaUs9fjD7sVh8+JdvUvqvLEP5insJfb6oKJs/Dq3w8fmxbcJm+o
         dIxg==
X-Gm-Message-State: AOJu0YyrSGPDCLu+GWpt6e30F0MPjdZQJ6VE6EHDKVRUsUcEj4MBPHOP
	q6d12635kA+em+mBnxbSNOEQhspwoELs3Mslhcc9i6fmOk/p+wRAi96TOyDjxc+4l0XGI74EL9s
	eIyKU7Hgobx+dilMI2iQjJ6AEDuRQwlrJOTWYnXrAKvoBLw3yYEs4YK8JdkgwHXeZwzF17lY=
X-Gm-Gg: ASbGncsjv9pHCWHaddcKt8zL5+mxUCzZFPCg25wL/1C22rXlv4cIeocKFdzGl9fk9US
	1wphiiqJVdHJCr1cJBcQucZajFNXa1z5e18pLPHmnHUxeD0QJ18P1enAjF4JqbmCtM5KxLzkX/3
	N4hR3uSgedDcnUaHZnrenPrEOjxbDIdXzDHffTXrQSjToldWGMY1bk4/cbdPlEPAnBRcmmeHnGl
	HDp+fNzs/mlATdpR63p14jMzGohUD8k+KyxbHNUT9n4YJBHt3aeFld+Hhxwqhqueq/8rEoD8t9q
	wYnoTi0aIpwSCmYwCxO+zkRlC4SEM6/nMMtgKjin2/O9sG37KHs0Rn4/l8OmatTelotQJJw6
X-Received: by 2002:a05:6a00:4644:b0:736:5822:74b4 with SMTP id d2e1a72fcca58-7489d04b711mr15653195b3a.21.1750113785168;
        Mon, 16 Jun 2025 15:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCCpHdGf5Yo8ro+gs5s+5plFGSZTbGwiHzKAu4yqnpZgJZYowcqRph1Os/Jxp1IuaZOqtVEg==
X-Received: by 2002:a05:6a00:4644:b0:736:5822:74b4 with SMTP id d2e1a72fcca58-7489d04b711mr15653159b3a.21.1750113784723;
        Mon, 16 Jun 2025 15:43:04 -0700 (PDT)
Received: from hu-mrana-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083029sm7405077b3a.81.2025.06.16.15.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 15:43:04 -0700 (PDT)
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
To: linux-pci@vger.kernel.org, will@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        andersson@kernel.org, mani@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_ramkri@quicinc.com,
        quic_shazhuss@quicinc.com, quic_msarkar@quicinc.com,
        quic_nitegupt@quicinc.com, Mayank Rana <mayank.rana@oss.qualcomm.com>
Subject: [PATCH v5 1/4] PCI: dwc: Export dwc MSI controller related APIs
Date: Mon, 16 Jun 2025 15:42:56 -0700
Message-Id: <20250616224259.3549811-2-mayank.rana@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616224259.3549811-1-mayank.rana@oss.qualcomm.com>
References: <20250616224259.3549811-1-mayank.rana@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE2MiBTYWx0ZWRfXw3sybrX+5ag/
 oZhcaaOQlIwZiViqw3fi5sbIxvvA9YqLl76Za7aFTp6jkhKRdquWdfx4+3eCkrGQqkb73m45nWr
 E9mQE0R4d8reHBtKLTvz0Kz2RyktZax+CKuZ4Y/aJCttetzmI6sdvIDdjbdktnZa+meCo1hjtcN
 LnnVVINaqxM/trHr7gaeuOfoc3oT5NPH2lxlnISfl0KIYA5DODGT4ytCUpKM9VhhpX+mRNxqPa5
 CW04BEG3kDrdRHl+3tyAces6LbjInZB9TA6TJieRuVxu4FGQulwXuEgvGiU7LfCAz3J0J/n+q56
 xUgelXc0Lu2sTRVRU1l0DHdiu7J5LDj9KNNgSZ694W5ceW9OC7Dqf0Bhrgj5tHZozOXFmjzZCEr
 8hYTsMUgcdgeZbW5Pt1uAktHwSwdBc+fbovsiuEvhGg+UInqjY69PqVzPPW4CpoYlbd2bsSz
X-Authority-Analysis: v=2.4 cv=PtaTbxM3 c=1 sm=1 tr=0 ts=68509dfa cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=2oFYxEjC1fcXuHwUiPIA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: SHNMY1tcereQkuwd8T_BRZqQVxdxe_U3
X-Proofpoint-GUID: SHNMY1tcereQkuwd8T_BRZqQVxdxe_U3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_11,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160162

Export dw_pcie_msi_host_init(), dw_pcie_msi_init(), and dw_pcie_free_msi()
APIs to allow dwc PCIe controller based MSI functionality from ECAM pcie
driver. Move MSI IRQ related initialization code into dw_pcie_msi_init()
as this code must be executed before dw_pcie_msi_init() API can be used
with ECAM driver.

Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 38 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h  | 14 +++++++
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 906277f9ffaf..af6c91ec7312 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -250,7 +250,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 	return 0;
 }
 
-static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
+void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 {
 	u32 ctrl;
 
@@ -263,19 +263,34 @@ static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
 }
+EXPORT_SYMBOL_GPL(dw_pcie_free_msi);
 
-static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
+void dw_pcie_msi_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	u64 msi_target = (u64)pp->msi_data;
+	u32 ctrl, num_ctrls;
 
 	if (!pci_msi_enabled() || !pp->has_msi_ctrl)
 		return;
 
+	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+
+	/* Initialize IRQ Status array */
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
+		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
+				    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+				    pp->irq_mask[ctrl]);
+		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
+				    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+				    ~0);
+	}
+
 	/* Program the msi_data */
 	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
 	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
 }
+EXPORT_SYMBOL_GPL(dw_pcie_msi_init);
 
 static int dw_pcie_parse_split_msi_irq(struct dw_pcie_rp *pp)
 {
@@ -317,7 +332,7 @@ static int dw_pcie_parse_split_msi_irq(struct dw_pcie_rp *pp)
 	return 0;
 }
 
-static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
+int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
@@ -391,6 +406,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_msi_host_init);
 
 static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 {
@@ -909,7 +925,7 @@ static void dw_pcie_config_presets(struct dw_pcie_rp *pp)
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	u32 val, ctrl, num_ctrls;
+	u32 val;
 	int ret;
 
 	/*
@@ -920,20 +936,6 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 
 	dw_pcie_setup(pci);
 
-	if (pp->has_msi_ctrl) {
-		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
-
-		/* Initialize IRQ Status array */
-		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
-					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-					    pp->irq_mask[ctrl]);
-			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
-					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-					    ~0);
-		}
-	}
-
 	dw_pcie_msi_init(pp);
 
 	/* Setup RC BARs */
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ce9e18554e42..4165c49a0a50 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -759,6 +759,9 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 int dw_pcie_suspend_noirq(struct dw_pcie *pci);
 int dw_pcie_resume_noirq(struct dw_pcie *pci);
 irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
+void dw_pcie_msi_init(struct dw_pcie_rp *pp);
+int dw_pcie_msi_host_init(struct dw_pcie_rp *pp);
+void dw_pcie_free_msi(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
 int dw_pcie_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
@@ -781,6 +784,17 @@ static inline irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
 	return IRQ_NONE;
 }
 
+static inline void dw_pcie_msi_init(struct dw_pcie_rp *pp)
+{ }
+
+static inline int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
+{
+	return -ENODEV;
+}
+
+static inline void dw_pcie_free_msi(struct dw_pcie_rp *pp)
+{ }
+
 static inline int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 {
 	return 0;
-- 
2.25.1


