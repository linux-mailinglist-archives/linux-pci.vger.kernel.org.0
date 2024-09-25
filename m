Return-Path: <linux-pci+bounces-13509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3584985662
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 11:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E11BB226C8
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 09:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BEF15B971;
	Wed, 25 Sep 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgJL/c0e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9797913AA53;
	Wed, 25 Sep 2024 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256667; cv=none; b=C++zxxjgXd9Rkp75TCq4Fzh8aFOOG5ymUvQvYr1RExsxkoIIV/5Eb3eVsF3oUcJ45BN/2o2DDtbz+G7qhMRLrh/KHLelwJiI1z8SzO3go46yr5mtSNOrILlO+iTgnOnGv8HynBnqklpgU7akVxEaJTOdKJl1WiquZxSbr+Xo8F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256667; c=relaxed/simple;
	bh=x2JF9xWznc10DmqXgd7CuRvcJk+8ONpVG+QxkOmFgQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OlrRiMg/MODneNK5AvT6IWGxtOtxus+UaRHM9+FIcjQDLnAIt52j1cUshbpvEBsGzHN437yes8Io8CPOnWeXGwOEscXK2B1AGCCIywrYQBRfNsFjljpnBb9a+bc6SDcL1KPWdvJVq+CwJz3eMGXouA6M5iO+ZmikyC/7oPzMzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgJL/c0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D58CC4CEC3;
	Wed, 25 Sep 2024 09:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727256667;
	bh=x2JF9xWznc10DmqXgd7CuRvcJk+8ONpVG+QxkOmFgQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tgJL/c0eI0Pzf2B14LODbJDI0p7Z1IRoiFIPHVUhJmHt29pRVg44j0S6NJ1wu7U+I
	 efHRQyL5Sv494fYPtYfE69s8ypF1aujlHoaBRg0p7w5t903YIkVuKDWp1GxP65ojzj
	 RWtRattmI7qzgQPuwXiYIniC0A5ACI+FZBbRfUiwF2Fx9WHMjvPlSCobdvPNlUZBVF
	 KrGo5EfOPUdKPJhsOVEP/59fecriOcNb5m31bn8CuTbdLXp4XZroRS2m5AF5ByDsmT
	 W0dJJHcjOzgcIY1j63WcVxDr1syWtU9eTvzqiOeytfvuwfmd48Q+dz3o9np34mzgCA
	 26OMZh5GnUnCA==
Message-ID: <4ee4d016-9d68-4925-9f49-e73a4e7fa794@kernel.org>
Date: Wed, 25 Sep 2024 11:30:58 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
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
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240925080522.qwjeyrpjtz64pccx@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.09.2024 10:05 AM, Manivannan Sadhasivam wrote:
> On Tue, Sep 24, 2024 at 04:26:34PM +0200, Konrad Dybcio wrote:
>> On 24.09.2024 12:14 PM, Qiang Yu wrote:
>>> Describe PCIe3 controller and PHY. Also add required system resources like
>>> regulators, clocks, interrupts and registers configuration for PCIe3.
>>>
>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>
>> Qiang, Mani
>>
>> I have a RTS5261 mmc chip on PCIe3 on the Surface Laptop.
> 
> Is it based on x1e80100?

You would think so :P

> 
>> Adding the global irq breaks sdcard detection (the chip still comes
>> up fine) somehow. Removing the irq makes it work again :|
>>
>> I've confirmed that the irq number is correct
>>
> 
> Yeah, I did see some issues with MSI on SM8250 (RB5) when global interrupts are
> enabled and I'm working with the hw folks to understand what is going on. But
> I didn't see the same issues on newer platforms (sa8775p etc...).
> 
> Can you please confirm if the issue is due to MSI not being received from the
> device? Checking the /proc/interrutps is enough.

There's no msi-map for PCIe3. I recall +Johan talking about some sort of
a bug that prevents us from adding it?

Konrad

