Return-Path: <linux-pci+bounces-32403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE93B08EBD
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 16:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9741C2578A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6EC2F6FB3;
	Thu, 17 Jul 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DIY9YdKR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D5F2F7D1F
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760916; cv=none; b=p3U09ywP32kTkMJUEKx1crjGynXxvGk48f2K1Ca5tsMjZMRrZlfucxbMxChAyGQ6cdPtKgCJFwI3MjLtjnnVp2oaEzH1bl3FHPXCBOGpKeYtSJf5DNahNP4WZE+whRgMg5ESan7JsrTBnrAFeqZ9QGyQTSh4penDyxKK+/Q7jS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760916; c=relaxed/simple;
	bh=Dhmeg5kW3jkXRtEQU8I7P8ZNQYm6stnF2VGjRncNTvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JSUAqyynND4NfvSLIwK/n3Ws8kXqqlk5luSGrEfkrMSv09crpHwokQRfnQpgzKHokrqoEb1xBeRLO8hVcHV3krhK9YHMkMa1MdTtUwnlDVy0zL86DL1PUi1xOv429VdQAdIWSbPSiQvAroaGxXcoaM17adgxeHLf1W5AFeOGiX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DIY9YdKR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBwSm0020653
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 14:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Djf6erG+ZP+oc2BSetwCL7jzmGa3Zd+9Ksh0jXCgHwk=; b=DIY9YdKR8kgent7u
	ZmxoiG9MlHN8ZlkmvSnPuryvCLYsAxGlV+snUfCE2j589h/23QR59h3J//O+TAZo
	RBz5Y2GI1SKnydn+gnFpRijuuPT3h+qussb+M7ncrUf3FG8qzB+D/dtJuXRwpff1
	/qlIX4+4b0ZfOCZT3WZWUyehYFugYMbvbztLeOCsT4F5N7PiYbmz4MD0xlhoOGgK
	u7ZlJOXZFqcUgJlnB78/SD8vJiHKRNmDz9HJiUzo7QA0zZyKsXXWJp26fLIy1VoY
	uvcQl/9FpHr0z8BTr9QStFcX1MELlYhW/Siyu4sf0M3QbeQV7XdWdisCXFeCyci+
	QjkHCg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpjxva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 14:01:54 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748d96b974cso1064194b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 07:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760913; x=1753365713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Djf6erG+ZP+oc2BSetwCL7jzmGa3Zd+9Ksh0jXCgHwk=;
        b=BGqa5j2DitKzCauxGqIvZoKxR8KNnkelvwUrFoFnAK1kLmI/1qEP/n8q8J68WhVbJA
         WvyxrPTuTcJd8Mz1En85fIjMF48Wvpa0Zhz2DQfjnsDc0XRkJC5hkxSnISAwy9nSfVZ4
         U4+AFNjUo5RL0mT0qT9pim2zQRA3tFQhIBxCyhNVnArsx8pA6lJ5RQtatSz3U7vht/51
         Au8TYnLU52YZbcSMTJgxmlozD8CVt4IV65sNrPJoDrHpRR8U3XMJbOETBwJ+dhAgtiBJ
         RE+0IRSCbThiutsET3sBWbMtbRdMbECbSA4XB7lMJt6godAVzAbC4S2SQ29c2ZSz44z5
         fSDA==
X-Forwarded-Encrypted: i=1; AJvYcCW57XAu5Ut/2esRs3G1SxKqZBmxolLRZzO7DFJNVnocK/6lPaKQucKCQY2Oif4rJHSBo0JQUX7gyMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpcTN3/GaSGBb0q3UlxAO3bH7tHXm7w8iZl1a3vjB6fSCyqiU7
	+hZ1HOpYpDTn08nO0x0eGLEtxJxy2JO95lPd88T/lk9UsEHCS8mfFE6jjvTuldNJ4VymJJ8DaIS
	5wn2sfK3nn5hXrcQCCSL47sw04PABuBVRkiyWiHnex/0jRz2TlzUcDv4VW6Lr34o=
X-Gm-Gg: ASbGncvtXUgjvbxqtK1uZBQKfRzdGoFFFKjjrqH4B5WPraaqYJbEy04zyRSzcPxcRIp
	gP5tCfqE5NPDlBCcG+Va3HbZIJtANJ01gCoqxovFSU5zL54oY6LQrdiEUaG6djGh6qQN+az5TyB
	c3EV9eWqJerbq+j6y2N9GV4izOFWEFhO6ODhD5f9xvlEG3jvqr1DfcuV4MBaKXifl1MPwMtTEYO
	49/iWEVWpCWFedVKD+KhaYyPpLupjoaDE1fbA84fjVZ2HBTRhlObPGlGoajOIKTfsQQ8eSZrqj0
	iWn4fAIsYfsYQ+fE3vGbAPNvxOxRRX5Nmm510Zv2b/QFLbT4ZBceCTEQ9oNb6Ob3ht8HStgQvms
	=
X-Received: by 2002:a05:6a20:7290:b0:235:b6de:4470 with SMTP id adf61e73a8af0-237d5a04312mr13021389637.13.1752760908514;
        Thu, 17 Jul 2025 07:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqfgvPvr2MPvSRydxqMLEX8fOncC77Ga6bNoSEBZPXqpAQm3mCkG2jxNO5HoVFg/84ZPlWmg==
X-Received: by 2002:a05:6a20:7290:b0:235:b6de:4470 with SMTP id adf61e73a8af0-237d5a04312mr13021329637.13.1752760907916;
        Thu, 17 Jul 2025 07:01:47 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7507a64b57dsm10311986b3a.14.2025.07.17.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:01:46 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 19:31:17 +0530
Subject: [PATCH 2/3] PCI: qcom: Use bw_factor to adjust bandwidth based on
 link width
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-opp_pcie-v1-2-dde6f452571b@oss.qualcomm.com>
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
In-Reply-To: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752760888; l=1499;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Dhmeg5kW3jkXRtEQU8I7P8ZNQYm6stnF2VGjRncNTvk=;
 b=084KUxFpeuJmftJPk/FbKVmIaYC1dXtazX4CPnFK15rWpGQGjjydZZMBNZrWPmRUtVBAw6skJ
 SiJ78PAdaVsDM9kS62O4m0IJwHUNPuuA2uMAA2Ft7ClH2vU7dOebCvY
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMyBTYWx0ZWRfX3gWnXdGrmqzD
 1F8o5aehbTtDY1prlNEiI71qPEzvZcE9whvkZdQXy8WFS0Q3hYS/HS0v2ct6koQVMw91vU/fKqB
 aGOkuJzaCdy31mPHARlmU9XoePgMq3MFKCvLBT0MB3YzcSvgzHr3D9V24py3OyCecULy4dbkN3W
 qsNH2gKWBdm1dC/k3HQbzkhXOJU7LjrwYkJxtnmjwL7L43mg88EySUCrNNlGRW5bh7GlDtX2Fzo
 6JCVJYWnqN7nov45NoCafgWuKVE+J1i+tZas8UAkn5Y13RcalWEUKKl/3/gR68TX4330s1zQzBu
 gS1zH8SPk3MUNHf6uepqMz+4TI/fZG0zhMTBo4hs/Hmq/O+EVdTWs46OuPiuCLGYH0rybmztv6D
 cb+8MyhQtNQ3uTpHSSdzztlq/aPrY/aHyH6drIc/gJDW3IgRUV+ggtYULeQ8FU8VUxg5NWbp
X-Proofpoint-GUID: gY59_csVhA1kGdCSJ5D7x6TDI3lN4vU4
X-Proofpoint-ORIG-GUID: gY59_csVhA1kGdCSJ5D7x6TDI3lN4vU4
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=68790252 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=953 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170123

Data rates 8GT/s x2 and Data rates 16GT/s x1 have same frequency so using
same OPP entry in the OPP table.  QCOM controllers may have different RPMh
votes for different rates. So we can't use shared entries in the OPP.

Use only data rate freqiency and remove width in it and use bw_factor
to multiply bandwidth based up on the link width through OPP.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c789e3f856550bcfa1ce09962ba9c086d117de05..fde9fd3fff6bdcec0c9618d3f4b003a3d823307f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1505,13 +1505,17 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 			return;
 
 		freq_kbps = freq_mbps * KILO;
-		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
+		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps,
 						 true);
 		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_bw_factor(pci->dev, width);
+			if (ret)
+				dev_err(pci->dev, "Failed to set OPP scale: %d\n", ret);
+
 			ret = dev_pm_opp_set_opp(pci->dev, opp);
 			if (ret)
 				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
-					freq_kbps * width, ret);
+					freq_kbps, ret);
 			dev_pm_opp_put(opp);
 		}
 	}

-- 
2.34.1


