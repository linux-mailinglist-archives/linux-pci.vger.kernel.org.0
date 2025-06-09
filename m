Return-Path: <linux-pci+bounces-29212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F646AD1BEC
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 12:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDED3A2CF4
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 10:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C220B256C60;
	Mon,  9 Jun 2025 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NZKDSen1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B93A25A655
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 10:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466342; cv=none; b=KdrIBbfwOnibblRH5ytOcRBQHdIqjRmAvGpDQG0PezS6XM1P0CSBJL84jpUq716w8KcA/iIx6ov/Fx6WoefxxuSvHexbflkKUfdc13RfUjJ6Yrz3OiK6A6L8RxFqS42dCQiroJv36esEcVl8sBaFHXxhexUSWKyC+J6gqqtzmyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466342; c=relaxed/simple;
	bh=rfpuuz4A0QmsWV8lRO0l5whEsWzWwv+rc5GG1/o0xok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IV5nesDuNZZXJLU/kaiW33/3hThMhY0XDOjr103fn76AuMOoAg3ary3G7iNYmIq5tz9PPwCB2y6yIFEaJoE/WPBbEve5p9nMlgL9tm3Z1HzF7rcI0GBn+X7s6guVWOCeOO6zxcFAUqQWoiHvdURnIUIEabP4KZfP/zIsAoIwHh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NZKDSen1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55996LUe006177
	for <linux-pci@vger.kernel.org>; Mon, 9 Jun 2025 10:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QsooE1BDcjvS4+pylG64GDXCYMB/yvCU5ly5nWPDrGY=; b=NZKDSen1iZxQsCyL
	umvq/NRS79yMsXt8GKVeb+0Ht2gMZR8HOyPCyoYTBDXIDg80nh7sCAcuuXDedPLM
	WU98ISW6XS3E19fXVbRplrsflSlCllf0rlU3eVAA9IJT//fxOnSPis4tPaxMRJTx
	/cRDz37Y7j9aiUHzFQPCw2kng2ixppx3V6SSg/fYgJrlcZFSkLcJEAW+XVAk71si
	zxnU9YaIyrHaP2lBuvtJaZBY4VEMcaKaPOi0WeU7tahv+YRVKGEHKfvzSFmkHPfs
	51bKzHMU3S05fWzgbYVOXdWvAr8fUeS52S/EryztCe9vuHMs+g5fuhJLhZbC56wJ
	JmnA7A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474dgxp39v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 10:52:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234fedd3e51so37632345ad.1
        for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 03:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466338; x=1750071138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsooE1BDcjvS4+pylG64GDXCYMB/yvCU5ly5nWPDrGY=;
        b=eIkoM7uGrqU0DQfGuKAUGCX0HJUgVAo9PDtaOBgzv3859kCUugouj0uF2emgIe79ee
         QJyKZCJDMhku5flPCj6TFOuoLlZ86SiHxBASIp6CzNFUEafq4RhWS657fScWhITC9KWo
         +MmMx5TXzB6ugF98yM2WkCWDrTNwwGmofbB5uEEeplScqTTV8dDwLkHhzn9762IXPfeG
         CjUD6zS9h3yJuMGObDJy6POcwxSXlLpIa975WYbkN4xMEByok/6RngF508X2Q+lT1Xnl
         3M3em2rEfCwgGsxZRaZTKN/gpDpuG2eHIoNt2DFW7+6+3l1mBSYDYCek69mSOeEywzHz
         ddSg==
X-Gm-Message-State: AOJu0YyaL/aPkPXUHd2fqJBz3VseaQKGy13vxxRmk/iLF2DD7pz5ZAEA
	U9nasfzxq/82Y7SivsRqpjBGLRg3CyAHfuoFOqW99s90YL09fyIrsCTw5EO8Fto1go/IsMLmDIi
	xkXMp8+4rAKzxx2+I8a8DCQ5/JqPfqBUfL9TR22HlS94eociFFJncywHQl3/iUaQ=
X-Gm-Gg: ASbGncvjOIQ6MwbyNr/W4TqNTOeEeyzsJx+hLyq80ygMdSIb6gwR5vAajrQnytdjbmQ
	AKx1RmfHVHQ1sURHaGW8XB2MpeiHj2xJYxJiVPiCsmWGyUOVFfwAtE+HUySHLZ//StCAOhDoksy
	U5p+qDGqFCOImCFXKNwAZUqJFeTi3jayIWjX+ZJ2U3/WJV0lqx309HZPWFBAUuM+rTYa0LQ/5m6
	HMgPx2DAizGHd6TpUKzLzs9r4An470OwdgDZABFcBBtsba6KrXkwc7qj0tHDfHGWs0RXiEFLvLl
	ZA/l/TtSOUD+HIZpW/aWx4L1Jw4K7cJyeT7VgsGB2J0q0O1o4PWQJBjMbQ==
X-Received: by 2002:a17:903:2349:b0:235:2799:640 with SMTP id d9443c01a7336-23601d225damr200290285ad.25.1749466338509;
        Mon, 09 Jun 2025 03:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFsj9gbm1Xe2gggDXCvM8eocxd1s80k1LTfUZKFfmG+nVAZVHG2TZKNjCJmXQ8psxA+pG/sQ==
X-Received: by 2002:a17:903:2349:b0:235:2799:640 with SMTP id d9443c01a7336-23601d225damr200289795ad.25.1749466338116;
        Mon, 09 Jun 2025 03:52:18 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f44sm51836465ad.63.2025.06.09.03.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:52:17 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 09 Jun 2025 16:21:28 +0530
Subject: [PATCH v4 07/11] PCI: qcom: Extract core logic from
 qcom_pcie_icc_opp_update()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-mhi_bw_up-v4-7-3faa8fe92b05@qti.qualcomm.com>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
In-Reply-To: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749466291; l=3243;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=rfpuuz4A0QmsWV8lRO0l5whEsWzWwv+rc5GG1/o0xok=;
 b=YVwMdol+AseMlfIz0/NjSMg6XCl8+u+DF7+jT+n81+w4e7KH9oYdQk4afC9TamYNqaM1TKy8M
 bo1nu3Kf+/ZBUYGTEKdroWLMKZLaUue+XTINQy4n4hMD1rB2U+XFiUi
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: -lnaKc_hIBnWJvLiL6FrHdkNauOo5tev
X-Authority-Analysis: v=2.4 cv=HMbDFptv c=1 sm=1 tr=0 ts=6846bce3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=h4B-02p0z56_JbXvspoA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: -lnaKc_hIBnWJvLiL6FrHdkNauOo5tev
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MiBTYWx0ZWRfX9ZQNHKME0r+X
 983NEz7ckeGbhZOworNuMJZfah3kyPzEL79ClbqTT1X+sT68M0xb3Eg4ZJIhRzO3exlT094SD2m
 jPNIrtqNAw/6BLx7MmWY96Wr3FYqj4oBVPpfEGX+frKGWuT8Pb7jA4VDTufh49VZvEdHx2Q1X00
 n2tFD/klba4i2ZpeBp/EYBOlE3K8CRJG9X9XS9uyLSS7+4q3QNmmXCNyss8iJepTDLrQQjprm8S
 SxOHS5R5TTRLzOLR7dTQnHOgPXg+ukJ4H6sa01rQ4Ar4RENtTVW4ZDEDEYN05NFBtIfNpsr3Q0c
 S6kZjt1skckmGZ+x2gACKTb32l/73PtZJlDcnh/QChm46mNrvKMOzpk3oqeSgSKFaApW8SOTJhs
 iLF7qE91TXSidFqjUZsJ6meOOimzMlTrUeWZzo8KXSs9XUg8ePam8YPH9OMqmZLf30hnkhZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506090082

Extract core logic from qcom_pcie_icc_opp_update() into
qcom_pcie_set_icc_opp() to use in other parts of the code to avoid
duplications.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 61 +++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c789e3f856550bcfa1ce09962ba9c086d117de05..02643579707f45fc7279023feb7dbc903e69822d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1294,6 +1294,40 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
 		pcie->cfg->ops->host_post_init(pcie);
 }
 
+static int qcom_pcie_set_icc_opp(struct qcom_pcie *pcie, int speed, int width)
+{
+	struct dw_pcie *pci = pcie->pci;
+	unsigned long freq_kbps;
+	struct dev_pm_opp *opp;
+	int ret = 0, freq_mbps;
+
+	if (pcie->icc_mem) {
+		ret = icc_set_bw(pcie->icc_mem, 0,
+				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
+		if (ret) {
+			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
+				ret);
+		}
+	} else if (pcie->use_pm_opp) {
+		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
+		if (freq_mbps < 0)
+			return -EINVAL;
+
+		freq_kbps = freq_mbps * KILO;
+		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
+						 true);
+		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_opp(pci->dev, opp);
+			if (ret)
+				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
+					freq_kbps * width, ret);
+			dev_pm_opp_put(opp);
+		}
+	}
+
+	return ret;
+}
+
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.init		= qcom_pcie_host_init,
 	.deinit		= qcom_pcie_host_deinit,
@@ -1478,9 +1512,6 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
 	u32 offset, status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
-	unsigned long freq_kbps;
-	struct dev_pm_opp *opp;
-	int ret, freq_mbps;
 
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
@@ -1492,29 +1523,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
 	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
 
-	if (pcie->icc_mem) {
-		ret = icc_set_bw(pcie->icc_mem, 0,
-				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
-		if (ret) {
-			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
-				ret);
-		}
-	} else if (pcie->use_pm_opp) {
-		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
-		if (freq_mbps < 0)
-			return;
-
-		freq_kbps = freq_mbps * KILO;
-		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
-						 true);
-		if (!IS_ERR(opp)) {
-			ret = dev_pm_opp_set_opp(pci->dev, opp);
-			if (ret)
-				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
-					freq_kbps * width, ret);
-			dev_pm_opp_put(opp);
-		}
-	}
+	qcom_pcie_set_icc_opp(pcie, speed, width);
 }
 
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)

-- 
2.34.1


