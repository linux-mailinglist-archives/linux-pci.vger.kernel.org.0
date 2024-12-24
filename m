Return-Path: <linux-pci+bounces-19001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE19FBC71
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 11:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E637A0619
	for <lists+linux-pci@lfdr.de>; Tue, 24 Dec 2024 10:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DFD1B218C;
	Tue, 24 Dec 2024 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A8DvnrqN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A165156F54;
	Tue, 24 Dec 2024 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735036597; cv=none; b=E1LH+T/a4MmVRo6ha10QUd907sVH7sSxozs0NV3TJkK8xoVX43h4LFFShIGw6HMdnbGbAnFeQchZ7bsaOdZLwFc9ii9+rlZkgNWfjCnScbo36vDGrVZD/zn+LjKuZtr+nuLlg31Yw90EQjJZlSY5kpELaq/Y4Crfyczitu2ZdEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735036597; c=relaxed/simple;
	bh=nCbrrQaiO3KsZr+cMwI1lakkk/v5i0EcVq+Mh9AsQY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mqt4TArJC9DFibWAi7bZupfDWuaG1JSPu4CXJK6KegMLwElsgqi5xRGE3xjcPBy60LsbZZqYc+6qlUDc3dNntfy3Soh65d28D22bd057Q+Wj2xnVEUCInlObibOrSnaq9Bzkfhs7IKbtgXtZA/5pFuSv/ZLdGEbzb1v40hNdX2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A8DvnrqN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BO9ZWEY007837;
	Tue, 24 Dec 2024 10:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/LF8kThLR66CHiug04lHhV9jYxwG+m0Ds0bDZ8YUk1M=; b=A8DvnrqNWhxtfa2o
	hPwVeJVkSbX8NiokRr7lnEzoWODJE3Ub6HHq//MK+GlgNCfECdP18EdvIdtegie6
	8AuNOLtn48TinP92n2VrhE0GOu1Cq2k8mFvi67eDHRg0s2Klpgc4xxalxFF3WWEb
	/6yIalnIQNJQYu3auy1XFx/HRsCMJVoopYBa0fi0qFB6CnpO+BdGbvpsN0SCxUNt
	bRGCmO/AfLptZ+PAQBRF560L9cNlgIEoCyTVdeFhd8YVV10qOZhjIHcsB79iVT1t
	nKJ/WAnDP1BVFr8N9Gg6QDXdK8ahvtX781N9nsBrc4GHqflYZKVe8F485fLoOq1R
	82Ii5A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qtf88ett-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 10:36:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BOAa7io011325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 10:36:07 GMT
Received: from [10.216.2.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Dec
 2024 02:36:01 -0800
Message-ID: <fb17e142-e66f-85a7-353c-0e498892b884@quicinc.com>
Date: Tue, 24 Dec 2024 16:05:58 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/4] PCI: of: Add API to retrieve equalization presets
 from device tree
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Konrad Dybcio <konradybcio@kernel.org>,
        Krishna Chaitanya Chundru
	<krishna.chundru@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Bjorn
 Helgaas" <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <konrad.dybcio@oss.qualcomm.com>, <quic_mrana@quicinc.com>,
        <quic_vbadigan@quicinc.com>, Bjorn Andersson
	<andersson@kernel.org>
References: <20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com>
 <20241223-preset_v2-v3-2-a339f475caf5@oss.qualcomm.com>
 <piccoomv7rx4dvvfdoesmxbzrdqz4ld6ii6neudsdf4hjj2yzm@2bcuacwa4feb>
 <d317c51a-3913-6c49-f8db-e75589f9289a@quicinc.com>
 <wjk32haduzgiea676mamqdr6mhbmm3rrb6eyhzghqpczjuiazx@ipik3jhjzmhz>
 <7bc9f3f2-851c-3703-39b4-fea93d10bd7f@quicinc.com>
 <ntag3wc3yqax2afsbzesev32hpj3ssiknhjq6dtncuuj4ljrxh@23ed4qdwfrxi>
 <49ccd5f2-8524-eba4-25ef-4cdc39edc93b@quicinc.com>
 <7busek7zgost2s7mjklgvlccaef3lgz4k7btki72nkr5et7fdn@wkv2z6zbicdj>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <7busek7zgost2s7mjklgvlccaef3lgz4k7btki72nkr5et7fdn@wkv2z6zbicdj>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0AaFtANUk3jvfTyitue3Jyi4ur8AmFpJ
X-Proofpoint-ORIG-GUID: 0AaFtANUk3jvfTyitue3Jyi4ur8AmFpJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240090



On 12/24/2024 3:25 PM, Dmitry Baryshkov wrote:
> On Tue, Dec 24, 2024 at 02:47:00PM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 12/24/2024 12:00 AM, Dmitry Baryshkov wrote:
>>> On Mon, Dec 23, 2024 at 10:13:29PM +0530, Krishna Chaitanya Chundru wrote:
>>>>
>>>>
>>>> On 12/23/2024 8:56 PM, Dmitry Baryshkov wrote:
>>>>> On Mon, Dec 23, 2024 at 08:02:23PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>
>>>>>>
>>>>>> On 12/23/2024 5:17 PM, Dmitry Baryshkov wrote:
>>>>>>> On Mon, Dec 23, 2024 at 12:21:15PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>>> PCIe equalization presets are predefined settings used to optimize
>>>>>>>> signal integrity by compensating for signal loss and distortion in
>>>>>>>> high-speed data transmission.
>>>>>>>>
>>>>>>>> As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
>>>>>>>> of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
>>>>>>>> configure lane equalization presets for each lane to enhance the PCIe
>>>>>>>> link reliability. Each preset value represents a different combination
>>>>>>>> of pre-shoot and de-emphasis values. For each data rate, different
>>>>>>>> registers are defined: for 8.0 GT/s, registers are defined in section
>>>>>>>> 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
>>>>>>>> an extra receiver preset hint, requiring 16 bits per lane, while the
>>>>>>>> remaining data rates use 8 bits per lane.
>>>>>>>>
>>>>>>>> Based on the number of lanes and the supported data rate, this function
>>>>>>>> reads the device tree property and stores in the presets structure.
>>>>>>>>
>>>>>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>      drivers/pci/of.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>>>>>>>      drivers/pci/pci.h | 17 +++++++++++++++--
>>>>>>>>      2 files changed, 60 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>>>>>>>> index dacea3fc5128..99e0e7ae12e9 100644
>>>>>>>> --- a/drivers/pci/of.c
>>>>>>>> +++ b/drivers/pci/of.c
>>>>>>>> @@ -826,3 +826,48 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
>>>>>>>>      	return slot_power_limit_mw;
>>>>>>>>      }
>>>>>>>>      EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
>>>>>>>> +
>>>>>>>
>>>>>>> kerneldoc? Define who should free the memory and how.
>>>>>>>
>>>>>> I will update this in next series.
>>>>>> as we are allocating using devm_kzalloc it should be freed on driver
>>>>>> detach, as no special freeing is required.
>>>>>>>> +int of_pci_get_equalization_presets(struct device *dev,
>>>>>>>> +				    struct pci_eq_presets *presets,
>>>>>>>> +				    int num_lanes)
>>>>>>>> +{
>>>>>>>> +	char name[20];
>>>>>>>> +	void **preset;
>>>>>>>> +	void *temp;
>>>>>>>> +	int ret;
>>>>>>>> +
>>>>>>>> +	if (of_property_present(dev->of_node, "eq-presets-8gts")) {
>>>>>>>> +		presets->eq_presets_8gts = devm_kzalloc(dev, sizeof(u16) * num_lanes, GFP_KERNEL);
>>>>>>>> +		if (!presets->eq_presets_8gts)
>>>>>>>> +			return -ENOMEM;
>>>>>>>> +
>>>>>>>> +		ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
>>>>>>>> +						 presets->eq_presets_8gts, num_lanes);
>>>>>>>> +		if (ret) {
>>>>>>>> +			dev_err(dev, "Error reading eq-presets-8gts %d\n", ret);
>>>>>>>> +			return ret;
>>>>>>>> +		}
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	for (int i = 1; i < sizeof(struct pci_eq_presets) / sizeof(void *); i++) {
>>>>>>>> +		snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << i);
>>>>>>>> +		if (of_property_present(dev->of_node, name)) {
>>>>>>>> +			temp = devm_kzalloc(dev, sizeof(u8) * num_lanes, GFP_KERNEL);
>>>>>>>> +			if (!temp)
>>>>>>>> +				return -ENOMEM;
>>>>>>>> +
>>>>>>>> +			ret = of_property_read_u8_array(dev->of_node, name,
>>>>>>>> +							temp, num_lanes);
>>>>>>>> +			if (ret) {
>>>>>>>> +				dev_err(dev, "Error %s %d\n", name, ret);
>>>>>>>> +				return ret;
>>>>>>>> +			}
>>>>>>>> +
>>>>>>>> +			preset = (void **)((u8 *)presets + i * sizeof(void *));
>>>>>>>
>>>>>>> Ugh.
>>>>>>>
>>>>>> I was trying iterate over each element on the structure as presets holds the
>>>>>> starting address of the structure and to that we are adding size of the void
>>>>>> * point to go to each element. I did this way to reduce the
>>>>>> redundant code to read all the gts which has same way of storing the data
>>>>>> from the device tree. I will add comments here in the next series.
>>>>>
>>>>> Please rewrite this in a cleaner way. The code shouldn't raise
>>>>> questions.
>>>>>
>>>>>>>> +			*preset = temp;
>>>>>>>> +		}
>>>>>>>> +	}
>>>>>>>> +
>>>>>>>> +	return 0;
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
>>>>>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>>>>>> index 14d00ce45bfa..82362d58bedc 100644
>>>>>>>> --- a/drivers/pci/pci.h
>>>>>>>> +++ b/drivers/pci/pci.h
>>>>>>>> @@ -731,7 +731,12 @@ static inline u64 pci_rebar_size_to_bytes(int size)
>>>>>>>>      }
>>>>>>>>      struct device_node;
>>>>>>>> -
>>>>>>>> +struct pci_eq_presets {
>>>>>>>> +	void *eq_presets_8gts;
>>>>>>>> +	void *eq_presets_16gts;
>>>>>>>> +	void *eq_presets_32gts;
>>>>>>>> +	void *eq_presets_64gts;
>>>>>>>
>>>>>>> Why are all of those void*? 8gts is u16*, all other are u8*.
>>>>>>>
>>>>>> To have common parsing logic I moved them to void*, as these are pointers
>>>>>> actual memory is allocated by of_pci_get_equalization_presets()
>>>>>> based upon the gts these should not give any issues.
>>>>>
>>>>> Please, don't. They have types. void pointers are for the opaque data.
>>>>>
>>>> ok.
>>>>
>>>> I think then better to use v1 patch
>>>> https://lore.kernel.org/all/20241116-presets-v1-2-878a837a4fee@quicinc.com/
>>>>
>>>> konrad, any objection on using v1 as that will be cleaner way even if we
>>>> have some repetitive code.
>>>
>>> Konrad had a nice suggestion about using the array of values. Please use
>>> such an array for 16gts and above. This removes most of repetitive code.
>>>
>> I don't feel having array in the preset structure looks good, I have
>> come up with this logic if you feel it is not so good I will go to the
>> suggested way by having array for 16gts and above.
>>
>>         if (of_property_present(dev->of_node, "eq-presets-8gts")) {
>>                  presets->eq_presets_8gts = devm_kzalloc(dev, sizeof(u16) *
>> num_lanes, GFP_KERNEL);
>>                  if (!presets->eq_presets_8gts)
>>                          return -ENOMEM;
>>
>>                  ret = of_property_read_u16_array(dev->of_node,
>> "eq-presets-8gts",
>>
>> presets->eq_presets_8gts, num_lanes);
>>                  if (ret) {
>>                          dev_err(dev, "Error reading eq-presets-8gts %d\n",
>> ret);
>>                          return ret;
>>                  }
>>          }
>>
>>          for (int i = EQ_PRESET_TYPE_16GTS; i < EQ_PRESET_TYPE_64GTS; i++) {
>>                  snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << i);
>>                  if (of_property_present(dev->of_node, name)) {
>>                          temp = devm_kzalloc(dev, sizeof(u8) * num_lanes,
>> GFP_KERNEL);
>>                          if (!temp)
>>                                  return -ENOMEM;
>>
>>                          ret = of_property_read_u8_array(dev->of_node, name,
>>                                                          temp, num_lanes);
>>                          if (ret) {
>>                                  dev_err(dev, "Error %s %d\n", name, ret);
>>                                  return ret;
>>                          }
>>
>>                          switch (i) {
>>                                  case EQ_PRESET_TYPE_16GTS:
>>                                          presets->eq_presets_16gts = temp;
>>                                          break;
>>                                  case EQ_PRESET_TYPE_32GTS:
>>                                          presets->eq_presets_32gts = temp;
>>                                          break;
>>                                  case EQ_PRESET_TYPE_64GTS:
>>                                          presets->eq_presets_64gts = temp;
>>                                          break;
>>                          }
> 
> This looks like 'presets->eq_presets[i] = temp;', but I won't insist on
> that.
> 
> Also, a strange thought came to my mind: we know that there won't be
> more than 16 lanes. Can we have the following structure instead:
> 
> #define MAX_LANES 16
> enum pcie_gts {
> 	PCIE_GTS_16GTS,
> 	PCIE_GTS_32GTS,
> 	PCIE_GTS_64GTS,
> 	PCIE_GTS_MAX,
> };
> struct pci_eq_presets {
> 	u16 eq_presets_8gts[MAX_LANES];
> 	u8 eq_presets_Ngts[PCIE_GTS_MAX][MAX_LANES];
> };
> 
> This should allow you to drop the of_property_present() and
> devm_kzalloc(). Just read DT data into a corresponding array.
> 
in the dwc driver patch I was using pointers and memory allocation
to known if the property is present or not. If I use this way I might
end up reading dt property again. I think better to switch to have a
array for above 16gts.

- Krishna Chaitanya.
>>                  }
>>          }
>> - Krishna Chaitanya.
>>
>>>
> 

