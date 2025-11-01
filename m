Return-Path: <linux-pci+bounces-39993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 341F7C27756
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 05:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 718AE4E6860
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 04:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C60262FDD;
	Sat,  1 Nov 2025 04:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TuXMLO4M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZHUvsahj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B326E714
	for <linux-pci@vger.kernel.org>; Sat,  1 Nov 2025 04:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761969613; cv=none; b=JIgp3sSF8m3K2hHDvFBOQupxxVjX/B/wyPSx7APtGO+2MLXSCZquZ5vK/XfEtF24bkaid8siL1+dLObo+ABoeB0JdDq2jUqtaf9oRSCokao1IvKHYUfA5yQzxu/XuLCOUPTTh61l77MNTlRkW5Ykws5lIfXWyEHtc7zS3EAiTd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761969613; c=relaxed/simple;
	bh=/rHGDiZUdOdrl9DYepaOQeGv1VtjtTYXi/+ZkT8cb+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z6n243HLMy2x/Jeq0T9K7jV6meCGusHwXDpzKTJgbBEMYavrtyvnaS/ZzMsRcR5VZtuXockfk8i96JdKtTgGxN40a4g+z9RU7dTiMy+n3NtEG297WA7IytNBBsQkMqpORPku5503ktFL/uJsd7J/vHLP88P2pXF5DCMgEkExvyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TuXMLO4M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZHUvsahj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A12Zg19419754
	for <linux-pci@vger.kernel.org>; Sat, 1 Nov 2025 04:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TUun8ttkoQTOkHeDhGd/NSYDbZVcwe4JABD7MBbYCrY=; b=TuXMLO4Mwi+OQcmI
	M6GtmmtWO7xl/RyIJhOXNW5/k8NraVBPmAbcFzs1LpGUCW6X/XAqFgOmP/D82J29
	2MNGsBLpyhR7k4KBQQuSVMApYqYz4xOJYsxh+t0GOc7/u+Q5nm+mO/aC8DsYlgLW
	7K/6ijmu65Ht/Sx00jW8VbIxsvuSLVsHy5p3oz6t9+a+Qww0dphE0m1xLj57fqYa
	L13h/AotM1493JshZcymzKXUquvAq4hl8FyOwj9O4FZgT4qeBTE1lnBakS1zUota
	V9E7sy6ClkN0Is4+vKzI4/mFBRX+sw/ACafGj//B9E5iCqG/CwFn/N5i5Q27QbRF
	ojEYFQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a59hhg35y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 01 Nov 2025 04:00:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-295592eb5dbso1204215ad.0
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 21:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761969608; x=1762574408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TUun8ttkoQTOkHeDhGd/NSYDbZVcwe4JABD7MBbYCrY=;
        b=ZHUvsahjt/knFgGJui7oDPL+E6OmvfRgp1VLICdckZAatL0KWnyq4osHYCLP2/rjsP
         J6pGGXd3g6o4UAjrzE8OhNpdmeX+ILXp4VaYscMgirJSxuDUqFtNEIku7ASPsT+FM4KD
         IWrBtiVNOUUE4T8nYvdpDB7+giqNzT9Xy3HODxbX0044LhKZ8ZH4xOeW2H5j9yfbClip
         zv0te9DMVy8J3siv0fxy2elEF0DRd7j9mVn5kGYNuwFOCF4IdKiOhF+QEefd0PsNT9wh
         Uk5S2/zEMWkbHsjaUlDFHttWK11Wm3j7auuSx+hW4gbgX8d9NbZUrxJrMPzY3XRVoY0x
         xU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761969608; x=1762574408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUun8ttkoQTOkHeDhGd/NSYDbZVcwe4JABD7MBbYCrY=;
        b=kqTQMJj+1ipErIgVgOGDtZlU1L9JOJtuwHCvOAC1lY+j16Y0LIQDHoU2rm//9HcFV3
         kWFsBcGuv3bOapn8cTD2CifbqMjpSmoYMM5ARcxAw3r56oM2KDPlXmBj/t/kWUz0+uDW
         Gz2RWspC29WWo5iuOoP5snTZEHx5un8Xd1yTSgYYS5fsEP9YhAUGlW97fsrX1jRiHSns
         KQmZPZvS8/XHNr9tsDtDClWgLT5cpq2eoDAFeCAj8xxzlhHvbcjG7opchSLQjyu9mjUW
         7xBWNMTqqDNbNEBAJ8ZM9T0J0V6o/fdshTQCQhqTyKy/MOjkeD9RqVX2cOX08xEmXYzD
         g/lA==
X-Gm-Message-State: AOJu0YzTZdcFH0JuGWJ1DA1oVqbKIzDAV1bToIb793Xmdc14TNs+89Qx
	LgJeUpnE24Z4hr1WdGNILI052jL2TxHlE6hZyMqMVk1U5V/sYwotFyK867r1Zu+nAgQiVhqWPkh
	QUNlFr8kkb/o6jTYMG4hNEO4k57Ap37VtXhfpwfAN2mRdpbzd/8X5n1GcikI4skk=
X-Gm-Gg: ASbGncv8MJubsbcpoyWVlCi8Jfm/IQeHLY10pQ/3zFSmEWIQKPC03k0ucYGDhEgZkKI
	onD3bmcc2OjZXhYOInA+VGp/dy+xstSkFRYbpTS1hKacMotCR/J8DlhorPMQGJVS2xyOcViL/5k
	uguIDcARc/OyGFS4+sfB9hpAuw9mkQJXXgJ86llaeUx7F7Qqw7dTuei6ahWCKaQdqNt4/0aVVSo
	KcwrBGSdOdypRJXg4hLky+rysisu0esCru5pCul+eu6soQHI79lKwENlTI0brv3o2hD3T5Fe9l6
	2Tuta+QM2LSNKVzRg0kbPWraX5/zsFqLgfwu7ovs3xvjYB2aamtXL8rmOnaAyIqPToPqCvB62GW
	+DCxTy5AODPzA5G0PCpChvhnjmjbUJQMQNg==
X-Received: by 2002:a17:903:185:b0:290:9a31:26da with SMTP id d9443c01a7336-2951a37a3d6mr76863615ad.16.1761969607641;
        Fri, 31 Oct 2025 21:00:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKAAec1m6KMSQ27zZIpV5w0wm864d/cFqrgqxQkc3z3RS2QIMzPOiuhWEcwaukQDzGofo9Eg==
X-Received: by 2002:a17:903:185:b0:290:9a31:26da with SMTP id d9443c01a7336-2951a37a3d6mr76863085ad.16.1761969607071;
        Fri, 31 Oct 2025 21:00:07 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268717ffsm41490725ad.2.2025.10.31.21.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 21:00:06 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sat, 01 Nov 2025 09:29:36 +0530
Subject: [PATCH v9 5/7] PCI: qcom: Add support for assert_perst()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-tc9563-v9-5-de3429f7787a@oss.qualcomm.com>
References: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
In-Reply-To: <20251101-tc9563-v9-0-de3429f7787a@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761969577; l=1479;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=/rHGDiZUdOdrl9DYepaOQeGv1VtjtTYXi/+ZkT8cb+s=;
 b=Lnb0kzer2s2KLRgW1R4m1XdeYI6aM+xYc3kfH0jbPdg1zODFUgULpywmccRH/RJ5i4TyZrvs3
 TXDDygSCY9mCnIuEfsxGuYCrfV4Vk4yQ7h8Y6FivM/7Si6SgkyZQjwl
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=V6lwEOni c=1 sm=1 tr=0 ts=690585c8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=j2XxTBISUlk66HYKGUMA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: RMjmkQrFd6yhsIEEhXwXNoCVh0oZhXfz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAzMCBTYWx0ZWRfX9MZrNNrSa+yI
 xZpAx5S+BAdIS3Xj7Z/i5wtkyCxeywTL28TfkJWLup7zKX9ZmNTkA0mVR25r4Slec7key1z6iso
 vG31oHt6D6qcrOl4Kh/0SLw9zoLcCcurEV1roLJW0EeFId3xgvEVfElmKiPSeEUnu2ead28ComJ
 YWI7k8mWW54+Ty7GUFOqQBtu7DA9biov97niHtj2a47wfcQObqFu2hGaObfVmpwDsqw8ieFINa1
 ki2cGSSxxsKuzUyxKdHTQutvrKKUVxWwt1mV3z69c9NWDioDeLQWiL3qICcmUor4xKTwfaAPDYv
 tKkiPRrIdc8uVErAj+RGLxaVXyLIQZTkgbx40+WrxgyMOpgEd3ubMKcAkr/YZGJhE1jinGFm6FI
 7s2ZJcW5Xx22yAju3Ru3Eooy9mAOHA==
X-Proofpoint-ORIG-GUID: RMjmkQrFd6yhsIEEhXwXNoCVh0oZhXfz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010030

Add support for assert_perst() for switches like TC9563, which require
configuration before the PCIe link is established. Such devices use
this function op to assert the PERST# before configuring the device
and once the configuration is done they de-assert the PERST#.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 805edbbfe7eba496bc99ca82051dee43d240f359..cdc605b44e19e17319c39933f22d0b7710c5e9ef 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -696,6 +696,18 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
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
@@ -1516,6 +1528,7 @@ static const struct qcom_pcie_cfg cfg_fw_managed = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.assert_perst = qcom_pcie_assert_perst,
 };
 
 static int qcom_pcie_icc_init(struct qcom_pcie *pcie)

-- 
2.34.1


