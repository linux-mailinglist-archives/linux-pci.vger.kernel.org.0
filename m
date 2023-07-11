Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE54674E704
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 08:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjGKGQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 02:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGKGP7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 02:15:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BBFE5;
        Mon, 10 Jul 2023 23:15:58 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B6Fcuu019060;
        Tue, 11 Jul 2023 06:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dM7/ZnZfOBpFxzcTE0r5c6y7E8JjAk//H9NvG5BBSZA=;
 b=WfE+OZq8r7UUeByWjlxHd8Mg8hzhbqCPT5vhpVN8M2+vjiCzwg64Xs0diQ2bq+MfZJSn
 vgJm1C9E7BwtO3bCXn3ZLF1Gbq7jbR+/V5sASSYPOcBPe7f/ADymj1rbM1btw+dyHJmB
 kc3JXfqX+wLROhrJ7SiaoPWmF39AnqEg+bWlfedJrgxmJkRvHrZh2z4Vs9fHsGyi5lIN
 Cm/G/LMshMtn5KcNA7nOtBf6zjsMJaYSE2icWLOkYMqyBBDFgCU0lU96wc/eSjfOOdNg
 zwbleb0+slJ9aSp7YfJTU6fbVI9SOm9PLsY0wnL9CkG54aNkDoHo119SK+5wd3o2Di8s UA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rs0kpg3h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 06:15:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36B6FZAd007429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 06:15:35 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 10 Jul
 2023 23:15:30 -0700
Message-ID: <e125c79b-3aea-da04-ab54-e532d4e54bfe@quicinc.com>
Date:   Tue, 11 Jul 2023 11:45:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 9/9] bus: mhi: ep: wake up host is the MHI state is in
 M3
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
CC:     <manivannan.sadhasivam@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Bo Liu <liubo03@inspur.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        "open list:MHI BUS" <mhi@lists.linux.dev>
References: <20230707151209.GA139708@bhelgaas>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230707151209.GA139708@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xWVVvg5VB4J3HzVVqqRw1ImNyGtgHVI4
X-Proofpoint-ORIG-GUID: xWVVvg5VB4J3HzVVqqRw1ImNyGtgHVI4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307110054
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 7/7/2023 8:42 PM, Bjorn Helgaas wrote:
> On Fri, Jul 07, 2023 at 02:41:57PM +0300, Dan Carpenter wrote:
>> On Fri, Jul 07, 2023 at 04:33:56PM +0530, Krishna chaitanya chundru wrote:
>>> If the MHI state is in M3 then the most probably the host kept the
>>> device in D3 hot or D3 cold, due to that endpoint transctions will not
>>> be read by the host, so endpoint wakes up host to bring the host to D0
>>> which eventually bring back the MHI state to M0.
>>>
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>>> ---
>>>   drivers/bus/mhi/ep/main.c | 28 ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
>>> index 6008818..46a8a3c 100644
>>> --- a/drivers/bus/mhi/ep/main.c
>>> +++ b/drivers/bus/mhi/ep/main.c
>>> @@ -25,6 +25,27 @@ static DEFINE_IDA(mhi_ep_cntrl_ida);
>>>   static int mhi_ep_create_device(struct mhi_ep_cntrl *mhi_cntrl, u32 ch_id);
>>>   static int mhi_ep_destroy_device(struct device *dev, void *data);
>>>   
>>> +static bool mhi_ep_wake_host(struct mhi_ep_cntrl *mhi_cntrl)
>>> +{
>>> +	enum mhi_state state;
>>> +	bool mhi_reset;
>>> +	u32 count = 0;
>>> +
>>> +	mhi_cntrl->wakeup_host(mhi_cntrl);
>>> +
>>> +	/* Wait for Host to set the M0 state */
>>> +	do {
>>> +		msleep(M0_WAIT_DELAY_MS);
>>> +		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
>>> +		count++;
>>> +	} while (state != MHI_STATE_M0 && count < M0_WAIT_COUNT);
>>> +
>>> +	if (state != MHI_STATE_M0)
>>> +		return false;
>> Functions which return false on success are an abomination.  Also
>> boolean functions should be named for the question they answer such
>> as access_ok() or has_feature() etc.
> +1.  Also nice if boolean functions do not have side effects, so in
> this case, where mhi_ep_wake_host() *does* something that might fail,
> I think "return 0 for success or negative error value" is easier to
> read.

sure Dan and Bjorn I will replace bool with int return type as suggested 
in the next patch series.

- KC

>> Write it like this:
>>
>> static int mhi_ep_wake_host(struct mhi_ep_cntrl *mhi_cntrl)
>> {
>> 	enum mhi_state state;
>> 	bool mhi_reset;
>> 	int count = 0;
>>
>> 	mhi_cntrl->wakeup_host(mhi_cntrl);
>>
>> 	while (count++ < M0_WAIT_COUNT) {
>> 		msleep(M0_WAIT_DELAY_MS);
>>
>> 		mhi_ep_mmio_get_mhi_state(mhi_cntrl, &state, &mhi_reset);
>> 		if (state == MHI_STATE_M0)
>> 			return 0;
>> 	}
>> 	return -ENODEV;
>> }
