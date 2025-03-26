Return-Path: <linux-pci+bounces-24788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070C5A71DDF
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 18:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54D433B3F7C
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 17:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A4523FC48;
	Wed, 26 Mar 2025 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MMaLDRUC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A723E334
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743011771; cv=none; b=R+fB1pZOB+PtyXsu8v3B2ILkzzrl62sb/o1+a4frp49874MvBTol+Z2PGQGg88BogG4UpASCFWHNXDqEuzeAO8guh3W9uXY9FssMawBmwHI6vna0POzQ/suAr6MEqhKNTKJ5els/n6E7qbhHh0ZBKX5H4uhl7p8RlHk2iieX0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743011771; c=relaxed/simple;
	bh=FOIE47d2wp0LC0VDLsB3snc29xU6ss8U478EjWgM9Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOGlZscxIExNXaTxLO/B4Mb6W/U2qg0PilODJMXa4WkvJfFpDwUITDBbFqZUpwcUKiBxkS8n9/q0NuDV0SaLJ44ZjYnB89NY/PcRZyGzC6TPVtJC0pcfRsVZ7dwzHtCH+aktQ+UfeXZE4dlSTJvok4qXrq7QFx7dEfLOkUyz5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MMaLDRUC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QF6AgR014431
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 17:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lxqno0230pcqB0H6Ol9XwwTC6E/yX89Z1LsI9uh3Cpc=; b=MMaLDRUCBI435iSA
	aGUj+zJEParOZXAr3hFQYuqXY29BDofFSZbsPunJ1/4bkUMNbmhKkFa/AT/QTHJU
	deOdmcufix7pePxdTkCP9L9hLSl8RP+J7YPks6WkzgGRG08tYpqYe2iRaHMG3iLM
	UhxVjWce6vrYHPBzRWJ7ddEYccu7YTjnMqDfwatbP75/o+auzdxDaGDY+xTrzwQ9
	+f+C+gObVekxoXb1ibmLI0xUtBzi2PXnPEgCZTKcplNaaIi6B20xMeP9CQhgigPN
	QJK3QrjfrDXR2cBcTWHIyXuVdEBLpC8lyaBprzLcBwu+H9tWyKiws/DM1N9KYZng
	UOoLpQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mb9mt58m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 17:56:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5841ae28eso4539185a.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 10:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743011767; x=1743616567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lxqno0230pcqB0H6Ol9XwwTC6E/yX89Z1LsI9uh3Cpc=;
        b=fHmlY2SY5njPOPLlTbS9rNQbCjP8Tbh3tCMu+OmjihsGGlH1bOtrzdC+yrANQHQnAx
         7ALlu1KK7jiaojDQfEZlR8nJ1iWqVY8LvaoM/ox0bJtZIJ63H/M/K4bED/SyxksT53wA
         ZPubY1o38UpFkzEYv22Te7erRX+9jrZIlthmivSZ656IkOsRCM9Jz3Rk5vyK4UHj26Ip
         tF/eiYNJR9tCiCkCh9tfe5BXWzzWGWXKEFtwaag0wCAGDgxtRluzom1tngcbX7sFs83A
         vgO4wTT7a9u7WsC6KUtP1eIKIeW9XXDEDV7mPoY4uKr9U2sT0CDZJk4ubfJGPlL2HJ5f
         wlSA==
X-Forwarded-Encrypted: i=1; AJvYcCV2i4Yw4nvF5aBmSEQAePf23bvzwCJcT4cHgNhqn6zQIpZzO1R8RMqI50VppE5wrfwJ0hUH2CSRn8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe8/ekm0lWDgoMoDpVjAUe5q+LSvyGz5CdIbl8EutNFYT3UqAJ
	1bhdLRpSRWptrNb4pW7WXFJhbVcyvLeJq+yx2O3vo8RCsn5UTM0E2nHXU+Z6xghTIZGXQhwDvFJ
	3e+oTPxoC8Wk2MZZbwzgjNhkGmqkx9t4EdcbQ5z3GKb/iHnIeJP2ulnfjI2M=
X-Gm-Gg: ASbGncuJm4KYZEsoYJZhmZib07fQpDcNaSlwvdbAXiJz/1XW2yNgXfTWnlLjJDpCGWy
	cdCF4kiwkTpIAE1NKi4CK6rY1Pglybtx8ePc4bZjRLhlnPB5GC8je9CU28MpS3JoI8xU/772d5y
	voF2lcsa9OEIMvgig/IZ7sc0BJbQHsH/3YmlFnqsd+tDIsMTJpF9FUE1f+QeCDf3xugdvsJgi1w
	cds/+EQ7E9qKA+UWcjYyYR+QvH/ekvYL80eEepmks6RmnQnvu2EYjxvodBOfxDgaguN9RlYGCbL
	Esx7a4MS2vcrgGI1Iz+Wm10Er3sBvroGoHcMunfwVUI6TBBsv+ynWLIzFhFeJje5Z2bssg==
X-Received: by 2002:a05:620a:4588:b0:7c3:d752:f256 with SMTP id af79cd13be357-7c5eda1ef32mr33501985a.7.1743011767162;
        Wed, 26 Mar 2025 10:56:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPo1a1tkN/XZXeNGAAUJcp1b82A8YyOkx8pDC2Hf99u7C+rn8fvVrRAP5A3JMYBukqijRm1A==
X-Received: by 2002:a05:620a:4588:b0:7c3:d752:f256 with SMTP id af79cd13be357-7c5eda1ef32mr33498785a.7.1743011766592;
        Wed, 26 Mar 2025 10:56:06 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef93e5cfsm1073652266b.82.2025.03.26.10.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 10:56:05 -0700 (PDT)
Message-ID: <0cc247a4-d857-4fb1-8f87-0d52d641eced@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 18:56:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com
References: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
 <20250309-ecam_v4-v5-1-8eff4b59790d@oss.qualcomm.com>
 <3332fe69-dddb-439d-884f-2b97845c14e1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3332fe69-dddb-439d-884f-2b97845c14e1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cs+bk04i c=1 sm=1 tr=0 ts=67e43fb8 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=hNMOycGrYB8S6Zk86AkA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xyMrtAR0ChFtQXZ9Ryw_LS8lBY_Q6tDV
X-Proofpoint-ORIG-GUID: xyMrtAR0ChFtQXZ9Ryw_LS8lBY_Q6tDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_08,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 mlxlogscore=852 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260110

On 3/11/25 12:13 PM, Konrad Dybcio wrote:
> On 3/9/25 6:45 AM, Krishna Chaitanya Chundru wrote:
>> PCIe ECAM(Enhanced Configuration Access Mechanism) feature requires
>> maximum of 256MB configuration space.
>>
>> To enable this feature increase configuration space size to 256MB. If
>> the config space is increased, the BAR space needs to be truncated as
>> it resides in the same location. To avoid the bar space truncation move
>> config space, DBI, ELBI, iATU to upper PCIe region and use lower PCIe
>> iregion entirely for BAR region.
>>
>> This depends on the commit: '10ba0854c5e6 ("PCI: qcom: Disable mirroring
>> of DBI and iATU register space in BAR region")'
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>> ---
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

I took a second look - why are dbi and config regions overlapping?

I would imagine the latter to be at a certain offset

Konrad

