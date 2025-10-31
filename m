Return-Path: <linux-pci+bounces-39917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C81C24BB1
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD72F4F3D2F
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 11:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095C3346FB2;
	Fri, 31 Oct 2025 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l3Fkzy15";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BTGGtahD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9C346FA0
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909148; cv=none; b=ndWUPICU7cBaVeyRp33ag46hp9g++7qFw8B35/+q5N+uZPGecwjRFW3n0A1YUsAyvtnCo4c4MR3ok4tVwRrvDItIMjbIwkf33a73mq113MGvqUyAkNAm0dOzfL23cTz0cywe+aHb0JknEeu0sHxxWNVUJDx0/8KP3b8qTmiF9uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909148; c=relaxed/simple;
	bh=Cpg3+E+77cgaN8CmBzJQTZxMkFdRoEwVVkKgFdeA8+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MFAtL7E1ledfsYa/P8kPId1Z2t7+1EBfZDT8EoPEgAPRyILn+1/MbJwlSsbvm07xhfaOWfAsLC4jRGaZU0q2Ld8ft9vF7Doj5YNirWXlJM0DTEXZ1FqDtKRumUgx5F64nFyB0OtZlcqYRYmKTR5yy4zQS2ZTZ4XJ7BAeFMuOQA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l3Fkzy15; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BTGGtahD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VA3tfU2558929
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GlcIk8VGLe34WMvbqxhiaOvLED3wY6vnyW7vFGcSUZs=; b=l3Fkzy15ESuU4uR7
	Cgfs8CSukRFuCmycic/BfGA1Srr9AIIvLYW+vabob1MrZTOSdEkhS0ZsaYbltDJP
	8p5+TUo79WNasulbvmoBYhETNE0KINz/q85DqRGvCKQt3QpF2OYvKT/iZ+72SFPC
	7kbzALVNonYZRmXmPSKZSkrfDKvAsTnx/5m/p9OhkkmA26JGEW2ZGGEV2y5an0oh
	YxF++wS7AzXjwUJrPN0LTfkD0dRI1LytLInF0FCDUUSVMKGl1mllkS6O+tn+srvm
	lZKj5EgYB5wBzHpXMxBG74GBndeMSQXBTrVm1OZR68SZWJuvo8AtM7V/HibBkyui
	c2ourw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4u1gr5us-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 11:12:26 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ee4998c50so1560125a91.3
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 04:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761909145; x=1762513945; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlcIk8VGLe34WMvbqxhiaOvLED3wY6vnyW7vFGcSUZs=;
        b=BTGGtahDVgJ+MZ38Ygy+YMRCIDGSylZVblonq/9c5vJuv7TAI2UkAVB2zOU69rwqMz
         NaCJN4ol/yOQr2B7ruZhZ/ofHYUEsgDFJf6g8J5LswZhf3KToKOMZg91YBpYYbOYoCwJ
         YVTP7vk3xU3lIzhodn2xz6r4eGg9zvNIHk11ZMoMh0EXqQ4LkUq6LV6mzWPQgLx8RKg2
         HGGnkj37/sc54EPy68T0CY9VDW2nTdSDfU7K4M1xj5ORqVCT6khEQNyS/1V6GSaSXgv9
         n+l8yPD/7Rquwti/WfbDeXFqBaoy4h+5pm7gVKZbvwXEWnU/VeX7OyPFsfqksVxlJmTG
         gv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909145; x=1762513945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlcIk8VGLe34WMvbqxhiaOvLED3wY6vnyW7vFGcSUZs=;
        b=ZGQWIy2y+pV42zMdN3AmX/93w4Ny9LS1Ba5Du9iX/8r2uxRvTQUK5ZJWTav3QNlTRF
         E86LBael2Zmjv5X4ClztcoYO+ockKzNTdz8LsOSzfQzSOerycYzDhK9uHlja4MUf0VLx
         tTNQoRGV17TRz6o9J+W+iMKEN1dg6Ngh0aa2nIiJVQZGuaJFb+dhQRGuFlFcIKkEoHuK
         RAO/g8X7srIV0Qddyq7/2BkfGuR26ACcIS0uioaV4PJ0nWN0ElYai85AxUidcruN5XPC
         F2IbzZEPyC4mf08J6mQC8xhhHs3+jpUdXTohROq/hFfNNPX5vWGpqlZAXG5SXBBKAgz9
         X50Q==
X-Gm-Message-State: AOJu0YxfMZNbz8i+yf7YpD+NLyE7+ZWnsYTzryxBn6H+YSTf3wi52EKN
	AjHT0k7M/pF74B4jibyXG+oiJAAzwCEoNaFjX5Zh4l5V/b6tbnphFQ1JRDA2H7nuQ3IuOEX1fsa
	xuoAG5/4giND8sU+xrJucKIs3gecYsDnpJt0ixxsDrkaSPnPLbn/YV0rx+Vgq6rA=
X-Gm-Gg: ASbGncv8FKELf20aYtmAUcmA7zDiw0GtFAvjgZlViAya6uqy6ykes6eQ+a/BoqKNPtk
	A1PaRD9Cs4GnllDmyqfrezwoq55l9QcSlbEM/CNYjQwroTh/RGxd9z1iElQ/tbs9LdpGtxGLjmw
	Z4p8hUq2FDpjuO6KWO5Xko9XoTqC3W3glsyo+7EWs+tQ+k2tQSgsCj6IXa18ef/LZYcTooqVVHe
	tVAFyT3uLQ8ztlZAsDRT5Ve1rxM/xFuhqVT8zMu0GuwYAteuYAl+BWxZCRTflHR1A4Tl27BUmsl
	F311UyteVS2Lvd8cBr37uRm39A52jjPHJ1hIEvtryBtHLsxLdf95ep4FhmJD7nX0MR9PJ28JLcJ
	d3uDW0cWTD+cisZh7BL2AEMBF0YRDc81QTA==
X-Received: by 2002:a17:90a:dfc8:b0:33b:bf8d:616f with SMTP id 98e67ed59e1d1-34083055a66mr4429857a91.20.1761909145263;
        Fri, 31 Oct 2025 04:12:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2ST7ootNOsSdE4YhU21tYljL3YrKuXc3saWzAqhR06PAK+Ghh+MoVC+hiJ9vhboqoewtliw==
X-Received: by 2002:a17:90a:dfc8:b0:33b:bf8d:616f with SMTP id 98e67ed59e1d1-34083055a66mr4429812a91.20.1761909144819;
        Fri, 31 Oct 2025 04:12:24 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d7793fsm1887363b3a.25.2025.10.31.04.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:12:24 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:42:01 +0530
Subject: [PATCH v8 4/7] PCI: dwc: Implement .assert_perst() hook
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-tc9563-v8-4-3eba55300061@oss.qualcomm.com>
References: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
In-Reply-To: <20251031-tc9563-v8-0-3eba55300061@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761909120; l=1221;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Cpg3+E+77cgaN8CmBzJQTZxMkFdRoEwVVkKgFdeA8+8=;
 b=A2apmLQWjrpCddCAoBMYspOGbY1QIo0TDIIU1w1angVGKY6uhitwrodwrhHFadFXP76rvNBG9
 lF0Z9T/66d/CNKEsVM2Flb0Jry7Ll4C5n6750sqoZXiAgJw3h21j3OJ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6904999a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=dSOQ3hK3KXaY1HoqDbQA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: AITUldsMMgr238pB2SbWAzK_Sw3MjLKr
X-Proofpoint-GUID: AITUldsMMgr238pB2SbWAzK_Sw3MjLKr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMSBTYWx0ZWRfX7lMBVGGZTsOC
 Gk/+5O6kff5QHs1e+lmDLhTut4J79klLH+dYZcFkNT3ZKD3vPYSorTuH4vlOBwq+ZYNDbLUVqjN
 tq1IR+ZDXlFu35r/7AWfzhcYHM8T/K3mL4bb9uloH0Cbckt+oU5joL6c9vVTCw8xqbjUvN2w0Yh
 ac9UPDvs/RHVAAcERI3KLqveDwnjLLp9wBk82R7GwjjiGkMVh5Ikyk6I2r6139GrNKMZEyVMpMY
 s2VihX85niB9q1d2AX6AZtyddkrFDCHS2DxD9u9nqqdkvcvhK6npb9/8KWzwwdabJFEP/EgmcKX
 tFOP2aLPtzgzGDnG6pmMXxb1OKSIwioUvqIq/OP8kKmXy0J/r8TZl+5pHFt5Y/I74sfGfkEPUEV
 nX2krXvDOtWNsN7Cqsxnaabpz/hsrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310101

Implement assert_perst() function op for dwc drivers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c4812e2fd96047a49944574df1e6f..b56dd1d51fa4f03931942dc9da649bef8859f192 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -842,10 +842,19 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static int dw_pcie_op_assert_perst(struct pci_bus *bus, bool assert)
+{
+	struct dw_pcie_rp *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	return dw_pcie_assert_perst(pci, assert);
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.assert_perst = dw_pcie_op_assert_perst,
 };
 
 static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)

-- 
2.34.1


