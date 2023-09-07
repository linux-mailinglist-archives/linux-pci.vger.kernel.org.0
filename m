Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C025797AE9
	for <lists+linux-pci@lfdr.de>; Thu,  7 Sep 2023 19:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245112AbjIGR52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Sep 2023 13:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjIGR51 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Sep 2023 13:57:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4665170C;
        Thu,  7 Sep 2023 10:56:55 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3875ea8L030697;
        Thu, 7 Sep 2023 06:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mZTbIBpUd9iXC5m5eQrkVF6qpnr7KXC2jM0o5fpM0RQ=;
 b=Cfabf4gAtq5ZJUNPjlaBrrXzZNiTjiQcl7L4KTYdFqB94KjiMgiI/Q3sN8Ge0MP7sMo6
 CPhQzTSa6J5KKyCoUOLQ7A6tFVogn4kbbd3MpG4rrXopIYuu2ugdvShTzWoJPm+OAmeS
 rKB6ZmM7Ji+Fu4BYFN4jInTXSbZxST+lRinA6L9nKuIe510Twg4kJCDrGw9WPeeJrlQe
 VBR+cKGNrF2IgcQolmwQC/5mfX0TllcHzlsR1bSVFODfyqBEEOSRoDyuEQZzYfbgO9//
 /9fMUpatrn3FeG2Dz1ImOmwMLddszYUI4ukbNalWhSA/1YIzuyARvHrqgwz3S/rGpM/z fw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sxgsqubjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 06:04:53 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38764pvE018083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 06:04:51 GMT
Received: from [10.216.2.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 6 Sep
 2023 23:04:45 -0700
Message-ID: <a43e5d7d-9254-03d4-3899-08dd23a6347a@quicinc.com>
Date:   Thu, 7 Sep 2023 11:34:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v4 3/4] OPP: Add api to retrieve opps which is at most the
 provided level
Content-Language: en-US
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
CC:     <manivannan.sadhasivam@linaro.org>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_parass@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        "Nishanth Menon" <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:OPERATING PERFORMANCE POINTS (OPP)" 
        <linux-pm@vger.kernel.org>
References: <1692717141-32743-1-git-send-email-quic_krichai@quicinc.com>
 <1692717141-32743-4-git-send-email-quic_krichai@quicinc.com>
 <20c40635-0ad9-4de3-b18b-ccbcc2fd3779@quicinc.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20c40635-0ad9-4de3-b18b-ccbcc2fd3779@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ylCDB2iUxcWj3nXhFWPZQuv-HIiSs6PT
X-Proofpoint-ORIG-GUID: ylCDB2iUxcWj3nXhFWPZQuv-HIiSs6PT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070052
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/23/2023 6:35 AM, Pavan Kondeti wrote:
> On Tue, Aug 22, 2023 at 08:42:20PM +0530, Krishna chaitanya chundru wrote:
>> Add dev_pm_opp_find_level_floor() for searching a lesser match or
>> operating on OPP in the order of decreasing level.
>>
> "OPP: Add api to retrieve opps which is at most the provided level". Pls
> change this to "opp: Add dev_pm_opp_find_level_floor()". The API name
> conveys the message.
>
> In the description, you can give a use case. i.e voting for the max
> level during initialization of a driver.
>
Done
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/opp/core.c     | 26 ++++++++++++++++++++++++++
>>   include/linux/pm_opp.h |  4 ++++
>>   2 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> index 954c948..e668cf2 100644
>> --- a/drivers/opp/core.c
>> +++ b/drivers/opp/core.c
>> @@ -727,6 +727,32 @@ struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
>>   }
>>   EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_ceil);
>>   
>> +
>> +/**
>> + * dev_pm_opp_find_level_floor() - Search for a rounded floor freq
>> + * @dev:	device for which we do this operation
>> + * @freq:	Start level
>> + *
> %s/freq/level
>
> Run make W=1 so that kerneldoc is tested.
Done
>> + * Search for the matching floor *available* OPP from a starting level
>> + * for a device.
>> + *
>> + * Return: matching *opp and refreshes *level accordingly, else returns
>> + * ERR_PTR in case of error and should be handled using IS_ERR. Error return
>> + * values can be:
> What do you mean by refresh here?

Level  argument will be updated by this API with the opp level being 
returned here,

I was trying to use same terminology used in other API's

>> + * EINVAL:	for bad pointer
>> + * ERANGE:	no match found for search
>> + * ENODEV:	if device not found in list of registered devices
>> + *
>> + * The callers are required to call dev_pm_opp_put() for the returned OPP after
>> + * use.
>> + */
>> +struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
>> +					      unsigned long *level)
>> +{
>> +	return _find_key_floor(dev, level, 0, true, _read_level, NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_opp_find_level_floor);
>> +
>>   /**
>>    * dev_pm_opp_find_bw_ceil() - Search for a rounded ceil bandwidth
>>    * @dev:	device for which we do this operation
>> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
>> index dc1fb58..a3bc386 100644
>> --- a/include/linux/pm_opp.h
>> +++ b/include/linux/pm_opp.h
>> @@ -128,6 +128,8 @@ struct dev_pm_opp *dev_pm_opp_find_level_exact(struct device *dev,
>>   					       unsigned int level);
>>   struct dev_pm_opp *dev_pm_opp_find_level_ceil(struct device *dev,
>>   					      unsigned int *level);
>> +struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
>> +					      unsigned long *level);
>>   
>>   struct dev_pm_opp *dev_pm_opp_find_freq_ceil(struct device *dev,
>>   					     unsigned long *freq);
>> @@ -285,6 +287,8 @@ static inline struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev,
>>   
>>   static inline struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
>>   					unsigned int *bw, int index)
>> +static inline struct dev_pm_opp *dev_pm_opp_find_level_floor(struct device *dev,
>> +					unsigned long *level)
>>   {
>>   	return ERR_PTR(-EOPNOTSUPP);
>>   }
>>
> Please run ./scripts/checkpatch.pl --strict <your patch> and fix the
> indentation warnings from this patch.
>
> Thanks,
> Pavan

Done

- KC

