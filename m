Return-Path: <linux-pci+bounces-34179-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B314B29C09
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 10:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B95189C834
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A726A3002DB;
	Mon, 18 Aug 2025 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Trfu9uoq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF02303C99
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 08:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505407; cv=none; b=VSOwUQ538xllsSqcxwkqnfGDksml4Zzwq0+qbKDwdU5L2M1BrDkuZcV0L6eFqGjtZc+lTv0L4DidQs6Tk0MApyuDGMYWDAsbqgIrOjrluHdaI0SmjnTq1vSiG1WwfICSiLK3wP2xSCN55MCuP/oszKqUwKilP4y13k+hxKRIq7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505407; c=relaxed/simple;
	bh=r1P5XOZ9xenxmIBMJEe17CUSV641Nz0efcyuB6UGa2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CSi1LmYv3RNAvAM7LW/N/ONa2eWS5vq31rW+LnvDYMMK9pvzaGRcJonCXnvepsjVKfs1r5P5Es7Q4QYC25NiVDQxJHK8xHIt9sFGSU5/hVizKUtct8nYr8VMMSAUmvRILMF8+UhQQOBEH6CNndNR0CQfjTSNHOgqbzvEIaOp/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Trfu9uoq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7V3DH026352
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 08:23:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YA2b9PAvdXRmG3Yuf64IGVHkPXHXY02Aav+qtOoDO0w=; b=Trfu9uoqWNmuDAZp
	dgQT+DNWP7ceg/uWTWqS8ycztNGXI13n4/uE5bYLdZxm/L9fVhYF6wM6j9pqO0mD
	J1TixYrRUv2bqDdk4Hv8R1Lb19zs9KSDZ2fGIWUWdZS+TyzLFpJIJfSphQ6cyiEA
	gtNB0SDWxAVJMJkuu52NiS0SPdBU155RL+yXWAKGkC3jZzGTrmZ2/nk6uRzg1uIU
	TGQC8hJCrjEdpfxj4kpz8Rim7n4OQkubd08zaUYFN3BqZftINjX+zvK8rukQ4Inz
	IXf0wWAJYc+SHz4h3ewIJrf0VPo17oTzqFx4jb4V6A5L1PArNkFNR2i+ETyfmfvd
	a++a0Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunr4f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 08:23:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244582bc5e4so45884735ad.2
        for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 01:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505404; x=1756110204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YA2b9PAvdXRmG3Yuf64IGVHkPXHXY02Aav+qtOoDO0w=;
        b=YHoo6CfRvwahtj1n2LUVaK4ZYif0uJ1u7/PonQrGLOz27RqoI2cMLosPzDm0ohKpy9
         G7I19YsxtpR2L0NqUSSQLgr8UPfBkvFVrk/XDeNAsoONdxm9A5ScI4upqSQW51Qqum/j
         InUbXiAFUGauUqOVWHyhw4yjtOMSHdIEGjWq5qfM6Ed+9xeCh8ibouqebgjmmCB0ur/B
         ZsBrZSnp283sVhfX9HEgxGF7BoQYRFQAO/QDqnXJ17nAEZhAFmLjXYTFHD3FtRNpj5s7
         fbZgkchccyhkWBLARmKApU9EYhIIOQdk7HU0oI9wpgWout+QJ8RXnEaXgDvkcja0Ffgk
         tIng==
X-Forwarded-Encrypted: i=1; AJvYcCXuweQ3d7Wh/Zs7djbxaryq2mA8i21I1FTFrljiXvaRNuNW+z8+uqkjBlXTRqHqCpvMEN6X75CfVvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fxnrQoexsqbqy0WZajVhK5r7vRP0HnddOhOoUcjksPvGyGMG
	aK09a9lTFim8LF9hPy2aQ2sQ3uRiSPxp299pjZHX96OgYSssAc6FI3IW7+A5eqnX1dIEJC0t5bB
	0yAu1zNzp58jCzs7NoP8iQ+dR5QqOtiBcLAqQpmmNt3UeN0igRtsm9dvws8MfMgo=
X-Gm-Gg: ASbGncveudwMx6daN+zmRsXXITa2PrHQxhR/Rk0WcGbQM9kpwzeFapVflICUov3GPh5
	0tLaUp0cu23m4rLvFZl45SCs4Ryq9GPahH493HLiLENv/YTKDsjWZE5j8mCZKu3UoxYe8pzcZum
	UXn+dCaqez1JWZfB69lhUZXv12pbSeNS65DFcoaRjbh6SXZ5Esu7suUUk1rNWVmKArDQhz0HWCP
	U/8eQSjbIpssNwsBXaIOxOZbwEHRc8Mo6ir2Gbi2Deog3idCBmhCaODvXfELhI7ITeU0c/gFJft
	0LId1TOcVTsBWcopb3eiNSg+ylRXoXztdXLNHFNiVqw8i+WdvhGUBQDQ4e2HSsuoduAyReAdXLU
	=
X-Received: by 2002:a17:903:37cd:b0:240:70d4:85d9 with SMTP id d9443c01a7336-24478cd29c1mr101023175ad.0.1755505403884;
        Mon, 18 Aug 2025 01:23:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYuBoM4owvivfKknYahmOIJgp7qidwojBn4u8QZooyQId72Yf/YGItXF9hitSi0rTk8Kblig==
X-Received: by 2002:a17:903:37cd:b0:240:70d4:85d9 with SMTP id d9443c01a7336-24478cd29c1mr101022735ad.0.1755505403431;
        Mon, 18 Aug 2025 01:23:23 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5536c3sm73225155ad.137.2025.08.18.01.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:23:23 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 13:52:55 +0530
Subject: [PATCH v2 3/3] PCI: qcom: Use frequency and level based OPP lookup
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-opp_pcie-v2-3-071524d98967@oss.qualcomm.com>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
In-Reply-To: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755505382; l=1213;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=r1P5XOZ9xenxmIBMJEe17CUSV641Nz0efcyuB6UGa2k=;
 b=yIhj5/flyrKcPzl2sJmHXf4IYpP87Kd3PzPby7h3mDHr2w3wwdRaowv/CYbZlukjY53rlE0WV
 t8sMccGGJAlBnKRYYFnGhVi+7QJBVVH0ErrAJh7QHWOlzcOXc3+RhS7
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: UHdbSQJe1nwub1Cpn5RtxE4knlMjtK_e
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a2e2fd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfX9prw+h402IGY
 w0Vk+62/gk9h05rKeV8ilnwflxvwsJkHpGxlBygLYELLWEMND5AVcl5WwD+QplgiOwaSoPwUTcs
 yfb4KvbkKNFzZ9sY64Y5+N6dV6XQobkH+Si5EbFHf3/IgNkeZJGmSVrnkquwylirKODFG7X/oFs
 u+5lOGsv6YScfxxYA4h+4GTS2uNx3cUhx21yK7oPPc+6kB+jKgWE7BL7gMoOWkihD30TbMb37d3
 w8PjvxoUnCLn+m+LnaRlH5nqBpCls4EFIjSa08ZMm0u83eJkMjXOfDmgyrG598er1LlJpSPEC3v
 0QLAnWaiwhyw6qYG/Y8pVJMUT8YnSwdHvzNDQYXnmF3kp50JPEg7M1VEGXAsAxkyaLoJL5y7Edq
 0fup/Yv1
X-Proofpoint-ORIG-GUID: UHdbSQJe1nwub1Cpn5RtxE4knlMjtK_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071

PCIe supports multiple data rates that may operate at the same clock
frequency by varying the link width. In such cases, frequency alone
is insufficient to identify the correct OPP. Use the newly introduced
dev_pm_opp_find_freq_level_exact() API to match both frequency and
level when selecting an OPP, here level indicates PCIe data rate.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 294babe1816e4d0c2b2343fe22d89af72afcd6cd..698209b5c13d99c639b09ca05bcd05767a2b9be1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1582,8 +1582,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			return;
 
 		freq_kbps = freq_mbps * KILO;
-		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
-						 true);
+		opp = dev_pm_opp_find_freq_level_exact(pci->dev, freq_kbps * width, speed, true);
 		if (!IS_ERR(opp)) {
 			ret = dev_pm_opp_set_opp(pci->dev, opp);
 			if (ret)

-- 
2.34.1


