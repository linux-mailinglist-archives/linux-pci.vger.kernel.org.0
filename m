Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CEF797823
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 18:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbjIGQmJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 12:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241331AbjIGQlw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 12:41:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48B5267CD;
        Thu,  7 Sep 2023 08:47:59 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3875gQgW005547;
        Thu, 7 Sep 2023 06:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=RiYKEw8O1oLJTlGLFSkxPYr6hZ1vd0atpxNjhMdpMdE=;
 b=NgRSkTeXLrf1EnMvBIhEG1QLbhedJRHOP+5Zf67NeaFtzCY/Yu+ycPNUJxkH5nU91UsO
 70MumLonGv8JlDd1jvQ+KboRQOkjY04apKkxnANHYirSDLmcbG/62OwRgK7wgkb5H3qG
 BAlm5iGNAEIZ8mfFUOXRkmQ71qv/HiPNI7Tc05APPmfl2ll5FlJgWLSln8xFGymI3vlS
 p67ya4XNSuzfqYSJLNC3HBY1t00JNOZaBMjwHxoBKe5WB/55zKYqo4H8JDaXYy6Aenba
 ahsrLAWlGVtLUGTboR36Jt1Ql2tR7UWc6rX/Q7luIuIrwSiV0KdySCjO3pWMIrto3CH0 xA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxpt02m87-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 06:01:03 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 38760xdY011341;
        Thu, 7 Sep 2023 06:01:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3sux4kjqv8-1;
        Thu, 07 Sep 2023 06:01:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 387610MN011350;
        Thu, 7 Sep 2023 06:01:00 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 387610Le011347;
        Thu, 07 Sep 2023 06:01:00 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 9A5EC13A9; Thu,  7 Sep 2023 11:30:59 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, mani@kernel.org
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, rafael@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v5 4/5] PCI: qcom: Return error from 'qcom_pcie_icc_update'
Date:   Thu,  7 Sep 2023 11:30:32 +0530
Message-Id: <1694066433-8677-5-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
References: <1694066433-8677-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uScLpW1HzmE7HV1Eb5mCKl9UNJo5-nWi
X-Proofpoint-GUID: uScLpW1HzmE7HV1Eb5mCKl9UNJo5-nWi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070052
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Return error from the function if the icc path is specified in the
dt and icc_set_bw failed or link is not up.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e2f2940..ca6350b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1357,22 +1357,21 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
+static int qcom_pcie_icc_update(struct qcom_pcie *pcie)
 {
 	struct dw_pcie *pci = pcie->pci;
 	u32 offset, status, bw;
 	int speed, width;
-	int ret;
 
 	if (!pcie->icc_mem)
-		return;
+		return 0;
 
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
 
 	/* Only update constraints if link is up. */
 	if (!(status & PCI_EXP_LNKSTA_DLLLA))
-		return;
+		return -ENODEV;
 
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
 	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
@@ -1392,11 +1391,7 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 		break;
 	}
 
-	ret = icc_set_bw(pcie->icc_mem, 0, width * bw);
-	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
-			ret);
-	}
+	return icc_set_bw(pcie->icc_mem, 0, width * bw);
 }
 
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
@@ -1529,7 +1524,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	ret = qcom_pcie_icc_update(pcie);
+	if (ret)
+		dev_err(dev, "failed to update interconnect bandwidth: %d\n",
+			ret);
 
 	if (pcie->mhi)
 		qcom_pcie_init_debugfs(pcie);
@@ -1596,7 +1594,10 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 		pcie->suspended = false;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	ret = qcom_pcie_icc_update(pcie);
+	if (ret)
+		dev_err(dev, "failed to update interconnect bandwidth: %d\n",
+			ret);
 
 	return 0;
 }
-- 
2.7.4

