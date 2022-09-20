Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC325BE307
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 12:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiITKW7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 06:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiITKW4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 06:22:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B850194;
        Tue, 20 Sep 2022 03:22:54 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KAMYCJ030209;
        Tue, 20 Sep 2022 10:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=ei3RTLrelI+vWzWY/UUM1rE2cKcsDhShOMPEsncj94E=;
 b=lUHSmQCKKN6wh3NMsnJ7qVx+ZEyBHVTZZeZuu9PUAf7V9dY/dAF2dCV6MXFzWogEEWWp
 M5PG/TSx3XhkWPAtmpLEbeTBM/W3RR3MuUHCULjHp0+aUD5eR66lYIa4Ot5+oN+u5KM/
 m/RxzkX/qazokbBkGyJBsemtppByKggwR+u6SI023iRt5exzC9Byu8TXIrCdW/AP4AK7
 p+hTUddOca5UjUo4T6qQcnmmH5KCizeDfpm7mOodyUp1K1wGTG3kyRj/roXH87n78Qjw
 BS8PtmSUXQhKobHavxBvvxhDwkP4Px7dMRlQKKTv+6x4xET9tLs5gCMgFnPmQbRuW3rM HQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jqa1k8aqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:22:34 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28KAMUDI016181;
        Tue, 20 Sep 2022 10:22:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jnqrbnbqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Sep 2022 10:22:30 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28KAMUG8016159;
        Tue, 20 Sep 2022 10:22:30 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 28KAMTb4016149;
        Tue, 20 Sep 2022 10:22:30 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 5E18D19F9; Tue, 20 Sep 2022 15:52:29 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        svarbanov@mm-sol.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-phy@lists.infradead.org, vkoul@kernel.org, kishon@ti.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v7 2/5] PCI: qcom: Add retry logic for link to be stable in either L1.1 or L1.2
Date:   Tue, 20 Sep 2022 15:52:24 +0530
Message-Id: <1663669347-29308-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
References: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MVX-zVMiMf09preCe-06zwyqS_L4eeRU
X-Proofpoint-ORIG-GUID: MVX-zVMiMf09preCe-06zwyqS_L4eeRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 mlxlogscore=951
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200062
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When link is in L1ss(L1.1 or L1.2), all the clocks will gate off and there
will be no activity on the link. At that point clocks and phy
can be turned off. If clocks got disabled before link enters
L1ss the PCIe link goes down.

Few endpoints are taking time more time to settle the link in L1 substates.
When we check the traffic in protocol analyzer, we see some DLLP packets
going on still. So Wait for max time of 200ms for the link to be stable in
L1 substates.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
changes since v6:
	- updated comments.
---
 drivers/pci/controller/dwc/pcie-qcom.c | 46 ++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3f5424a..7a6f69e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1809,23 +1809,47 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 static int __maybe_unused qcom_pcie_pm_suspend(struct qcom_pcie *pcie)
 {
 	u32 val;
+	ktime_t timeout, start;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 
-	/* if the link is not active turn off clocks */
-	if (!dw_pcie_link_up(pci)) {
-		dev_dbg(dev, "Link is not active\n");
-		goto suspend;
-	}
+	/*
+	 * When link is in L1ss, all the clocks will gate off and
+	 * there will be no activity on the link. At that point clocks
+	 * and phy can be turned off. If clocks got disabled before
+	 * link enters L1ss the PCIe link goes down.
+	 *
+	 * Few endpoints are taking time more time to settle the link
+	 * in L1ss. Wait for max of 200ms for the link to be stable in
+	 * L1ss.
+	 */
+	start = ktime_get();
+	/* Wait max 200 ms */
+	timeout = ktime_add_ms(start, 200);
+
+	while (1) {
+		/* if the liink is not active turn off clocks */
+		if (!dw_pcie_link_up(pci)) {
+			dev_dbg(dev, "Link is not active\n");
+			break;
+		}
 
-	/* if the link is not in l1ss don't turn off clocks */
-	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
-	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
-		dev_warn(dev, "Link is not in L1ss\n");
-		return 0;
+		/* if the link is not in l1ss don't turn off clocks */
+		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
+		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
+			dev_dbg(dev, "Link enters L1ss after %lld  ms\n",
+					ktime_to_ms(ktime_get() - start));
+			break;
+		}
+
+		if (ktime_after(ktime_get(), timeout)) {
+			dev_warn(dev, "Link is not in L1ss\n");
+			return 0;
+		}
+
+		udelay(1000);
 	}
 
-suspend:
 	if (pcie->cfg->ops->suspend)
 		pcie->cfg->ops->suspend(pcie);
 
-- 
2.7.4

