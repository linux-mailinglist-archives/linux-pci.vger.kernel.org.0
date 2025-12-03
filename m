Return-Path: <linux-pci+bounces-42547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8E5C9DEAF
	for <lists+linux-pci@lfdr.de>; Wed, 03 Dec 2025 07:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FE014E0406
	for <lists+linux-pci@lfdr.de>; Wed,  3 Dec 2025 06:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE83299947;
	Wed,  3 Dec 2025 06:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVizO1rC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ih4J/DhH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84FB299920
	for <linux-pci@vger.kernel.org>; Wed,  3 Dec 2025 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764742836; cv=none; b=P4sTDcm4ijsnwC16IAxmxMjthxE2tp8EiXiaM2m4Ieam9MFkilIiaYZQiFcA7PYPOHqicMGB39cyDJVak47TXwsXzVvYkSib/pbLkPDw39/EGMstRAw85uOj8sUztxPdfh9IFCdaxRWwpXaO+cBu6gd3L375itVJ2YhgOeVTKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764742836; c=relaxed/simple;
	bh=j0NHr6gaR0hCCc9uJTEGB2f61u5g4pXG4YCVsjBiL94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJJcpTxxT9O6mBRa1KJkzDkh+7T2GJ3xkpHlFE4WyxdaJWLrkK1XoUlBXbLiH2ue0ikMlVJ4oE0HgijFipnWCNBKq5yiOeET3jLCPaFw7uK8ylfAOkGY6poUvUJndhrAItiuVVohMW/g92alZAM2VKz+JlAz809J215eQpO8qO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kVizO1rC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ih4J/DhH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B34h1Z4385386
	for <linux-pci@vger.kernel.org>; Wed, 3 Dec 2025 06:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H7X39lnwBzI/TnVn7a7Ulf4HCr87WNBcyrTcQi2lH8Q=; b=kVizO1rCnKc45WB4
	5/3irJV12OiC+84GIcxQH25yz3h4HZh9DmvnR7VMj4YFTP93JvquJ8V6r65/qHt1
	4vegDtE4vo8I5siGS3X8KsbiMyEqNgTULZKQgmP56EYy8f28sSGxP4nLpzTyrTGy
	u6soXJ32vwqdbspLlbOpxa9RaRpf2PAKzqgsQON31Bq7MmruuLdmBiuxqwmEsgqq
	FPTW/huT8UqBsMAAcABYBpjcEoE5GyNohqhGJdtul4R20ftyOO/bT8XaMmjlDa54
	ijGZ1k6mq53UJU17qYUD7UGCvSV0LJPLRLYxbaCKEI9FW129d3YtmfrCqfC0Gyfo
	3Z78VA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4at5db1tg4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 06:20:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2958a134514so84964215ad.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 22:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764742832; x=1765347632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7X39lnwBzI/TnVn7a7Ulf4HCr87WNBcyrTcQi2lH8Q=;
        b=Ih4J/DhH55Lrl6Wiax8bppk8e8aALVYIF5vYt24idPqFHss+hEoprs48xSdAhsMRPg
         WJ7jjDn5sTZFawmqmMOmilSD3DzF9iMkFAYRsFY5hcj0CJKDS5YbGOLRuzOYHoFGsHA7
         djqbyMEc1jLFy1txxmK6HTcr8v07qpmT94D0vUDm3RhIbzYrQuIEFJz7ms6NtFHVZMr+
         iMQxcBi/5Py+Ghf619kSX/LJ9kZTDGIbU+KQDDVLfHNmfPKWSphCOXsKiSgdn3Tzokox
         8qcBVjpd6y0erqMtbc77SUATGBKX8PckdGcIe5YZXgOd7/V9mw8+HRgK3kuSkP80umUf
         3ZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764742832; x=1765347632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H7X39lnwBzI/TnVn7a7Ulf4HCr87WNBcyrTcQi2lH8Q=;
        b=mUOeDdkEvChhGTZLOxW0jAXTAqmLTUpbiiV9lBI+DNVqKOdhGkpXp7YojL050d/PP7
         C0l1+ReCJIN2i9eklysEZ1ytxXbw9pGxtRIExSZPWUjTgP5Q9G/ToMuE3yI9FR3E+fjI
         e++ZlDImwNt7DRM6D6PaLt3A3gTHXFAcJsxRCxk+OYyD9S6R5ldJtGJliuYAY2aloG6G
         KLS64kAs7SNxz8DMfsuV38dZIH3OtxlPKzLEMbI6Mroy6hJwGIf9mTuZXFiiQzkNu0Wk
         SZ4N07GBFnxgD62kDuKZAmapKxq9h8U8a771pmCNIgvr2ks0ZW8RN5dDSVRH521sPNS1
         Gwzg==
X-Gm-Message-State: AOJu0YyrCwFJIglWvVinrYaHxB/eK2xKmhJ5FL2RWPupe1b845WP53Si
	172fr/S9qEeYfHz0DWAdtY/OpKDitg7sn5KbNxoZfIPvCAzXsGq8QMiyO3pmAqajkR47lLb4OPG
	nRajY0nBaEO7tyj0sJlm4LJ+VkuKAO+R+sLFEjEycyEdXA2CQtIhgFrTRv8LC+xi+9cM7eYM=
X-Gm-Gg: ASbGncsM9ObP6c84B/gq1OfXmzK6Pl5rkB+igdbkZ880J1OAP1Ozz8Os/H5+vkNjlGx
	LcY8xS3xviHv/dPY1AxW/CSS86Au4tfrXabyW9BwZUM5kKnpLTwf8kCPlfyeHSU3Ddf/PdCusA0
	cAgvhYo8JEoZtWrr3oCM70UlngUojTleAPbLrsLg1KMAivHe/UzEgcEBtGrOPQ2mCsrx4Ok0PET
	hKhY5+4J8C1KkU+0h+wQZlDgiQ7lv1osqK9+Y8lWCbP5sGpgy9D4M0LGysZJRkNUPucZ8sfXmun
	lFZ2yMRMs6YONLvE5yL4RhVG81SybaSmfj5NhKNOMiywE17azeW8xzCDkzyPx3vtdzLWK6lm19b
	c5tg/K5G+iIKIv5YdpgX/hxrD0KAi9ATX36BF/i7ycJlB
X-Received: by 2002:a17:902:cecb:b0:295:5668:2f26 with SMTP id d9443c01a7336-29d68452625mr16565195ad.46.1764742832156;
        Tue, 02 Dec 2025 22:20:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/AfM1+1l3iWkAPu4Imly3Dl1xs6Svc2Asn6aX3v5k7MV0x1cQV7b3cg48K3NoFM9undFz6w==
X-Received: by 2002:a17:902:cecb:b0:295:5668:2f26 with SMTP id d9443c01a7336-29d68452625mr16564895ad.46.1764742831547;
        Tue, 02 Dec 2025 22:20:31 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb4026bsm174263015ad.71.2025.12.02.22.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 22:20:31 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 03 Dec 2025 11:50:15 +0530
Subject: [PATCH 2/2] PCI: dwc: Fix missing iATU setup when ECAM is enabled
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-ecam_io_fix-v1-2-5cc3d3769c18@oss.qualcomm.com>
References: <20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com>
In-Reply-To: <20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com>
To: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, macro@orcam.me.uk,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764742821; l=6265;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=j0NHr6gaR0hCCc9uJTEGB2f61u5g4pXG4YCVsjBiL94=;
 b=0pPNQvrKFk353JrtmMaFC3xvJ/btb22oD1cZih6Nlb+DbvGTBlNIsaC7LmzB5K8k75BVfHV2m
 whcjjyw/V8MBoDApYRATXAyFZJEn64a4kII4ixSJDTYhvDcSZqZSTVK
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: MHd1G4JrNjeP2kpWahPe176XIhK1zz2z
X-Proofpoint-GUID: MHd1G4JrNjeP2kpWahPe176XIhK1zz2z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDA0OCBTYWx0ZWRfX+MBOTRfK7yPm
 zdIP7NTza42JC16jnOvYD1nUIB5oWhBB+gwSXP8TQOXA3hcVE6P5WKsRdsEfcMpjBcyFvc9EWsV
 XjVX9qM486p/JGnvSoLoHxS2X0eIaoAVPhNtCeyNA5Za3bPNd9E/rPwCU+FwPxob3cuf3it7Tsu
 /sQv6UoSbnFYXpvtGzebKH7nbhywMsBSInn9Oqa57NmVNTP6UvhQbU4nGZkUYBEWP6TvKb15KbO
 ErcNFTui5NvmfgFZ4invI3O1JY9+2VN9K0f42iq3xRGJksgbLUv4+Yd2qg8YyDlpCvQ1DzDSFUR
 s4gDI3YTEolsOHcrMKJeu7SH0ieYlWTuoipb4YH75IvufwiOvKIr0EJdDuPSyAhZKCEpuFtu3/C
 oaW2ihAOCgFSzDkezRiFJkNRH/iEJg==
X-Authority-Analysis: v=2.4 cv=VoMuwu2n c=1 sm=1 tr=0 ts=692fd6b1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=BcPKCTjPAAAA:8 a=EUspDBNiAAAA:8
 a=qLoSvkEBCYgc-AYi8KwA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=MNXww67FyIVnWKX2fotq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512030048

When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
before configuring ECAM iATU entries. This left IO and MEM outbound
windows unprogrammed, resulting in broken IO transactions. Additionally,
dw_pcie_config_ecam_iatu() was only called during host initialization,
so ECAM-related iATU entries were not restored after suspend/resume,
leading to failures in configuration space access

To resolve these issues, the ECAM iATU configuration is moved into
dw_pcie_setup_rc(). At the same time, dw_pcie_iatu_setup() is invoked
when ECAM is enabled.

Rename msg_atu_index to ob_atu_index to track the next available outbound
iATU index for ECAM and MSG TLP windows. Furthermore, an error check is
added in dw_pcie_prog_outbound_atu() to avoid programming beyond
num_ob_windows.

Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
Reported-by: Maciej W. Rozycki <macro@orcam.me.uk>
Closes: https://lore.kernel.org/all/alpine.DEB.2.21.2511280256260.36486@angie.orcam.me.uk/
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 37 ++++++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.c      |  3 ++
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
 3 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 4fb6331fbc2b322c1a1b6a8e4fe08f92e170da19..22c6ec7bff8840d935803f0b96749413b1c3f905 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -433,7 +433,7 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
 	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
 	 * remaining buses need type 1 iATU configuration.
 	 */
-	atu.index = 0;
+	atu.index = pp->ob_atu_index;
 	atu.type = PCIE_ATU_TYPE_CFG0;
 	atu.parent_bus_addr = pp->cfg0_base + SZ_1M;
 	/* 1MiB is to cover 1 (bus) * 32 (devices) * 8 (functions) */
@@ -443,6 +443,8 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
+	pp->ob_atu_index++;
+
 	bus_range_max = resource_size(bus->res);
 
 	if (bus_range_max < 2)
@@ -455,7 +457,11 @@ static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
 	atu.size = (SZ_1M * bus_range_max) - SZ_2M;
 	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
 
-	return dw_pcie_prog_outbound_atu(pci, &atu);
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
+	if (!ret)
+		pp->ob_atu_index++;
+
+	return ret;
 }
 
 static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
@@ -630,14 +636,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		goto err_free_msi;
 
-	if (pp->ecam_enabled) {
-		ret = dw_pcie_config_ecam_iatu(pp);
-		if (ret) {
-			dev_err(dev, "Failed to configure iATU in ECAM mode\n");
-			goto err_free_msi;
-		}
-	}
-
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
@@ -942,7 +940,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
-	pp->msg_atu_index = ++i;
+	pp->ob_atu_index = ++i;
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
@@ -1084,14 +1082,23 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	/*
 	 * If the platform provides its own child bus config accesses, it means
 	 * the platform uses its own address translation component rather than
-	 * ATU, so we should not program the ATU here.
+	 * ATU, so we should not program the ATU here. If ECAM is enabled, config
+	 * space access goes through ATU, so setup ATU here.
 	 */
-	if (pp->bridge->child_ops == &dw_child_pcie_ops) {
+	if (pp->bridge->child_ops == &dw_child_pcie_ops || pp->ecam_enabled) {
 		ret = dw_pcie_iatu_setup(pp);
 		if (ret)
 			return ret;
 	}
 
+	if (pp->ecam_enabled) {
+		ret = dw_pcie_config_ecam_iatu(pp);
+		if (ret) {
+			dev_err(pci->dev, "Failed to configure iATU in ECAM mode\n");
+			return ret;
+		}
+	}
+
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
 
 	/* Program correct class for RC */
@@ -1113,7 +1120,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	void __iomem *mem;
 	int ret;
 
-	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
+	if (pci->num_ob_windows <= pci->pp.ob_atu_index)
 		return -ENOSPC;
 
 	if (!pci->pp.msg_res)
@@ -1123,7 +1130,7 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
 	atu.routing = PCIE_MSG_TYPE_R_BC;
 	atu.type = PCIE_ATU_TYPE_MSG;
 	atu.size = resource_size(pci->pp.msg_res);
-	atu.index = pci->pp.msg_atu_index;
+	atu.index = pci->pp.ob_atu_index;
 
 	atu.parent_bus_addr = pci->pp.msg_res->start - pci->parent_bus_offset;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index c644216995f69cbf065e61a0392bf1e5e32cf56e..f9f3c2f3532e0d0e9f8e4f42d8c5c9db68d55272 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -476,6 +476,9 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	u32 retries, val;
 	u64 limit_addr;
 
+	if (atu->index > pci->num_ob_windows)
+		return -ENOSPC;
+
 	limit_addr = parent_bus_addr + atu->size - 1;
 
 	if ((limit_addr & ~pci->region_limit) != (parent_bus_addr & ~pci->region_limit) ||
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e995f692a1ecd10130d3be3358827f801811387f..69d0bd8b3c57353763f98999e5d39527861fe1a7 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -423,8 +423,8 @@ struct dw_pcie_rp {
 	struct pci_host_bridge  *bridge;
 	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
+	int			ob_atu_index;
 	bool			use_atu_msg;
-	int			msg_atu_index;
 	struct resource		*msg_res;
 	bool			use_linkup_irq;
 	struct pci_eq_presets	presets;

-- 
2.34.1


