Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953D478C420
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 14:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjH2MUV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 08:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjH2MUK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 08:20:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFD4E6F;
        Tue, 29 Aug 2023 05:19:34 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T9pBHI002012;
        Tue, 29 Aug 2023 12:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cYoyZlgewTYduAprD6YluXYfDJU00ET8JDAPnWBrxzE=;
 b=bpWKQbwy0tN3Ejcy3d6KbEY/N03nD9mcaXhkFKKhcoY4sIxC+nIEYoFhZPVHtftEKHVt
 yusBhVoGlb9Lqh+pWSfghVLPX2XxLDafQ6oSnZ099Fu7HFmk86jc/UNYKcmN4t+ot+wq
 DEXGNJTmtUKbowvJPqXy/At1RNYTLsB0TUQPHB5DfRUTGq5G5XyHWDguHJEGLbJ8967j
 kzouB/YD5V/gI3fL7cGUSjeGaiRBEMKkTSjtf93uLRBHC+iJUHB5qJoTZnXwteqC9VJe
 8AZECRGh7jyveFiDKdCRJj8xrBMWAL/YPRq/Sh42x4c2wltFikEfbiC+Ck1OUvm0PMDR dQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss4wq1cna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 12:18:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TCIcLQ026384
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 12:18:38 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 05:18:34 -0700
Message-ID: <fc40910f-828b-8cf8-f49a-6b2af7166748@quicinc.com>
Date:   Tue, 29 Aug 2023 17:48:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v10 0/4] PCI: qcom: ep: Add basic interconnect support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_ramkri@quicinc.com>
References: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
 <20230728025648.GC4433@thinkpad>
 <b7f5d32f-6f1a-d584-4cdd-4c5faf08a72e@quicinc.com>
 <73700e92-2308-3fe0-51b1-c2373be2893e@linaro.org>
 <bed64143-8803-5027-d9ec-eafaaeb64e35@quicinc.com>
 <ecc6076b-2278-70e6-3863-3dcf89adfd0f@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <ecc6076b-2278-70e6-3863-3dcf89adfd0f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mnbxfRZRIx7SvvTT3W66QthcJYD_bnsG
X-Proofpoint-ORIG-GUID: mnbxfRZRIx7SvvTT3W66QthcJYD_bnsG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_08,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0 adultscore=0
 mlxlogscore=661 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290106
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/29/2023 5:44 PM, Krzysztof Kozlowski wrote:
> On 29/08/2023 14:13, Krishna Chaitanya Chundru wrote:
>> On 8/29/2023 5:26 PM, Krzysztof Kozlowski wrote:
>>> On 29/08/2023 13:41, Krishna Chaitanya Chundru wrote:
>>>> On 7/28/2023 8:26 AM, Manivannan Sadhasivam wrote:
>>>>> On Wed, Jul 19, 2023 at 12:50:14PM +0530, Krishna chaitanya chundru wrote:
>>>>>> Add basic support for managing "pcie-mem" interconnect path by setting
>>>>>> a low constraint before enabling clocks and updating it after the link
>>>>>> is up based on link speed and width the device got enumerated.
>>>>>>
>>>>> Krzysztof, can this series be merged for 6.6? Bjorn A will pick the dts patches.
>>>>>
>>>>> - Mani
>>>> A Gentle ping
>>>>
>>> Whom do you ping and why me? If you choose not to use
>>> scripts/get_maintainers.pl, it's your right, but then you might get
>>> maintainers wrong and no surprise patches got not accepted...
>>>
>>> Plus, it's merge window, so why pinging now?
>>>
>>> Best regards,
>>> Krzysztof
>> Krzyszto,
>>
>> The series is already reviewed and there are some patches which is
>> reviewed by you also.
>>
>> I am using the same command to send patches it looks like this script is
>> fetching based upon the source file where there was change due to that
>> only I was seeing the problem of all patches are not going to all the
>> maintainers.
>>
>> I was trying to install b4 and make sure to send all patches to all the
>> maintainers next time on wards.
>>
>> we pinged it now so that as this is already reviewed and no comments on
>> this series so that this can picked up.
> It is the fifth same email from you. With just few differences. Please
> stop. Please fix your email client.
>
> Best regards,
> Krzysztof

I got a mail saying message was not delivered saying there is some html 
code, I taught it didn't send and trying to send again few changes.

Please ignore other mails, sorry for the trouble.

- KC

