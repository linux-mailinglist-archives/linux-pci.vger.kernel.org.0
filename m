Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F0B5B6817
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 08:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiIMGnF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 02:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiIMGnC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 02:43:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993FC58DCA;
        Mon, 12 Sep 2022 23:43:01 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D2hVHK008767;
        Tue, 13 Sep 2022 06:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eXOZDRzg2RsNnXeweM+Pjekl64CFMxDYXgxSIun5DwQ=;
 b=hJj+fqt/ICGitNsAQGYBR/x/coip63yTOGtVSKGz2cdh2m6ktszkuFHc2b4ofQ6APSdd
 3MpO3HoYnRIckEyA7c59qm0kyT0bnKucJEU8vc35xamupzxZ5LdtmYn3CuT8Dc2T2SF8
 GPg77k9go81QT0IrBjk6aMt3gPbFQd078bGWXIjCAMicJ1ox6mJ6OhzvqCKtUu2CMHCj
 MEtKPrGSAzoO+OVUojJlh3T0HPdXXbp/BWAQp1R4GgeZj/Re/7dsU1M44G2YZnqnjk/k
 Q0f/esVeyoPlaUmqoam7ODlq0FHIbTqQ5T4k4GaT+ukJYGVrhgBgtp25NEEgt37qkM0M LA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjh9tgj7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 06:42:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D6gn7H009087
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 06:42:49 GMT
Received: from [10.216.15.227] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 23:42:43 -0700
Message-ID: <49536ca8-ef98-9927-d1be-977ab5244c91@quicinc.com>
Date:   Tue, 13 Sep 2022 12:12:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v6 5/5] clk: qcom: Alwaya on pcie gdsc
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Krishna chaitanya chundru" <quic_krichai@quicinc.com>
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
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
In-Reply-To: <20220912170437.GA36223@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P7jDaIjVJ2jzB4fEydZBASyNAW6KdZ2q
X-Proofpoint-GUID: P7jDaIjVJ2jzB4fEydZBASyNAW6KdZ2q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_02,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=878 spamscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130029
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/12/2022 10:34 PM, Manivannan Sadhasivam wrote:
> + Rajendra
> 
> On Fri, Sep 09, 2022 at 02:14:44PM +0530, Krishna chaitanya chundru wrote:
>> Make GDSC always on to ensure controller and its dependent clocks
>> won't go down during system suspend.
>>
> 
> You need to mention the SoC name in subject, otherwise one cannot know for
> which platform this patch applies to.
> 
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/clk/qcom/gcc-sc7280.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
>> index 7ff64d4..2f781a2 100644
>> --- a/drivers/clk/qcom/gcc-sc7280.c
>> +++ b/drivers/clk/qcom/gcc-sc7280.c
>> @@ -3109,7 +3109,7 @@ static struct gdsc gcc_pcie_1_gdsc = {
>>   		.name = "gcc_pcie_1_gdsc",
>>   	},
>>   	.pwrsts = PWRSTS_OFF_ON,
>> -	.flags = VOTABLE,
>> +	.flags = ALWAYS_ON,
> 
> Rajendra, should we also put PCIe GDSC into retention state as you have done for
> USB [1]?

Yes, it looks like we should handle this the same way as we did with usb.
Why are we removing the VOTABLE flag anyway?

> 
> Thanks,
> Mani
> 
> [1] https://lore.kernel.org/all/20220901101756.28164-2-quic_rjendra@quicinc.com/
> 
>>   };
>>   
>>   static struct gdsc gcc_ufs_phy_gdsc = {
>> -- 
>> 2.7.4
>>
> 
