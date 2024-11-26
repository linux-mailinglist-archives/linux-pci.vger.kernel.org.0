Return-Path: <linux-pci+bounces-17314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AF09D9203
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 07:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA3B284561
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 06:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFC6185935;
	Tue, 26 Nov 2024 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bE6/tpfq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867521A260;
	Tue, 26 Nov 2024 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604305; cv=none; b=HazP2DX9EkqFsoH8Aik1yXlP4qDdwAIB8iK1XQkNwYyLreYX1rfThttrjqtVGYompk1UrH4Q94t0lm8GBDFWZPeO8LxevK1Y7w6FniYhTqvjpb1gOoItGCRjNvarV+hBn49Xl1uz4koTwyl/VAoT0S9W/W3/zeW6Ts15wXOQ3Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604305; c=relaxed/simple;
	bh=ea28nK8vsUwWJKvGN0RHa9y1Qemeg5SzlFiaRsCKmzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1TK/D1HTa21ReKcjQLX9uzGgzRg206R0tIvywf5tntDYw9NBVYKI7Yo6KW0BpTNytlky/36bnaq05bu2jA7DIYrq75qkzsxpcPxdfdJrIVf3XWYty/Rs21PXjA+KpzxdYQGcBajBesAfCz1utQsdLD7Qxi3n88IH6neI7EmtA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bE6/tpfq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12045C4CED2;
	Tue, 26 Nov 2024 06:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732604305;
	bh=ea28nK8vsUwWJKvGN0RHa9y1Qemeg5SzlFiaRsCKmzw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bE6/tpfqbuSGhKoBHUsXpE9cFkby6LveEHJc8SffGHpXjPqDD0IJq/POKfrTbabZt
	 rvjMui6O3NjdElD3ggn4WBokdHJdneTQvvw0F1mfLjsvaBw/gJxBNAcmsRifQUmRvd
	 x2jPr0ZFBXvSfEg+GxUnQZGBJULNeJJUsQg31lHDmTvgkGsNUerND2nInpVWf2824P
	 8wZmJsPwstef0o33cMueN7pZQ34JDJWSiWr+j5P6M3B41RCNfsjdAH75dYkB58vGqV
	 adsnxQv92rVzOin3AOoSdc/xk2XVtP6hlV7qH6c+9szjwxPw6aATxGMIy/qnAJtCxE
	 yyOP48FhMY2lw==
Message-ID: <c81b89ff-6eb5-4a01-af84-636aa2a02a34@kernel.org>
Date: Tue, 26 Nov 2024 07:58:16 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241112-qps615_pwr-v3-0-29a1e98aa2b0@quicinc.com>
 <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>
 <poruhxgxnkhvqij5q7z4toxzcsk2gvkyj6ewicsfxj6xl3i3un@msgyeeyb6hsf>
 <42425b92-6e0d-a77b-8733-e50614bcb3a8@quicinc.com>
 <b203d90d-91bc-437b-9b91-1085034ed716@kernel.org>
 <cce7507f-a2c4-6f96-f993-b9a7e9217ffa@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <cce7507f-a2c4-6f96-f993-b9a7e9217ffa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2024 07:50, Krishna Chaitanya Chundru wrote:
> 
> 
> On 11/25/2024 1:10 PM, Krzysztof Kozlowski wrote:
>> On 24/11/2024 02:41, Krishna Chaitanya Chundru wrote:
>>>> ...
>>>>
>>>>> +  qps615,axi-clk-freq-hz:
>>>>
>>>> That's a downstream code you send us.
>>>>
>>>> Anyway, why assigned clock rates do not work for you? You are 
>>>> re-implementing legacy property now under different name :/
>>>>
>>>> The assigned clock rates comes in to the picture when we are 
>>>> using clock
>>> framework to control the clocks. For this switch there are no 
>>> clocks needs to be control, the moment we power on the switch 
>>> clocks are enabled by default. This switch provides a mechanism to 
>>> control the frequency using i2c. And switch supports only two 
>>> frequencies i.e
>>
>>
>> frequency of what, since there are no clocks?
>>
> The axi clock frequency internal to the switch, host can't control
> the enablement of the clocks it can control only the frequency.
> 
> we already had a discussion on this on v2[1], and we taught you agreed
> on this property.
> 
> [1] 
> https://lore.kernel.org/netdev/d1af1eac-f9bd-7a8e-586b-5c2a76445145@codeaurora.org/T/#m3d5864c758f2e05fa15ba522aad6a37e3417bd9f
> 

This points something else. I diged v2 and found many unanswered
questions and unfinished discussion:

https://lore.kernel.org/r/linux-arm-msm/20240803-qps615-v2-0-9560b7c71369@quicinc.com/T/#m7074ab9e5f89e29faf430c82f769e67d0e4072cf

The property description did not improve, actually it got worse: you
repeat constraints in free form text.

Best regards,
Krzysztof

