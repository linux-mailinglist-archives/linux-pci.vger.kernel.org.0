Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607EC75F6C4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 14:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjGXMsJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 08:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjGXMsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 08:48:01 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AB1E63;
        Mon, 24 Jul 2023 05:47:38 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OCdNMx015189;
        Mon, 24 Jul 2023 12:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ydsySNg3Q4jb9ZF8E2mxqDsppYBtg+mgK0htP0/P++8=;
 b=GeJ0m14BtIZMHrXqvwbe0Z/p+6eYj+E6y0Fx2XQshZ5+iMpYhPBoyv4TbjxVFeIaQNhI
 i8C0cmE8h6S7gzhJrreKDcpKVpQDPAhIDf5RIRutWSqjGSeJZmS3YQCO9E85gOX98T9A
 o/ra386jGX6Or5fx668kgQdvRdZBVX1DxQUMTn7Rfd+1L3HRz67ft13zrGAX3qDtMCcc
 BSPgEXBB6QiIMuWGNEzjPw7Y4Hwb/GGgPOXWgIID8K5N8PWMEyHBqjio4Oz0GtpXoooK
 kOtG0mA8EspRuIgG5KEIj6gjOrpTbm8zDVRU3TiAtkjIWKHIutSA5dNb33+MgAkiCUy3 bg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s08deu6j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 12:47:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OClUmN000608
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 12:47:30 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 24 Jul 2023 05:47:26 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <mani@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>
Subject: [PATCH 1/1] PCI: qcom: Add early fixup to set the max payload size for IPQ9574
Date:   Mon, 24 Jul 2023 18:17:11 +0530
Message-ID: <20230724124711.2346886-2-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724124711.2346886-1-quic_ipkumar@quicinc.com>
References: <20230724124711.2346886-1-quic_ipkumar@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qrwMwwu4YmBCpcOPEpZY0lXkGqd2xOFP
X-Proofpoint-ORIG-GUID: qrwMwwu4YmBCpcOPEpZY0lXkGqd2xOFP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_09,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=771 spamscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240113
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set 256 bytes as payload size for IPQ9574 via early fixup. This allows
PCIe RC to use the max payload size when a capable link partner is
connected.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
This patch depends on the below series which adds support for PCIe
controllers in IPQ9574
https://lore.kernel.org/linux-arm-msm/20230519090219.15925-1-quic_devipriy@quicinc.com/

 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index cee4e400a695..6695bc3b122f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1631,6 +1631,11 @@ static void qcom_fixup_class(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
 }
+
+static void qcom_fixup_mps_256(struct pci_dev *dev)
+{
+	pcie_set_mps(dev, 256);
+}
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0101, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0104, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0106, qcom_fixup_class);
@@ -1638,6 +1643,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0107, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x0302, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1000, qcom_fixup_class);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1001, qcom_fixup_class);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_QCOM, 0x1108, qcom_fixup_mps_256);
 
 static const struct dev_pm_ops qcom_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(qcom_pcie_suspend_noirq, qcom_pcie_resume_noirq)
-- 
2.34.1

