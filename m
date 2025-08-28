Return-Path: <linux-pci+bounces-34972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE00B39569
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 09:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B650D1C268B3
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 07:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CD03009E1;
	Thu, 28 Aug 2025 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JgKGsMVc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877403002DE
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366524; cv=none; b=Da6PzRSvTKkzlaZNLXP4IGuWrkGrQLUvFugqRAwFvdfGe48w4AkywEAmua2NuJ95Ox5xy6OWAHjo3RvHJfdA79qRgYtRfSTaybIAinASRBURAOWAftk6x2UPT0aGtbzN1hnTJjeOIe2hkJEn/nN3VdpdZ7+rKNdaqW6l4iFsJj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366524; c=relaxed/simple;
	bh=baBIAb49MxduM5gBqS+AIR83kaKzbO1n1WU9xKYWh0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CIWls/XVfmq+GgD71bo6kiA/ucY83okl8VtZgRcLx+rC+U+voEeW+2Z2IJyGvmL6co9mpm2y4Bdu9U9H64w/N7RFQwFaSbJEgDFtW7+EnEaOJ9Ec/kDj4BrvDixNQ+4PAPrK2yBSJKv2HEJAIfPqQ1uXDiQH+zJy0X11wL/0Ys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JgKGsMVc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S63ksA027289
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 07:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bcw8SVGU6KozHp+cFpIEECdCat+/J3psNgrGaj/N3wI=; b=JgKGsMVcsoSjqt6w
	eGpxCkbhBYgUxsiCAIlCDC9RdFYiiIKd2k8it/QJlcvCpPKx9GD67wpJEK85JFUh
	jeHYL0msL+Y+Yq4kf4YX4W5NhC/QEIO2tO+AnyVSLb6iEU5FnSBiYxm7qFrKXWo4
	hg6ksQKifCl8qzAkcjYINNX7mJ+V7PrwmnyYqIULegGZT2jed5EuLQS1kJSiZl1q
	M9fvfNovHXxO8tbHJxgAWf6pPeuhe39ZLSs2wl/+jMYj8+vlyyf2Rl87Vu8PWmSy
	IBP+HIr0u79k72s32KQgEUjiJ2S8Kfmvm2VeW/iKgKFoiTmIEzK4adxmphtHHAAz
	SV7oZA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48se16xc52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 07:35:21 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-771e331f176so637687b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 00:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366521; x=1756971321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bcw8SVGU6KozHp+cFpIEECdCat+/J3psNgrGaj/N3wI=;
        b=VPdX4jGifbHXSMT+NCjoqlLy2zLgLtdVh3Gu7FRpO+ahRT3Xh9re3hTHiZmlkN4s+V
         U1vsQvanjVjj71JijnpxVkgqhyNWglawsr584oc99cuyzapG6x9VqOVqCO5CcE151Btr
         F3jJsjOOD6bdMd6gAk6kzDQ5MHlwIJwNIBkvGQF/e7y4jVZWXmo5SD9fuq9DLhJiZPaf
         CWlTGIoVqpY1jjieXMbmFgTrLHw97T7ggbhZrL5L7CAxJLTZAsAkF71/78lUoNK276Rk
         EczAGarI9y4VwGLtzPMEre30goceQIrDzFWQSDI6LBMlhwGDEJVQRQSkk5AUSO0f3663
         IKug==
X-Forwarded-Encrypted: i=1; AJvYcCXgmsLFsAd1ViqNW1p9pT9z4D2VRSI7Q1EYu/1+XVd9XEQNPUTomotS8uqip/WGdyCHvi5bkV+87JE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ubCSs+V3CP/qQUAmMcx9knxrtwYGJpWK23p3xlgr/8LVAYqT
	grS6dsZzN+DWDQ1Dhn8Dyare5iDbwAC4tgOeW3ycIXmdfaW6EDv2oOFTpL2UOnR7LSYnYNbU11N
	aKwugGBs6RWQfcfENCeUPPxM/E611l+Ej8qNRgSOLsJNjA3T5OKe15lCLXHor2Rw=
X-Gm-Gg: ASbGnctVNNlTozGxqzoCIR1x4ICS0fz258lGfyiimLDe1nkSdZmRIYIq62Jy07+tiUa
	LDqdphXnKD9lVI3MN1XHBd74TUBmA30UlD4zDXhqdszjx5U9atpBaocg00M7od3jhstX/paMa1D
	6qosW/rdSt0CGk1qIKhB5nv01r8/pp/h+HAVBbu6x7F3STm5NhodkE1YHlxpFTVFJTTcPWXNpPS
	0YzRHyqyjQLBVb+6CRMWbDDVGk9gqrb3J/w/JH+T64mLOfJlZDxpq+RP9k+k529jX7McMV5hxmT
	BlHvxIP/2su7MGpi+iWwCxvA022QdhD9Bhtt1F+xDHL9ohSqM/bfsvEaSKbbRwyj+IQsi6kQSTo
	=
X-Received: by 2002:a05:6a20:734f:b0:231:acae:1977 with SMTP id adf61e73a8af0-24340c0faebmr33056218637.15.1756366520713;
        Thu, 28 Aug 2025 00:35:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGqKf6x0p+HRSdaIY6VwavENLliL5CVF/xXooan6+Zly5ChHdt0Lk95GVnS8O6Q9shJv13Mg==
X-Received: by 2002:a05:6a20:734f:b0:231:acae:1977 with SMTP id adf61e73a8af0-24340c0faebmr33056182637.15.1756366520161;
        Thu, 28 Aug 2025 00:35:20 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4b77dc7614sm9605810a12.8.2025.08.28.00.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:35:19 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 13:04:23 +0530
Subject: [PATCH v8 2/5] PCI: dwc: Add support for ELBI resource mapping
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-ecam_v4-v8-2-92a30e0fa02d@oss.qualcomm.com>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
In-Reply-To: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756366503; l=2000;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=baBIAb49MxduM5gBqS+AIR83kaKzbO1n1WU9xKYWh0E=;
 b=TKihAuNriez516iIXhX4LKVsLszp633LecGCi3r7p+3DZsS8S3yGRL0vmif4gG0HB2Cbd/Ayp
 Mv9FClckxhoCMfa+fjCqGFHUneHYfQz7l1ad80gl8dbYFoM/k97AAr4
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: EyjqP36s7d3D1zvBlVPexKO7lGFaCRMx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDEyMCBTYWx0ZWRfX5QQjW/mdGxvO
 ON6ONHvUhk4uFdfgB1Z4vKGTvBrqJSt8zytV/OMtdSuteOGjBEX8h/TwP+YAgFtQfrABX79xKGe
 vWvwXbOF/AOVhPl/4KD9loCkD2dm9N4QpAj8zLYmu6VjGWcTijlt3RDKcFfslU26zxx4SOdJS8o
 a7Pr1tyCHiMp9WizaqSjXZXhegH+NpbA1DvZudBAFBQPFU/1xUCGJKLd0q08oSk+FiN6yFTc0vS
 mDDEc0wgSp3HOmNGZH3nnxD2hHxsXCh3AndBQZGyw3y6FZXqU+rK276zaFm7gNyiuZ7guziOJo8
 Zu9QjXtRJK4XuTeXXoCvMzaWCcAmCr0WnTOjF0cZYJdPnV8oUyA22sFIzdxgoCYh0Qjs47NaL9Y
 9cRU/WBZ
X-Proofpoint-ORIG-GUID: EyjqP36s7d3D1zvBlVPexKO7lGFaCRMx
X-Authority-Analysis: v=2.4 cv=CNYqXQrD c=1 sm=1 tr=0 ts=68b006b9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=De8H20xVS9kR4mXr8yMA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260120

External Local Bus Interface(ELBI) registers are optional registers in
DWC IPs having vendor specific registers.

Since ELBI register space is applicable for all DWC based controllers,
move the resource get code to DWC core and make it optional.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++++
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928cc29870ab258d33bee9ff8f83143..4684c671a81bee468f686a83cc992433b38af59d 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -167,6 +167,15 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 		}
 	}
 
+	if (!pci->elbi_base) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
+		if (res) {
+			pci->elbi_base = devm_ioremap_resource(pci->dev, res);
+			if (IS_ERR(pci->elbi_base))
+				return PTR_ERR(pci->elbi_base);
+		}
+	}
+
 	/* LLDD is supposed to manually switch the clocks and resets state */
 	if (dw_pcie_cap_is(pci, REQ_RES)) {
 		ret = dw_pcie_get_clocks(pci);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcdd794013a865ad6c4c7cc251edb48..ceb022506c3191cd8fe580411526e20cc3758fed 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -492,6 +492,7 @@ struct dw_pcie {
 	resource_size_t		dbi_phys_addr;
 	void __iomem		*dbi_base2;
 	void __iomem		*atu_base;
+	void __iomem		*elbi_base;
 	resource_size_t		atu_phys_addr;
 	size_t			atu_size;
 	resource_size_t		parent_bus_offset;

-- 
2.34.1


