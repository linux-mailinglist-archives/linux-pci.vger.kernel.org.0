Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426535B3221
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 10:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiIIIpq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 04:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiIIIpb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 04:45:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124D7E2291;
        Fri,  9 Sep 2022 01:45:27 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2898a4Yg013286;
        Fri, 9 Sep 2022 08:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=kb8qQseZWUATfPCRZc5nzAu2oEou8/t8rUjWQ8Ps+3Y=;
 b=VAtDlGU2XRxC7A3DD3DtjxeBbHC44Xlj83dGZV6hIZzTEQ8K6hbxEvCOANKHLQSU+5Ay
 kXoiekkRgM9ni3vsb9gjj4+hWJ50RI5GL4Zd76Gbyhb2RXjHinUgKsCbIo1Zik+Tpop6
 eBpIxp3VHzO4EKfJASa6YKB6ejtVDmqqB25KoukA2F26Y4zlS/9qdEfdZDbCuiVInEwy
 hEIj3ssBB2fMyfHguiQr/+LsMHXdOvjq9vHAzPgPxsXCMu0Yb7cBESbvkyVbGJa7IlFa
 q+RXJW6BXQWoh1dmwYTdCba9M6UEY52yNWJI2hdhpj2Zaes/4gpKjpBe4WRCl3hrbocA Tg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfrhg9tdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 08:45:16 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2898j5bJ014236;
        Fri, 9 Sep 2022 08:45:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jc00m8vq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 09 Sep 2022 08:45:05 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2898iK7B013119;
        Fri, 9 Sep 2022 08:45:04 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2898j4Mb014199;
        Fri, 09 Sep 2022 08:45:04 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id B667344AB; Fri,  9 Sep 2022 14:15:03 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 2/5] PCI: qcom: Add retry logic for link to be stable in L1ss
Date:   Fri,  9 Sep 2022 14:14:41 +0530
Message-Id: <1662713084-8106-3-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
References: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RFDhlk6eYaRSL-nQgg0CIjidNWiKzRyF
X-Proofpoint-GUID: RFDhlk6eYaRSL-nQgg0CIjidNWiKzRyF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090030
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some specific devices are taking time to settle the link in L1ss.
So added a retry logic before returning from the suspend op.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6e04d0d..15c2067 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1809,26 +1809,40 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 static int __maybe_unused qcom_pcie_pm_suspend(struct qcom_pcie *pcie)
 {
 	u32 val;
+	ktime_t timeout, start;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
 
 	if (!pcie->cfg->supports_system_suspend)
 		return 0;
 
-	/* if the link is not active turn off clocks */
-	if (!dw_pcie_link_up(pci)) {
-		dev_info(dev, "Link is not active\n");
-		goto suspend;
-	}
+	start = ktime_get();
+	/* Wait max 200 ms */
+	timeout = ktime_add_ms(start, 200);
 
-	/* if the link is not in l1ss don't turn off clocks */
-	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
-	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
-		dev_warn(dev, "Link is not in L1ss\n");
-		return 0;
+	while (1) {
+
+		if (!dw_pcie_link_up(pci)) {
+			dev_warn(dev, "Link is not active\n");
+			break;
+		}
+
+		/* if the link is not in l1ss don't turn off clocks */
+		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
+		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
+			dev_dbg(dev, "Link enters L1ss after %d  ms\n",
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

