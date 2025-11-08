Return-Path: <linux-pci+bounces-40610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE4CC425E2
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 04:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17482188C943
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 03:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33432D3A96;
	Sat,  8 Nov 2025 03:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eha4cnon";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fLj/8dyo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100012D7DD3
	for <linux-pci@vger.kernel.org>; Sat,  8 Nov 2025 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762572232; cv=none; b=WJXRO9ZnXRnvwtlk56LemqMf3bzgdvLauGVqXBmkMloXD3xtMU8ExFrR9/V4pSjlmv0aol8X0dfA1rqEyJN+a8tHJCj2BlhUaFegdITChYrpaATBYax6rVpCBOYiAkJ6amlfHurkOvYlR0x8XHPLWhaM5/FudvY+msIR9uXMDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762572232; c=relaxed/simple;
	bh=6JV6iijCVKWK12xOisbku7kPcAUn8AtYsjIJ5OCWPFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EuzgzkX55Zaw2dEIL65+yDk+5aQ6k0hXKiUQNGvEvcwQ8l8rCvJyKFo0uj2g2VpJ5hOAELwR3NquwseA6uY6y+s2gy291KfDdfNsN5vOt5L5ijFh5NXyZLnGjhBMzqaaxmT/roJrmJtSnnZ0blURWbQBSA0zu9pWrFE6D1c6XdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eha4cnon; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fLj/8dyo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A7LraOB4128432
	for <linux-pci@vger.kernel.org>; Sat, 8 Nov 2025 03:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Fr/wxR5o/dgbV3wh8KKr+sf9R0I5j0Vgjg2foUPt36M=; b=eha4cnonGwBYSZvy
	pYmc4n79gp2n0VHCHz2WBs9/CGxFuO4k09cdoLUDuiFwJ21v+2o4Cf2eJqdUCiXd
	EJ9YDnN2up2Pe4KBe53Ok9H/+MXNb8Icr5nWex46rBdOno9EfsSLi+u9iSJmVE23
	PbMc0cszoPeaUtpQvtsiHMzQISnYVT8mD4jLrOOf8Ilu5yKdJXfMfOEFolsGXY1E
	s0+1F60ZqQrCU7BnxB0ch74O29WcOtm3HWoQf0rvlWF1tqWk/HkFwrokntx3rUVq
	UOSQ0XtxsOEGqqKU0KEjdkNhJJmul5RBe4aTPeYanllwNvu51nKwvU0vG7nljasH
	fb4BmA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9s37gfun-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 08 Nov 2025 03:23:50 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso1312427a12.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 19:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762572230; x=1763177030; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fr/wxR5o/dgbV3wh8KKr+sf9R0I5j0Vgjg2foUPt36M=;
        b=fLj/8dyoesSzxtgreOSdyMzVbwvI1Bkh7iGJvDt3Tjwth2uyiSjsR4hnz2xRhYAlBh
         5dypsEz5cQ0KUEUwTMMaBl9D99JxbuRG2WYDUpH/5XqQI7EnfrKvYWwP9z5s8Zxnk5zE
         cozk20QH014V0Ku8vXxne8GVgneTD0mmtOLX3brsTrWWOhuUyfJvK5FVdXTLfR4ytDZ4
         j8jiPSxkfj6kvs+Jtvpd0RMqZhm/C+FPhXGENKjEju6+X/LS6xNHu5dSizeTJNAQpevJ
         3xmdlxg10RUo+fIjR3QLrqAJBULyenoTFJJmu06vNwPgJ+ZtJt9qg9KJYh0PKtinP6k/
         VwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762572230; x=1763177030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fr/wxR5o/dgbV3wh8KKr+sf9R0I5j0Vgjg2foUPt36M=;
        b=qkXxaMyhSylTd5mUGZJS4mzpABnKbHWUcC2z1ckqszf2WrP1tcDjUWziXMz9npQCNR
         uwufykEsQMY6NZtHf/zOxk85Jgp3rrM8Sv1InUvJPpNEEANXvpMto2n9Tni2jZ8G+HMX
         jjy2oAg+K41v0e2etxqZNSEb3r3zB4bWDEl52cuGyUBW8x/3NqzZYXiAtX6+civ6+SuQ
         o98Cwn603JgAXShWdt/5fbaESZnM020/fM5GdIxtEKRNm63vuoEC0WxS9x2/ci7804mg
         OWOQXx2iy21rrsRE1TWs4Azm88GDHbtnf5g+T4z+/3VEqBusis78831a/RrAPOhK/HOz
         aGqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnKX9wQfgJ9H7hbb3yuEPz/LrH1EMNFIbSf8E2IH4wcc9iCN3zv28xOg5r6miKhdxnc2/Ofwpzu5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4sqyEIe7/BL86WlX95T3yMGVBwbGduYD4KmKuyjyogoji9RhR
	jp96UzVuYpU69R2yPaZgOmiRnEdlk0iOxzy9U0X66juP3xrDXmF26y9bOt/cFxzT22l+6urR2n7
	VsSEEYJ6aW1tRIGVY8kO0M9B2Hnmo3LM4p0BBoUQZ6s6zHlQtbItoe9GQmvHLOAo=
X-Gm-Gg: ASbGncuZ/xYYT3+0hO2QCmJ5SgCJXVcwD6nhmJ4JWt2/ifFqM3rCPdBoa5cJYhsJryF
	hsjs8bUM9CBXRBizf0JN+a3glVnfe2v11qwVrN1xEUfpDb7RkmrCdcRFAUhBNAwqWRvKE4Q+LN0
	vRXDneu9QSMn8vYJ2Tf3s2b9jLF9atIIzUndvzUuNiqWMF9r4v5cHQyzG6lDatv830QFYIaWNwl
	Pj86/5ALPP94ae0aLcLdfjn3yRddwy6EkIasUt63FAEXSlJKiOKtgdY1XtnzjRr7+t+vDlQdI4U
	nwf5xVTILtwhet2nLj4xuo/6k016OJJvfE9jRRZDKhzTMTPpYwHgplEVY2FQ/Wyeqiz9q/DGhKe
	DdF8VMup37x8QRQaSom/LITPAjCzolPY=
X-Received: by 2002:a17:903:3888:b0:295:82b4:216a with SMTP id d9443c01a7336-297e571465dmr18065405ad.55.1762572229259;
        Fri, 07 Nov 2025 19:23:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsPQGg2btR0xGIz5xypocjn6Gr6qICR5EqNd0NlnUfF0QOLxZ9gXCvB7HPRKNZ1zn5VRPVqw==
X-Received: by 2002:a17:903:3888:b0:295:82b4:216a with SMTP id d9443c01a7336-297e571465dmr18065105ad.55.1762572228652;
        Fri, 07 Nov 2025 19:23:48 -0800 (PST)
Received: from [192.168.0.104] ([106.219.179.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297d83c941esm19942445ad.44.2025.11.07.19.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 19:23:48 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Date: Sat, 08 Nov 2025 08:53:20 +0530
Subject: [PATCH v2 2/4] PCI/pwrctrl: Add support for handling PCIe M.2
 connectors
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-pci-m2-v2-2-e8bc4d7bf42d@oss.qualcomm.com>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
In-Reply-To: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3917;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=6JV6iijCVKWK12xOisbku7kPcAUn8AtYsjIJ5OCWPFI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpDre1vSB6sn4ipoEY4JQzaVgP68zyXEyRCh4BV
 fbwo8ZR0IyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaQ63tQAKCRBVnxHm/pHO
 9ahiB/4s48SNsDwbsKrC+vFr7Or7Us7fMwNs4pr1f839l3M87RDgsCEV8U7ygcvWxHHzaorxDMB
 OlXKx5b+lkbJg7oA0renkTbPsqsBVaOaHSi4GgvEGDVP7l7jncYrks+w2Z26chBez01zUbUwOEQ
 Du5vFLPLcQJYSsdXXYTO132u766HKyaSUBnRJdd4yIYIz9GVPoJH/G1PRTr6a3T+MzVmy6PxOeH
 vV8JQdKMS9gb3tzORHtptODmkArVv/ZFr1bsbcoAackq8hHjDoxvqj8bjm5wrL7aS5MUCcGfRpT
 ELH42cpIYGriIhZbq58VhMPWLGeubRnDdAXtq/Y8vrHfFVQt
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-ORIG-GUID: xzXSG8vTpnLnDt78ZcuXdt5LDhyaQ2wH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyNyBTYWx0ZWRfX9YBSBNgwi7FW
 R4AS0EINRG20jEcopj0J7+0E1SYfafaY+cb/DyS8eGFB5VlxBdzI3HeIuaLBfTAa77/uZnXff+G
 fdj/Tb8WDibXJBZvhaKcYIJZ3dOS44K/ESraOL1kr4H6e7i9VMXRVQF9Jiid55PXFs/s+e/8sbR
 p2LuL7jevba2TwG3F9PbH7joLKVZoON1+D5qAin7vYdcp8aXA87E+0ZjNS3TEGn8TTH8zjpnRkl
 wv7EiekL3664mrcDyDhXh/H4aRC4ppgZSTOgnPkjSSd+4jfbgiCS1KiRji6+iSG3rpw4INJ83w+
 MwUN59ecFNNDAp594DX1hFFnQg/v6Ze9am0H27UgZw0NAA3ItofflIQa2dSSsF324N5w41xxYNB
 QH3/4j+9Ai9qJscc/2Bz5vm4zTdFzQ==
X-Proofpoint-GUID: xzXSG8vTpnLnDt78ZcuXdt5LDhyaQ2wH
X-Authority-Analysis: v=2.4 cv=caTfb3DM c=1 sm=1 tr=0 ts=690eb7c6 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=qronr9GGDLuyXDLutoyxMA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=T-2iuOupZRtFYbKAKI8A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511080027

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


