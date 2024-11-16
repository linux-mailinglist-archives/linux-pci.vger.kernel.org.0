Return-Path: <linux-pci+bounces-16993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6769D0129
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 23:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A296EB2567B
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 22:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EB21B9835;
	Sat, 16 Nov 2024 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TNQJ2RY7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F2B1B2190;
	Sat, 16 Nov 2024 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731794468; cv=none; b=HjPTIXD27s/r5HBwGXKG8xyAQLuvKJc9K5FYElbqQmHa/UCA36ek+QEHiKzWcIfuY+fDe2+pKgFa+NMzjPLWVJYMA1BngqSjb4f0RxvNUC4kvm2ir463Av6CQYANdjTKiQmEbXUz5PZF4qBFWwcyPH6wQ+QceuvdzCkCELBnyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731794468; c=relaxed/simple;
	bh=pvMr8lq/Mb8Gknmhhljff2OQb8275sOKyFDvAfAIH8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LaDj2JDJxd5UXnWSu7JBlbKlp1vN+sxNVlFomtbnsCJfJUUlH8zxecObEzyEaXTHqghjTVcIouG3jydwKUyQe/RITegbB6CZz2S7Sfr90+9Q9nRN7la8e3micG/j+07VovP9LnhB6mNhnXrexKXZtFJyFzZN+SFS9FYsxeohs10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TNQJ2RY7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGLvQWi017227;
	Sat, 16 Nov 2024 22:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LZ8QPSnCXhWK5kFmKgLsquT767E0X0q1xbRLoR+JhOI=; b=TNQJ2RY7nfmP2iy5
	guon6JesoijFISnaHgg43YdmYbUBsMBf2RJDXA8lnx0PkVoXamQwMaBEkzDLjpBT
	qNwHDDYHk9HEiFEvLXRxYfkibdb6rAIfmnHOTFT0wJAJF1pdPvXIUWNtiff2A+RE
	xdKpVyn3QjjN4Oc3C+n7+UaKcIcUirlq8KJKry6e/EDc6OXtQMDeqJF94YbMYPOj
	B04yM14DA6MmIinVCDzz7f1AZQPCqckiEnSElMr8RnQv28i2SpgOFu384AVsvUPr
	YpB0gsrgR6EgwIPloSonMvv8mWulqpqHl7izSk0M3h4QF6Ld1jVMevXoyn+CLr7v
	o5F6Ow==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42xksqhbkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 22:00:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AGM0hBs006547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 22:00:43 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 16 Nov 2024 14:00:37 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sun, 17 Nov 2024 03:30:19 +0530
Subject: [PATCH 2/3] PCI: dwc: Add ECAM support with iATU configuration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241117-ecam-v1-2-6059faf38d07@quicinc.com>
References: <20241117-ecam-v1-0-6059faf38d07@quicinc.com>
In-Reply-To: <20241117-ecam-v1-0-6059faf38d07@quicinc.com>
To: <cros-qcom-dts-watchers@chromium.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_mrana@quicinc.com>,
        <mmareddy@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731794424; l=8047;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=pvMr8lq/Mb8Gknmhhljff2OQb8275sOKyFDvAfAIH8U=;
 b=QArXG/eRKX+OiOO+z6FguI14vwRaO1c1xJ1PjVopxzPKW/wpMh482CdaDlxThDJ9zekkY4f6z
 DAF2fYE/03VB70UgS0cGAfJ/FGN2bWlmZGvkGWWZBrHUpgijAtfaNtk
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: R6O9Mfq1Mrd8gC6Jnlm8qBljqEpUhksp
X-Proofpoint-ORIG-GUID: R6O9Mfq1Mrd8gC6Jnlm8qBljqEpUhksp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411160192

The current implementation requires iATU for every configuration
space access which increases latency & cpu utilization.

Configuring iATU in config shift mode enables ECAM feature to access the
config space, which avoids iATU configuration for every config access.

Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift mode.

As DBI comes under config space, this avoids remapping of DBI space
separately. Instead, it uses the mapped config space address returned from
ECAM initialization. Change the order of dw_pcie_get_resources() execution
to acheive this.

Introduce new ecam_init() function op for the clients to configure after
ecam window creation has been done.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 114 ++++++++++++++++++----
 drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
 drivers/pci/controller/dwc/pcie-designware.h      |   6 ++
 3 files changed, 102 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c7290..e98cc841a2a9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -418,6 +418,62 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct dw_pcie_ob_atu_cfg atu = {0};
+	struct resource_entry *bus;
+	int ret, bus_range_max;
+
+	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
+
+	/*
+	 * Bus 1 config space needs type 0 atu configuration
+	 * Remaining buses need type 1 atu configuration
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
+	bus_range_max = bus->res->end - bus->res->start + 1;
+
+	/* Configure for bus 2 - bus_range_max in type 1 */
+	atu.index = 1;
+	atu.type = PCIE_ATU_TYPE_CFG1;
+	atu.cpu_addr = pp->cfg0_base + SZ_2M;
+	atu.size = (SZ_1M * (bus_range_max - 2));
+	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
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
+	if (pp->ops->ecam_init)
+		pp->ops->ecam_init(pci, pp->cfg);
+
+	return 0;
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -431,19 +487,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
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
@@ -454,6 +499,30 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	pp->bridge = bridge;
 
+	pp->cfg0_size = resource_size(res);
+	pp->cfg0_base = res->start;
+
+	if (!pp->enable_ecam) {
+		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
+		if (IS_ERR(pp->va_cfg0_base))
+			return PTR_ERR(pp->va_cfg0_base);
+
+		/* Set default bus ops */
+		bridge->ops = &dw_pcie_ops;
+		bridge->child_ops = &dw_child_pcie_ops;
+		bridge->sysdata = pp;
+	} else {
+		ret = dw_pcie_create_ecam_window(pp, res);
+		if (ret)
+			return ret;
+		bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
+		pp->bridge->sysdata = pp->cfg;
+	}
+
+	ret = dw_pcie_get_resources(pci);
+	if (ret)
+		goto err_free_ecam;
+
 	/* Get the I/O range from DT */
 	win = resource_list_first_type(&bridge->windows, IORESOURCE_IO);
 	if (win) {
@@ -462,14 +531,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -504,6 +569,12 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	dw_pcie_iatu_detect(pci);
 
+	if (pp->enable_ecam) {
+		ret = dw_pcie_config_ecam_iatu(pp);
+		if (ret)
+			goto err_free_msi;
+	}
+
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
@@ -533,8 +604,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	/* Ignore errors, the link may come up later */
 	dw_pcie_wait_for_link(pci);
 
-	bridge->sysdata = pp;
-
 	ret = pci_host_probe(bridge);
 	if (ret)
 		goto err_stop_link;
@@ -558,6 +627,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
 
+err_free_ecam:
+	if (pp->cfg)
+		pci_ecam_free(pp->cfg);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_init);
@@ -578,6 +651,9 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
+
+	if (pp->cfg)
+		pci_ecam_free(pp->cfg);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
 
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
index 347ab74ac35a..33afa91b402c 100644
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
@@ -353,6 +356,7 @@ struct dw_pcie_host_ops {
 	void (*post_init)(struct dw_pcie_rp *pp);
 	int (*msi_init)(struct dw_pcie_rp *pp);
 	void (*pme_turn_off)(struct dw_pcie_rp *pp);
+	int (*ecam_init)(struct dw_pcie *pcie, struct pci_config_window *cfg);
 };
 
 struct dw_pcie_rp {
@@ -379,6 +383,8 @@ struct dw_pcie_rp {
 	bool			use_atu_msg;
 	int			msg_atu_index;
 	struct resource		*msg_res;
+	bool			enable_ecam;
+	struct pci_config_window *cfg;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.34.1


