Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A6A76C46C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 06:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjHBE7m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 00:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjHBE7l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 00:59:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A5419B0;
        Tue,  1 Aug 2023 21:59:40 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3724RM43010916;
        Wed, 2 Aug 2023 04:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=lnR2khHJx8LY6hQNdPkRP1Ls8Tu3vNaPwWY9+/cUFgQ=;
 b=Ur71/UV2P+kkCceOSJKSXjHa0l0rLbRK6d0oiplPXYZ+UxGjENYpEBw1k5RqB2ztuMDN
 BmZipIIF9FZ5VcNHSKbttQ3oBrud1MuEhUfZs7sNcIwyVwL3yuZnPAcxX3vzYeyHTgrT
 FszbG5XdHkU2KEq6zToy7YkH44HIKS/pnaEuQNhaVWIEUgpp5nWwLgxNhLsM/kOYPGzW
 uak4dx32f0V+JAUdIXcN0c0p96XxONuT78RQf7u3C2oqynpRTtRV0Jha3+rsOw6HhbNn
 GipQ15q7Al0bXxroubySvqFh09ppapbuCsCIkWh6A3RhFmQXToji9Y1M9BjUqjZ/VVDB iQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s72gqspb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 04:59:31 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3724xRiD022303;
        Wed, 2 Aug 2023 04:59:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3s4uukd91u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 02 Aug 2023 04:59:27 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3724xQud022283;
        Wed, 2 Aug 2023 04:59:26 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3724xQxt022280;
        Wed, 02 Aug 2023 04:59:26 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id D9C4E4B5F; Wed,  2 Aug 2023 10:29:25 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 2/5] PCI: dwc: Add wakeup host op to pci_epc_ops
Date:   Wed,  2 Aug 2023 10:29:16 +0530
Message-Id: <1690952359-8625-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690952359-8625-1-git-send-email-quic_krichai@quicinc.com>
References: <1690952359-8625-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: feycgqgB72pj-HQrac95SQL0Uq5jWAX1
X-Proofpoint-ORIG-GUID: feycgqgB72pj-HQrac95SQL0Uq5jWAX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_02,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=724 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020044
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add wakeup host op to wake up host from D3cold or D3hot.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f9182f8..e2733a4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -463,6 +463,17 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+static bool dw_pcie_ep_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				bool send_pme)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+
+	if (!ep->ops->wakeup_host)
+		return false;
+
+	return ep->ops->wakeup_host(ep, func_no, send_pme);
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
index 6156606..fc47e74 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -330,6 +330,8 @@ struct dw_pcie_ep_ops {
 	 * driver.
 	 */
 	unsigned int (*func_conf_select)(struct dw_pcie_ep *ep, u8 func_no);
+
+	bool	(*wakeup_host)(struct dw_pcie_ep *ep, u8 func_no, bool send_pme);
 };
 
 struct dw_pcie_ep_func {
-- 
2.7.4

