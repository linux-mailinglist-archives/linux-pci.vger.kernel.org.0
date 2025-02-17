Return-Path: <linux-pci+bounces-21581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9735FA37B81
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 07:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5F63AFA50
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 06:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071531A5BAE;
	Mon, 17 Feb 2025 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZPunaYbj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386919E968
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 06:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774082; cv=none; b=e7qGzsfsGxv7qkozsMpI3kJW68HAuS+jLFcavYlCxuB5K5aTCnVGxy0uy9WRRnL9EJKzWuPuhOUid6fId4wIZIht6x2kT85gvU0CvsWdboEmDoVd++WCfoWk5sO6LwXgS2t3XUp7/i8YNXHBJ/1AmsoXEyYorbNRKKueLxdeI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774082; c=relaxed/simple;
	bh=0G/XG/YxFU6rag6WMJ+nAr2rfc55DQyaEL7pfp0M3cA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BBX0QWGWdk7HQjG/kk+9k34f/v52HmCtM+HHvwIqVmXDJEW23q5COwzwkB/8QVj5klrrvA9UnXW+IXI/5/2rd4daZ4eCxh/CbH4rx3iiZWHmTjGP6BliZvs7kGTkkslkQz9pAmYa7hqHRc+j5blCKOrcYpeG2vCm1I/amSQy9DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZPunaYbj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H03DOC026868
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 06:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q1NDvwgjsJKCHcz2zk+2Dmi/QW8Mawbbd+wgtBUmftM=; b=ZPunaYbj4TIqMFz0
	T3LRCGPJk17W1qhvXE63JJeWaIgGUAdJhkRTqmXbjhVx4RZ9SQNEFoEYFG8PtH1P
	28slha4pYfrQeOKWOd2t6eu23DpA2pXW196TmKNY6h6kkjH8ZRgF9fNi6TQNjR7h
	96DHuKFGpqbuowOW9gyH5odARl1rpmFwXTuELIIZ6eKiM9JpPPWXfFL5/nvnfyIu
	wxxnm9W3JSPCZ+INrVGKcQNmZ6C22prHhLCkJdtAnZ9agXca9nXFD33NymbiP+7c
	voMmrf6SUvIzuey3sNHDqN2bufJAUCihixw83cHFGRbPOWXKPlH7YU/3ksT9qZrM
	YAmWqw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7sgq5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 17 Feb 2025 06:34:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc43be27f8so5347439a91.1
        for <linux-pci@vger.kernel.org>; Sun, 16 Feb 2025 22:34:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739774079; x=1740378879;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1NDvwgjsJKCHcz2zk+2Dmi/QW8Mawbbd+wgtBUmftM=;
        b=Wcj8ju48aSUhOp5ajiIdfHOQJkmwo2iaCuY9FlI0ZgYOA2hZCJy2065yvUFkPLPM1G
         VzBrVBIlEEM5WQYJnIOuc1UZcIlilQwsqJZJLnim4qZ8UMvFdvnms2ONolHYkqUu3Ts9
         JIusEjFLlIQC5r25HQz8kXloWqoMtP8lVdGZxBfau0f1lkojdQJ6DvzaUSVeHjqCwJJx
         zqfgrdyR8BWpwtApmuXGEtwCn0+eCZR7D5pXjJpx2zmuLcoUHkGSVs6yxjR7AdbRKXB7
         8jaiz6qv96tu5HOxFxKTT3BiABBcQnzlexr3RwCRIG5QQ5LN7JA9tFlYiUsi8ay38CmG
         L+cQ==
X-Gm-Message-State: AOJu0Yyqw2UWwFK7XSDQ6qCWysU04VqZP/7hkucew7DCm5p3o0GQwdO6
	wMnD9hiQI0ycnMI4zfmToy+oqweKfjxFDXbdvfppqieCfkQLkG1uGeK98sHewqn0c8xQ98Bx8ca
	LIV4YsnC6NizNSosJonoN745mXnjvAt3FuIXfRfH73s7FDdK6EIUo2Bg1WLY=
X-Gm-Gg: ASbGncuCpvDTJs6MLU7mWVbf9sYfetP/Bx6L1nxep8IZSWLUhc9hpPfBXo6vRNo/K2P
	vpvYdU6ITKKl7qtH6LWltYKDBVKMXMxWlRaMg1LE/EggiQsAukhHaLGyYrKt/d2vKb4NTpdCt6B
	weGkmLgMJjZZ7TUqMtZ2mRqiHoLSdN6GQiyhI8OQMp+bABL3Xcu8q2P0zsffrXgXwZpme3lLf3Z
	4NXciH9QXzzLJ9vcR8j0+ziYAAAhTe9x8VJErIN51EmLpu5IbiJYNhyualmDMPVi/kPrZybjtGO
	/RgBE6mka4sxlC+GZflYkjc2bFfpRUduWJWzwoQk
X-Received: by 2002:a05:6a00:2447:b0:732:7fc1:92b with SMTP id d2e1a72fcca58-7327fc109efmr3075261b3a.14.1739774079214;
        Sun, 16 Feb 2025 22:34:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo0N15+Zd6Zvn9MgmFe3O8zvUpQANFOb3oxcmBBPbKXDnoGvy/IogEzYji+ZVTk5wsJ02f0w==
X-Received: by 2002:a05:6a00:2447:b0:732:7fc1:92b with SMTP id d2e1a72fcca58-7327fc109efmr3075222b3a.14.1739774078806;
        Sun, 16 Feb 2025 22:34:38 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73263b79287sm3771800b3a.29.2025.02.16.22.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:34:38 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 17 Feb 2025 12:04:11 +0530
Subject: [PATCH 4/8] PCI: dwc: qcom: Update ICC & OPP votes based upon the
 requested speed
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-mhi_bw_up-v1-4-9bad1e42bdb1@oss.qualcomm.com>
References: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
In-Reply-To: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        quic_jjohnson@quicinc.com, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739774050; l=4852;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=0G/XG/YxFU6rag6WMJ+nAr2rfc55DQyaEL7pfp0M3cA=;
 b=Hv/Cj81cpzxIilICVPcYYxPIKptPd12BGfcSJ+l3Y8rH9BsZmDsiq3nLW5/vP+pOP5tdLvy7T
 nSrKxG7A+K/Bkp3+j4W6kGPcRka5O/GhV7R4Fhb2BVuY4JowhVuxifs
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: XgS4cQJE5ANcy5Tj0F4vW3H6uaw7IQpJ
X-Proofpoint-ORIG-GUID: XgS4cQJE5ANcy5Tj0F4vW3H6uaw7IQpJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170056

QCOM PCIe controllers needs to disable ASPM before initiating link
re-train. So as part of pre_bw_scale() disable ASPM and as part of
post_scale_bus_bw() enable ASPM back.

Update ICC & OPP votes based on the requested speed so that RPMh votes
gets updated based on the speed.

Bring out the core logic from qcom_pcie_icc_opp_update() to new function
qcom_pcie_set_icc_opp().

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 105 +++++++++++++++++++++++++--------
 1 file changed, 79 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e4d3366ead1f..a39d4c5d7992 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1294,10 +1294,88 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
 		pcie->cfg->ops->host_post_init(pcie);
 }
 
+static int qcom_pcie_set_icc_opp(struct qcom_pcie *pcie, int speed, int width)
+{
+	struct dw_pcie *pci = pcie->pci;
+	unsigned long freq_kbps;
+	struct dev_pm_opp *opp;
+	int ret, freq_mbps;
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
+static int qcom_pcie_scale_bw(struct dw_pcie_rp *pp, int speed)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u32 offset, status, width;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
+
+	return qcom_pcie_set_icc_opp(pcie, speed, width);
+}
+
+static int qcom_pcie_enable_disable_aspm(struct pci_dev *pdev, void *userdata)
+{
+	bool *enable = userdata;
+
+	if (*enable)
+		pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
+	else
+		pci_disable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
+
+	return 0;
+}
+
+static void qcom_pcie_host_post_scale_bus_bw(struct dw_pcie_rp *pp, int current_speed)
+{
+	bool enable = true;
+
+	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_disable_aspm, &enable);
+	qcom_pcie_scale_bw(pp, current_speed);
+}
+
+static int qcom_pcie_host_pre_scale_bus_bw(struct dw_pcie_rp *pp, int target_speed)
+{
+	bool enable = false;
+
+	pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_disable_aspm, &enable);
+	return qcom_pcie_scale_bw(pp, target_speed);
+}
+
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.init		= qcom_pcie_host_init,
 	.deinit		= qcom_pcie_host_deinit,
 	.post_init	= qcom_pcie_host_post_init,
+	.pre_scale_bus_bw	= qcom_pcie_host_pre_scale_bus_bw,
+	.post_scale_bus_bw	= qcom_pcie_host_post_scale_bus_bw,
 };
 
 /* Qcom IP rev.: 2.1.0	Synopsys IP rev.: 4.01a */
@@ -1478,9 +1556,6 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
 	u32 offset, status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
-	unsigned long freq_kbps;
-	struct dev_pm_opp *opp;
-	int ret, freq_mbps;
 
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
@@ -1492,29 +1567,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
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


