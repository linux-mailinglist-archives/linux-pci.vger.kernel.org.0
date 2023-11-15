Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0497EC271
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 13:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbjKOMhX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 07:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343796AbjKOMhU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 07:37:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA03134;
        Wed, 15 Nov 2023 04:37:15 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF9N1pk002619;
        Wed, 15 Nov 2023 12:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=HTm8CF46xBmkgyrV2xIjdBUCdZq+AtWJp3uODOL1kMs=;
 b=fkymIZo5R3NFxRhWqVAWQGp+Fu5xkzbyGYWyVKh9XAnqSZbzTwtyUZcNtqvq1w2/XEPD
 6UZe/p58IY7Mpu6NyaTsAMzWfFJM5lIKC/btJOoihsmAL410qzjdoK+NFh76VhtNi/fg
 9VjN0X8e1SlvY908CB/WCnlqJNJy/MXb8pQlX4BBCdfSGPlIs0ZXu95NnZYqW8UWbMae
 YEiZjZD24LJC3BVhyyZ8liO/NId0myIufai26IXx7fQ5qswP9o7m086YJ5eVnj6R/V6d
 xi3odW3OVO5SPzVrFqNHnGERFKekZACW/JAslV1dnwzSvJNdju14wyj7A0IQHH6/LzDN 5w== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucuac0g0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 12:37:09 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AFCb5wo022076;
        Wed, 15 Nov 2023 12:37:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3ua2pmatv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 Nov 2023 12:37:05 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFCb5dM022063;
        Wed, 15 Nov 2023 12:37:05 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3AFCb5Yh022056;
        Wed, 15 Nov 2023 12:37:05 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 0F9784BD6; Wed, 15 Nov 2023 18:07:04 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijjose@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v3 1/3] PCI: qcom: Enable cache coherency for SA8775P RC
Date:   Wed, 15 Nov 2023 18:06:59 +0530
Message-Id: <1700051821-1087-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700051821-1087-1-git-send-email-quic_msarkar@quicinc.com>
References: <1700051821-1087-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rXxhE9IZE8yfUlt_verTee15m_eT6UG9
X-Proofpoint-GUID: rXxhE9IZE8yfUlt_verTee15m_eT6UG9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_11,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=704
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150097
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This change will enable cache snooping logic to support
cache coherency for 8775 RC platform.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6902e97..b82ccd1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -51,6 +51,7 @@
 #define PARF_SID_OFFSET				0x234
 #define PARF_BDF_TRANSLATE_CFG			0x24c
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
+#define PCIE_PARF_NO_SNOOP_OVERIDE		0x3d4
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
 
@@ -117,6 +118,10 @@
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
 
+/* PARF_NO_SNOOP_OVERIDE register fields */
+#define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
+#define RD_NO_SNOOP_OVERIDE_EN			BIT(3)
+
 /* PARF_DEVICE_TYPE register fields */
 #define DEVICE_TYPE_RC				0x4
 
@@ -961,6 +966,14 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+
+	/* Enable cache snooping for SA8775P */
+	if (of_device_is_compatible(dev->of_node, "qcom,pcie-sa8775p"))
+		writel(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
+				pcie->parf + PCIE_PARF_NO_SNOOP_OVERIDE);
+
 	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
-- 
2.7.4

