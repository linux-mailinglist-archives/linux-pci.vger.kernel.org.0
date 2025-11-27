Return-Path: <linux-pci+bounces-42214-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B42AC8F497
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 16:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF31434EFA9
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 15:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7184F33769C;
	Thu, 27 Nov 2025 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R8cLx1+r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ay+tFXHV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6D63375A4
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257485; cv=none; b=igzyOGNbrp0Q897vSCGvPywq9cmqyLhjV0jw33Xu7NQnnP0k4IHwvpwUg88009PNkVj3G7IHFEhwOLrAQ7tWHQh7r/fxiWZ071YO874esEw347nhPLGXzgtzMX1PvOFmFRXQAjN1qHOnBKxZyVym4PaXi1+Bg2JpNAd6hZzkyTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257485; c=relaxed/simple;
	bh=Tktq60NusPXL17N9tZWDKQHun91n1Lxa+GBNzW8axvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rM/fX73ztGgyC2OD3Oe0cpFGw/d+O9M9O09YXcqJBBeRXo4ojKyWIqKp0CIBCglkPrCmWEW5hoNXn5ACt0isttGpEMzJIBMV/OpxdaHCY4DSjBqGhFouEz8WkBZ5HIJmAMivNnwOmZK97IFAUtNknsT9LnmG45a4hVuRQIaR698=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R8cLx1+r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ay+tFXHV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR8sbm41668527
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 15:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eRppFPSWTmE4OfcViuVyX037cqqE/RI9YqLW5Ngzcs0=; b=R8cLx1+r/dSbwZZ6
	MBbHJD/7212ZjHt8N9OKpdHZDJxUQ7tFmwAWSLwqsDCbCIAEVGazMNNbcWVneHS2
	V/TDsBOAvBwaIj0VDDYWf35dZ/coGXCljXeDieBifQHY51uulfPKRBw2fSGbYvns
	/Dm1L7wx6c7AJDeFcHenI/PYt4InfwNfLFSya6efFpC2LEinMdCPI037fRoYwqY7
	pAb3vhC+txlvENlS16DWO1TkIz2YD33v83ipvl+UXW6Azj4BExd2KvUL6GUrR/Ej
	LHLGSEpV2ChY1plmhvWosgmxgcg6UgpkWtxVk0u8EsaJQPeRM9SR0mpxnsTM6PP4
	42jqdQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ap0bmv6vs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 15:31:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340c0604e3dso944300a91.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 07:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764257482; x=1764862282; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRppFPSWTmE4OfcViuVyX037cqqE/RI9YqLW5Ngzcs0=;
        b=Ay+tFXHVzez2ZT6zo9IjwspJVTWF2Sdv6hhKUwWii9bvStZgVIOhrJGhsUwp0vH8Mq
         /JC5tZ8H6WwkgasLuoKWk9n4gJCpKDeDaJQ8mFB1eSDw21l5QRMQMT/oZxVJe2y+yWcY
         WZvOa9pWjshLJutzEMqgxxpHTw+aWV0yH9bsWm6+CPnz721VTBtsC5gc57o/C9VZeNxF
         1diEMfFbHuzJFH7509zOEr/fHZxU3fnMDBjRiDnYdCfUfPZGEoIBp3oU/RLuQglUja3m
         X4yOXVQNqs43xxRKiZ5avtaqD6i0nlZFduwbq4VG6qCsH0kutK23Q5+yAwmj0loQRTJj
         xCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764257482; x=1764862282;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eRppFPSWTmE4OfcViuVyX037cqqE/RI9YqLW5Ngzcs0=;
        b=Kn1anFD6RyLtC0BO2uJrBrY3qfnveO6OhLCon97lo02Is++KKD3CFQzM34OCQBq4Pb
         Ay0vPqdrVPi4aDaVW5+3v5UjdxX6Uc5zQ/DYb9B2T+BXDOPy0xjUd64RGvf3P+NR4Nij
         zma///8b+X0baBSnnMaj4Lpz2P5SM5IoRR+3Ei4lb2sFhy84+OH0WmJTH0wCgXi6MeW8
         9+wQsBKsM3faHebNqbtlepurBhMQJ7/ekrHbsM5Qqz/VpZ1U55kDOMz9U2N3Qm9bJll5
         PARnRWH3TgzRSQ+0XRWhGq8NSrtVnjOgGt9KCR29duBVoUhNPE0S6UzjvMYVafy9ZL2R
         PWTQ==
X-Gm-Message-State: AOJu0YxDrknjXl6RJHIYImCuIkP78mXAdLQskFquqOYY2pvZNvh6us09
	6lqg+RPs7po79E8QAMYZ2vBms6cj3URnFiMZtDKBwErz3ScZ8jQ3C6coFGbZ+QAMp17URdY5+TV
	AMfQhPTS+0thOBDcCwI245tCQqIesxZrDmvbnqs1ZNDMGQOVrQQSu0Ywy3oOXWfY=
X-Gm-Gg: ASbGncsz3PUgYDMvJ6Z0nqgVXFW60B3Jn4bXCJbPrsXRjopyBgubg1aT5jvPDJW1k7Q
	p+T/VBJNcWOVefKq7mASgfVclwaOWGeRJKgDFiMdC4xiPDyogeMbJ9M8oPnKkg+tg2YosUiRoEb
	4/y7AiPV0qmp1UdM67TzkvXzIDdsDtxWvJbtoizV7mrkaNdOpDUaNVShEPzCQngSZHbykwkxxXj
	gk05lh/akrshFn/YzA6j7zyfa/yCNmKMThZJpr316bl+whvYwh88QeVEgY8oKn3qs6iwblyoBkD
	CjX+XhHyrpqnRKGGMaNKXpx7IFxa24gyKGbJ5c3lzMAlcBOniqHzFII025uoLJNu9gPtAM9A3QK
	Nzr5zYEnrXULyoiBZ7pP4eT97SS/kBVtPYqu5XugDvs/IyQ==
X-Received: by 2002:a17:90b:3b48:b0:341:c964:125b with SMTP id 98e67ed59e1d1-34733f4ab3fmr25684544a91.31.1764257481999;
        Thu, 27 Nov 2025 07:31:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE62nvOTPLWq4/4MMTiuik/DAtIz2Cb1ehcyD2vsKQdu4aPIQPpB26ntbsewRJ1yYMcmJQ1HA==
X-Received: by 2002:a17:90b:3b48:b0:341:c964:125b with SMTP id 98e67ed59e1d1-34733f4ab3fmr25684505a91.31.1764257481510;
        Thu, 27 Nov 2025 07:31:21 -0800 (PST)
Received: from hu-sushruts-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475e889832sm3592940a91.0.2025.11.27.07.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:31:21 -0800 (PST)
From: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 21:00:51 +0530
Subject: [PATCH 1/2] PCI: dwc: Program device-id
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-program-device-id-v1-1-31ad36beda2c@quicinc.com>
References: <20251127-program-device-id-v1-0-31ad36beda2c@quicinc.com>
In-Reply-To: <20251127-program-device-id-v1-0-31ad36beda2c@quicinc.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764257471; l=1886;
 i=quic_sushruts@quicinc.com; s=20251127; h=from:subject:message-id;
 bh=Tktq60NusPXL17N9tZWDKQHun91n1Lxa+GBNzW8axvY=;
 b=31dK5IydddpHmltXOHFkG0DMp+UBt04Ba59rfLykpXqXmwiTEEZAC2cv2GrB2jMOCXSc2m/O/
 70JPiTYXNyLA2sWmIZaNvHb8rrZIky1yeHGIyW6Oywd5V0nMSekxROR
X-Developer-Key: i=quic_sushruts@quicinc.com; a=ed25519;
 pk=OrUHTxBaSg1oY3CtCictJ5A4bDMNLRZS1S+QfD9pdjw=
X-Authority-Analysis: v=2.4 cv=AKyLkLWT c=1 sm=1 tr=0 ts=69286eca cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=k65PBKbxA0_g_y9gc8oA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDExNSBTYWx0ZWRfX6FieI2UjUE14
 4ElFUzcwaom//LnK7huy9P+2shnzwFahh2jVy5sBQRCA/dXrNXIch+FfmZ0FnRvEqjvf0WrQ584
 Ph/Q5ZjQQ4kxQaXyXrBoskk2V+kki2qAnDMX5cz2ww9ZlLN2EkA4WaIjU9jzfPWalY54EE/zgV9
 eR1nVPiy/eS8Ts/RVB3287NOX+p85mPLi10450lpgylLe/K/SKE6YGWjGXXvbZlZA1ATDt0IEII
 96iFpzjGi5yplLz3g41zjm+sJUX1CRQLr2aqd3nMPyrKuwYlsk62gpkjf72zaFvof8rObU+C8vD
 UEmvYAMX6hZq9PIsGCt66UsQEk5d1bfwNHnwUMBFl3RNe6t2Ay1XHri621qX+tAMGkLPntQX1Qw
 KGbvX4T9S/KxHOElhPGf0BooFXbbDQ==
X-Proofpoint-GUID: SIR75cnwjEBChL-9Axz5sVsO0G2P2335
X-Proofpoint-ORIG-GUID: SIR75cnwjEBChL-9Axz5sVsO0G2P2335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511270115

For some controllers, HW doesn't program the correct device-id
leading to incorrect identification in lspci. For ex, QCOM
controller SC7280 uses same device id as SM8250. This would
cause issues while applying controller specific quirks.

So, program the correct device-id after reading it from the
devicetree.

Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
 drivers/pci/controller/dwc/pcie-designware.h      | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e92513c5bda5..e8b975044b22 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -619,6 +619,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	pp->device_id = 0xffff;
+	of_property_read_u32(np, "device-id", &pp->device_id);
+
 	dw_pcie_version_detect(pci);
 
 	dw_pcie_iatu_detect(pci);
@@ -1094,6 +1097,10 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
 
+	/* Program correct device id */
+	if (pp->device_id != 0xffff)
+		dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, pp->device_id);
+
 	/* Program correct class for RC */
 	dw_pcie_writew_dbi(pci, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ec..eff6da9438c4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -431,6 +431,8 @@ struct dw_pcie_rp {
 	struct pci_config_window *cfg;
 	bool			ecam_enabled;
 	bool			native_ecam;
+	u32			vendor_id;
+	u32			device_id;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.25.1


