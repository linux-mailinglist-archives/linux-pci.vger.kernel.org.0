Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585956A3E7D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Feb 2023 10:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjB0Jgw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 04:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjB0Jgv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 04:36:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9D3CA2A;
        Mon, 27 Feb 2023 01:36:48 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R4sGgM007031;
        Mon, 27 Feb 2023 09:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=fFtKuRl7ltXe/gF9tHGWwksasGO5SrHc88zXuVbCr0M=;
 b=QG9RDgamUYYP+MGFS6MBi7K2COX9/ePqTIyTM4+FhV8ERz+An29WiltxbahRaGYanhoj
 Vh1VKBOzlyyeGQaIW/5OnqyqoIFHdWGPBdCfDpYjAqvK3hF/KFYKoN0n6q0o5kx0iuvc
 fX467DJtujjcjTTUKGxJzsP0KHhQWW4pFDoEiohg/tQ+DIaI16ZNkY6lQT7elECR/VzO
 y5pQdAYsH4ZGMTvi9vZFbty0Dv9StYEvmYgEPps2W6C+vd+gSk8jtZ75wT/X2NU1Cb4n
 QD9CQHdwyBMho4rpJ0971DFbEgpp0qWeZJSiOpD7ngIzZQWjruq5nN9ezvTuIEusphhK aQ== 
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nyajavhgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 09:36:29 +0000
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 31R9aOeS026273;
        Mon, 27 Feb 2023 09:36:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3nybdkafcc-1;
        Mon, 27 Feb 2023 09:36:24 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31R9aO1R026268;
        Mon, 27 Feb 2023 09:36:24 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-krichai-hyd.qualcomm.com [10.213.110.37])
        by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 31R9aOMS026267;
        Mon, 27 Feb 2023 09:36:24 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 4058933)
        id 65E4147AF; Mon, 27 Feb 2023 15:06:23 +0530 (+0530)
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH V1] arm64:dts:qcom:sc7280: mark memory of PCIe as cache coherent
Date:   Mon, 27 Feb 2023 15:06:15 +0530
Message-Id: <1677490575-29092-1-git-send-email-quic_krichai@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hv5wk8APxsiR4odzxFP3I-ezSliRXOvh
X-Proofpoint-ORIG-GUID: hv5wk8APxsiR4odzxFP3I-ezSliRXOvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 clxscore=1011 phishscore=0 mlxscore=0 mlxlogscore=653
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302270074
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mark the PCIe node as dma-coherent as the devices on PCIe bus are
cache coherent.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index bdcb749..8f4ab6b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2131,6 +2131,8 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pcie1_clkreq_n>;
 
+			dma-coherent;
+
 			iommus = <&apps_smmu 0x1c80 0x1>;
 
 			iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
-- 
2.7.4

