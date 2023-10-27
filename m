Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727BC7D99EC
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 15:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjJ0Nem (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 09:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjJ0Neh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 09:34:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F7E1B6;
        Fri, 27 Oct 2023 06:34:34 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RCo8Mj004225;
        Fri, 27 Oct 2023 13:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=DBU0j4dBrgUkK4irOTj/KLSG+jwo3RZm6XIyZE1Wex8=;
 b=nDrpU2vSkceLHZeK4KzPmfZpnhbL1qUiKNdRXArm5OI9jM9FHtBmuda/NFIpeZe/8Bcc
 ZCGjhiQtZkZ/ZtvM/k4y9cOlULazzR135DFseAWGWWpBUfAJkAfoZZC9UX76cbfd3gzW
 r5h9T5vwEtToaUPbUoemKHyAVozXT8Pfbjw6Ju0edLG5JwixuTPFXSdMUC6/qJaPLtm6
 IZyYF9t4vwoxIeRh1jbh167PSsy4fhrb1tpEUW4R23tYoMUJ+P05BsHb8F6XrdNP/em5
 gTUgj9m/zQLlc3nhozghlPcdVoZuc8VQ4OP0Wx4InSJdRCDH2eRBmCrM5+Rb+62q3dOJ dA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyxbx25pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Oct 2023 13:33:22 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 39RDWwDi025504;
        Fri, 27 Oct 2023 13:33:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3tv7qmaapw-1;
        Fri, 27 Oct 2023 13:33:19 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39RDXIBM026044;
        Fri, 27 Oct 2023 13:33:18 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 39RDXIOi026042;
        Fri, 27 Oct 2023 13:33:18 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id C26F8481E; Fri, 27 Oct 2023 19:03:17 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev
Subject: [PATCH v4 2/4] PCI: qcom-ep: Add support for SA8775P SOC
Date:   Fri, 27 Oct 2023 19:03:10 +0530
Message-Id: <1698413592-26523-3-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698413592-26523-1-git-send-email-quic_msarkar@quicinc.com>
References: <1698413592-26523-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BF2kNGxZQocECmBhMXTzHtnTFUC1877r
X-Proofpoint-GUID: BF2kNGxZQocECmBhMXTzHtnTFUC1877r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_11,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 impostorscore=0 mlxlogscore=988
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270117
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for SA8775P SoC to the Qualcomm PCIe Endpoint Controller
driver. Adding new compatible string as it has different set of clocks
compare to other SOCs.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 32c8d9e..4c01c34 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -858,6 +858,7 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_pcie_ep_match[] = {
+	{ .compatible = "qcom,sa8775p-pcie-ep", },
 	{ .compatible = "qcom,sdx55-pcie-ep", },
 	{ .compatible = "qcom,sm8450-pcie-ep", },
 	{ }
-- 
2.7.4

