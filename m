Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A216758EB7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 09:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGSHVI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 03:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGSHUx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 03:20:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5657C2D42;
        Wed, 19 Jul 2023 00:20:37 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J5T1fQ021632;
        Wed, 19 Jul 2023 07:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=gtb6gYVpTAjg2zcFSW0Orpb5Gq3mMILJPHFU0d+4I/Q=;
 b=ZMz/OaZjiyeZ5Iq0QlKpBRJbA/tBoEYx+LuDdJVgGNQ+8JK5JAw5B+/QB+E7B1bkFUlS
 9ehaKExvBhYmzzw/tyMjJY+thsekmomPp1kXc2pzG5KrVyJ7IqFUHeNfg1NKu0cRLpBg
 UZotOUWK5XC0p158c4hh38QOIjf9LNrQbv+RhLOGVKLm3m3VMmWvs5uH/ONb256oH4XS
 IG+SeFUOJDqugeRhqEwEk3U8k/PfMSj/K3R61geAcf7LFbOjg9PpKsZF0iHlb2dkqRvZ
 JrnzGkYBJP+LdRI+8EohotmrNregvyKLq6hq+T++VNQjGkzxXc1rSzCVc9jegaCdhJhd Nw== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rx8sk087u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 07:20:24 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36J7KKIq022625;
        Wed, 19 Jul 2023 07:20:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rumhm1v71-1;
        Wed, 19 Jul 2023 07:20:20 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36J7KKdl022610;
        Wed, 19 Jul 2023 07:20:20 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 36J7KKAn022583;
        Wed, 19 Jul 2023 07:20:20 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id A01AC47C7; Wed, 19 Jul 2023 12:50:19 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v10 0/4] PCI: qcom: ep: Add basic interconnect support
Date:   Wed, 19 Jul 2023 12:50:14 +0530
Message-Id: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zrZncTP3iTbsVQl7qu_YnR_jtz-V1_8W
X-Proofpoint-ORIG-GUID: zrZncTP3iTbsVQl7qu_YnR_jtz-V1_8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_04,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=517 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190066
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add basic support for managing "pcie-mem" interconnect path by setting
a low constraint before enabling clocks and updating it after the link
is up based on link speed and width the device got enumerated.

changes from v9:
	- addressed the comments by mani.
changes from v8:
        - Added cpu to pcie path in dtsi and in dtsi binding.
changes from v7:
        - setting icc bw to '0' in disable resources as suggested by mani.
changes from v6:
        - addressed the comments as suggested by mani.
changes from v5:
        - addressed the comments by mani.
changes from v4:
        - rebased with linux-next.
        - Added comments as suggested by mani.
        - removed the arm: dts: qcom: sdx55: Add interconnect path
          as that patch is already applied.
changes from v3:
        - ran make DT_CHECKER_FLAGS=-m dt_binding_check and fixed
         errors.
        - Added macros in the qcom ep driver patch as suggested by Dmitry
changes from v2:
        - changed the logic for getting speed and width as suggested
         by bjorn.
        - fixed compilation errors.


Krishna chaitanya chundru (4):
  PCI: qcom-ep: Add ICC bandwidth voting support
  arm: dts: qcom: sdx65: Add PCIe EP interconnect path
  arm: dts: qcom: sdx55: Add CPU PCIe EP interconnect path
  dt-bindings: PCI: qcom: ep: Add interconnects path

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 15 +++++
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi             |  5 +-
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             |  4 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          | 71 ++++++++++++++++++++++
 4 files changed, 93 insertions(+), 2 deletions(-)

-- 
2.7.4

