Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3AE588B31
	for <lists+linux-pci@lfdr.de>; Wed,  3 Aug 2022 13:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiHCL3R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Aug 2022 07:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbiHCL3P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Aug 2022 07:29:15 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312B42E681;
        Wed,  3 Aug 2022 04:29:13 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273BR55t005939;
        Wed, 3 Aug 2022 11:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=KfhRgMPMwBkmASqDHHBd7ojyHq/RT2vLicoMijb2GNs=;
 b=cGScPKF4Lw3Aja11hbGByH8jTbJeywG4WE7aoCA/v/me0Aj7DQIUflbm3ya9AJ4JzIcr
 kiwKb5UaVvLpYADhGLh45L8buA1ExfQKgc5P6ApiEj/4JvhcJHKyep/vXI/GBBRIe7j7
 h9fcEOGokGrA6pUzvJTmEQrwIvQfa2xJoRxz3CWcDvhqmTYieKLqNhfneatvNw5eDr/G
 cyM45gL5T+tuO9P0ohI1Tuyok/990IuC/Tn4G/sC/QhrvtAoKhiHE1ijQOIkYs2YgfWn
 XnnpC1rD01/N/55aiiQA4fQFNMpdoHrDA1p6KPd2cjeBdEw0HL7vrM0TsyIw4TRyVgg8 8w== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hq8rq1pve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Aug 2022 11:29:03 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 273BSw2w023596;
        Wed, 3 Aug 2022 11:28:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3hmwqkd7de-1;
        Wed, 03 Aug 2022 11:28:58 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 273BSwLf023579;
        Wed, 3 Aug 2022 11:28:58 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 273BSwWS023562;
        Wed, 03 Aug 2022 11:28:58 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 1A75C41CA; Wed,  3 Aug 2022 16:58:58 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 3/3] PCI: qcom: Add retry logic for link to be stable in L1ss
Date:   Wed,  3 Aug 2022 16:58:54 +0530
Message-Id: <1659526134-22978-4-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
References: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N8TByLuOzygBy6WohQ3eIZ63fEjEP027
X-Proofpoint-GUID: N8TByLuOzygBy6WohQ3eIZ63fEjEP027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208030050
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some specific devices are taking time to settle the link in L1ss.
So added a retry logic before returning from the suspend op.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index f7dd5dc..f3201bd 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1829,15 +1829,30 @@ static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
 {
 	struct qcom_pcie *pcie = dev_get_drvdata(dev);
 	u32 val;
+	ktime_t timeout, start;
 
 	if (!pcie->cfg->supports_system_suspend)
 		return 0;
 
-	/* if the link is not in l1ss don't turn off clocks */
-	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
-	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
-		dev_warn(dev, "Link is not in L1ss\n");
-		return 0;
+	start = ktime_get();
+	/* Wait max 100 ms */
+	timeout = ktime_add_ms(start, 100);
+	while (1) {
+		bool timedout = ktime_after(ktime_get(), timeout);
+
+		/* if the link is not in l1ss don't turn off clocks */
+		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
+		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
+			dev_info(dev, "Link enters L1ss after %d ms\n",
+					ktime_to_ms(ktime_get() - start));
+			break;
+		}
+
+		if (timedout) {
+			dev_warn(dev, "Link is not in L1ss\n");
+			return 0;
+		}
+		usleep_range(1000, 1200);
 	}
 
 	if (pcie->cfg->ops->suspend)
-- 
2.7.4

