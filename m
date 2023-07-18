Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652397580B1
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 17:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjGRPVA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 11:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjGRPU7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 11:20:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3865DC0;
        Tue, 18 Jul 2023 08:20:58 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IFI3JJ008296;
        Tue, 18 Jul 2023 15:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=IscltNk2d68+/+s5NWyxpmimxpfYBboBnnaojrCojfo=;
 b=LnyrTyVjvsBpNVOadzypkNfy3IGRRm/1oq9IB+eHn6c3ItwTA6tvFk54vuxVwSXuhmUt
 YJOf5UO6GBwXzdOKzF1IuOsLswCzn0ziqtdpiaK08xTAY5uVtPZnIWBZS0nWk8UuJxKf
 ysQSvAOuOz5FpbYzNohsMnZeOcceuA5MBB49u0DSyBJlQA5BF7TauxIE187c4iu1uYIs
 lLRDYjn4UvRbWvjNBV//CIUS2tcF7aw9U2ZM8uFF8qf3qBcEYlq8Ki5moWaZB2W45LjR
 RSiuTFG6bHaLgbZpo0kUvCEog2fdqlGF4gU22BDFcOOSibkjv5FlyK1b6Mhzzm0o12sh Zg== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwnrrh7hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 15:20:53 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 36IFKnLd026248;
        Tue, 18 Jul 2023 15:20:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rumhkb0g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Jul 2023 15:20:49 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36IFKnmr026055;
        Tue, 18 Jul 2023 15:20:49 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 36IFKnjq025902;
        Tue, 18 Jul 2023 15:20:49 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 59F6D4AF6; Tue, 18 Jul 2023 20:50:48 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v9 0/4] PCI: qcom: ep: Add basic interconnect support
Date:   Tue, 18 Jul 2023 20:50:41 +0530
Message-Id: <1689693645-28254-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aHL3nClpYAwCsjS0zwDqtNhZ6xv1hS1N
X-Proofpoint-ORIG-GUID: aHL3nClpYAwCsjS0zwDqtNhZ6xv1hS1N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_11,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=517 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180141
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add basic support for managing "pcie-mem" interconnect path by setting
a low constraint before enabling clocks and updating it after the link
is up based on link speed and width the device got enumerated.

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
  dt-bindings: PCI: qcom: ep: Add interconnects path
  arm: dts: qcom: sdx65: Add PCIe interconnect path
  arm: dts: qcom: sdx55: Add CPU PCIe interconnect path
  PCI: qcom-ep: Add ICC bandwidth voting support

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 15 +++++
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi             |  5 +-
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             |  4 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c          | 72 ++++++++++++++++++++++
 4 files changed, 94 insertions(+), 2 deletions(-)

-- 
2.7.4

