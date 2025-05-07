Return-Path: <linux-pci+bounces-27369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CEAADD04
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 13:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12F0B188FA71
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 11:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804C1215F49;
	Wed,  7 May 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KutWJ/g1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA01215F58;
	Wed,  7 May 2025 11:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616279; cv=none; b=d/ZUi4DWCm1BEmlIRhuzRcNtiEBeYgg3fqFMYe/+/UTWOlz7V9eqrVzcyAgz2ssQCwrP469Qa16mtEGnqjZ6eQa+AwkfLp10iXP3NTXcEh8lY4npHhrabIwT32epbflk1i1pGjaH7O5IrQn/yodf97AD6a7+xOMw1wIWf6n0RGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616279; c=relaxed/simple;
	bh=ZntyQpw2zi5iOaOV9k2HOzNU8KHguQzDjhm53vtJw5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P26zHFgK05nn/dCr3A02YWv4LMadZQrvNDOUFsBv8z3H8+gjukaxH+wdqiIqVH0h3OH8qAOR0hSbrXQtIRyk1vClX9EvSDeDUCIa9JQkNG6t5KFNAnnVQCAT8E/b4YIGZTw2AZ03mnU7diGMLUko+NPsdgTa2cpzkRvedgGyT2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KutWJ/g1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547A8WUS009115;
	Wed, 7 May 2025 11:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uA25O6r9wDpkNxGF6Ry+LoJMfYqYXfcqAr/9W7fDnIw=; b=KutWJ/g1BpPBlKHq
	KSbVyDM0pWsutBvxtipM9QV63jddzbuSK0SChD0LtY2Q+9qyR/RHuGknIoG/K9lF
	n0zM2b9MKEqFiE9ySEXmPpvSGuC7Xfl/kWelt2Id7emxd2wzKT03aCpgUsTbSCew
	PYkC7cYgjLVxR1FBCj8m6Ii7hECf0Fi8VZ/O1zGDKifgXfC86S8zN2EF3qEtM1/0
	JAEGEmV5S0iSN9YHWQF1I4sxGjyMpiJcEElYN3QnI6tTZ7BfEFgZwakWY42YOuQH
	dTHLqrzMasmDqzWDLh3orvqbGhi05dl756vgeZsDWBfiSC24AvT+qeoHi6/INBzT
	MsNBVQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46g5gh85cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 11:10:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 547BAsIu003195
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 May 2025 11:10:54 GMT
Received: from [10.216.37.183] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 7 May 2025
 04:10:48 -0700
Message-ID: <1a83e239-7cd7-4230-7117-54c9d97f1ed3@quicinc.com>
Date: Wed, 7 May 2025 16:40:45 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] PCI: dwc: Chain the set IRQ affinity request back to the
 parent
Content-Language: en-US
To: Tsai Sung-Fu <danielsftsai@google.com>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Andrew Chant <achant@google.com>,
        Brian Norris
	<briannorris@google.com>,
        Sajid Dalvi <sdalvi@google.com>, Mark Cheng
	<markcheng@google.com>,
        Ben Cheng <bccheng@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
References: <20250303070501.2740392-1-danielsftsai@google.com>
 <87a5a2cwer.ffs@tglx>
 <CAK7fddD4Y5CJ3hKQvppGB2Bof4ibYDX4mBK3N1y8qt-NVoBb7w@mail.gmail.com>
 <87eczd6scg.ffs@tglx>
 <CAK7fddAqDPw1CuvBDUsQApbs1ZSE_ruyTAdsp+c4116C0ZjvVw@mail.gmail.com>
 <878qpi61sk.ffs@tglx>
 <CAK7fddCG6-Q0s-jh5GE7LG+Kf6nON8u9BS4Ame9Xa7VF1=ujiw@mail.gmail.com>
 <878qpg4o4t.ffs@tglx>
 <CAK7fddBSJk61h2t73Ly9gxNX22cGAF46kAP+A2T5BU8VKENceQ@mail.gmail.com>
 <874izz1x42.ffs@tglx>
 <CAK7fddBidt90Yjh=fjj=w8uovjEyes6Qe1U0m7k5XWGYZm+GHA@mail.gmail.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CAK7fddBidt90Yjh=fjj=w8uovjEyes6Qe1U0m7k5XWGYZm+GHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 76dWRpRUk8RBuH2Ouo3XaVN9F_2LJn9D
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=681b3fbf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=AMFphiw-AAAA:8
 a=wQ3t4f8JpbTjhMOd9qAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2bb41rcl4DbygUh6CoKr:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEwNCBTYWx0ZWRfX96SS2ppmYpc4
 rIiDV1wvb4eWN26/6GbfAgsuEShLxXAixEgMuPb7vIS6Qu10+RCcpn0+DqgeF4PNqvBPUdc4D9/
 ZnjT6TUlnxV86sT2FXTH7aOK7kfxtJ8aTCcFpdSsa6uc2JMYue+UZ4N9y8ZvpdEGqiqLZPKkYiM
 We1BJgDOU9iIvShTLENpIwDTkLtPN3CZ3ORcDucOy9XeL1BGMj64JuN+qt3UQK95DKhejdhBb40
 EetCzJ4p4cpkwgIuhEeS5iSvcnWxwUD8hBRFe/0jUQOZiCbvIZm9YGRxjeiC8C01k1WqHyqD/aH
 TByaV34utTNP/lCKEECgDSqfm5sVlngLgeGrjuWO6t1MbTX6mgdTiLINhv6igQ2jn84DnRvZhqq
 Awk7BOSNCNBG7DeE8F+JKKTrWgEhhWFr62udUs0zh60txZxGGH66CjkP04cUNJkuYViGRpkj
X-Proofpoint-ORIG-GUID: 76dWRpRUk8RBuH2Ouo3XaVN9F_2LJn9D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505070104



On 3/25/2025 12:08 PM, Tsai Sung-Fu wrote:
> On Tue, Mar 11, 2025 at 10:05 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> On Tue, Mar 11 2025 at 17:52, Tsai Sung-Fu wrote:
>>
>> Please do not top-post and trim your replies.
>>
>>> Running some basic tests with this patch (
>>> https://tglx.de/~tglx/patches.tar ) applied on my device, at first
>>> glance, the affinity feature is working.
>>>
>>> I didn't run stress test to test the stability, and the Kernel version
>>> we used is a bit old, so I only applied change in this 2 patches
>>
>> I don't care about old kernels and what you can apply or not. Kernel
>> development happens against upstream and not against randomly chosen
>> private kernel versions.
>>
>>> And adding if check on irq_chip_redirect_set_affinity() and
>>> irq_set_redirect_target() to avoid cpumask_first() return nr_cpu_ids
>>
>> I assume you know how diff works.
>>
>>> May I ask, would this patch be officially added to the 6.14 kernel ?
>>
>> You may ask. But you should know the answer already, no?
>>
>> The merge window for 6.14 closed on February 2nd with the release of
>> 6.14-rc1. Anything which goes into Linus tree between rc1 and the final
>> release is fixes only.
>>
>> This is new infrastructure, which has neither been posted nor reviewed
>> nor properly tested. There are also no numbers about the overhead and
>> no analysis whether that overhead causes regressions on existing setups.
>>
>> These changes want to be:
>>
>>     1) Put into a series with proper change logs
>>
>>     2) Posted on the relevant mailing list
>>
>>     3) Tested and proper numbers provided
>>
>> So they are not even close to be ready for the 6.15 merge window, simply
>> because the irq tree is going to freeze at 6.14-rc7, i.e. by the end of
>> this week.
>>
>> I'm not planning to work on them. Feel free to take the PoC patches,
>> polish them up and post them according to the documented process.
>>
> I really appreciate the patches from you, I am quite new to the
> upstream and IRQ framework. So would you help to share
> some experiences on how this kind of new infrastructure of IRQ
> framework should be tested if you don't mind ?
QCOM is also interested in this feature, if you need any help
we can support it. Please let us know the status of this
patch to take it forward.

- Krishna Chaitanya.
>> Thanks,
>>
>>          tglx
> 
> Thanks
> 

