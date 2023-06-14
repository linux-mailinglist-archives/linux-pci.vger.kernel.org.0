Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45787302A3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jun 2023 17:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbjFNPB4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jun 2023 11:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245689AbjFNPBn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jun 2023 11:01:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700BB2954;
        Wed, 14 Jun 2023 08:01:23 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDmVYG019632;
        Wed, 14 Jun 2023 15:01:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=vqJWExu1DJam83x+oYh9SasCk//OcKLC5ZJsLEOuE9U=;
 b=kdTIuEeJofBuuZbji2tFIcTjP1mVb0E3B3ivBJ9hfjO80EXH2lkR4RajFtCQjIWmkyQw
 oyrqEuoqwToZQqhwYTtFzNKXjMPayR2Rnyj8CKZD2nZdK+h8UqltWYbp4WfVnKM+YZwh
 YzA5hlx6SXxgisOj/T/qQWO/QAFhDDo0H2GzP0SQCP0rj9gIiWWtZy3777CF3GH0kr0/
 ic75Vks4+noyqrlZf43k7MtRYcGLFwY0gUUu3HHg4E85UeIdDQGF0+gSU+BNeK4XSFir
 GOK2skgpgGwp3o+G+jqaU8poJOaJKrIdhWTMfBR8uhx41RgGfEfE3LcM8BRufjInh5Qm OQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r7eceg7r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 15:01:11 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35EF18qu018630;
        Wed, 14 Jun 2023 15:01:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3r7271jayf-1;
        Wed, 14 Jun 2023 15:01:08 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35EF18Qu018615;
        Wed, 14 Jun 2023 15:01:08 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 35EF17xQ018603;
        Wed, 14 Jun 2023 15:01:08 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 299474A09; Wed, 14 Jun 2023 20:31:07 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org (open list:PCI DRIVER FOR SYNOPSYS DESIGNWARE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC v1 2/3] pci: dwc: Add wakeup host op to pci_epc_ops
Date:   Wed, 14 Jun 2023 20:30:48 +0530
Message-Id: <1686754850-29817-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1686754850-29817-1-git-send-email-quic_krichai@quicinc.com>
References: <1686754850-29817-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6ecVuw8ZdBcKWiujei_y1se-SRlbDoAH
X-Proofpoint-ORIG-GUID: 6ecVuw8ZdBcKWiujei_y1se-SRlbDoAH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=697 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306140131
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
 drivers/pci/controller/dwc/pcie-designware-ep.c | 11 +++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f9182f8..60cc323 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -463,6 +463,16 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+static int dw_pcie_ep_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+
+	if (!ep->ops->wakeup_host)
+		return -EINVAL;
+
+	return ep->ops->wakeup_host(ep, func_no);
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -477,6 +487,7 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.wakeup_host		= dw_pcie_ep_wakeup_host,
 };
 
 int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 79713ce..e338591 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -330,6 +330,8 @@ struct dw_pcie_ep_ops {
 	 * driver.
 	 */
 	unsigned int (*func_conf_select)(struct dw_pcie_ep *ep, u8 func_no);
+
+	int	(*wakeup_host)(struct dw_pcie_ep *ep, u8 func_no);
 };
 
 struct dw_pcie_ep_func {
-- 
2.7.4

