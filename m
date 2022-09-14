Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EAD5B7EA6
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 03:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiINBsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 21:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiINBsM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 21:48:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E396E8BF;
        Tue, 13 Sep 2022 18:48:11 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E0tWk0017499;
        Wed, 14 Sep 2022 01:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2Z+/JonFdZpRQOIxQN4GAnusCIrl7PDPZpungI506Ec=;
 b=Mby/NQVTAteT58+4g32ZX9F4Ey5VoSXFMTi1TxJ47N1gRZvmMR6Nr3uxWC7XHkY6zJMv
 MHOcBsn5Osr9NQdKRu1HqNe8RIQ+F+ifa6I0SGYy4zqdiIZuA9Uu6mYPCMe4wgzq2omo
 C9CW7y5TVIsohDYtL1+47UiryBiKPRDmFctsmYr1f9ZoF+q5NlRIOST6WaAP8gQnPgNp
 Jy8qe5yYXCeLNS1PfnUHBVurGEZv1sk0WCbpxUfufA++8MUlvPLr3UDLDsu5kGJGyVw9
 /haqS8aHN70wC6kEMyUmev3K1QZIdeJZNrRBqhxkHGJxUqb9TxwOjPWVj0l+piA/GjJ3 wQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy0b8p3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 01:48:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28E1m46m004759
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 01:48:04 GMT
Received: from [10.216.1.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 18:47:57 -0700
Message-ID: <3c582fa2-7596-df33-7f5d-62cf23061f21@quicinc.com>
Date:   Wed, 14 Sep 2022 07:17:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 5/5] clk: qcom: Alwaya on pcie gdsc
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mka@chromium.org>, <quic_vbadigan@quicinc.com>,
        <quic_hemantk@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
References: <1662713084-8106-1-git-send-email-quic_krichai@quicinc.com>
 <1662713084-8106-6-git-send-email-quic_krichai@quicinc.com>
 <20220912170437.GA36223@thinkpad>
 <49536ca8-ef98-9927-d1be-977ab5244c91@quicinc.com>
 <20220913164233.GF25849@workstation>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20220913164233.GF25849@workstation>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9uF4CngIVbRObr3F1nF__AnTS-TbgmKw
X-Proofpoint-ORIG-GUID: 9uF4CngIVbRObr3F1nF__AnTS-TbgmKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=974
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140006
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/13/2022 10:12 PM, Manivannan Sadhasivam wrote:
> On Tue, Sep 13, 2022 at 12:12:32PM +0530, Rajendra Nayak wrote:
>> On 9/12/2022 10:34 PM, Manivannan Sadhasivam wrote:
>>> + Rajendra
>>>
>>> On Fri, Sep 09, 2022 at 02:14:44PM +0530, Krishna chaitanya chundru wrote:
>>>> Make GDSC always on to ensure controller and its dependent clocks
>>>> won't go down during system suspend.
>>>>
>>> You need to mention the SoC name in subject, otherwise one cannot know for
>>> which platform this patch applies to.
>>>
>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>>> ---
>>>>    drivers/clk/qcom/gcc-sc7280.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
>>>> index 7ff64d4..2f781a2 100644
>>>> --- a/drivers/clk/qcom/gcc-sc7280.c
>>>> +++ b/drivers/clk/qcom/gcc-sc7280.c
>>>> @@ -3109,7 +3109,7 @@ static struct gdsc gcc_pcie_1_gdsc = {
>>>>    		.name = "gcc_pcie_1_gdsc",
>>>>    	},
>>>>    	.pwrsts = PWRSTS_OFF_ON,
>>>> -	.flags = VOTABLE,
>>>> +	.flags = ALWAYS_ON,
>>> Rajendra, should we also put PCIe GDSC into retention state as you have done for
>>> USB [1]?
>> Yes, it looks like we should handle this the same way as we did with usb.
> Okay, thanks for the confirmation.
>
>> Why are we removing the VOTABLE flag anyway?
> Yeah, I don't see a reason for doing that.
>
> Chaitanya, please follow the patch from Rajendra I mentioned above and adapt it
> for PCIe GDSC.
>
> Thanks,
> Mani
ok I will try to adapt that.
>>> Thanks,
>>> Mani
>>>
>>> [1] https://lore.kernel.org/all/20220901101756.28164-2-quic_rjendra@quicinc.com/
>>>
>>>>    };
>>>>    static struct gdsc gcc_ufs_phy_gdsc = {
>>>> -- 
>>>> 2.7.4
>>>>
