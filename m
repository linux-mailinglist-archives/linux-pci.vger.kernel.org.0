Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218647982CE
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 08:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242357AbjIHGyd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 02:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242352AbjIHGyb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 02:54:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034311FC0;
        Thu,  7 Sep 2023 23:54:17 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3885SoXC013469;
        Fri, 8 Sep 2023 06:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=WXwHW3raU1s4hsJmYL33wyGGrAkde3NQR+Ib+Oud5/8=;
 b=GnXwV6nJImi8n5yDG96Iyg/fuLHClMdAmcqmtqCMCFEmL+A2OcWNXm4U9DAEhGLIJX8d
 3aLRio7r2aqUwGpvgY0Jg4WGWVgGJSi2+pQb//iGr5Jg/fcX6n1znRzhiuMmMajTB0Io
 Nec0zqY+dZv1CBJCtt6WGBtEe8lTZRis913OnaQ50Tephmh8hKyKmP/lMEEzedXUb6lp
 RcwvJgYaPdJQLntuRFYmXg1I+eEgir+k5Gd6QOBnoFrNVHg90TVKJkBmqggnS7+FgpXH
 kimjR3L5zOZWsYa7aj8lZqkPCeE4qHGs6NAurJ5tm/a+rV/zuQZ4gbE9ojQLfGX9L1pg IA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3synyq8x31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 06:54:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3886s8wR015171
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 06:54:08 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 7 Sep 2023 23:54:04 -0700
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date:   Fri, 8 Sep 2023 12:23:37 +0530
Subject: [PATCH v6 3/4] PCI: qcom-ep: Print D-state name to distinguish
 D3hot/D3cold
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230908-dstate_change-v6-3-b414a6edd765@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694156032; l=1363;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=TzxLjUexBXpCNWAKpf7FWRIPywhjFbkIJ1i/74YzOoU=;
 b=t4FTnrgD69+F5RypjL6PlT00G1LuqIKkJuPtk7CNeUmzacVS7ThC3qGQPkwZgpo131Quhx4tp
 oAatwTwDG1gBnaSJAgTdCHsREkVEGL/46cHo5rbHIzwkAg0mACczu6H
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r-BaZ681W8TS3aNCwQb6zj9aYjBc9GtY
X-Proofpoint-GUID: r-BaZ681W8TS3aNCwQb6zj9aYjBc9GtY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=817 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the state event is stored as pci_power_t, use the PCI helper
pci_power_name() to print the state event.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 402ace57309d..2337602ebc7f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -656,7 +656,6 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_DSTATE_CHANGE, status)) {
 		dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
 					   DBI_CON_STATUS_POWER_STATE_MASK;
-		dev_dbg(dev, "Received D%d state event\n", dstate);
 		state = dstate;
 		if (dstate == PCI_D3hot) {
 			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
@@ -666,6 +665,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 			if (gpiod_get_value(pcie_ep->reset))
 				state = PCI_D3cold;
 		}
+		dev_dbg(dev, "Received %s event\n", pci_power_name(state));
 		pci_epc_dstate_notify(pci->ep.epc, state);
 	} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
 		dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");

-- 
2.42.0

