Return-Path: <linux-pci+bounces-20468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 473BFA20AC6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 13:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 560E57A0814
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 12:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC631A256B;
	Tue, 28 Jan 2025 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GfLKuMW+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7441A23A4
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738068812; cv=none; b=RH7hm2M36lQZjnGX+syauCLv60yagqjWTFZhKSN6jnCkISxZQJHbhXSztZRfBmsmCegj2yh6sQCHDUqR1FB5MvTVUz2xzU2oubY1E1quc05Kv3sZW5zDyAV+rF9IFiabYmPczhNl4jWwktr+Ne71wnfcwbkalxr/obEdMG2NrI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738068812; c=relaxed/simple;
	bh=AmKBEMYbq3C1waUn1c3i1+nqUIo9we6DMiSCNRCXMuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bi11ZCpL0SFDEUDJ/gudPMgrYFGqjpfA4rFzUEg8TryODSGPnG82FNP3P1IeLgRgOAi81tn3UBtPtFQyZZNG9WDL/d1Vz87J/B+X5UuU1lSWNAxUXjuBmCbavWtRtQ7yUhs8XEiRJks3z2k5aKbAzBYBG9NLdDwpgJIf9R6479A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GfLKuMW+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S8hDUc014844
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 12:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MV9sHX+bNUWcHes1enc1kOVtoMjibHPlM6e++jnw3fA=; b=GfLKuMW+eJwMrVKK
	C4dzxdizExOpdLHR7oO9iv0y7WSELr6pViZR1rDuSXfVG0C+kFLZDwXb5eWRv3Y9
	Ompc/HUe68D2Q/UoJ5S0gZJ5xJRwQ01sZjtwGgq1XONW7kvDtzagfg5mDvPjIimV
	dAZAYoXnXVa6k9kPiaJSlY3sz2/Ucr6aXI2LFGaN1lmClelEEiBUzrDBLQddhwq0
	VF+i/Nv8FVdsz+blETVhh6HMTbVPVpXRXZ1dW9xCKLzKJxvCY+nGIJXfaa4VnAGF
	LrQ5tAZh9hUa+JCXckjwLApIIzJe/95G3v9+sm0XMSKXHSaqBUZOlFlXDPAAHqyd
	TR0zXw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44euyq8hkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 12:53:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-467a437e5feso15364401cf.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 04:53:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738068809; x=1738673609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MV9sHX+bNUWcHes1enc1kOVtoMjibHPlM6e++jnw3fA=;
        b=P896285CnJp2B8srf0BBnQOayUtrNSuEsuGA+G+KX/B2k3OUlyWDrUMiBX4v7EaPQF
         3nwyePTe3LFngVb/4azOyL3xkBD5Ha+jifePakwtozwcSn0ziO1VhQ8BPJpY3v8MYgen
         nNvRaADQr3Xei/7iMvVE5F09xzsdX6KI5JK3Q854uBu6zZtmSGWvnHCpO75RSSyySDH4
         FsBhZ67qC7+x9F81L+syvtUdVVkI7rifRgVGZW12YxEWmThLc+VUYwfwdppmviJq8kPN
         unzz50c4Sd02ZoWTfWm1inda8CnTSKREhvh3c3HM7vy9an1FtRMgHX4TpUKdN50J4a1A
         836A==
X-Forwarded-Encrypted: i=1; AJvYcCWWO3VM2t+ehEk/vbqoV+0S4fmjaxA+GA7khxseXNQZr9Ls3VvrttAO2JyGjFka4QPC4asj1AqD6Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKs8561WqpNZs9pok4mUEb3C9pg+prAJm6UgPlWRS3/CZey3/
	kDsoJ/G6rDEHTfoNENBr0YC/L/7KUXVr+xh9LNJtmCNg1wrkhheRFUkDsP0sNiw1tcQfdiXuDwl
	KTUzQNBE1mDcevV0F8viv5zUgyGVrHSDoMJ717zb+WZ156XcKx1DOebzSphA=
X-Gm-Gg: ASbGnct194+DBiy2GpmbFUoP6tbFR/oDNiEQ8+j8NIM+Iq1iRs3sQsTuhS1R7kbw3Uq
	X8DXZ8wMaHnLTYRodhDkiDIcf8D7qF8CvrnwIHuzJpZRCAn2Ycrz7oiOIw75YsaKZDhH3Wpvld7
	8n2tOrbrH7ZEKnpVH87gZ8yZFcGoEEKC6d1cORRaSIAKgmuFuSesuDN/zvtO5INrkUw9bvh9Wvj
	vExCC6+Mkdq950FVLF9JWHRCZP2LThYHhfr0uaShELhOLODOTcC4i+vBQz7A3rd1sfppIZBgbCc
	XVbltbEFyPZcC193hFd5+Xi7Ow/Df+OsCW5Og9NGQYU5CNQlVxc5WIOwgus=
X-Received: by 2002:a05:622a:242:b0:462:b46b:8bf8 with SMTP id d75a77b69052e-46e12bb2f1amr255168701cf.14.1738068808695;
        Tue, 28 Jan 2025 04:53:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm5ay2LvDoijzjcNRhCGL+J9QvFyvGFGKVSlosrn3eTzj4AlErQXYlgeiM6A+1c4sLY5PPLg==
X-Received: by 2002:a05:622a:242:b0:462:b46b:8bf8 with SMTP id d75a77b69052e-46e12bb2f1amr255168571cf.14.1738068808299;
        Tue, 28 Jan 2025 04:53:28 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e66860246sm50383761cf.11.2025.01.28.04.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 04:53:27 -0800 (PST)
Message-ID: <b074baa0-07c5-450d-8531-e2b1d706df0b@oss.qualcomm.com>
Date: Tue, 28 Jan 2025 13:53:21 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] PCI: dwc: Add ECAM support with iATU configuration
To: Manivannan Sadhasivam <mani@kernel.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com, mmareddy@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
References: <20250121-enable_ecam-v3-0-cd84d3b2a7ba@oss.qualcomm.com>
 <20250121-enable_ecam-v3-2-cd84d3b2a7ba@oss.qualcomm.com>
 <20250124061237.he34clwukqwzqx2t@thinkpad>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250124061237.he34clwukqwzqx2t@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 42DRp3vPQwSixVohD9Yj29wyqRfG-J9I
X-Proofpoint-GUID: 42DRp3vPQwSixVohD9Yj29wyqRfG-J9I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280097

On 24.01.2025 7:12 AM, Manivannan Sadhasivam wrote:
> On Tue, Jan 21, 2025 at 02:32:20PM +0530, Krishna Chaitanya Chundru wrote:
>> The current implementation requires iATU for every configuration
>> space access which increases latency & cpu utilization.
>>
>> Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
>> which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
>> would be matched against the Base and Limit addresses) of the incoming
>> CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
>>
>> Configuring iATU in config shift feature enables ECAM feature to access the
>> config space, which avoids iATU configuration for every config access.
>>
>> Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift feature.
>>
>> As DBI comes under config space, this avoids remapping of DBI space
>> separately. Instead, it uses the mapped config space address returned from
>> ECAM initialization. Change the order of dw_pcie_get_resources() execution
>> to achieve this.
>>
>> Enable the ECAM feature if the config space size is equal to size required
>> to represent number of buses in the bus range property, add a function
>> which checks this. The DWC glue drivers uses this function and decide to
>> enable ECAM mode or not.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 
> Some minor comments inline. Overall, the patch LGTM!
> 
>> ---

[...]

>> +bool dw_pcie_ecam_supported(struct dw_pcie_rp *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct platform_device *pdev = to_platform_device(pci->dev);
>> +	struct resource *config_res, *bus_range;
>> +	u64 bus_config_space_count;
>> +
>> +	bus_range = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
>> +	if (!bus_range)
>> +		return false;
>> +
>> +	config_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>> +	if (!config_res)
>> +		return false;
>> +
>> +	bus_config_space_count = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;
>> +
>> +	return bus_config_space_count >= resource_size(bus_range);
> 
> return !!(bus_config_space_count >= resource_size(bus_range));

You made me think that there's some weird interaction here, but C99 says

"Each of the operators < (less than), > (greater than), <= (less than or equal to),
and >= (greater than or equal to) shall yield 1 if the specified relation is true and
0 if it is false.89) The result has type int"

so I'm not sure this is necessary

Konrad

