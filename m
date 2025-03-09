Return-Path: <linux-pci+bounces-23204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73CAA580CC
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 06:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41EF43A454A
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 05:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F6F1865E5;
	Sun,  9 Mar 2025 05:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DE73tUri"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFBF18871F
	for <linux-pci@vger.kernel.org>; Sun,  9 Mar 2025 05:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499192; cv=none; b=r3QhX4hyOKw+HFcBGlB5ZHsxWlkphD2J5D4dXH1+068hrXp7TbRu5u72pY1sT8X/HiF2JXR8Wscgh9T+IYF6lmbzWwQkOZ+C7Y+/8SyANF/4d7X79bkTzSaMA0fJmNqNQYTjux1eu4ZZW0sNAb0NGsFZTJ+9qFa+vT53YzrY9uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499192; c=relaxed/simple;
	bh=wsREze9ZB4TFdyowJtOMq8dXoF2NzkSuE4x5ZRpejYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDGGS4JBObpXxKDCxlTgrEdAuASTrN02XkrL3U8FvRcvMqkzOowsz2NvmrT9qUZrVzF+Mc9W366caZ4nxssLWy34iRjmw/K8xdJGVC91Kin+U8Lfc44JK4jDYM4IH3bIe1DwU1NLgM22gWjfMJUiunoFPRrH7R/HcjzsnMBoQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DE73tUri; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5294oA1x016551
	for <linux-pci@vger.kernel.org>; Sun, 9 Mar 2025 05:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3EfkY4Hv452ybIcZQDu1ZsQhrhBGarKIBNj23RcC4To=; b=DE73tUriRr7ieO+e
	0LOTqB5TJiLyk9/UKDDnNJW3hKcXiA5T2AgjRJOj/gtQLeIwA/D9UVb42fHRz5dW
	FY18BhoAzbd4a9i9eELK+4H4nMsaMBE3hKGDBYnyNHcoge0uvOZwZNOz6tj1iCWJ
	ZCAYWWvwfehLclpTzj15+KebIrr1GEpK7xWs6Wjrv5JWNeFXR3L3uKP5tGf87rQ5
	n8jLOKzAr/U3lBpMAubhlcaWnqtch9NRJGjF+6bYciIs/OD2mGJR9w+goYUZTtcw
	/DSttw+Z0N7tKO8tOCH5nBAKPUh8TvehS6wa4R9bzHmiXkW8z7d6eE4oeg2NNPWq
	TQZuJg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ewphp81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 09 Mar 2025 05:46:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2240a7aceeaso56194285ad.0
        for <linux-pci@vger.kernel.org>; Sat, 08 Mar 2025 21:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741499189; x=1742103989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EfkY4Hv452ybIcZQDu1ZsQhrhBGarKIBNj23RcC4To=;
        b=KU6IEjB+8I92Ig0orBwnYN7BGo8f3hOZzwnXpc23+dv8lWIzSyuGbmXX4GxNXeaPdj
         SfBsRnrjvL009ylybnfojZzLG7LF1aTkMqkfpCYnJPbVh2IGw4L9pDZKI4Mz2nhIz6xy
         hCDflEKSI9ljjOXthymzk7HddTG+9jOzSd8+xZdeulyxg0yp6m8J4GNf8apuRaUuEelZ
         /MJfoEdft4v9M5WIOpxlq13WwFca+N6vMY3PbAj1ragOLw8Jmz9stQRx6I7Likn+Fcf4
         OfChpPNyXsFD+OcZqVabqpfW3KNEEXvi1g0g2iACnJtyUx0X7qbHr42GD7obCk07BV1J
         I4/A==
X-Forwarded-Encrypted: i=1; AJvYcCU10Bh55oFZYA7fH0OB+he0g+394PS/erNqYMYPWGih10QXOfIQLIt6v7H4wErMTnAnCJzACW6VhBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1F3KXLOIZC6gOCeHDgVUak1/1e4OhuvntEuZZ7FcEVMJNMQK
	+FKJO9RCfXbkIdHF15mWNFN+E+S8LMjOkTkK+2S9YqzKfu3jAtYrTYPT4FZX5wlIdGtG6NwLtSM
	ZMOrk40tPFDs3tdzBT1rKQnfxuvvqrpUh8tufdD3YoyyQ5G/sPiyXJwVNqiE=
X-Gm-Gg: ASbGnct0zzB6bdXlu0weqRcIOH+J+PgE9VzQvnaLJhd9BGGSdlEy6Ee71F5KJYevQnP
	1/8YrYi2NcxCWb5CfR91/WsxPDV2jF6/PZOrD+Ug1CCuEtGhAatFuIomkk8/v+59cvmOxg32dqu
	7JBjJKhu34gUgPVeRdV1Mu9x1A+XKXZz6JNh/ixrxSV7HQiNDCVI9ch6cia4HvSfbpw5p/cGUOK
	UQJfvMVXdWRf9zT1TlXH6G3F827XbbC66EPEshZan8SfLTKF2PGE8nDESITSNnfIScUEHVBR6Jn
	elH05LdIN7k0UtLOro0OWdKdOQRU4UY+gnlD14xB9gLMqNlIV0Y=
X-Received: by 2002:a17:902:ef48:b0:223:4e54:d2c8 with SMTP id d9443c01a7336-22428a8d1damr159377645ad.21.1741499188762;
        Sat, 08 Mar 2025 21:46:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtcdtKDb+nmzTQePtl4xsTUPi4gRGltswejf9cFXfLAFAd/iJir52Hd6AeQw6W6iDiwcL4YQ==
X-Received: by 2002:a17:902:ef48:b0:223:4e54:d2c8 with SMTP id d9443c01a7336-22428a8d1damr159377425ad.21.1741499188425;
        Sat, 08 Mar 2025 21:46:28 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddbe7sm54887145ad.32.2025.03.08.21.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 21:46:28 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 09 Mar 2025 11:15:26 +0530
Subject: [PATCH v5 4/7] PCI: dwc: Add support for ELBI resource mapping
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-ecam_v4-v5-4-8eff4b59790d@oss.qualcomm.com>
References: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
In-Reply-To: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741499159; l=1733;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=wsREze9ZB4TFdyowJtOMq8dXoF2NzkSuE4x5ZRpejYQ=;
 b=3crrTkeeu1lFVP3OJpn9vRcbyNPD+fSlBlxCr4aL6Y2A/R7na9mB0h3h1kD+h5ws1pvISIKPL
 UNzx3N5eygBBUkBGfbMjBG0MBfXMZ67rKTYQ2f080kHpXbyfhO8X/XU
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: O6nLbjCqi2Fcrxwq2V8eY0fZ_AE3I_cK
X-Proofpoint-ORIG-GUID: O6nLbjCqi2Fcrxwq2V8eY0fZ_AE3I_cK
X-Authority-Analysis: v=2.4 cv=C5sTyRP+ c=1 sm=1 tr=0 ts=67cd2b35 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503090043

External Local Bus Interface(ELBI) registers are optional registers in
dwc which has vendor specific registers.

As these are part of dwc add the mapping support in dwc itself.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++++
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072..874fd31a6079 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -157,6 +157,15 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
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
index 501d9ddfea16..3248318d3edd 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -443,6 +443,7 @@ struct dw_pcie {
 	resource_size_t		dbi_phys_addr;
 	void __iomem		*dbi_base2;
 	void __iomem		*atu_base;
+	void __iomem		*elbi_base;
 	resource_size_t		atu_phys_addr;
 	size_t			atu_size;
 	u32			num_ib_windows;

-- 
2.34.1


