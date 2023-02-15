Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952B06974BF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjBODSm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBODSl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:18:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E0241D6;
        Tue, 14 Feb 2023 19:18:40 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F1n8de022336;
        Wed, 15 Feb 2023 03:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QQZXePndB0lAR9S6w3Ec7/K5ucqSD6ZFFKzDBN8FhwI=;
 b=KPzk68EGAKfLfKwPdJ/X8VLy6tXidZfSXfQdkPk7lapugrtU8cxhEKs16WJAPMkXNBKu
 ipdXITFtBgK0k64+ecdm682ZyUAAkSpf5+pkLb4olOLmUiBf33gfRvM+LWWOc64hNPH/
 uWSVbAW6rTcIgryGRQWmEOYAX1kmQQ9rO4MehvXq/X3uaT1W8kHQ6/ww0yv7CPe8ZYd8
 eTXuNIBbjar//TT8mebvr79St0LTC9+iZ7+jY6SFoBvMcN/qBXU5T0WDida2Q8SMIcb0
 zGNwtl6lLORvs0K+uaHvxN+SdUo4pGIvPXdJI501+tLwVRS92Bf5WrVQ/xRPs5XS6pZj Zw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqyyguhab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 03:18:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31F3IHi8001607
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 03:18:17 GMT
Received: from [10.50.15.255] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 19:18:09 -0800
Message-ID: <9fc73f31-71c7-f69c-ace1-2ddc9967ef36@quicinc.com>
Date:   Wed, 15 Feb 2023 08:48:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/7] dt-bindings: clock: Add PCIe pipe clock definitions
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <bhelgaas@google.com>,
        <devicetree@vger.kernel.org>, <kishon@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <kw@linux.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <lpieralisi@kernel.org>, <mani@kernel.org>,
        <mturquette@baylibre.com>, <p.zabel@pengutronix.de>,
        <robh@kernel.org>, <svarbanov@mm-sol.com>, <vkoul@kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-6-quic_devipriy@quicinc.com>
 <f439f476121a5624b5243b0b340bd9a4.sboyd@kernel.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <f439f476121a5624b5243b0b340bd9a4.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MSlr6nO5gYxTqeSQJsj7-XOScK86BMTD
X-Proofpoint-GUID: MSlr6nO5gYxTqeSQJsj7-XOScK86BMTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_17,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150028
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for taking time to review the patch!

On 2/15/2023 8:00 AM, Stephen Boyd wrote:
> Quoting Devi Priya (2023-02-14 08:41:33)
>> Add PCIe clock definitions for IPQ9574 SoC
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   include/dt-bindings/clock/qcom,ipq9574-gcc.h | 276 ++++++++++---------
>>   1 file changed, 140 insertions(+), 136 deletions(-)
>>
>> diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>> index feedfdd5e00a..c89e96d568c6 100644
>> --- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>> +++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
>> @@ -74,140 +74,144 @@
>>   #define GCC_PCIE3_AXI_S_BRIDGE_CLK                     65
>>   #define GCC_PCIE3_AXI_S_CLK                            66
>>   #define PCIE0_PIPE_CLK_SRC                             67
>> -#define PCIE1_PIPE_CLK_SRC                             68
> 
> Just add the new define at the end. This number and define is ABI
> forever and shouldn't change.
Sure, will update
> 
>> -#define PCIE2_PIPE_CLK_SRC                             69
>> -#define PCIE3_PIPE_CLK_SRC                             70
Best Regards,
Devi Priya
