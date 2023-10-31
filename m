Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35B57DD0E0
	for <lists+linux-pci@lfdr.de>; Tue, 31 Oct 2023 16:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjJaPqt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Oct 2023 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjJaPqq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Oct 2023 11:46:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB258F;
        Tue, 31 Oct 2023 08:46:44 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VDtaLK028022;
        Tue, 31 Oct 2023 15:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=4i+UjBfccEyJpR7mWsj2oJ8qwKh7n8PKP5gW4vRIGxk=;
 b=YAvO9vgcK6wV6pTjlmn/llUkdKeXLB1kg19s9QuVFBij8XeuId7VfdCUwLifQUSLt93e
 33oNLcoAhVqTXoDZP8UxvlFpZ5noMiyjYv+/KBW5HaPo2RN5oEFWknjv4lJdwIP8dzLs
 6HlFkA8fvJIJ3udmQeXQteNwxSaCeRIswZm94FzywVoJ4mfB22zaHNVwJx3R+akhDxSW
 ju2TNPu4do+nJNvDzyrWVE/6+U8n23uruQmAUz6DOWhIhdimlvFIG9tqAqjMwTkjj8CE
 iys24o3CDP5GEyH/mjJ0rBydhBfEor5doJm+DfoPwhsfqz5Hpk1HxEX55cU4AD18F1s5 fw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2tpx1sm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 15:46:37 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39VFdoOv032117;
        Tue, 31 Oct 2023 15:46:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3u0uckx0ur-1;
        Tue, 31 Oct 2023 15:46:34 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39VFkYkj006383;
        Tue, 31 Oct 2023 15:46:34 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 39VFkY1Z006381;
        Tue, 31 Oct 2023 15:46:34 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id BDA7D4BFB; Tue, 31 Oct 2023 21:16:33 +0530 (+0530)
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
Subject: [PATCH v1 2/3] PCI: qcom-ep: Enable cache coherency for SA8775P EP
Date:   Tue, 31 Oct 2023 21:16:25 +0530
Message-Id: <1698767186-5046-3-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698767186-5046-1-git-send-email-quic_msarkar@quicinc.com>
References: <1698767186-5046-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9j63HvsVa2RRkPPU5Z6xQah4FGL9a9tD
X-Proofpoint-GUID: 9j63HvsVa2RRkPPU5Z6xQah4FGL9a9tD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_02,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=570
 priorityscore=1501 mlxscore=0 suspectscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310125
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This change will enable cache snooping logic to support
cache coherency for SA8755P EP platform.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 3a53d97..bc958a0 100644
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
@@ -86,6 +87,9 @@
 #define PARF_DEBUG_INT_CFG_BUS_MASTER_EN	BIT(2)
 #define PARF_DEBUG_INT_RADM_PM_TURNOFF		BIT(3)
 
+/* PARF_NO_SNOOP_OVERIDE register value */
+#define NO_SNOOP_OVERIDE_EN			0xa
+
 /* PARF_DEVICE_TYPE register fields */
 #define PARF_DEVICE_TYPE_EP			0x0
 
@@ -489,6 +493,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	val |= BIT(8);
 	writel_relaxed(val, pcie_ep->parf + PARF_LTSSM);
 
+	/* Enable cache snooping for SA8775P */
+	if (of_device_is_compatible(dev->of_node, "qcom,sa8775p-pcie-ep"))
+		writel_relaxed(NO_SNOOP_OVERIDE_EN, pcie_ep->parf + PCIE_PARF_NO_SNOOP_OVERIDE);
+
 	return 0;
 
 err_disable_resources:
-- 
2.7.4

