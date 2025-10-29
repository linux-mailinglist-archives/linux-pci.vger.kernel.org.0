Return-Path: <linux-pci+bounces-39636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F70C1A10E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 12:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53E4650854C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 11:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FDF33A036;
	Wed, 29 Oct 2025 11:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DE69YI6l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hG2U3GFH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE633DED7
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737447; cv=none; b=VFvlpmjZ3QgR4+IpiVHtUeKEPbNvx5MSoW9SBTxzmWgosrg0J5tLYvIuW+xfKZNN4obOyhJC437O+oAMqWAuaFf+KMx9P7rpt+cJXVXnh5o4W9s2PIhaXMxbG3mDbEyAjeG34t1N0Vxko3s59OwPuKT04r/hRRBJq+JoWSVqgFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737447; c=relaxed/simple;
	bh=/0zY7f+/NmNwlOKeDfkudP6y0/Cc6rFCysp5ws1L2xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DA6xi3c9VezOOAa7DWU8b2aO5i+JX4Gn5eSfGfdBIfSS4CnVKmZnXCXRWIA7IpqkjeGwjjVnEUyq6Kh2yy8hGq/LonSxHyaYtqHtUxWFolCMreog4Df37d9QmBKtiaMhwhl8UdiXzF1S4jo0M3qfJoamjL3VF2fXjC9b9Wt0rdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DE69YI6l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hG2U3GFH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uwX43757751
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zgL5OSB/LlXjPB9KeMiUSBoV579HCQc0pGIvC9Q0kz4=; b=DE69YI6llUWPsvdK
	2eEaivv2B+oU1s0fHOyUrUwZBJdarFBCVjWLHZYtcLoTK7h5m3KlYMIXwvj6zsdI
	xSpb3IoDHPtvZBo45tVkz5WQhfslR3J93W3WCFpQWPdVwSRC0iAJvjPVR7l4G/pv
	mq5RETV1+hreNoGarS7JNhQxu91bMraZkFmCuCALwe/Tv/33YLUjC4xwonJESLJL
	P0buCBedKZ/I9MucD1qhuCfw1uMahv1TFg37cKGmSph7w0mj7lq3SgGW0QEhLFoJ
	WVYDvwxxIqBKoFIQqCViDqAHWnauJME8QfgvTall9drvcjZ3Mvg4E/ux5CDuNIiJ
	GclK6A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a349y2bkt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 11:30:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26985173d8eso185377775ad.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 04:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761737444; x=1762342244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgL5OSB/LlXjPB9KeMiUSBoV579HCQc0pGIvC9Q0kz4=;
        b=hG2U3GFHqS7lm1IlUaIZA0rCnlMQldm/NIza+r3WYln1IpUWXY47kcQmYQz7RF9Ufj
         GI6QW5WElf0GpzismGw9J847i18BW3RCRumUESnEIio7GAz3+ELyMPTjFO+bo3oxVxeK
         cULpd5dOCJdMpnKduKIlQ8EBtAVtTeu1HY8utczChuLGS/H2iFWvbVbJEcXvGR0FXLAe
         0+thmicibz81qx8sxinE2FUWrzVZBzXD6lZpbLKWayXaKwqBtpMi5XUlpeQCuJShqOsK
         RZ7pSJ+4mceUbTly/1UPmmls87Wqqw4RezJuML1YzS5pRC5XKowfCeANy3SOLs74cu+q
         MJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737444; x=1762342244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgL5OSB/LlXjPB9KeMiUSBoV579HCQc0pGIvC9Q0kz4=;
        b=JpWwqfB+Ek7Ao+bIi/vxQ1UgTv0mvpNohnLSXrBBe0h138MsG8UJpNu2Z8Kd4E3b9J
         49zjWvbReDrl6DHyXmA/NjMDPDw/AMHplVDbb+I5tYweIF2ohd2RMxVey6mRg3jwlIoV
         XUdDTRjXc7Om3OJAkDEEqojijdeWU9PQx1Y3Nku8SXVNWlTV66dqMXPzZfQl74v9ggcr
         YfBOGqFykXHYFkHjtLG+wInD5DlyERqco8OraAhyf4ziT0lwcQQXf/sodA+KpGgS+q3/
         h24xXJYserS3UCGdlAIMJC6GU+9jAXL02xLuOQ7zphH9BGS+qXeGQxtKQ89QWzOyd5Oo
         qt5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3XGVultk8lWB71yOMScGk6T8Z8YIqM2iuy+jwMRO/gJ1FskKrpN4X6+6crroLkDTDH0+rbwUAPjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSlJYctiIfQnN8zgogqSyo/wm8dvh0H2XFIF9uUm4K186/VMiP
	QvN7N/aAr4GxaJWAXCu/Y2jICjTbiZtYsAj30KYBYCmlRIkv/1A7/FeuevvIHmUdfGUxSKW5RYW
	5Quyx6b4oxRfI0yDKxSbSAI/fAC7SmOHte9rax7nZVKPTzhwHXTSIZsnnrio4pe4=
X-Gm-Gg: ASbGnctvD9NepFPiXBhaO0f8TjxueMEFm6c/BDNHVk/sOxIpIb2/wX532nbMFiDN1ZE
	oJfHYdh9VX8ec0k7UpzphZjXqBSUDuREwY1mytawYJaVhLGP8NYl8qTfzRVTCZaMSYF82b6OvmP
	3R/QLVlHyADSsEvAETiGmoKvLV/67FZfzYZVIuUtZG5wNo02ksgLtksb+a096OQLJaaJ52ozhid
	7JzXGH085JD+dYcS/95cp4EcMRGehwjrszIiZ3tZPsnx/J2xOY55QpLhkRw/JxZ1fJrljV34x5j
	8WAjWQR6r2aj6kJuBMuC6asBvLnjSRaxRARIbg1hX94IA35/WCudsaHkzXvdiDzNky6S6TzKGqr
	ruU1Tk8UI7LAQDIg8QAe3O2VYR5BfMmZcNQ==
X-Received: by 2002:a17:902:ecce:b0:269:87a3:43b8 with SMTP id d9443c01a7336-294dedfaa82mr25711765ad.4.1761737444094;
        Wed, 29 Oct 2025 04:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJyLsEMvXCp+Lqhoe7+83sMpVNkVgslqDw8ZcMIT25DGYtnSJn9/5QFnN/lFGONxEq1y/8ZA==
X-Received: by 2002:a17:902:ecce:b0:269:87a3:43b8 with SMTP id d9443c01a7336-294dedfaa82mr25711345ad.4.1761737443407;
        Wed, 29 Oct 2025 04:30:43 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d429c6sm152154935ad.85.2025.10.29.04.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:30:43 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 16:59:59 +0530
Subject: [PATCH v7 6/8] PCI: qcom: Add support for assert_perst()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-qps615_v4_1-v7-6-68426de5844a@oss.qualcomm.com>
References: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
In-Reply-To: <20251029-qps615_v4_1-v7-0-68426de5844a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761737398; l=1479;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=/0zY7f+/NmNwlOKeDfkudP6y0/Cc6rFCysp5ws1L2xI=;
 b=2/MPQfCzaTDI0jwXow2vCfR0h4ZcC1BUmVn3V0PWdjPoconL51iUp68mvJ0BgnlrMSeD7xD0o
 YPHpHYrQfqCCAqgUT9fjnXTawRabKEUkMc7R/ELwb3T9v8filKJ4cfO
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=D8RK6/Rj c=1 sm=1 tr=0 ts=6901fae4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=j2XxTBISUlk66HYKGUMA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 7N5VtbrLhZnfqkbHYlPsstmn62WzioHz
X-Proofpoint-ORIG-GUID: 7N5VtbrLhZnfqkbHYlPsstmn62WzioHz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA4NSBTYWx0ZWRfX7ysFmuC0sUEa
 WQmDcQbT0YZhb55s+Q8HxNY78VjSsxlObgmWs5mz4tL1V7Hysu4VEGC1TjbI5qaqOxHi+GKtOHF
 BeT5+Taskr1kL1uQISVV1dmnIyGyWxVL5OtEszHieStqxHufKVmCTMv463Kjz3ryHKvqqw+3yY3
 LiS5odPTATC9C32mltbLaycAAKq81jFWOvbiHT+m1cRzouz4q5JmAVDfi99b11QAhVzEzdSYtEU
 qF4RGngRtci9R2YVvSBYRh2rSuCZ3L0ofHa9YNBCdthCYo1NZ+1fmFSy/YAPNUVCA0BiUn3dQn0
 p3n2DLf8uZnnEvr1EIYibpUpqmXeUOWDcQpI6VLaRGGILNsx3ayBCYty24PPy23bmpk2UoJqWlG
 Uwx3AZk/gRRguHjjiiG6kKcktpKXrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_05,2025-10-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290085

Add support for assert_perst() for switches like TC9563, which require
configuration before the PCIe link is established. Such devices use
this function op to assert the PERST# before configuring the device
and once the configuration is done they de-assert the PERST#.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6948824642dcdcb1f59730479b5a3d196ebf66ee..a6ebcbc19d3c8b28bab53f516ae2a2b42701ca6f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -640,6 +640,18 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_assert_perst(struct dw_pcie *pci, bool assert)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	if (assert)
+		qcom_ep_reset_assert(pcie);
+	else
+		qcom_ep_reset_deassert(pcie);
+
+	return 0;
+}
+
 static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -1448,6 +1460,7 @@ static const struct qcom_pcie_cfg cfg_fw_managed = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.assert_perst = qcom_pcie_assert_perst,
 };
 
 static int qcom_pcie_icc_init(struct qcom_pcie *pcie)

-- 
2.34.1


