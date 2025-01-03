Return-Path: <linux-pci+bounces-19220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEE8A008D3
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 12:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C37E164873
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3DD1F8F11;
	Fri,  3 Jan 2025 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9dljV/H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7543D1C5F20
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 11:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735904646; cv=none; b=swX/1Q81Kgf2onfXUDSM7NAVAUo2GUHLGe3qBtkZzkayeYJ/Nm5hCuc77nwX+SjVq/EF60lJ3NTFgbOEuYWr4np0S3xXy6/7VUikEWThs2TOJV+EHX1pJEwYT3Y0kbhpk7hC/YIzh9NePB78IunZSPgAN9sT7SsJe0nmHf3zYi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735904646; c=relaxed/simple;
	bh=C45X3EUAgx08ml/ELxgPHUzyevyNUk4WFtQJokeSxdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/mun0UiqBu11mOVlDSknmp4w76LE3FXX8g7N6ZPoEtbYJ9BDoqdZCRKklTWxp5e+zVjAw+nfRKYpaCMjWH7yaBeSCq/GxaapED/OMx5AsT6TRCvFYvbd+v89OPtH1yNMsahOVHYUrtYF2LQFlaM8RnrIk9R80N7+p8RcnQSG/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j9dljV/H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502Kowff027361
	for <linux-pci@vger.kernel.org>; Fri, 3 Jan 2025 11:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X2tVzUXMfsTc5Cv21aOZVtteU56XGzsMiwn9gxG46kQ=; b=j9dljV/HbhkkUMbE
	463JxaqPgFqzWMoWVyK5ezlNwYbs+f1dTpxE3Q8t75BtsR1PI8SW/iHJL8c+/chX
	wHu179aIDPKuwz4RB/9NXY5Su3vM4k8K6eFBKSeZwFJHUI3ueUDYb+IRLrwHK0ty
	fgzxmmIzw98jLMQ1AxRsgAlzaMUOeH2alRHxMKu/4S7Kf3sGXvoCV5Swi0BpIifQ
	GEkjieb+lPgzGXXh6PBM+ZaUGeanZGisyBMVlAt0Y+rgUYKI8gTztbuoup6kDb8n
	M1ZzCwa+lxbQZdZ6UexXhQEKxc18XcovFS1u+Fwu+LLu9XsOX9LlyxXOj4XWJ0Jv
	3sx7YA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43wxsea3vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 03 Jan 2025 11:44:03 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6d8f77bf546so35949436d6.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Jan 2025 03:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735904642; x=1736509442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X2tVzUXMfsTc5Cv21aOZVtteU56XGzsMiwn9gxG46kQ=;
        b=M2JgrbQW5sPnYIworVbGaiCWorhZtg4TaVZcMQ9o7egnd04fMnI0XGQG9m6/zdDUJB
         FDJxotmr6xoF7Pkh1S3H4CtV3eZ3caVp/98o6ThQllXC2VEdn5v92RP72XcCrqG5Lt+C
         sHwiUqM1JZ8IbLCXYFziFtBS7ZCHm7f3LkFdvwUJcHwbE4hQMXEx8Q+1jOx7xhP+xmkW
         WyhwoBObh0aeBLGAdzUNdoZRZ320QraJeZpaKAph0uBaM1fZy3i/QazCldoylq/18W25
         VnM2zXSGye8Y2J/yVWDoEp/ZXapwq1gsDisRLiqAy0qOPKY+0aZOE6shSD/vH9LVT7dj
         Y4sg==
X-Forwarded-Encrypted: i=1; AJvYcCWI2WmTVhSyW9GoUfRAo5d7MrL8DyEtOollyQadophon+N6Xc+g9kLC4b6smdPJUfLxHuuKZi9O5mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKFchiSTVfq221Oo+DRONyeplHyaH+W/YE1ZlvrkrFGzxthrgY
	0vuj3qIL96DdK5nsx4qlnstEZ/95R+7gWIfA/rq5Bzhojkglde576V3iH87e9oBzStlojTUuapK
	EUUxfB4iUTFC0AWaj5RqG1V99D/47unXM1HUWMCeCbjNfGtalwfs2W0DJ6Pc=
X-Gm-Gg: ASbGncvftY8qV6Hg55dtqO4XlSwbrDUysU8SV+xv8IX/H8XF/YdMgriT32LYRYO0o1a
	XE1tbL/os6vlvOO7cGe75TiiZKB9cjfLbdBCZ3XH1iOV91ks0lihhqy1ZJJ26E1LrTtz5UMP/VV
	bA2xZ1juPNFw83no2abJ6Lc5nrxGxnZFn/tjMFpC1o4YG+/YD0fdNB+/71ok+WoeFxMez55GJrl
	h6GhXZhkS9Ggax4xMUX9AZNmsfjHlf2wQY4gBM2jWlohPuB+tE3q2n/GI1V37xGsvCNRC8QOpmC
	zCK/0MJPNvfUwebD6gwN+anXqUn/GjBJlRU=
X-Received: by 2002:a05:620a:471f:b0:7b6:d273:9b4b with SMTP id af79cd13be357-7b9ba7b083amr2928565085a.10.1735904642300;
        Fri, 03 Jan 2025 03:44:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMolNXavTyj4EBPuyvAJYCuV5XMcyeJpvVST7jyVrD8ntpOR4z3lCuBT5kFYE2zu5fPfTvHw==
X-Received: by 2002:a05:620a:471f:b0:7b6:d273:9b4b with SMTP id af79cd13be357-7b9ba7b083amr2928563685a.10.1735904641842;
        Fri, 03 Jan 2025 03:44:01 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e830b00sm1872313166b.16.2025.01.03.03.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 03:44:01 -0800 (PST)
Message-ID: <869a43cb-2717-49d2-b454-d37716c663fa@oss.qualcomm.com>
Date: Fri, 3 Jan 2025 12:43:58 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] PCI: of: Add API to retrieve equalization presets
 from device tree
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com,
        Bjorn Andersson <andersson@kernel.org>
References: <20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com>
 <20241223-preset_v2-v3-2-a339f475caf5@oss.qualcomm.com>
 <piccoomv7rx4dvvfdoesmxbzrdqz4ld6ii6neudsdf4hjj2yzm@2bcuacwa4feb>
 <d317c51a-3913-6c49-f8db-e75589f9289a@quicinc.com>
 <wjk32haduzgiea676mamqdr6mhbmm3rrb6eyhzghqpczjuiazx@ipik3jhjzmhz>
 <7bc9f3f2-851c-3703-39b4-fea93d10bd7f@quicinc.com>
 <ntag3wc3yqax2afsbzesev32hpj3ssiknhjq6dtncuuj4ljrxh@23ed4qdwfrxi>
 <49ccd5f2-8524-eba4-25ef-4cdc39edc93b@quicinc.com>
 <7busek7zgost2s7mjklgvlccaef3lgz4k7btki72nkr5et7fdn@wkv2z6zbicdj>
 <fb17e142-e66f-85a7-353c-0e498892b884@quicinc.com>
 <CAA8EJpr=ktQ4c2dGxnCQNF4rLOCuCLRr6OYT4yVkyOnk2nF+Og@mail.gmail.com>
 <1a3c7424-9cef-4fed-aa53-ad922aa4d3cb@oss.qualcomm.com>
 <42297b99-5930-e270-45d6-181e1c36681f@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <42297b99-5930-e270-45d6-181e1c36681f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ubRkVveIHd7PNphOc8YmT_LPE9c9x7JX
X-Proofpoint-GUID: ubRkVveIHd7PNphOc8YmT_LPE9c9x7JX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030103

On 31.12.2024 5:38 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 12/30/2024 7:11 PM, Konrad Dybcio wrote:
>> On 24.12.2024 11:57 AM, Dmitry Baryshkov wrote:
>>> On Tue, 24 Dec 2024 at 12:36, Krishna Chaitanya Chundru
>>> <quic_krichai@quicinc.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/24/2024 3:25 PM, Dmitry Baryshkov wrote:
>>>>> On Tue, Dec 24, 2024 at 02:47:00PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>
>>>>>>
>>>>>> On 12/24/2024 12:00 AM, Dmitry Baryshkov wrote:
>>>>>>> On Mon, Dec 23, 2024 at 10:13:29PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 12/23/2024 8:56 PM, Dmitry Baryshkov wrote:
>>>>>>>>> On Mon, Dec 23, 2024 at 08:02:23PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 12/23/2024 5:17 PM, Dmitry Baryshkov wrote:
>>>>>>>>>>> On Mon, Dec 23, 2024 at 12:21:15PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>>>>>>> PCIe equalization presets are predefined settings used to optimize
>>>>>>>>>>>> signal integrity by compensating for signal loss and distortion in
>>>>>>>>>>>> high-speed data transmission.
>>>>>>>>>>>>
>>>>>>>>>>>> As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
>>>>>>>>>>>> of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
>>>>>>>>>>>> configure lane equalization presets for each lane to enhance the PCIe
>>>>>>>>>>>> link reliability. Each preset value represents a different combination
>>>>>>>>>>>> of pre-shoot and de-emphasis values. For each data rate, different
>>>>>>>>>>>> registers are defined: for 8.0 GT/s, registers are defined in section
>>>>>>>>>>>> 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
>>>>>>>>>>>> an extra receiver preset hint, requiring 16 bits per lane, while the
>>>>>>>>>>>> remaining data rates use 8 bits per lane.
>>>>>>>>>>>>
>>>>>>>>>>>> Based on the number of lanes and the supported data rate, this function
>>>>>>>>>>>> reads the device tree property and stores in the presets structure.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>       drivers/pci/of.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>>>       drivers/pci/pci.h | 17 +++++++++++++++--
>>>>>>>>>>>>       2 files changed, 60 insertions(+), 2 deletions(-)
>>>>>>>>>>>>
>>>>>>>>>>>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>>>>>>>>>>>> index dacea3fc5128..99e0e7ae12e9 100644
>>>>>>>>>>>> --- a/drivers/pci/of.c
>>>>>>>>>>>> +++ b/drivers/pci/of.c
>>>>>>>>>>>> @@ -826,3 +826,48 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
>>>>>>>>>>>>         return slot_power_limit_mw;
>>>>>>>>>>>>       }
>>>>>>>>>>>>       EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
>>>>>>>>>>>> +
>>>>>>>>>>>
>>>>>>>>>>> kerneldoc? Define who should free the memory and how.
>>>>>>>>>>>
>>>>>>>>>> I will update this in next series.
>>>>>>>>>> as we are allocating using devm_kzalloc it should be freed on driver
>>>>>>>>>> detach, as no special freeing is required.
>>>>>>>>>>>> +int of_pci_get_equalization_presets(struct device *dev,
>>>>>>>>>>>> +                                  struct pci_eq_presets *presets,
>>>>>>>>>>>> +                                  int num_lanes)
>>>>>>>>>>>> +{
>>>>>>>>>>>> +      char name[20];
>>>>>>>>>>>> +      void **preset;
>>>>>>>>>>>> +      void *temp;
>>>>>>>>>>>> +      int ret;
>>>>>>>>>>>> +
>>>>>>>>>>>> +      if (of_property_present(dev->of_node, "eq-presets-8gts")) {
>>>>>>>>>>>> +              presets->eq_presets_8gts = devm_kzalloc(dev, sizeof(u16) * num_lanes, GFP_KERNEL);
>>>>>>>>>>>> +              if (!presets->eq_presets_8gts)
>>>>>>>>>>>> +                      return -ENOMEM;
>>>>>>>>>>>> +
>>>>>>>>>>>> +              ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
>>>>>>>>>>>> +                                               presets->eq_presets_8gts, num_lanes);
>>>>>>>>>>>> +              if (ret) {
>>>>>>>>>>>> +                      dev_err(dev, "Error reading eq-presets-8gts %d\n", ret);
>>>>>>>>>>>> +                      return ret;
>>>>>>>>>>>> +              }
>>>>>>>>>>>> +      }
>>>>>>>>>>>> +
>>>>>>>>>>>> +      for (int i = 1; i < sizeof(struct pci_eq_presets) / sizeof(void *); i++) {
>>>>>>>>>>>> +              snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << i);
>>>>>>>>>>>> +              if (of_property_present(dev->of_node, name)) {
>>>>>>>>>>>> +                      temp = devm_kzalloc(dev, sizeof(u8) * num_lanes, GFP_KERNEL);
>>>>>>>>>>>> +                      if (!temp)
>>>>>>>>>>>> +                              return -ENOMEM;
>>>>>>>>>>>> +
>>>>>>>>>>>> +                      ret = of_property_read_u8_array(dev->of_node, name,
>>>>>>>>>>>> +                                                      temp, num_lanes);
>>>>>>>>>>>> +                      if (ret) {
>>>>>>>>>>>> +                              dev_err(dev, "Error %s %d\n", name, ret);
>>>>>>>>>>>> +                              return ret;
>>>>>>>>>>>> +                      }
>>>>>>>>>>>> +
>>>>>>>>>>>> +                      preset = (void **)((u8 *)presets + i * sizeof(void *));
>>>>>>>>>>>
>>>>>>>>>>> Ugh.
>>>>>>>>>>>
>>>>>>>>>> I was trying iterate over each element on the structure as presets holds the
>>>>>>>>>> starting address of the structure and to that we are adding size of the void
>>>>>>>>>> * point to go to each element. I did this way to reduce the
>>>>>>>>>> redundant code to read all the gts which has same way of storing the data
>>>>>>>>>> from the device tree. I will add comments here in the next series.
>>>>>>>>>
>>>>>>>>> Please rewrite this in a cleaner way. The code shouldn't raise
>>>>>>>>> questions.
>>>>>>>>>
>>>>>>>>>>>> +                      *preset = temp;
>>>>>>>>>>>> +              }
>>>>>>>>>>>> +      }
>>>>>>>>>>>> +
>>>>>>>>>>>> +      return 0;
>>>>>>>>>>>> +}
>>>>>>>>>>>> +EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
>>>>>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>>>>>>>>> index 14d00ce45bfa..82362d58bedc 100644
>>>>>>>>>>>> --- a/drivers/pci/pci.h
>>>>>>>>>>>> +++ b/drivers/pci/pci.h
>>>>>>>>>>>> @@ -731,7 +731,12 @@ static inline u64 pci_rebar_size_to_bytes(int size)
>>>>>>>>>>>>       }
>>>>>>>>>>>>       struct device_node;
>>>>>>>>>>>> -
>>>>>>>>>>>> +struct pci_eq_presets {
>>>>>>>>>>>> +      void *eq_presets_8gts;
>>>>>>>>>>>> +      void *eq_presets_16gts;
>>>>>>>>>>>> +      void *eq_presets_32gts;
>>>>>>>>>>>> +      void *eq_presets_64gts;
>>>>>>>>>>>
>>>>>>>>>>> Why are all of those void*? 8gts is u16*, all other are u8*.
>>>>>>>>>>>
>>>>>>>>>> To have common parsing logic I moved them to void*, as these are pointers
>>>>>>>>>> actual memory is allocated by of_pci_get_equalization_presets()
>>>>>>>>>> based upon the gts these should not give any issues.
>>>>>>>>>
>>>>>>>>> Please, don't. They have types. void pointers are for the opaque data.
>>>>>>>>>
>>>>>>>> ok.
>>>>>>>>
>>>>>>>> I think then better to use v1 patch
>>>>>>>> https://lore.kernel.org/all/20241116-presets-v1-2-878a837a4fee@quicinc.com/
>>>>>>>>
>>>>>>>> konrad, any objection on using v1 as that will be cleaner way even if we
>>>>>>>> have some repetitive code.
>>>>>>>
>>>>>>> Konrad had a nice suggestion about using the array of values. Please use
>>>>>>> such an array for 16gts and above. This removes most of repetitive code.
>>>>>>>
>>>>>> I don't feel having array in the preset structure looks good, I have
>>>>>> come up with this logic if you feel it is not so good I will go to the
>>>>>> suggested way by having array for 16gts and above.
>>>>>>
>>>>>>          if (of_property_present(dev->of_node, "eq-presets-8gts")) {
>>>>>>                   presets->eq_presets_8gts = devm_kzalloc(dev, sizeof(u16) *
>>>>>> num_lanes, GFP_KERNEL);
>>>>>>                   if (!presets->eq_presets_8gts)
>>>>>>                           return -ENOMEM;
>>>>>>
>>>>>>                   ret = of_property_read_u16_array(dev->of_node,
>>>>>> "eq-presets-8gts",
>>>>>>
>>>>>> presets->eq_presets_8gts, num_lanes);
>>>>>>                   if (ret) {
>>>>>>                           dev_err(dev, "Error reading eq-presets-8gts %d\n",
>>>>>> ret);
>>>>>>                           return ret;
>>>>>>                   }
>>>>>>           }
>>>>>>
>>>>>>           for (int i = EQ_PRESET_TYPE_16GTS; i < EQ_PRESET_TYPE_64GTS; i++) {
>>>>>>                   snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << i);
>>>>>>                   if (of_property_present(dev->of_node, name)) {
>>>>>>                           temp = devm_kzalloc(dev, sizeof(u8) * num_lanes,
>>>>>> GFP_KERNEL);
>>>>>>                           if (!temp)
>>>>>>                                   return -ENOMEM;
>>>>>>
>>>>>>                           ret = of_property_read_u8_array(dev->of_node, name,
>>>>>>                                                           temp, num_lanes);
>>>>>>                           if (ret) {
>>>>>>                                   dev_err(dev, "Error %s %d\n", name, ret);
>>>>>>                                   return ret;
>>>>>>                           }
>>>>>>
>>>>>>                           switch (i) {
>>>>>>                                   case EQ_PRESET_TYPE_16GTS:
>>>>>>                                           presets->eq_presets_16gts = temp;
>>>>>>                                           break;
>>>>>>                                   case EQ_PRESET_TYPE_32GTS:
>>>>>>                                           presets->eq_presets_32gts = temp;
>>>>>>                                           break;
>>>>>>                                   case EQ_PRESET_TYPE_64GTS:
>>>>>>                                           presets->eq_presets_64gts = temp;
>>>>>>                                           break;
>>>>>>                           }
>>>>>
>>>>> This looks like 'presets->eq_presets[i] = temp;', but I won't insist on
>>>>> that.
>>>>>
>>>>> Also, a strange thought came to my mind: we know that there won't be
>>>>> more than 16 lanes. Can we have the following structure instead:
>>>>>
>>>>> #define MAX_LANES 16
>>>>> enum pcie_gts {
>>>>>        PCIE_GTS_16GTS,
>>>>>        PCIE_GTS_32GTS,
>>>>>        PCIE_GTS_64GTS,
>>>>>        PCIE_GTS_MAX,
>>>>> };
>>>>> struct pci_eq_presets {
>>>>>        u16 eq_presets_8gts[MAX_LANES];
>>>>>        u8 eq_presets_Ngts[PCIE_GTS_MAX][MAX_LANES];
>>>>> };
>>>>>
>>>>> This should allow you to drop the of_property_present() and
>>>>> devm_kzalloc(). Just read DT data into a corresponding array.
>>>>>
>>>> in the dwc driver patch I was using pointers and memory allocation
>>>> to known if the property is present or not. If I use this way I might
>>>> end up reading dt property again.
>>>
>>> Add foo_valid flags to the struct.
>>
>> Some(u8)/None would be fitting, but we're not there yet :(
>>
>> Are all 0x00-0xff(ff) values valid for these presets?
>>
> currently 0xff are reserved not sure in future PCIe spec data rates
> can use it or not.

Maybe we could use it as a #define-d placeholder then, and kick the
can down the road. Opinions?

Konrad

