Return-Path: <linux-pci+bounces-40675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97766C4525F
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 08:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B2E24E82F0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 07:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F84A2EAB79;
	Mon, 10 Nov 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LVVCGEb2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SkIj8Wz1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9262E9ED8
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757989; cv=none; b=Q9Pp7hAJA6VY0U3o9atWhKa5LWthkdMxRfRrhsjrQRVf0JGoi2iEonsHF1NiiaSyaPGQrmyhMptj82a2q8wL6u3E2by2FPcTMSUMvhYaKO/A/eb22JuWFNROtMgQdPHOqDCxR1VD2weHBFij494J8eWA0IlJTrYEdCBaaauxVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757989; c=relaxed/simple;
	bh=/U0Ja6pIIORCOrQm8/mm85Ss8jUcFZsmQzXcPppHTe0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tgSBhCQJhNTiINl3EiYsr3L+v07zDQc5etOnvhF0zrdX3hp+4wSWTdUQ9ljcoYcGq5H22kk79FXrcpe1iq+G+JmoSoSUJxJPAUSOGQPJJTVNQrzFg+ZDkPOJDqXDuzkp+5DMAg3jcwsfIPT38eK8wmRcsMCe8z8LPYfnogsZ+Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LVVCGEb2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SkIj8Wz1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA3jphu2546973
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QvbETnacGfv8HxOpAO3p92SNgsFELgIWPahl1X2BsS0=; b=LVVCGEb2lExbULwv
	Ql5On2P4JxdS0JsLIGNGxJeRs3apIJksLIBtWxxholRQnBwXgLyXK+nytHWX4GyX
	p9LUwMXBziGFYj3ZPWQ4jebiW8fGhWSyrGkhiMJid/NQXE5ZgRkI9nx/UKo69SDQ
	Y1gHDWSGfSy4SC1XnbGgGAvuzAYdCyrHW5haz0Y+kaE15Ae33osH/aakXB7HDazy
	Ul6IWg3IYWeZjFr31hckl7U8o1zxX37eTIkeVVynnk28eD6RVBwfE7pqF2Dfp24o
	GlB8G6pZkZmgAXZdJAK9XhHCp/mW7BxeX9hZoZb4wG0JVPJr6+X3aixFhQBbqCNQ
	YRX5Kg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab8ea8cxf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 06:59:46 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7b0e73b0f52so6429788b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 09 Nov 2025 22:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762757986; x=1763362786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvbETnacGfv8HxOpAO3p92SNgsFELgIWPahl1X2BsS0=;
        b=SkIj8Wz1mRaRoIl/G2rg8/jYtKCfz5vQFCbyBdtg4Gz6j+qfrtAfhWdkjf642TTF4E
         4a7ZDhAYbBn/NDpK7sRLrywQc6RIeUP4HW/dA46Bbe+GA8sJEgXGF2HEWM5qguC/CP0c
         vAJCwpnilslTwJU/rHlVRNaTHHKRlyNihYwSpWKK3mWiDGH4llFaJ5qZLpsxzcMS9d1F
         3rO5CCRVGR49ke9TvwST+pQttIsFe8RvxOyM2AkiRE+HVO4a54BL+J+OU4Fh8P8iRb4a
         LH+NnW3StjcDdP8rC6N08hHLsfmXVFaW+Xo1ypiciYqQ67NiorQ7CCxnV2mE/iYDvYbQ
         sGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757986; x=1763362786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QvbETnacGfv8HxOpAO3p92SNgsFELgIWPahl1X2BsS0=;
        b=J246QbcscGcoVLdyoeJNuGNmkn8ni2cWaUQpU9bmcroNvWl9pEc8HPp+jDy17QZfor
         8dCQeShI3baywzTvfy2czoulDcMRBuPH0sb0dXn0xRpNBMH2I2YCuc/jnJ/D6g7C/3Ww
         K0yTuhxOYGbL1ketnGvH5mGG0Psz27oc1o3F73G6i/2C5qWkrzPfn33BON/R4QRidbr8
         M9/8TmQAsCwEcBXqcg4zza2usQk10qjepdvDuTAiyvpJ1iPgMT1NRFCXe25eiZAvjCrD
         XGmfuINtSLZzUWGeBHRDeRxLHkpxVakUWlUwNUJGHdwqjSj98e97Rt94ds5/Uz7K3WX6
         e6tQ==
X-Gm-Message-State: AOJu0Yw9e2zQLKm6Nii2XYPl0Al8vnKrrJaG05p0+Xzb+C8Q+UJw/JCj
	59+jXQYUixoHQ3Lsz0QZHo1dG3eB8k9algg1nbClA5y9wOADPL+eLQnw0JnkyTt/bsdHQa8ssVt
	3bxpX5g0Q4/hELwKgd05GMa02VZT2ml1hp/olQSmpEOBPlY7iFQ7v04JyNBqnhZo=
X-Gm-Gg: ASbGncsOOEyV8W1CccTLSf49kwFWoC/GxmOiReM1axXReUpaQTEOFRDCRM6jV1JkuPl
	hEH4L3qEUOVOrXNqMjQbJeYYMc8MXkBFg629RHqnuwYr1BHRlWcJMh5vC29gGlZQmqntW415n7N
	Aifc3bWhZSOovr6o0bvSZGKeL5iL23bXomd0+vb9TwmdRfjTSkaRllwtKmMggE+ExderSu4FIrJ
	Cs3PrU7drd/y3RxsBALur+H0PiirpWpDTlqMHKM2TuG4xgss+E76hnAG4KjbC9QMwY1tBWx+Beh
	olmLU4nMaDYQjj+If8V1Ev6+USZ0AB0OcH6lmIxK3fOuWIyprycacSfVWLwtFcb3GKOHJ4mN2+E
	Q95v8qQjv9whlz6MjMLOgGpnVFIRV9ELcqlD76iDHlhEoGw==
X-Received: by 2002:a05:6a00:c89:b0:7aa:bc48:abbb with SMTP id d2e1a72fcca58-7b225ace559mr7802738b3a.3.1762757985885;
        Sun, 09 Nov 2025 22:59:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaBsucwcRdh9oZNvURQRWiMHgCL35FCP5RKbbm5wnKQC6rj0xWFwVrUJZef5dZ9I3V5LuCQQ==
X-Received: by 2002:a05:6a00:c89:b0:7aa:bc48:abbb with SMTP id d2e1a72fcca58-7b225ace559mr7802716b3a.3.1762757985389;
        Sun, 09 Nov 2025 22:59:45 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c09f22sm10565900b3a.20.2025.11.09.22.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:59:45 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Sun, 09 Nov 2025 22:59:41 -0800
Subject: [PATCH 2/5] PCI: dwc: Add new APIs to remove standard and extended
 Capability
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-remove_cap-v1-2-2208f46f4dc2@oss.qualcomm.com>
References: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
In-Reply-To: <20251109-remove_cap-v1-0-2208f46f4dc2@oss.qualcomm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762757982; l=3697;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=/U0Ja6pIIORCOrQm8/mm85Ss8jUcFZsmQzXcPppHTe0=;
 b=J3FlWgLvdMzH2W746W95HHPNs+PK26TKJTJHqWKrZqsn14ptsuYN6yaflvHQCy/9ZBKICutuc
 dok8bavnWmTCQriP78o4FiLLIG8BeUmea5duUp0oB0jyo1dWjsSj1BQ
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-GUID: BuhMVhk-IVCDXSkkzLLtAStNsJwko5jE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA1OSBTYWx0ZWRfX2+14+5WOQKfi
 8WQfjP9dF8Gnw/5Jvdte27zLHhLwHc0hGuvrz/HdN6slcQ7GBepEaABgqqOWls+E6+6TYptIk/+
 C9ugs25vBC1h38h1KsD5/ubxUuHiCO4wQ1mvtex4M2RpCpEFf1WKi71JoU+pIJYqAaWq/ZCRO0v
 EyesDazQoU1jZzd0nRLG/f2SjBg1sHJcdOsgSEBS0jLcoDCGWGXY+Aa4ZgvYX7x+NXEHsQ53KXS
 bU6J9Cas73A69VwkGkM9GzwbPyX3KeYeThsVZa9cZ0DNGx/XUneB+AxUqMwjG817rhKAkHns0VA
 XC5yt0YscIlJ6rt6a22tAm10UVCsERQnxLZNxtMtf5De4Bq4aVPQzEMu6EZgNHCxk1xBnHFH/vM
 n2BK4WQRBs0ZYZnCJWnx/jM0hbzUnw==
X-Proofpoint-ORIG-GUID: BuhMVhk-IVCDXSkkzLLtAStNsJwko5jE
X-Authority-Analysis: v=2.4 cv=QLxlhwLL c=1 sm=1 tr=0 ts=69118d62 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=keqCWTWlQfiW9DbH:21 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=x49saZnIPM4AqZOLoEoA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100059

On some platforms, certain PCIe Capabilities may be present in hardware
but are not fully implemented as defined in PCIe spec. These incomplete
capabilities should be hidden from the PCI framework to prevent unexpected
behavior.

Introduce two APIs to remove a specific PCIe Capability and Extended
Capability by updating the previous capability's next offset field to skip
over the unwanted capability. These APIs allow RC drivers to easily hide
unsupported or partially implemented capabilities from software.

Co-developed-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 53 ++++++++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5585d3ed74316bd218572484f6320019db8d6a10..24f8e9959cb81ca41e91d27057cc115d32e8d523 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -234,6 +234,59 @@ u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_ext_capability);
 
+void dw_pcie_remove_capability(struct dw_pcie *pci, u8 cap)
+{
+	u8 cap_pos, pre_pos, next_pos;
+	u16 reg;
+
+	cap_pos = PCI_FIND_NEXT_CAP(dw_pcie_read_cfg, PCI_CAPABILITY_LIST, cap,
+				 &pre_pos, pci);
+	if (!cap_pos)
+		return;
+
+	reg = dw_pcie_readw_dbi(pci, cap_pos);
+	next_pos = (reg & 0xff00) >> 8;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+	if (pre_pos == PCI_CAPABILITY_LIST)
+		dw_pcie_writeb_dbi(pci, PCI_CAPABILITY_LIST, next_pos);
+	else
+		dw_pcie_writeb_dbi(pci, pre_pos + 1, next_pos);
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_remove_capability);
+
+void dw_pcie_remove_ext_capability(struct dw_pcie *pci, u8 cap)
+{
+	int cap_pos, next_pos, pre_pos;
+	u32 pre_header, header;
+
+	cap_pos = PCI_FIND_NEXT_EXT_CAP(dw_pcie_read_cfg, 0, cap, &pre_pos, pci);
+	if (!cap_pos)
+		return;
+
+	header = dw_pcie_readl_dbi(pci, cap_pos);
+	/*
+	 * If the first cap at offset PCI_CFG_SPACE_SIZE is removed,
+	 * only set it's capid to zero as it cannot be skipped.
+	 */
+	if (cap_pos == PCI_CFG_SPACE_SIZE) {
+		dw_pcie_dbi_ro_wr_en(pci);
+		dw_pcie_writel_dbi(pci, cap_pos, header & 0xffff0000);
+		dw_pcie_dbi_ro_wr_dis(pci);
+		return;
+	}
+
+	pre_header = dw_pcie_readl_dbi(pci, pre_pos);
+	next_pos = PCI_EXT_CAP_NEXT(header);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writel_dbi(pci, pre_pos,
+			  (pre_header & 0xfffff) | (next_pos << 20));
+	dw_pcie_dbi_ro_wr_dis(pci);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_remove_ext_capability);
+
 static u16 __dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
 					  u16 vsec_id)
 {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ecd10130d3be3358827f801811387f..b68dbc528001b63448db8b1a93bf56a5e53bd33e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -552,6 +552,8 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
+void dw_pcie_remove_capability(struct dw_pcie *pci, u8 cap);
+void dw_pcie_remove_ext_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci);
 u16 dw_pcie_find_ptm_capability(struct dw_pcie *pci);
 

-- 
2.34.1


