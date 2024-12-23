Return-Path: <linux-pci+bounces-18971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315499FB02C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 15:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E97816B9A8
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E828E1B3948;
	Mon, 23 Dec 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g/+Z1gGk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F91B3929;
	Mon, 23 Dec 2024 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964368; cv=none; b=T3zViTneYi7aKZGL/fAJ4Xj3csMT9d0uf1VvZeiTaeYkCUES1MBuHENG/tGbUurv5DbN4Pk+0E0Y609f2kKw7IAPA8RzGRFLf+LM2ixzPaWi+SWujhVI8XbMB7KHtXar/yl+fwXZS5XxUAAS+7FVWV0q/U5Nlvhu0RNSCjSoFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964368; c=relaxed/simple;
	bh=cTsolYltWuYKBh+2FKGBUJVLIxqagqNe4+UBZFb+jeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k7kOYFQpa5cuphAC9xjQZLK1AknBJTK3YovXMj50ycsbpKBgkSoSudfMdFhtsCT6yBj4STzrB/i+7A546NSqWDBWyf1LrTtj5/cnNipEB2FfRAS8ncR0AuSGW/pcimsA4WCqgVORYTIUyd0F+sWJ2nIBejv1aruOMPVk5uw+mXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g/+Z1gGk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BN9TQ9q019745;
	Mon, 23 Dec 2024 14:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gZ+KzYl49hHTpFkqIHUSLaFZP2QFO+hk+TL11BAvvXM=; b=g/+Z1gGkd20f56no
	maYu/0/dY4vvm3qEl2jjSNI4Yqk1q8Y3DV9EVy5hC6NTXgXsub3/QwTWgo8Fej8+
	UefxsRXJHr3j0mq595HatTtVfV1sq//k8qJRFGlwld+e2NcUpSyqwUVzBr1KErq8
	dI0nsgfd2VKKlm+pBy49n3An5SXuxI89g7jGkmhisOkp4qxtbpcJL31D3QHNSfdg
	SAhgW5//8ZJAPUvnvXu+eImcVWAGPqkHx2EZtde1pwy5iA4mAv2IsyoBIz1xX9QY
	B5CzSA4Np16ZiHO+Okq4qWz9YGbz/y4b8P5QCSrsgy9IPNm5o9eWIbkDrCIWFP1o
	kptbeg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43nn8vs80y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 14:32:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BNEWZnc024675
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 14:32:35 GMT
Received: from [10.216.2.152] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Dec
 2024 06:32:27 -0800
Message-ID: <d317c51a-3913-6c49-f8db-e75589f9289a@quicinc.com>
Date: Mon, 23 Dec 2024 20:02:23 +0530
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
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krishna Chaitanya Chundru
	<krishna.chundru@oss.qualcomm.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
	<kw@linux.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <konrad.dybcio@oss.qualcomm.com>, <quic_mrana@quicinc.com>,
        <quic_vbadigan@quicinc.com>, Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20241223-preset_v2-v3-0-a339f475caf5@oss.qualcomm.com>
 <20241223-preset_v2-v3-2-a339f475caf5@oss.qualcomm.com>
 <piccoomv7rx4dvvfdoesmxbzrdqz4ld6ii6neudsdf4hjj2yzm@2bcuacwa4feb>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <piccoomv7rx4dvvfdoesmxbzrdqz4ld6ii6neudsdf4hjj2yzm@2bcuacwa4feb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SHLgLfs82H1EkOOAjFXyOIGPjUaGK4Gk
X-Proofpoint-ORIG-GUID: SHLgLfs82H1EkOOAjFXyOIGPjUaGK4Gk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412230131



On 12/23/2024 5:17 PM, Dmitry Baryshkov wrote:
> On Mon, Dec 23, 2024 at 12:21:15PM +0530, Krishna Chaitanya Chundru wrote:
>> PCIe equalization presets are predefined settings used to optimize
>> signal integrity by compensating for signal loss and distortion in
>> high-speed data transmission.
>>
>> As per PCIe spec 6.0.1 revision section 8.3.3.3 & 4.2.4 for data rates
>> of 8.0 GT/s, 16.0 GT/s, 32.0 GT/s, and 64.0 GT/s, there is a way to
>> configure lane equalization presets for each lane to enhance the PCIe
>> link reliability. Each preset value represents a different combination
>> of pre-shoot and de-emphasis values. For each data rate, different
>> registers are defined: for 8.0 GT/s, registers are defined in section
>> 7.7.3.4; for 16.0 GT/s, in section 7.7.5.9, etc. The 8.0 GT/s rate has
>> an extra receiver preset hint, requiring 16 bits per lane, while the
>> remaining data rates use 8 bits per lane.
>>
>> Based on the number of lanes and the supported data rate, this function
>> reads the device tree property and stores in the presets structure.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/of.c  | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci.h | 17 +++++++++++++++--
>>   2 files changed, 60 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index dacea3fc5128..99e0e7ae12e9 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -826,3 +826,48 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
>>   	return slot_power_limit_mw;
>>   }
>>   EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
>> +
> 
> kerneldoc? Define who should free the memory and how.
> 
I will update this in next series.
as we are allocating using devm_kzalloc it should be freed on driver
detach, as no special freeing is required.
>> +int of_pci_get_equalization_presets(struct device *dev,
>> +				    struct pci_eq_presets *presets,
>> +				    int num_lanes)
>> +{
>> +	char name[20];
>> +	void **preset;
>> +	void *temp;
>> +	int ret;
>> +
>> +	if (of_property_present(dev->of_node, "eq-presets-8gts")) {
>> +		presets->eq_presets_8gts = devm_kzalloc(dev, sizeof(u16) * num_lanes, GFP_KERNEL);
>> +		if (!presets->eq_presets_8gts)
>> +			return -ENOMEM;
>> +
>> +		ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
>> +						 presets->eq_presets_8gts, num_lanes);
>> +		if (ret) {
>> +			dev_err(dev, "Error reading eq-presets-8gts %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	for (int i = 1; i < sizeof(struct pci_eq_presets) / sizeof(void *); i++) {
>> +		snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << i);
>> +		if (of_property_present(dev->of_node, name)) {
>> +			temp = devm_kzalloc(dev, sizeof(u8) * num_lanes, GFP_KERNEL);
>> +			if (!temp)
>> +				return -ENOMEM;
>> +
>> +			ret = of_property_read_u8_array(dev->of_node, name,
>> +							temp, num_lanes);
>> +			if (ret) {
>> +				dev_err(dev, "Error %s %d\n", name, ret);
>> +				return ret;
>> +			}
>> +
>> +			preset = (void **)((u8 *)presets + i * sizeof(void *));
> 
> Ugh.
> 
I was trying iterate over each element on the structure as presets holds 
the starting address of the structure and to that we are adding size of 
the void * point to go to each element. I did this way to reduce the
redundant code to read all the gts which has same way of storing the 
data from the device tree. I will add comments here in the next series.
>> +			*preset = temp;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 14d00ce45bfa..82362d58bedc 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -731,7 +731,12 @@ static inline u64 pci_rebar_size_to_bytes(int size)
>>   }
>>   
>>   struct device_node;
>> -
>> +struct pci_eq_presets {
>> +	void *eq_presets_8gts;
>> +	void *eq_presets_16gts;
>> +	void *eq_presets_32gts;
>> +	void *eq_presets_64gts;
> 
> Why are all of those void*? 8gts is u16*, all other are u8*.
> 
To have common parsing logic I moved them to void*, as these are 
pointers actual memory is allocated by of_pci_get_equalization_presets()
based upon the gts these should not give any issues.
>> +};
> 
> Empty lines before and after the struct definition.
> 
ack.

- Krishna Chaitanya.
>>   #ifdef CONFIG_OF
>>   int of_pci_parse_bus_range(struct device_node *node, struct resource *res);
>>   int of_get_pci_domain_nr(struct device_node *node);
>> @@ -746,7 +751,9 @@ void pci_set_bus_of_node(struct pci_bus *bus);
>>   void pci_release_bus_of_node(struct pci_bus *bus);
>>   
>>   int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge);
>> -
>> +int of_pci_get_equalization_presets(struct device *dev,
>> +				    struct pci_eq_presets *presets,
>> +				    int num_lanes);
> 
> Keep the empty line.
> 
>>   #else
>>   static inline int
>>   of_pci_parse_bus_range(struct device_node *node, struct resource *res)
>> @@ -793,6 +800,12 @@ static inline int devm_of_pci_bridge_init(struct device *dev, struct pci_host_br
>>   	return 0;
>>   }
>>   
>> +static inline int of_pci_get_equalization_presets(struct device *dev,
>> +						  struct pci_eq_presets *presets,
>> +						  int num_lanes)
>> +{
>> +	return 0;
>> +}
>>   #endif /* CONFIG_OF */
>>   
>>   struct of_changeset;
>>
>> -- 
>> 2.34.1
>>
> 

