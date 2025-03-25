Return-Path: <linux-pci+bounces-24611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 440BFA6E8F0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 05:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2733B07C1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 04:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E59864D;
	Tue, 25 Mar 2025 04:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jNnC4RLE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EF36FC5
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 04:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742877803; cv=none; b=kZ0CgyXTaKhEmGEVlPPz4YF6R7u8CZ7HWlGsCkSYOWMkLWCpZUq7f31UtmtuBm6e/I4UjQfn81L2+J87tfVDsVgheyw7cDhwMkof+WMlrnnZhcvpu0PcYFDlSDb0DAYh+aLOFcmYDXgblbVPFEOpc3VE9HPPA89oKhFIseOuxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742877803; c=relaxed/simple;
	bh=SIXKcpBMIQGoLpI7fW2p0s99bbX903KeXkbaEGxXY64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVN3xFnCG+gV8MQeCkNBQTcvPJQII2L0WauYGaZTjQ/4PXmFkcOukbwiJ5mOLN7pzg82QxET3ZnIvEKA/x64tBmRCqm1vn3gb6TLb7NB5aNqeacEjkfaHzjHMdK/7Osm1PY7YgJ7dkXGaj3MWHw7dF/f2Med1cvvm54m/00ql0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jNnC4RLE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OJ2WTm004762
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 04:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8rg16wpSQyfAsE/YtUxxFvRY2qDBDufr5ivHz9mkK9s=; b=jNnC4RLEs2ZKvOab
	/gdws6j4I+3nL8A63nPCl8Sh7gzusmIlS1tpiOowvyvcXEFhR0XLx4wlh9gynOWt
	HTGs0Wq0RGP6e2oM+GsAiWustpSZ4LwNsEjfnPfEoqUYf/zCib0p75MTP5qLo9iW
	7d6zOmtsUzkUM3pFxqmZOqip57wZt5ra6xEEqxb2SApwt5lnn+g3cm24EEsbpOea
	pgClGGIcyuR8gtWVZu0H2VlQx3pi40eIufwuUPZXMcv/Hg9gqRH9ykH5M2MzZqHe
	ZqBMQ62bn3iEVU8KoHUthu6+ZuvPDqYleil2c9tII7CS+Ne6YTBlR9GCH+yj42Wb
	XAnVmg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm79phyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 04:43:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2240a96112fso142173225ad.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Mar 2025 21:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742877800; x=1743482600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rg16wpSQyfAsE/YtUxxFvRY2qDBDufr5ivHz9mkK9s=;
        b=DeOMOU/MZlqXiaO2dzXDg5wTRWDwnG1PqRyZ0+GItqJnG9ho1ooGi5MJLsfco9P5hB
         ulOo6rNNAyrBLdweUyCLS6YrknVklWAUPHPQDknZWdigExyqyl9KqxiP9WBbcfoS1mZA
         443aR+FL2nex5mAVgvGToJ2f/MHLe7Dz3pOErCFDJ90Qd2zmSECQ/nxRf9Cew7vxXBaA
         IwO6GcsGTjH2meRt8W3XmlJ/gt/BOnDmvNUEUm10PIKRMnjhxt+5W8+3pouhcR8Y80Dz
         CdDeVXiGdwpE3AqYl3iuxEDtM1yizC26eWyKAKOlZzDH1pNUEundixGbTJFg4BKcTI8p
         o4NA==
X-Forwarded-Encrypted: i=1; AJvYcCWDVuaVljOoNLczbOA5EIURFcPWSPMIwaLKNqLiYUrsoXGdKfgVkKUeO0o8pz8YSucxYVPfd+H3Y9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGY3atuxjMZvItfik0aq7e1+o9i5S+I4uw3C7E3liF6r18j61T
	LXpsQVDhzojEd/D0hQDDKDajRAMxzMoXwiSSp/Yez8P2B+E4HMtPQDo8n5DTbcMj7GG/MSyfuiN
	f3gaug5xgwnaByXKPdmFlDo2QhGf6iJVsqGtUlr7HCIE+dYjhTbnPP1nWy2U=
X-Gm-Gg: ASbGncsX7/odG5CjOJZzePuT9iBi6Ax0prRU+xugBSJi6HjRsKbODXfzc9NB7gdW+or
	qsGqRtiaJ2Wh2olDqX0/O/JgXN9bO8Uo+Q5NmkruiZY9/I9W4vFRpZuublZNNpOBQlbb4VqmZ5+
	FBoZAdZHr6/ihKKTcNXtI2Z6ldgOzC6No9jvuaT5FaMBbHD5msW0seIkWybh9FRhZrTLJOi2Zxi
	Rqae6KbzeC/qsBuenpyIePeBmbAzv4pGVlCfRQu8kvtJs+hjoe7LEUsTMl/Q7cCMhLdkux9q0XN
	Q3Q0R/irp1bpKMGRYwyggdLUCM+Eizyi7EkDdECNS3UcJQ==
X-Received: by 2002:a17:902:d2d0:b0:224:1001:677c with SMTP id d9443c01a7336-22780c526b7mr205321255ad.9.1742877799439;
        Mon, 24 Mar 2025 21:43:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHhiFYkMAYAQ90q+e8se3nX4Nk3qVKNalr3u13o8pkfzAvJxAo67LexTL8yeMYxb1e286o3g==
X-Received: by 2002:a17:902:d2d0:b0:224:1001:677c with SMTP id d9443c01a7336-22780c526b7mr205320995ad.9.1742877798911;
        Mon, 24 Mar 2025 21:43:18 -0700 (PDT)
Received: from [10.92.192.202] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739061872b7sm8948785b3a.162.2025.03.24.21.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 21:43:18 -0700 (PDT)
Message-ID: <3bccf9a8-f60c-90e7-4301-8e10417c8107@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 10:13:12 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] arm64: qcom: sc7280: Move phy, perst to root port
 node
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250322-perst-v1-0-e5e4da74a204@oss.qualcomm.com>
 <20250322-perst-v1-2-e5e4da74a204@oss.qualcomm.com>
 <2b038454-8994-490c-9d59-9bd03f52e337@oss.qualcomm.com>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <2b038454-8994-490c-9d59-9bd03f52e337@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OEeqygZdd9eQpfmZjNvMMpcT7kFmcbY0
X-Proofpoint-ORIG-GUID: OEeqygZdd9eQpfmZjNvMMpcT7kFmcbY0
X-Authority-Analysis: v=2.4 cv=IKYCChvG c=1 sm=1 tr=0 ts=67e23469 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=1RYYy9rr-L5vwPXD2fUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_02,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250030



On 3/25/2025 12:45 AM, Konrad Dybcio wrote:
> On 3/22/25 4:00 AM, Krishna Chaitanya Chundru wrote:
>> Move phy, perst, to root port from the controller node.
>>
>> Rename perst-gpios to reset-gpios to align with the expected naming
>> convention of pci-bus-common.yaml.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 0f2caf36910b..6c21c320a2b5 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2271,9 +2271,6 @@ pcie1: pcie@1c08000 {
>>   
>>   			power-domains = <&gcc GCC_PCIE_1_GDSC>;
>>   
>> -			phys = <&pcie1_phy>;
>> -			phy-names = "pciephy";
>> -
>>   			pinctrl-names = "default";
>>   			pinctrl-0 = <&pcie1_clkreq_n>;
>>   
>> @@ -2284,7 +2281,7 @@ pcie1: pcie@1c08000 {
>>   
>>   			status = "disabled";
>>   
>> -			pcie@0 {
>> +			pcieport1: pcie@0 {
> 
> pcie1_port0 (or pcie1_port), please
> 
pcie1_port0 makes more sense as pcie1 indicates pcie instance
and port0 indicates root port0. I will update this in next
series.

- Krishna Chaitanya.
> Konrad

