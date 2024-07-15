Return-Path: <linux-pci+bounces-10297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B6D931A1B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344BDB22751
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D375F61FFA;
	Mon, 15 Jul 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U7ZzDLCm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D75C77102;
	Mon, 15 Jul 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067289; cv=none; b=P4S8ksFvhjHVTMlBlsCTbUM+xjWPPUXuTM7l+Cm53teviqkKWQTaVSygfgoVEbzi90jHTmcWo6v/nvPxaeJQFjebeidYt+XlcwFqi792CblxJZw0xRaUIevixDlRZKyoaXDQ6ngh13z6qErAqMoh7QyUIYLKQETuzB77CAiYO1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067289; c=relaxed/simple;
	bh=+poeAqJsZY9LbSVXnYITZWtVjYjabmv+yobXW+UrZGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFJ/aFM2hy8IbirLXsou50jN40vrt7WYE0PKXqQCpAV7ur1+PpMX3qCj7sd275PEC+kPgMla47gTSu2T4FGzLkHTBzPx7XbdPAMrR+lKzo01eNHt71cFSlwcuRO9Of04PBCkC8TTGAWl3Ml2PB8pJrXbMzOPpeFpXKKVjo0z2II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U7ZzDLCm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH8h0o002695;
	Mon, 15 Jul 2024 18:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dB1MeVxgK7PLtAVG7XzzE3SB
	RfycrqHx2a72LtOGaCw=; b=U7ZzDLCmlBWqtoTCsAdLwY7WiK8VYzqlSlQlcqRh
	KX6FXwlyTMrJxBiH7fM8iOlRcp1KaPSrRAaZ5WmUp5GF2jhPc02EKriTq2vbCLYt
	ikCX/5Tx62GaEeVivHkSrKXb++w0hXY5uLOeXOTBo5xlkKz8pZGhHs6ldWtgVmwI
	jym85qWdia7CwZdiuDtNo1e6gtQSC4DH9lOaV93nqYz734km80HNVuqzYrydG72P
	PogkUVzSmMzVzKt0SpbR337IZecBbAbyEf8a83RR/cTaThjjACWwHNnkihCcto5O
	nIuHTtFTgyuvx9pBn2tQgsVvZWtAQ0ioJtzWxW6zR5LEhg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bhy6w172-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46FIDq4u027898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:52 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Jul 2024 11:13:52 -0700
From: Mayank Rana <quic_mrana@quicinc.com>
To: <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <cassel@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <s-vadapalli@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>, Mayank Rana <quic_mrana@quicinc.com>
Subject: [PATCH V222/7] PCI: dwc: Add msi_ops to allow DBI based MSI register access
Date: Mon, 15 Jul 2024 11:13:30 -0700
Message-ID: <1721067215-5832-3-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QXnSMJVv9URGOAupC_PenYEsxYQr4cAB
X-Proofpoint-ORIG-GUID: QXnSMJVv9URGOAupC_PenYEsxYQr4cAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150142

PCIe ECAM driver do not have dw_pcie data structure populated and DBI
access related APIs. Hence add msi_ops as part of dw_msi structure to
allow populating DBI based MSI register access.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 20 ++++++++++++-
 drivers/pci/controller/dwc/pcie-designware-msi.c  | 36 +++++++++++++----------
 drivers/pci/controller/dwc/pcie-designware-msi.h  | 10 +++++--
 3 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3dcf88a..7a1eb1f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -47,6 +47,16 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static u32 dw_pcie_readl_msi_dbi(void *pci, u32 reg)
+{
+	return dw_pcie_readl_dbi((struct dw_pcie *)pci, reg);
+}
+
+static void dw_pcie_writel_msi_dbi(void *pci, u32 reg, u32 val)
+{
+	dw_pcie_writel_dbi((struct dw_pcie *)pci, reg, val);
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -55,6 +65,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource_entry *win;
 	struct pci_host_bridge *bridge;
+	struct dw_msi_ops *msi_ops;
 	struct resource *res;
 	bool has_msi_ctrl;
 	int ret;
@@ -124,7 +135,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			if (ret < 0)
 				goto err_deinit_host;
 		} else if (has_msi_ctrl) {
-			pp->msi = dw_pcie_msi_host_init(pdev, pp, pp->num_vectors);
+			msi_ops = devm_kzalloc(dev, sizeof(*msi_ops), GFP_KERNEL);
+			if (msi_ops == NULL)
+				goto err_deinit_host;
+
+			msi_ops->pp = pci;
+			msi_ops->readl_msi = dw_pcie_readl_msi_dbi,
+			msi_ops->writel_msi = dw_pcie_writel_msi_dbi,
+			pp->msi = dw_pcie_msi_host_init(pdev, msi_ops, pp->num_vectors);
 			if (IS_ERR(pp->msi)) {
 				ret = PTR_ERR(pp->msi);
 				goto err_deinit_host;
diff --git a/drivers/pci/controller/dwc/pcie-designware-msi.c b/drivers/pci/controller/dwc/pcie-designware-msi.c
index 39fe5be..dbfffce 100644
--- a/drivers/pci/controller/dwc/pcie-designware-msi.c
+++ b/drivers/pci/controller/dwc/pcie-designware-msi.c
@@ -44,6 +44,16 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
 	.chip	= &dw_pcie_msi_irq_chip,
 };
 
+static u32 dw_msi_readl(struct dw_msi *msi, u32 reg)
+{
+	return msi->msi_ops->readl_msi(msi->msi_ops->pp, reg);
+}
+
+static void dw_msi_writel(struct dw_msi *msi, u32 reg, u32 val)
+{
+	msi->msi_ops->writel_msi(msi->msi_ops->pp, reg, val);
+}
+
 /* MSI int handler */
 irqreturn_t dw_handle_msi_irq(struct dw_msi *msi)
 {
@@ -51,13 +61,11 @@ irqreturn_t dw_handle_msi_irq(struct dw_msi *msi)
 	unsigned long val;
 	u32 status, num_ctrls;
 	irqreturn_t ret = IRQ_NONE;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
 
 	num_ctrls = msi->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 	for (i = 0; i < num_ctrls; i++) {
-		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
-					   (i * MSI_REG_CTRL_BLOCK_SIZE));
+		status = dw_msi_readl(msi, PCIE_MSI_INTR0_STATUS + (i * MSI_REG_CTRL_BLOCK_SIZE));
 		if (!status)
 			continue;
 
@@ -115,7 +123,6 @@ static int dw_pci_msi_set_affinity(struct irq_data *d,
 static void dw_pci_bottom_mask(struct irq_data *d)
 {
 	struct dw_msi *msi = irq_data_get_irq_chip_data(d);
-	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
 	unsigned int res, bit, ctrl;
 	unsigned long flags;
 
@@ -126,7 +133,7 @@ static void dw_pci_bottom_mask(struct irq_data *d)
 	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 	msi->irq_mask[ctrl] |= BIT(bit);
-	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, msi->irq_mask[ctrl]);
+	dw_msi_writel(msi, PCIE_MSI_INTR0_MASK + res, msi->irq_mask[ctrl]);
 
 	raw_spin_unlock_irqrestore(&msi->lock, flags);
 }
@@ -134,7 +141,6 @@ static void dw_pci_bottom_mask(struct irq_data *d)
 static void dw_pci_bottom_unmask(struct irq_data *d)
 {
 	struct dw_msi *msi = irq_data_get_irq_chip_data(d);
-	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
 	unsigned int res, bit, ctrl;
 	unsigned long flags;
 
@@ -145,7 +151,7 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
 	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
 	msi->irq_mask[ctrl] &= ~BIT(bit);
-	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, msi->irq_mask[ctrl]);
+	dw_msi_writel(msi, PCIE_MSI_INTR0_MASK + res, msi->irq_mask[ctrl]);
 
 	raw_spin_unlock_irqrestore(&msi->lock, flags);
 }
@@ -153,14 +159,13 @@ static void dw_pci_bottom_unmask(struct irq_data *d)
 static void dw_pci_bottom_ack(struct irq_data *d)
 {
 	struct dw_msi *msi  = irq_data_get_irq_chip_data(d);
-	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
 	unsigned int res, bit, ctrl;
 
 	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
 	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_STATUS + res, BIT(bit));
+	dw_msi_writel(msi, PCIE_MSI_INTR0_STATUS + res, BIT(bit));
 }
 
 static struct irq_chip dw_pci_msi_bottom_irq_chip = {
@@ -262,7 +267,6 @@ void dw_pcie_free_msi(struct dw_msi *msi)
 
 void dw_pcie_msi_init(struct dw_msi *msi)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
 	u32 ctrl, num_ctrls;
 	u64 msi_target;
 
@@ -273,16 +277,16 @@ void dw_pcie_msi_init(struct dw_msi *msi)
 	num_ctrls = msi->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 	/* Initialize IRQ Status array */
 	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
+		dw_msi_writel(msi, PCIE_MSI_INTR0_MASK +
 				(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
 				msi->irq_mask[ctrl]);
-		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
+		dw_msi_writel(msi, PCIE_MSI_INTR0_ENABLE +
 				(ctrl * MSI_REG_CTRL_BLOCK_SIZE), ~0);
 	}
 
 	/* Program the msi_data */
-	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
-	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
+	dw_msi_writel(msi, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
+	dw_msi_writel(msi, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
 }
 
 static int dw_pcie_parse_split_msi_irq(struct dw_msi *msi, struct platform_device *pdev)
@@ -324,7 +328,7 @@ static int dw_pcie_parse_split_msi_irq(struct dw_msi *msi, struct platform_devic
 }
 
 struct dw_msi *dw_pcie_msi_host_init(struct platform_device *pdev,
-				void *pp, u32 num_vectors)
+				struct dw_msi_ops *ops, u32 num_vectors)
 {
 	struct device *dev = &pdev->dev;
 	u64 *msi_vaddr = NULL;
@@ -341,7 +345,7 @@ struct dw_msi *dw_pcie_msi_host_init(struct platform_device *pdev,
 
 	raw_spin_lock_init(&msi->lock);
 	msi->dev = dev;
-	msi->pp = pp;
+	msi->msi_ops = ops;
 	msi->has_msi_ctrl = true;
 	msi->num_vectors = num_vectors;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-msi.h b/drivers/pci/controller/dwc/pcie-designware-msi.h
index 633156e..cf5c612 100644
--- a/drivers/pci/controller/dwc/pcie-designware-msi.h
+++ b/drivers/pci/controller/dwc/pcie-designware-msi.h
@@ -18,8 +18,15 @@
 #define MSI_REG_CTRL_BLOCK_SIZE		12
 #define MSI_DEF_NUM_VECTORS		32
 
+struct dw_msi_ops {
+	void	*pp;
+	u32	(*readl_msi)(void *pp, u32 reg);
+	void	(*writel_msi)(void *pp, u32 reg, u32 val);
+};
+
 struct dw_msi {
 	struct device		*dev;
+	struct dw_msi_ops	*msi_ops;
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
 	struct irq_chip		*msi_irq_chip;
@@ -31,11 +38,10 @@ struct dw_msi {
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 	bool                    has_msi_ctrl;
 	void			*private_data;
-	void			*pp;
 };
 
 struct dw_msi *dw_pcie_msi_host_init(struct platform_device *pdev,
-			void *pp, u32 num_vectors);
+			struct dw_msi_ops *ops, u32 num_vectors);
 int dw_pcie_allocate_domains(struct dw_msi *msi);
 void dw_pcie_msi_init(struct dw_msi *msi);
 void dw_pcie_free_msi(struct dw_msi *msi);
-- 
2.7.4


