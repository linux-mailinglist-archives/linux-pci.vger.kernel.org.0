Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D58740829
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 04:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjF1CTm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 22:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF1CTl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 22:19:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E479C1BE9;
        Tue, 27 Jun 2023 19:19:40 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S1jEMw024612;
        Wed, 28 Jun 2023 02:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=QgWMcPzFqNiXlDNtnl/5wBCYzDq0M3EAgNvmmatSSIo=;
 b=ad8BspXShklU8O0dDFabdN8PRVCPguR9+Zc2+EUyxlvScOyQdmstb2Qr1qljAySXEOKz
 n6IWNxSZvbD1YOaJhcXtrysEGHRxuLYKP7QL8qwsjVU4jz2GDpjYdfKYrYOfODFKqknQ
 /zKL+6Hv+XrqWk/KgSp9x8bj8teB7Xj2cqTT7HhTXPoEgFg8DJ33eyQn1M87UxKiFYul
 ezpDN9llWwAiBf05+qRFMVj/lrjup1Uj2RuHbH2M12C9tq1zaGm+X2AxWu3JDEGhWSky
 6S5lu9vlE9xUsyw6Ylnlpn0q3m57L+RASzB0jSMC4Rws2gkvXT8tqL6JpD+kKCDg+NDj og== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgbfsr1j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 02:19:37 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 35S2JYxl023379;
        Wed, 28 Jun 2023 02:19:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3rdsjkqpkk-1;
        Wed, 28 Jun 2023 02:19:34 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35S2JYi2023365;
        Wed, 28 Jun 2023 02:19:34 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.112])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 35S2JXv5023361;
        Wed, 28 Jun 2023 02:19:34 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 324CB4AA4; Wed, 28 Jun 2023 07:49:33 +0530 (+0530)
From:   Krishna chaitanya chundru <quic_krichai@quicinc.com>
To:     manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v6 0/3] PCI: qcom: ep: Add basic interconnect support
Date:   Wed, 28 Jun 2023 07:49:27 +0530
Message-Id: <1687918770-28416-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K-7N3sMDXgpjPdBcls83U6iog9SjsFSf
X-Proofpoint-ORIG-GUID: K-7N3sMDXgpjPdBcls83U6iog9SjsFSf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_16,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=538
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280019
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
 drivers/pci/controller/dwc/pcie-qcom-ep.c          | 72 +++++++++++++++++++++-
 3 files changed, 87 insertions(+), 1 deletion(-)

-- 
2.7.4

