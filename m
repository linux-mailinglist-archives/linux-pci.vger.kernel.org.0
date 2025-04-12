Return-Path: <linux-pci+bounces-25702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 716C6A86A33
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 03:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D18B8C5D16
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 01:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E5A15575B;
	Sat, 12 Apr 2025 01:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iUVyLRgr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC90131E2D
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744422645; cv=none; b=sNUcodO0tDf2St+5UHPq8Wm/kamwC5TmrKQkKz5D0B8YB7c5jkkRKK15HoE7hCSf+IjGIgGEWBcdwMPzrpqplqJ0OflnBUYA45LSpViLtW4SbBWWkUOzMdjUTi1LokhTmr+liphq3H7SoWkNTt3i/q6zaXOqD4YVs1pBpRe6FmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744422645; c=relaxed/simple;
	bh=XchJ+I4Ear9gG/gPsK09+clneiUIEGvSpQq596I1TtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NiGkdmeP+4q/JJ+s9fuGKUz1oIFRqMtm8h43bbysjeGteMT0sGJCJd1FyYc6pmZ67Q8Gzo9p0Vm8YwRlD9/GefEdNE1hu0HF/fA0245se9vfxkqsK6XMzC4u4ta6BY4+Dj+LCMNfymX7zYvja+AHNyXK5gatHifbmT7SB4j6k+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iUVyLRgr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BF05Zg019674
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oYOi44WO+zkPOJCPPKYoUWpuQQF+pIDf3S5b1isNpYg=; b=iUVyLRgrMPtfQKsb
	qKz8n8QgQAe8NRriMpubBIO0Xo6z6rJFmstIYLOWy/Ue4hYy7p0D8QSdJxBGaE7r
	qbncEuFjBpF7PubA5qJe/C4s+2uyFzIcW0Wn5U9DdFzQtyBNgqYiJ8f3EYJ8zcGv
	w4+IpgT+7fRmeLu2HQTgTDELAnoyEYhoQwLdYtk4bNELaP+MVikpeo5PyhwC6rVu
	yGZU43GghVaKS7ppjPAv+mhzgo9YjzX4kot1eX4OoxS5H9EOItHt7gPLQQfE5Vva
	RZ9+grN/ITLstOR/cze44JZerEkPTE4YDc1j3u1VSLb8lcRXUjeelNfpxEdCN/Xv
	DrS7Uw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twcrv6rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 12 Apr 2025 01:50:42 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-af2f03fcc95so2736655a12.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 18:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744422636; x=1745027436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYOi44WO+zkPOJCPPKYoUWpuQQF+pIDf3S5b1isNpYg=;
        b=CaCJcK4O17x7o4zYsVG/DbLNdko7yJg5Ut4+Bs9feCBvvYP56yc7+4evIgRAcKO4YN
         IthZj0eZuwfBZmf88OY/50+GZhAWw7Dt6OShWdJ5Qp0MKE8J4ipU4pG/2GK0Ws/e9i94
         pfn8Y1Bn0DVrybGk0iBLV1DHbQNZ3eZd9n2mB6gz6JjxgxloupdJnh3DkP3rNNsvLOzB
         j0FtQeQRjMgFPm9b0ezuE7jGECAGQpfJUFqPPreCr55bKyaX4YnmsxrNFTji8wJU4ph8
         4Ozy5rc3RSGWILlMlC/fO2y7P/exzMmCvj4PpIrSNYRUsR0J2vy1yipjtHXPfVVnpeC2
         cXgg==
X-Forwarded-Encrypted: i=1; AJvYcCXDUzt9OBhv+W/YiIcrafA7fiIw9fNLc7LGkO01+MzjseiDbaR/F4L+UuPT0C+QJof2GnOxaXZ+FtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRlGSH+beiuG9wamVBflLn5lGc07yQKaP7FMTCvQvampmQ7Zzs
	4XTJb/eTnbm0LEHpWC36rRrza8hImXMz44U1Ssxmu6VY//dflzUTk7GT14mkkRgH27fu5MYojzq
	+Iq8T/YauLzeRgVFLbvsPofnRPnDGg96NpGBpwLIoDPOyVYHijhhK/1KCNKs=
X-Gm-Gg: ASbGncv1vpKqAb111DHsSqVqqFUTUPqoW9RBbfPocAtMNxHit8rNanbYRbbaOQI8vWV
	CcXu8n/vbQe53A/0Vzo8G5cxIOcTbkP9jtq3IzOksdO70lWX/BKChR0yzGyD+WzFUFPwwZAmUKR
	ksGmFIKX0/sxiIEKu7fyWGJyGpRKPWEMOqFfYNriBZJvH6OJELaAu+zfazMclrTwvGGZ8vaszqc
	v/CbYMhRSriZmAtrTXbcdpO65gjLdpOgZ01LG+FW5JZTMxCwfM0MVX6W4fwD/rr9ntwQXUNhziw
	HoavNtHUYe/7l1eOWFPqJ7IdETUDKN255QdEAVNvR1xNlOM=
X-Received: by 2002:a05:6a20:c706:b0:1f5:7eee:bb10 with SMTP id adf61e73a8af0-2017978ef74mr7640383637.8.1744422635720;
        Fri, 11 Apr 2025 18:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy1047R5RX/zZuv/NuW4Ly4u8E8wOw/508EQSTeQ25upBk1E7jkKhJZb+0VeQZCmxsbqlEGA==
X-Received: by 2002:a05:6a20:c706:b0:1f5:7eee:bb10 with SMTP id adf61e73a8af0-2017978ef74mr7640354637.8.1744422635377;
        Fri, 11 Apr 2025 18:50:35 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a3221832sm5516825a12.70.2025.04.11.18.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 18:50:35 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 12 Apr 2025 07:19:53 +0530
Subject: [PATCH v5 4/9] PCI: dwc: Add host_start_link() & host_start_link()
 hooks for dwc glue drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250412-qps615_v4_1-v5-4-5b6a06132fec@oss.qualcomm.com>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
In-Reply-To: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744422605; l=1587;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=XchJ+I4Ear9gG/gPsK09+clneiUIEGvSpQq596I1TtY=;
 b=wEfDVbJqT5k8/OZ/k547iX0Qa5pXN50JwZf/j1S7SDGoiMIVHQM1ePMT7j4SCMnCn6QscZUX3
 l7BYCLpHIFJDK4KC+oPntvIiau/RgyV93qAgFiTOo2Pz1EzT6BuZhh4
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: KvbF7xlTdMeIfAKO-vXAZ-x5bU8L3Aw7
X-Authority-Analysis: v=2.4 cv=QuVe3Uyd c=1 sm=1 tr=0 ts=67f9c6f2 cx=c_pps a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: KvbF7xlTdMeIfAKO-vXAZ-x5bU8L3Aw7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-12_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 mlxlogscore=749 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504120012

Add host_start_link() and host_stop_link() functions to dwc glue drivers to
register with start_link() and stop_link() of pci ops, allowing for better
control over the link initialization and shutdown process.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 56aafdbcdacaff6b738800fb03ae60eb13c9a0f2..f3f520d65c92ed5ceae5b33f0055c719a9b60f0e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -466,6 +466,8 @@ struct dw_pcie_ops {
 	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
+	int	(*host_start_link)(struct dw_pcie *pcie);
+	void	(*host_stop_link)(struct dw_pcie *pcie);
 };
 
 struct debugfs_info {
@@ -720,6 +722,20 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
 		pci->ops->stop_link(pci);
 }
 
+static inline int dw_pcie_host_start_link(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->host_start_link)
+		return pci->ops->host_start_link(pci);
+
+	return 0;
+}
+
+static inline void dw_pcie_host_stop_link(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->host_stop_link)
+		pci->ops->host_stop_link(pci);
+}
+
 static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 {
 	u32 val;

-- 
2.34.1


