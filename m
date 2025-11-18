Return-Path: <linux-pci+bounces-41494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBEEC68C36
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 11:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 377EE35DA34
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3613321D9;
	Tue, 18 Nov 2025 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nQGnFtnr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IPUyin9w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7FA2D8375
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460720; cv=none; b=qFuTip6noU9mZ3ynXggWZ2hFoba0SWXYcvIMqpS1Oc3jdvlP4VVQzQaIrSDH9cZLRnsPbrn81PWBFLDSw33kPFJsA2EdCgq/3tchKtXiL5Cyw74nwlSLa7Aqa7TkN+YV20eVZwPPVnuen446kCmDp4b7NIL5pQ630fkmsSx1NK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460720; c=relaxed/simple;
	bh=2k8kp2eCR6II4n4tUCL2G0L3QQg9MS54ilVfxnRiAaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzFUxDrfINnt77IKKcvII54goIAln/bDdOOXf9N+ArLIYA8STMfONSXynSKtZcoMRtNBvgnsDvFMLmTvzRaHCljAwiSiIxzjUGvW/QJWC+FH3LHlgKX46B5svxzUHKrO1YJu9vP77K0gWVIM8pUJNCbvBlAMuGsjMyU5eA//zFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nQGnFtnr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IPUyin9w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AI2w9FY375768
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 10:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KsUDUPxoq1t6MjKduGIYJdoPPwEgISWzAZ7LFsDaIFs=; b=nQGnFtnrJESm64mR
	9pEc4QGS9+y/0mQ5OuNcwYcNBN7K9xcBXlAZDMp3AESCmTFz6V4EtRyMRhEok4FE
	LJlTT7GbrrR5JD/PzKyzc1ItEtLZtrnFYMd3p1CStYB1LamauxsLJ/Vxu9dE6eWk
	sNGBuKh/xOWdXERN2tINpi6JyN7Z499XZZ7UF37dVO74mRhpBy4BVbzX6Slp8a/k
	vVDWFOIGBUuoT4WZ+dC3O2E09RSTsmIUOQA3YrwJZmz8zBS8PkEbCE/SyB3PW+3g
	iHXBEcNt1S3G0aV7cwlkcczhwsXkck9+4QYTxIP5O3gPGA81pEQJCyhpNgsHHus7
	FctMpg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ag76njrk8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 10:11:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29557f43d56so66778455ad.3
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 02:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763460717; x=1764065517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KsUDUPxoq1t6MjKduGIYJdoPPwEgISWzAZ7LFsDaIFs=;
        b=IPUyin9wB/Vj6H+ZgeTe7FQvnCbZtFe/t9i3L99WcMLdy2R/Zx5bSXNIeLW3qGU3j/
         vM207TqagJu3qEpYf88CvI3fbvtYxsOLkZqZoElD7CGPDxVSONqMalsc0doQ7oY8CLk9
         IjH/QoCZqyXhwFrJX25541VFH2HfdcEBKf6IQzsIZj+PKtSO9v/B1Y9SG5r5sdspQPOY
         AqttR7Ya6kSzqpzyk8vQ1Q1mUs09vs+g7hd7/atZnOR2PQ1tHeI+tPJtDbOtn3dQv+f3
         irSaGjRVa02XCYYFqjIZ2Nk9pbBfzOxpRn1K2d7szCD+DAMKfUmns3MZjhG1b90NZtyD
         CirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763460717; x=1764065517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsUDUPxoq1t6MjKduGIYJdoPPwEgISWzAZ7LFsDaIFs=;
        b=FO5na+ziGBCSajaBmRAyMXbT/BKgforyTQUHMv4gppMypmWZtMRUipoxUGahxSZY2n
         /Z2Oajx9uUP81dWSTmhnEbhoftmduLyT1ZW3Jjv2uWQhlr717MLbU8epHp788xtfrz/m
         BCC2nbPOwhpnLNN0FfCdmdgY6rYuWYUev708KTglnp71xup2L8UR2Fw7CLYHhG5A9M6G
         i2dU/pDB3Ifil9ZQEBm0xbk80R68Ls7REe+yN+9cFfKVEGM07faaOiEn2YDFddIyzcwF
         YXj8PIpT3mf0OgzZ3PEp028C6fU3dZYANHmfKq2KmqyH2uxdcBTvObKOXHYipRXsZNyZ
         VEOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtTnlARYjmcuUO/yVV4psuszWiiJWcGMV4FbzKftbKRvx+EnLb++7xRbFXTtn8GE+EqubiJoUpl+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOTDm5aBlrIqGkx58YevRagW47iRtUvyJhXgmUE0MeETb7yqz0
	MtcqXIgo1lCvg6D4bvCY/GxJAeEWXibkmRfZCa+ddRz9zTRmsI1UGJ1H9lk9spgoD/DfpkHLsX0
	iYKmjhvMPZjubWYTbuvmjxvea2o5TCG+Rg42J2ClEnr7zZYABeEEo5xwQr/xL3cY=
X-Gm-Gg: ASbGncuyDHq/S6NYuW6qyhnQD8xlhCtYh3rjmyEniamNzAyzHgsyQjq4ogSHGo4totl
	TB1B5/IvJo0YdKYDX+N8MPB6xho0Q58naN/CiVgIGHUZ3v9CPRW61QooSUvnSk/RgaoioBD2M2P
	GiZAGyRzniNUxB646kBx7FWq85up21Z8DfZkUsCs47xBKubzqubJ1esFK/oNp2N21uu3sn4uEt5
	dmrpV8hs0kVfLbjJxWtXmnXG6+Tr96nxtI0wpirDbl4Fns1eARUyvx2bIXctB+/f90SVYj9jfFc
	Nuuae5zNONznqghRQT29lsWJ3Jb1RZrFtJq939DBsmZMfkhzIxdaAtaP2jgU2brK73zZyA+sGhZ
	cTKkV2E0cB+xK3iy3B0N2Mp4LydayXTcAXOj7MTe9K+Ru/Aquu1KDJSKgS9yW7awB
X-Received: by 2002:a17:902:f647:b0:298:42ba:c422 with SMTP id d9443c01a7336-2986a73303amr176999535ad.31.1763460716847;
        Tue, 18 Nov 2025 02:11:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSElhq/foZIVZg0t4wjamD5rzsGK+/4gwbgY+RGs+mSFiFVT1jM6xTJZ07fGy9cGHEujc8lw==
X-Received: by 2002:a17:902:f647:b0:298:42ba:c422 with SMTP id d9443c01a7336-2986a73303amr176999195ad.31.1763460716345;
        Tue, 18 Nov 2025 02:11:56 -0800 (PST)
Received: from [10.133.33.100] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2986e5ef32asm133115195ad.39.2025.11.18.02.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 02:11:56 -0800 (PST)
Message-ID: <12bce4de-9491-4040-991b-529bc916983c@oss.qualcomm.com>
Date: Tue, 18 Nov 2025 18:11:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add PCIe3 and PCIe5 regulators
 for HAMAO-IOT-EVK board
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, krishna.chundru@oss.qualcomm.com,
        quic_vbadigan@quicinc.com
References: <20251112090316.936187-1-ziyue.zhang@oss.qualcomm.com>
 <20251112090316.936187-3-ziyue.zhang@oss.qualcomm.com>
 <rakvukrdsb3vpr4k22hgvbr2yc65me32uezwrqgn2573kblirt@7q7pgr3nkvso>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <rakvukrdsb3vpr4k22hgvbr2yc65me32uezwrqgn2573kblirt@7q7pgr3nkvso>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE4MDA4MSBTYWx0ZWRfXw+42mkVSAvTi
 fflNy3F3KTwIueF28ItjjAUocWKmWt1gtqCkAYuYKsGC7AIAdKGPSWSWf/6Qk6tauliW1lLMFh0
 yxS6l/70gHErqcNwjs0JHQntvTTq4EQ7aZ3WsdU/Y5rKeahvw/gbKKoP1CmjF/PEBeemTHqTQrP
 UcQFtl98VkVLHAEJLAJR2ACwVbu/xeaqk/gw8F6fqPi3tFvAczTSO1YCWyodJ41nA6K43CEMVi1
 a84XjzC1TLcNwJPi1QUe1xqaYdpv5vrEeF+1yj53zUchyx2+tnM27LmXPb0KcRLtzg1o9Fk1eFv
 BLFSL860sNvBwCDsP8uC86n1pozpp/NuUChvu3HiIM08e0mXgJm/qY/Ionx+umJ4wC1lA3tqhE3
 i50JZFhmjX/pbsPKmQKK7QWvkdh+Lg==
X-Proofpoint-GUID: _e3UnhT8bvdL6JiZAEMGzzCuUgoX966G
X-Proofpoint-ORIG-GUID: _e3UnhT8bvdL6JiZAEMGzzCuUgoX966G
X-Authority-Analysis: v=2.4 cv=a4I9NESF c=1 sm=1 tr=0 ts=691c466d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=0FT5JWsqCLsmEzCoxIcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511180081


On 11/13/2025 5:16 AM, Dmitry Baryshkov wrote:
> On Wed, Nov 12, 2025 at 05:03:16PM +0800, Ziyue Zhang wrote:
>> HAMAO IoT EVK uses PCIe5 to connect an SDX65 module for WWAN functionality
>> and PCIe3 to connect a SATA controller. These interfaces require multiple
>> voltage rails: PCIe5 needs 3.3V supplied by vreg_wwan, while PCIe3 requires
>> 12V, 3.3V, and 3.3V AUX rails, controlled via PMIC GPIOs.
>>
>> Add the required fixed regulators with related pin configuration, and
>> connect them to the PCIe3 and PCIe5 ports to ensure proper power for the
>> SDX65 module and SATA controller.
>>
>> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
>> Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 83 ++++++++++++++++++++++
>>   1 file changed, 83 insertions(+)
>>
>> +&pmc8380_3_gpios {
>> +	pm_sde7_aux_3p3_en: pcie-aux-3p3-default-state {
> What is sde7? Other than that:
>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
Hi Dmitry

I’m not sure what “sde7” refers to specifically. I saw this name in the

schematic, and the pin is labeled PM_SDE7_AUX_3P3, so I used that naming

in the DT.


BRs

Ziyue

>
>> +		pins = "gpio8";
>> +		function = "normal";
>> +		output-enable;
>> +		output-high;
>> +		bias-pull-down;
>> +		power-source = <0>;
>> +	};
>> +
>> +	pm_sde7_main_3p3_en: pcie-main-3p3-default-state {
>> +		pins = "gpio6";
>> +		function = "normal";
>> +		output-enable;
>> +		output-high;
>> +		bias-pull-down;
>> +		power-source = <0>;
>> +	};
>> +};
>> +
>>   &pmc8380_5_gpios {
>>   	usb0_pwr_1p15_reg_en: usb0-pwr-1p15-reg-en-state {
>>   		pins = "gpio8";
>> -- 
>> 2.34.1
>>

