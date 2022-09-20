Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614D45BE2FD
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 12:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiITKW4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 06:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiITKWz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 06:22:55 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDE01117B;
        Tue, 20 Sep 2022 03:22:54 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7xnQ8009265;
        Tue, 20 Sep 2022 10:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=bGJ+pKfcVqDIiOFQgrD1m3p0Qty8nksEq/klYn0BIPM=;
 b=XAZsccVcSJYqkb7T+7aVnSfLKuG1feYZpSoA199uGAWHJnOIWgUVn6SyT8RMjIBm+YQn
 081+tZdpXSNRFVCCSrOJlYEDVlG5CNyryyT6J4S2oYYd/H36P7vyVJPSsjheC+B1UfKX
 9waKQ4hUrBR8qAqY5HwT8ddTnCHLZAxrqpaHM6OYtNVrV5+w0nBV+zfzwK1UzDhrC0Q4
 mspw0ckWNanPQG8JfSkdExvKly91NcDFhR0vnzArmwefyA5uqXZgR6CFF/UqcBJVE5j9
 WCabQqFVAhaJU2hM1w69hmRsA3YMFDnw5DhlrMQjglktALXxNRQiB0Nwv0vsk6NXf6dS Xw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jptw33446-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 10:22:34 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28KAMVlW016209;
        Tue, 20 Sep 2022 10:22:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3jnqrbnbr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Sep 2022 10:22:31 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28KAJDH9014240;
        Tue, 20 Sep 2022 10:22:31 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 28KAMUcX016193;
        Tue, 20 Sep 2022 10:22:31 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 18FE31A0A; Tue, 20 Sep 2022 15:52:30 +0530 (+0530)
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
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v7 5/5] clk: qcom: gcc-sc7280: Update the .pwrsts for PCIe GDSC
Date:   Tue, 20 Sep 2022 15:52:27 +0530
Message-Id: <1663669347-29308-6-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
References: <1663669347-29308-1-git-send-email-quic_krichai@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: i22Kw6cglr45nfDrZ8fX6cgxsUowuBmL
X-Proofpoint-GUID: i22Kw6cglr45nfDrZ8fX6cgxsUowuBmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0
 mlxlogscore=802 classifier=spam adjust=0 reason=mlx scancount=1
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

Enabling PCIe GDSC retention to ensure controller and its
dependent clocks won't go down during system suspend.
Update the .pwrsts for PCIe GDSC so it only transitions
to RET in low power.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
changes since v6:
	- Instead of marking as ALWAYS_ON setting .pwrsts to RET in low
	  power.
---
 drivers/clk/qcom/gcc-sc7280.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index 7ff64d4..e66069c 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -3108,7 +3108,7 @@ static struct gdsc gcc_pcie_1_gdsc = {
 	.pd = {
 		.name = "gcc_pcie_1_gdsc",
 	},
-	.pwrsts = PWRSTS_OFF_ON,
+	.pwrsts = PWRSTS_RET_ON,
 	.flags = VOTABLE,
 };
 
-- 
2.7.4

