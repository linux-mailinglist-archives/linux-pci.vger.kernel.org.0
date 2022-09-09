Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC055B32D7
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 11:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiIIJDe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 05:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiIIJDO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 05:03:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C744135D56;
        Fri,  9 Sep 2022 02:02:22 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2898XruF002505;
        Fri, 9 Sep 2022 09:01:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0aWLSRdOmBl5WamWS6Ow07Mc3A1ZnKDPqXSZxitN4Qw=;
 b=jebl0LoInpaAVL6Oml3XayIpxMiy2PG4xMIHEBvahH7AmtWzM4uJJgrnvD3G7f0Eut8Q
 3US+5VpurtcpAiS7EarQ4CKGTnKPZ/GxEBVwRPG5MEtXKl11edxDPCLslPKuqcuGi8hu
 cWQKX6wM9YeNUFSttdca3IwVGVEO2/WIEJ5VmBZmjMyYwWNcXif3AJtgyg6bLk70TRqZ
 KJaKevPtUh3nOE0LlCqdGRWEr5oqrR4v8+lkMAaBgh1RvU6TGFQMCkOPpY1Tg23NutBU
 M9LU3fliPvlk9cG+BHFsIA1sks36ELeVh5wxgm//o+tgS46q4T2UqwFcy7A69Jm0Tq4G tg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jfuww9vrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Sep 2022 09:01:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2898niVI002505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Sep 2022 08:49:44 GMT
Received: from [10.216.15.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 9 Sep 2022
 01:49:37 -0700
Message-ID: <2f72368a-39d9-152d-a563-f190774ebf7d@quicinc.com>
Date:   Fri, 9 Sep 2022 14:19:34 +0530
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
X-Proofpoint-GUID: HDqQ8EN0H9PT3vg4GVW7HjiKQDFWysIo
X-Proofpoint-ORIG-GUID: HDqQ8EN0H9PT3vg4GVW7HjiKQDFWysIo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_04,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209090031
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
>
>> +
>> +		/* if the link is not in l1ss don't turn off clocks */
>> +		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
>> +		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
>> +			dev_info(dev, "Link enters L1ss after %d ms\n",
>> +					ktime_to_ms(ktime_get() - start));
>
> Probably this should be dev_dbg() to avoid cluttering the kernel log that
> isn't relevant most of the time.
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

Hi Matthias,

In the v6 patch series we tried to include this logic, but as we are 
going with syscore ops

all the interrupts will be disabled by that time. and this timeout logic 
is enabling interrupts

and this causes the suspend to fail. So going with the previous logic.

Thanks & Regards,

Krishna chaitanya.

