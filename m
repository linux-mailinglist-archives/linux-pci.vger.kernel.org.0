Return-Path: <linux-pci+bounces-43777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 895F9CE533F
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 18:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A5CF30422AD
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A77221F15;
	Sun, 28 Dec 2025 17:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EBCfNwAL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jbSU+3uI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F822259A
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766941307; cv=none; b=qy3FALGnj5b4nF5Qt/P1QdwTl/F7azNfj3zxOHr+68DelmVWkYL8e/4A6tHtrld8IFDtR+VlmmrP1WjWWbmzsnH9gHcrQ7xtDVoIqVWWqrbbImymKrTj5wK5AO+1pMPAcxAqZ0AKbolF5wlkWkzV6Zjs6kuxIC/On66KXWeL9N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766941307; c=relaxed/simple;
	bh=Z2MQcMtEDf0+MlOwlvmKClr02SMu0Uf8mDR8S4+Fr7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s4LVvm7TjdPhzIwb2U51DwHu3UZr8racYgR7JxNt0OAlin1WFfeiBEmyu/JRXHPNmVKZT9Mz/Lpo0v1eo2w7ssPThHm6KSyLneM0bJu94T5Ye5TTxumKslrYbxkD809Pjq9G0xX1OSLHYfD3yqB8q7DiF4pCLawnsV+gVCXDoqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EBCfNwAL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jbSU+3uI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSGlZhb3719424
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 17:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lO8KnnWgHSsJ7X+4A3/uEMMgQDJP+dBeFTvM/NCdCwo=; b=EBCfNwAL1rIz7Xy/
	pWfGXlmTLOUFPyQcR8bJLxG+fgXSqsKD115M235Jy3/RRcFB5X6TFJ7V8az3NSbj
	JZFrlgckN4b3lI2zVeBr0tUwvzoPxw+rl0ibxavd2PowzflTsAoWJKXcH1yMOnFr
	+R4X+LzgOqTXrmry2TfWvRpd6dSrt9yavMQkrj2/EPNV5LXEywj232TNz8RiVUl0
	KGKNCOh8c7qoR3Rimpg1ryHg0GOcX94ISJBhR+gh5B2W0PCUWWOU8BPdba/nRcVa
	Bqd7CD5FfAlsMZZU03tXv3oO9mizdx4QKMf+ysBqDum8ifw94RDyT4sVXtFqGhOX
	rxhV4w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6f62hhj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 17:01:43 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b9208e1976so15986754b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 28 Dec 2025 09:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766941302; x=1767546102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lO8KnnWgHSsJ7X+4A3/uEMMgQDJP+dBeFTvM/NCdCwo=;
        b=jbSU+3uIlEZ/DOGe/0zaPI4BQp/lMdY26A/Skqdmur4Ns31ox8CVggbxuZXUasdkoO
         640aefdhm5rgvW2PXFeggOu5yiO8sjezf7Wdq7TJukrpT1Ci6XzWa+6YRHs26Cir+8Ug
         4GftbNkt5OEHAdv5QWrKYl/e5tIB1MSaaxXQ5w+GzAh4qRdv6xrUains4q/OHKJterJM
         2ZB5oOUD+xgShGRTWoZGFivNek1ATrVpYkAWZtXEMOb1K4UhPfXsTB6IAetdvj85iOvz
         h2qHzfFYT7JR2J69RxWfiZEtZaTFxMPB6GEhO4PVz43xhBF+71NuDQV/u/J2rQ7HqPgr
         TEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766941302; x=1767546102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lO8KnnWgHSsJ7X+4A3/uEMMgQDJP+dBeFTvM/NCdCwo=;
        b=jMjKZPErImI0PIXoGjIctTh+ZVQBP7WPbTn9xwOD2imh13cf5xG17aRyQoZssXLxDv
         dYBcJX6IJZqXH4NBE0l4y0D8Q85PtUplTOsRdo5eDPrGKcHErXjEEHrpVXYrlzLy6BBR
         1bU+oW7ZH2sLS3RSFPbiHOPcL9QBAqpXwIb0jqgUxkveyBnw/KWyIoXNQmO+LRBI1ieu
         ZETO6hWFpS3vKmuTTBvbtOhaKh0tiiOTM91K57pgt+QltJWLWgCmsJlOl07s4/cgm9ZZ
         uUNOu8ft7q/s2hul8m7hPinCE36hH4KUnIrGmVLZ+DPVmuG6vL26r5oYdfOlBDVMtFPj
         Tp2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmpxq2Vi1XNCTUekjVtr8Z0VnaUQfbuHONjHaqFi280utpcr4TI3mOE5m3YJcvL2BwHTyh2HJlN5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2HJVX9MTOa+qRF/Pi+N72VkkVGI4TjL7M5cN+I9NcGP5je0bA
	H47KCGrkQWAJPgJvzvan3uW2SA4Rxi4R6Lb+tx2tfV3yMLWd7/SfPPy9vM86On6qAvuunKwoEty
	btnAZY8fafPQfP7UKBlRKRexBhLfzov3vnLxvNUxEBDqdX3TgQbA3P+87mcyg+oA=
X-Gm-Gg: AY/fxX4ORDpG1ZHhKEAnzQ8o8thQbudFBhRAw0WRKKkPfmI62rn4D+qnesFd3zongyv
	gqJw50Ob6tFhh35ymJiQFEGyV7CPie3roLdgMLvZLuUGZq4Kjjpm1X6lg2xiLsRj1AAv3F07gGQ
	V61kHYMS4sdGPD4VbaS4YytUxUI2OkOGsIoqKVofrKwVTTdCfd4Zv0EQAIbFDYhQkiV4DMYkJZm
	5YVOpAQVKwWKKkKvmx0XfO8Pa95alFMiaqx2z4HJY1BpsKtJXtH1HzxYi4VTpRjWKs3DwkLdeGq
	vy8RDBTb/MsshYSlyOe2dMfpGB7vbsYwIBBDGzdExGzOPWGnArDNGtXm0WE0mzilAhmp4KTZcpx
	wFj13QyxFl2TbKQeCR+TBNsm/KOgNjX+93Ck=
X-Received: by 2002:a05:6a00:4091:b0:7e8:4398:b365 with SMTP id d2e1a72fcca58-7ff6666fb6dmr26620067b3a.56.1766941302425;
        Sun, 28 Dec 2025 09:01:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVA7a0q7fL5mIleAzOZdrFNeS91W87Ncnq8EVjDEwuLWRFyji36RoXXncfIFII87lTO4ggYw==
X-Received: by 2002:a05:6a00:4091:b0:7e8:4398:b365 with SMTP id d2e1a72fcca58-7ff6666fb6dmr26620031b3a.56.1766941301904;
        Sun, 28 Dec 2025 09:01:41 -0800 (PST)
Received: from work.lan ([2409:4091:a0f4:6806:90aa:5191:e297:e185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7ae354easm27053925b3a.16.2025.12.28.09.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Dec 2025 09:01:41 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Sun, 28 Dec 2025 22:31:04 +0530
Subject: [PATCH v4 4/5] PCI/pwrctrl: Create pwrctrl device if the graph
 port is found
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251228-pci-m2-v4-4-5684868b0d5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Z2MQcMtEDf0+MlOwlvmKClr02SMu0Uf8mDR8S4+Fr7o=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpUWJZi+OafIN/4BNYQUHZiDJVSi1SBNpgCKCKH
 DHZemBVgO2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaVFiWQAKCRBVnxHm/pHO
 9e6xB/4wMR8YICaDAR48uFLGUJjdWx3H9G6VyXUGvRi3LLh+tfNxRT/71W7P/Iei6fMZOMxUlfM
 Xmi1UoqocqoJRZ+m+4OEJoeDYF/mEcFdGyO/yOBALlk0ftq/74Bg2tm98JQrVRuLytK+B60D9Uw
 niH4+wf8eqf8eEbM2UWIlrMJ/re041H5FZkAn0ez4BC4+26LGVBxyiQfz/g/fK6ugRw5FbG9spe
 W9IngGtihEwM8gJ7GktcJ39ULghQR//YsoOdGxSn6Dy6yow2lu6sa+/DaVwDkjXzF7kCtTzX+p2
 Lgoo+fcQM+lS1olTJWWhWPRprbx8wTOcIa5xetbYBbJ9s5J2
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-GUID: r0WilN-TGLwKC2LvuEW4PBLTkzIDbRnU
X-Proofpoint-ORIG-GUID: r0WilN-TGLwKC2LvuEW4PBLTkzIDbRnU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDE1NiBTYWx0ZWRfX5BBtCnL6hTXq
 mL5BQNDHxEyVaqPJ04aEtbgJWRCRu9dcDrLqizper05FdJnuvnPIsx9s8lP2Ym7rv2lYRYY4LjB
 RIP1mLtKYtAF9VuwKMMHko9N3kL3FrFOgJWNGyB4Gmyl6Sy57PaXnzEnI5u/4B2Sgor9B73UEHn
 TF5Qa0QEvAP/9gTB4Mk5Ir5M14HvWzo3baE48EZUsB5FgMaGr7wcRTBEtXVumv2MVlymZF/RQ71
 PkEjcMB+vPzyRo9h+qVcdESNbZBGbHUxtqxkFoSdr9ywqn1Gdb9/OaPUDV5nRjYt2BD9VbTju0R
 a+ksBjQU1uOHDJSGqDqOr50jWyRXHPaa9CNHa4tSNDtN0N+1EFJI92R6+qUdHS/YYHvWIyzFgAG
 BgZhkdIZR3DGUQBa2ujvF0hnDPIwwS767HK1JsicFozBT1Xt0JW4WwgFGLXw44NkHOcdeg1/Nuy
 LMXlasxsKjgBg8Tw0TA==
X-Authority-Analysis: v=2.4 cv=YuEChoYX c=1 sm=1 tr=0 ts=69516277 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0pvPJS888BSDkZzuOKoA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512280156

The devicetree node of the PCIe Root Port/Slot could have the graph port
to link the PCIe M.2 connector node. Since the M.2 connectors are modelled
as Power Sequencing devices, they need to be controlled by the pwrctrl
driver as like the Root Port/Slot supplies.

Hence, create the pwrctrl device if the graph port is found in the node.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d..cd7efd20a74a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
+#include <linux/of_graph.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -2585,7 +2586,7 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 	 * not. This is decided based on at least one of the power supplies
 	 * being defined in the devicetree node of the device.
 	 */
-	if (!of_pci_supply_present(np)) {
+	if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
 		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
 		goto err_put_of_node;
 	}

-- 
2.48.1


