Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42735B1789
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiIHIq6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 04:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiIHIqq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 04:46:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078D611CD4E;
        Thu,  8 Sep 2022 01:46:28 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288877Ms013349;
        Thu, 8 Sep 2022 08:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=qfj+h3J2L519bE2HtjD5kab2cVsVAeOaLIzlggd6yJA=;
 b=o+ngamKDD1lBAjhUqT0YhVvWWsRGTLK2h/oHHj2HhRhe2NpIsC6Ue4+kfEk+26qHLwyC
 an8VuWRYR9KLEHozjmTYuVFmnXdGTACD8ZXTQbNFHvv5wBit5xuqTkC3+XhnPtq7wuo+
 FbGLN0viajQYxEtkZmUcO3qgVHtarKRswizJmhvKlB49RCeATEYaWU+DotEaDsZAek5t
 AhAoeTcRIRcuqnJkxVSaFnzHcgtbxRTCGvUtRZyZudEkOcdbqZJt3Fq0W9eb/Qf2iY7e
 GP9ERZssaupy0O0X9O7H8UAJxPLxu7a1ma/kxpoKC+gqPF28KCms8uShX/DIn9zXaG0v Ig== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jf1swsbfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 08:46:23 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2888i2uW011862;
        Thu, 8 Sep 2022 08:46:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3jc00m3e0y-1;
        Thu, 08 Sep 2022 08:46:19 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2888gNm4008440;
        Thu, 8 Sep 2022 08:46:19 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2888kJqV014053;
        Thu, 08 Sep 2022 08:46:19 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 81DDE449C; Thu,  8 Sep 2022 14:16:18 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v4 0/2] PCI: qcom: sc7280: add missing aggre0 and aggre1 clocks
Date:   Thu,  8 Sep 2022 14:16:14 +0530
Message-Id: <1662626776-19636-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QS6wUPq5p-QWY6KvVv4i-Zr9fbq_e8BT
X-Proofpoint-ORIG-GUID: QS6wUPq5p-QWY6KvVv4i-Zr9fbq_e8BT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_06,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=416
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080031
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing aggre0 and aggre1 clocks supports to PCIe node.

Without voting these clocks, PCIe link is going down when system is
suspended as these clocks can get turned off as no-one is voting for them.

Krishna chaitanya chundru (2):
  arm64: dts: qcom: sc7280: Add missing aggre0, aggre1 clocks
  dt-bindings: pci: QCOM Add missing sc7280 aggre0, aggre1 clocks

 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 10 ++++++----
 arch/arm64/boot/dts/qcom/sc7280.dtsi                 |  8 ++++++--
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.7.4

