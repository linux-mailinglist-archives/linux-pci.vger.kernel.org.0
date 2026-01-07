Return-Path: <linux-pci+bounces-44168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F33CFD20C
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 11:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 729C830386B7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 10:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE503301701;
	Wed,  7 Jan 2026 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mjF4K94+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UxYdGbGP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5A30DED4
	for <linux-pci@vger.kernel.org>; Wed,  7 Jan 2026 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780575; cv=none; b=a+yMTYnXailIFzU1hk8ncZ9xYHtCCnLgLp3dCLH03ak+I1zRPmGGQxJoCWrbXhXBqrEIFJFdE/lLz6k1nk8edTUWEzW0NFPb56GkLp4STuYJmd5VkLxI47t5sZXf1nuTNj0Gwn0Jz9pCDUv3J8cujy2HFoNygVwwNGQap9LCZhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780575; c=relaxed/simple;
	bh=1KxKfObDETHscY8rnhC1ORd73aP/bt/xsFfWA8vV/bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6axNHi4kZ597dJCr0No3LsBdnJEAsdVYYWQI/fAT34tDu+jMS4FvZrH7wIxSWcxADkkh+YF9U2gXQ423WXSEqopU0dMPSmGv5H5/ktDgCSwyagjdym1dCPJUeHNQUNTSgeyZRXG4oqKIbyAN2wNjW3n0EkuuebsJ5B3gAZlqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mjF4K94+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UxYdGbGP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6079GHSO3889118
	for <linux-pci@vger.kernel.org>; Wed, 7 Jan 2026 10:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	udw1eUX5AGugXDTEzQPhcy3bTz1GW4bpaID9E/vn9hA=; b=mjF4K94+Wd03cBz1
	fQZXOT1/EDIibjv9FLqj5bXfv3pNiIe1o0idHZeCE5ZTdCkXcSGtDpRi66eEUsFy
	Vbd/FNPQJYYuwheVPnjEVsVnM2FCnT/LOJ2KgtI4INMJxpTfyfJ6rTWyuRJmOH43
	3zQTggAW9vlVIVkTwJ2oi77oC8GWw+A3/DPY+s4MXU9gNeNm3Qaa6+rhgI1pQkVn
	N5BxT59RAkLVHAVbgh/6+U/kXAC0W6lYWqqqSziUPFdP8Zm/HzpdKM9z5PPxrTNP
	K2+dGrCaWIU0jayeuLzW5BtoPD9u7h6KsjYiJ42TkUS70VD21uO5dxFaIJGN3TSo
	NS+ssw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh6a0jvvd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 07 Jan 2026 10:09:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a377e15716so46368185ad.3
        for <linux-pci@vger.kernel.org>; Wed, 07 Jan 2026 02:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767780572; x=1768385372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=udw1eUX5AGugXDTEzQPhcy3bTz1GW4bpaID9E/vn9hA=;
        b=UxYdGbGPB+UKFk4juBzQ4GnlxPzyzUe/TTNd4BcGBNvoK+/gWoaJQJD1tBDZXfg0A2
         bs9dPxzrLsZpDIwYnqWf+GJ+vhFC6zlSczWemWI2Ekj7G55ITO+0Zz3m9TrcAgUQeKJp
         7Z2dcco2mdZcCZYMxPs9TJDZcInx+1smVEyFdQQm6qPpaL30bYRgsfau1g0MVqUj08Vp
         JBI2S3e7lQJoKzSRcUyCEbCn5mdxq04oWso56BTokQ3glQUEABp+IOEGvdo1WiKRpqSA
         8s/MnzFgTJg/ZmVL+sYgXUykNWSaimCc9iOc6gSrBpQxpAsRgOu/jBkH2xWFc93dD5O4
         cmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767780572; x=1768385372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udw1eUX5AGugXDTEzQPhcy3bTz1GW4bpaID9E/vn9hA=;
        b=R4DhgozGdD612+84sUvp7FpPZ1AxspekkZxIOljZvOOAdz19Ll+2Refh/2S9iLzJg0
         yj+DAAqKca0D0SNzildAeGyfECWlaUt2dKdkp2XRBEOVXZSsLFNdM/DOhxcFxXykuisb
         OsBP6Jj1WYLogn6HppFRJ8J98+G++TncT0sypuyJkMnzG3LfhstuQCafZgJ927mtTCzU
         0kn47rNQDnbsEBxaHOMdlarcvYNh7kCFwrd5HFBLuD5F4b173mO0YKJp//yeHcdeYT0+
         4ysgiOFsP2JdF9KM/gxn2BLPKUID3C8HALr2sIYaOvVv1vZeHxR0SZTu4sm/ayV4UI7C
         ocDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh8Gd1g01LJ1YbwKwHRSt3gB4Eh+GP51UXG1f2gbN2T7zn9UeJ+C0RHFJj/ILFtSfdgKmawUXfcBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykg4Xj88p/rfk7D2EHiD3JHpX14FutJyY1fDksAXlYywy+qk6u
	B4HjyFeLxCvkKiFuyQs6YRhZIQ7FBonb3KkiDMGCgtF/1VTwKRwyMTBr4Vt9jw652FRdkrpn0hd
	zeo8RuEcid1EWRkLRb0aF+wXC2KGpu4krb52w8nnW7iqUHLe8IpSD33juWnKcF3Q=
X-Gm-Gg: AY/fxX6XIhOxl5EVSzE6NdNvsE0tl7ilVudTAdt205Pwe4sonFQayq7gHRsR+dW4NsW
	BXI5I8eFMsnbvisX3GDqliW/V7cGDlWD4CHpO94eY5MRJOHAAMTG8mNMRgOdQNsnftiDSBhPVw9
	ocHW40KL9Y6Qn44W+7ZMhN7mkKP22i1UjKUyD3uKB0E/DkMXgOOk175WjgemIy0vJtl9omal2B6
	9hSkdXj5rt9L8ulQB/Q6CvwDuFoC3thkeT8kOoHx821E6Mas2vts8UPcvRPTdYy0qGiZ2zB8h8s
	+cK+z6WXG6bL8IusVJkektXOPYRqXXas9+BU2QpPd4qiGrjuMei8nsQDbXDrUjd7qRIfKwS9UNW
	WUeM7Rueoo+j9UuJdKgyrIO59eTEqUGlwljldaGRnrV3/oec=
X-Received: by 2002:a17:903:2348:b0:2a0:d431:930 with SMTP id d9443c01a7336-2a3ee4b244dmr19748205ad.47.1767780571920;
        Wed, 07 Jan 2026 02:09:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0LO0AbdqJrkfWaN2hJ7j9a3u+lehpoZUlZBHWKc1x1PyeIkRqMM6NwTEK43+mHHpSRBaQ+w==
X-Received: by 2002:a17:903:2348:b0:2a0:d431:930 with SMTP id d9443c01a7336-2a3ee4b244dmr19747945ad.47.1767780571440;
        Wed, 07 Jan 2026 02:09:31 -0800 (PST)
Received: from [172.20.10.11] ([152.57.155.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd469dsm46794155ad.94.2026.01.07.02.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 02:09:31 -0800 (PST)
Message-ID: <9b938af1-d915-4674-90a8-46a4fed0f7f5@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 15:39:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: Add LTSSM tracing support to debugfs
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>,
        linux-pci@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <mani@kernel.org>
References: <1767691119-28287-1-git-send-email-shawn.lin@rock-chips.com>
 <8d4e73f5-b4da-4aca-a2b2-b607be8c245a@oss.qualcomm.com>
 <014d034f-998d-466c-9c73-181297de83ba@rock-chips.com>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <014d034f-998d-466c-9c73-181297de83ba@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gQnLjaBbxOC-tEhupbKPTi38SJU7ZfTw
X-Proofpoint-GUID: gQnLjaBbxOC-tEhupbKPTi38SJU7ZfTw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA4MiBTYWx0ZWRfX4OzSf25EfYIc
 r59ywKHHDX+i3eJAUQ787m2Y8yxucHNHuiZ2PhdaiX49WXM+m8mGz7bCidcISho7vF4JFKp/3aD
 EfJ4vT/WxynEPRAn9eoVNYp2P1xsH//0hTJtmY4p3yJ2pXfb5qAkJnY+VkR3aVIAwX4hS/pfzWs
 SQ0HAjQ7Lroww/Qk578P/nv2XCM3IiZqK9IHZRAl+EyiCwLTfTF+/xc1+yBtfiC3SK9c/ws+O7O
 tC8f2on3qV9tER/kOP5c9Gqn9hlq10eQSR1KzPlY2ykJsoL7/QtvKDOLdJZBes85IZgoGuRGexx
 0OqKKbeikEGcDgQ/jtQ7vVjWnTKDF2KDqs7PCsFgRvvn8hB/ttW4HD+RXhLshXaRFfs6ICcn5PK
 z+9UmW8ek2RhnXZkLct3N67XF5SWlo5KZ8DwT8zaLneUxTJ+ZKTjXV4VBG+z7aD5EE70+oBCwBy
 8t5lK4R3+rd2y5CfbWg==
X-Authority-Analysis: v=2.4 cv=MtdfKmae c=1 sm=1 tr=0 ts=695e30dc cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=tDXggk5s07qaktl9dEk39g==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=s8YR1HE3AAAA:8 a=8IykHcQbvvH1SdHDNeUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070082



On 1/7/2026 3:11 PM, Shawn Lin wrote:
> 在 2026/01/07 星期三 17:12, Krishna Chaitanya Chundru 写道:
>>
>>
>> On 1/6/2026 2:48 PM, Shawn Lin wrote:
>>> Some platforms may provide LTSSM trace functionality, recording 
>>> historical
>>> LTSSM state transition information. This is very useful for 
>>> debugging, such
>>> as when certain devices cannot be recognized. Add an ltssm_trace 
>>> operation
>>> node in debugfs for platform which could provide these information 
>>> to show
>>> the LTSSM history.
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> ---
>>>   .../controller/dwc/pcie-designware-debugfs.c  | 44 
>>> +++++++++++++++++++
>>>   drivers/pci/controller/dwc/pcie-designware.h  |  6 +++
>>>   2 files changed, 50 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/ 
>>> drivers/pci/controller/dwc/pcie-designware-debugfs.c
>>> index df98fee69892..569e8e078ef2 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
>>> @@ -511,6 +511,38 @@ static int ltssm_status_open(struct inode 
>>> *inode, struct file *file)
>>>       return single_open(file, ltssm_status_show, inode->i_private);
>>>   }
>>> +static struct dw_pcie_ltssm_history *dw_pcie_ltssm_trace(struct 
>>> dw_pcie *pci)
>>> +{
>>> +    if (pci->ops && pci->ops->ltssm_trace)
>>> +        return pci->ops->ltssm_trace(pci);
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>> +static int ltssm_trace_show(struct seq_file *s, void *v)
>>> +{
>>> +    struct dw_pcie *pci = s->private;
>>> +    struct dw_pcie_ltssm_history *history;
>>> +    enum dw_pcie_ltssm val;
>>> +    u32 loop;
>>> +
>>> +    history = dw_pcie_ltssm_trace(pci);
>>> +    if (!history)
>>> +        return 0;
>>> +
>>> +    for (loop = 0; loop < history->count; loop++) {
>>> +        val = history->states[loop];
>>> +        seq_printf(s, "%s (0x%02x)\n", ltssm_status_string(val), val);
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static int ltssm_trace_open(struct inode *inode, struct file *file)
>>> +{
>>> +    return single_open(file, ltssm_trace_show, inode->i_private);
>>> +}
>>> +
>>>   #define dwc_debugfs_create(name)            \
>>>   debugfs_create_file(#name, 0644, rasdes_debug, pci,    \
>>>               &dbg_ ## name ## _fops)
>>> @@ -552,6 +584,11 @@ static const struct file_operations 
>>> dwc_pcie_ltssm_status_ops = {
>>>       .read = seq_read,
>>>   };
>>> +static const struct file_operations dwc_pcie_ltssm_trace_ops = {
>>> +    .open = ltssm_trace_open,
>>> +    .read = seq_read,
>>> +};
>>> +
>>>   static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
>>>   {
>>>       struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
>>> @@ -644,6 +681,12 @@ static void dwc_pcie_ltssm_debugfs_init(struct 
>>> dw_pcie *pci, struct dentry *dir)
>>>                   &dwc_pcie_ltssm_status_ops);
>>>   }
>>> +static void dwc_pcie_ltssm_trace_debugfs_init(struct dw_pcie *pci, 
>>> struct dentry *dir)
>>> +{
>>> +    debugfs_create_file("ltssm_trace", 0444, dir, pci,
>>> +                &dwc_pcie_ltssm_trace_ops);
>> Can we have this as the sysfs, so that if there is some issue in 
>> production devices where debugfs is not available,
>> we can use this to see LTSSM state figure out the issue.
>>
>
> Thanks for the input. I think the ltssm_trace is debug in nature, just 
> like the existing ltssm and rasdes_debug nodes, so it probably fits 
> better under debugfs for consistency. Moreover, given most time we
> combine rasdes_debug and ltssmm history to debug issues, if we split it
> out, we’d end up with two separate debugging areas, which feels a bit
> fragmented and less clear. 
Rasdes has statistics and err injection along with debug feature, we can 
have them
as debugfs only since they will not help in debugging production issues. 
For others like
ltssm, lane_detect & rx_valid we can have in sysfs.

- Krishna Chaitanya.
>
>
>> - Krishna Chaitanya.
>>> +}
>>> +
>>>   static int dw_pcie_ptm_check_capability(void *drvdata)
>>>   {
>>>       struct dw_pcie *pci = drvdata;
>>> @@ -922,6 +965,7 @@ void dwc_pcie_debugfs_init(struct dw_pcie *pci, 
>>> enum dw_pcie_device_mode mode)
>>>               err);
>>>       dwc_pcie_ltssm_debugfs_init(pci, dir);
>>> +    dwc_pcie_ltssm_trace_debugfs_init(pci, dir);
>>>       pci->mode = mode;
>>>       pci->ptm_debugfs = pcie_ptm_create_debugfs(pci->dev, pci,
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/ 
>>> pci/controller/dwc/pcie-designware.h
>>> index 5cd27f5739f1..0df18995b7fe 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>>> @@ -395,6 +395,11 @@ enum dw_pcie_ltssm {
>>>       DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
>>>   };
>>> +struct dw_pcie_ltssm_history {
>>> +    enum dw_pcie_ltssm *states;
>>> +    u32 count;
>>> +};
>>> +
>>>   struct dw_pcie_ob_atu_cfg {
>>>       int index;
>>>       int type;
>>> @@ -499,6 +504,7 @@ struct dw_pcie_ops {
>>>                     size_t size, u32 val);
>>>       bool    (*link_up)(struct dw_pcie *pcie);
>>>       enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
>>> +    struct dw_pcie_ltssm_history * (*ltssm_trace)(struct dw_pcie 
>>> *pcie);
>>>       int    (*start_link)(struct dw_pcie *pcie);
>>>       void    (*stop_link)(struct dw_pcie *pcie);
>>>       int    (*assert_perst)(struct dw_pcie *pcie, bool assert);
>>
>>
>


