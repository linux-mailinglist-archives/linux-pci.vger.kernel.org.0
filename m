Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D115ABC4E
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 04:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiICCXF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 22:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiICCXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 22:23:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E3DEC4C9;
        Fri,  2 Sep 2022 19:23:03 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28322nSi015788;
        Sat, 3 Sep 2022 02:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=ily7j5u6hr80PUIzH4pzDn7ftPuMVCZLNA3gbBByjH0=;
 b=UZBiE0G0ZtAWLFh6DYLvXcrBes5qeWKbD4AZ3JXayXr/9v7utiAzpou2UAj58GQtSqCz
 uH0Wjn74KzVbtDKwnQCWBQLmb915YZps7Vc/sgsaX+CWgtkzZd/5Fapa0e9XIdIS9beR
 W9RNmKTrEY9jtuBP4lNmU+CrfbMXVka2oZpab+vFwgo93Bo1vegB77NhHELDmKaOV/sv
 srxH4m3zqE3j3Q+4Pb5/6atELouJSr83/V1ifeo4NlrkqMhr9y9BFqaOGUMUIAqQAv4j
 5FdXIy8MDaMeH0jDgqpDJdQVAfvwKcg7uvMd7xrRexrWcIYem3SCxb6auRDVKOTOfyWK yA== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jb3k3chdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Sep 2022 02:23:00 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2832MuVC016085;
        Sat, 3 Sep 2022 02:22:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3j7cbktj0w-1;
        Sat, 03 Sep 2022 02:22:56 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2832Mua6016057;
        Sat, 3 Sep 2022 02:22:56 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 2832Mtir016056;
        Sat, 03 Sep 2022 02:22:56 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 6DB82382F; Sat,  3 Sep 2022 07:43:06 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v3 0/3] PCI: qcom: sc7280: add missing aggre0, aggre1 and ddrs sf tbu clocks
Date:   Sat,  3 Sep 2022 07:43:01 +0530
Message-Id: <1662171184-25211-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IvVaS0i_PkvtIsdysCBmPowsFXs-Yy9o
X-Proofpoint-ORIG-GUID: IvVaS0i_PkvtIsdysCBmPowsFXs-Yy9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_08,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 mlxlogscore=366 bulkscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209030010
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing aggre0, aggre1 and ddrs sf tbu clocks supports to PCIe node.

Without voting these clocks, PCIe link is going down when system is
suspended as these clocks can get turned off as no-one is voting for them.

Krishna chaitanya chundru (3):
  PCI: qcom: Add sc7280 aggre0, aggre1 and ddr sf tbu clocks in PCIe
    driver
  dt-bindings: pci: QCOM Add missing sc7280 aggre0, aggre1 clocks
  arm64: dts: qcom: sc7280: Add missing aggre0, aggre1 clocks

 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 10 ++++++----
 arch/arm64/boot/dts/qcom/sc7280.dtsi                 |  4 ++++
 drivers/pci/controller/dwc/pcie-qcom.c               |  3 +++
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.7.4

