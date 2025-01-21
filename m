Return-Path: <linux-pci+bounces-20177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E3BA179BE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 10:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082B018849F3
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 09:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCCB1BEF83;
	Tue, 21 Jan 2025 09:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZE2tp3Lx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6C31C1AD4
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737450178; cv=none; b=Cz5zvM3hqTIauqjOAw4T+6DVxyaO8ffDUD/nXOA2EBh/dJ5CTGIrXmj3LBvXSJg8SNksaWiRHXnLhrKlCR9Eq0Ywd+tteAouKr7lV1eQ4ZnGGr9Gs/SjsaOCJX2PfmUoMWEtLR0oz7Sn1XD4EA25GUWBn8kLEGBPQibA1t6Gdzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737450178; c=relaxed/simple;
	bh=MCubf1WxeyClKc15KlJ1QBlBaJU/1wzFUu/KC1N0k3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVu9QW+eQnva3tj4KVPx4bjaKE1bwwA1aZuhFMUW0RGuSQDTJQHKE0t0cenIieXzLJHFzKy6M+YL+CYh8GH8Ai0oayPVtRggHf+wH70QNSNkwSjqkNiye5I4YecGwIFQtKzHJnhciU1GeYuv+HCMmJR/293fh3iF7WgkDKTOU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZE2tp3Lx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L8YjLF008407
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 09:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jcv08fL/0RnAdlWkXnMIdosyK/IbIQ4FO7/qvbqPHI8=; b=ZE2tp3LxxhDgjsGY
	FCjycSYMKJ/0W3yuDq/cAYMLfTLZXWcYvRgwTv2rW0yP7k90oBEYzJmmbXr4yPeg
	Gs1GdthZ11dmXbJato72AQIcaxDPG9k1dIL7HxuOC2RY0wenLPcwuu8gO0WJ2638
	KzvLj946HOrTBGY2bIQwGzF7v+6QfQUj5qR8i20beMd8Hpe1GwGC04tfJ6Lj6FZh
	aTDfskq3AZ3nblt61uMCtSmtZdeQ7cdx+Rbt2t7JdGWESQ37F+91FocKjAuISGIh
	rnrNKEJToYjU64oMhnepejkSd8/xcmyu7RbvbRtX4yUgawgeh5oqTxnJf6l+hO4k
	lZKd8Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a71nr87f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 09:02:55 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21661949f23so161624335ad.3
        for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 01:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737450175; x=1738054975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jcv08fL/0RnAdlWkXnMIdosyK/IbIQ4FO7/qvbqPHI8=;
        b=c9hDthZat6OReiM63IxJNuKP49Ha49uyiZBEgn4IMKiJuONwHEK6oBQDoLoZMza1FX
         n3/u8sSEe4c/iq6XNZp+K4FezcVFBPr646mAe91pb61+2+KROQBIG0ogY1Tr3WRLCZHx
         /kVmy1hO8egD4QFn9qtjNcF+FF9H/bCkBhezgjYZXoXo2YADpi5kEDyV3GyQSXBLJM0m
         WVsMvnwSLlduM3D5n0Llrn4ASmRzIs+JYuwl0Zo/M8xd3AbVTkjTj/RVxizni4Kiw+e4
         9YxxlEIuj7yWTt6QDgd3uLVOo0z0+HijPeR6CTpSqNQcNr9Q0qhPAZYG2kTHzmUTiIV7
         UCkA==
X-Forwarded-Encrypted: i=1; AJvYcCW+r6hpj/QZdMyA9yzCuQ6CnuXYrDNQtE5a7daEC/Ua/TWwzJ1cSBWVD04jA/X4Ordln4CkIUYwHCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxatA8GqM5LbS/4jN+ExPVYrMNf5sJUgcIcVtMrZS0R8UKTtQ3Z
	MUVZ4j1XjNhTUYgHpgoTHAM6iIdx3/CRwsKWclP/cgOL1lxj0WfU3QDCsOipsjbcvELho26fFDP
	wFqhU+o2tNGmIv3b59jGcrtnq/AlWeJdB3TTPzK/PDAkI5iDArPPRXWI2Bxw=
X-Gm-Gg: ASbGncvX4EQXBJtiiJtiDz10z6J2y2GL7KXFpNmu2aoQXBqDb9VXdvsBa05rrUN7gDk
	VVQCDeLl5ul5BLwYqUxMAK4eSN86Djl3kF0+FQ9j53E0cODKiakDYea42ZZLtNbA0U9WbpEUbJl
	GfkCAVIduE7mwKe9cgnD/MZ1NJjc/LfO+j89PzS726b4334TAPJz0HuyM+aUD84GhscoY3j64zk
	ccbpP4GZ03sRsgfjLWBJsp2QJpUS6oRZEhZI2/JxlhT5+0Rabaar6rEXwKRPSUpiccMsFFjh+pv
	FQS5J71L2Q6qfAh37diU3rR2hJYcnA==
X-Received: by 2002:a05:6a00:a95:b0:72d:8fa2:9998 with SMTP id d2e1a72fcca58-72dafa44feamr25589923b3a.14.1737450174431;
        Tue, 21 Jan 2025 01:02:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsv05UklhuL+Dq42AKNGXkM5zlYYzVrxmW+WVLeNtUF+F45Qfg3azzKLJjyIgZjLV6xkQKNg==
X-Received: by 2002:a05:6a00:a95:b0:72d:8fa2:9998 with SMTP id d2e1a72fcca58-72dafa44feamr25589887b3a.14.1737450174015;
        Tue, 21 Jan 2025 01:02:54 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabaa6407sm8528378b3a.163.2025.01.21.01.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 01:02:53 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 21 Jan 2025 14:32:20 +0530
Subject: [PATCH v3 2/4] PCI: dwc: Add ECAM support with iATU configuration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-enable_ecam-v3-2-cd84d3b2a7ba@oss.qualcomm.com>
References: <20250121-enable_ecam-v3-0-cd84d3b2a7ba@oss.qualcomm.com>
In-Reply-To: <20250121-enable_ecam-v3-0-cd84d3b2a7ba@oss.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com, mmareddy@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737450158; l=10160;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=MCubf1WxeyClKc15KlJ1QBlBaJU/1wzFUu/KC1N0k3Y=;
 b=t1NwjmWp53V6acIB+5tp68MSomrAvU0uZgqJWpFPRYs38cFYBt3VcghoQuFWE6PYh4SFrBEH4
 zUsw6hh2T36A62S6+KKpmCF0gG11K6kBz52xEljzsNBlW28hsCRgdtI
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: L1xtfYfmlzOI07ZezJK6CZ7NZYud1VMm
X-Proofpoint-ORIG-GUID: L1xtfYfmlzOI07ZezJK6CZ7NZYud1VMm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_04,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210074

The current implementation requires iATU for every configuration
space access which increases latency & cpu utilization.

Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
would be matched against the Base and Limit addresses) of the incoming
CfgRd0/CfgWr0 down to bits[27:12]of the translated address.

Configuring iATU in config shift feature enables ECAM feature to access the
config space, which avoids iATU configuration for every config access.

Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift feature.

As DBI comes under config space, this avoids remapping of DBI space
separately. Instead, it uses the mapped config space address returned from
ECAM initialization. Change the order of dw_pcie_get_resources() execution
to achieve this.

Enable the ECAM feature if the config space size is equal to size required
to represent number of buses in the bus range property, add a function
which checks this. The DWC glue drivers uses this function and decide to
enable ECAM mode or not.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/Kconfig                |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c | 139 +++++++++++++++++++---
 drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h      |  11 ++
 4 files changed, 133 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index b6d6778b0698..73c3aed6b60a 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -9,6 +9,7 @@ config PCIE_DW
 config PCIE_DW_HOST
 	bool
 	select PCIE_DW
+	select PCI_HOST_COMMON
 
 config PCIE_DW_EP
 	bool
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d2291c3ceb8b..3888f9fe5af1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -418,6 +418,66 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = {0};
+	resource_size_t bus_range_max;
+	struct resource_entry *bus;
+	int ret;
+
+	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
+
+	/*
+	 * Root bus under the root port doesn't require any iATU configuration
+	 * as DBI space will represent Root bus configuration space.
+	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
+	 * remaining buses need type 1 iATU configuration.
+	 */
+	atu.index = 0;
+	atu.type = PCIE_ATU_TYPE_CFG0;
+	atu.cpu_addr = pp->cfg0_base + SZ_1M;
+	atu.size = SZ_1M;
+	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
+	if (ret)
+		return ret;
+
+	bus_range_max = resource_size(bus->res);
+
+	if (bus_range_max < 2)
+		return 0;
+
+	/* Configure remaining buses in type 1 iATU configuration */
+	atu.index = 1;
+	atu.type = PCIE_ATU_TYPE_CFG1;
+	atu.cpu_addr = pp->cfg0_base + SZ_2M;
+	atu.size = (SZ_1M * (bus_range_max - 2));
+	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
+
+	return dw_pcie_prog_outbound_atu(pci, &atu);
+}
+
+static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct resource_entry *bus;
+
+	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
+	if (!bus)
+		return -ENODEV;
+
+	pp->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
+	if (IS_ERR(pp->cfg))
+		return PTR_ERR(pp->cfg);
+
+	pci->dbi_base = pp->cfg->win;
+	pci->dbi_phys_addr = res->start;
+
+	return 0;
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -431,19 +491,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	raw_spin_lock_init(&pp->lock);
 
-	ret = dw_pcie_get_resources(pci);
-	if (ret)
-		return ret;
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
-	if (res) {
-		pp->cfg0_size = resource_size(res);
-		pp->cfg0_base = res->start;
-
-		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
-		if (IS_ERR(pp->va_cfg0_base))
-			return PTR_ERR(pp->va_cfg0_base);
-	} else {
+	if (!res) {
 		dev_err(dev, "Missing *config* reg space\n");
 		return -ENODEV;
 	}
@@ -454,6 +503,31 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	pp->bridge = bridge;
 
+	pp->cfg0_size = resource_size(res);
+	pp->cfg0_base = res->start;
+
+	if (pp->ecam_mode) {
+		ret = dw_pcie_create_ecam_window(pp, res);
+		if (ret)
+			return ret;
+		bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+		pp->bridge->sysdata = pp->cfg;
+		pp->cfg->priv = pp;
+	} else {
+		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
+		if (IS_ERR(pp->va_cfg0_base))
+			return PTR_ERR(pp->va_cfg0_base);
+
+		/* Set default bus ops */
+		bridge->ops = &dw_pcie_ops;
+		bridge->child_ops = &dw_child_pcie_ops;
+		bridge->sysdata = pp;
+	}
+
+	ret = dw_pcie_get_resources(pci);
+	if (ret)
+		goto err_free_ecam;
+
 	/* Get the I/O range from DT */
 	win = resource_list_first_type(&bridge->windows, IORESOURCE_IO);
 	if (win) {
@@ -462,14 +536,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
-	/* Set default bus ops */
-	bridge->ops = &dw_pcie_ops;
-	bridge->child_ops = &dw_child_pcie_ops;
-
 	if (pp->ops->init) {
 		ret = pp->ops->init(pp);
 		if (ret)
-			return ret;
+			goto err_free_ecam;
 	}
 
 	if (pci_msi_enabled()) {
@@ -504,6 +574,12 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	dw_pcie_iatu_detect(pci);
 
+	if (pp->ecam_mode) {
+		ret = dw_pcie_config_ecam_iatu(pp);
+		if (ret)
+			goto err_free_msi;
+	}
+
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
@@ -533,8 +609,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	/* Ignore errors, the link may come up later */
 	dw_pcie_wait_for_link(pci);
 
-	bridge->sysdata = pp;
-
 	ret = pci_host_probe(bridge);
 	if (ret)
 		goto err_stop_link;
@@ -558,6 +632,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
 
+err_free_ecam:
+	if (pp->cfg)
+		pci_ecam_free(pp->cfg);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_init);
@@ -578,6 +656,9 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
+
+	if (pp->cfg)
+		pci_ecam_free(pp->cfg);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
 
@@ -985,3 +1066,23 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
+
+bool dw_pcie_ecam_supported(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct platform_device *pdev = to_platform_device(pci->dev);
+	struct resource *config_res, *bus_range;
+	u64 bus_config_space_count;
+
+	bus_range = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
+	if (!bus_range)
+		return false;
+
+	config_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
+	if (!config_res)
+		return false;
+
+	bus_config_space_count = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;
+
+	return bus_config_space_count >= resource_size(bus_range);
+}
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 6d6cbc8b5b2c..63d36676f858 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -509,7 +509,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	val = PCIE_ATU_ENABLE;
+	val = PCIE_ATU_ENABLE | atu->ctrl2;
 	if (atu->type == PCIE_ATU_TYPE_MSG) {
 		/* The data-less messages only for now */
 		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35a..41022f06572e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -20,6 +20,7 @@
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/pci.h>
+#include <linux/pci-ecam.h>
 #include <linux/reset.h>
 
 #include <linux/pci-epc.h>
@@ -171,6 +172,7 @@
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_CFG_SHIFT_MODE_ENABLE	BIT(28)
 #define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
@@ -342,6 +344,7 @@ struct dw_pcie_ob_atu_cfg {
 	u8 func_no;
 	u8 code;
 	u8 routing;
+	u32 ctrl2;
 	u64 cpu_addr;
 	u64 pci_addr;
 	u64 size;
@@ -379,6 +382,8 @@ struct dw_pcie_rp {
 	bool			use_atu_msg;
 	int			msg_atu_index;
 	struct resource		*msg_res;
+	bool			ecam_mode;
+	struct pci_config_window *cfg;
 };
 
 struct dw_pcie_ep_ops {
@@ -685,6 +690,7 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
 int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
 void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 				       int where);
+bool dw_pcie_ecam_supported(struct dw_pcie_rp *pp);
 #else
 static inline irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
 {
@@ -715,6 +721,11 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 {
 	return NULL;
 }
+
+static inline bool dw_pcie_ecam_supported(struct dw_pcie_rp *pp)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PCIE_DW_EP

-- 
2.34.1


