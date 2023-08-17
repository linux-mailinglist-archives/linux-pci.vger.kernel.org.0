Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBEB77EF24
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 04:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347645AbjHQCf0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 22:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347655AbjHQCfN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 22:35:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F2726B6;
        Wed, 16 Aug 2023 19:35:12 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H2Yp4H022386;
        Thu, 17 Aug 2023 02:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=rCzluOKI0Lk0lfcL1JcHVEYhlSjayyn8DN/IyFNCaUU=;
 b=SXmhu44jQnZ85yBfKnsMviDwesLumQeVDhJ9LPaZZ8n+3WtS6AlbujYfLgkV9rUatldm
 asuMGQi8+K+SmxbE8pxkLIcLT4zYDf1VRAxlOwa9QSDXmbnhwuci7Tox3GYAcxs02LHl
 F0IZ7XO5LFOyrd2SM0PgmlXcNQbagE+VCbdzxbPMuw56durYEvzizzmm7yTYy21iEAK3
 S0dDIWbTjFnCQPoXQ5sMThuyCTGngJiwrS+pzuDLLSvmLFFsqbpS44wdZaXsKisU+4Ho
 zCpvrkTcbicR9MX5gPSTzVZhVnVlPHKMV4Cjfm+WAyJ8Ub3unZU0NCHRatVA2kmnt/Wt SQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sgf5ub96d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 02:34:51 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 37H2Yl5C020718;
        Thu, 17 Aug 2023 02:34:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3se35mdvyu-1;
        Thu, 17 Aug 2023 02:34:47 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37H2YlcA020712;
        Thu, 17 Aug 2023 02:34:47 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 37H2YlnX020709;
        Thu, 17 Aug 2023 02:34:47 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id B79142A11; Thu, 17 Aug 2023 08:04:46 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1] PCI: qcom: Add sysfs entry to change link speed dynamically
Date:   Thu, 17 Aug 2023 08:04:43 +0530
Message-Id: <1692239684-12697-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: v1u6mfp2FZUsI_rTGmRrcaC_yfh-83TN
X-Proofpoint-GUID: v1u6mfp2FZUsI_rTGmRrcaC_yfh-83TN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_21,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 mlxlogscore=752 clxscore=1015 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170021
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe can operate on lower GEN speed if client decided based upon
the bandwidth & latency requirements. To support dynamic GEN speed
switch adding this sysfs support.

To change the GEN speed the link should be in L0, so first disable
L0s & L1.

L0s needs to be disabled at both RC & EP because L0s entry is
independent. For enabling L0s both ends of the link needs to support
it, so first check if L0s is supported on both ends and then enable
L0s.

This patch is dependent on "PCI: qcom: Add support for OPP"
https://lore.kernel.org/linux-arm-msm/1692192264-18515-1-git-send-email-quic_krichai@quicinc.com/T/#t

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 141 +++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 831d158..ad67d17 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -241,10 +241,150 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
+	bool l0s_supported;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
 
+static void qcom_pcie_icc_update(struct qcom_pcie *pcie);
+static void qcom_pcie_opp_update(struct qcom_pcie *pcie);
+
+static int qcom_pcie_disable_l0s(struct pci_dev *pdev, void *userdata)
+{
+	int lnkctl;
+
+	pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCTL, &lnkctl);
+	lnkctl &= ~(PCI_EXP_LNKCTL_ASPM_L0S);
+	pci_write_config_word(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCTL, lnkctl);
+
+	return 0;
+}
+
+static int qcom_pcie_check_l0s_support(struct pci_dev *pdev, void *userdata)
+{
+	struct pci_dev *parent = pdev->bus->self;
+	struct qcom_pcie *pcie = userdata;
+	struct dw_pcie *pci = pcie->pci;
+	int lnkcap;
+
+	 /* check parent supports L0s */
+	if (parent) {
+		dev_err(pci->dev, "parent\n");
+		pci_read_config_dword(parent, pci_pcie_cap(parent) + PCI_EXP_LNKCAP,
+				  &lnkcap);
+		if (!(lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)) {
+			dev_info(pci->dev, "Parent does not support L0s\n");
+			pcie->l0s_supported = false;
+			return 0;
+		}
+	}
+
+	pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
+			  &lnkcap);
+	dev_err(pci->dev, "child %x\n", lnkcap);
+	if (!(lnkcap & PCI_EXP_LNKCAP_ASPM_L0S)) {
+		dev_info(pci->dev, "Device does not support L0s\n");
+		pcie->l0s_supported = false;
+		return 0;
+	}
+
+	return 0;
+}
+
+static int qcom_pcie_enable_l0s(struct pci_dev *pdev, void *userdata)
+{
+	int lnkctl;
+
+	pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCTL, &lnkctl);
+	lnkctl |= (PCI_EXP_LNKCTL_ASPM_L0S);
+	pci_write_config_word(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCTL, lnkctl);
+
+	return 0;
+}
+
+static ssize_t qcom_pcie_speed_change_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t count)
+{
+	unsigned int current_speed, target_speed, max_speed;
+	struct qcom_pcie *pcie = dev_get_drvdata(dev);
+	struct pci_bus *child, *root_bus = NULL;
+	struct dw_pcie_rp *pp = &pcie->pci->pp;
+	struct dw_pcie *pci = pcie->pci;
+	struct pci_dev *pdev;
+	u16 offset;
+	u32 val;
+	int ret;
+
+	list_for_each_entry(child, &pp->bridge->bus->children, node) {
+		if (child->parent == pp->bridge->bus) {
+			root_bus = child;
+			break;
+		}
+	}
+
+	pdev = root_bus->self;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+
+	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
+	max_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
+
+	val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+	current_speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, val);
+
+	ret = kstrtouint(buf, 10, &target_speed);
+	if (ret)
+		return ret;
+
+	if (target_speed > max_speed)
+		return -EINVAL;
+
+	if (current_speed == target_speed)
+		return count;
+
+	pci_walk_bus(pp->bridge->bus, qcom_pcie_disable_l0s, pcie);
+
+	/* Disable L1 */
+	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL);
+	val &= ~(PCI_EXP_LNKCTL_ASPM_L1);
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL, val);
+
+	/* Set target GEN speed */
+	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL2);
+	val &= ~PCI_EXP_LNKCTL2_TLS;
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL2, val | target_speed);
+
+	ret = pcie_retrain_link(pdev, true);
+	if (ret)
+		dev_err(dev, "Link retrain failed %d\n", ret);
+
+	/* Enable L1 */
+	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCTL);
+	val |= (PCI_EXP_LNKCTL_ASPM_L1);
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCTL, val);
+
+	pcie->l0s_supported = true;
+	pci_walk_bus(pp->bridge->bus, qcom_pcie_check_l0s_support, pcie);
+
+	if (pcie->l0s_supported)
+		pci_walk_bus(pp->bridge->bus, qcom_pcie_enable_l0s, pcie);
+
+	qcom_pcie_icc_update(pcie);
+
+	qcom_pcie_opp_update(pcie);
+
+	return count;
+}
+static DEVICE_ATTR_WO(qcom_pcie_speed_change);
+
+static struct attribute *qcom_pcie_attrs[] = {
+	&dev_attr_qcom_pcie_speed_change.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(qcom_pcie);
+
 static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
 {
 	gpiod_set_value_cansleep(pcie->reset, 1);
@@ -1716,6 +1856,7 @@ static struct platform_driver qcom_pcie_driver = {
 		.of_match_table = qcom_pcie_match,
 		.pm = &qcom_pcie_pm_ops,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.dev_groups = qcom_pcie_groups,
 	},
 };
 builtin_platform_driver(qcom_pcie_driver);
-- 
2.7.4

