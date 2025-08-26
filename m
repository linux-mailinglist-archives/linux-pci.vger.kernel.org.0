Return-Path: <linux-pci+bounces-34745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C89B35AA4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 13:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5659F7B700D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61965321438;
	Tue, 26 Aug 2025 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jahjgjn/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E59321457
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206201; cv=none; b=O6jD8Xb7zhFPtey8s1q2lB34UUtjdPw9XMPJb0zZMktMrlm7vqNfz8IhznqbIpiBynjGCy/A2GCMjp5LR2lzozTiTEvORjmfcbHxOobLPoBYnyXxXtSqmJ8+H44Q+wreiaXHT3uR/8OY7hWsjMzV0E488wszLPIgbMDPESZhSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206201; c=relaxed/simple;
	bh=wjx9GMHTJv+sVXCnnpOXOAGgSyeX0KAgl8FPgsVCss8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehNDkddK+96s/VZ06PGnB6EZkIDdZR6qxTYeInH9ZK+t98WC+Za1GlkP3uYw1xidCaxA8adqLKmKRscq9T92tdtesL1OJVDWdkIUXeDC8tTzEBz83vkJ+4fM3Pk+kkDaxzqhtet8//C/LY2AtIf+RNWkuf5ygUDfP8knNcsBUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jahjgjn/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q7jK1W024698
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 11:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+DPSOTrO4cYwZj0R18ru4Kcr+olXie/WQj6w6L3l2ss=; b=jahjgjn/kxh6JZTo
	n78k0lULURc8IHG/Robbj7CS9D6Ss9qepDv0yicP4w9Q1ahpv9UlZNb54wuGrtqu
	QUd0dBqXPJvHfP5MZTWZZIh6yisFRFZKXoSKQ153mLYOdPNHaM4Kfn0IMDZuOe9t
	idCvDWytRnisTRH+IhQJMG8a3IgYDmMvA9CbpCItsGw6vrtdAKsGUer210NkF/IF
	5sDZQxyL+tyN4Vu6k5OyBOeKBLER5C6KsbqO1zdA6vQeuygF9g2LZ2rfroTY/iAg
	j5SRGZIt/Q990yNdOHnxW1G+lWjEtGConyEJbv/r/WKjt0lect2qmm2rcA239SQ8
	bBFItw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfgg9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 11:03:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244582bc5e4so68277455ad.2
        for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 04:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206196; x=1756810996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DPSOTrO4cYwZj0R18ru4Kcr+olXie/WQj6w6L3l2ss=;
        b=eXT3zVdYmIlu2EL2aKQbJUuZg2E6ZFRyOwUjtYux7O1o6oQHA8KJywISbQW81B50dq
         a+ETUW+Mc/5z+FpMTUFM51eAYpvRCFbIUlZ+7eXad1+V+8zLAjp9qCZqILMnVonAcr3i
         oHmHHVE6aCpaJJAqVWDnClVQQWpQsSxpP8BwcfHo3LiZe273wRlpjP0PR4AqIuS9GFfj
         Gy+Oxt1b7weyo5rPdbg3YhmncjxPMnBRCp/POK9OOVTRKEst+P3QRIK3mWPU7d15qgAz
         njE51NH+mS1/D0BDK8SSOVYTEeNG0B+9lOUwnBYhXsKXDZe4bHJ7a8O1ETrI+e5melfT
         2C/A==
X-Forwarded-Encrypted: i=1; AJvYcCUMCD9OWXKsIYrjBjjhdG+pmKoaZlY5uY5KbqtzYYfMKFG+N2cPafgm+0Hc6SSInlE+MOyz2Vgj7RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHsH5D+T8iXwkQidBK2BKjfXve7oI2ule+zXllGJqZSG7Vi0gE
	h72y9M0gpI5IEyntiaglD2Z8ggX4fTpSB3IrJ533zudRtTELnsy7qnclyXm6/t0FVuXL2f4NjCI
	As01yEImw9+kWqnrq/oYC1TAPbJKT8PtOY15A5I26YNcZhwQFf2o213qi8utXLb4=
X-Gm-Gg: ASbGncsniCujoL1ZcfpImfEP79TQ1k8udXQi769nqoBmA3NBCSDyHwfklC5tdAXFCiU
	GhXlFFoBOvNEjlLcBG80UCneff0MKAjZfwSymi6aUPqlG+6b3afbF1HLvJN7ibDG/VyrptuRT1U
	MuBspypBs7oV9LJQc7ATnVBACO+eGbKFaoaixqEqmEWWCUGviGrZ1DNsbw3qorzktBkX1vfjOry
	6VJSnXGK+/cQxrTLIbo+OoymAR6cNbZqqhwa6kwE2PvgrGSXZFM98862/qi4hxZz5lGXRV3L070
	FRP58AoEtITvKAwAzNDSTwqYu/fYUt6kACO0jZ9g4ADy7udYBKDnM5crUQN3Fi2+azl6mIDOXRg
	=
X-Received: by 2002:a17:902:cec2:b0:246:61e:b564 with SMTP id d9443c01a7336-2462f1d82c4mr184212015ad.61.1756206196108;
        Tue, 26 Aug 2025 04:03:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb/AZx3XW6vrNMBVNQNlwghugBEj5Jl+a3IPk5UUCn6++1jKG/5K7QzZFQ/5XN3S+gDRMYRg==
X-Received: by 2002:a17:902:cec2:b0:246:61e:b564 with SMTP id d9443c01a7336-2462f1d82c4mr184211365ad.61.1756206195528;
        Tue, 26 Aug 2025 04:03:15 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688a5e5esm93207955ad.161.2025.08.26.04.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:03:15 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 16:32:55 +0530
Subject: [PATCH v3 3/3] PCI: qcom: Restrict port parsing only to pci child
 nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-pakala-v3-3-721627bd5bb0@oss.qualcomm.com>
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
In-Reply-To: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756206175; l=1564;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=wjx9GMHTJv+sVXCnnpOXOAGgSyeX0KAgl8FPgsVCss8=;
 b=C0xBQUzGHEvIUVnt+TDkqiJDzJlJ3dBZwRdN3YqQCt7Cp8x8kuf2+DS17yh6DcNQNE0FJYI5o
 XBtet90TSDPCSMC2G8ETJoAda/ei6+0M0XJb054TozCWTN7TI3xe++D
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX1cuzi1siXfcc
 lWwc7v2Erdp1QShr5g89cqPNcODxxOjnwdb+jF/gXBKOsJd2uJdbZMMhjbbPwODXPkS7CVAAOF7
 onHyTRQs4ShpRsx/tOfVLweOIfZFNgPCZndkcDf0bjsc7hJWWLqo3VF3h/mdvYBanOsgoTAsfZ8
 FcAbjvgFRzl28HxEnOOiUddoUiQ+HLMVU2KH2pQe4KbC9ZJrOiWqLN/qWAfvCDj3QkUuBq9WKvg
 NlwqRfQV6viFrBfj34sPXCOjIFaKP5hVFwDlmdwaN6W8CuObb6cg4cvkMTmvsLguzo8APr4AeZG
 Xz2QNt1gnl63LmlqY29qvHWN73xzHxvhnOPK9dRn3mDvS6HmTVeXF4g2DAK+FNs8ui2tSWEg/UL
 imTvASFG
X-Proofpoint-GUID: Pee51vAYsINUC_Re2fIJ5nDszoooCw-J
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68ad9475 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Pee51vAYsINUC_Re2fIJ5nDszoooCw-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

The qcom_pcie_parse_ports() function currently iterates over all available
child nodes of the PCIe controller's device tree node. This includes
unrelated nodes such as OPP (Operating Performance Points) nodes, which do
not contain the expected 'reset' and 'phy' properties. As a result, parsing
fails and the driver falls back to the legacy method of parsing the
controller node directly. However, this fallback also fails when properties
are shifted to the root port, leading to probe failure.

Fix this by restricting the parsing logic to only consider child nodes with
device_type = "pci", which is the expected and required property for PCIe
ports as defined in pci-bus-common.yaml.

Fixes: a2fbecdbbb9d ("PCI: qcom: Add support for parsing the new Root Port binding")
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..fbed7130d7475aafb0d8adf07427c3495921152f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1740,6 +1740,8 @@ static int qcom_pcie_parse_ports(struct qcom_pcie *pcie)
 	int ret = -ENOENT;
 
 	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
+		if (!of_node_is_type(of_port, "pci"))
+			continue;
 		ret = qcom_pcie_parse_port(pcie, of_port);
 		if (ret)
 			goto err_port_del;

-- 
2.34.1


