Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB877EC280
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 13:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbjKOMiA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 07:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343794AbjKOMh6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 07:37:58 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A19125;
        Wed, 15 Nov 2023 04:37:55 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFAdwQe032479;
        Wed, 15 Nov 2023 12:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=yvsrz7gI4WoOCC7ibHaISLNGWUyLEnOYhiZTDogf9rI=;
 b=MDO/FWhOtuNQn9OsKZW3y3ycmVtMYlHHk8sDNtt7gpAZ/xZoYAdHTtIiXdGkiP3FglEU
 Z+DITDR62KQq/vkUH+1ap3eFnfSAXfuJEXvdHiXceLkjJY7nVU3pik/8MgmJBOessl1U
 hNNze4wtf8X6W57iWHpDYvVaUgvULPWVxaiP6VsjQjmgJ5HFKO1xPGyrUHHk1mrTz7Tx
 nKh7vH2pKAltWc8iDkGefZLBxUW+CDrFIxRMv7sFMo+J/m75/53xvECNDxq+XliN1sQ6
 TpDOhDRHpVcakIhuwxFSF1zta5Jm3pGkMblV9R0w7ICfBgX5aj0BJWTZ2kMZEnJPy9pm 3A== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucq5f8ydx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 12:37:47 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AFCb62t022140;
        Wed, 15 Nov 2023 12:37:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3ua2pmatvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 15 Nov 2023 12:37:06 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFCb6Dn022085;
        Wed, 15 Nov 2023 12:37:06 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3AFCb5JF022079;
        Wed, 15 Nov 2023 12:37:06 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 024024BD5; Wed, 15 Nov 2023 18:07:05 +0530 (+0530)
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
Subject: [PATCH v3 2/3] PCI: qcom-ep: Enable cache coherency for SA8775P EP
Date:   Wed, 15 Nov 2023 18:07:00 +0530
Message-Id: <1700051821-1087-3-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1700051821-1087-1-git-send-email-quic_msarkar@quicinc.com>
References: <1700051821-1087-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fQE39bTScXvFrjGSvMmT8VSy4mgmWlID
X-Proofpoint-ORIG-GUID: fQE39bTScXvFrjGSvMmT8VSy4mgmWlID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_11,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 mlxlogscore=564
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150097
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This change will enable cache snooping logic to support
cache coherency for 8775 EP platform.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 3a53d97..ee99fb1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -47,6 +47,7 @@
 #define PARF_DBI_BASE_ADDR_HI			0x354
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
 #define PARF_SLV_ADDR_SPACE_SIZE_HI		0x35c
+#define PCIE_PARF_NO_SNOOP_OVERIDE		0x3d4
 #define PARF_ATU_BASE_ADDR			0x634
 #define PARF_ATU_BASE_ADDR_HI			0x638
 #define PARF_SRIS_MODE				0x644
@@ -86,6 +87,10 @@
 #define PARF_DEBUG_INT_CFG_BUS_MASTER_EN	BIT(2)
 #define PARF_DEBUG_INT_RADM_PM_TURNOFF		BIT(3)
 
+/* PARF_NO_SNOOP_OVERIDE register fields */
+#define WR_NO_SNOOP_OVERIDE_EN                 BIT(1)
+#define RD_NO_SNOOP_OVERIDE_EN                 BIT(3)
+
 /* PARF_DEVICE_TYPE register fields */
 #define PARF_DEVICE_TYPE_EP			0x0
 
@@ -489,6 +494,11 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	val |= BIT(8);
 	writel_relaxed(val, pcie_ep->parf + PARF_LTSSM);
 
+	/* Enable cache snooping for SA8775P */
+	if (of_device_is_compatible(dev->of_node, "qcom,sa8775p-pcie-ep"))
+		writel_relaxed(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
+				pcie_ep->parf + PCIE_PARF_NO_SNOOP_OVERIDE);
+
 	return 0;
 
 err_disable_resources:
-- 
2.7.4

