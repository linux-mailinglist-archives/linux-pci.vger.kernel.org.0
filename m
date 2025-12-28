Return-Path: <linux-pci+bounces-43776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E7CE5318
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 18:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E26EF3006E38
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D4C21771B;
	Sun, 28 Dec 2025 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D7iSvRsh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kok7xKeV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431AE1A285
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766941301; cv=none; b=IWXT0m+XdoY8w5Et0V8G2MpstMEKnk8U1OeV3eAmJ5Kp7Zex5DnggOwCR+aIcjTkl9t5iaf0fLiUKgz2eoKeq1wz3NdUe7bU/iDu1n+QihbrlYgsOjNVjJrxVzwmK1MXawBpXqhp/1q4OhzW1gAR7TEk9MwDHBRWtkeF+Mi9CZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766941301; c=relaxed/simple;
	bh=AO6DA+THdUbk+4mox05j2FvqW5j/957nknRRq0lgeZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MK7JZxQpocFOApLxDJ5hewRYqxr6syEOkcHJNdnqWblhnZ4TWGr+A7ZJKwA0mJTFpx4WWgVKLGXwxDqGj5IaH0rFlzlSOsxRW56YNdgh8YuoHMj4MZrD602QBI3liMsaPgmjFN5NPiBw68UD39Vvd3rB3D8ETV0PZmsQG6BN53I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D7iSvRsh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kok7xKeV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSAuMvR2801368
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 17:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O6Foh2+wdOecjl7PjsSTEaLNWnsQbdXhe0iMFqdYSf0=; b=D7iSvRsh2zi2RHRB
	YdhRbbAsKM+FCVwdFmbtkMp8WVrH54MNO0OhotvUJEYUHGrQbVcKP4HgJYTqdukM
	WCDWxcg8IhNZdsG/lIpjJJ/oLC5SF+oPu/4N4Croi4TFdmiFPzUrpSt4iQCuLkdi
	nHSzsKV74zH4gt/ZStiXsnoRO/lcQUEh5peuwMT7TCQj8jVEKHopc1wzETNn8wkW
	k4DGEEsqzLOooA3e4nS3vTxRmzhGexjDP4Moe8F7TSutDAZ60rr3kP1Q29foS4R6
	xzaPfOoKdnwc8zKtlMKot9Hdz4S/UuuCt074oK0xTTcwIPbK/yeUHat/dKIMfzPt
	pRkJgQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba7u5je4g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 17:01:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7d5564057d0so19932884b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 09:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766941297; x=1767546097; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6Foh2+wdOecjl7PjsSTEaLNWnsQbdXhe0iMFqdYSf0=;
        b=kok7xKeVNa+li7M25Kbc+uNo/MTtF8pPjVsuNHUCvZyGLXUiv97rDJgFaouvPz3lQO
         7bZlRrr/r7VSUs+XFdROpg1EQqHp9QRr+b6OKO4R4OzMYzl9V3GQh/SF6l45fDx30ORo
         CmTr9rM+hjd6bJ1gCbtUAOZXrGdLTBXr9FOqhI0xurln2nWXHiA7W7VvTLi1oLGt4cgt
         wqN76QjfNW3HvC8UvuN5ENX1qsuTgnLlhlSthPZP7J0sWaDL6hhGPhpcNroLSiuWkn3T
         rNSywM6MsEUQjAyxvLeVP9U1GJRL9qirrUMtOgpo05LauBT/4rT3ueV/XwkFQsXhEXd1
         Ns+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766941297; x=1767546097;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O6Foh2+wdOecjl7PjsSTEaLNWnsQbdXhe0iMFqdYSf0=;
        b=JPhaAY8fyPfwPJZ8tNtEG/GG0xsPD3M0S26FItBo5h074+W+kOcqbJwNfwz0hnZlsP
         LpwZvyS9i8QAS+NcrlKaSifudV5087DwHpuAfI0AtregdaJns0/yJHWLdWAZTjPWMCMI
         ZTkB4bKusbyNn+8sneVXvIWHSrtf8Y31rIrhXMCOKOWC89qf5vcyoJcS1nz4sVrprujY
         LOCT2wHCXcMI8/oYN1pjOcSBk4VIX9yve6YVpJAXyKsKiKmt8+gM6i52YNiGo0jhSBDj
         7RnYiBgTh1/ufdNM/pwF1eyNysnctZ5N9Ek1gBzU0W+HrV6dnBbTXyKBtFE79jWR7d5v
         R78Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcl3Wtrmg5iTWOl0C2gBi+0wMmcCNHXOjvacL6ds7gxgLPGk4SXYxkAt6lMo/hDNeUlVDmkwocgeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNAirWHz1f+4eIIXFqOQySybF3eGMfzjif3jLeay/WQHBYFJC
	jNw1xm+K1KuQNSI2NNH0aTNbBzX3c1g9i+1ISU7ydKuL88ZGUi2+2GlYkalhXDQGJ8nncKPYCdc
	1u/nyNSYyKGeIUMco1GCPHtwqBHDHhHlWBQXKbtKGRtE1bkaFLGv19/ngUfetkVI=
X-Gm-Gg: AY/fxX7fMq2QaCyd6CDB0FlyRx84b4CvI9LQAUGLqwt2FOFgnAUhcU8maQC1BkWKv+/
	RhcBHs5VOd5lN2C/KP/ZOe3HKYwjFonY/O9so+4K9d72yg7Ouu5s4t+W2Wf7zrpb2Q2cFHp+5eR
	IX2btc1Pzgl6iQBRrR+YsCU6hkjAWQZzF8Djj1jRobC/Ca04oAfKZstUrHwDXamVLSlYggdKXE0
	hCHKXxRCsvaGeKfUBFXo6MqijrkAt0lnsijftTc8CvIGtjfFqIUKSMRmJwWtvzolS/qKtkB6gJ6
	s41vDREUuIIUeXx5hmV+NpvFcDXd48+Epp1+CQGEE70M0W+HiZNQA2OksBVLVh6L2hl8MNdcNKR
	jhs33AIvzIxgxUbveHezvWeobEqH7apKW7Fg=
X-Received: by 2002:a05:6a00:2c86:b0:7e8:450c:61a8 with SMTP id d2e1a72fcca58-7ff6705c5b4mr24960225b3a.63.1766941296888;
        Sun, 28 Dec 2025 09:01:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiAFTZ8ex25xK3kPmcrFizu8q326IIEvwoBzq5IZ1fWaQ27rEXg5Vo2OhiV4GIKFe3bx9oDQ==
X-Received: by 2002:a05:6a00:2c86:b0:7e8:450c:61a8 with SMTP id d2e1a72fcca58-7ff6705c5b4mr24960193b3a.63.1766941296368;
        Sun, 28 Dec 2025 09:01:36 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:90aa:5191:e297:e185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7ae354easm27053925b3a.16.2025.12.28.09.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:01:36 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:31:03 +0530
Subject: [PATCH v4 3/5] PCI/pwrctrl: Add support for handling PCIe M.2
 connectors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-pci-m2-v4-3-5684868b0d5f@oss.qualcomm.com>
References: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
In-Reply-To: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3872;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=AO6DA+THdUbk+4mox05j2FvqW5j/957nknRRq0lgeZo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpUWJZfNqK+Fro47r7/XxC1e1nbiRuyWbDsEZNP
 d/8r8W/zyCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVFiWQAKCRBVnxHm/pHO
 9e5eB/4ud4BPdyBhFUZ/uAfAI8eQV+h6yOv40h3VlyX4wvbAXOpu7EM9FDokADrdtrwpQqLySLg
 qJQhF/ls5tL9Ewxixulc0x0acUkCIgNC98lKgoyflgGw5mjMbnSo9lx3kgY5ZuhzRaEBdQr4urC
 kCrOIao3W0C2GQrObc9n2NNG1jMeKaYw/rEW+K05P3QP9XJyTpx3MOWbi9DSOZiRAGzldaq+Zxh
 OVEZIriC1nVan5rwz6QNlETpMaedl6ckZbx4tNJyzr+AeHQ4k7zI0FmRWn/T/4UCvD/LXGQaf/B
 WGgjdfSxBV3YFXkS3k60DrBlvoHxXfYBoF68St1spm/MglcA
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: pF_ezNVhEfUp4_C6spsfdjs9GhtfqBY7
X-Proofpoint-ORIG-GUID: pF_ezNVhEfUp4_C6spsfdjs9GhtfqBY7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1NiBTYWx0ZWRfX0pl9c27PmeMv
 ni9OWMVtMSm2N4AcVMAsmOdgTnbVmeo5PGMVwaNajmPSaSQw3eCB94OtO0r39nOdX6EZueqNr6j
 jKiVKpa9abo88FZMp1omgdbJLVuON/DX1scVCMrSC63pcAuXCWJA1AX8iTvncpvRZOk9g6YNj8p
 CaW+rSGpeT7sPDOHT2aVePn/SbfRfm4kG7MDN4lW+I2bg4bZ/Ca/A0TrveGMgiy304Qg7EjVVsg
 U/GGxJSZje4KIZznWve7P2lJ4BYZ/3j9GCeRO/IHGtAiAdUMlmg50uLs8gP3RPl7ci8JE4idBCW
 qolt/xx059n8t3kr8HHFfbdiBBNmUp7V+OgjaAwfS3GTBzbTgMxf1kfMULsYqjNE6XJKmpZ+BvF
 ZRnMgUDrMKrczBUAtm+AioJYGcFpBJzVHuE+bzf7EF2GB+cR1PO072FYPXCihdHilW/KUgoBzK7
 /txztsauSUfqDrqXdrg==
X-Authority-Analysis: v=2.4 cv=DptbOW/+ c=1 sm=1 tr=0 ts=69516272 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=T-2iuOupZRtFYbKAKI8A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512280156

Add support for handling the PCIe M.2 connectors as Power Sequencing
devices. These connectors are exposed as the Power Sequencing devices
as they often support multiple interfaces like PCIe/SATA, USB/UART to the
host machine and each interfaces could be driven by different client
drivers at the same time.

This driver handles the PCIe interface of these connectors. It first checks
for the presence of the graph port in the Root Port node with the help of
of_graph_is_present() API, if present, it acquires/poweres ON the
corresponding pwrseq device.

Once the pwrseq device is powered ON, the driver will skip parsing the Root
Port/Slot resources and registers with the pwrctrl framework.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/Kconfig |  1 +
 drivers/pci/pwrctrl/slot.c  | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index e0f999f299bb..cd3aa15bad00 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -13,6 +13,7 @@ config PCI_PWRCTRL_PWRSEQ
 
 config PCI_PWRCTRL_SLOT
 	tristate "PCI Power Control driver for PCI slots"
+	select POWER_SEQUENCING
 	select PCI_PWRCTRL
 	help
 	  Say Y here to enable the PCI Power Control driver to control the power
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 3320494b62d8..d46c2365208a 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -8,8 +8,10 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of_graph.h>
 #include <linux/pci-pwrctrl.h>
 #include <linux/platform_device.h>
+#include <linux/pwrseq/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -17,12 +19,18 @@ struct pci_pwrctrl_slot_data {
 	struct pci_pwrctrl ctx;
 	struct regulator_bulk_data *supplies;
 	int num_supplies;
+	struct pwrseq_desc *pwrseq;
 };
 
 static void devm_pci_pwrctrl_slot_power_off(void *data)
 {
 	struct pci_pwrctrl_slot_data *slot = data;
 
+	if (slot->pwrseq) {
+		pwrseq_power_off(slot->pwrseq);
+		return;
+	}
+
 	regulator_bulk_disable(slot->num_supplies, slot->supplies);
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
 }
@@ -38,6 +46,20 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 	if (!slot)
 		return -ENOMEM;
 
+	if (of_graph_is_present(dev_of_node(dev))) {
+		slot->pwrseq = devm_pwrseq_get(dev, "pcie");
+		if (IS_ERR(slot->pwrseq))
+			return dev_err_probe(dev, PTR_ERR(slot->pwrseq),
+				     "Failed to get the power sequencer\n");
+
+		ret = pwrseq_power_on(slot->pwrseq);
+		if (ret)
+			return dev_err_probe(dev, ret,
+				     "Failed to power-on the device\n");
+
+		goto skip_resources;
+	}
+
 	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
 					&slot->supplies);
 	if (ret < 0) {
@@ -53,17 +75,20 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
-				       slot);
-	if (ret)
-		return ret;
-
 	clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(clk)) {
+		regulator_bulk_disable(slot->num_supplies, slot->supplies);
+		regulator_bulk_free(slot->num_supplies, slot->supplies);
 		return dev_err_probe(dev, PTR_ERR(clk),
 				     "Failed to enable slot clock\n");
 	}
 
+skip_resources:
+	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
+				       slot);
+	if (ret)
+		return ret;
+
 	pci_pwrctrl_init(&slot->ctx, dev);
 
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->ctx);

-- 
2.48.1


