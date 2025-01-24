Return-Path: <linux-pci+bounces-20332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4938A1B4B2
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 12:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5D23ADC9B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218A121ADCE;
	Fri, 24 Jan 2025 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D5NYFeEC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F62921A449
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737717802; cv=none; b=rEwyr8qL3gsg8o0DYOcBN3AKzr8hiI5qPH12HU4IpbKUpm4KlwvjTU2FIcSSuiyBO84p/N5H5hj2kQFTIbh/ROlq1NZhNd/0qtdrNceqj12GEv97UbctYWr1fP4hRqeeWvA3sU5LNyoI5z3ds1MJeYskdyAiCDceXzqou+XqAbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737717802; c=relaxed/simple;
	bh=5rxRkPnumzzfAdemdZBFDf4pCGC4z3dLReWUJOLysOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfRpp8faaTbHj+lgrfpwmFIJSLSw/621Kx9qpCdNomggttoFTMwkyNXPzopnFbbavKDzlPaU13sl1XioP4j0fINyTFn8gNdKYkzWKFdRHLNgy8EuFJyjIBed+0qyd6kOVHlkfla4yLsm8eEC63bV0zuA5x+JgJYEpXQ1oiqt+Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D5NYFeEC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OA5Ykw010917
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 11:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yQsJM/reDtTZynjk4EeE4bMecMMhIsTfkx5E7VPjZRU=; b=D5NYFeECrB+NIu2h
	0RjuRpUEOxguxk9hUACSGBKDDxE71BQn0PWFc6KO3j7zTlHLAt0o2ky4Ao+8XKtl
	2zQ3rWfdUNtddM9z9k+5HCD01oknrLI6JnEe+Do7/vrQTCRlrRR8uGCUlVUrx0nR
	7kveaNHmapp4HOqsWjmk/IpidsBSKmIh27p66QgDh5bd2FGJnGh8FUD0c16LYPhm
	gMrp5OZot+3wCkSQ11hZsreTMgFhg82YxNs0b66bWkRdXo4whZ16DvHRjTdR5eJB
	JuYwNnLNoaGk9V4bR7D9qVtt0aEpokDyNgPDskvkKymWdj2bQZ7k4Vw9+S/90VYJ
	0R6Umw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c8ta892w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 11:23:18 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216750b679eso27508865ad.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Jan 2025 03:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737717798; x=1738322598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQsJM/reDtTZynjk4EeE4bMecMMhIsTfkx5E7VPjZRU=;
        b=WqtxOOU97uSlzkEgnHDD/TEyWZkE9x42yaYv5gm+xsbvzCwKmXWX7A+eWoF/eXYWgL
         yIGzDVUnihAL1khVpTT+LJzvIVes3P1QmUrBm3WylH4i60cG0dC9SWkrs26IDOUkJgiA
         VYQNAd9t8yFZ63rLsSe9JNN01mr50jFl8NHUwexS73JgE65mIYDsDZlnDDvSkqmQCbx6
         n32Jrlol5uZbnh8MRkps++Fpp7kDlFGrqKhUQQMzlAB5PXvbT67mEfaw9Ox2g/jix6DE
         ZNELoUy2iSsxXyKwqfhMjD7X16HZju8GFQj/V75eS62rZg29dYKnmyF+JrI8iu8nKUck
         LaKg==
X-Forwarded-Encrypted: i=1; AJvYcCUjQjP/Byd2qRxsRbtRJupsM6djO3VZQmFDZV41NjzCIHol20EEsax2lFYVS0LomzNJSBQlyqPr00c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx+pDj7vo//SFkeHiB+VlgxQ9tZpuhyIOdUR4Xq4PoMlBOXSkG
	Uc4mJKIXsMIHV6GETf87BlAIrHo1/cVq97zcmOJ1tdHTbLYShNLotIUzzvKNlOGWTsaWUDF2I38
	bLjhzYZ6munKo29TqYVl2cP3ExVhkfdeLH2wzWDFyc1WQ9xpsv2lGSQJa6G4=
X-Gm-Gg: ASbGncvNbgbQDh3Irc1/Ziauc0h/B1m0hdSxfXDnTVLxgvV1spJ1ft4UtzuIHDEtpZX
	4JK5pUnaacR/b2FQjQgRJRclN7ev4nAWowiZjOElG+eI4BRGA3kGi3/0U9KPdB97++UPBvHtSY5
	X1uOlBV6D5Xjdji0tuk1hUmIbV/4sgXMillQPH8nqsqKkVTMuvaDHuCHTBr4iSjggRSlpS9SnXH
	Qwwj77SRvC6gLRznhLQ/XpdZLndikNhNaNmcDYtElQwuHRPZjlmq37QxenH8c2lzt8QEXdS1Omq
	07J44LEvpk2Q29nVSXmn3X67QP0lvQ==
X-Received: by 2002:a17:902:ea11:b0:216:3889:6f6f with SMTP id d9443c01a7336-21c353ef827mr388132665ad.17.1737717797950;
        Fri, 24 Jan 2025 03:23:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3Jqk6JwmPr0oV22Ct9YC/haBNCR5+wlGUm1dWyD9lp1UJigU4ZqRujgW8yn5pehGWZ6HDsQ==
X-Received: by 2002:a17:902:ea11:b0:216:3889:6f6f with SMTP id d9443c01a7336-21c353ef827mr388132335ad.17.1737717797512;
        Fri, 24 Jan 2025 03:23:17 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414cc20sm14025385ad.165.2025.01.24.03.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 03:23:17 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 24 Jan 2025 16:52:49 +0530
Subject: [PATCH v4 3/4] PCI: dwc: Improve handling of PCIe lane
 configuration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-preset_v2-v4-3-0b512cad08e1@oss.qualcomm.com>
References: <20250124-preset_v2-v4-0-0b512cad08e1@oss.qualcomm.com>
In-Reply-To: <20250124-preset_v2-v4-0-0b512cad08e1@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737717776; l=3448;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=5rxRkPnumzzfAdemdZBFDf4pCGC4z3dLReWUJOLysOk=;
 b=DonzVQzdHIl/WfHGG9u0Cqbhe1IO8nnLwtceD1UvRCtOb+1eL/WEb1u3AvWnzxwtvnu2w+jjh
 /JUC2z5bR+ZBzFWy77WB08SVCXfQqFBvYWAlzX4NH0b3nqUKL7QSwTF
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: boN4gLrWSaKWQ-6CzLFdSQ6nxHvmsgH0
X-Proofpoint-ORIG-GUID: boN4gLrWSaKWQ-6CzLFdSQ6nxHvmsgH0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_04,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240083

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


