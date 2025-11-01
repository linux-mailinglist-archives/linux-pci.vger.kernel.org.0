Return-Path: <linux-pci+bounces-39991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2844C27726
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 05:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851051B21ED8
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 04:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E904B268688;
	Sat,  1 Nov 2025 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QXyvL2Ko";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B2PzB9vw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687F726D4DE
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 03:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761969600; cv=none; b=Jhkar/yxlhlFuf7qwscrWGuBFFwlBLX6u/QlyDzphUuMNM31UeIrxYFm+gI/DVwvvAJbxg1wTlAnQf2iO80CSI1gD//aLq1FGNMK987fdkv96S86/PyXfH+FZO5a+IaW1PdUQKBcWlbBx4f9YEL2NGi7uCY1sFaPiHQiTgTL8V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761969600; c=relaxed/simple;
	bh=0ISk1zo5mbRe9LxvVD2vadNQhbkjLDQVBj/SNxnxtpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKrrZIi9PwN5RTWOQ/1JVyLabyR1KE38ocyHZtf6j2CyKjIrkSvAyPCO+w+3pdqiv1+cr7usZqGx81hYnOWa/5W9oT3SCYMF7jV5pSOBvmKeQqDAt5N2Ir9MtsDTSthh7yym4yTj4eq2VRfL1Vv1VeRDY/51zfptllUAM+2aD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QXyvL2Ko; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B2PzB9vw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VHFesO897530
	for <linux-pci@vger.kernel.org>; Sat, 1 Nov 2025 03:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O9iELXAHflmw8+ZgJ3dYI+WWKiAnqwwPtj78oi+ZNss=; b=QXyvL2KoRZKxfRTJ
	cvMABRkrG0rdyUxPGP4PzRibuen36GV43WC87dkgRY8HK6Ofziy+pRZHsIezQ4BA
	mB0MgNo67uyQ1NYf4STNyv8H/G8WrvQVyPqf+Yzl4ePZPcVvaWbwikquKoYw1KK9
	FvuOctD0Kz1ajs86HGIGL9/lLuzgTPlequnNvoFavVhj3Ls3MgvM3H70VaNy5yDi
	KYt1ox4EZ8wZvHyXVGYujZqirjOeKoHjZs2GgLqQzaiE3Y1yEoDioIKGw0T8XaS2
	2d7eWZTCBIELa+qMoAzsB5m9oyj+O4GqjkdLub2Z2l6fURK2EyoiE7YJgjINgMeS
	RJikpw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb2413y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2025 03:59:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290ab8f5af6so28178115ad.3
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 20:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761969598; x=1762574398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9iELXAHflmw8+ZgJ3dYI+WWKiAnqwwPtj78oi+ZNss=;
        b=B2PzB9vwanaO/susS7kzX9B6rcxuVubYoTS+cTtJD6hRMmhQ/DTpMqlM1V5cad1CUZ
         pyELkqm8wxzTpmml1clMH7zz1hwzEJQ6yDRMK2kwZqtuWjAzfVnoU3nxfceP4DUynLod
         AoLEUT/fZSmIGm9l1lnsonTbi1TZ2Iz17iSHUu9GSOvV85bMyrGFzAXktqD4/PsrLSpo
         QwX1h20Zj36V1MTxqCRYWyhCaYwXN8PmpOn6AY1EU32r6biW3Mn/OMYYsscAEV+Vr5qw
         7R91DnWVG5jgoPPLPyklMbFPwbvechumS6U8fRtSRSNTmphJ3l8/7V12X6qiIppRl+eg
         I7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761969598; x=1762574398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9iELXAHflmw8+ZgJ3dYI+WWKiAnqwwPtj78oi+ZNss=;
        b=VVWE7Y6h9w7O/Dmqxq/APkP3te5MXzc5P2lbZ9r7ptCxVKaX03TN3JiCgNf6P0vLgG
         c4hT3HKSj1we7VIVyT6CsacpcnlpHvR3Q+WuWn27cFrOL+3qYAaqqsurYU6WQobY3ZHu
         IyDJYSCG22Sxbz+zqbaCEXkONC3VAjxLELuVd5D+jex99Kr1GfCcgx8kokTAbEB+Jxz9
         UP3SlN2f+hxW49YiCcYoQG7hqzqLnnpA57FVAHp2h+7HFbzKIbK/qq5Asd8XF811utT6
         Rlz8rD2xCJLeb0A/FCvVGHghqRx6mggXKCYAXI0F9LX5xKjUL0+tqWC4zGSgVpBirxgK
         Wy+Q==
X-Gm-Message-State: AOJu0YxcuI68eBPPZIX0AYOcpRozesxHAq4xuMQxG1u2aZqbI5v+ytpY
	Lh/VgHve/VC37/xbJ82mN2a6YYwc23jYnn6S8e4PlxY/ctmT+ZAnyh2G47/VsjlF5eGEU19OgDy
	03a+NfmuuAhI28/btA5bO/ebjaC80o7IljmzCoWQRl2y75JeXm7wTgLyQ3Kx5fMEIvBL739c=
X-Gm-Gg: ASbGnctuJj8TxA+vTmKa7hSkMYGs5kD6x9B0PZr37Ow/M8i/YYnrqfAS0/n6Myuo/em
	rIo2DA0Z7jW9uZmg3m4MXUmt2YQTefZsBAilbTuIjwrqgiCPbK1jx2tnzVaZY/cLrKEIseUrVSG
	Y75f32CiFfBj4H6Zyhz6LXiqcRblxfjUQeApK5J6K9iNa/j7EgSlorbM2qVCfLNWcmGrOtL0udJ
	Jbya0NCCrUPkNOBaXoaS0PQrHAtSpdb6gtVFENHdSM55e0nKc1yyCi9n7QiOsddp2Q2GV0Dsmkn
	slld3/cFSCmhOOBVArbPF1/D4FD6+yGNzpKF69X2btZ0q09FARZsx8TnZqnm9LytH+7VPC/iO3t
	U3JHf4ObKpr+i3ke84xEokPrmsKIMeLHSiw==
X-Received: by 2002:a17:902:c947:b0:295:269d:87d1 with SMTP id d9443c01a7336-295269d893emr49212665ad.52.1761969597810;
        Fri, 31 Oct 2025 20:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJc8g/476xtMo1z1kMshWvFgOL9ZnM1ggtVT7FaVakM6XhShCNST3snp68LNvZ2gl9YcoVDw==
X-Received: by 2002:a17:902:c947:b0:295:269d:87d1 with SMTP id d9443c01a7336-295269d893emr49212415ad.52.1761969597358;
        Fri, 31 Oct 2025 20:59:57 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268717ffsm41490725ad.2.2025.10.31.20.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 20:59:57 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 01 Nov 2025 09:29:34 +0530
Subject: [PATCH v9 3/7] PCI: dwc: Add assert_perst() hook for dwc glue
 drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-tc9563-v9-3-de3429f7787a@oss.qualcomm.com>
References: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
In-Reply-To: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761969577; l=1362;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0ISk1zo5mbRe9LxvVD2vadNQhbkjLDQVBj/SNxnxtpA=;
 b=5hoG2lVfjcLdohSHpM4iCeuSiCiha0smcKSS9Zwrty/Rdaz1tc9AqhNjVCwmZk5gbLJ5LkNAs
 2oricXxhAPwADqvJwtlzr2twoSpmYYyJr3rpbzwhKqorhO2GKO3K/AL
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=690585be cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAzMCBTYWx0ZWRfX476pDxUJ+e1Y
 Ol3JzomIezoLSG/3mxj/WEWpIQ1Vjly1P84Pc1zxHDos9fTrOjnfWwXgf6y/636oIC9eJAS7g6f
 eywDdC2Xc0CY6It+u58ATYlbFFHPpF8gcprefJusRzNCcWAqAelT3yeoTp3Ev14t8cAafqZm7dU
 cwoBqZRP0teKbIhM1fxH/DDQxV26sK1NYh6AlaQNH/CEMr+zH50pAf12psGk8DsioY3/Ouw+Xg/
 BrXuZl7E5mJ7Y61pwbeY/dv/X0KBXPeoLRm3ijxnlgp/kcDBvaYrCbI/D5WLHg/1Z01uKa4zO2K
 7gNCRdZQOcivPHZ6HdWVWkTC1zMbwJ6bxAw8YQ4StwYomkb9ycp44imOE+l+IKmeLssfiOyOHwq
 ru6mav8cOb8C2ZQnQ5ZQL5MvDiEiJw==
X-Proofpoint-GUID: rV13k84Gw7HVelMV_8ZwGf2fOb36DRF-
X-Proofpoint-ORIG-GUID: rV13k84Gw7HVelMV_8ZwGf2fOb36DRF-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010030

Add assert_perst() function hook for dwc glue drivers to register with
assert_perst() of pci ops, allowing for better control over the
link initialization and shutdown process.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ecd10130d3be3358827f801811387f..99a02f052e1c8410573ecd44340a9ba4f822e979 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -485,6 +485,7 @@ struct dw_pcie_ops {
 	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
+	int	(*assert_perst)(struct dw_pcie *pcie, bool assert);
 };
 
 struct debugfs_info {
@@ -787,6 +788,14 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
 		pci->ops->stop_link(pci);
 }
 
+static inline int dw_pcie_assert_perst(struct dw_pcie *pci, bool assert)
+{
+	if (pci->ops && pci->ops->assert_perst)
+		return pci->ops->assert_perst(pci, assert);
+
+	return 0;
+}
+
 static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 {
 	u32 val;

-- 
2.34.1


