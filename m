Return-Path: <linux-pci+bounces-40329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CF1C34D40
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 10:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 506594FBDCE
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3AF3128B4;
	Wed,  5 Nov 2025 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ccsDX/ah";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XA80tFHl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C562FFDD5
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334210; cv=none; b=JrQahytAD+OYJ3Dy45TUOJvay0VPVuSCqPkXomrU0ABAtyoOiN/ntQU0SNVpttFTMADlBFmLsJgDxpBcWP3TVq+SkORyILnZ+yFdQeiv0bh3Uo7TwsVH9Xmt6p68WonPRGqF+nc52pHyL038p7uEOmbOgFzbg0roULMFcYJC9nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334210; c=relaxed/simple;
	bh=6JV6iijCVKWK12xOisbku7kPcAUn8AtYsjIJ5OCWPFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZzCd5fjXsw9WBN5hBGqCkvKinb8p6GrQvqcK9mQDFg/1QB2vVdyzG4Vwoci0h1qFcdU8wOGf8TyKqoQa3zSaLYMWMifKAVcsmditUSwAjFyMN32RVY1zV5w+4irc3XSp6M4dn4f/y3mJOM8BIrcbFxWlEqxoP9tpdMN/KexLiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ccsDX/ah; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XA80tFHl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A58A3q22903465
	for <linux-pci@vger.kernel.org>; Wed, 5 Nov 2025 09:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fr/wxR5o/dgbV3wh8KKr+sf9R0I5j0Vgjg2foUPt36M=; b=ccsDX/ahHOAU9SIv
	k3oUU+hyAQAwcC8vJfmonKiSpfSdySdaktnVMMAOnhqz8JtoRLtCwUL/HmatQITz
	aBuEQkq86E9l7fdcXBB8z1HKLrc8JR6z98Y09b9BhdDckuAWbATQt6GRHS413PNM
	IDvOU4limZzAZLQW0vJo3HZPoe9qx8gIyNi6fJhPIN5fKnehNRXY3R5mHgljikgk
	ilRbSQCNTxJgROm+Sa5dF+uXFRxNBuvS22vCocC7GhElp14chhS3MFx51rNasCQR
	sHNFCO9L0Am/8S4G9M33MaUHpevKP9lu9MIhNcedN/g6Lw+NFEvJW6j+03Y4Vc7R
	lkPq0g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7mbbtrcb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 09:16:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33baef12edaso7939573a91.0
        for <linux-pci@vger.kernel.org>; Wed, 05 Nov 2025 01:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762334206; x=1762939006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fr/wxR5o/dgbV3wh8KKr+sf9R0I5j0Vgjg2foUPt36M=;
        b=XA80tFHlUKQevg11jRpdq5xPLgHxMAocgf6eKG5XYHFJaB8mXZqahm1sgQJwAlwd9A
         pmSCbdevpf93HuEcWMuAExYHgN2n4omUZKL8EmGHeSERYE0xOTfUvVxo/KHPkai5s7Fe
         HfM+cYQnVdG1oU0Sj7m6PEz8FeMBq90a2jevJ67trP9vZLXBKr4GhbK1hXQmVwxTWnkg
         U7jsa45xpPa2FEIvqDG2RIkiWpq7JSpFQWrAad3JNfOI11SMr3n9Pyn3v5ZlmUYfsdNX
         qv6kO0cHDcwDm4lXxmg1VuvzZUq6WBo1LgBCM+CqxjFf+htaoDf2rDSQ68CnT2dypC8H
         gZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334206; x=1762939006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fr/wxR5o/dgbV3wh8KKr+sf9R0I5j0Vgjg2foUPt36M=;
        b=HL6LMpnx29GQKb7MYKLg3O2LYs6f36sWU1xl72MChedmoxVx0NT4I4OSizsn90qkA8
         xem5Yj134qmE0itTrbmBMWHgZxCf6tjUcvD0mlUFaGfVk+Zm1qUaq3+7IiXtY3Oqajij
         Xw52Tnr3YzJ2rvjbcSPBOjOn9rOajqjfB0leek0E0u/j1VL+NRsxPivJ1FdSYwNrSaQI
         mMwSGvfw7Uxye1LYeTaeqpUeNuhqty5SHsDRXugSrbaonwueK4X0ED//YwuKCdFcLVpf
         Gz4syC0mJNrYa1LTH56mPhRycIGksJbwH+WFCpFn+NKT1nMRQqELny5LygmLaymiHwtd
         lIxw==
X-Forwarded-Encrypted: i=1; AJvYcCVT12pr8eUZ8AlFinKHddAx05Qg9YTtSPXqS/qD60b567sL4gjA5OnU5KaZTVhXnFDrNdZepLIwNiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKgySFAxR0zrwdM/py7VjnyBEZAWuziiFZKLMNq09j6owNg2v7
	sDC8KUxvWH2QzKsXFkJaAam4po/l1MLHBjPSCpTg04UUMgsPK7JOEp4qneoPbC/LlLJMy9lBLE3
	GcN98l6Hwg2PwqAYhXfXZOId3cCw78qCDUn7Jb7VqGYjPqESWZyoQqhs3ZzeRjmo=
X-Gm-Gg: ASbGncuCblzcReUWHCOcP4gWeqqIYd86lMq6o1J8cFhy7s3tEaXJoEKRUqC1Su33L+H
	upTCV1e5p5FC6czzO8GI5vlbb1fSbdQO95V5NZY10gKrahdZIPeCnhj+T8cB1pcRn+RZZZ+MTyJ
	US2HY2kG52JkS4/32eb1lQffjU1PESKO+6FTZ3UdVM2yxr8dPGdPz4w4kOQlonhd00ocSqcZ8OG
	wvF18V66KkHFScZnEzV2RXsSP2pIvwD/JYhioK0t/thZVUsQgmUt9/pbblznTzJ7WRlev0j4dNm
	zpat/dmdQmPudugFBAKBG3jc9PZ9/SH4a1z9uaCBSY+bf0r+zi3ypSHWyGmouUpfPfck5/pfNTj
	t7obqi4/IHsUQjg3pRxNyXTTgQ2AA
X-Received: by 2002:a17:90b:48ca:b0:340:f05a:3ecb with SMTP id 98e67ed59e1d1-341a6ded3a8mr3020694a91.28.1762334205642;
        Wed, 05 Nov 2025 01:16:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKwsvUGdrfKTQhaqiwzEypp+iS5QzZH09d6n929jY+N764lQ1Gt7nCYOFdvWBtf2B+FDuBSw==
X-Received: by 2002:a17:90b:48ca:b0:340:f05a:3ecb with SMTP id 98e67ed59e1d1-341a6ded3a8mr3020664a91.28.1762334205088;
        Wed, 05 Nov 2025 01:16:45 -0800 (PST)
Received: from [192.168.1.102] ([120.60.68.120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417a385563sm2274249a91.0.2025.11.05.01.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:16:44 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 14:45:50 +0530
Subject: [PATCH 2/4] PCI/pwrctrl: Add support for handling PCIe M.2
 connectors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-pci-m2-v1-2-84b5f1f1e5e8@oss.qualcomm.com>
References: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
In-Reply-To: <20251105-pci-m2-v1-0-84b5f1f1e5e8@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3917;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=6JV6iijCVKWK12xOisbku7kPcAUn8AtYsjIJ5OCWPFI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpCxXoCyTIkkKmbRofz4BXOgj+hgIcJiMyJzFHE
 6fXLle3+wmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQsV6AAKCRBVnxHm/pHO
 9SofB/97Zy40OYNFyPILHV9/VogbBFLuszEaspIiN624N2tKtZSWiU/fsRJB7et/oc+uBk8YhVY
 JnIO5xFZSpLLIn1wV5J9V5qxSp9rXKUaPIaVnhPYyrM6xOBowoL9vCNQEAwQkTi4DUyJFVawRfG
 bpoLxDWiV4f1I+EglDR0L8yr3zsIBzBv3r/H7+0MgvegB8IOi34Yi7Z9xzyXVB5ZJuDD7G9U1rD
 r5BOseJOjqhHqzd9uSNttgb16/CF2W1ailQJxwUGmNnBT17mU1QbtOHGMJc3FS3CqrXNSUT8po9
 l6SAIlGuRIbWRhvk+dNukITDyeAvd1drTpvjgXMM8j/ZPsZj
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-ORIG-GUID: wdxR9WIIMUDiCHsCZamq-hSMhISZ_eMy
X-Proofpoint-GUID: wdxR9WIIMUDiCHsCZamq-hSMhISZ_eMy
X-Authority-Analysis: v=2.4 cv=MK1tWcZl c=1 sm=1 tr=0 ts=690b15ff cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=adoi+G5QptZiRYWGMQz2cA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=T-2iuOupZRtFYbKAKI8A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDA2OSBTYWx0ZWRfX6/Z9dl5fJjSf
 afo8gWosUjLHj96tCqK/4imWricWNNXkUJ2cyLHIM1sISxOCaaienqROpNTZp3qbqbEcHR6acnE
 /swf3C2d29zxO+LGl1BFcsNyUpRq/KqJq+s6LP4l2rWH4ztTW8EWnM2pTRzKwdf81lWT/4qQmAI
 iku5SYsXyUD+YjRnAvfi/r8aAJ8babvB+0DVJGzRFP7hi+6uA5TeAYDe2DnrngV2ZP2PrOXo2QQ
 tuH7cMkMxJhTaITh7wTbrVnKeUGy9ftbmFIqI5w/cHUgm1QGs6M9jmnYAISu4E0z57kdO2/oM6Z
 pkMgmZmCAay0nRXPa0sMZX+KobzCSmWfUcDRakvw9QFy32cpVwlEVP/eQvVWpHvi1ToJU8z/mLf
 pEGBFxTeD9A6BwQMyPjP9xobCvaWoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_03,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050069

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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/Kconfig |  1 +
 drivers/pci/pwrctrl/slot.c  | 35 ++++++++++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index 6956c18548114ce12247b560f1ef159eb7e90b10..9a195cb7e117465625c68301534af22000dfca8d 100644
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
index 3320494b62d890ffbae6f125e2704167ebccf7b9..d46c2365208ac87c4e83ba8d69ac1914d9bf9088 100644
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


