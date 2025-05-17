Return-Path: <linux-pci+bounces-27905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7E6ABA7C9
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 04:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29334A01FA4
	for <lists+linux-pci@lfdr.de>; Sat, 17 May 2025 02:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CEF1494C3;
	Sat, 17 May 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WqNjSPGY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16B13D8A3
	for <linux-pci@vger.kernel.org>; Sat, 17 May 2025 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747448454; cv=none; b=U6lNiomOdG+QWvCyuP1YzGnDhLAR/BvoUhQt75EgWhWRVlLy8xOsOq6gDI3hUWudMBq+eb3/H75EKrwPq5SoGOWLAF4seFa8T5ZRtIO5oQcolNnoV0YBYtdgwoftvdOdqHKK09soVaRk936d0KOq/A+c+1lWuwakhKd+c0IT5U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747448454; c=relaxed/simple;
	bh=IW95dRVDzLxWDiP4V5IJuFJCvFkVuSSiAPkNdJbaBK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMdRLAFuqK/Hmxpgf7paPQIYGI9UIRclToo7gdulLH1KGyCyMeK4b1O4ZES/ZtgzR5G7RM0GzyOTWxE7grN0FDt2zJxHvFmZp7uOs/lQWCJ4kePTQTOZKMKEP8AVyNQbAznESUH2p8cFCGN59uEC1iagH2mn2/DvZfwnITM34uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WqNjSPGY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54H07NIa022998
	for <linux-pci@vger.kernel.org>; Sat, 17 May 2025 02:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BybEuDZH4NGRzyNjwmGtbUuQ3E9hmqYyOXM4Ex3cnbU=; b=WqNjSPGYKjbHBimW
	PyXKify/MPZGsDKXi0mcCU5rroX7MjOUNqe+e5+QAVS857mPF71MXYj0bJlt/s/2
	0lTsGqoMf36G/NHMWRbzT8fHLWoGJNJeJTFlnGcAPx0awQCjzw+f7bHW6E1H90wr
	gMOWx/SDf1xTgwYIvwq+NYiafzczZ51otCp5R1Y5tle4SJ4W1KXKjvBZElmZOifc
	fwZRRTi+k8/vrjadlyf/a9Urn7nnKnD7vQnRGUJKu46Y59k7urzagAXAS4SPc4hg
	HpLmfYSGsHE96hDHiyGqPILjXK9IXfORH1XE5uGjOR37M83XAhj8NmRqZAglSM25
	26t0ZQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46p4gq9wkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 17 May 2025 02:20:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-231c326fe2bso21188265ad.0
        for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 19:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747448450; x=1748053250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BybEuDZH4NGRzyNjwmGtbUuQ3E9hmqYyOXM4Ex3cnbU=;
        b=XK9aZ+NqNAxJsscW/nIxXbSisIap5xfcBWYxIsd3O2ZOkgqLJOTZ8CWdYU1rJC2dM0
         eblMto46+20B5d0Q4eOdfENgVPZJTUeZmc8u6esVs4Mk5WnlI0Yi7oDUIjjqRLKlG2kO
         4FLfs7jgkfG9+ZVEX76VaPSkg1Tq04oDMyXFRc8ZMjwuhfy9P2AckfgZGDLZSl8L207l
         zZJX0Q+P4X+6x5GMGvFHaDHaTvX5lk+HktSpi0E+/n2KwVdlBR/ftSnIXo4owYSPjhZU
         /UF15+NGXORc8C2buVn4fN2oRd7TDppYdmo0zN01IBNbLoaRKrnIopIYz8gelQBN5M0G
         vSSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX49cEaPKNiUk06xaP3+rYDs2JG7+ntONvKvmsdJsaM0DkpkpsmuUUD2N1SW8PQaGfyA1Jhtuvx0Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSrkkHKc3XyA2ISvPYp+vD3+zYbE7axnYuRkLGGGU7yfyH8qYQ
	Cykvn/odJ3gXRmB/Apua/CXBmkdOUy13+b3zlkb5ZjVVym3GpUJ6S0inT2tZvQg3kV1xgdzfzGT
	gsiejohPKsYgr2597lB7BGpsa2gC0dI0Q15BfCyetZefvIxyJgCIuJtOGyMpBO87D5z0LJrY=
X-Gm-Gg: ASbGncvAQ4/Q+W5OycZA7wsgZjb2qw67vcc/LfZwEPeaXV7I06shr+qvX27jhdBWQBC
	lTDLnbixv8HIG/rAYLwCPuLTONavkKYAySuZQ2yNzqMeZIxspNkD3v1gHL0r4QGOdWZ9IC5dTse
	kJsMxoOumMfxttOzABS78eZ9zySadffN44LN2erGTWtI/qfiwev/mVRpIdzB0SuhhWMSG3RYy7E
	nkKsF1nmCo2zMYr0nWbLDO/xXUo/WCeBvba44BunSGqKdo85W5pY8o+1y1Trbp+10KhmhHI8gI2
	1RVnj6utMURxdUZtWJJ4KwflqHPbjnkeExABiWXbBww=
X-Received: by 2002:a17:903:2284:b0:22e:663f:c4b with SMTP id d9443c01a7336-231de36bb60mr62454935ad.26.1747448449827;
        Fri, 16 May 2025 19:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkbEmesceMI5K5xKUt2aNYagIV4L8LmW/ecFTbpPRKFblTfrRwsWe6NNkQC+kxccVxuM6idA==
X-Received: by 2002:a17:903:2284:b0:22e:663f:c4b with SMTP id d9443c01a7336-231de36bb60mr62454725ad.26.1747448449331;
        Fri, 16 May 2025 19:20:49 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.230.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed23a8sm21089715ad.220.2025.05.16.19.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 19:20:48 -0700 (PDT)
Message-ID: <d5868e98-a037-eb2f-7310-80bfe6ec974e@oss.qualcomm.com>
Date: Sat, 17 May 2025 07:50:42 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 07/10] bus: mhi: host: Add support for Bandwidth scale
Content-Language: en-US
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
 <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
 <20250313-mhi_bw_up-v2-7-869ca32170bf@oss.qualcomm.com>
 <fzin4uttqtf33moiew6bazgxea7w72at5quumjg646s43wnq2g@3eupbyomplgw>
 <45deb1b9-748f-2342-1cf7-16b54ef6b95b@quicinc.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <45deb1b9-748f-2342-1cf7-16b54ef6b95b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Yzv5k4gePHTzpQcrULHa5l3aFBokqRGy
X-Authority-Analysis: v=2.4 cv=KulN2XWN c=1 sm=1 tr=0 ts=6827f283 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=m9Fid+qPLYWXQ4ltJ96dlQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=y7MCS0CkwjfyNYDPbrEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE3MDAyMCBTYWx0ZWRfX3SJPM91XBMyN
 EmTi1zs8uArCnw3ZEHbE5SmvpB6gdulyQL3UTNqi7LsuHZGDw5D6epC+QAny8i9bJTkEb0oEa+L
 tmyg1VValCdwB5nTTsCxoBNoaaKyHzAOXLMkiiWsb1V+av3vjFZSmPA3tRN1OU0Tyks1UdGV8DM
 qIr6Sa2m7SY34Y5WPEIwJkk/O9xi61/5gvaOQOC0Vni4TpgQ4Gj5eutg8ODKRWIn4C7Zo1bhxj4
 511AveenM+M0OHqaAEqi/m0xLgRR0VVaM6VsXXLuvaNKmbgrvws8i/EK6BaiiqF0XY399I4B2sn
 iKFdsJwL6z74nYrZ4xXSO1p4FM01uh4+LOBBIwbMI/kpV/TmelQeh7cNKjvZDRoZEw5El5DtdsQ
 fJdsy+DqAY61R0v81RvX8DZnA6PJi/3wTh5eZ1huCyoBMRnpvShXVRq3Gv90KhxCehjh33Od
X-Proofpoint-GUID: Yzv5k4gePHTzpQcrULHa5l3aFBokqRGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-17_01,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505170020



On 5/6/2025 9:59 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 4/25/2025 10:13 PM, Manivannan Sadhasivam wrote:
>> On Thu, Mar 13, 2025 at 05:10:14PM +0530, Krishna Chaitanya Chundru 
>> wrote:
>>> As per MHI spec sec 14, MHI supports bandwidth scaling to reduce power
>>
>> Same here, add spec version.
>>
>>> consumption. MHI bandwidth scaling is advertised in devices that contain
>>
>> 'advertised in devices or by devices'? Difference is subtle, but it 
>> changes the
>> context.
>>
> its by device, I will correct it next patch.
>>> the bandwidth scaling capability registers. If enabled, the device
>>> aggregates bandwidth requirements and sends them to the host in the form
>>> of an event. After the host performs the bandwidth switch, it sends an
>>> acknowledgment by ringing a doorbell.
>>>
>>> if the host supports bandwidth scaling events, then it must set
>>
>> So this means both host and device has to support bandwidth scaling 
>> events? What
> Yes both host and device has to support this.
>> does 'events' mean here?
> Device sends bw scale info through dedicated MHI event ring events.
>>
>>> BW_CFG.ENABLED bit, set BW_CFG.DB_CHAN_ID to the channel ID to the
>>> doorbell that will be used by the host to communicate the bandwidth
>>> scaling status and BW_CFG.ER_INDEX to the index for the event ring
>>> to which the device should send bandwidth scaling request in the
>>> bandwidth scaling capability register.
>>>
>>> As part of mmio init check if the bw scale capability is present or not,
>>> if present advertise host supports bw scale by setting all the required
>>> fields.
>>>
>>
>> Sounds like the host is depending on the device for bandwidth scaling.
>>
> yes
>>> MHI layer will only forward the bw scaling request to the controller
>>> driver, it is responsibility of the controller driver to do actual bw
>>> scaling and then pass status to the MHI. MHI will response back to the
>>> device based up on the status of the bw scale received.
>>>
>>
>> Why the controller driver needs to be involved for a spec defined 
>> feature?
>> This is not answered here.
>>
> The controller driver here is mhi controller driver, the MHI layer
> doesn't have any info about PCI related stuff, only controller driver
> knows about it. I will update the commit text accordingly.
>>> Add a new get_misc_doorbell() to get doorbell for misc capabilities to
>>> use the doorbell with mhi events like MHI BW scale etc.
>>>
>>
>> So this is a spare doorbell? Why can't you call it as 
>> 'get_bw_scaling_db()'?
>>
> Similar to MHI BW scale there are some other features which depends on
> getting spare doorbell like posted time synchronization MHI V1.2, 5.1.2
> To scale for future features I added like this.
>>> Use workqueue & mutex for the bw scale events as the 
>>> pci_set_target_speed()
>>> which will called by the mhi controller driver can sleep.
>>>
>>> Signed-off-by: Krishna Chaitanya Chundru 
>>> <krishna.chundru@oss.qualcomm.com>
>>> ---
>>>   drivers/bus/mhi/common.h        |  16 +++++++
>>>   drivers/bus/mhi/host/init.c     |  64 ++++++++++++++++++++++++-
>>>   drivers/bus/mhi/host/internal.h |   7 ++-
>>>   drivers/bus/mhi/host/main.c     | 101 
>>> +++++++++++++++++++++++++++++++++++++++-
>>>   drivers/bus/mhi/host/pm.c       |  10 +++-
>>>   include/linux/mhi.h             |  13 ++++++
>>>   6 files changed, 205 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
>>> index eedac801b800..0a02acee709a 100644
>>> --- a/drivers/bus/mhi/common.h
>>> +++ b/drivers/bus/mhi/common.h
>>> @@ -208,6 +208,22 @@
>>>   #define MHI_RSCTRE_DATA_DWORD1        
>>> cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
>>>                                      MHI_PKT_TYPE_COALESCING))
>>> +/* MHI Bandwidth scaling offsets */
>>> +#define MHI_BW_SCALE_CFG_OFFSET        0x4
>>> +#define MHI_BW_SCALE_CAP_ID        (3)
>>> +
>>> +#define MHI_BW_SCALE_ENABLE(bw_scale_db, er_index)    
>>> cpu_to_le32(FIELD_PREP(GENMASK(31, 25), \
>>> +                            bw_scale_db) |                \
>>> +                            FIELD_PREP(GENMASK(23, 19), er_index) 
>>> |    \
>>> +                            BIT(24))
>>> +
>>> +#define MHI_TRE_GET_EV_BW_REQ_SEQ(tre)    FIELD_GET(GENMASK(15, 8), 
>>> (MHI_TRE_GET_DWORD(tre, 0)))
>>> +#define MHI_BW_SCALE_DB_ID(er_index)    FIELD_PREP(GENMASK(31, 25), 
>>> er_index)
>>> +
>>> +#define MHI_BW_SCALE_RESULT(status, seq)    
>>> cpu_to_le32(FIELD_PREP(GENMASK(11, 8), status) | \
>>> +                        FIELD_PREP(GENMASK(7, 0), seq))
>>> +#define MHI_BW_SCALE_NACK            0xF
>>> +
>>>   enum mhi_pkt_type {
>>>       MHI_PKT_TYPE_INVALID = 0x0,
>>>       MHI_PKT_TYPE_NOOP_CMD = 0x1,
>>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>>> index 0b14b665ed15..71abe02f5726 100644
>>> --- a/drivers/bus/mhi/host/init.c
>>> +++ b/drivers/bus/mhi/host/init.c
>>> @@ -496,10 +496,56 @@ static int mhi_get_capability_offset(struct 
>>> mhi_controller *mhi_cntrl, u32 capab
>>>       return -ENXIO;
>>>   }
>>> +/* to be used only if a single event ring with the type is present */
>>
>> Then open code in the caller itself. I see no benefit in adding it as 
>> a separate
>> function.
>>
> This added as seperate function for upcoming features which uses
> same logic.
>>> +static int mhi_get_er_index(struct mhi_controller *mhi_cntrl,
>>> +                enum mhi_er_data_type type)
>>> +{
>>> +    struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
>>> +    int i;
>>> +
>>> +    /* find event ring for requested type */
>>> +    for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
>>> +        if (mhi_event->data_type == type)
>>> +            return mhi_event->er_index;
>>> +    }
>>> +
>>> +    return -ENOENT;
>>> +}
>>> +
>>> +static int mhi_init_bw_scale(struct mhi_controller *mhi_cntrl,
>>> +                 int bw_scale_db)
>>> +{
>>> +    struct device *dev = &mhi_cntrl->mhi_dev->dev;
>>> +    u32 bw_cfg_offset, val = 0;
>>> +    int ret, er_index;
>>> +
>>> +    ret = mhi_get_capability_offset(mhi_cntrl, MHI_BW_SCALE_CAP_ID,
>>> +                    &bw_cfg_offset);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    /* No ER configured to support BW scale */
>>
>> What does it mean?
>>
> I will remove the comment this is not making any sense.
>>> +    er_index = mhi_get_er_index(mhi_cntrl, MHI_ER_BW_SCALE);
>>> +    if (er_index < 0)
>>> +        return er_index;
>>> +
>>> +    bw_cfg_offset += MHI_BW_SCALE_CFG_OFFSET;
>>> +
>>> +    /* advertise host support */
>>> +    val = MHI_BW_SCALE_ENABLE(bw_scale_db, er_index);
>>> +
>>> +    mhi_write_reg(mhi_cntrl, mhi_cntrl->regs, bw_cfg_offset, val);
>>> +
>>> +    dev_dbg(dev, "Bandwidth scaling setup complete. Event ring:%d\n",
>>> +        er_index);
>>> +
>>
>> "Bandwidth scaling setup complete with event ring: %d\n"
>>
> ack
>>> +    return 0;
>>> +}
>>> +
>>>   int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>>>   {
>>>       u32 val;
>>> -    int i, ret;
>>> +    int i, ret, doorbell = 0;
>>>       struct mhi_chan *mhi_chan;
>>>       struct mhi_event *mhi_event;
>>>       void __iomem *base = mhi_cntrl->regs;
>>> @@ -633,6 +679,16 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>>>           return ret;
>>>       }
>>> +    if (mhi_cntrl->get_misc_doorbell)
>>> +        doorbell = mhi_cntrl->get_misc_doorbell(mhi_cntrl, 
>>> MHI_ER_BW_SCALE);
>>> +
>>> +    if (doorbell > 0) {
>>> +        ret = mhi_init_bw_scale(mhi_cntrl, doorbell);
>>> +        if (!ret)
>>> +            mhi_cntrl->bw_scale_db = base + val + (8 * doorbell);
>>> +        else
>>> +            dev_warn(dev, "BW scale setup failure\n");
>>
>> "Failed to setup bandwidth scaling: %d"
>>
>>> +    }
>>>       return 0;
>>>   }
>>> @@ -778,6 +834,9 @@ static int parse_ev_cfg(struct mhi_controller 
>>> *mhi_cntrl,
>>>           case MHI_ER_CTRL:
>>>               mhi_event->process_event = mhi_process_ctrl_ev_ring;
>>>               break;
>>> +        case MHI_ER_BW_SCALE:
>>> +            mhi_event->process_event = mhi_process_bw_scale_ev_ring;
>>> +            break;
>>>           default:
>>>               dev_err(dev, "Event Ring type not supported\n");
>>>               goto error_ev_cfg;
>>> @@ -1012,9 +1071,12 @@ int mhi_register_controller(struct 
>>> mhi_controller *mhi_cntrl,
>>>           mhi_event->mhi_cntrl = mhi_cntrl;
>>>           spin_lock_init(&mhi_event->lock);
>>> +        mutex_init(&mhi_event->mutex);
>>>           if (mhi_event->data_type == MHI_ER_CTRL)
>>>               tasklet_init(&mhi_event->task, mhi_ctrl_ev_task,
>>>                        (ulong)mhi_event);
>>> +        else if (mhi_event->data_type == MHI_ER_BW_SCALE)
>>> +            INIT_WORK(&mhi_event->work, mhi_process_ev_work);
>>>           else
>>>               tasklet_init(&mhi_event->task, mhi_ev_task,
>>>                        (ulong)mhi_event);
>>> diff --git a/drivers/bus/mhi/host/internal.h 
>>> b/drivers/bus/mhi/host/internal.h
>>> index 3134f111be35..bf7c6a7c9383 100644
>>> --- a/drivers/bus/mhi/host/internal.h
>>> +++ b/drivers/bus/mhi/host/internal.h
>>> @@ -241,6 +241,8 @@ struct mhi_event {
>>>       struct mhi_ring ring;
>>>       struct db_cfg db_cfg;
>>>       struct tasklet_struct task;
>>> +    struct work_struct work;
>>
>> bw_scaling_work or bw_scale_work?
>>
> ack
As this is in mhi_event and this work structure
can be used in future for features like
TIME sync. So going with same name.

- Krishna Chaitanya.
>>> +    struct mutex mutex;
>>
>> Add a comment on the purpose of the mutex.
>>
>>>       spinlock_t lock;
>>>       int (*process_event)(struct mhi_controller *mhi_cntrl,
>>>                    struct mhi_event *mhi_event,
>>> @@ -403,7 +405,8 @@ int mhi_process_data_event_ring(struct 
>>> mhi_controller *mhi_cntrl,
>>>                   struct mhi_event *mhi_event, u32 event_quota);
>>>   int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>>>                    struct mhi_event *mhi_event, u32 event_quota);
>>> -
>>> +int mhi_process_bw_scale_ev_ring(struct mhi_controller *mhi_cntrl,
>>> +                 struct mhi_event *mhi_event, u32 event_quota);
>>>   /* ISR handlers */
>>>   irqreturn_t mhi_irq_handler(int irq_number, void *dev);
>>>   irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev);
>>> @@ -419,5 +422,5 @@ void mhi_unmap_single_no_bb(struct mhi_controller 
>>> *mhi_cntrl,
>>>                   struct mhi_buf_info *buf_info);
>>>   void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
>>>                    struct mhi_buf_info *buf_info);
>>> -
>>> +void mhi_process_ev_work(struct work_struct *work);
>>>   #endif /* _MHI_INT_H */
>>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>>> index 4de75674f193..967563d86aec 100644
>>> --- a/drivers/bus/mhi/host/main.c
>>> +++ b/drivers/bus/mhi/host/main.c
>>> @@ -472,7 +472,10 @@ irqreturn_t mhi_irq_handler(int irq_number, void 
>>> *dev)
>>>           if (mhi_dev)
>>>               mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
>>>       } else {
>>> -        tasklet_schedule(&mhi_event->task);
>>> +        if (mhi_event->data_type == MHI_ER_BW_SCALE)
>>> +            queue_work(mhi_cntrl->hiprio_wq, &mhi_event->work);
>>
>> To avoid the hassle, I think it is worth changing the mutex in bwctrl to
>> spinlock. I don't think there would be issues in spinning inside
>> pcie_set_target_speed().
>>
> I am not sure if it is good to change it to mutex or not in
> pcie_set_target_speed() because it is being called from
> pcie_failed_link_retrain() and this is being called when new pci
> device is added and many other places.
>>> +        else
>>> +            tasklet_schedule(&mhi_event->task);
>>>       }
>>>       return IRQ_HANDLED;
>>> @@ -1049,6 +1052,102 @@ int mhi_process_data_event_ring(struct 
>>> mhi_controller *mhi_cntrl,
>>>       return count;
>>>   }
>>> +/* dedicated bw scale event ring processing */
>>> +int mhi_process_bw_scale_ev_ring(struct mhi_controller *mhi_cntrl,
>>> +                 struct mhi_event *mhi_event, u32 event_quota)
>>> +{
>>> +    struct mhi_event_ctxt *er_ctxt = 
>>> &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
>>> +    struct device *dev = &mhi_cntrl->mhi_dev->dev;
>>> +    struct mhi_ring *ev_ring = &mhi_event->ring;
>>> +    dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
>>> +    u32 response = MHI_BW_SCALE_NACK;
>>> +    struct mhi_ring_element *dev_rp;
>>> +    struct mhi_link_info link_info;
>>> +    int ret = -EINVAL;
>>> +
>>> +    if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state))) {
>>> +        ret =  -EIO;
>>> +        goto exit_bw_scale_process;
>>
>> exit_bw_scale?
>>
> ack
>>> +    }
>>> +
>>> +    if (!MHI_IN_MISSION_MODE(mhi_cntrl->ee))
>>> +        goto exit_bw_scale_process;
>>> +
>>> +    if (!is_valid_ring_ptr(ev_ring, ptr)) {
>>> +        dev_err(dev,
>>> +            "Event ring rp points outside of the event ring\n");
>>> +        ret =  -EIO;
>>> +        goto exit_bw_scale_process;
>>> +    }
>>> +
>>> +    dev_rp = mhi_to_virtual(ev_ring, ptr);
>>> +
>>> +    /* if rp points to base, we need to wrap it around */
>>
>> Nit: Use caps for starting letter and also for acronyms.
>>
>>> +    if (dev_rp == ev_ring->base)
>>> +        dev_rp = ev_ring->base + ev_ring->len;
>>> +    dev_rp--;
>>> +
>>> +    /* fast forward to currently processed element and recycle er */
>>> +    ev_ring->rp = dev_rp;
>>> +    ev_ring->wp = dev_rp - 1;
>>> +    if (ev_ring->wp < ev_ring->base)
>>> +        ev_ring->wp = ev_ring->base + ev_ring->len - ev_ring->el_size;
>>> +    mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
>>> +
>>> +    if (WARN_ON(MHI_TRE_GET_EV_TYPE(dev_rp) != 
>>> MHI_PKT_TYPE_BW_REQ_EVENT)) {
>>> +        dev_err(dev, "!BW SCALE REQ event\n");
>>> +        goto exit_bw_scale_process;
>>> +    }
>>> +
>>> +    link_info.target_link_speed = MHI_TRE_GET_EV_LINKSPEED(dev_rp);
>>> +    link_info.target_link_width = MHI_TRE_GET_EV_LINKWIDTH(dev_rp);
>>> +    link_info.sequence_num = MHI_TRE_GET_EV_BW_REQ_SEQ(dev_rp);
>>> +
>>> +    dev_info(dev, "Received BW_REQ with seq:%d link speed:0x%x 
>>> width:0x%x\n",
>>> +         link_info.sequence_num,
>>> +         link_info.target_link_speed,
>>> +         link_info.target_link_width);
>>
>> dev_dbg()
>>
>>> +
>>> +    /* bring host and device out of suspended states */
>>> +    ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
>>> +    if (ret)
>>> +        goto exit_bw_scale_process;
>>> +
>>> +    mhi_cntrl->runtime_get(mhi_cntrl);
>>> +
>>> +    ret = mhi_cntrl->bw_scale(mhi_cntrl, &link_info);
>>> +    if (!ret)
>>> +        response = 0;
>>> +
>>> +    response = MHI_BW_SCALE_RESULT(response, link_info.sequence_num);
>>> +
>>> +    write_lock_bh(&mhi_cntrl->pm_lock);
>>> +    mhi_write_reg(mhi_cntrl, mhi_cntrl->bw_scale_db, 0, response);
>>> +    write_unlock_bh(&mhi_cntrl->pm_lock);
>>> +
>>> +    mhi_cntrl->runtime_put(mhi_cntrl);
>>> +    mhi_device_put(mhi_cntrl->mhi_dev);
>>> +
>>> +exit_bw_scale_process:
>>> +    dev_dbg(dev, "exit er_index:%u ret:%d\n", mhi_event->er_index, 
>>> ret);
>>
>> Can these entry exit debug sequences be avoided?
>>
> ack.
> - Krishna Chaitanya.
> 
>> - Mani
>>

