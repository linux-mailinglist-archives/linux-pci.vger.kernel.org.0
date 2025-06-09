Return-Path: <linux-pci+bounces-29215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0AEAD1BF8
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 12:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4227C3A6401
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 10:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3932571AC;
	Mon,  9 Jun 2025 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QdVfk1RH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF2D25C704
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749466359; cv=none; b=FDyr9aNB+EXsTfq6a/066b+ELSWhZ6nGWtiMNghQj7VU4KWHOX9qqPl4XrSLm/kl34i8bFaO0wNfRuH/FcW7egjY2Bd/i0uf8ht+B2hf0zDZMo3U4HJq0rfCWxm6CvdAxAlgRJkj92KwfSmAzZvclUjcwD1HW+bcw8BMJG/DM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749466359; c=relaxed/simple;
	bh=ozgpq2xmvi4UJqJjNIVDkHjQo77lQtGFPl31rvLet4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JW5dENSfY9xgM5Ud+mUHDE+qhyRVOxZpvMq3kPxn8bdNF4w5VnRTkt2AehuZKa93fd2jQFdd7bwUKniME4BKFEXTXyUDjlGSWnf2ucE5S+NVhdV1VOybi+Zf4y9DYdasDiEWIG1iyMKBsKCslCJ/57XOZyjr6nw1RiyD2jk82mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QdVfk1RH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5599LlDW008098
	for <linux-pci@vger.kernel.org>; Mon, 9 Jun 2025 10:52:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rf3T1+3GASlWJzZ0bWsqvC6Cu4nVbS7t3i233bUQno4=; b=QdVfk1RHP9aFEftv
	jffgvjF6vy41GBr7vtN3G8DmLCPOlFlFUA/D9ctuL3rFx+++2QK6He3h3xq0QEPq
	uiCmC4p26jBkB5ff3eP876Rd6X2dc1af3pNYR2OEdNGTjK56v17lnw5GwDbitwzI
	qZDQyKDjgiqFvMdK2O+1F3Eo9SIkRFSJUGzbnXJ61JDK5BnXfvQKsqphxFLyT1gO
	d6uj1vUfvkug3wvw2RLRPy8T8R8fovwQTcrGEIfn35ft1PNrmu8ehIo2q0CjO86j
	VU/vSoth44dMy7SWgvRLaCm6BdPkfPJJgAfJ4GgPlBIHZKCLNoMEHL1X+y/FksI1
	9ItvDw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474e6jdhd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 10:52:36 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2eea1c2e97so2944742a12.2
        for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 03:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749466356; x=1750071156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rf3T1+3GASlWJzZ0bWsqvC6Cu4nVbS7t3i233bUQno4=;
        b=uQkoZsBPG8LEbq3ULSSEZwZ2fnX+C9tVDTwucNbJM4fD0LfkqRt6UGqvNZafGXkr8X
         LvIlmcs1kaMmfQZqYdZquNgE9hNEykK1t/F7ImLZROB8fFV+YWp/zw852/JDxRNeuUTv
         IgOr+lI4I6FbwFFzWMZ6mlo/NspvdjREHbG75XRg95SbZb7C+9UAlDZWzWrsDGvTcSMS
         mWycf0gB1ysznCoL3MAQkBUnGMvfrfoLX/OJlZKMnM9DhhmtISHGAojfyhWGpDSabvCa
         Rg7dBHczQGG2i5oanqxqIjJdxpJ6L6Obzqemppkoa19t8If3N2ycOCy0GKSYEjnGo5lx
         n7nA==
X-Gm-Message-State: AOJu0Yxh4BBp6HLZq1N/W79JkjIYpoOnEsU6ZrTEhNGbrLvYzHcVxN8J
	fsxmS+Q7piFI5C/yIixU6RA83jc91ik3gRybPeQENR2DxHFmIbalKrXAapArDDtLICp7ISKIkiE
	5gWwhJd/rQiWhHTx/v+J6djVaLiI2RN51QLQLsOxzONMNOudJXQIF21GeG7n8n/E=
X-Gm-Gg: ASbGncuUSrfN94Af5P91d8NlqLkccyewTyPKyOKEfG561OVkzCSqiBmQ+hY6Z5yEVMj
	IQSBXcDOKASRxzs3HfF/g/NjLwY0MLuSiyqBuXtFrSE/BrwV0yrOnr8NTgCP0w8KtYZHJNB0fKp
	yfmLibvcpIKjcqenCXR59U/qOZdAv4UG5XkauPGqYNGng4DnyvjbNn6C9AGsobLab7U/qMB0RP+
	oQRlGTJjgEyWLnfUaF4C1Q6UJyFplorHN/8UcbTm8kKjx/JsmO1H1cJji0/3Llmt/B0AOL99fVq
	/tS/NECLCl4aDVLscxWoB6pn5oVbdaJHajmxdACu36LYrrvkQprpu7RpDg==
X-Received: by 2002:a17:902:e892:b0:234:1163:ff99 with SMTP id d9443c01a7336-23601dbda63mr188272185ad.43.1749466355804;
        Mon, 09 Jun 2025 03:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfOtxSShcIPHOq4ERfbAdlOhJ+1CY8bWvhhbD6i4sNfbzlFHhLFu/fy1Gvh29SHVHghOb2zg==
X-Received: by 2002:a17:902:e892:b0:234:1163:ff99 with SMTP id d9443c01a7336-23601dbda63mr188271785ad.43.1749466355402;
        Mon, 09 Jun 2025 03:52:35 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603092f44sm51836465ad.63.2025.06.09.03.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 03:52:35 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 09 Jun 2025 16:21:31 +0530
Subject: [PATCH v4 10/11] PCI: Add function to convert lnkctl2speed to
 pci_bus_speed
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-mhi_bw_up-v4-10-3faa8fe92b05@qti.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749466291; l=1624;
 i=krichai@qti.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=ozgpq2xmvi4UJqJjNIVDkHjQo77lQtGFPl31rvLet4w=;
 b=yaLOh4FX5gPQeN9e5bGsAkcMXFcxKgY8uVvM1nj/u8Ux7O6Q0xBWEZ19LjFKr1TFtB3aF2ufv
 5EL3YOyrIgoD5l4/FTIM/xHGeEl1CjT+2Ytmco4OKC5eUZzGNbxgip+
X-Developer-Key: i=krichai@qti.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Id6HWXqa c=1 sm=1 tr=0 ts=6846bcf4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=rcts_Xg4tTJKaDXoMsUA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: -zSrLLGusZnvuBG6gZJp9N3XMUtkIqM8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MiBTYWx0ZWRfX8FFAaEdMLfIY
 r8lEjcM5j7AjRI0UCUkeVhVU+Gt3bfFcyr5ExpucC8JTgXBSUx5jizGkPacjLs1rJEiPpjfrg+6
 zcNXnufLQcLhV60Ab/zoyMb40PJ4o+EtYuINg6S7LEmuJJMTpj0bgcKFKtYoyIR7hktxM/lpQbM
 +p62bXFCbmn+fD2cDmLveuz+f67SD/3wN7FJfSHpBFAc1rIIjBV5LHCklfDQf1dY/mMsV5aDAH9
 UgC9cVGM82bAduvT1NerymNMCvyFPP/v09CSEqY9hx2hFFaRSy7+95v/tMNTj0vZHt9yUApk8AV
 K2GVZ1iu+h8BQqjk/+L0BkHs0IUF/a61Jqdp+Zxlbd1T27FL4qCy106c57kbsoIwDkX6/sQv8sQ
 2GTzp/0sRJTHpHDKGXt/CMlt6LhFRB4NYSyvwSASxNAsQsHnaAzDYA84amOym52khKsLozjb
X-Proofpoint-GUID: -zSrLLGusZnvuBG6gZJp9N3XMUtkIqM8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090082

Add a exported function to convert lnkctl2speed to enum pci_bus_speed,
so that other kernel drivers can use it.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pci.c   | 12 ++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e9448d55113bdfd2263d8e2f6b3ec802f56b712e..8950e88826e27accfe699e31fba8f4077c26296f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6018,6 +6018,18 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_link_speed_mbps);
 
+/**
+ * pci_lnkctl2_bus_speed - convert lnkctl2 speed to pci_bus_speed
+ * @speed: LNKCAP2 SLS value
+ *
+ * Return: pci_bus_speed
+ */
+enum pci_bus_speed pci_lnkctl2_bus_speed(int speed)
+{
+	return pcie_link_speed[speed];
+}
+EXPORT_SYMBOL(pci_lnkctl2_bus_speed);
+
 /**
  * pcie_bandwidth_available - determine minimum link settings of a PCIe
  *			      device and its bandwidth limitation
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cb703443290a013c8372333fc8d547d190d9f3b4..900f2aad5caf664eb89babca82e1921b1ca2fe5f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1654,6 +1654,7 @@ int pci_cfg_space_size(struct pci_dev *dev);
 unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+enum pci_bus_speed pci_lnkctl2_bus_speed(int speed);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)

-- 
2.34.1


