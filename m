Return-Path: <linux-pci+bounces-22331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F01A43E18
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 12:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAD718851F5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA59E268684;
	Tue, 25 Feb 2025 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pNxv1FZD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272F62686BC
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483957; cv=none; b=CnlxSSI74XTqkcv8yWoVjMYToOcLCA/mgOv5pef3Xzt3eg2RSgJyP9fOqKtFMxvgAFE+iZZzOejifiEHFms/6r6dz0R4jsoShNpZNHzh8ecA292/gxPGwqmtVP5sjFsk4dDn/yGWIrLva6HOWaUwXYyTkaRn8WV4KNP5y+oQZ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483957; c=relaxed/simple;
	bh=u4stSlHqt6SDmbNCOygNp94BXAp7R4cdNbXp5bogHOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TUiVIvQq7NYTi0Si4QFMho+jq7MVSbY9IwBY308uaEnj/Gg3D+ZqZNWHtj1pb9LQhZ+XrjEdQLjmWQKQZKxGWxwOmlLiSryKJXp3UAdVn4T0YxgJVizVdXM9i+mTNgzKJ2xN2C4k0Mvu08snzZj/r9ToL/0DbUDxIbxXFXpyUEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pNxv1FZD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8C6a8017995
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 11:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CL0lc3FSdVBtQAJZpLV5Pqt/+P+vvC1pRH/Z+SNoYHk=; b=pNxv1FZDgM6TnQ1b
	mK81TmbDhW/rQI2Y2M6MKYBwLuCKDpN47fU3jfck+PLlFGtfxiAU49ONE4Vi05yL
	VV+aT9zdyUX9G0YTViTPQWCnwBDvoTSDkK6IW4jKb2cjjWbgja8k77cWVTGwBIQv
	BLWbS8ZeVJwsiZp0aDG9AxJMNG6VANqQROBqVQVZEaJfX8TH88WiCWekj8ldEm25
	2JU39X09Z/EV5mc801XiHJx5AfYDSd2GVm++8l8ZCtaWIF54al24YLkH1fSvtzPl
	hbm61So8XeA7LMZ01S5yA6XGxGRI489ENAgT3FZfuZpTgsuKkG6sSMzREM0rC+Ur
	VUsb4g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5k68ud9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 11:45:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-221063a808dso108258075ad.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 03:45:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483953; x=1741088753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CL0lc3FSdVBtQAJZpLV5Pqt/+P+vvC1pRH/Z+SNoYHk=;
        b=P7Zkr1Cy4LbiH/6a1RZ+aAHdxzxT8lJYq3lI0rtZiItV33nsdPOpfFhVHtB/UOCTiR
         00vP5tOi8QytCtcq/yXKNpA/RrX2wlruurIrdsLXGkUl3BysojBeb7xCwW/P/B0GMG+H
         ANrWZFSFLHikT/fEiyf8+tDMiCiSVCc7u5hioKIbmh88LKeOIBX9wKt7txfndJaYiDjP
         6UNP65qrtjrNXCRdEN86UKU12NQ6Pkwfksv1ceZK95/zUj1VKgdW7KSUyVVo7D60H44i
         v6cTscaDMwCjxgf4/7+L2NprZj2VMGmqFkCN7P496etv+nPvH0SbJFBHSbmg8R6+lx06
         utww==
X-Forwarded-Encrypted: i=1; AJvYcCXjWjyMlJKHa0ryWenszJdGH+6sBDybAEdNp04jHEhGgIVhc+x6Lbvmp29rKkxt32cEdREs4gmKBoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoxJJoIgVtceF738vVvVfOKkopzjts/y8kwaHfbRgeP1oNmb08
	/uJJO6MYqf+ABSmnEjMhpCPNLifbrP+IgNuSEQKneog+tuWwTPQ4TJB8Ni9w3fVSLwtzYmI3Uw+
	JSQ9ozu7UGfrlnTA5ee0VPb21IHzspYaUKRd3Jzr21MMUNnMl6/kqpMgxy8Y=
X-Gm-Gg: ASbGncvytwZoq5ivCoeSLvOuJTLv6jk+/ja6VjWaH9IvHKv+I02+6mQsdsQSRTGtbDk
	UR/bYkzJmB4tX2Kcg9DfRjth7oL3GUdSkFxd87+vWcKHDpckTFtPg2qgr31M28jlFk2J1cflVFu
	8kYEMHHv99oB7ybEy3e4VT3j1d+Q0vGdiCZgJIe52lOZnP4sLoMPFdTA7s9D3gBFnmof2qhkm8X
	rSk5SXV+54ZUUG1MChbvW7ult8EI7arF/68HggNwNwUzSUQGCRi55z7/N1BPy1hqSqJOvRiMwE+
	+h4B4HZU6p4eSlHEeVSmYpUlR6MM8drUBsMQxTM95xp7g3f+z8Q=
X-Received: by 2002:a05:6a00:1810:b0:727:3fd5:b530 with SMTP id d2e1a72fcca58-73426d77f98mr23597980b3a.15.1740483953487;
        Tue, 25 Feb 2025 03:45:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF98KPJ3NHHETIUHz7cVz0wu8yWb6paMuhFIuUIGnid4MPw8cUtFG1Nqb9e6yv3CwbN4XxWTQ==
X-Received: by 2002:a05:6a00:1810:b0:727:3fd5:b530 with SMTP id d2e1a72fcca58-73426d77f98mr23597949b3a.15.1740483952968;
        Tue, 25 Feb 2025 03:45:52 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9bb1sm1331790b3a.92.2025.02.25.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:45:52 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 17:15:06 +0530
Subject: [PATCH v7 3/4] PCI: dwc: Improve handling of PCIe lane
 configuration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-preset_v6-v7-3-a593f3ef3951@oss.qualcomm.com>
References: <20250225-preset_v6-v7-0-a593f3ef3951@oss.qualcomm.com>
In-Reply-To: <20250225-preset_v6-v7-0-a593f3ef3951@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740483933; l=3059;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=u4stSlHqt6SDmbNCOygNp94BXAp7R4cdNbXp5bogHOM=;
 b=oTMbuIEWa0kinDliVDvtm/fVhAbjJe+MxEG67fD9o1BGTgITJ7v/ldktwJIJaDX0WLUYw1xM3
 yon9TibsZreBK0B2dZula3WaVgUj5R73uYw9ax9vYU/yFGK4l111H8P
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: is_VVOorQPTYdNINY-vulSo8f1SN2Je6
X-Proofpoint-GUID: is_VVOorQPTYdNINY-vulSo8f1SN2Je6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250082

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
 drivers/pci/controller/dwc/pcie-designware.c      | 11 ++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ffaded8f2df7..dd56cc02f4ef 100644
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
index 145e7f579072..9fc5916867b6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -737,12 +737,21 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 
 }
 
+int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
+{
+	u8 cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+
+	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
+}
+
 static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 {
+	int max_lanes = dw_pcie_link_get_max_link_width(pci);
 	u32 lnkcap, lwsc, plc;
 	u8 cap;
 
-	if (!num_lanes)
+	if (max_lanes == num_lanes)
 		return;
 
 	/* Set the number of lanes */
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 501d9ddfea16..61d1fb6b437b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -488,6 +488,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
+int dw_pcie_link_get_max_link_width(struct dw_pcie *pci);
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      const struct dw_pcie_ob_atu_cfg *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,

-- 
2.34.1


