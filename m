Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E5F743381
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 06:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjF3EZj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 00:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjF3EZe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 00:25:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E54630D1;
        Thu, 29 Jun 2023 21:25:33 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U4JQT8010952;
        Fri, 30 Jun 2023 04:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=Voo9QKIV2Frsi5kA9jpD3XnC9AdZmVSTZ4udynG7uPc=;
 b=JV/AkqhpGbo5xO39N47jFAIoJiXNn59+EaPPAdlFHAdOxgDD1irbzQaC3+2BDf4LGp5R
 flfMGMhnLH6bYVenM9WlzrZQK9hmmpnWFXtOUhE8zAh+W2+Ivogm18CNWluf1S5ljJdb
 f6nm955iLHDUnQ1IdNg9TAmUancJwlDct/fQfTjqK0zFRbEBHBse1JACjq2VI8jEt2RP
 fGYaRLUXVmkc0CJDtnw1qMa2jSkBOlO5kIsYuh3V2fk0ncCkftI2nsbxiRLVyNLLJPMm
 eeZTf8nen+AJHaK+fx6JfklxCI0ju0yL/5tux1CBIgF4WAyeAcXjfuQW9XYYK4pKB2hA +g== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rh7s2t1jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 04:25:30 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35U4PQFG013204;
        Fri, 30 Jun 2023 04:25:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3rdsjknf4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Jun 2023 04:25:26 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35U4PQVg013188;
        Fri, 30 Jun 2023 04:25:26 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 35U4PQ9i013186;
        Fri, 30 Jun 2023 04:25:26 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id A685C4AB6; Fri, 30 Jun 2023 09:55:25 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v7 0/3] PCI: qcom: ep: Add basic interconnect support
Date:   Fri, 30 Jun 2023 09:55:20 +0530
Message-Id: <1688099123-28036-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0q7wfKuBdFE3QLqpwvjnDgEghTbHjwck
X-Proofpoint-ORIG-GUID: 0q7wfKuBdFE3QLqpwvjnDgEghTbHjwck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=535 impostorscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300037
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add basic support for managing "pcie-mem" interconnect path by setting
a low constraint before enabling clocks and updating it after the link
is up based on link speed and width the device got enumerated.

chnages from v6:
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


Krishna chaitanya chundru (3):
  dt-bindings: PCI: qcom: ep: Add interconnects path
  arm: dts: qcom: sdx65: Add PCIe interconnect path
  PCI: qcom-ep: Add ICC bandwidth voting support

 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 13 ++++
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             |  3 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c          | 71 ++++++++++++++++++++++
 3 files changed, 87 insertions(+)

-- 
2.7.4

