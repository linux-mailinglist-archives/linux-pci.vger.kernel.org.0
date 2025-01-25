Return-Path: <linux-pci+bounces-20357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7D5A1C358
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 13:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A627A3793
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 12:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EBC20765E;
	Sat, 25 Jan 2025 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FiqXKMm0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C881FC7C3
	for <linux-pci@vger.kernel.org>; Sat, 25 Jan 2025 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737809515; cv=none; b=iNaWa3bzaWnNX/IVoPOdnkGKpgzmYOuJR0VI1i1r5BPUc6M0ssdrZu+uY4katzQ6/JpiXTrTNHdxmtCR9BJSla+sTPw1cLAd8Ad4Id/wAqNUV6Ieg06LQKEZzTKDqnzpMHJRP383qIEcLwIdOpRV3+HeHZbRQhEOThLBmd/cNZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737809515; c=relaxed/simple;
	bh=86QVJcp7+Wpb1h56kTcVv3nN2lg8fSxxUT5DE2OEIwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWLp7Phw7O++SgAwhpsA0d+zdwQkCE6NXdEZT2NYKQESIcg0ntLKWB2CqWVz8kb3ZZkv8MK3zaDI+/hIXrmsv5Dt/klD9ipNAtydTcTIJJgpa7npnprlXSzXLnFVVLPhLgIvcqOyACX7VQfOmRp1XztHuxUxJqV6CN6FuuDAb4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FiqXKMm0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50PCbVVc000870
	for <linux-pci@vger.kernel.org>; Sat, 25 Jan 2025 12:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CWziA7aUdOr4gS8lvvWsqKbJ5Nzxb5TboxzkZ56gBtY=; b=FiqXKMm0wQShkz4q
	nOQOWrda0vMsz9UXlynj2imlecUhsyfA1AjKKzT3TfpIxHFKnosRakQogRolApnR
	Xc7AFDFACBEcQiL3Qzn2EGKmKChuLRcbU2Me8JrpxfKD07cAJhGjzhfWDbYppVxz
	g4hZUpmT0Q2DxCkKsEJMroa2HYdPtZYYD95fx+cNKE90FRjrcc/69UFwxQkxqPtm
	ysIalOZnBlYjLA9bIGTCfZ691n4lghATUUNTfkU/XxIx4O4V7MEojXvGZ+WPGQm8
	DEfYY8eF+JLXpCIp7FbR/75htxmWemu0F1QgbA+b0iaNqpBRP70Oc1i0d+XO2z9w
	A8bL+g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44cryr8gph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Sat, 25 Jan 2025 12:51:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e5c3a933so47991685a.3
        for <linux-pci@vger.kernel.org>; Sat, 25 Jan 2025 04:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737809511; x=1738414311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWziA7aUdOr4gS8lvvWsqKbJ5Nzxb5TboxzkZ56gBtY=;
        b=wlfu8GK1qzHPbGweujkNiQjV8Wn2dQhJyHJAOLp+nMlsbVfxOPhbE8kgYIyU7sukH4
         wo1Ksjz5dPHSfxv8KciIBIo+MOldFeyDeV9KIgo9h6mDGAkB33WbxVB82WB6N9ZOV2Ju
         V090i98KSDdBF6c8igOGlx+1ivHAN9El2/6u6hLZgkeHOoVf0HGEc4hmAqLwu7Ix44Ou
         KU9qJHMRDEjEBHpU6xCy00AwH8iEzrdfDhUBTxZWCxYl1SWBRN8c3MpDGK0E0z4OO7FX
         LY0KkZTcwXh9fA0J9xL2ocDiH6jSI50TUfdsRMlpewdkrDv1c0/72gsyteRIqA1lRRYU
         4X0g==
X-Forwarded-Encrypted: i=1; AJvYcCXxnVxty36IUNCxC2tAUmDZgeYZKMxGDQnmRj9rgSP9N36huy/s0IzJmD6q0xlupMjQtWCA0wModNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyehRzb8HAZh5ixiNdCLJv1ajVm2S4CqBtpsCWbn5/sQ345tVcr
	FZw5/VfH9tFfvHjTCQQEjqXu54itwSrK0oBTuvEav3NDMfGVtfSlsUUbOQtka3Fy/moWF8VxSNT
	NBeB4Omz6abzRUR9rzeCxOeQtTrxq6oe0vsqviCdrDsi+mFGjpFMry/do77o=
X-Gm-Gg: ASbGncvhJRNdmm0+ZoCjcqcfBDttB7HZ65TR1jRQ7T1kKYGMsUBTw1DUiSf8eq1EaRg
	CufhPpzRPUDn8PDRkJOw/Ifc61Fe76i0HT/L3vsD00Qcsx9RCim6E06jhTh+bquUAf944umP9jm
	ghIjv8s/9TkfmtIEB0fAJ+GaQmPAB+5KW1QRHRx+3LUTT/jzENDgUZZjzMOWi2Bpq0XGkJCMnTh
	M/MPG9g3w+n/4TjHvbHWrpecdveUsrMr+pgQf6O1I4BYbv2bGSf49zOaIotFbDjFQupmlvtJqjW
	7rbSYVZgvOmFQf60rF77KblRm2E1eKZG57oyHEYbqT2oHyI4GwbbP4+g2bU=
X-Received: by 2002:a05:620a:450e:b0:7b6:dc5c:de5 with SMTP id af79cd13be357-7be631e6b5emr2052213785a.1.1737809511545;
        Sat, 25 Jan 2025 04:51:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+UQrv1kM0ZKAZiqODKXjGLwGCixqQRdnXMHLQHxrdyBaXBM/t1cXrqvIOKkD+dJIF7eR9gA==
X-Received: by 2002:a05:620a:450e:b0:7b6:dc5c:de5 with SMTP id af79cd13be357-7be631e6b5emr2052211885a.1.1737809511100;
        Sat, 25 Jan 2025 04:51:51 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc18640df4sm2507590a12.48.2025.01.25.04.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2025 04:51:49 -0800 (PST)
Message-ID: <653c86f8-30d3-4ffe-aa2d-ffb37b7b5bb2@oss.qualcomm.com>
Date: Sat, 25 Jan 2025 13:51:46 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] PCI: of: Add API to retrieve equalization presets
 from device tree
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250124-preset_v2-v4-0-0b512cad08e1@oss.qualcomm.com>
 <20250124-preset_v2-v4-2-0b512cad08e1@oss.qualcomm.com>
 <79281aca-c275-4055-8d2c-d2407b0f9811@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <79281aca-c275-4055-8d2c-d2407b0f9811@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JQD26N2yEB0d2EomTQiarbkzrj-2_s_a
X-Proofpoint-ORIG-GUID: JQD26N2yEB0d2EomTQiarbkzrj-2_s_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_05,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501250093

On 25.01.2025 1:47 PM, Konrad Dybcio wrote:
> On 24.01.2025 12:22 PM, Krishna Chaitanya Chundru wrote:
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
>>  drivers/pci/of.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/pci.h | 24 +++++++++++++++++++++++-
>>  2 files changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index dacea3fc5128..7aa17c0042c5 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -826,3 +826,50 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
>>  	return slot_power_limit_mw;
>>  }
>>  EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
>> +
>> +/**
>> + * of_pci_get_equalization_presets - Parses the "eq-presets-ngts" property.
>> + *
>> + * @dev: Device containing the properties.
>> + * @presets: Pointer to store the parsed data.
>> + * @num_lanes: Maximum number of lanes supported.
>> + *
>> + * If the property is present read and store the data in the preset structure
>> + * assign default value 0xff to indicate property is not present.
>> + *
>> + * If the property is not found or is invalid, returns 0.
>> + */
>> +int of_pci_get_equalization_presets(struct device *dev,
>> +				    struct pci_eq_presets *presets,
>> +				    int num_lanes)
>> +{
>> +	char name[20];
>> +	int ret;
>> +
>> +	presets->eq_presets_8gts[0] = 0xff;

Also please #define 0xff as a reserved value

Konrad

>> +	if (of_property_present(dev->of_node, "eq-presets-8gts")) {
>> +		ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
>> +						 presets->eq_presets_8gts, num_lanes);
>> +		if (ret) {
>> +			dev_err(dev, "Error reading eq-presets-8gts %d\n", ret);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	for (int i = 0; i < EQ_PRESET_TYPE_MAX; i++) {
>> +		presets->eq_presets_Ngts[i][0] = 0xff;
>> +		snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << (i + 1));
>> +		if (of_property_present(dev->of_node, name)) {
> 
> of_property_count_u8_elems returns -EINVAL if the property does not exist
> 
> you can then drop a level of indentation:
> 
> ret = of_property_read_u8_array...;
> if (ret == -EINVAL) {
> 	continue;
> } else {
> 	...
> }
> 
> 
> similarly above for 8gts
> 
> Konrad

