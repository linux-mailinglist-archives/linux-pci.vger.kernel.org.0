Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856CE6DC872
	for <lists+linux-pci@lfdr.de>; Mon, 10 Apr 2023 17:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDJPYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Apr 2023 11:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjDJPYf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Apr 2023 11:24:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916A0524C;
        Mon, 10 Apr 2023 08:24:25 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33ADwNWW020502;
        Mon, 10 Apr 2023 15:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=B7hktaHS3+Jr0jFS7OIhmXVXwXbZ+Qs2ec9yQjGds/c=;
 b=P3lIw3FyQ88l4rqtMgQRq5lwEce9jJAtfjfJk4ipQFTXsWDwy1xX7mLUPlkcrqWQ3+3Y
 nwLPYCcXHde5AIXXGwjQJSvi+HJe8LFM/Ix3mVxmk3AUyXiADuM0tdHZBSpYO714h7mJ
 xhcAWiy/7FsiHtF7DlcBhHm3cuQqY3f/dtHsNxwvG6KHa/TjhZGQbjcl3RXiEmhw1RCT
 oY6nX172mO71BEIRqmbU2/0T+ipBL+38TJrb8M4ZKtggW5zwOYIL1Er/p0Esj3YEJOHO
 MFITBP6YRdYEcxmyNAvaHaCdBHeN4BGbKJ3wUDND0Kp0P+yRL81uv6ImmRZaxZy+r04c EQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pvj1krej9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 15:24:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33AFO49D011750
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Apr 2023 15:24:04 GMT
Received: from [10.216.3.168] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 10 Apr
 2023 08:23:55 -0700
Message-ID: <5d8df470-b4e2-54ab-4f64-9d9faa747e43@quicinc.com>
Date:   Mon, 10 Apr 2023 20:53:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 4/9] phy: qcom-qmp-pcie: Add support for IPQ9574 g3x1
 and g3x2 PCIEs
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lpieralisi@kernel.org>,
        <kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <mani@kernel.org>,
        <p.zabel@pengutronix.de>, <linus.walleij@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <quic_srichara@quicinc.com>,
        <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_ipkumar@quicinc.com>
References: <20230404164828.8031-1-quic_devipriy@quicinc.com>
 <20230404164828.8031-5-quic_devipriy@quicinc.com> <ZDQpcvIoug2plELg@matsya>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <ZDQpcvIoug2plELg@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: roDphO_ufNFh7TyiCr9PJ6vDQHBz8197
X-Proofpoint-ORIG-GUID: roDphO_ufNFh7TyiCr9PJ6vDQHBz8197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_09,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100131
X-Spam-Status: No, score=-2.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/10/2023 8:51 PM, Vinod Koul wrote:
> On 04-04-23, 22:18, Devi Priya wrote:
>> Add support for a single-lane and two-lane PCIe PHYs
>> found on Qualcomm IPQ9574 platform.
> 
> Is there a reason to have the phy patches with the whole pile. Didnt
> notice any dependency, so please consider splitting per susbsystem
> (hint: that will get you faster reviews as well)
> 
Sure, thanks!
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V2:
>> 	- Added qmp_pcie_offsets for ipq9574 3x1 and 3x2 PHY
>> 	  configuration as it does not contain child node
>>
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c      | 332 ++++++++++++++++++
>>   .../phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h   |  26 +-
>>   .../phy/qualcomm/phy-qcom-qmp-qserdes-pll.h   |   3 +
>>   3 files changed, 355 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index b1e81530d551..39ed2076bdce 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -515,6 +515,250 @@ static const struct qmp_phy_init_tbl ipq8074_pcie_gen3_pcs_misc_tbl[] = {
>>   	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
>>   };
>>   
>> +static const struct qmp_phy_init_tbl ipq9574_gen3x1_pcie_serdes_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CLKBUFLR_EN, 0x18),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CTRL_BY_PSM, 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x31),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_IVCO, 0x0F),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TRIM, 0x0F),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CMN_CONFIG, 0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP_EN, 0x42),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_RESETSM_CNTRL, 0x20),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_MAP, 0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER1, 0xFF),
> 
> small cases for hex values please.
Okay
> 
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER2, 0x3F),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x30),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x21),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE0, 0x68),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE0, 0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE0, 0xAA),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE0, 0xAB),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE0, 0x14),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE0, 0xD4),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE0, 0x09),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE0, 0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE0, 0x28),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE0, 0xA0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE0, 0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE0, 0x24),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x20),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV, 0x0A),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x32),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYS_CLK_CTRL, 0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_BUF_ENABLE, 0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_EN_SEL, 0x08),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TIMER, 0x0A),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE1, 0x53),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE1, 0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE1, 0x55),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE1, 0x55),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE1, 0x29),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE1, 0xAA),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE1, 0x09),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE1, 0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE1, 0x28),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE1, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE1, 0xA0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE1, 0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE1, 0xB4),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV_MODE1, 0x08),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_EN_CENTER, 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER1, 0x7D),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER2, 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_ADJ_PER1, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_ADJ_PER2, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE0, 0x0A),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE0, 0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE1, 0x08),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE1, 0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE0, 0x19),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE1, 0x28),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x90),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x89),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x10),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_serdes_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CLKBUFLR_EN, 0x18),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BIAS_EN_CTRL_BY_PSM, 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x31),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_IVCO, 0x0F),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TRIM, 0x0F),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CMN_CONFIG, 0x06),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP_EN, 0x42),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_RESETSM_CNTRL, 0x20),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_MAP, 0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER1, 0xFF),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE_TIMER2, 0x3F),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x30),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x21),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE0, 0x68),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE0, 0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE0, 0xAA),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE0, 0xAB),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE0, 0x14),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE0, 0xD4),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE0, 0x09),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE0, 0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE0, 0x28),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE0, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE0, 0xA0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE0, 0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE0, 0x24),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV, 0x0A),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_SELECT, 0x32),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYS_CLK_CTRL, 0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_BUF_ENABLE, 0x07),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SYSCLK_EN_SEL, 0x08),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_BG_TIMER, 0x0A),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DEC_START_MODE1, 0x53),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START3_MODE1, 0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START2_MODE1, 0x55),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_DIV_FRAC_START1_MODE1, 0x55),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP2_MODE1, 0x29),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_LOCK_CMP1_MODE1, 0xAA),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CP_CTRL_MODE1, 0x09),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_RCTRL_MODE1, 0x16),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_PLL_CCTRL_MODE1, 0x28),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN1_MODE1, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_INTEGLOOP_GAIN0_MODE1, 0xA0),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE2_MODE1, 0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_VCO_TUNE1_MODE1, 0xB4),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SVS_MODE_CLK_SEL, 0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORE_CLK_EN, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CORECLK_DIV_MODE1, 0x08),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_EN_CENTER, 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER1, 0x7D),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_PER2, 0x01),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_ADJ_PER1, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_ADJ_PER2, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE0, 0x0A),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE0, 0x05),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE1_MODE1, 0x08),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_SSC_STEP_SIZE2_MODE1, 0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE0, 0x19),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_EP_DIV_MODE1, 0x28),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x90),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_HSCLK_SEL, 0x89),
>> +	QMP_PHY_INIT_CFG(QSERDES_PLL_CLK_ENABLE1, 0x10),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_pcie_tx_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_HIGHZ_DRVR_EN, 0x10),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x06),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_pcie_rx_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x03),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_ENABLES, 0x1C),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x14),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x61),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1E),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0C),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7F),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x70),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1, 0x73),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x80),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_LOW, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH, 0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH2, 0xC8),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH3, 0x09),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0xB1),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xC8),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x09),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xB1),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0xF0),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x02),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0x2F),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0xD3),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x40),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
>> +	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xC0),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_gen3x1_pcie_pcs_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_DCC_CAL_CONFIG, 0x01),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xAA),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x0D),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_G12S1_TXDEEMPH_M3P5DB, 0x10),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_gen3x1_pcie_pcs_misc_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG2, 0x0D),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_EQ_CONFIG1, 0x14),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_EQ_CONFIG1, 0x10),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_EQ_CONFIG2, 0x0B),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P10_PRE, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P10_POST, 0x58),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_CONFIG2, 0x52),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2, 0x50),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4, 0x1A),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x06),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6, 0x03),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xC1),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_pcs_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x0D),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_G12S1_TXDEEMPH_M3P5DB, 0x10),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_DCC_CAL_CONFIG, 0x01),
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xAA),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl ipq9574_gen3x2_pcie_pcs_misc_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2, 0x1D),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG1, 0x14),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG1, 0x10),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_EQ_CONFIG2, 0x0B),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_PRESET_P10_PRE, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_PRESET_P10_POST, 0x58),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG1, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG2, 0x52),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG4, 0x19),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1, 0x00),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2, 0x49),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4, 0x2A),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x02),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6, 0x03),
>> +	QMP_PHY_INIT_CFG(QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xC1),
>> +};
>> +
>>   static const struct qmp_phy_init_tbl sdm845_qmp_pcie_serdes_tbl[] = {
>>   	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
>>   	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
>> @@ -2045,6 +2289,10 @@ static const char * const ipq8074_pciephy_clk_l[] = {
>>   	"aux", "cfg_ahb",
>>   };
>>   
>> +static const char * const ipq9574_pciephy_clk_l[] = {
>> +	"aux", "cfg_ahb", "anoc_lane", "snoc_lane",
>> +};
>> +
>>   static const char * const msm8996_phy_clk_l[] = {
>>   	"aux", "cfg_ahb", "ref",
>>   };
>> @@ -2075,6 +2323,24 @@ static const char * const sdm845_pciephy_reset_l[] = {
>>   	"phy",
>>   };
>>   
>> +static const struct qmp_pcie_offsets qmp_pcie_offsets_3x1_ipq9574 = {
>> +	.serdes         = 0,
>> +	.tx             = 0x0200,
>> +	.rx             = 0x0400,
>> +	.pcs            = 0x0800,
>> +	.pcs_misc       = 0x0c00,
>> +};
>> +
>> +static const struct qmp_pcie_offsets qmp_pcie_offsets_3x2_ipq9574 = {
>> +	.serdes		= 0,
>> +	.tx		= 0x0200,
>> +	.rx		= 0x0400,
>> +	.tx2		= 0x0600,
>> +	.rx2		= 0x0800,
>> +	.pcs		= 0x1000,
>> +	.pcs_misc	= 0x1400,
>> +};
>> +
>>   static const struct qmp_pcie_offsets qmp_pcie_offsets_v5 = {
>>   	.serdes		= 0,
>>   	.pcs		= 0x0200,
>> @@ -2177,6 +2443,66 @@ static const struct qmp_phy_cfg ipq6018_pciephy_cfg = {
>>   	.phy_status		= PHYSTATUS,
>>   };
>>   
>> +static const struct qmp_phy_cfg ipq9574_gen3x1_pciephy_cfg = {
>> +	.lanes			= 1,
>> +
>> +	.offsets		= &qmp_pcie_offsets_3x1_ipq9574,
>> +
>> +	.tbls = {
>> +		.serdes		= ipq9574_gen3x1_pcie_serdes_tbl,
>> +		.serdes_num	= ARRAY_SIZE(ipq9574_gen3x1_pcie_serdes_tbl),
>> +		.tx		= ipq9574_pcie_tx_tbl,
>> +		.tx_num		= ARRAY_SIZE(ipq9574_pcie_tx_tbl),
>> +		.rx		= ipq9574_pcie_rx_tbl,
>> +		.rx_num		= ARRAY_SIZE(ipq9574_pcie_rx_tbl),
>> +		.pcs		= ipq9574_gen3x1_pcie_pcs_tbl,
>> +		.pcs_num	= ARRAY_SIZE(ipq9574_gen3x1_pcie_pcs_tbl),
>> +		.pcs_misc	= ipq9574_gen3x1_pcie_pcs_misc_tbl,
>> +		.pcs_misc_num	= ARRAY_SIZE(ipq9574_gen3x1_pcie_pcs_misc_tbl),
>> +	},
>> +	.clk_list		= ipq9574_pciephy_clk_l,
>> +	.num_clks		= ARRAY_SIZE(ipq9574_pciephy_clk_l),
>> +	.reset_list		= ipq8074_pciephy_reset_l,
>> +	.num_resets		= ARRAY_SIZE(ipq8074_pciephy_reset_l),
>> +	.vreg_list		= NULL,
>> +	.num_vregs		= 0,
>> +	.regs			= pciephy_v4_regs_layout,
>> +
>> +	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>> +	.phy_status		= PHYSTATUS,
>> +	.pipe_clock_rate	= 250000000,
>> +};
>> +
>> +static const struct qmp_phy_cfg ipq9574_gen3x2_pciephy_cfg = {
>> +	.lanes			= 2,
>> +
>> +	.offsets		= &qmp_pcie_offsets_3x2_ipq9574,
>> +
>> +	.tbls = {
>> +		.serdes		= ipq9574_gen3x2_pcie_serdes_tbl,
>> +		.serdes_num	= ARRAY_SIZE(ipq9574_gen3x2_pcie_serdes_tbl),
>> +		.tx		= ipq9574_pcie_tx_tbl,
>> +		.tx_num		= ARRAY_SIZE(ipq9574_pcie_tx_tbl),
>> +		.rx		= ipq9574_pcie_rx_tbl,
>> +		.rx_num		= ARRAY_SIZE(ipq9574_pcie_rx_tbl),
>> +		.pcs		= ipq9574_gen3x2_pcie_pcs_tbl,
>> +		.pcs_num	= ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_tbl),
>> +		.pcs_misc	= ipq9574_gen3x2_pcie_pcs_misc_tbl,
>> +		.pcs_misc_num	= ARRAY_SIZE(ipq9574_gen3x2_pcie_pcs_misc_tbl),
>> +	},
>> +	.clk_list		= ipq9574_pciephy_clk_l,
>> +	.num_clks		= ARRAY_SIZE(ipq9574_pciephy_clk_l),
>> +	.reset_list		= ipq8074_pciephy_reset_l,
>> +	.num_resets		= ARRAY_SIZE(ipq8074_pciephy_reset_l),
>> +	.vreg_list		= NULL,
>> +	.num_vregs		= 0,
>> +	.regs			= pciephy_v4_regs_layout,
>> +
>> +	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
>> +	.phy_status		= PHYSTATUS,
>> +	.pipe_clock_rate	= 250000000,
>> +};
>> +
>>   static const struct qmp_phy_cfg sdm845_qmp_pciephy_cfg = {
>>   	.lanes			= 1,
>>   
>> @@ -3379,6 +3705,12 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>>   	}, {
>>   		.compatible = "qcom,ipq8074-qmp-pcie-phy",
>>   		.data = &ipq8074_pciephy_cfg,
>> +	}, {
>> +		.compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy",
>> +		.data = &ipq9574_gen3x1_pciephy_cfg,
>> +	}, {
>> +		.compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy",
>> +		.data = &ipq9574_gen3x2_pciephy_cfg,
>>   	}, {
>>   		.compatible = "qcom,msm8998-qmp-pcie-phy",
>>   		.data = &msm8998_pciephy_cfg,
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
>> index a469ae2a10a1..5f002b150cea 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
>> @@ -8,11 +8,25 @@
>>   #define QCOM_PHY_QMP_PCS_PCIE_V5_H_
>>   
>>   /* Only for QMP V5 PHY - PCS_PCIE registers */
>> -#define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2		0x0c
>> -#define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4		0x14
>> -#define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE		0x20
>> -#define QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1		0x54
>> -#define QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS		0x94
>> -#define QPHY_V5_PCS_PCIE_EQ_CONFIG2			0xa8
>> +#define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG2			0x0c
>> +#define QPHY_V5_PCS_PCIE_POWER_STATE_CONFIG4			0x14
>> +#define QPHY_V5_PCS_PCIE_ENDPOINT_REFCLK_DRIVE			0x20
>> +#define QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L		0x44
>> +#define QPHY_V5_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_H		0x48
>> +#define QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L		0x4c
>> +#define QPHY_V5_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_H		0x50
>> +#define QPHY_V5_PCS_PCIE_INT_AUX_CLK_CONFIG1			0x54
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG1			0x5c
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG2			0x60
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_CONFIG4			0x68
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG2			0x7c
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG4			0x84
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5			0x88
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_MODE2_CONFIG6			0x8c
>> +#define QPHY_V5_PCS_PCIE_OSC_DTCT_ACTIONS			0x94
>> +#define QPHY_V5_PCS_PCIE_EQ_CONFIG1				0xa4
>> +#define QPHY_V5_PCS_PCIE_EQ_CONFIG2				0xa8
>> +#define QPHY_V5_PCS_PCIE_PRESET_P10_PRE				0xc0
>> +#define QPHY_V5_PCS_PCIE_PRESET_P10_POST			0xe4
>>   
>>   #endif
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h
>> index ad326e301a3a..231e59364e31 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h
>> @@ -8,6 +8,9 @@
>>   
>>   /* QMP V2 PHY for PCIE gen3 ports - QSERDES PLL registers */
>>   #define QSERDES_PLL_BG_TIMER				0x00c
>> +#define QSERDES_PLL_SSC_EN_CENTER			0x010
>> +#define QSERDES_PLL_SSC_ADJ_PER1			0x014
>> +#define QSERDES_PLL_SSC_ADJ_PER2			0x018
>>   #define QSERDES_PLL_SSC_PER1				0x01c
>>   #define QSERDES_PLL_SSC_PER2				0x020
>>   #define QSERDES_PLL_SSC_STEP_SIZE1_MODE0		0x024
>> -- 
>> 2.17.1
> 
Best Regards,
Devi Priya
