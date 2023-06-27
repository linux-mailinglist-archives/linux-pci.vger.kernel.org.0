Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFE573F00C
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 03:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjF0BBw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 21:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjF0BBv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 21:01:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21BC12E;
        Mon, 26 Jun 2023 18:01:50 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35R0olZk026161;
        Tue, 27 Jun 2023 01:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=qhnhRqi0nFLzXr+49PYiC7nGp/gXo7EQd1cvpHDh3/w=;
 b=fMFW5jZGJav7Bfh1p7iEAyPjf9Zy36dp9fOdSgItQAtBURU2rrkMFOUpN89vuokzZtHS
 QWg1zftKD1lU6OTlykhwmOfnTb/9mX98clufaERCEj51FdygYb4dJwnvSZeYL1QmDjMj
 4GcTtloONitP6Yy18iz0A64PAuDSa5li5Ogd6zjg9QmoXUO7j9RpVt3XdY/GzJXXw+HE
 SgMyFcE0SuxNKPhSMGEOZU2vs+AwZ3xtiRbrCPpwciW3xaJYbzlkh26Qx4QCwjmrC+W6
 BM1QALSJ5aOiYA/33ymrv4NwUQpTNusA2VpkBAsloQnZAA6N85WnY+O+uYwJyJM+I9n/ hg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rfgmp0f6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jun 2023 01:01:46 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35R11hOf006793;
        Tue, 27 Jun 2023 01:01:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rdsjkh3c1-1;
        Tue, 27 Jun 2023 01:01:43 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35R11hjh006712;
        Tue, 27 Jun 2023 01:01:43 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 35R11hNQ006663;
        Tue, 27 Jun 2023 01:01:43 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 865594AA5; Tue, 27 Jun 2023 06:31:42 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v5 0/3] PCI: qcom: ep: Add basic interconnect support
Date:   Tue, 27 Jun 2023 06:31:28 +0530
Message-Id: <1687827692-6181-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mo9TVmwqt8Dhcet6mh4jdMkpnyAT_A1c
X-Proofpoint-ORIG-GUID: mo9TVmwqt8Dhcet6mh4jdMkpnyAT_A1c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_20,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxlogscore=552 phishscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270007
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add basic support for managing "pcie-mem" interconnect path by setting
a low constraint before enabling clocks and updating it after the link
is up based on link speed and width the device got enumerated.

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


Krishna chaitanya chundru (3):
  dt-bindings: PCI: qcom: ep: Add interconnects path
  arm: dts: qcom: sdx65: Add interconnect path
  PCI: qcom-ep: Add ICC bandwidth voting support

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 13 ++++
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             |  3 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c          | 73 ++++++++++++++++++++++
 3 files changed, 89 insertions(+)

-- 
2.7.4

