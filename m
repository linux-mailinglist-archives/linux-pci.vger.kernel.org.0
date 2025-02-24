Return-Path: <linux-pci+bounces-22155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D5A415EF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246961884185
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0009723FC66;
	Mon, 24 Feb 2025 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G+MClCNk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760E20B20A
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380698; cv=none; b=jPoTRVK+kAfTGMW0bpTNWsvl3LRBT4IzOoWoCNlHafy8c5o4cSnCnAob0LBS7rg7FDtchBZCA31PKeqOr1GU9xOW3xsCX/asFNfviP8JPt1X0QVGrVLWUA38w7kQrnjHH0B+mMwk9Ahw9iCyETuaCPLYFm7XdZIQ5oyFR5u7R80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380698; c=relaxed/simple;
	bh=y/1clNCL+NS++oBFmjRbg2CcgwGbN/lxf2/nF53Ef0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/ug7ZwYfFG2FNf/aJEycHYPYqhjwo8PsICPxkQjmwC6vtlNR35nWj30s/YENREVy5e2tNGV0tF79P4l0vJYaVhBwp37fKYk+BRJ30frqB3I8z8gPP5VEY7vF9MTy9Onsb/QPKHOK6ZgMOMoReae9JNceYKE8pJMQFtACDbIibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G+MClCNk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51NNUTcW013984
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 07:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5WIheLZ9opmWJFXhXFIzA03DR/ItI8HoBk7UEWH8SJg=; b=G+MClCNkjb73xwPw
	ZEXpm+ckL5qkTNXzC3PmPQFZtYMluGUvm+kQflVTHB+UYxZBi9uTpL/P5P6WMgVG
	ahgA+BN/8G7MAIBepOEJi3ifu5POvQxIdBQdIsQSDf6g5GOt95lIIBbX4imqdAFO
	Xp+B4DZsUmZ3RnCvseDhMmjxui32qVBGdO7KG6a0jyh+osWLZLS2c0efHGCZxEgO
	4Rp7cc5cy1JbafIdIAlx3TFtsCPG4VizQEPJmtwEfpIidSFhXyRV0dRTjDYsJNke
	hwynB0Au8EXSOgOC+9d2wZ2UVsRaSAHLPtPpTMS2u9zL8YLVB180kAb0Mc9SDEw7
	r7/+9w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y65xux0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2025 07:04:54 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220f87a2800so135838585ad.0
        for <linux-pci@vger.kernel.org>; Sun, 23 Feb 2025 23:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740380693; x=1740985493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5WIheLZ9opmWJFXhXFIzA03DR/ItI8HoBk7UEWH8SJg=;
        b=nQNpyxKkmNEoB8QKYTyBZ474N5So3SKOXC3TXVxo8K6WgsN+OQkxDA8p1Q2V0aaqwU
         wE9kl95EWpSxCagHgHfFAWK13frwWd0TN6bf4WevOdnNeyVQOyil1ZA/RhcSzqqWHFdY
         AGFPA+AhbhlVPQJ5b8KPbJxh+0o5fpB0mGqfDZBGfrTTAzHq1EUBgMUicqwDdhBJmmu3
         FFNQQAAOIHzIkL7JcE06Cysr/2QJZUupJde/SfY/MuxjmnmO4Pw04EyICWGxc9brh/4o
         2QuhwEO8z0DKRJ27cHOMe2uIVvFjSgrF0mG5lRUousdcHswCHR1pzb1hdlWGgGQkoLQy
         w0pw==
X-Forwarded-Encrypted: i=1; AJvYcCUNV2EwRa1oASPkPeWOzWTJTn/fzbFD0RPNZf8N3p5rSn+rsdBr4iIjbBd9yS7Y/WLxjwcVo7/IEZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpuoWFf0bnDTJjqNKbmjJiKabEpVCCyqKh0xCutayUaQhm8Z4x
	J4UmKBLPuep7Aaee7/5kForvzgk07vJufb26PoKKTI12sGIHtWzsi0isp7npmi6zHAcfJkYQbKJ
	X+OYweaAZYLfVpyqsddlgYoCmZJ4fTfSLC0TvBJmdnUFtWFRScFCfrOV/BAw=
X-Gm-Gg: ASbGnctrn0MvQMrMhy1J8vPVfAijGVaExfCMPdvOaoTIXfGfSoOzk/3bPwKjdcg+wmi
	+Rp1GOPWtcValnV0Hn5+TfIze3aulVdA/vHkT1EbT3/MXY2Cg+V7MWiwa0wF/Hip0xgk6o8Rwt8
	vbvgTZeChngX+AB5NUXLOhnIxzihtMo9TGWcK7YmR8WGdlhAVe73m2VxWbzFHIfy8oAcLo+fqs5
	lC4F1CxXHmEHYBYAdAAV2ZBdF9Q3H+NB5Iy+XkxStInS6VY91Le1FzM7rscbItAD4tOj3LgYd7l
	vWOfGnV0ZDMCiBkgJQeDLKpRgRawSZciSflnPTCGf1Wt
X-Received: by 2002:a17:902:b205:b0:220:ff3f:6cbc with SMTP id d9443c01a7336-221a1148e8emr150628055ad.34.1740380693157;
        Sun, 23 Feb 2025 23:04:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb5MhpjJCIMzKcXsJRwIio6H1DsGvFgoeETQaOrh0qyse+TUhBysl2xMdsD1dadgJePi5zyg==
X-Received: by 2002:a17:902:b205:b0:220:ff3f:6cbc with SMTP id d9443c01a7336-221a1148e8emr150627665ad.34.1740380692729;
        Sun, 23 Feb 2025 23:04:52 -0800 (PST)
Received: from [10.92.199.34] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55866ecsm173253775ad.212.2025.02.23.23.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 23:04:52 -0800 (PST)
Message-ID: <c5bee42e-f914-7fd7-6c72-6c9e760733a3@oss.qualcomm.com>
Date: Mon, 24 Feb 2025 12:34:45 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 4/4] PCI: dwc: Add support for configuring lane
 equalization presets
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
References: <20250210-preset_v6-v6-0-cbd837d0028d@oss.qualcomm.com>
 <20250210-preset_v6-v6-4-cbd837d0028d@oss.qualcomm.com>
 <20250214093414.pvx6nab7ewy4nvzb@thinkpad>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250214093414.pvx6nab7ewy4nvzb@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ztiw4cxmtY14JvLXrX2I71HlJgkPPH1e
X-Proofpoint-ORIG-GUID: ztiw4cxmtY14JvLXrX2I71HlJgkPPH1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_02,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=977 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502240049



On 2/14/2025 3:04 PM, Manivannan Sadhasivam wrote:
> On Mon, Feb 10, 2025 at 01:00:03PM +0530, Krishna Chaitanya Chundru wrote:
>> PCIe equalization presets are predefined settings used to optimize
>> signal integrity by compensating for signal loss and distortion in
>> high-speed data transmission.
>>
>> Based upon the number of lanes and the data rate supported, write
>> the preset data read from the device tree in to the lane equalization
>> control registers.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-designware-host.c | 53 +++++++++++++++++++++++
>>   drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
>>   include/uapi/linux/pci_regs.h                     |  3 ++
>>   3 files changed, 59 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>> index dd56cc02f4ef..7d5f16f77e2f 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>> @@ -507,6 +507,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>>   	if (pci->num_lanes < 1)
>>   		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
>>   
>> +	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
>> +	if (ret)
>> +		goto err_free_msi;
>> +
>>   	/*
>>   	 * Allocate the resource for MSG TLP before programming the iATU
>>   	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
>> @@ -808,6 +812,54 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>>   	return 0;
>>   }
>>   
>> +static void dw_pcie_program_presets(struct dw_pcie_rp *pp, enum pci_bus_speed speed)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	u8 lane_eq_offset, lane_reg_size, cap_id;
>> +	u8 *presets;
>> +	u32 cap;
>> +	int i;
>> +
>> +	if (speed == PCIE_SPEED_8_0GT) {
>> +		presets = (u8 *)pp->presets.eq_presets_8gts;
>> +		lane_eq_offset =  PCI_SECPCI_LE_CTRL;
>> +		cap_id = PCI_EXT_CAP_ID_SECPCI;
>> +		/* For data rate of 8 GT/S each lane equalization control is 16bits wide*/
>> +		lane_reg_size = 0x2;
>> +	} else if (speed == PCIE_SPEED_16_0GT) {
>> +		presets = pp->presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS];
>> +		lane_eq_offset = PCI_PL_16GT_LE_CTRL;
>> +		cap_id = PCI_EXT_CAP_ID_PL_16GT;
>> +		lane_reg_size = 0x1;
>> +	}
>> +
>> +	if (presets[0] == PCI_EQ_RESV)
>> +		return;
>> +
>> +	cap = dw_pcie_find_ext_capability(pci, cap_id);
>> +	if (!cap)
>> +		return;
>> +
>> +	/*
>> +	 * Write preset values to the registers byte-by-byte for the given
>> +	 * number of lanes and register size.
>> +	 */
>> +	for (i = 0; i < pci->num_lanes * lane_reg_size; i++)
>> +		dw_pcie_writeb_dbi(pci, cap + lane_eq_offset + i, presets[i]);
>> +}
>> +
>> +static void dw_pcie_config_presets(struct dw_pcie_rp *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	enum pci_bus_speed speed = pcie_link_speed[pci->max_link_speed];
>> +
> 
> Please add a comment stating that the equalization needs to be performed at all
> lower data rates for each lane.
> 
>> +	if (speed >= PCIE_SPEED_8_0GT)
>> +		dw_pcie_program_presets(pp, PCIE_SPEED_8_0GT);
>> +
>> +	if (speed >= PCIE_SPEED_16_0GT)
>> +		dw_pcie_program_presets(pp, PCIE_SPEED_16_0GT);
> 
> I think we need to check 'Link Equalization Request' before performing
> equalization? This will also help us to warn users if they didn't specify the
> property in DT if hardware expects equalization.
> 
Ok I will add a check in dw_pcie_program_presets() if there is no dt
property for a particular data rate/speed in next patch.

- Krishna Chaitanya.
> Currently, even if DT specifies equalization presets for 32GT/s, driver is not
> making use of them.

> - Mani
> 

