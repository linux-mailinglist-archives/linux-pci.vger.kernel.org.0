Return-Path: <linux-pci+bounces-28838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAE0ACC141
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 09:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1EF116DAD6
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FF42690F6;
	Tue,  3 Jun 2025 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gr19oFt3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B0F267B10
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748936128; cv=none; b=nuNbOdwCAh3Bj+GF/+JaRb4cR6nYWyHAukRXX0NrgUTXQ6kBDIotElWIwiFjevZs9jwCbLC6Rbb8LuqYCdLIRgVqJ+FEvkNhdsQZHfLdnsRx97n3FlLT+e/+TA7w4pAsBRBJzGzVfdr/M6sJDQ1J83mxqn2MLF5xYUe6BBC3vzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748936128; c=relaxed/simple;
	bh=E+QAiazNn9v/r2GaWNXCVc9NzRxjWjvN6HgGF1scPOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1eAy66Ivb1xntI7AxZUjZDgeTFtnN8Kmx1jQvqhQUAsnF6ykQ1u29C6czAOjoUMgyaA0lqsprn5S2wpJQiAuxkO9Pe0PAa/tsd7geXjhlHd5cpcsCG6SmJ+D9utNmss+8Ta3fDg+nSpwr6XsNYfr5TFIMP2Xog6MgCIeGAAOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gr19oFt3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552N7vmq013294
	for <linux-pci@vger.kernel.org>; Tue, 3 Jun 2025 07:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FecECnu2NheaNqiJX/ORSRrplhA+quPcAjrXUQL/gTk=; b=Gr19oFt30bnti54h
	gNQk79Ergs0wgCwz30ZHvmZwf5TdCovgO4pWxpr/0hgrjMmdHE2g7OVAmM4kaZ4Z
	gUUAk7dK0lXyNiIqo6Q/SGnn3hRiigP1KkZKG6PpkCQztChATSCX8N7G6h3sIf3X
	L15hftjzEejwcDZ3krYgBfyZqO/U+YTUYlpAEXn4WetcNHBJdN2i/6BqTjdIaD5L
	vFVtA47qs5lQNPdu8TKznCeofD9EGu4t7llEqUifCRuA384JqXbrqmHiAn6DdsDr
	RG4Km/z/dkSgvKgyQo4MjyCKJg/1VNJ3tBFfecPaX01IT+/z0Xbr+IFUfZJV4jzb
	X37mfg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8t1r33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 07:35:26 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2eeff19115so2215561a12.0
        for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 00:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748936125; x=1749540925;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FecECnu2NheaNqiJX/ORSRrplhA+quPcAjrXUQL/gTk=;
        b=jnZwA0dYuGy/oxw8xugiP29gkOtWypc9f5SojWZzoI8+3hvgHSwf+52M0oKy6y11Id
         1FLPjOLbF3APtvJYWRUnor+LRa5a0rEDw9CWeCWTLFg2TE0b/Hfp+h0UQPQ2PUVuzOzz
         psv5v0w+V1gRnOMrwoKfNoS8NFrXt+XcMxTHemMnKS4bWw7uVlANzbbN57kAgfDKHEwR
         Ex07WRDzxkHslBlBRfJQrYD/dSUlb92OvRYygqie8fwJGSrSuqhYu4RV4z8ysSyXAw1i
         X9viOIZrsERKJGbW1/36RmxEHtWror3GDXXrpRs8hhpR7bifFsFmO6k2anvUBrVJBJ9g
         iD6A==
X-Forwarded-Encrypted: i=1; AJvYcCWfTKoGTEM+VsQyzhvmgOQcM4BylXnM5LsfVwUc8oJnNUnQwjSBq3Ztd6fyeMa41FAQIpwtV45mbVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZmFwUb6JzHA+MSUSEu2rLtGNRpt4SJX7o0rd+TUFyyO3UxVKb
	jRaqJ49gdIpX21n77C9azLOj8ihqf92MCTStspT5j6frqTP7bjA5bUFO4WG34D27SWeScZwq672
	ia7qrpHSsEddLRIZkvknZak7S5RUkzEOpm2n/UPGckCYOnCd3LFW1s8CPUC77T7w=
X-Gm-Gg: ASbGncsqm2yFFG3NDx1YjPQ7jhoID9H3+dObBlLGW1yN2PNT5nVdAQt826mz3EKoGcf
	j0WxPnfxncumha9nJCRyFE7DkrvrG3JwW2Ezr1ealjHfiGVz0sEViOdu/i3VTw8ObB2t+RjgeYc
	t052CqT++n8ebUQ9YAGmFcWy3Gn+wwhqouBcYihyWDCFddV8VPJxXHjyNA56QqPkGpsD3qYZxE1
	uDmn28Yh9Q08DxJFOpg5Tk8vzUyV65KM2IEJltV++9aebUcShvpyPX++HUleMl+BcwYDktkY9HV
	/PJ29RBTpKWKpmYgO9hKWyQCN3zwi7FagNkdix8NuA==
X-Received: by 2002:a05:6a20:2589:b0:1f5:8b9b:ab54 with SMTP id adf61e73a8af0-21ad95818b7mr27385851637.23.1748936125219;
        Tue, 03 Jun 2025 00:35:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbrLjN/LK2D8S83yJequqnD62klgE0P1XAXLcbq1Q+J2LZWaSZQvhy+vzl67jRzKVjcPVj7w==
X-Received: by 2002:a05:6a20:2589:b0:1f5:8b9b:ab54 with SMTP id adf61e73a8af0-21ad95818b7mr27385809637.23.1748936124761;
        Tue, 03 Jun 2025 00:35:24 -0700 (PDT)
Received: from [10.92.214.105] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb6b5csm6627188a12.72.2025.06.03.00.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 00:35:24 -0700 (PDT)
Message-ID: <fb1cee63-ec97-d5c7-7a9b-bda503a91875@oss.qualcomm.com>
Date: Tue, 3 Jun 2025 13:05:17 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/3] arm64: qcom: sc7280: Move phy, perst to root port
 node
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com
References: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>
 <20250419-perst-v3-3-1afec3c4ea62@oss.qualcomm.com>
 <r4mtndc6tww6eqfumensnsrnk6j6dw5nljgmiz2azzg2evuoy6@hog3twb22euq>
 <0e1d8b8e-9dd3-a377-d7e0-93ec77cf397f@oss.qualcomm.com>
 <pb7rsvlslvyqlheyhwwjgje6iiolgkj6cqfsi6jmvetritc7lr@jxndd5rfzbfy>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <pb7rsvlslvyqlheyhwwjgje6iiolgkj6cqfsi6jmvetritc7lr@jxndd5rfzbfy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eJQTjGp1 c=1 sm=1 tr=0 ts=683ea5be cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=gzpaoVQaGCppcG2blusA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: k7cxd_9AXd8y96WkE7qs5Azb6FNjmvps
X-Proofpoint-GUID: k7cxd_9AXd8y96WkE7qs5Azb6FNjmvps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA2NSBTYWx0ZWRfX9J+VX1JtXEXH
 U4kI4cfaXjP09qINEQosSFz92z4hDLzUyeCWbjjLAD1RRrPiWwXpjNgH9SVClsE5Zfhzs3qnfRT
 Ki2biU7m8jIX9H4qpADZ+61P4KNn2v3eBMA3QNf4zPwJ+YSGPZ9/bvXtfE3Bs6OP9AlGuq8VP19
 eKWmtzP2PSEVU8XrKZ28F5IWe+Jn9y2yvNJIW23rjxJAjB7PbMODskpdaNaYU6pWweTepk1PaxX
 VwSy9pP6JF5UngbzEwfmtMbtuRSxKgE96EdGDmCyJq1Td4we5/5UDOoahxXGTNZdq6zvuknQ5d6
 gh6qFhkDBOe+o62owjT5QojWarJ01qDXATfzeq98uwED7QJE1wdHyN9rYHWhzVR2vSQSzfoH5cI
 ddX4dMS5ayY0v26bU5D68tmJAbvmh2f+JJDrtc3nw6oHlwGeNEtqWaYa4Zvq2CWhSDY8vhyb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 phishscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506030065



On 6/3/2025 12:22 PM, Manivannan Sadhasivam wrote:
> On Tue, Jun 03, 2025 at 12:03:01PM +0530, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 6/1/2025 12:35 PM, Manivannan Sadhasivam wrote:
>>> On Sat, Apr 19, 2025 at 10:49:26AM +0530, Krishna Chaitanya Chundru wrote:
>>>> There are many places we agreed to move the wake and perst gpio's
>>>> and phy etc to the pcie root port node instead of bridge node[1].
>>>
>>> Same comment as binding patch applies here.
>>>
>>>>
>>>> So move the phy, phy-names, wake-gpio's in the root port.
>>>
>>> You are not moving any 'wake-gpios' property.
>>>
>> ack I will remove it.
>>>> There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
>>>> start using that property instead of perst-gpio.
>>>>
>>>> [1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
>>>>
>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts   | 5 ++++-
>>>>    arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 5 ++++-
>>>>    arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 5 ++++-
>>>>    arch/arm64/boot/dts/qcom/sc7280.dtsi           | 6 ++----
>>>>    4 files changed, 14 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>>>> index 7a36c90ad4ec8b52f30b22b1621404857d6ef336..3dd58986ad5da0f898537a51715bb5d0fecbe100 100644
>>>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>>>> @@ -709,8 +709,11 @@ &mdss_edp_phy {
>>>>    	status = "okay";
>>>>    };
>>>> +&pcie1_port0 {
>>>> +	reset-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>>>> +};
>>>> +
>>>>    &pcie1 {
>>>> -	perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
>>>>    	pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
>>>>    	pinctrl-names = "default";
>>>
>>> What about the pinctrl properties? They should also be moved.
>>>
>> pinctrl can still reside in the host bridge node, which has
>> all the gpio's for all the root ports. If we move them to the
>> root ports we need to explicitly apply pinctrl settings as these
>> not tied with the driver yet.
>>
> 
> If the DT node is associated with a device, then the driver core should bind the
> pinctrl pins and configure them. Is that not happening here?
The root node will not be associated with the driver until enumeration,
the controller drivers needs these to be configured before enumeration.

- Krishna Chaitanya.
> 
> - Mani
> 

