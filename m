Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488157439EA
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 12:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjF3Kwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 06:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjF3Kwc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 06:52:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2315635AF;
        Fri, 30 Jun 2023 03:52:31 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U5LCB1020100;
        Fri, 30 Jun 2023 10:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=yoqAwqb4UmnZXTKQ6pQCHhmtr5plOyugizSdTRJ3bcw=;
 b=LhHAsm7Upcxr88RExcv0ByJoESZ+EEzkHoerfAH+Tp9C0TxVFEBFYJpRg6kRX+63TUZh
 rWrt027QXCv1aJgVmkn/QyedKclZR0bB4BjWLCPtADuRlmr0vFR4Se4m9FUFCWn8S/1z
 ccA8WEmqjJ3vGdFF6ZkFc81RV0efcoYk078b5CfpCwLnErmRdeTSzgUVMXcUgG/ZdKFN
 qQ3dcuERA72NLPXXfBotSlw2xYvI072Hd7fnMlJzQuhKXr7OMo61+8OToNp4DZk/AX5p
 X03BTYZ4C20lYvYlwGm4eAiMMETyhYJCfe4un7poVrk4wZ45k9+Z/uiAUoWpZyi/XSW9 qA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rha8e2f2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 10:52:20 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35UAqH2N004744;
        Fri, 30 Jun 2023 10:52:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rdsjkpf2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Jun 2023 10:52:17 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UAqHvt004730;
        Fri, 30 Jun 2023 10:52:17 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 35UAqGFG004718;
        Fri, 30 Jun 2023 10:52:16 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 38E374AC3; Fri, 30 Jun 2023 16:22:16 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 5/8] pci: dwc: Add wakeup host op to pci_epc_ops
Date:   Fri, 30 Jun 2023 16:22:08 +0530
Message-Id: <1688122331-25478-6-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
References: <1688122331-25478-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7-MDDinAiM0VZ2_YoaxYJyrMpMhPC4z_
X-Proofpoint-ORIG-GUID: 7-MDDinAiM0VZ2_YoaxYJyrMpMhPC4z_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=711 clxscore=1011 impostorscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300092
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add wakeup host op to wake up host from D3cold or D3hot.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f9182f8..7474849 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -463,6 +463,17 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+static int dw_pcie_ep_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				enum pci_epc_wakeup_host_type type)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+
+	if (!ep->ops->wakeup_host)
+		return -EINVAL;
+
+	return ep->ops->wakeup_host(ep, func_no, type);
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -477,6 +488,7 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.wakeup_host		= dw_pcie_ep_wakeup_host,
 };
 
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 6156606..79df866 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -330,6 +330,9 @@ struct dw_pcie_ep_ops {
 	 * driver.
 	 */
 	unsigned int (*func_conf_select)(struct dw_pcie_ep *ep, u8 func_no);
+
+	int	(*wakeup_host)(struct dw_pcie_ep *ep, u8 func_no,
+				enum pci_epc_wakeup_host_type type);
 };
 
 struct dw_pcie_ep_func {
-- 
2.7.4

