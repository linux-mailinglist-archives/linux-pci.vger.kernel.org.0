Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41957696A0E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 17:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjBNQna (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 11:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjBNQnJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 11:43:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FD82A6F3;
        Tue, 14 Feb 2023 08:43:00 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EBd6HN023062;
        Tue, 14 Feb 2023 16:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=ZQPSSMIZukH8hQt148d8lH7s+AasSAJMGw4ArXGUN2o=;
 b=PO0TAcQrijPkzYdSgSo2gbFNxarTgxhVpZGnEtrfA7QbxTLVucZ+KYA1pYdN+E6GTRnz
 +AwD/A6M5tyhVDt0MWtI24iY38G0aHtXNs3wSbH7Y5W4PGJnN7lXiwb7yYNjmFD6hDWR
 6/WxUnxKkYVDJRT960Vatq1L5AjKH0XbF6wiB59PWef6AKcYb3B3SQmhm4D/AV8mHf04
 je4YcTYiakBG9GttdLt804lVTQUrLOO2aB7VQMfG/wwyH/T8opeYbYmZW2KRghCwea+h
 YnIppSXc2l9xpfzZHPg2GvcGaAMAkrWL1/mQf4+5C2Hjoa8rn4XnoP/Gt+//anEKSAMS Fw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqtsutta8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:42:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EGgk42018184
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 16:42:46 GMT
Received: from devipriy-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 08:42:39 -0800
From:   Devi Priya <quic_devipriy@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <svarbanov@mm-sol.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH 5/7] dt-bindings: clock: Add PCIe pipe clock definitions
Date:   Tue, 14 Feb 2023 22:11:33 +0530
Message-ID: <20230214164135.17039-6-quic_devipriy@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230214164135.17039-1-quic_devipriy@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CHWhO0FJ2T3eqIs4Wn6qmnCOC1J-wZb_
X-Proofpoint-ORIG-GUID: CHWhO0FJ2T3eqIs4Wn6qmnCOC1J-wZb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_11,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302140142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe clock definitions for IPQ9574 SoC

Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
---
 include/dt-bindings/clock/qcom,ipq9574-gcc.h | 276 ++++++++++---------
 1 file changed, 140 insertions(+), 136 deletions(-)

diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
index feedfdd5e00a..c89e96d568c6 100644
--- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
@@ -74,140 +74,144 @@
 #define GCC_PCIE3_AXI_S_BRIDGE_CLK			65
 #define GCC_PCIE3_AXI_S_CLK				66
 #define PCIE0_PIPE_CLK_SRC				67
-#define PCIE1_PIPE_CLK_SRC				68
-#define PCIE2_PIPE_CLK_SRC				69
-#define PCIE3_PIPE_CLK_SRC				70
-#define PCIE_AUX_CLK_SRC				71
-#define GCC_PCIE0_AUX_CLK				72
-#define GCC_PCIE1_AUX_CLK				73
-#define GCC_PCIE2_AUX_CLK				74
-#define GCC_PCIE3_AUX_CLK				75
-#define PCIE0_RCHNG_CLK_SRC				76
-#define GCC_PCIE0_RCHNG_CLK				77
-#define PCIE1_RCHNG_CLK_SRC				78
-#define GCC_PCIE1_RCHNG_CLK				79
-#define PCIE2_RCHNG_CLK_SRC				80
-#define GCC_PCIE2_RCHNG_CLK				81
-#define PCIE3_RCHNG_CLK_SRC				82
-#define GCC_PCIE3_RCHNG_CLK				83
-#define GCC_PCIE0_AHB_CLK				84
-#define GCC_PCIE1_AHB_CLK				85
-#define GCC_PCIE2_AHB_CLK				86
-#define GCC_PCIE3_AHB_CLK				87
-#define USB0_AUX_CLK_SRC				88
-#define GCC_USB0_AUX_CLK				89
-#define USB0_MASTER_CLK_SRC				90
-#define GCC_USB0_MASTER_CLK				91
-#define GCC_SNOC_USB_CLK				92
-#define GCC_ANOC_USB_AXI_CLK				93
-#define USB0_MOCK_UTMI_CLK_SRC				94
-#define USB0_MOCK_UTMI_DIV_CLK_SRC			95
-#define GCC_USB0_MOCK_UTMI_CLK				96
-#define USB0_PIPE_CLK_SRC				97
-#define GCC_USB0_PHY_CFG_AHB_CLK			98
-#define SDCC1_APPS_CLK_SRC				99
-#define GCC_SDCC1_APPS_CLK				100
-#define SDCC1_ICE_CORE_CLK_SRC				101
-#define GCC_SDCC1_ICE_CORE_CLK				102
-#define GCC_SDCC1_AHB_CLK				103
-#define PCNOC_BFDCD_CLK_SRC				104
-#define GCC_NSSCFG_CLK					105
-#define GCC_NSSNOC_NSSCC_CLK				106
-#define GCC_NSSCC_CLK					107
-#define GCC_NSSNOC_PCNOC_1_CLK				108
-#define GCC_QDSS_DAP_AHB_CLK				109
-#define GCC_QDSS_CFG_AHB_CLK				110
-#define GCC_QPIC_AHB_CLK				111
-#define GCC_QPIC_CLK					112
-#define GCC_BLSP1_AHB_CLK				113
-#define GCC_MDIO_AHB_CLK				114
-#define GCC_PRNG_AHB_CLK				115
-#define GCC_UNIPHY0_AHB_CLK				116
-#define GCC_UNIPHY1_AHB_CLK				117
-#define GCC_UNIPHY2_AHB_CLK				118
-#define GCC_CMN_12GPLL_AHB_CLK				119
-#define GCC_CMN_12GPLL_APU_CLK				120
-#define SYSTEM_NOC_BFDCD_CLK_SRC			121
-#define GCC_NSSNOC_SNOC_CLK				122
-#define GCC_NSSNOC_SNOC_1_CLK				123
-#define GCC_QDSS_ETR_USB_CLK				124
-#define WCSS_AHB_CLK_SRC				125
-#define GCC_Q6_AHB_CLK					126
-#define GCC_Q6_AHB_S_CLK				127
-#define GCC_WCSS_ECAHB_CLK				128
-#define GCC_WCSS_ACMT_CLK				129
-#define GCC_SYS_NOC_WCSS_AHB_CLK			130
-#define WCSS_AXI_M_CLK_SRC				131
-#define GCC_ANOC_WCSS_AXI_M_CLK				132
-#define QDSS_AT_CLK_SRC					133
-#define GCC_Q6SS_ATBM_CLK				134
-#define GCC_WCSS_DBG_IFC_ATB_CLK			135
-#define GCC_NSSNOC_ATB_CLK				136
-#define GCC_QDSS_AT_CLK					137
-#define GCC_SYS_NOC_AT_CLK				138
-#define GCC_PCNOC_AT_CLK				139
-#define GCC_USB0_EUD_AT_CLK				140
-#define GCC_QDSS_EUD_AT_CLK				141
-#define QDSS_STM_CLK_SRC				142
-#define GCC_QDSS_STM_CLK				143
-#define GCC_SYS_NOC_QDSS_STM_AXI_CLK			144
-#define QDSS_TRACECLKIN_CLK_SRC				145
-#define GCC_QDSS_TRACECLKIN_CLK				146
-#define QDSS_TSCTR_CLK_SRC				147
-#define GCC_Q6_TSCTR_1TO2_CLK				148
-#define GCC_WCSS_DBG_IFC_NTS_CLK			149
-#define GCC_QDSS_TSCTR_DIV2_CLK				150
-#define GCC_QDSS_TS_CLK					151
-#define GCC_QDSS_TSCTR_DIV4_CLK				152
-#define GCC_NSS_TS_CLK					153
-#define GCC_QDSS_TSCTR_DIV8_CLK				154
-#define GCC_QDSS_TSCTR_DIV16_CLK			155
-#define GCC_Q6SS_PCLKDBG_CLK				156
-#define GCC_Q6SS_TRIG_CLK				157
-#define GCC_WCSS_DBG_IFC_APB_CLK			158
-#define GCC_WCSS_DBG_IFC_DAPBUS_CLK			159
-#define GCC_QDSS_DAP_CLK				160
-#define GCC_QDSS_APB2JTAG_CLK				161
-#define GCC_QDSS_TSCTR_DIV3_CLK				162
-#define QPIC_IO_MACRO_CLK_SRC				163
-#define GCC_QPIC_IO_MACRO_CLK                           164
-#define Q6_AXI_CLK_SRC					165
-#define GCC_Q6_AXIM_CLK					166
-#define GCC_WCSS_Q6_TBU_CLK				167
-#define GCC_MEM_NOC_Q6_AXI_CLK				168
-#define Q6_AXIM2_CLK_SRC				169
-#define NSSNOC_MEMNOC_BFDCD_CLK_SRC			170
-#define GCC_NSSNOC_MEMNOC_CLK				171
-#define GCC_NSSNOC_MEM_NOC_1_CLK			172
-#define GCC_NSS_TBU_CLK					173
-#define GCC_MEM_NOC_NSSNOC_CLK				174
-#define LPASS_AXIM_CLK_SRC				175
-#define LPASS_SWAY_CLK_SRC				176
-#define ADSS_PWM_CLK_SRC				177
-#define GCC_ADSS_PWM_CLK				178
-#define GP1_CLK_SRC					179
-#define GP2_CLK_SRC					180
-#define GP3_CLK_SRC					181
-#define DDRSS_SMS_SLOW_CLK_SRC				182
-#define GCC_XO_CLK_SRC					183
-#define GCC_XO_CLK					184
-#define GCC_NSSNOC_QOSGEN_REF_CLK			185
-#define GCC_NSSNOC_TIMEOUT_REF_CLK			186
-#define GCC_XO_DIV4_CLK					187
-#define GCC_UNIPHY0_SYS_CLK				188
-#define GCC_UNIPHY1_SYS_CLK				189
-#define GCC_UNIPHY2_SYS_CLK				190
-#define GCC_CMN_12GPLL_SYS_CLK				191
-#define GCC_NSSNOC_XO_DCD_CLK				192
-#define GCC_Q6SS_BOOT_CLK				193
-#define UNIPHY_SYS_CLK_SRC				194
-#define NSS_TS_CLK_SRC					195
-#define GCC_ANOC_PCIE0_1LANE_M_CLK			196
-#define GCC_ANOC_PCIE1_1LANE_M_CLK			197
-#define GCC_ANOC_PCIE2_2LANE_M_CLK			198
-#define GCC_ANOC_PCIE3_2LANE_M_CLK			199
-#define GCC_SNOC_PCIE0_1LANE_S_CLK			200
-#define GCC_SNOC_PCIE1_1LANE_S_CLK			201
-#define GCC_SNOC_PCIE2_2LANE_S_CLK			202
-#define GCC_SNOC_PCIE3_2LANE_S_CLK			203
+#define GCC_PCIE0_PIPE_CLK				68
+#define PCIE1_PIPE_CLK_SRC				69
+#define GCC_PCIE1_PIPE_CLK				70
+#define PCIE2_PIPE_CLK_SRC				71
+#define GCC_PCIE2_PIPE_CLK				72
+#define PCIE3_PIPE_CLK_SRC				73
+#define GCC_PCIE3_PIPE_CLK				74
+#define PCIE_AUX_CLK_SRC				75
+#define GCC_PCIE0_AUX_CLK				76
+#define GCC_PCIE1_AUX_CLK				77
+#define GCC_PCIE2_AUX_CLK				78
+#define GCC_PCIE3_AUX_CLK				79
+#define PCIE0_RCHNG_CLK_SRC				80
+#define GCC_PCIE0_RCHNG_CLK				81
+#define PCIE1_RCHNG_CLK_SRC				82
+#define GCC_PCIE1_RCHNG_CLK				83
+#define PCIE2_RCHNG_CLK_SRC				84
+#define GCC_PCIE2_RCHNG_CLK				85
+#define PCIE3_RCHNG_CLK_SRC				86
+#define GCC_PCIE3_RCHNG_CLK				87
+#define GCC_PCIE0_AHB_CLK				88
+#define GCC_PCIE1_AHB_CLK				89
+#define GCC_PCIE2_AHB_CLK				90
+#define GCC_PCIE3_AHB_CLK				91
+#define USB0_AUX_CLK_SRC				92
+#define GCC_USB0_AUX_CLK				93
+#define USB0_MASTER_CLK_SRC				94
+#define GCC_USB0_MASTER_CLK				95
+#define GCC_SNOC_USB_CLK				96
+#define GCC_ANOC_USB_AXI_CLK				97
+#define USB0_MOCK_UTMI_CLK_SRC				98
+#define USB0_MOCK_UTMI_DIV_CLK_SRC			99
+#define GCC_USB0_MOCK_UTMI_CLK				100
+#define USB0_PIPE_CLK_SRC				101
+#define GCC_USB0_PHY_CFG_AHB_CLK			102
+#define SDCC1_APPS_CLK_SRC				103
+#define GCC_SDCC1_APPS_CLK				104
+#define SDCC1_ICE_CORE_CLK_SRC				105
+#define GCC_SDCC1_ICE_CORE_CLK				106
+#define GCC_SDCC1_AHB_CLK				107
+#define PCNOC_BFDCD_CLK_SRC				108
+#define GCC_NSSCFG_CLK					109
+#define GCC_NSSNOC_NSSCC_CLK				110
+#define GCC_NSSCC_CLK					111
+#define GCC_NSSNOC_PCNOC_1_CLK				112
+#define GCC_QDSS_DAP_AHB_CLK				113
+#define GCC_QDSS_CFG_AHB_CLK				114
+#define GCC_QPIC_AHB_CLK				115
+#define GCC_QPIC_CLK					116
+#define GCC_BLSP1_AHB_CLK				117
+#define GCC_MDIO_AHB_CLK				118
+#define GCC_PRNG_AHB_CLK				119
+#define GCC_UNIPHY0_AHB_CLK				120
+#define GCC_UNIPHY1_AHB_CLK				121
+#define GCC_UNIPHY2_AHB_CLK				122
+#define GCC_CMN_12GPLL_AHB_CLK				123
+#define GCC_CMN_12GPLL_APU_CLK				124
+#define SYSTEM_NOC_BFDCD_CLK_SRC			125
+#define GCC_NSSNOC_SNOC_CLK				126
+#define GCC_NSSNOC_SNOC_1_CLK				127
+#define GCC_QDSS_ETR_USB_CLK				128
+#define WCSS_AHB_CLK_SRC				129
+#define GCC_Q6_AHB_CLK					130
+#define GCC_Q6_AHB_S_CLK				131
+#define GCC_WCSS_ECAHB_CLK				132
+#define GCC_WCSS_ACMT_CLK				133
+#define GCC_SYS_NOC_WCSS_AHB_CLK			134
+#define WCSS_AXI_M_CLK_SRC				135
+#define GCC_ANOC_WCSS_AXI_M_CLK				136
+#define QDSS_AT_CLK_SRC					137
+#define GCC_Q6SS_ATBM_CLK				138
+#define GCC_WCSS_DBG_IFC_ATB_CLK			139
+#define GCC_NSSNOC_ATB_CLK				140
+#define GCC_QDSS_AT_CLK					141
+#define GCC_SYS_NOC_AT_CLK				142
+#define GCC_PCNOC_AT_CLK				143
+#define GCC_USB0_EUD_AT_CLK				144
+#define GCC_QDSS_EUD_AT_CLK				145
+#define QDSS_STM_CLK_SRC				146
+#define GCC_QDSS_STM_CLK				147
+#define GCC_SYS_NOC_QDSS_STM_AXI_CLK			148
+#define QDSS_TRACECLKIN_CLK_SRC				149
+#define GCC_QDSS_TRACECLKIN_CLK				150
+#define QDSS_TSCTR_CLK_SRC				151
+#define GCC_Q6_TSCTR_1TO2_CLK				152
+#define GCC_WCSS_DBG_IFC_NTS_CLK			153
+#define GCC_QDSS_TSCTR_DIV2_CLK				154
+#define GCC_QDSS_TS_CLK					155
+#define GCC_QDSS_TSCTR_DIV4_CLK				156
+#define GCC_NSS_TS_CLK					157
+#define GCC_QDSS_TSCTR_DIV8_CLK				158
+#define GCC_QDSS_TSCTR_DIV16_CLK			159
+#define GCC_Q6SS_PCLKDBG_CLK				160
+#define GCC_Q6SS_TRIG_CLK				161
+#define GCC_WCSS_DBG_IFC_APB_CLK			162
+#define GCC_WCSS_DBG_IFC_DAPBUS_CLK			163
+#define GCC_QDSS_DAP_CLK				164
+#define GCC_QDSS_APB2JTAG_CLK				165
+#define GCC_QDSS_TSCTR_DIV3_CLK				166
+#define QPIC_IO_MACRO_CLK_SRC				167
+#define GCC_QPIC_IO_MACRO_CLK                           168
+#define Q6_AXI_CLK_SRC					169
+#define GCC_Q6_AXIM_CLK					170
+#define GCC_WCSS_Q6_TBU_CLK				171
+#define GCC_MEM_NOC_Q6_AXI_CLK				172
+#define Q6_AXIM2_CLK_SRC				173
+#define NSSNOC_MEMNOC_BFDCD_CLK_SRC			174
+#define GCC_NSSNOC_MEMNOC_CLK				175
+#define GCC_NSSNOC_MEM_NOC_1_CLK			176
+#define GCC_NSS_TBU_CLK					177
+#define GCC_MEM_NOC_NSSNOC_CLK				178
+#define LPASS_AXIM_CLK_SRC				179
+#define LPASS_SWAY_CLK_SRC				180
+#define ADSS_PWM_CLK_SRC				181
+#define GCC_ADSS_PWM_CLK				182
+#define GP1_CLK_SRC					183
+#define GP2_CLK_SRC					184
+#define GP3_CLK_SRC					185
+#define DDRSS_SMS_SLOW_CLK_SRC				186
+#define GCC_XO_CLK_SRC					187
+#define GCC_XO_CLK					188
+#define GCC_NSSNOC_QOSGEN_REF_CLK			189
+#define GCC_NSSNOC_TIMEOUT_REF_CLK			190
+#define GCC_XO_DIV4_CLK					191
+#define GCC_UNIPHY0_SYS_CLK				192
+#define GCC_UNIPHY1_SYS_CLK				193
+#define GCC_UNIPHY2_SYS_CLK				194
+#define GCC_CMN_12GPLL_SYS_CLK				195
+#define GCC_NSSNOC_XO_DCD_CLK				196
+#define GCC_Q6SS_BOOT_CLK				197
+#define UNIPHY_SYS_CLK_SRC				198
+#define NSS_TS_CLK_SRC					199
+#define GCC_ANOC_PCIE0_1LANE_M_CLK			200
+#define GCC_ANOC_PCIE1_1LANE_M_CLK			201
+#define GCC_ANOC_PCIE2_2LANE_M_CLK			202
+#define GCC_ANOC_PCIE3_2LANE_M_CLK			203
+#define GCC_SNOC_PCIE0_1LANE_S_CLK			204
+#define GCC_SNOC_PCIE1_1LANE_S_CLK			205
+#define GCC_SNOC_PCIE2_2LANE_S_CLK			206
+#define GCC_SNOC_PCIE3_2LANE_S_CLK			207
 #endif
-- 
2.17.1

