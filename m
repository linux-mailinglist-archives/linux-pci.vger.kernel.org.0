Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8341C7982C8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 08:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242341AbjIHGyT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 02:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242303AbjIHGyR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 02:54:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089511BE7;
        Thu,  7 Sep 2023 23:54:13 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 388671BJ017468;
        Fri, 8 Sep 2023 06:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=Sxt2/AesRTRq7G6Vm9pac+N9rls9QqefJr3NSZO3XH0=;
 b=TYEJHwyph6ChVIpzCET7rcpNgIgroOlTeTKpRbMHLZVwoCIlSDEKhgdSamRg+IYeOrgu
 Op0XYyupzjJPYZVw/h9CW+hxTG5IUd6JwSeJygZKwwmHcI7USD9VVb7GvBUeIua9foMq
 w/7dxEIaFGwpJ6RDGTfejJVHlXS9plhgenUm999yhGS+zec9BMrg5j8ww5A7L34hpmTx
 gLCBz5F+6EeZ17WPKUtVZBABOVwcNsi6z5/XxRwDHEQnitoZ4suv+83TRhxeSXGdDWCn
 7yTuUKww/+bBez3UH2hgd08jwjuz1GP6Grie1aFi2kcGCam8oEjKyOouu8uO1AfRyBxj kw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syf5c1yg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 06:54:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3886s4H5007201
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 06:54:04 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 7 Sep 2023 23:54:00 -0700
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date:   Fri, 8 Sep 2023 12:23:36 +0530
Subject: [PATCH v6 2/4] PCI: qcom-ep: Add support for D-state change
 notification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230908-dstate_change-v6-2-b414a6edd765@quicinc.com>
References: <20230908-dstate_change-v6-0-b414a6edd765@quicinc.com>
In-Reply-To: <20230908-dstate_change-v6-0-b414a6edd765@quicinc.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694156032; l=1690;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=7+fZlP+EjfzIGzfl9thzeVMRXwgPe/8fqtyjrkfcWYM=;
 b=uNHFDsG3il+U8v679Cu7FfTy6QaK2MIzhlbGC9xYVhOos7Mf6J3JQe4vsgS1gf7P0yAEtSmFh
 nLwZ/4zXrnlBEuYyJVwM26rDEKVLHZq6vGGMnDawUhjqJYsjqSWf6Zx
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8q03IGRjgDi7hmCODU_37TvpI5nlNi8l
X-Proofpoint-ORIG-GUID: 8q03IGRjgDi7hmCODU_37TvpI5nlNi8l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 mlxlogscore=995
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to pass D-state change notification to Endpoint
function driver.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 8bd8107690a6..402ace57309d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -633,6 +633,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	struct device *dev = pci->dev;
 	u32 status = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
 	u32 mask = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_MASK);
+	pci_power_t state;
 	u32 dstate, val;
 
 	writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);
@@ -656,11 +657,16 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
 					   DBI_CON_STATUS_POWER_STATE_MASK;
 		dev_dbg(dev, "Received D%d state event\n", dstate);
-		if (dstate == 3) {
+		state = dstate;
+		if (dstate == PCI_D3hot) {
 			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
 			val |= PARF_PM_CTRL_REQ_EXIT_L1;
 			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
+
+			if (gpiod_get_value(pcie_ep->reset))
+				state = PCI_D3cold;
 		}
+		pci_epc_dstate_notify(pci->ep.epc, state);
 	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
 		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
 		dw_pcie_ep_linkup(&pci->ep);

-- 
2.42.0

