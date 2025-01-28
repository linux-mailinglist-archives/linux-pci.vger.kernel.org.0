Return-Path: <linux-pci+bounces-20445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE219A2077A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 10:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3E3166AA5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C0219E98A;
	Tue, 28 Jan 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k3vWDOUN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012CC19E806
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738057088; cv=none; b=lDTvNrWSuuf87t+SZ/zDhiwLvI4xvtv3iGrvbAhV4ENBEUmb/KfHIbjitLE2AIvH+/F8TvwRyXlvkSrGPB3L6oiBZbNlJUcfXkoDff5MTNOu8TKX63EXGXz9yxgj5AQGWmjaiaGzb2xfRASMA46Chyl+8DueGPsFMrvYLUVJTws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738057088; c=relaxed/simple;
	bh=aNUEDnnBXJmAjyo+Rv+xBzm6n/bBygSEIE3MuD7dTNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=toCVuxRJ5RxENzzYJKkwFGSxDOZqQiOVkxqlSrIt5NLshLehaTbh05Ebgh3YhgjTuYI9HelQmzQc6ZQRNtAdYu3ncyYmv7GLLWLhUvMX6xc5q+EXusy/lWRQ5s5XUf9OYmtn903D/cmdgeh5m2qmX1fEQ4UUHLmR+pRaBdVyjIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k3vWDOUN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RMrdLw032733
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 09:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XSzEhIRdosnOQdlh1gNHLhzWcdv9LO4gzDz9oRpq27k=; b=k3vWDOUNzKbltxew
	+htQSftzkCD+qxLObLypik1EJhnN9qVGUEORriupWZiy3nGcqG0XWEzGSSUpztOV
	0OMBPTaeoLq7TACVcOXg3snufgWFMJUWDrhnvYqkwQnQ3FbnfHQOvWvK2HXjdizx
	21qTePgO1h9I1ZTV6xq1zjJFt3irnm4FL2l3qr5WC4IpNcZenlZ9mRTat3qF23hT
	h4nLWCwWC1Jr5598pJoF9Sa/e0e0vrM4uIfp7rR1TuIQz5StLO++fa6+15eftiWN
	xHcV2fH6xWgfNl+yv1FmZHHs5gg6uHQL6RiBnRvJKb1Yt/T5wNITL3h5nSK+n5CA
	ZoDQmg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ekb89289-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 09:38:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef35de8901so10121248a91.3
        for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 01:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738057085; x=1738661885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSzEhIRdosnOQdlh1gNHLhzWcdv9LO4gzDz9oRpq27k=;
        b=bWp0QbZZKqmYQfyj+0uxGW8AOcSckTX20tIk8SXFBLTQ4F4IbgdJCqX74aHOjUMVW6
         1bGRIXRv2J0JahlYyKkK7jL+XH9yqTDP1PCFfMV/EY2TENz9wNUDqgi8EGLzWt1UzkMX
         a4IHLPtGI2yV421u9VkL9fXjv94c3kMAWB/mu2XR7dWCbVhmgSlGVDrMp1HjEOdLAJfq
         5/3Y/sPmWicbiHht2IUFjBBEP1ENzCY1SgjggxSzKqLeN21goHfFV6UgA8MGsrVWHR9O
         cJ2QEfQKRnnZqZWM+tioQL/+MSmORGjceaewSXhxiDJIelQlcFeILTrB0SHAZGH071j5
         WeRg==
X-Forwarded-Encrypted: i=1; AJvYcCVc0P5gl2z4W50EB1ICjLw13Ymj54HV8TqfH5MPbeAcXJgaDxWUb64m4GlTzKcDWc6QiK1LGMFh16w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPaY3Grp/Qg7pNVAcZLFnIh5GbR16c8EeH/fynO9d0BPKNv2Z7
	WEdDiv0qk+iDkpEMeOfTiEeGpwGlG9YHiKQKsghc1VY89rF7ybqGE68ZqVd7/Q1JaNZDYcfZUP0
	scfwBP5Wa4fvhgS/54aUJk7pBb2+Eo9Bj4++bU9WzWiV3b8n8mr0KwSwgyXeDkSY2mTI=
X-Gm-Gg: ASbGnctBzRrFCWIoJbv2eHpQfQqPhADfVUjBdDWAu+d/nNROqZTPmOrwpSNQvVNKbwL
	ph9UPcft/H7/fHTLoi+oFVM1mQrpsZYHdfDL723LWJ6SynLKQo06G0BnZgiaTi08v8HGMq4TkEH
	fz3B/KZppvE0u641hMT7vmE69UfgRNDznSv8SwbSP6O6gFpE75Y7p+K9hwD5EI7RWswd1vBv3fb
	qzgdum6jK8C96v4lQGAWoEzknyTx39adkVDTGShkbeUJgkjyHenDW/XlbB9tA+HgTyRIzjEsbQI
	zDoMaDRXXaJR6TEdh1OWKhJtIJefzT+9dGXV5nhn
X-Received: by 2002:a17:90b:270d:b0:2ee:863e:9ffc with SMTP id 98e67ed59e1d1-2f782ca5d86mr59282600a91.21.1738057084965;
        Tue, 28 Jan 2025 01:38:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESpE/6TmYCtn7vt9b8+M+eOqAHMi7X4Aa/jIxEhceUkinauqe95Ek3jOdkLhDitwInRCGZ4g==
X-Received: by 2002:a17:90b:270d:b0:2ee:863e:9ffc with SMTP id 98e67ed59e1d1-2f782ca5d86mr59282565a91.21.1738057084592;
        Tue, 28 Jan 2025 01:38:04 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa456absm9749501a91.2.2025.01.28.01.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 01:38:04 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 28 Jan 2025 15:07:41 +0530
Subject: [PATCH v5 3/4] PCI: dwc: Improve handling of PCIe lane
 configuration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-preset_v2-v5-3-4d230d956f8c@oss.qualcomm.com>
References: <20250128-preset_v2-v5-0-4d230d956f8c@oss.qualcomm.com>
In-Reply-To: <20250128-preset_v2-v5-0-4d230d956f8c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738057065; l=3427;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=aNUEDnnBXJmAjyo+Rv+xBzm6n/bBygSEIE3MuD7dTNE=;
 b=JcDyBKDyG0bP7cftM+W5ncKic8gdrE1Q9GqpbicZFepKvWWI1N1o99MUistpklv6aAFxq7qvQ
 zfrRJu4ShbwA9/G7L1H+z6Al+NvOzMVbk8ufaKbB7qgjF673jagnjCD
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: k0wf-Ao4oZIAwf371YQwcVcVF3fd1cgn
X-Proofpoint-ORIG-GUID: k0wf-Ao4oZIAwf371YQwcVcVF3fd1cgn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501280074

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
 drivers/pci/controller/dwc/pcie-designware.c      | 12 +++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

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
index 6d6cbc8b5b2c..1007248d3525 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -736,6 +736,14 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 
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
 	u32 lnkcap, lwsc, plc;
@@ -1069,6 +1077,7 @@ void dw_pcie_edma_remove(struct dw_pcie *pci)
 
 void dw_pcie_setup(struct dw_pcie *pci)
 {
+	int num_lanes = dw_pcie_link_get_max_link_width(pci);
 	u32 val;
 
 	dw_pcie_link_set_max_speed(pci);
@@ -1102,5 +1111,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
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


