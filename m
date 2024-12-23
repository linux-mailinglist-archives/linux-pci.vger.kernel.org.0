Return-Path: <linux-pci+bounces-18954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B53629FAACA
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 07:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05E41886729
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 06:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0024191F8C;
	Mon, 23 Dec 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GZxUTt+6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E11714B4
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734936706; cv=none; b=IfTBTKt9n0hKCIjDTL4gLGqX9L+raTCHoENQedZTcXX6jf/QMn/SU3/JeH6ZWOB8Y0t7YmY9qKgDtmKPAsXGAt3auw8hhYwjPBMs4MPKXL7QkBW6IobDntebVobMnaKBZzEdrQlaCLJBQfa4xjTjMLNlHLY370xzjgDYjzcqa7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734936706; c=relaxed/simple;
	bh=5rxRkPnumzzfAdemdZBFDf4pCGC4z3dLReWUJOLysOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mFQDwSghLk+OJCMcwEpwRM2iHj/TuyV3atCyps1Na+S1vKmKH1UV+Ag7VTqsg6tW25Dsj2Lul3TEUhMyBbVbVw4w49T+8MlWSe4hD/hb+X9iMvJDcpOZllkeREBVhdJeSeo25yNutWqUUODjJwuQGqnHwKHng1YfaE6O5/maxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GZxUTt+6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN6mOwJ004675
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 06:51:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQsJM/reDtTZynjk4EeE4bMecMMhIsTfkx5E7VPjZRU=; b=GZxUTt+63nkN28l4
	ErRIGOg66rHzOF8MvAYQAOxy5xBL0D+Y2UiODN5qTbrWMS2bWhlGdxc9rF6qB/lQ
	CcyF7M6Sge9F6eOp+vnBt0VwSUGXFaZ4ez5js4i574puhU0+uNx2DDxVEyONg4kB
	o+hAEpmohQddcmDLQYo7/uc0DefWQVsxdI31hjbC3VQKZGhd/KJdG3zJY9d3mvj7
	qWAYNia3CcfESSqcQ+8qQU/FiJaha0xajMJA7+4gYSfdJWX6XESXrEuSz2+Wipkt
	Guukl7bmA0UuJJxvl6WdIEaCDMDr1PuF8Ji+llfBLR1Urm9w2OAD34eTea5dgtdJ
	FPgEdA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q2ww80dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 23 Dec 2024 06:51:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee46799961so5228946a91.2
        for <linux-pci@vger.kernel.org>; Sun, 22 Dec 2024 22:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734936703; x=1735541503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQsJM/reDtTZynjk4EeE4bMecMMhIsTfkx5E7VPjZRU=;
        b=dTHLSV7th4l6g7d93sQZYXb7GhYg2aia49EFpMpOes0kg0R2gk4u57yhmy/4sXfxzW
         +NLxc3YqsqTQVCvZIyg5NjV0Sdp7LQ50nPurbYybJfKnEDTGecYfvMTSHMWBS+gv9rSJ
         uERM5sPoJ2tPY5laWJBb9YSjXD61Ar1waG7jbZQTH7weIr26aQmPMvfWfVkFj/ShGbNf
         IvnYdaF9ru4PppkdlL2CXTnZ59ZvdxV9z8MrHX2JIOoMkpHFtV9ykRGdnzGNTEALHBr/
         slWdbAxh5wbAjmtSbhGMq8tmmJ3DMZTWkqU6VnGPtHkRipr/+DNve0FUWCSSwVEE7Etl
         OJng==
X-Forwarded-Encrypted: i=1; AJvYcCUgYTWiNc4XMGAtBXGSd29hzOiVJdxTi5oym2wDUr8mhkRSB9QQ+3KX6ML7uTUQ/It0M1Y47MhsJ6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOycpUCKgDFtVxXv4ldMsuDL5zB1xYVtM88cmoe0Y34k353sqf
	cjb6olISZNtrkf7wnkyd63rxIWMF3GRl99NHwqpr68HxcRLWTZnq5wUka29s5M/F0AXGEHRi9pa
	qGTCuJ9ncTfzkE7ctzmJHhTWOKYfyeZhLDJNsdByjkZLSYLBfypWccGlqO/w=
X-Gm-Gg: ASbGnctIh0iTfciKAHStHCmrzzUBHJRerW0zIkTezSSWOtsgma2XfjU93OIPrd4QM6A
	3IH95CuVE+HHfSBdm/h9wG3jrTQrULRa4Yp6hpHyScZBv/hEDupQD7S0U1visNOHZBUP9YRj1T/
	W0GlHAeXS3Lnf3iyUSCp84hFWtrmKic6gKVmTuevJXtAIT2Rtsik+y/OlGNqh37xWamkf3+kR8w
	+0GYvo5C0ReEyIZ7DTmMh3dyizddr9oMb8i4cGdrSE+l+AEGhI0ZT8lHCCNa/fFiGZ0GmT68PPJ
	xDdTZNmfYc12SdHQ
X-Received: by 2002:a17:90b:5245:b0:2ee:d958:1b18 with SMTP id 98e67ed59e1d1-2f452f01c34mr14869506a91.36.1734936703251;
        Sun, 22 Dec 2024 22:51:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3Eevay4cFpBOZVpfqRhKjBVEV/hQa4faos0PEeOW7zqFrwQ+g3KW2ARs1mbw6xpw+YV7mDQ==
X-Received: by 2002:a17:90b:5245:b0:2ee:d958:1b18 with SMTP id 98e67ed59e1d1-2f452f01c34mr14869492a91.36.1734936702884;
        Sun, 22 Dec 2024 22:51:42 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f4413sm66570155ad.172.2024.12.22.22.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2024 22:51:42 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 23 Dec 2024 12:21:16 +0530
Subject: [PATCH v3 3/4] PCI: dwc: Improve handling of PCIe lane
 configuration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241223-preset_v2-v3-3-a339f475caf5@oss.qualcomm.com>
References: <20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com>
In-Reply-To: <20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, quic_mrana@quicinc.com,
        quic_vbadigan@quicinc.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734936683; l=3448;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=5rxRkPnumzzfAdemdZBFDf4pCGC4z3dLReWUJOLysOk=;
 b=drL2ws+ekg+rOEN2EVcQ1pdTOuJQRBj/bcvcwDRYsyjofzJvw6CLCHfF4MwD0uTP7SNSAYHbU
 6K0Q/nsao9xDp7HKpXRtGxBFuIQbpsdVoekFT9GlMpHFH7Ktk0yNqsb
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 2F60hYcX73drZa3JqzmZZs_5RxYSUfWK
X-Proofpoint-GUID: 2F60hYcX73drZa3JqzmZZs_5RxYSUfWK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230059

Currently even if the number of lanes hardware supports is equal to
the number lanes provided in the devicetree, the driver is trying to
configure again the maximum number of lanes which is not needed.

Update number of lanes only when it is not equal to hardware capability.

And also if the num-lanes property is not present in the devicetree
update the num_lanes with the maximum hardware supports.

Introduce dw_pcie_link_get_max_link_width() to get the maximum lane
width the hardware supports.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c |  3 +++
 drivers/pci/controller/dwc/pcie-designware.c      | 14 +++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c7290..2cd0acbf9e18 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -504,6 +504,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	dw_pcie_iatu_detect(pci);
 
+	if (pci->num_lanes < 1)
+		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
+
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 6d6cbc8b5b2c..acb2a963ae1a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -736,6 +736,16 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 
 }
 
+int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
+{
+	u32 lnkcap;
+	u8 cap;
+
+	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
+}
+
 static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 {
 	u32 lnkcap, lwsc, plc;
@@ -1069,6 +1079,7 @@ void dw_pcie_edma_remove(struct dw_pcie *pci)
 
 void dw_pcie_setup(struct dw_pcie *pci)
 {
+	int num_lanes = dw_pcie_link_get_max_link_width(pci);
 	u32 val;
 
 	dw_pcie_link_set_max_speed(pci);
@@ -1102,5 +1113,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	val |= PORT_LINK_DLL_LINK_EN;
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
 
-	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
+	if (num_lanes != pci->num_lanes)
+		dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35a..500e793c9361 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -486,6 +486,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
+int dw_pcie_link_get_max_link_width(struct dw_pcie *pci);
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      const struct dw_pcie_ob_atu_cfg *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,

-- 
2.34.1


