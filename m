Return-Path: <linux-pci+bounces-16728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C67A39C81DD
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 05:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779391F21D1C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 04:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22771E882F;
	Thu, 14 Nov 2024 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5OrcJCg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A211E8827;
	Thu, 14 Nov 2024 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731557675; cv=none; b=n4Ktmi5+mkwE+kLRVvRG/cSeCXhWozs3AmoK6BgW1s0tgErRHaN8P8+xwlWL2LynO39jT+x7DC6L0dU5L3zK47rxTfbXku2bkn/3clfMYOcLYWpt0ReoJDwpMVzyGgzUFniU+jQ9OmEHrkbV4Hoq037u3Byi6g2nEeEdt3DJzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731557675; c=relaxed/simple;
	bh=OGi2dRNe5tO8+2VRnUt3YjU4LnEZeMja9EiwcEWaM7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nNjUtebVt5LnR9jKfg6SICsxQ1CibGl7yqrdJ6qYG0O3aejTWmcb0bSxklspS28R6fojUqdkhTHH08gMiHgtQ4B13DRs1vlsM6RY0ZawSjYqpya9Wke1K4IRsJKW8ByNJNgZKlmYOzGcafYpDUsbl5y5IM9cdf7MzmIGHmtGIaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5OrcJCg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20960C4CED0;
	Thu, 14 Nov 2024 04:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731557674;
	bh=OGi2dRNe5tO8+2VRnUt3YjU4LnEZeMja9EiwcEWaM7g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h5OrcJCgXXxwvA7j6mOF+WVdHHHIaUEb6bPrmmH8aEkakEF+HDO0GpZiJ9RTPc68S
	 G/edfQWhbg3BSeEVOzrGM7eOEXDz946JASKQvI8RFmMcfDW2wEKqD4koSoEjYkQx+z
	 N1Lg6sOoj7lnv4p2xPiLF3w6GlSarEO1Zwy+nyQ04ELj277kOFr5BswK/2xXZCPH7V
	 p+7fy3UFXLwEGvU6AsBDhHAMKCBmEIAS2Q/vRklKWqII2X6EkQgrUY1/lRzoiavARP
	 pK5GpIs5MOkl4gIfPvpnxOkz3hbOQynjTGbBXmuCdDVyEScw+zAVAfQtJZcq2L7btE
	 7Z7ed07XKdWCA==
Message-ID: <11cae8ab-a46b-47b4-b919-f7021057dc11@kernel.org>
Date: Thu, 14 Nov 2024 13:14:28 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/14] Fix and improve the Rockchip endpoint driver
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241017015849.190271-1-dlemoal@kernel.org>
 <117828c6-92c4-4af4-b47e-f049f9c2cb7b@kernel.org>
 <ed723fe1-e243-4a9e-8d1c-f29461d07cb7@kernel.org>
 <20241113175222.eh76hksyj6sptwvo@thinkpad>
 <20241113205900.GA1184086@rocinante>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241113205900.GA1184086@rocinante>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/14/24 05:59, Krzysztof Wilczyński wrote:
> Hello,
> 
>>>>> These patches were tested using a Pine Rockpro64 board used as an
>>>>> endpoint with the test endpoint function driver and a prototype nvme
>>>>> endpoint function driver.
>>>>
>>>> Ping ? If there are no issues, can we get this queued up ?
>>>
>>> Mani,
>>>
>>> Ping AGAIN !!!!
>>>
>>> I do not see anything queued in pci/next. What is the blocker ?
>>> These patches have been sitting on the list for nearly a month now, PLEASE DO
>>> SOMETHING. Comment or apply, but please reply something.
>>>
>>
>> Damien,
>>
>> Sorry for the late reply. Things got a bit hectic due to company onsite meeting.
>> I'm going through my queue now.
> 
> Thank you, Mani!  I took this over and pulled this series.
> 
> You and Bjorn can have a look over the changes, if you have a moment.  That
> said, at least to me, the changes looked good.

Krzysztof,

Thanks. But the kernel test robot already complained about a build failure for
the rockchip branch. The series needs to go through the endpoint branch as the
.align_addr method is only defined in that branch at the moment.

> 
> 	Krzysztof


-- 
Damien Le Moal
Western Digital Research

