Return-Path: <linux-pci+bounces-24909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CDDA74345
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 06:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182DD1887CFA
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 05:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7D7201039;
	Fri, 28 Mar 2025 05:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dQpQ2U9Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9291C8FB4
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 05:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743139476; cv=none; b=LcMtY4X4afOnONJ0QEVFX5/wDBAsocJUyFvXi8Z+VjA3xD97yznUfO8TVr9FQPveRXrGyzabGmY6zb9+nRPRZvSzH9ohl6GtYuuuPiaUP3f2AwUj63jejeBvS+LNEqpWV0vepcrbmqLrqixdzN0Ge/02eN+jcBYJE37RMeItD+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743139476; c=relaxed/simple;
	bh=hKwE0aVj7IxvPgqbug4g8fwgNRQS3t1i+9RqDv29W3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRHKuSoLjLq++WuLXRLnUiaroVg0f0/gGU87pBBGkE35pN0aIg/72+E2JOh6SwNXAgC98fAhPLHLDo6jDhAlhbU21TdbLA9nuOJ0mZ33SKg5tIx0yPkUTHmsLjMmScScW1GhIUptpZneDVnLUVv2eF+LKD6qbrveoMefp+Zn+n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dQpQ2U9Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RFOsBx005967
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 05:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QSK0TFoPYN4H7p8t4mXqY9o9fUEjdQFFbsNmfIJdZ1g=; b=dQpQ2U9Y2CX//k4l
	gx8DBLqDIuov7liNgOfVdZtMJt6yvqOw4TdP4KqswW8V8Ka7LUZ9nY5CJfRiawUo
	ZnE8y5wti0LeBjeM62+HgBC3sfJDq8MhY9dq/yPOkN/TTO0cLusKIHq9KkiVlWWe
	DOO5urZAdMcdgQK6/MISwmfUvL7ATeFtTWEc0mpF1IzETczZCSLXydCxzoZZWkLy
	V0Cip2AnVX+UJGjieF3BJj9omLDUo0L+9vid4rf531lW+3Ax051rSA2LqKbeUUet
	Kmxu+1thsu/9P98x46dh4aLFeVDGZzGx8HggVSjgbs+Liu6BrY3Cf8fK5jkZa46T
	tYvhCg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45m7nf7fnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 05:24:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-304cf76fd6aso3292029a91.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 22:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743139473; x=1743744273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QSK0TFoPYN4H7p8t4mXqY9o9fUEjdQFFbsNmfIJdZ1g=;
        b=A4KNAiGjQ9AQ9Jj9ihpcSU9fNS0Nk4xoYXw47rHey91E4nEy7XHkHBiOSIAAXfEkS6
         6uuRaAyv0gvYSHqqak+J1SbQaZwPbnlQZYaOaB3gNKtF/71oxPW6KeAfzo4ic0UJpB+5
         vBYwxt4SPC59kYiB0xMNI/HhPcz/z+XCoLXsVPL63mNN0E+MGgTcxrQDkWeZWGmKmEGw
         MlPNJ8qVrMnCEKtFzfN2RZP9U/peVnXAeU+caDO1tYHs7ocqZs1O6Plomq4FeZAOeVbj
         hhd56SWwdifaQMKdyOSNoENbUxF6gy9B8ofCg2kubtZMMzLJMlIAgPgS2NLekCkopjU4
         4cng==
X-Forwarded-Encrypted: i=1; AJvYcCX/pN5S6/rs3oxHlkgdQOydhxapw9A2s0aYJffg8DbGX1d44M0r98stPqlvkiGgK1ROSkj4BrtKjnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSKIyfHi9FLtwEqjJEbEe40UWTGfWTNGZa6GiMN4dCDf883XyJ
	MtMDlDvDxdZqCEvagO/wDqT9vAYUzY8GTrND+tRA5qWYXQT5wz5y7SQrWWdr4eEIQnCvHz83T5b
	KriGcm9XoVgtPXtZRJ+QmWUaMMlrfn3pCb63TSgxRhmO2HHRm6rqTOXbUQ+o=
X-Gm-Gg: ASbGnct9sGmL2/rQKTjSFVJ+8TU9X1dKEwH6WslkT69UC+h12a6AHn9JlZO9XXqv50w
	PDw/MvVXB+gWRfbuCO325zNdGf/flWUzLvSyBLO3VH1xewmT8ut91UvZSv+IkM222XXNR4PVljx
	xmKnYWDBZSpngqUbFpj6L7idjOkoFqHfO6lzBk9UFq7on/a0lgFNzwjC7Tb2UsJbsDfeW+Tp1+u
	jpfZ//QBjsScRZTGNcfFXRvB5RxuDXm6GOgw1Ck9JEGs1ToHdiRRs++81ufwIB5kYVBdmQmznrb
	WbPMiN9JakMm+iNNZsNtD/KkEVI3GuczvLp8ASh7yZ9Fiw==
X-Received: by 2002:a05:6a20:a108:b0:1fa:9819:b064 with SMTP id adf61e73a8af0-1fea2d70237mr12642142637.18.1743139472666;
        Thu, 27 Mar 2025 22:24:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ6Ufty4NvxamcgmWJLeaXvoKya4Z1DfFIgAAvJV3k/9x3mn97U7mCVnp7j3hgm0R0G+mdyg==
X-Received: by 2002:a05:6a20:a108:b0:1fa:9819:b064 with SMTP id adf61e73a8af0-1fea2d70237mr12642107637.18.1743139472118;
        Thu, 27 Mar 2025 22:24:32 -0700 (PDT)
Received: from [10.92.192.202] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93ba1b22bsm795906a12.77.2025.03.27.22.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 22:24:31 -0700 (PDT)
Message-ID: <7a0724ad-89a5-0ccd-eba5-ca4871ce1cdd@oss.qualcomm.com>
Date: Fri, 28 Mar 2025 10:54:25 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v8 2/4] PCI: of: Add of_pci_get_equalization_presets() API
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?=
 <kw@linux.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
References: <20250316-preset_v6-v8-0-0703a78cb355@oss.qualcomm.com>
 <20250316-preset_v6-v8-2-0703a78cb355@oss.qualcomm.com>
 <gl2klkvpkb2vrxrzdqbqjomfis66tldy6witvbqdd2ig3st3rw@jstguoejcofa>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <gl2klkvpkb2vrxrzdqbqjomfis66tldy6witvbqdd2ig3st3rw@jstguoejcofa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UcM5gCzgdYk80NPl8ime8LMxCRjQPuV7
X-Proofpoint-GUID: UcM5gCzgdYk80NPl8ime8LMxCRjQPuV7
X-Authority-Analysis: v=2.4 cv=IMMCChvG c=1 sm=1 tr=0 ts=67e63291 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=wBt9fhMRhOodALO6grUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503280035



On 3/28/2025 10:09 AM, Manivannan Sadhasivam wrote:
> On Sun, Mar 16, 2025 at 09:39:02AM +0530, Krishna Chaitanya Chundru wrote:
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
>> Based on the number of lanes and the supported data rate,
>> of_pci_get_equalization_presets() reads the device tree property and
>> stores in the presets structure.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/of.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci.h | 32 +++++++++++++++++++++++++++++++-
>>   2 files changed, 75 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 7a806f5c0d20..18691483e108 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -851,3 +851,47 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
>>   	return slot_power_limit_mw;
>>   }
>>   EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
>> +
>> +/**
>> + * of_pci_get_equalization_presets - Parses the "eq-presets-Ngts" property.
>> + *
>> + * @dev: Device containing the properties.
>> + * @presets: Pointer to store the parsed data.
>> + * @num_lanes: Maximum number of lanes supported.
>> + *
>> + * If the property is present, read and store the data in the @presets structure.
>> + * Else, assign a default value of PCI_EQ_RESV.
>> + *
>> + * Return: 0 if the property is not available or successfully parsed else
>> + * errno otherwise.
>> + */
>> +int of_pci_get_equalization_presets(struct device *dev,
>> +				    struct pci_eq_presets *presets,
>> +				    int num_lanes)
>> +{
>> +	char name[20];
>> +	int ret;
>> +
>> +	presets->eq_presets_8gts[0] = PCI_EQ_RESV;
>> +	ret = of_property_read_u16_array(dev->of_node, "eq-presets-8gts",
>> +					 presets->eq_presets_8gts, num_lanes);
>> +	if (ret && ret != -EINVAL) {
>> +		dev_err(dev, "Error reading eq-presets-8gts :%d\n", ret);
> 
> 'Error reading eq-presets-8gts: %d'
> 
>> +		return ret;
>> +	}
>> +
>> +	for (int i = 0; i < EQ_PRESET_TYPE_MAX - 1; i++) {
>> +		presets->eq_presets_Ngts[i][0] = PCI_EQ_RESV;
>> +		snprintf(name, sizeof(name), "eq-presets-%dgts", 8 << (i + 1));
>> +		ret = of_property_read_u8_array(dev->of_node, name,
>> +						presets->eq_presets_Ngts[i],
>> +						num_lanes);
>> +		if (ret && ret != -EINVAL) {
>> +			dev_err(dev, "Error reading %s :%d\n", name, ret);
> 
> 'Error reading %s: %d'
> 
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(of_pci_get_equalization_presets);
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index 01e51db8d285..78c9cc0ad8fa 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -9,6 +9,8 @@ struct pcie_tlp_log;
>>   /* Number of possible devfns: 0.0 to 1f.7 inclusive */
>>   #define MAX_NR_DEVFNS 256
>>   
>> +#define MAX_NR_LANES 16
> 
> Why did you limit to 16?
> 
As per PCIe spec we support maximum of 16 lanes only right

- Krishna Chaitanya.
> - Mani
> 

