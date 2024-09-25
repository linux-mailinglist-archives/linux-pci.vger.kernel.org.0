Return-Path: <linux-pci+bounces-13510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D44985699
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 11:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 697F6B23180
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 09:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F1813DDB9;
	Wed, 25 Sep 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMl089XN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785F128F3;
	Wed, 25 Sep 2024 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257605; cv=none; b=k+i9b8/KZHTtVKtAbGdU7mBYigcfr1jXYt1VU4Sv8Hs8eBIIEZdSVEgvEW01zkHDcCQ+gDjwF+f1zOfAqmmMxCIgCd47Paj+w5AssrK6wN9sUe4bdcyOVcFL3YojeQXZhI4ElQ2XtJX9WkNM1Qg0a3CJHk2XT2u8jvlQqkvVvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257605; c=relaxed/simple;
	bh=wtn5+KuMLTAqeZweMoRuxkoCjg49C5loEg74Pkq8niU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDkzo5gNF/uMNfbk0Lvk1ISlm1kFHXsqqKvAU/p/BNoA6tiF1G2qE4gVyTxvgGIz3Ly02BcG68gFh2WM9arnXIgs1dD1Ii3Z12CIxcdUtM9gqcfaS5viI23MUPr1yZk8eTzha1ziUXS8m9IOGp2FS2n5TNc8UXWp+fWgr5LnhSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMl089XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EA2C4CEC3;
	Wed, 25 Sep 2024 09:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727257605;
	bh=wtn5+KuMLTAqeZweMoRuxkoCjg49C5loEg74Pkq8niU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rMl089XNFRAEGqGjifzGH4vHmkqYCn0PuSiSSxoa44g9uXf9m4QFeUwMFyWZ4/Jrl
	 RaWXD3u0L8Qt22vg1xvfKfhEXnEe51XdG2dZYT7Xw1P6J0/FadUCOm49X5dW6kf4zE
	 hT1lEuWPSW5mbij8dbwOKHzfa5Rhyr+ZhFoZ6OxzHE3IZeYZhDa2sRoSDqE7jqdSA0
	 8gz/HaruwpjM77EOo8nPk4GT+zFAAKpD8cMPuedCRqi+afrz3e5QVRuyl59+Rc3uXE
	 +tjJZ18viIKSWYX490NH6d9/dZcdd2dpWfj8j/G2Tee3pwbN31N28qqnWwHoIfyStT
	 leX5AWRIOWgAA==
Message-ID: <2731e17d-c1ad-4fb4-ab60-82ceafeffbaf@kernel.org>
Date: Wed, 25 Sep 2024 11:46:35 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
To: Konrad Dybcio <konradybcio@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Johan Hovold <johan+linaro@kernel.org>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, andersson@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 abel.vesa@linaro.org, quic_msarkar@quicinc.com, quic_devipriy@quicinc.com,
 dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
 neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-7-quic_qianyu@quicinc.com>
 <9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org>
 <20240925080522.qwjeyrpjtz64pccx@thinkpad>
 <4ee4d016-9d68-4925-9f49-e73a4e7fa794@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <4ee4d016-9d68-4925-9f49-e73a4e7fa794@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.09.2024 11:30 AM, Konrad Dybcio wrote:
> On 25.09.2024 10:05 AM, Manivannan Sadhasivam wrote:
>> On Tue, Sep 24, 2024 at 04:26:34PM +0200, Konrad Dybcio wrote:
>>> On 24.09.2024 12:14 PM, Qiang Yu wrote:
>>>> Describe PCIe3 controller and PHY. Also add required system resources like
>>>> regulators, clocks, interrupts and registers configuration for PCIe3.
>>>>
>>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> ---
>>>
>>> Qiang, Mani
>>>
>>> I have a RTS5261 mmc chip on PCIe3 on the Surface Laptop.
>>
>> Is it based on x1e80100?
> 
> You would think so :P
> 
>>
>>> Adding the global irq breaks sdcard detection (the chip still comes
>>> up fine) somehow. Removing the irq makes it work again :|
>>>
>>> I've confirmed that the irq number is correct
>>>
>>
>> Yeah, I did see some issues with MSI on SM8250 (RB5) when global interrupts are
>> enabled and I'm working with the hw folks to understand what is going on. But
>> I didn't see the same issues on newer platforms (sa8775p etc...).
>>
>> Can you please confirm if the issue is due to MSI not being received from the
>> device? Checking the /proc/interrutps is enough.
> 
> There's no msi-map for PCIe3. I recall +Johan talking about some sort of
> a bug that prevents us from adding it?

Unless you just meant the msi0..=7 interrupts, then yeah, I only get one irq
event with "global" in place and it seems to never get more

Konrad

