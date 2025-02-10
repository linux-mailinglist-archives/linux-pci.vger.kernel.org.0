Return-Path: <linux-pci+bounces-21049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D955A2E56C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 08:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B550B188A840
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2025 07:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B071B4243;
	Mon, 10 Feb 2025 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QLnkEjvt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292DC1BD9CB
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172637; cv=none; b=OFkuxRcBNVSdwJzIeAAUUiFh+a91WHvmWudYFYgco628QgRYPfmxQycuXrBRBRDFophOir7cfyQQe/VUIInctpiggfbq45wlEjoqT3ctoF7wd+yfqtSt7DrHfDNbdnkKVgLu53rWXPdamFAe24RUStjFK5kEeH4tx75oMAxOhUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172637; c=relaxed/simple;
	bh=aQRQ6+sri+2FjvUvhS/l1+zsbikTMl/4NyNhdlh4S5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N+qpxfsFpQa/UH+qipVDU0oGjNd+8aDXrVPsB+/pgBN2K79qRJvmzzhxc+VzRHssp/nAmqZCQaq04PPhRgEbZMI9PAXG9CxIxbalfBldg69gy1uck4tNccsdkzxC9gQYZDn03GqyW+VOJuBN5hShTAHR5wuq5nusrQfK2TK0QfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QLnkEjvt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519MLswX023543
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wRrOHyip7ZbNQ8lQZNrcx41SX8ZDA1DYAx7l+sPi8FQ=; b=QLnkEjvtShF4yQUQ
	59LbxklTXLrVeURi78b4YdSZtR0aRY+HWGSDr8ous2OcFH2KA4sBGtghCJF+obVQ
	fvwerthjtbQ7QG4Q+h+UiW1JQukHY9geConVce1YcPGreop1rMyx8v/4HnoBaK4J
	5r26vMorQDX5clIIlUcIQw31Q4HNz1PqicK82zid5CUCm3ZnfV4zW8SqY4ZHW3ST
	tcLRke4ZqPWvdgQadR/+DwEaI5UqayB3ndNbAEahLaLC1S+IT3bVrrOBr8QOsmXR
	RCO3S1sq0fFtXSMrgHsgHN9NML8u1wsB6UIXsU7twxrPzRMhcLbaR12kT/mdu17t
	CWUfzA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0guudcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2025 07:30:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso12694011a91.1
        for <linux-pci@vger.kernel.org>; Sun, 09 Feb 2025 23:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739172632; x=1739777432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRrOHyip7ZbNQ8lQZNrcx41SX8ZDA1DYAx7l+sPi8FQ=;
        b=nCkffvWmi7717JuaGb0psM9z2UCYd74PxwQ97zGHxO9fDhwDnsK5kPx5Ca5b3DpqZy
         tSmHgFa2NIfI7u1v1eyUdYIbrKnKD9dIZiZg9P3gsDDsJDvOcFspHPXCDHrD/Yp4qAc2
         k8z+h1EPmiF58O62rs9VgX4rtf7XtdFW9p+lX5B5Cf9/vvaZRffJmHVlSJj/2KHayQnS
         4r4vhHGvMAsOk/5B8nPtj7oCsnlO7G13ih80F7VOcSQZqm/18Kie2WdVu/ViOKZLLnef
         Xuq8aSKNjaMJMNmRk2/G/EFCZK7ft5ZgOfnlLayqQXG9Uk+IgnuCdZV0tUsvARzkPRDZ
         KsVw==
X-Forwarded-Encrypted: i=1; AJvYcCVHyEGFqFKzqGUS6vRBC+ObL1+azxgZ5M6Gy5dxaJde8AtTJFh8YSP6whvwpMpdR6oZMAwJJNO+q/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YySkNUnDE9x5QZ8jl0AcXb3WqdDcJo4oBl4Tr1qCBysXkej5WMT
	o+Ma/zusfqMcBvl8Tsjkj4UBTosjAR8aY+BkfoyPFJGYjxAoJ/6pzZGiJSpS2uh4IDC5BbeoEfs
	7RSoP738RGpEhpOY7aGDK9qSgh6MQIdGtaDVvaB2Puwjia9xbzKiXqrXF7bw=
X-Gm-Gg: ASbGncvwlkGQcVfX5erVeIrvMSUH9TOL3Wxz8W3NnMZIHuwI2Oz/7Ily0Z4/TmEoR4x
	CFwiRUe18mXwJ5/gZ+x3Pn07mlVcSseHKvb7TStxTzUrHcLcTs/5FcGfLMbOk4q/eSDexjSIXdh
	G/0lSpD4WG1814egY2mYRmFhpE+6Cfb5CcCA8A16ifiproS8hNoxygYaykeD9HloMnRa3JqxU0D
	I90q41ncDAqo5l26SIE8CaBiEDbHXYiOilkidM6ThM0JYkcXAvCbXRX6e3+8C7jqXl8EcjVTadE
	RCTo/SDpapa6CpWSbIJRPWef0LyeeqpLH5kuvIhG
X-Received: by 2002:a17:90b:2ec5:b0:2fa:2252:f438 with SMTP id 98e67ed59e1d1-2fa2450cf33mr18714854a91.30.1739172632487;
        Sun, 09 Feb 2025 23:30:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGC4mFsdhr14elczMdgif0tIJ9T32NQVRA86UAwGYhm7aRYQ7hdqOUHt+ZP3HEWgDqCFnMgDg==
X-Received: by 2002:a17:90b:2ec5:b0:2fa:2252:f438 with SMTP id 98e67ed59e1d1-2fa2450cf33mr18714812a91.30.1739172632097;
        Sun, 09 Feb 2025 23:30:32 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a6fe28sm7918507a91.26.2025.02.09.23.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:30:31 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 10 Feb 2025 13:00:02 +0530
Subject: [PATCH v6 3/4] PCI: dwc: Improve handling of PCIe lane
 configuration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-preset_v6-v6-3-cbd837d0028d@oss.qualcomm.com>
References: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
In-Reply-To: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739172612; l=3073;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=aQRQ6+sri+2FjvUvhS/l1+zsbikTMl/4NyNhdlh4S5Y=;
 b=VCnpoykv6zQRuJNMbEm6VdCa9AY6fq++JhPDYFwoMtavGyTSlIFAEqHNlne4oCwsJ2w9Dw0a0
 /v3Lv2XJzR1DAxjBZMQrUAUVCbu6ncBtGcIvRRjc/DYwqXY2GU1QVwy
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: dO-SQEKAWAtkTqS_2dZ8kNjSpnPZk4_N
X-Proofpoint-GUID: dO-SQEKAWAtkTqS_2dZ8kNjSpnPZk4_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_04,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502100061

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
index 145e7f579072..967c62cf3db0 100644
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
+	if (!num_lanes || max_lanes == num_lanes)
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


