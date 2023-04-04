Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB76D6958
	for <lists+linux-pci@lfdr.de>; Tue,  4 Apr 2023 18:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbjDDQuK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Apr 2023 12:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjDDQuH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Apr 2023 12:50:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA4C5260;
        Tue,  4 Apr 2023 09:49:55 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334C46YJ016565;
        Tue, 4 Apr 2023 16:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=to5gibObB/rOOrjM18K2d3HeopciaYLtmTV7OYDnREI=;
 b=G9XYy0s4bhgE7NcpMEwheXz0pLJ1c7KDT2kr4G0YJn7uAgF9E4ydzlSo0YrQbUv6UP5B
 j+HjBDdkHXlCOFDN+LsmvMEhPl6sOg+18y4sEyBkJi660cOX9qMmqImCKXdOZgMjMUPs
 w74X6Br1msrijSMT7rBT5Z8Ov4zVOmPpDy5QyXAX8k0kWx6B+5EopEZZI5wpIKub6fIl
 Hsup6sBOP7dKwiingjfxAwIEdwL+RA1z9r5nmSKPpuZHejFVKNzHg3wJTZiFwLB9tQzd
 hcx3RpEFbqeHUk6Ni9DqFFSuIdjmRZCzxkLP8aeBQpmsWaSByHCxeDrpyyU3UWr1+FU6 9A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqy623uk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 16:49:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 334GnjUw030500
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 16:49:45 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 4 Apr 2023 09:49:36 -0700
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <linus.walleij@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_ipkumar@quicinc.com>
Subject: [PATCH V2 6/9] dt-bindings: pinctrl: qcom: Add few missing functions
Date:   Tue, 4 Apr 2023 22:18:25 +0530
Message-ID: <20230404164828.8031-7-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230404164828.8031-1-quic_devipriy@quicinc.com>
References: <20230404164828.8031-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hrLww66kL9o8WvvbLuXraPUaAh4GmBy7
X-Proofpoint-ORIG-GUID: hrLww66kL9o8WvvbLuXraPUaAh4GmBy7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_08,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxlogscore=994 phishscore=0 mlxscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304040156
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Added the missing functions cri_trng2, gpio and removed the
duplicate entry qdss_tracedata_b

Fixes: 5b63ccb69ee8 ("dt-bindings: pinctrl: qcom: Add support for IPQ9574")
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 Changes in V2:
	- Added the missing functions to pinctrl binding which was
	  spotted with dtbs_check upon adding the pinctrl definitions for 
	  pcie perst gpio

 .../devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml      | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
index f32239d08c32..673713debac2 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
@@ -74,15 +74,15 @@ $defs:
                 blsp1_i2c, blsp1_spi, blsp1_uart, blsp2_i2c, blsp2_spi,
                 blsp2_uart, blsp3_i2c, blsp3_spi, blsp3_uart, blsp4_i2c,
                 blsp4_spi, blsp4_uart, blsp5_i2c, blsp5_uart, cri_trng0,
-                cri_trng1, cri_trng3, cxc0, cxc1, dbg_out, dwc_ddrphy,
-                gcc_plltest, gcc_tlmm, mac, mdc, mdio, pcie0_clk, pcie0_wake,
+                cri_trng1, cri_trng2, cri_trng3, cxc0, cxc1, dbg_out, dwc_ddrphy,
+                gcc_plltest, gcc_tlmm, gpio, mac, mdc, mdio, pcie0_clk, pcie0_wake,
                 pcie1_clk, pcie1_wake, pcie2_clk, pcie2_wake, pcie3_clk, pcie3_wake,
                 prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, pta, pwm,
                 qdss_cti_trig_in_a0, qdss_cti_trig_in_a1, qdss_cti_trig_in_b0,
                 qdss_cti_trig_in_b1, qdss_cti_trig_out_a0, qdss_cti_trig_out_a1,
                 qdss_cti_trig_out_b0, qdss_cti_trig_out_b1, qdss_traceclk_a,
                 qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b, qdss_tracedata_a,
-                qdss_tracedata_b, qdss_tracedata_b, qspi_clk, qspi_cs, qspi_data,
+                qdss_tracedata_b, qspi_clk, qspi_cs, qspi_data,
                 rx0, rx1, sdc_clk, sdc_cmd, sdc_data, sdc_rclk, tsens_max,
                 wci20, wci21, wsa_swrm ]
 
-- 
2.34.1

