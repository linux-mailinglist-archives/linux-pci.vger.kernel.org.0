Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4EB59F21C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Aug 2022 05:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbiHXDl1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 23:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiHXDl1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 23:41:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFF88306A;
        Tue, 23 Aug 2022 20:41:26 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27O3S0EL021474;
        Wed, 24 Aug 2022 03:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MVllEistK37PAbAJhqSO0eSSw4RhFoMq71ZebOQjmUU=;
 b=K0iQk78hXp5F0WQhE3FvIZ8JkvFRXfcoICdiCvGUyZifVJvRKfr8QId6UNxM/sm3kLui
 2wcX6GVPdvFr75jcH0+t4Y7uYMcHcQfMEBjvM0zfIJfVkCyT77m3iwDgvmy6OAstlfmE
 JqYAwSFbxyEU4NsKtA6vy3gFOeMEKCDqINmwted6DXL708Jd8+lqa/Jy0ZuFzi2Zyr9d
 E+aa9gODSBkDICxfnIU+0u57uOahaSO8Eg8094o3YmiQyxYflGBCVbHfA8LhBPFt8K2B
 CjPpbEtptJVfNvzDzzwRxxeUNZ3tdg19r2smrFwVaDGKep00JIGywyRY0Z5V0l2XkFi3 sQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j52pqht5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 03:41:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27O3fG4g013599
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 03:41:16 GMT
Received: from [10.216.7.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 23 Aug
 2022 20:41:08 -0700
Message-ID: <300cf1ee-3fee-edf9-555a-11440c589ddb@quicinc.com>
Date:   Wed, 24 Aug 2022 09:11:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 3/3] PCI: qcom: Add retry logic for link to be stable
 in L1ss
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_hemantk@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <manivannan.sadhasivam@linaro.org>,
        <swboyd@chromium.org>, <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Stanimir Varbanov" <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <1659526134-22978-1-git-send-email-quic_krichai@quicinc.com>
 <1659526134-22978-4-git-send-email-quic_krichai@quicinc.com>
 <Yuw7HyoFX4jk6eOE@google.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <Yuw7HyoFX4jk6eOE@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ra-me2rNMBSMb2A55Byu7nRwwpxgtZ-1
X-Proofpoint-GUID: ra-me2rNMBSMb2A55Byu7nRwwpxgtZ-1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_02,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240014
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/5/2022 3:03 AM, Matthias Kaehlcke wrote:
> On Wed, Aug 03, 2022 at 04:58:54PM +0530, Krishna chaitanya chundru wrote:
>> Some specific devices are taking time to settle the link in L1ss.
>> So added a retry logic before returning from the suspend op.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index f7dd5dc..f3201bd 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -1829,15 +1829,30 @@ static int __maybe_unused qcom_pcie_pm_suspend(struct device *dev)
>>   {
>>   	struct qcom_pcie *pcie = dev_get_drvdata(dev);
>>   	u32 val;
>> +	ktime_t timeout, start;
>>   
>>   	if (!pcie->cfg->supports_system_suspend)
>>   		return 0;
>>   
>> -	/* if the link is not in l1ss don't turn off clocks */
>> -	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
>> -	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
>> -		dev_warn(dev, "Link is not in L1ss\n");
>> -		return 0;
>> +	start = ktime_get();
>> +	/* Wait max 100 ms */
>> +	timeout = ktime_add_ms(start, 100);
> In my tests 100 ms is ample margin for most NVMe models (it's often 0 and
> generally < 10), however with one model I saw delays of up to 150 ms, so
> this should probably be 200 ms or so (it's a long time, but most of the
> time the actual delay is significantly lower
ok I will increase the time to 200.
>
>> +	while (1) {
>> +		bool timedout = ktime_after(ktime_get(), timeout);
> 'timedout' looks very similar to the other local variable 'timeout'
> in this function. Actually why not just do without the new variable and
> put this after reading the register.
>
>     		if (ktime_after(ktime_get(), timeout)) {
> 			dev_warn(dev, "Link is not in L1ss\n");
>   			return 0;
> 		}
ok sure will update in the next patch.
>> +
>> +		/* if the link is not in l1ss don't turn off clocks */
>> +		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
>> +		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
>> +			dev_info(dev, "Link enters L1ss after %d ms\n",
>> +					ktime_to_ms(ktime_get() - start));
>
> Probably this should be dev_dbg() to avoid cluttering the kernel log that
> isn't relevant most of the time.
ok sure will update in next patch.
>
>> +			break;
>> +		}
>> +
>> +		if (timedout) {
>> +			dev_warn(dev, "Link is not in L1ss\n");
>> +			return 0;
>> +		}
>> +		usleep_range(1000, 1200);
> You could use fsleep() instead of specifying a range.
>
> Based on my testing I think a slightly higher delay like 5ms wouldn't hurt.
> That would result in less 'busy looping' for slower NVMes and would still
> be reasonable fast for those that need 10 ms or so.
>
> Actually you could replace the entire loop with something like this:
>
> 	if (readl_poll_timeout(pcie->parf + PCIE20_PARF_PM_STTS, val,
> 	    val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB, 5000, 200000) {
> 	    dev_warn(dev, "Link is not in L1ss\n");
> 	    return 0;
> 	}

Ok we will look in to this option and will update the patch if needed.

