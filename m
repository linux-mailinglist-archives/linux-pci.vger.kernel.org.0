Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB66569A73C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Feb 2023 09:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBQIoY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Feb 2023 03:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQIoX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Feb 2023 03:44:23 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4071A4BEAA;
        Fri, 17 Feb 2023 00:44:22 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7JHJG010166;
        Fri, 17 Feb 2023 08:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RoG3QFgx+g3HhxufoiewTaGFcRP7fYRH09/0OCg480Q=;
 b=HkpgO82b2hbQGx7OdqKRN3rb7AO33/0Hx89MCMekrL8tOJ1X/0OLycykY6B80IOM+NtO
 1Oyuylb9embvBHkDDulb3pfGqO08PkVNP97QehepIZgrb5fKsVmPtxKw/Egy25hVuul+
 BWeQ7b2CI/WfK7/vdgGNyqXyuQIwxQWsppbmC3Xu5frLoB/+Eu1pW0mFGEtLACQfDX/T
 TCtn+rPTyIQFgUZg8ykD9CdL+zvwKhn5mAWveQTzmkQ0mHHEteoRKY+W4tbxpugB3rTj
 DjE4UaKq/tekb3rCF3BJ06eUJ65hqpbteLZWOdCf1aIIgTuQVBEeK40H+Kn4ZUhyLX9s hw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nt53br6c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:44:09 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31H8i8vg008811
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 08:44:08 GMT
Received: from [10.216.47.237] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 17 Feb
 2023 00:43:59 -0800
Message-ID: <0d5f6df8-bb44-f9fe-8d5c-50e488ae4c53@quicinc.com>
Date:   Fri, 17 Feb 2023 14:13:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 6/7] clk: qcom: gcc-ipq9574: Add PCIe related clocks
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <svarbanov@mm-sol.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-7-quic_devipriy@quicinc.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20230214164135.17039-7-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RIiwdB0XPaWUQ__aRXKlMpHkWzISZ-kJ
X-Proofpoint-GUID: RIiwdB0XPaWUQ__aRXKlMpHkWzISZ-kJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_04,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=971 spamscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170077
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Devi,

On 2/14/2023 10:11 PM, Devi Priya wrote:
> Add the clocks needed for enabling PCIe in IPQ9574
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>   drivers/clk/qcom/gcc-ipq9574.c | 76 ++++++++++++++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
> index b2a2d618a5ec..1bf33d582dc2 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -1538,6 +1538,24 @@ static struct clk_regmap_phy_mux pcie0_pipe_clk_src = {
>   	},
>   };
>   
> +static struct clk_branch gcc_pcie0_pipe_clk = {
> +	.halt_reg = 0x28044,
> +	.halt_check = BRANCH_HALT_DELAY,
> +	.clkr = {
> +		.enable_reg = 0x28044,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_pcie0_pipe_clk",
> +			.parent_hws = (const struct clk_hw *[]) {
> +				&pcie0_pipe_clk_src.clkr.hw
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +

   Also, this patch should come before your phy driver updates.

Regards,
  Sricharan

