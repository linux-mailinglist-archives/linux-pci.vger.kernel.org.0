Return-Path: <linux-pci+bounces-40193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06927C30F1E
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 13:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A0474F9EBF
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2812EBDFA;
	Tue,  4 Nov 2025 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RCbGBDtY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DcSDq30p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F72C21D4
	for <linux-pci@vger.kernel.org>; Tue,  4 Nov 2025 12:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258436; cv=none; b=lnzJW332NO7jjoaaV7JNyeJa9qqF3Va/tkutdNXDZw1azTbByp/j3llO0kAbp+e7A+jk1CvQeSwhdgU3IJcnzrb3HwnMQ9zsJlo79TmOdtjZGLuNpYqgF9+eXONRM1SPV3YgHj/EhgjIF/p7NZgnAIQF+5RXPdB4LG0zoKUq0Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258436; c=relaxed/simple;
	bh=+DzoErrmclrx+fyVr7vdFN6fgo2UUZGE/vT4uUlDgdQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rgAbb4DKBU22/tb/F90f3Mk3YgrOyTgT7julIKHtNRkQErupI9U4Jfj82+Va4LvhApcEtVv/uwCXPCo3c+wOwputeHzhlZN8Znk48jyrdMDVOYLuTQc53QtxLm9NNvHkpLQS0cR235g/rqYaW1zt3jwQ9Rt+Ao9jTHuuURt1S5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RCbGBDtY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DcSDq30p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48g1nL1505465
	for <linux-pci@vger.kernel.org>; Tue, 4 Nov 2025 12:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9l2F5WQjsOuWEb21RSgF9g
	1FD2s6A5B664vjj5RTNLs=; b=RCbGBDtYIP76PgacdYhWDofUHNA+esoKzS8VqH
	ImYKekPMjMQyfJZ+EAJhYJriORNBWcqo66vQDwfqH/QO878czWhem9G7Vkv5IoTV
	USoco2S5nrl0xhs8p5EkSfWejqc+Moc/US62WRGFmQBjbP9DZc17ddNwUPQ1pvdr
	VPOGSuul3aULeXCdxHxqXmQtUPOdT+Jm4JHD4obFqFcy2F1NRBMXicynV8KucXnu
	iCwUb71DkjtNrq7OocCfF5KNkr6uA/6msOcRkoPy3uvKZCCvp3cR2+q2I/TO4FQS
	ZdegRoVvLbCUhPl39TzbFqE61zEUYKIFMzF2CTmKD/JWQsqw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7b6ps3tv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 04 Nov 2025 12:13:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b63038a6350so4608917a12.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Nov 2025 04:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762258433; x=1762863233; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9l2F5WQjsOuWEb21RSgF9g1FD2s6A5B664vjj5RTNLs=;
        b=DcSDq30pz/7X5oVJ5PxP84YuLLKFdr5hCFWR++sY2iECcz4QBEAuDEFY3uGDBvcXn3
         m4gmjq4mMqtCgROwpX+j6Pnb75VBCnISiIlXDcZfl+J+fBzY5eEWReJd0l+fmGxJCrAV
         T4qnJcuzYlG0pn3vDkUzUbN5j/8tvPY4ThsngnYQjxOwQ6oD8K9lFuIttN5jp5vDmoUG
         nrdMaF/Nk8n6ZUwBb5Ibin0Nb0ACyX91sHZEJ2pKUBwwtaPB0ai/X21P271W3F86cuYk
         szGOakQ2CQpzuh8lvAlYXiWXXFkOVHef/pZCgobKsn4CZbZ29XnDMTVev+YVDgkT7JaQ
         xlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762258433; x=1762863233;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9l2F5WQjsOuWEb21RSgF9g1FD2s6A5B664vjj5RTNLs=;
        b=WQhTtBwtz0Tmt2JqA3uTG3+/L9+SNewCBTV2Eb85gcItpmrSFWbj34GeE99CUGdtlh
         cCDSeV1S19OwhxPOX+iVOduCh+fh9VPbYZxM3spR4XoZ3yrHNhCU+n/zwqfK3UCJgoNn
         l9lGa28ZiG1uavCP5yeIG/0p21NU/x99AvGyYKi3aXcGilKCKsAdz1R3Hyr1NHurpQpd
         izM1f17Rmwk7bFsyHYYOee1x6hFPWTsPdng6Zrx5TMbnnSFVRffWoH3m8RQqdfVLNEJj
         /yWgaM1CyCczeh9BMvPNiCbkECQqZbq9qmX351cBAtHu2vCh/td6JHE/Us2eKfFsoRxU
         VvIA==
X-Gm-Message-State: AOJu0YxOZsG2lQW9NO8PNMKLlLi7cCK1S+Z2jNQb9DbvKuG6nsTUPDbC
	ESTJ+pfzRUAs05vZycxbdm9i/aDXGdkh/Tvt6yqFgQAm6+orXUXoH/cQl6uu516VPpBcHcdEQWt
	hUM9V9UnOKH7Od3J+A1SleZrqYgRjdxVYTqesq90dfS62JAxF27nT1yCBnM5XlDU=
X-Gm-Gg: ASbGnctpPXFhsm/nBuvc5YWdhklRLs9EYPNUHg5uO6OVTq6H7gspKT/WaaBo2400vTz
	zwHxbl5DtY0qfziegh6D67u+zVir2xPSHDeUKgn+3BLFJXuq+rKzPWy2fj8kBKFR+d0lM16jB0Y
	D+FWFvzy7dUCNznQ9xTR39jP07a3xg5CNkoD23byxOA66yiqxBsP8HTkzoWh4jQWavyQAKjs6EM
	2G1QZyD3kgprGPHh00knmuf6Jj4294d7ju2uu9YXWpWmFL7VUcWakfH5yQD8aHqObJnnPRnimdw
	Vpspg5aehdy4o5l+qhcKSOwmZ35avWBIBkhrR/jj2FYtv+xy+oz/6UraJ02djPz45czHl0MjZoT
	Gndi/SbgGaePwr4oXnlbv9zMowfHVFc1K2w==
X-Received: by 2002:a05:6a20:9188:b0:346:3d90:84dd with SMTP id adf61e73a8af0-34e272e54ccmr3397696637.1.1762258433114;
        Tue, 04 Nov 2025 04:13:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESpL5vuTatq+nBygYOabD7eaIn2oVMV0YsB98tvlM39eFI7tpfjioEbqRljOYql4yuAMDUrA==
X-Received: by 2002:a05:6a20:9188:b0:346:3d90:84dd with SMTP id adf61e73a8af0-34e272e54ccmr3397665637.1.1762258432574;
        Tue, 04 Nov 2025 04:13:52 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f87a7287sm2254104a12.31.2025.11.04.04.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:13:52 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 17:42:45 +0530
Subject: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2 exit
 timing
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251104-t_power_on_fux-v1-1-eb5916e47fd7@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALztCWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMT3ZL4gvzy1KL4/Lz4tNIKXXODlGQzC2Nzc0sTQyWgpoKi1LTMCrC
 B0bG1tQDBSo3GYAAAAA==
X-Change-ID: 20251104-t_power_on_fux-70dc68377941
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
        quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762258429; l=2473;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=+DzoErrmclrx+fyVr7vdFN6fgo2UUZGE/vT4uUlDgdQ=;
 b=lVDCnFqbZFnTyGYnkfi7e0ol56cwmZaLfYwWZSFMRo+XeSHOhGCNocy6q1IsLr2D0JKQjL+p2
 Fw+sgznAj9rB4j5oylbrg9+Sac01F+R5lYLGmHdxjaQ7LU33PG2nds+
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEwMSBTYWx0ZWRfX08/ZUZNy/Ag7
 fEcFXZo3LJ7cj9EZ747KBRynpWJgAn+DVqzwy0j5xxPr5HOufLofbwTTaqIcZeYR2ndYmBPmf3o
 UEqGs9HJe5BTYemwAYT5SdBbcMJxt8dXfRdY+M30GsvhfkJhzoVzuvuJWjy4jI/VuSXKEK9n53w
 NuMV4okqupfKKohoI2hf6tcDS3Qj61tDaDwj91AjYkvdQuk7GWqi+bPa37QTgFwZWC0oNnJjtbE
 WcKt+Xe6J6KWSjogrK5vgQEy80rRfxqPXMYpVw58afEvNYU8SgC/ytPunAZnE32OXElP+lmdGfQ
 +bPuHnkszXiQ9qqqqxDkKI7VZU72R74agjo6/N1x0JRDq1YlJnFsHd5V9dKeXY9TSGFGrla2xRc
 +3AWb9/Fvq/tgrt3MaCniSCDWnmbEQ==
X-Proofpoint-GUID: G4XRmGzouqsjPksvfc7bsCI7PvyyFJmg
X-Proofpoint-ORIG-GUID: G4XRmGzouqsjPksvfc7bsCI7PvyyFJmg
X-Authority-Analysis: v=2.4 cv=Y4L1cxeN c=1 sm=1 tr=0 ts=6909ee01 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=kXhGf0cxdCgfIYue-YsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040101

The T_POWER_ON indicates the time (in μs) that a Port requires the port
on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
asserted before actively driving the interface. This value is used by
the ASPM driver to compute the LTR_L1.2_THRESHOLD.

Currently, the root port exposes a T_POWER_ON value of zero in the L1SS
capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations.
This can result in improper L1.2 exit behavior and can trigger AER's.

To address this, program the T_POWER_ON value to 80us (scale = 1,
value = 8) in the PCI_L1SS_CAP register during host initialization. This
ensures that ASPM can take the root port's T_POWER_ON value into account
while calculating the LTR_L1.2_THRESHOLD value.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c48a20602d7fa4c50056ccf6502d3b5bf0a8287f..52a3412bd2584c8bf5d281fa6a0ed22141ad1989 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1252,6 +1252,27 @@ static bool qcom_pcie_link_up(struct dw_pcie *pci)
 	return val & PCI_EXP_LNKSTA_DLLLA;
 }
 
+static void qcom_pcie_program_t_pwr_on(struct dw_pcie *pci)
+{
+	u16 offset;
+	u32 val;
+
+	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
+	if (offset) {
+		dw_pcie_dbi_ro_wr_en(pci);
+
+		val = readl(pci->dbi_base + offset + PCI_L1SS_CAP);
+		/* Program T power ON value to 80us */
+		val &= ~(PCI_L1SS_CAP_P_PWR_ON_SCALE | PCI_L1SS_CAP_P_PWR_ON_VALUE);
+		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_SCALE, 1);
+		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_VALUE, 8);
+
+		writel(val, pci->dbi_base + offset + PCI_L1SS_CAP);
+
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+}
+
 static void qcom_pcie_phy_power_off(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_port *port;
@@ -1302,6 +1323,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_disable_phy;
 	}
 
+	qcom_pcie_program_t_pwr_on(pci);
+
 	qcom_ep_reset_deassert(pcie);
 
 	if (pcie->cfg->ops->config_sid) {

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251104-t_power_on_fux-70dc68377941

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


