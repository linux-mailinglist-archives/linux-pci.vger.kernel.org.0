Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D324D78C40F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 14:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjH2MRl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 08:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjH2MRN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 08:17:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DEE1AA;
        Tue, 29 Aug 2023 05:16:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TAm2I5021381;
        Tue, 29 Aug 2023 12:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=llxaos4mQo6Fgz94bvhY8Vrz3R1XenyuxOe4AfKIMVk=;
 b=dBEEnNJIcckxKJpXFqz9OHFJL1Vn6vpiO7aIP0zO/8v3G+kzDrja+WxGu3wUlCZ5qOMp
 0UavakbMcLpTAEexdPR6v1RIroYzVvWXGy//BqLs/XkhPMCnx84gVmC8Y1MAXdbHYkMf
 6zyo/6E10zMvHUQqPB3KmcDakuV802SvosZYgt0ciAELv/wgsOPaVYvxqGoA5/tP7LGo
 4Y8o2b0HYGta+b3MeLwzua+Ob3zXw61xrwHm1MjlrTMMtkkLwPsMQlY2qqircpfJVxjy
 Djg1Iy9lHy/Fd18xb988UQLJGcv4GGu6qaSKDmYTMz3xmQLEqM8W7U0k2sGadJnfN1Ss hQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss0521wk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 12:16:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TCGoaw022305
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 12:16:50 GMT
Received: from [10.217.219.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 05:16:46 -0700
Message-ID: <425807b5-2194-f682-4841-bfcfe414d289@quicinc.com>
Date:   Tue, 29 Aug 2023 17:46:43 +0530
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
 <a0fc7f8b-dfb1-f5f8-40f2-43a4f13944ae@quicinc.com>
 <fb2abd03-7393-0d41-8b8e-8fe8dade0923@linaro.org>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <fb2abd03-7393-0d41-8b8e-8fe8dade0923@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: CaxgwdPeufIP1pO3FayMwTLhSSC1OrGg
X-Proofpoint-GUID: CaxgwdPeufIP1pO3FayMwTLhSSC1OrGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_09,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=297 mlxscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290106
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/29/2023 5:42 PM, Krzysztof Kozlowski wrote:
> On 29/08/2023 14:10, Krishna Chaitanya Chundru wrote:
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
>> I am using this command to send patches it looks like this script is
>> fetching based upon the source file where there was change due to that
>> only I was seeing the problem of all patches are not going to all the
>> maintainers.
>>
>>    --cc-cmd=scripts/get_maintainer.pl ./patch-series
>>
>> I was trying to install b4 and make sure to send all patches to all the
>> maintainers next time on wards.
> This looks good.
>
>> we pinged it now so that as this is already reviewed and no comments on
>> this series so that this can picked up.
> And what is has anything to do with me? You got everything needed from
> me, don't you?
>
> Anyway, do not ping during merge window.
>
>
> Best regards,
> Krzysztof

I meant to ping all maintainers I should pinged as new reply to cover 
message instead of replying back to mani's comment.

sure Krzysztof we will make sure we don't ping in merge window.

- KC


I

>
