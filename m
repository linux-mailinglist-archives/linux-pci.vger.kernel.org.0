Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AA47E3F84
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 14:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjKGNE7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 08:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjKGNEn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 08:04:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D955A6;
        Tue,  7 Nov 2023 04:50:48 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7CfWa9011597;
        Tue, 7 Nov 2023 12:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=0GzQyt3T+b2JN0Ik3plxzQ08+JCrd3yB2OuiRYA1+lo=;
 b=cLDhQ4Aw4ZhqnqCH5wldiwAPzh5NklVjcEt+t4wh+U7i77FtrAWhkOHn0CMc3pC51K1b
 kXyhmYTNoPEKuqd6NtrbOK5mE0uhEInueLMRk9Y3jSI9RwgGr44P9KlIysSbZ0Wc84G9
 BF3oUsZEShnT90wDUKxBGJL1NYgzUBZ9Y/JZA6adUy0UGOZ71+0GfphgWvT5LAtKrsgo
 VcGuvMh6yKuQcu1WbycaVdrk022khcs37Qwr9laHWNT2j8eczY8PXw41hDbak9UtZ49q
 ZN6xSSTl2h0ChWjwYywGKmJYxBB8tYAQBYeYyhNEH7A14DG4bagYlK82l+mq5BTlReEL Xg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u7agf1eer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Nov 2023 12:50:39 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3A7CoVjG000705;
        Tue, 7 Nov 2023 12:50:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3u5f1m401a-1;
        Tue, 07 Nov 2023 12:50:35 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7CoZxK000745;
        Tue, 7 Nov 2023 12:50:35 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3A7CoZlg000744;
        Tue, 07 Nov 2023 12:50:35 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 954824C77; Tue,  7 Nov 2023 18:20:34 +0530 (+0530)
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
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev
Subject: [PATCH v7 3/4] PCI: epf-mhi: Add support for SA8775P
Date:   Tue,  7 Nov 2023 18:20:27 +0530
Message-Id: <1699361428-12802-4-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1699361428-12802-1-git-send-email-quic_msarkar@quicinc.com>
References: <1699361428-12802-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qFLRwl1F8RRZmkMcKb0tDrdpUaBZowrG
X-Proofpoint-GUID: qFLRwl1F8RRZmkMcKb0tDrdpUaBZowrG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_04,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=665 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070106
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Qualcomm Snapdragon SA8775P SoC to the EPF driver.
Reusing PID (0x0306) as dedicated PID for SA8775P EP is yet to decide
and it supports HDMA. Currently, it has no fixed PCI class, so it is
being advertised as "PCI_CLASS_OTHERS".

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index b7b9d3e..23ea94e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -114,6 +114,22 @@ static const struct pci_epf_mhi_ep_info sm8450_info = {
 	.flags = MHI_EPF_USE_DMA,
 };
 
+static struct pci_epf_header sa8775p_header = {
+	.vendorid = PCI_VENDOR_ID_QCOM,
+	.deviceid = 0x0306,               /* FIXME: Update deviceid for sa8775p EP */
+	.baseclass_code = PCI_CLASS_OTHERS,
+	.interrupt_pin = PCI_INTERRUPT_INTA,
+};
+
+static const struct pci_epf_mhi_ep_info sa8775p_info = {
+	.config = &mhi_v1_config,
+	.epf_header = &sa8775p_header,
+	.bar_num = BAR_0,
+	.epf_flags = PCI_BASE_ADDRESS_MEM_TYPE_32,
+	.msi_count = 32,
+	.mru = 0x8000,
+};
+
 struct pci_epf_mhi {
 	const struct pci_epc_features *epc_features;
 	const struct pci_epf_mhi_ep_info *info;
@@ -677,6 +693,7 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
 }
 
 static const struct pci_epf_device_id pci_epf_mhi_ids[] = {
+	{ .name = "sa8775p", .driver_data = (kernel_ulong_t)&sa8775p_info },
 	{ .name = "sdx55", .driver_data = (kernel_ulong_t)&sdx55_info },
 	{ .name = "sm8450", .driver_data = (kernel_ulong_t)&sm8450_info },
 	{},
-- 
2.7.4

