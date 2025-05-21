Return-Path: <linux-pci+bounces-28223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBE7ABF960
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 17:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21641BA48BC
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FD22153E7;
	Wed, 21 May 2025 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BPj1a56S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515EF2139C8;
	Wed, 21 May 2025 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841548; cv=none; b=CcIJTKwAe5L+kCNkZHpBnyaw9vcO0j3/ZlRIU8ig1nahkwMsrbCR9N24RiL9P2NhrL4Va4tIK4F4SDOJ8X+NS59O6d/erct4VPhMu8KbZlyYra5fcDqL0HV2FLryNshz8ZDE91Wn77sJwj9bwAiwG7fpj3aW1AD1ceGDbsrq448=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841548; c=relaxed/simple;
	bh=g2alB9EP+7/n8yI8/NZcOxnPHOBIM0vK+TbEcQARBt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e72nzrVR6aL3B4wuTFvYt13/OKsgePmzo/8tSKTsp+FGjTYHkeiGgskaFIVcLh+8910aLJUHVwIwaHasbvirWzOsm4Q6R7goGkP5rhlBYPdVm0GIF4DiDz9cIF368mjr+KhMEF/z06kCzweOmT386l/zgqfeLY6qEsqbH6N+boQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BPj1a56S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XJY0013424;
	Wed, 21 May 2025 15:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qzqnhQBFsflY3nmZG8TNLCp1PRo7RCDvGRrlihPo6kA=; b=BPj1a56Se3UzYLRx
	pQgo8D5VG/GtvrdgT08YXfknx06/+rH8Aj6xzkHaJbfbs2N+BLjXtmJ1uHMfGp+w
	XMSBr5e4bKmW+UFQFwv1Urpv1lmcqGTBnOcV1vzrPTAidIPlkuGWJcBsZt7NAvKM
	6Nw4mzmJmNvFXear0tpnHhW29T7rLEqrj+fddXj9MvvC4hNcsAFcgM1gd1zBxhHU
	XI+SkUg9xvDGmrC55vZJuIcUnxQEabStEl+QuUS1TWB92BXvtre7zQGQQOf31pTG
	4hIesmO3FlPAUeflfbqr+I+YmcmRm/YLsY7WLnYXBJG1YwH5TWCFitsLtl4p8soy
	JhUfPg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwh5bfsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 15:32:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54LFW6r7026909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 15:32:06 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 08:32:05 -0700
Message-ID: <2c0b4220-d92c-4dba-9364-33d713f26dbe@quicinc.com>
Date: Wed, 21 May 2025 09:32:04 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] bus: mhi: host: Add support to read MHI
 capabilities
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        "Bjorn
 Helgaas" <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mhi@lists.linux.dev>,
        <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <qiang.yu@oss.qualcomm.com>, <quic_vbadigan@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_mrana@quicinc.com>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
 <20250519-mhi_bw_up-v3-7-3acd4a17bbb5@oss.qualcomm.com>
 <aa45ff83-bc8f-4cef-a82c-9a868396d19d@quicinc.com>
 <8bb9acff-b2cf-edb0-bd55-251cf4a93f5b@oss.qualcomm.com>
Content-Language: en-US
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <8bb9acff-b2cf-edb0-bd55-251cf4a93f5b@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE1MSBTYWx0ZWRfXxnaJb7V1VaIh
 DEkdqiEY9/kGm2Eg4dD3TRPistrrO10PK8DA+eodCpj/WUuQoqzge0Pw6DNzvBiYjzmoPBJ4itd
 yuWpfmX6RjRobZiUqJvMdnJMqGrCp/Y8kknzMAZ+3ykw+5Fp/1AY3cudPYH+B0Cowf80dSgGrqq
 8eYoYKs9ov7H/tf+pDLxOHxEnTDssU8Jm0Iu5e2Rtb+7n/LoVsIEJ6qIhiwDeZrqHpQY9iyc/Yv
 I/GXfGepp5u1Eicz11jhO3Y2QeAKB7moc3+PVJl6OyPyhbZh2f2d6dTMCkcrx+Ohk4z6a/+qOHH
 6da4AHdjO99ei2hYMVunmYpbtDpPUqHLDQ2XELVZPiLRd+eDWGKVA122MakxwLgFy/X1wMiNTTg
 5oA6ZCcSET2EwRjCVyQsPwOJ71zg98jO0O0PLZDmqmtK443G2Ay7pMMnMOxdgq4luM6S3dYJ
X-Authority-Analysis: v=2.4 cv=XeWJzJ55 c=1 sm=1 tr=0 ts=682df1f7 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=Af02sFNo4fdZPFbs5mEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qqsNyME4ffCDkvLPzdtCBRAJtOscHoSf
X-Proofpoint-ORIG-GUID: qqsNyME4ffCDkvLPzdtCBRAJtOscHoSf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210151

On 5/21/2025 9:06 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 5/21/2025 8:22 PM, Jeffrey Hugo wrote:
>> On 5/19/2025 3:42 AM, Krishna Chaitanya Chundru wrote:
>>> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
>>>
>>> As per MHI spec v1.2,sec 6.6, MHI has capability registers which are
>>> located after the ERDB array. The location of this group of registers is
>>> indicated by the MISCOFF register. Each capability has a capability 
>>> ID to
>>> determine which functionality is supported and each capability will 
>>> point
>>> to the next capability supported.
>>>
>>> Add a basic function to read those capabilities offsets.
>>>
>>> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
>>> Signed-off-by: Krishna Chaitanya Chundru 
>>> <krishna.chundru@oss.qualcomm.com>
>>> ---
>>>   drivers/bus/mhi/common.h    |  4 ++++
>>>   drivers/bus/mhi/host/init.c | 29 +++++++++++++++++++++++++++++
>>>   2 files changed, 33 insertions(+)
>>>
>>> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
>>> index 
>>> dda340aaed95a5573a2ec776ca712e11a1ed0b52..eedac801b80021e44f7c65d33cd50760e06c02f2 100644
>>> --- a/drivers/bus/mhi/common.h
>>> +++ b/drivers/bus/mhi/common.h
>>> @@ -16,6 +16,7 @@
>>>   #define MHICFG                0x10
>>>   #define CHDBOFF                0x18
>>>   #define ERDBOFF                0x20
>>> +#define MISCOFF                0x24
>>>   #define BHIOFF                0x28
>>>   #define BHIEOFF                0x2c
>>>   #define DEBUGOFF            0x30
>>> @@ -113,6 +114,9 @@
>>>   #define MHISTATUS_MHISTATE_MASK        GENMASK(15, 8)
>>>   #define MHISTATUS_SYSERR_MASK        BIT(2)
>>>   #define MHISTATUS_READY_MASK        BIT(0)
>>> +#define MISC_CAP_MASK            GENMASK(31, 0)
>>> +#define CAP_CAPID_MASK            GENMASK(31, 24)
>>> +#define CAP_NEXT_CAP_MASK        GENMASK(23, 12)
>>>   /* Command Ring Element macros */
>>>   /* No operation command */
>>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>>> index 
>>> 13e7a55f54ff45b83b3f18b97e2cdd83d4836fe3..a7137a040bdce1c58c98fe9c2340aae4cc4387d1 100644
>>> --- a/drivers/bus/mhi/host/init.c
>>> +++ b/drivers/bus/mhi/host/init.c
>>> @@ -467,6 +467,35 @@ int mhi_init_dev_ctxt(struct mhi_controller 
>>> *mhi_cntrl)
>>>       return ret;
>>>   }
>>> +static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 
>>> capability, u32 *offset)
>>> +{
>>> +    u32 val, cur_cap, next_offset;
>>> +    int ret;
>>> +
>>> +    /* Get the 1st supported capability offset */
>>
>> "first"?  Does not seem like you are short on space here.
>>
> Misc register will have the offest of the 1st capability register
> from there capabilities will have linked list format.

No, I'm saying don't have "1st" in the comment, but have "first" 
instead. I think that will read better.

"Get the first supported capability offset"

>>> +    ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF,
>>> +                 MISC_CAP_MASK, offset);
>>
>> This fits on one line.
>>
>>> +    if (ret)
>>> +        return ret;
>>
>> Blank line here would be nice.
>>
>>> +    do {
>>> +        if (*offset >= mhi_cntrl->reg_len)
>>> +            return -ENXIO;
>>> +
>>> +        ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, *offset, &val);
>>> +        if (ret)
>>> +            return ret;
>>
>>
>> There is no sanity checking we can do on val?  We've had plenty of 
>> issues blindly trusting the device.  I would like to avoid having more.
>>
> we can check if val is not all F's as sanity other than that we can't
> check any other things as we don't know if the value is valid or not.
> Let me know if you have any taught on this.

mhi_read_reg() should handle the PCIe link error case. You can check to 
see that the value is within the MHI space before using it.

Also, shouldn't the value be transformed from le32 to cpu and back?

>> Also looks like if we find the capability we are looking for, we 
>> return the offset without validating it.
>>
> For offset I can have a check to make sure the offset is not crossing
> mhi reg len like above.
> 
> - Krishna Chaitanya.
>>> +
>>> +        cur_cap = FIELD_GET(CAP_CAPID_MASK, val);
>>> +        next_offset = FIELD_GET(CAP_NEXT_CAP_MASK, val);
>>> +        if (cur_cap == capability)
>>> +            return 0;
>>> +
>>> +        *offset = next_offset;
>>> +    } while (next_offset);
>>> +
>>> +    return -ENXIO;
>>> +}
>>> +
>>>   int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>>>   {
>>>       u32 val;
>>>
>>


