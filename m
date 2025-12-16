Return-Path: <linux-pci+bounces-43119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0C0CC48F8
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91825300A731
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28213644DC;
	Tue, 16 Dec 2025 12:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LraelETJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SdWRJtTo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3316235CB8B
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765889533; cv=none; b=Cm6NpkT1zf072DpQ2rn0cRD5o0m4FCSYnnd+WLhh4UjEdkdnO/JGDU6ae+cUSVTSTt+3biXFNE6IXmeXpBNLkemHtsklHIV62W7RFYFULnPgXv/T7gS+aNqVJZS3AWqplLlKZ/7RjThU8UWEXwcG8IaVnjLsy1PaNn1xmDlTaD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765889533; c=relaxed/simple;
	bh=hImE7GQrCuzWz+LCETc8MWiZwVHo4qo/PyPQSktScRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNYUVd5Oo5ynrgmYxG+XuwePkcghibKLd+fbR4X39xrP395Um36Sk5imb+9gjWRoFx5qBw2CDjjf0VK+b9ivjh5XSCykRiuN0+W4u/b0h75b/xAtu5V+Q0JdQ2N4dFdPh4uyl2jvW0noQQFibXZIRyDaKvXveBc9tlhmAAVAqds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LraelETJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SdWRJtTo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGCo3eA2869694
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 12:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jy1598yUJqUvu+a7XgM5cYaI53QGia/dl9hRsBk1Zhk=; b=LraelETJ8uHo7rm4
	z4g4tkiP9GsG63ZX40EEg9dp74yWZzTsQxlpy/Wdd7YKtnIxgiljEyrERjtMzRP2
	+N+8951XtOPmYmyZjuMjBRbcp/UWyEuoO68sKZRMevXlX0AmJ08zOvCEGcid957k
	JtTjS4jwxezJeRngiOiuhh9ln5c1/xzX7O2v9xWf/bNru/VGOKkTDAW3T8qwRFbP
	IRiTMUPLOFXV16Fo+eJoVLy/9IdLcSIoilf+H5fRaHzk72uG2FKRjX6cwAugdDP0
	txKVKow35q73dEoYkIVsaGggSG9hs+LRzMsGBWolR389bCIdWp3nwKTuSxhVX5XU
	iCFwow==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b33kw94hu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 12:52:09 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b9ef46df43so4791892b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 04:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765889528; x=1766494328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jy1598yUJqUvu+a7XgM5cYaI53QGia/dl9hRsBk1Zhk=;
        b=SdWRJtToHDKUJnxPXXehCof0yjpAwLxywQzxdghGgJ84FTEpt8OkvaerVd8ZeQMLZ/
         yrXons8Kevo9DSER7ZuKQCNPTryipxAO9e7gaoirbcy22kIYvf80sTqXYkSVV8yJ1OC3
         uEAQmoqyFDZkDCSMRlGJkeCHgwdiT9iAGhR3QArA3VTtSuM1BHwJ4cyAn+YEfoJLWenQ
         1D5M77ewz3kap1DPgnKeE2cFJfFEerAJzCZk8+c9tbbVFYHUAowlLUXSfINACPuPIX0J
         lkIn8WvGVW9yYT0SD2PouHLFnVnPRdmc0SnKy6YbrZkaeWHfKCuJxKevHheYqICkSYMS
         PMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765889528; x=1766494328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jy1598yUJqUvu+a7XgM5cYaI53QGia/dl9hRsBk1Zhk=;
        b=pGqOmIVymYE/qa5SJ66lRsKE/Lx7q43uJQAdCBVlP+bu5Q6fIWp3F3uo/ftMPzqNKl
         OndaxD5MuX5whBPDncrwkjG+GxLqHxRMldBvEdwfQzvslNrVQr9CLxQZjxKo6PJQDnHe
         +UFZTyXPqS4LBpoX/0g/uK9F+f076bhYDmEa1sp4Alce++WOJhMpqVdHcpZHEL/oUtCH
         pgU86fM9N4lChXj3zQ91kxdhQpA4bDYllM/xNimIULV5owgVTIGP7+kKJwL4RQyebOyK
         Uqb7SdRD4c6qi1GltYGQi06ggfOJAwhzvwl8xWr9nUKlro/LUuDUyteUV2voec47rliI
         m6hw==
X-Gm-Message-State: AOJu0Yy8ZrqRf5X/43SLnEOLB0hqR+siJx7D4QTkQ4kouXYcBzQyDf7X
	7oKXzns7uujMjPBQ67TdGES8TpNaVy+N0KnPv4G4GEReJjRx1WVVn+4/f4HRBGGWHdKUBf8Wwzv
	CfUl5+Zgz3dFczVIbb6n3lGq97GWuzvlcwaHqRofonOJLN9QK4WkbM1Uqwcer5mY=
X-Gm-Gg: AY/fxX5+lepmqY5cFGLzbqkVWGyOSQVmZusOtgZr1xAjLChOATExamXlBjzvr4ln7Ok
	ZmwkNRt1iregVWLc2h+qr9oIp4yMUZr6BC2JxK9+Jzezi9ygIcEtcVSvmbkg8IwW30JjbQrPxF6
	zUuhXn2E9kQxEMmqaDXcx0nUEealCzFGE5fBcLyfsiaJd2swyUNzTPPQC2EhQW4cqW4NLXvH8FA
	Tw/JOi1YM+L7WaPYa32EAfNt37YkQub+2q+e4pkNdCfZ9UOYiT+dNQJWaDmmCgDbusS9KRTR5xX
	2FtBeLKGvj3LGXWqG1tVhDu3MeXRu2ADxaYlcQ+oASHa923bOQ3giaWbuJrDoyikSh8CQx+Dfts
	i2FPlnkWhkYLPjHaOrTbX+qI1xYYH852phrdM8k4LTQ==
X-Received: by 2002:a05:6a20:939f:b0:35e:4017:3f32 with SMTP id adf61e73a8af0-369afa0f149mr12539055637.38.1765889528340;
        Tue, 16 Dec 2025 04:52:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjzD7R4uaZ9Cp8BC5PKe+O45asaEaN2RWQgZGhm1UDQOaN2oNuTVDcVsFmdwaYr/60winWHA==
X-Received: by 2002:a05:6a20:939f:b0:35e:4017:3f32 with SMTP id adf61e73a8af0-369afa0f149mr12539021637.38.1765889527748;
        Tue, 16 Dec 2025 04:52:07 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f5ab7d87e8sm13634362b3a.25.2025.12.16.04.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 04:52:07 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 18:21:44 +0530
Subject: [PATCH v2 2/5] PCI/pwrctrl: Add 'struct
 pci_pwrctrl::power_{on/off}' callbacks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-pci-pwrctrl-rework-v2-2-745a563b9be6@oss.qualcomm.com>
References: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
In-Reply-To: <20251216-pci-pwrctrl-rework-v2-0-745a563b9be6@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Chen-Yu Tsai <wenst@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6339;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=hImE7GQrCuzWz+LCETc8MWiZwVHo4qo/PyPQSktScRQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpQVXoI2KPJRcOdMTIipPr6Ud1/OJHbwdy8AEwn
 Nrm5E+vwmmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaUFV6AAKCRBVnxHm/pHO
 9XVsB/9YvZIzl+Mywl3tkwyVsxgkXlZ9ldkwCpfjg+sz0vqfzO5ed+Cs6GDQIu//5Hw3WQcPsZD
 J/8Ef4P8D7KSwduDxa7aVa+8z+iLWcTsbqZjFbz+2nbSCZUqCbkybLtWt72nk9bBLFOJ54y4W2g
 rFINTSID4Dk9sFaDSyBwKHoP4ZIbsRlSaLItUCICHGGpwur1d/88YH2orCf4K9VIETbVa8TCcYv
 ZBMJti2YogCB9erkpZXJDi/Dco5bYpDoWpm7zTmuWmBHomp40SacXsAyyOJOB/DKAsaQRmtTxdS
 fiGqx7ZHW3nT+KpiHGi8Q8rgwUqY2ev0qaVTa3zujXF82nix
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Authority-Analysis: v=2.4 cv=TLpIilla c=1 sm=1 tr=0 ts=694155f9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=wnJ2AIBC+6MZbTdryK78rQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8
 a=awzhGNnQlOWheNBC8EkA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: 8W4ryoxDfZDVbhyTofjipxFHZ30d4cnO
X-Proofpoint-ORIG-GUID: 8W4ryoxDfZDVbhyTofjipxFHZ30d4cnO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDEwOSBTYWx0ZWRfXz+B8kS3fY0bu
 TDjAcSap5NCIE0x8ekJvFDTtENNIPaK1SNCFAFdaICevwWT88xJOc+VzfLcK3B2XbQsaGJYtQZK
 vgnkYUXMyt7XsViI8xBdKmSPXPGVElfkz9jEtNWWmwVPxV9AZjAZSCiY6Q5litSXEDGKsZWA9uQ
 FKb1LI2+c72YvbqrE2GTrlEyYLhUIBv9a6KxEOr9QijaE97XJ64oRmQD1Sy5bc6YYXRG6tT4IrZ
 f+26yHltD27+G7dUoQrAXLpZ5lnRE3qzIo3QhXA5KsqrIY26wfg8G2Zvvxp/WYyvC7RtRBGKwUC
 ZCxtpCWBo8s4pDJsGlaxy7WBmHgJ54N5u+2q3z89UmXiM/2eKHlmor17dSpTwLcr/Reld75knvV
 83mfbdX4RHknxaHak7mpnNyUjSesUQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512160109

To allow the pwrctrl core to control the power on/off sequences of the
pwrctrl drivers, add the 'struct pci_pwrctrl::power_{on/off}' callbacks and
populate them in the respective pwrctrl drivers.

The pwrctrl drivers still power on the resources on their own now. So there
is no functional change.

Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 27 +++++++++++++++---
 drivers/pci/pwrctrl/slot.c               | 48 ++++++++++++++++++++++----------
 include/linux/pci-pwrctrl.h              |  4 +++
 3 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index 4e664e7b8dd2..0fb9038a1d18 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -52,11 +52,27 @@ static const struct pci_pwrctrl_pwrseq_pdata pci_pwrctrl_pwrseq_qcom_wcn_pdata =
 	.validate_device = pci_pwrctrl_pwrseq_qcm_wcn_validate_device,
 };
 
+static int pci_pwrctrl_pwrseq_power_on(struct pci_pwrctrl *ctx)
+{
+	struct pci_pwrctrl_pwrseq_data *data = container_of(ctx, struct pci_pwrctrl_pwrseq_data,
+							    ctx);
+
+	return pwrseq_power_on(data->pwrseq);
+}
+
+static void pci_pwrctrl_pwrseq_power_off(struct pci_pwrctrl *ctx)
+{
+	struct pci_pwrctrl_pwrseq_data *data = container_of(ctx, struct pci_pwrctrl_pwrseq_data,
+							    ctx);
+
+	pwrseq_power_off(data->pwrseq);
+}
+
 static void devm_pci_pwrctrl_pwrseq_power_off(void *data)
 {
-	struct pwrseq_desc *pwrseq = data;
+	struct pci_pwrctrl_pwrseq_data *pwrseq_data = data;
 
-	pwrseq_power_off(pwrseq);
+	pci_pwrctrl_pwrseq_power_off(&pwrseq_data->ctx);
 }
 
 static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
@@ -85,16 +101,19 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
 				     "Failed to get the power sequencer\n");
 
-	ret = pwrseq_power_on(data->pwrseq);
+	ret = pci_pwrctrl_pwrseq_power_on(&data->ctx);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to power-on the device\n");
 
 	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_pwrseq_power_off,
-				       data->pwrseq);
+				       data);
 	if (ret)
 		return ret;
 
+	data->ctx.power_on = pci_pwrctrl_pwrseq_power_on;
+	data->ctx.power_off = pci_pwrctrl_pwrseq_power_off;
+
 	pci_pwrctrl_init(&data->ctx, dev);
 
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &data->ctx);
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 3320494b62d8..14701f65f1f2 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -17,13 +17,36 @@ struct pci_pwrctrl_slot_data {
 	struct pci_pwrctrl ctx;
 	struct regulator_bulk_data *supplies;
 	int num_supplies;
+	struct clk *clk;
 };
 
-static void devm_pci_pwrctrl_slot_power_off(void *data)
+static int pci_pwrctrl_slot_power_on(struct pci_pwrctrl *ctx)
 {
-	struct pci_pwrctrl_slot_data *slot = data;
+	struct pci_pwrctrl_slot_data *slot = container_of(ctx, struct pci_pwrctrl_slot_data, ctx);
+	int ret;
+
+	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
+	if (ret < 0) {
+		dev_err(slot->ctx.dev, "Failed to enable slot regulators\n");
+		return ret;
+	}
+
+	return clk_prepare_enable(slot->clk);
+}
+
+static void pci_pwrctrl_slot_power_off(struct pci_pwrctrl *ctx)
+{
+	struct pci_pwrctrl_slot_data *slot = container_of(ctx, struct pci_pwrctrl_slot_data, ctx);
 
 	regulator_bulk_disable(slot->num_supplies, slot->supplies);
+	clk_disable_unprepare(slot->clk);
+}
+
+static void devm_pci_pwrctrl_slot_release(void *data)
+{
+	struct pci_pwrctrl_slot_data *slot = data;
+
+	pci_pwrctrl_slot_power_off(&slot->ctx);
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
 }
 
@@ -31,7 +54,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 {
 	struct pci_pwrctrl_slot_data *slot;
 	struct device *dev = &pdev->dev;
-	struct clk *clk;
 	int ret;
 
 	slot = devm_kzalloc(dev, sizeof(*slot), GFP_KERNEL);
@@ -46,23 +68,21 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 	}
 
 	slot->num_supplies = ret;
-	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
-		regulator_bulk_free(slot->num_supplies, slot->supplies);
-		return ret;
-	}
 
-	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
+	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_release,
 				       slot);
 	if (ret)
 		return ret;
 
-	clk = devm_clk_get_optional_enabled(dev, NULL);
-	if (IS_ERR(clk)) {
-		return dev_err_probe(dev, PTR_ERR(clk),
+	slot->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(slot->clk))
+		return dev_err_probe(dev, PTR_ERR(slot->clk),
 				     "Failed to enable slot clock\n");
-	}
+
+	pci_pwrctrl_slot_power_on(&slot->ctx);
+
+	slot->ctx.power_on = pci_pwrctrl_slot_power_on;
+	slot->ctx.power_off = pci_pwrctrl_slot_power_off;
 
 	pci_pwrctrl_init(&slot->ctx, dev);
 
diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
index 4aefc7901cd1..bd0ee9998125 100644
--- a/include/linux/pci-pwrctrl.h
+++ b/include/linux/pci-pwrctrl.h
@@ -31,6 +31,8 @@ struct device_link;
 /**
  * struct pci_pwrctrl - PCI device power control context.
  * @dev: Address of the power controlling device.
+ * @power_on: Callback to power on the power controlling device.
+ * @power_off: Callback to power off the power controlling device.
  *
  * An object of this type must be allocated by the PCI power control device and
  * passed to the pwrctrl subsystem to trigger a bus rescan and setup a device
@@ -38,6 +40,8 @@ struct device_link;
  */
 struct pci_pwrctrl {
 	struct device *dev;
+	int (*power_on)(struct pci_pwrctrl *pwrctrl);
+	void (*power_off)(struct pci_pwrctrl *pwrctrl);
 
 	/* private: internal use only */
 	struct notifier_block nb;

-- 
2.48.1


