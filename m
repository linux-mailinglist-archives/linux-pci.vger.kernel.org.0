Return-Path: <linux-pci+bounces-34999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B15B39C9A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AF287BA3AA
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E539B31352D;
	Thu, 28 Aug 2025 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lt9sX4dG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD83128BA
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383040; cv=none; b=iuk3nT2RC2QQWuy1XlL5EMJkLQ65B9p81zodMXaiwzcumwIy1MEIgpZfaN1F6Vo0EQUoyuUy7XZKq/ve9g20VhFu1EZ57/APDHSApt+cNQJV8EACcGDWC9o2fLSvJPliu4evt5rl1vS73qfFJwtwXzrOMdHPoy58MPyx4+29YqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383040; c=relaxed/simple;
	bh=pMaklKWqapFpWdv+7J9AHF7Bw2YdzTcWihkps7qIAps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5QmByEMIqKHS+/4ikEt+ubJfv+TTIHr61drzjEHw2IH9sYT7BVIGcAq0LSUZDsAl4UTEWipdHvVKJ2xHk/GW3UVEbjcFd51f0Ua65V9g2b36euZlhH1y0Gk4MxkATyXDL3vs1qNGYjBXgdRM+hRM08fSS3NtH/GwFmnqTxuY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lt9sX4dG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SAE6X0007255
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LYoFfKuu5GFLrCOXiIOOxFQX14nlPMmQHH5fe4JzCMU=; b=lt9sX4dGkNtDFFDt
	bAT2gpDdQNq6TYuLT1r45kOPejvUIoSVzMg7QHW3xNAXnYaww37MCIAWVtehpAjp
	sTRe3JjCwDyRmK5UWLQqmBTRqIdg7/fsYpr3BrKklghJGXWnnYhOFarWW5V63F2/
	hZiPzoYfeS8gZ9e4HYAqyRTh+cG6zfvU5jcFDk7gEFJOt9KqluC+DFxKIMMfvYXB
	jgfUqVX43GlHoFRF99H7ZsBA9o7v6Mn4w2FvAzJwSbgX2wcUAWVfP1zyJ47EIRJ1
	toXt9JaMHM+8Pa1vArSvZhCNPFtOJ1HeurTzNhBesRMg1BHv28mrwtSYuzTEDUuO
	uC6zcQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tn67ga45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:10:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-327a60cef33so841381a91.2
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 05:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383038; x=1756987838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYoFfKuu5GFLrCOXiIOOxFQX14nlPMmQHH5fe4JzCMU=;
        b=bNLAy5ehFYANXnlRRpAsp3MnbXJI20T+KlzzeoSqzQbOwYXDKbdyqjAfG14BBxqj4v
         RKIkKjwKTmjMth0SXxb1iX8gqrIPMhgYSADjjT8/UA0vrOOszPmqpcp5KtsJtOjOf5nl
         W06iIPK/97OsWvZvp4q3G8sRlWcaPUQy46MHX9q8fpT6eLzNZ11Ic7fpdqrHuaRL5MQq
         BfyF3V/StaVctL9engB8Hi5UQnwJJH3zjogJAxK6c7G+hwQ9JjrGmMHy8TO+qGBO0opg
         NnTk8rEze4xdITHL/1pM2eOLzr7Mrn9mIhVa9Pl011ZGinzxcjtQEGcoBuk9kUQAuA/g
         eXhg==
X-Forwarded-Encrypted: i=1; AJvYcCV4XzCFH7e+P0KmE2yNNX2syXHPtpbngH6vw4q7ilncml17EsGYlrDxc1fb0ecvr7b+rgj4U/UosHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUD+xArDFsc7F53KypfQ4c37bSxa9Gsk3t6ORdLT5nWMEF+/nd
	evstTyCTetz9b9i359W2Gu/EqgS/iLhAmhzxz8jI2Mo0IJiv3Tb4DtuykfMns7pwAqf3J6OR6ZL
	M1TOsKTMR077zHF/qfyPw+zGhfzSgl1bf/kQ5RefcnUI8hJW8Ysr7bQ6RvNGSuCI=
X-Gm-Gg: ASbGncu+iNTZWrdFGGjYUmk48AYl71AH1K8+95AzR68Smmv6UJDrjUshxm0jp7VjSHA
	xEXLBbbRZ8TYDN1sBjH30YZSWeGAi4p4eHuVcsafGyCncH+ArUHVVT8UXG0D0yW8wpMgOq025ik
	QJjwD/7lPD3aiftZDudnKWKvUFwHOnLsnn6EiY97wIylXIfpjrrDdLoFyZQ0foHKrnUA2oG66gr
	APOnBzp1pnDybjGICY7TIFGzJDXjWQZbw98qR05kyPS/84zw9mSIZp5KsIsvJykOXOMK6slG0Gs
	nI+2SoWtd/HVF6QGohMqjdZBNGERyQy3/joAuv7gNLlQCB3l5t0IoEcLZ/UI5Yw+s44xNvuCVY0
	=
X-Received: by 2002:a17:90b:4e87:b0:327:734a:ae8c with SMTP id 98e67ed59e1d1-327734aafacmr7013833a91.10.1756383037346;
        Thu, 28 Aug 2025 05:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvAJvJ+Agf+PXn5CDP3LOj/cLF51Uz0w7Smptbs5rUVIF/mhglzzjjGvG7lqCA625p35ue/w==
X-Received: by 2002:a17:90b:4e87:b0:327:734a:ae8c with SMTP id 98e67ed59e1d1-327734aafacmr7013775a91.10.1756383036835;
        Thu, 28 Aug 2025 05:10:36 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm4019070a91.0.2025.08.28.05.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:10:36 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 17:39:02 +0530
Subject: [PATCH v6 5/9] PCI: dwc: Implement .start_link(), .stop_link()
 hooks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-qps615_v4_1-v6-5-985f90a7dd03@oss.qualcomm.com>
References: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
In-Reply-To: <20250828-qps615_v4_1-v6-0-985f90a7dd03@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756382994; l=1453;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=pMaklKWqapFpWdv+7J9AHF7Bw2YdzTcWihkps7qIAps=;
 b=6REL8f9VVvl4nfDJ8zLlXrHgnb2S/Rf6iqrVR2o5YAG8A93MtB3RAwJqcuaLM93mtbPWR3N0x
 i71jT6xKGP/Dnp9bpetEtz+EkkFCrvEOUi3Mq3IW8O1v/t1TpZjF+OI
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA4NSBTYWx0ZWRfX/xKFJwK3q6OK
 2FhZRSxPFyv14kcX6cG2JTmhUl2jBdLnvx/05EQ6QoHCXAz+mWkOyPhHQNhJ5ay8QGupOg49tvT
 HyLyAK/mTd4nRbSstUQzixp1WGVl0dDyQrg9RtzJ9HWl3uep2STfzNWtitwdh8CMILQrj11T+pB
 yklX1zEEjt3GjdP76ixaGL730T/Tffg6sw4kcV0uTeo4SJovb7VmUjM3pb7N7TeKkbBZ0VUeYHa
 9dm1uFbrvPRBkOtvCbZYo3FH8s7VQ1GA3X0gQrreFNKGAzuB7KkjcRHA/ZWbUPJJB5TIFnghIVA
 Xk34YsJ2JbNGGedr/qMx7N59srz13gUuLy3XyGphLw2eRbTJijaXoWGAGtA+MQ7Iv0RWnvl20kV
 FkUcj/BJ
X-Proofpoint-GUID: sJ1wZb5VNWxmmxp66QPtQ4jFh9Vpor4a
X-Proofpoint-ORIG-GUID: sJ1wZb5VNWxmmxp66QPtQ4jFh9Vpor4a
X-Authority-Analysis: v=2.4 cv=P7c6hjAu c=1 sm=1 tr=0 ts=68b0473e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=4bBsNf6MAaYI6lVPmewA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508280085

Implement stop_link() and  start_link() function op for dwc drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501254d2b2de5d5e056e16d2aa8d4b7..bcdc4a0e4b4747f2d62e1b67bc1aeda16e35acdd 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -722,10 +722,28 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static int dw_pcie_op_start_link(struct pci_bus *bus)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	return dw_pcie_host_start_link(pci);
+}
+
+static void dw_pcie_op_stop_link(struct pci_bus *bus)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	dw_pcie_host_stop_link(pci);
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.start_link = dw_pcie_op_start_link,
+	.stop_link = dw_pcie_op_stop_link,
 };
 
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)

-- 
2.34.1


