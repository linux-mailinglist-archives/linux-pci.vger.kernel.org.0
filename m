Return-Path: <linux-pci+bounces-34998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75B6B39C7C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA59189A1C5
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EFE31195D;
	Thu, 28 Aug 2025 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X6SlWyIh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F9311587
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383035; cv=none; b=Exl8jvWRncLVrErObEvxNHZ3P8lBx4335xdQYHcbEGakMLgrJnFILeLhc+XZurCWlInQHQodNxmtJdXBbSjwE9Jzbd6KsF5ehESaqoSSyT6yK1Tob280ksQE/alY2twKuY6C7UZ9zkBJKm3HxO7ByRQXOzyfXT0BnkvrLJCuhI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383035; c=relaxed/simple;
	bh=gJyZo4+y70cAtQtM0l94BcRRIWPsTYGyCPIEqvg0Um4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eTlvDvqzuoLir0zEjUNrBq3QrgZ0tvg+8nNbzMuT05t5HYuIKrwloDJdPo44MGAn6HwWE6wUOoreznVbVeDX1Lew6fSjs2Av3dOPBk8sQ+tAhR93IFqlWdjDwlKtnQaFb+7ea5EhznkdWApQwtiLVqFESzlW1eoU1gHE8e92UOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X6SlWyIh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SAui6t021327
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ed6L8eMIvW0AbHtn3XR+t7FYjsouaycVZOPUWpXRCik=; b=X6SlWyIht6MY+2gP
	qkxTu5ixJm3zsW11mJocaFzzjYBQdC+f/n27GVbArjDiLhkqOKQdYSO4a/Jmjdfw
	OODYV/YUs2rVylt1xpCErJEtfCa0pjBtsGlxh0QQ+Q448Une9VaKo2zaUW2r8ZM/
	cR4aOZyuv6NJXhGSBQ7ZOW3tPpcnTfrTP2VZDjv9HSFnCsZtQ38ZUp9FSGGUyqXv
	EYQvKLvK+MZTET2y6J+cC7ImGdCHCHCOMlvpawYyol/FJvcrmMY7tRS+ZjrpszBe
	eVptmnBLGpTj9i7XlQJIj5YcxOaCf5uILR2aZCwXz4lqKWTYXM78ikmMqy+0OwS+
	olqXTQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5we7ujs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 12:10:32 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b49de40e845so720221a12.1
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 05:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383031; x=1756987831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ed6L8eMIvW0AbHtn3XR+t7FYjsouaycVZOPUWpXRCik=;
        b=t0/mmWKnuqU7uCuJ6dU18/e+63QIBQc/9A0jxrT9ASr4SP1DZbgT5WI2iRDWY079x2
         gCJyGsi6BkT2KULJxsErV4T09orRtyefHQEeUJ3IwkS6PtVRrCWwTyVq8WfaR6CQ+Vh0
         owgOk6lHln8sZIwt1Q04p+qm31i9FOPnMbEwe30wxZ/x9vepJRUkTWqg8Zcgp2CWcUQ8
         dphJ3ear1IpvX6nC9UsBKgvoknVJzeCoxJ99KlA3EDUsbWYlAqy77wAtFR9E3RX2JxC9
         2yChZY1fFjy7pO936sofhlHx5NBG7zpeTVOGW6cGjK8rfEliJi2R1/K7GCnMl0du5MX+
         W2mA==
X-Forwarded-Encrypted: i=1; AJvYcCUL7Qw+14tBlDUMQMyoUz5Z8lAgU4zDxGGqe5hqQeuOmC7ztNloUnWTJKRUiDtiLcfxfrmFlkzYfog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTcuIOMsXBB40yevNX2neRhk/8Gy9Y3DqO8nootb1RIdlOo0uc
	CSIZf2tbY68X5d3SHdynYtJAo7/CBxjMgGmOeVUqrosDSBzgNYy4kmOOF/K10IXl8PZMtcx6pYT
	HNp9niBtQckNjSj+zl3XFzpjmn5XlOWvHD3dOKcSd4ByjIGsfOt76I4K0JuF+g/8=
X-Gm-Gg: ASbGncuX4t5YBjP8q3rmOohw2ofGxiW/nBgul2j9fGNbNx1oE3FsiMmTrjJq9eTDS2F
	7NV+paxUQuJq9V7Dddqg+9ulfzxwZ85YKStn8KV8peon7aGRwgbjrfBo7AkdFAjM4kUZnyHpsdC
	OsX9AR9pYVYlLUCZ2BvQGicoi6VdA9lELWVdyukPTsa4NnZWi/OX5JppFxcGT23zOIrgONVafwg
	7FH/GWrrSDuKqZDrj37lglbqGg52AUBkJwgC7UbLMfUnpaKNL5r5M3TX0U8OuNdLtQ4nHU7uXBZ
	LYdENQzYOEGwzSAA2B3zFC2QmKGz2ssEp2LFz4TsZ6LG/mdtWS8K5608gtr5EyuiMS5By5l2xhE
	=
X-Received: by 2002:a17:90b:1f85:b0:327:c0c6:8829 with SMTP id 98e67ed59e1d1-327c0c68a2emr1602912a91.24.1756383030498;
        Thu, 28 Aug 2025 05:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLqn7GbKDipnvW7wO7xyl/z3nxMSZZtjcarpD2Fv56UXUJZ4TTQws5DQWp7lRiXQXSlA/Unw==
X-Received: by 2002:a17:90b:1f85:b0:327:c0c6:8829 with SMTP id 98e67ed59e1d1-327c0c68a2emr1602844a91.24.1756383029911;
        Thu, 28 Aug 2025 05:10:29 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32741503367sm4019070a91.0.2025.08.28.05.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 05:10:29 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 17:39:01 +0530
Subject: [PATCH v6 4/9] PCI: dwc: Add host_start_link() & host_start_link()
 hooks for dwc glue drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-qps615_v4_1-v6-4-985f90a7dd03@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756382994; l=1587;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=gJyZo4+y70cAtQtM0l94BcRRIWPsTYGyCPIEqvg0Um4=;
 b=m3Z83ZVY0UwHl+oGtMxjjvp8Cwj8Qi1oKlZ+0jAtkA1r8ZOAULJQJy/HJIbx09SyD/w0CwAm2
 oQLd0oEZ6nmACuGRfvCySXEqKHoqu3pc4HcgTAkcz87/6u3scmYEyk8
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: ws7MK4bSI8ql3BhqDH8tMWjCpdSIgw_c
X-Proofpoint-ORIG-GUID: ws7MK4bSI8ql3BhqDH8tMWjCpdSIgw_c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX6U7T5U0AnVIm
 wWDC6joWVGACO9JUb9F35KrkKEDZYNrtHCYYybzsSL095DAXkekpp2JgGKdAp55Hy2GXRnpaQSn
 DgQmBJ2HLrqVTA5nBm/pn+rcc0npdNF/V1DZxLw/TbuF41PXZ2U3SpUqb+fRWsdbM4YWJRlS3JI
 RKb/QiOSRkDknO/YNwi1ng/EJoUBld3KzX32YAdD5YLFOQluXIMT7Q6YV+LPbL3BhJ6IjW85f9r
 PqzDh0n0NthMw7Iz/2cAmDtjToc6yzk2CMI7Imfd8+fqYP0IKEKE2W5z3xeKUCyDdlMCTO91VMp
 GDM4Vi2aoCzgxpBA/U0JsXKGSPu9gTfoXiTgfrNpDfIDlIP5ExybDrFPVm8lPes+rV8ZYenvQph
 DlCrhZiS
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68b04738 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

Add host_start_link() and host_stop_link() functions to dwc glue drivers to
register with start_link() and stop_link() of pci ops, allowing for better
control over the link initialization and shutdown process.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcdd794013a865ad6c4c7cc251edb48..1ed7a75501bd516ef704035a63e5edd35bd7e0bd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -479,6 +479,8 @@ struct dw_pcie_ops {
 	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
+	int	(*host_start_link)(struct dw_pcie *pcie);
+	void	(*host_stop_link)(struct dw_pcie *pcie);
 };
 
 struct debugfs_info {
@@ -738,6 +740,20 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
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


