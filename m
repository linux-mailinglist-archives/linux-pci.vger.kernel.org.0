Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5309876341A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 12:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjGZKnP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 06:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjGZKnO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 06:43:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421CA212B;
        Wed, 26 Jul 2023 03:43:13 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q7R7mY007763;
        Wed, 26 Jul 2023 10:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Hlj89nR2ktz7oEB/4DNcUsbBiauYQu5YgEhQRa/Z55c=;
 b=hZJu26xMO93gWMXYCXiH55vxHgPBRPbXmWH2z81XKc6rodkoQTQ3mdsRfWpBhtL1cxai
 tmSenbFbdZJ5BhA4QytnUDdT0yy/dvv2YsG/4Y+3+5n697ytk7nDTD6sgMn1sk4Ti/PL
 WUyaS+NUIQA40pQcmAIrzXEvFph2KK0nS+7gMYN5OCj8P+oqLdnN3FdVSbcBqk4WeHzo
 nXd6rbJ9or9laKQ75bKGiNr991Zcx2Goxp65UHCWxN6amHhiS+tfO0AWN5DU2QBzhDJF
 cTsj7vtyRJF2JER7s82fp29rjcq0cVHtX/IQyet7NKmc8jpJN/KNS2F9Vl1wnZIBNZH8 2Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2vq9gmsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 10:43:06 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36QAh55s016532
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 10:43:05 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 03:43:01 -0700
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <mani@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>
Subject: [PATCH v2] PCI: qcom: Set max payload size 256 bytes for IPQ9574
Date:   Wed, 26 Jul 2023 16:12:49 +0530
Message-ID: <20230726104249.534210-1-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HXwrTeDwQ53XZ5y_WOPeY3ih8y_taJ3Z
X-Proofpoint-GUID: HXwrTeDwQ53XZ5y_WOPeY3ih8y_taJ3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_04,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 clxscore=1015 mlxlogscore=824 spamscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307260094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch sets 256 bytes as payload size for IPQ9574. This allows
PCIe RC to use the max payload size when a capable link partner is
connected.

Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
---
[v2]:
	Dropped cover letter for this patch. Configured the max payload
	in the post_init of IPQ9574 instead for early fixup.

 drivers/pci/controller/dwc/pcie-qcom.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 8ee7c2b5de27..739c0d514a96 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1145,6 +1145,15 @@ static int qcom_pcie_post_init(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
 {
+	struct dw_pcie *pci = pcie->pci;
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 val;
+
+	val = readl(pci->dbi_base + offset + PCI_EXP_DEVCTL);
+	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	val |= PCI_EXP_DEVCTL_PAYLOAD_256B;
+	writel(val, pci->dbi_base + offset + PCI_EXP_DEVCTL);
+
 	writel(SLV_ADDR_SPACE_SZ_1_27_0,
 	       pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
 
-- 
2.34.1

