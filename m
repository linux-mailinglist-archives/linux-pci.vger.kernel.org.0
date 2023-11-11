Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F72B7E8840
	for <lists+linux-pci@lfdr.de>; Sat, 11 Nov 2023 03:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344844AbjKKCd2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 21:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjKKCd1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 21:33:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1893C30;
        Fri, 10 Nov 2023 18:33:24 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AB2W6p5019105;
        Sat, 11 Nov 2023 02:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=UvzoKZnUjViW9hU9vq50LtblAPRPSyUldpi5ZIk9Fsg=;
 b=htindFEav1e82lkk6UmbKefgJE9Yai/OrnKr8O9jG3nVHYCzVaF6T2Eyz3qRjV6WiTVF
 PpRvgiF2Pm0PkkWGTYkascSy9aBeWr4QsWbDzJZhgJqE/WzrrQTlFP8Zcux4XgaODpi6
 GlkQ9TKSJnPe3pEsvwSn31HMyL+hx1wwAhw2VGOgiqwfPftdrZE8dMDTJdVCgvI4P8xM
 w54YGBYRgRZWqTjMn9DfclZoyE1AGQBQ9syvHL7nn4vGkwz8FKnNUCasfFx06x5hJ47y
 2eb8S7VbRMMH/K4L2BMWPYhwEsBYm37D38jxGvpCN/M/kJzgEtBjgnIZNoryNLlyEFkS sw== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u93r0kuk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 02:33:15 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3AB2XBTw021745;
        Sat, 11 Nov 2023 02:33:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3u5f1mjp4n-1;
        Sat, 11 Nov 2023 02:33:11 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AB2XBRr021736;
        Sat, 11 Nov 2023 02:33:11 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3AB2XBin021733;
        Sat, 11 Nov 2023 02:33:11 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
        id 5FCC32C83; Sat, 11 Nov 2023 08:03:10 +0530 (+0530)
From:   Mrinmay Sarkar <quic_msarkar@quicinc.com>
To:     agross@kernel.org, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org
Cc:     quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_parass@quicinc.com, quic_schintav@quicinc.com,
        quic_shijjose@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev
Subject: [PATCH v8 3/5] PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function names
Date:   Sat, 11 Nov 2023 08:02:59 +0530
Message-Id: <1699669982-7691-4-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1699669982-7691-1-git-send-email-quic_msarkar@quicinc.com>
References: <1699669982-7691-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -T4NyjzAkXUJlJc-2JaVxp1jRp_T00Fv
X-Proofpoint-ORIG-GUID: -T4NyjzAkXUJlJc-2JaVxp1jRp_T00Fv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_21,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=671 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311110018
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Without the prefix, the function name would appear as
"/sys/kernel/config/functions/{sdx55/sm8450}". This will be a problem if
multiple functions are supported for this endpoint device.

So let's add the "pci_epf_mhi_" prefix to identify _this_ function
uniquely. Even though it is an ABI breakage, this driver is not used
anywhere outside Qcom and myself to my knowledge. So it safe to change
the function name.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index b7b9d3e..5b0515a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -677,8 +677,8 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
 }
 
 static const struct pci_epf_device_id pci_epf_mhi_ids[] = {
-	{ .name = "sdx55", .driver_data = (kernel_ulong_t)&sdx55_info },
-	{ .name = "sm8450", .driver_data = (kernel_ulong_t)&sm8450_info },
+	{ .name = "pci_epf_mhi_sdx55", .driver_data = (kernel_ulong_t)&sdx55_info },
+	{ .name = "pci_epf_mhi_sm8450", .driver_data = (kernel_ulong_t)&sm8450_info },
 	{},
 };
 
-- 
2.7.4

