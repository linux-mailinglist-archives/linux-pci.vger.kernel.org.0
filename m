Return-Path: <linux-pci+bounces-29459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C42AD5A93
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 17:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8CD3A351A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D941D130E;
	Wed, 11 Jun 2025 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIQjoBF3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5001ABEA5;
	Wed, 11 Jun 2025 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656021; cv=none; b=CLFE161EiGaKTqfMeVLoZ3+xS6v+vXVWYvO0Q1ExVdhzsN3IVrbVnYVO75ICVxQULYr6q3nSfUCv2xJTWO6/OYbn5StD7Psx+Acb4JgUjub78s+0z2DJ1WpNGLjzM06ugEAPu2k0ozzNgCk1uJ60NMkqpjzdWQhYWs8LrzquJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656021; c=relaxed/simple;
	bh=9VxDeQswEJMyTwEyirk1JPkXo0uxK77PL4djHQ8K4B8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOEfdAVB0zQKA5xNgX2Dr8YdYGRmVRsl05mjiD0L62z1mp2B2b/otryEQVjqjpKD6MzIFTD0LsuemgPV7TFBXcKVEDxfOqLk0vR3quAwk+qvL4NW5mEarzhsEj3PHZsFVULW/mVLij0Rlza1W+5zYoZqNJJlcnQ/tENCbLDw8rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIQjoBF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B13EC4CEE3;
	Wed, 11 Jun 2025 15:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749656021;
	bh=9VxDeQswEJMyTwEyirk1JPkXo0uxK77PL4djHQ8K4B8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nIQjoBF3cdsCXdI0diy0wSbKfaaxVVcPHFhq0UwpoeFN5ZeyPpHZUT/3RsxTGNSsK
	 PPBhLDTH+dMrQSufUYHXiAKkNnopy/Fg1QyhnzSQ+Zt2HcPmGJE66Wb4N9cCaCa8Lw
	 Yyp+S+Ml8g6VjVricuG4IYVvJQ6E+n2yy3rqK5mGh1FZxCYQ9im58QhpQfTar/Fu+f
	 dIU4ff/nqPYDER+LRnubAbkhaPCjQCwrh+M+Sg1gqh/3X++n9SAux+Csg1+HsBvQVL
	 FJUvZwZBfaw9q80or9w2Tbfvt1fFmsk6kAOoSUXB3LlfIs68bXFXRrHkLF9ABg2tn0
	 xM+apHWtlU/8Q==
Message-ID: <d1e3fede-0f75-4c00-a087-d04923000ae3@kernel.org>
Date: Wed, 11 Jun 2025 17:33:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: qcom: sc7280: Move phy, perst to root port
 node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>
 <20250419-perst-v3-3-1afec3c4ea62@oss.qualcomm.com>
 <20250423153747.GA563929-robh@kernel.org>
 <2ce28fb9-1184-4503-8f16-878d1fcb94cd@oss.qualcomm.com>
 <ba107a41-5520-47fa-9943-6e33946f50b1@kernel.org>
 <56eccdb0-c877-431d-9833-16254afa1a0c@oss.qualcomm.com>
 <77eeca94-0703-44c9-b30b-17fc989dedb7@kernel.org>
 <7eca5cd3-9ab8-4c42-93e8-d8043dd26408@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <7eca5cd3-9ab8-4c42-93e8-d8043dd26408@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/06/2025 17:17, Konrad Dybcio wrote:
> On 6/11/25 8:36 AM, Krzysztof Kozlowski wrote:
>> On 10/06/2025 15:15, Konrad Dybcio wrote:
>>> On 6/2/25 3:01 PM, Krzysztof Kozlowski wrote:
>>>> On 08/05/2025 16:26, Konrad Dybcio wrote:
>>>>> On 4/23/25 5:37 PM, Rob Herring wrote:
>>>>>> On Sat, Apr 19, 2025 at 10:49:26AM +0530, Krishna Chaitanya Chundru wrote:
>>>>>>> There are many places we agreed to move the wake and perst gpio's
>>>>>>> and phy etc to the pcie root port node instead of bridge node[1].
>>>>>>>
>>>>>>> So move the phy, phy-names, wake-gpio's in the root port.
>>>>>>> There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
>>>>>>> start using that property instead of perst-gpio.
>>>>>>
>>>>>> Moving the properties will break existing kernels. If that doesn't 
>>>>>> matter for these platforms, say so in the commit msg.
>>>>>
>>>>> I don't think we generally guarantee *forward* dt compatibility though, no?
>>>> We do not guarantee, comment was not about this, but we expect. This DTS
>>>> is supposed and is used by other projects. There was entire complain
>>>> last DT BoF about kernel breaking DTS users all the time.
>>>
>>> Yeah I get it.. we're in a constant cycle of adding new components and
>>> later coming to the conclusion that whoever came up with the initial
>>> binding had no clue what they're doing..
>>>
>>> That said, "absens carens".. if users or developers of other projects
>>> don't speak up on LKML (which serves as the de facto public square for
>>> DT development), we don't get any feedback to take into account when
>>> making potentially breaking changes (that may have a good reason behind
>>> them). We get a patch from OpenBSD people every now and then, but it's
>>> a drop in the ocean.
>>>
>> I don't understand what you are commenting on. Do you reject what I
>> asked for?
> 
> If the general consensus among kernel PCIe folks will come down to what
> this patch does, I think it's fair to shift to a "correct" hw
> description, especially if this is a requirement to resolve a blocker
> on functionality (which the author didn't clarify whether is the case)

Again I do not see how this argues with my comment, so please clarify:
do you agree or disagree with my request?

Best regards,
Krzysztof

