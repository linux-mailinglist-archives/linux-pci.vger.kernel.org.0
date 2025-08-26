Return-Path: <linux-pci+bounces-34699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A54B35327
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 07:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2052416B3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 05:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E8B221F32;
	Tue, 26 Aug 2025 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FMQ8bmrp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A6B23FC66
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 05:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185521; cv=none; b=C4xqMUUkLWdTr6f2EMZ8EHuTljKsQGwFxn5tgXPk13yUUW43qjSbfB1ka8YruDb4I+3CminXVqVhGr2+tuIF0ahLOwhgxbPWg+VbI8nUmq4l2RIaqi8Ms2WqmglDKbFS6eIisE6YKSIVbYWcdEZRguU5csgQLRB/8pFlS5NrB1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185521; c=relaxed/simple;
	bh=jBBl6A3Sxsg2d6MaEgBHO65kZTpSDglRvHQ0xA/RmfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHucR4t85O0VzoLLMD9/jT88ycKPHI3HOMdRcSsok4SujzJT5tAFGdKMNruxOwWipJXzn5/pJR9/lPzpF9mSlLG7YPOK1N6ddK9V8zvSYGPHZ3LhQTxB4OROEU07s70eVE5pnzweuqvkyACnSA7L2F4zeG5y4FXR2nGgrhTu1t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FMQ8bmrp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PMjPgx027946
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 05:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kofxhc8N7wzIQRIEJ2kzWHMlZjkxlt2XuX/b69ntAxg=; b=FMQ8bmrpH0Fb9uiJ
	W05bJiRqeYmofneSgc7YqnPmNUBXq7ONs72v07tgYj6LHYSuPkkleWGFAyH40+1e
	GjCCMg24nRNlhhw2mKtY9IxXpxRI3etSIonz0s4u5v+oUw5cSUrk9+l1N2h5lJG5
	C1Ucj90fXZv86+4HqwPUvY1CXxx+ro3TAASxP5irLWFnqM4jdYoh5Sv8LB97KTnA
	eruF0ssK0AeWkNEZ+xTnQaEjnvoeqnMgmfroWrmjJdPkBpK1yNkhvytiN888MwpB
	jiOYYXFkKsBEF+Bgn0HLQ6d8YzPkGc/WNhWbRnoYI1alFuL6XqyRmso106+3a9K6
	rGS5RA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpesuyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 05:18:39 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445805d386so59487385ad.1
        for <linux-pci@vger.kernel.org>; Mon, 25 Aug 2025 22:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756185518; x=1756790318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kofxhc8N7wzIQRIEJ2kzWHMlZjkxlt2XuX/b69ntAxg=;
        b=IKAZQSN7o1Zuava0q81h/rgXwvPZx+XJ15MJDXjlSEAveA43zxOpl8bqk8H+VbSF0B
         sOMngXcv8v8Lnn0+Xd/L/7/2fCPzwZfq3vlrnw6BhFH0p+Z4DAMRCHWO3+lO1pfLwMWz
         GkcgTRpbZPr+ajZBp62JsTO/rfNv+3Y1EmalDMqjKUiDbwPlPRlCgBPIG8pJJ4aES40A
         N0/ZFaZ7Fk7xHX52pQJ7pcDhEOFDEBXNBOP0r8dwq19hVpP7OPk1cRlcUna5ZoH0VELe
         FGEkovr/Tocp9ZIIy2hyElCfLtbRqB2kVgHBGRfVjpvcIQKeLrquqBxmIFRa1/xtSBlJ
         5GHw==
X-Forwarded-Encrypted: i=1; AJvYcCVwnlMIeiLb4nO6ytvuJvYJoyiSJhkFGIfpD2L629GjkIB4FKfHez2dDmJled4zTvoO3bOb46Y8H4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQ1+oLnbNx5KUBB4QfoK7iLv0wMRcI3hB4trGHv+Nt39ejFVe
	1zVnpiewcyZ2bvOHuU+Tm+w1oo35SDdK5ts5oYaKUYT0MB3pC4n4ZM3iMePF+Ood8EWapmmHIUu
	PfxL+1FNKyCkiCE0mkLQYhgEgC75PpZral7CzV6OnwQXpcnaLwZXLPTeP2rSqhHU=
X-Gm-Gg: ASbGnctcLvhJ316tSfhrEMX0O86C0Q+Hal0+qKhc384ZGOophXVsrpizDk84M/wFiwn
	4bLVxsgHWEGc4ik6hqUI3IgGpTa2XuyRUIzi2ttfvaEenP1HtN5+ysFPymOwXUYXLgc6ZOkOW/x
	VGEiCh89yeJg5+lXFsQ74KV/18+2gwdhF1m6bXhgeXP08A9lLQ9j+spGpjkyUhyfGGR3e6O1/J3
	V6r3Q0Vos/M9s48NzMbZKh9QcpXGnOVnsAYjOsyQeyG9W20uLrA9O0IMVmJYmQZBuiHrpFI1N5i
	X1h9z3wbaHFJYbNCfCfV1w+Ks4nenr31BfL+pRttyth73Ms6LAq6COLJeFF741mmiIMzbzN4ngU
	=
X-Received: by 2002:a17:902:ce01:b0:246:620:a0b7 with SMTP id d9443c01a7336-2462efca36fmr198911535ad.59.1756185517805;
        Mon, 25 Aug 2025 22:18:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6jaIv7DtGJPobKQ+27XcXwD3MZpcVOJ/10YwK1S+M2DJVkeRw1bb4S2/CrZ/WaSRWL2lVxg==
X-Received: by 2002:a17:902:ce01:b0:246:620:a0b7 with SMTP id d9443c01a7336-2462efca36fmr198911185ad.59.1756185517321;
        Mon, 25 Aug 2025 22:18:37 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889f188sm84348085ad.146.2025.08.25.22.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 22:18:36 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 10:48:17 +0530
Subject: [PATCH v2 1/3] dt-bindings: PCI: qcom,pcie-sm8550: Add SM8750
 compatible
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-pakala-v2-1-74f1f60676c6@oss.qualcomm.com>
References: <20250826-pakala-v2-0-74f1f60676c6@oss.qualcomm.com>
In-Reply-To: <20250826-pakala-v2-0-74f1f60676c6@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756185504; l=941;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=jBBl6A3Sxsg2d6MaEgBHO65kZTpSDglRvHQ0xA/RmfI=;
 b=NFH0HQvjBdon/4JFbP282Z0YCzHarUAwH2ON+nxifoqe6QlU5ydUhTiLI6wIU+BXaxC1p6m0s
 tKeTnzhnnbqDC3D8RmJ+jPdXWdfmKH5G1e+8nFD6BczmP2nIBmyk2O2
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: rnYfokDJKKcCCkQD1T4_DyY8JSSOXF83
X-Proofpoint-ORIG-GUID: rnYfokDJKKcCCkQD1T4_DyY8JSSOXF83
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68ad43af cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=ly1VyIkaSgMpB_u5KqwA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX28m/jceVefm3
 FR8rjAieQV85K41c8e/WI9V6aH4f0W74suvN0jI2G8Q/o/sUI2+VXFNW3PIBElP8/xTe3t1pyih
 p4wI/PJV64OBU/SUdJ6QQ46El8yyBYcAdkRokCDUmi2EYk5p4maU2HtjeAW22t90Fg2KoIeVEaL
 BLc0jMCICTJ/Quyud1HrT8m6y2B0SFlESVcb4yn/ANUn2FMcM+upTJttuT5OR9AU5uBdQ8EVdfK
 rZKlDiGGm7bTRnZ/ZPGk5lLUXvU72dax1gBfK/o6O6dl/6Xk3CSEZg38I7NuUdJn/qeElztfuMQ
 aJVWOCmQI5CpRa+Xfhc7TfSgNsdnNWTPBnJDHhf/wHh5ZLIca8gJ0yn4NtbezMZ8567GDV9/Dt8
 jONiUXAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

On the Qualcomm SM8750 platform the PCIe host is compatible with the
DWC controller present on the SM8550 platorm.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
index dbce671ba011c8991842af6d6c761ec081be24cb..38b561e23c1fda677ce2d4257e1084a384648835 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - qcom,sar2130p-pcie
               - qcom,pcie-sm8650
+              - qcom,pcie-sm8750
           - const: qcom,pcie-sm8550
 
   reg:

-- 
2.34.1


