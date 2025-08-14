Return-Path: <linux-pci+bounces-34042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5ECB2652B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 14:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D46183A7C0F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 12:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C5A2FCBEB;
	Thu, 14 Aug 2025 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="KWboGCmW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C665A1F582A
	for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173748; cv=none; b=hSMoL3vNEL76IWfxESF2lf/yKG4gCCwiapezF0KEgcVpCq1ReHU8NfpBHxHDwJ340LlHXNMNK62QKwm1RbtWxz4Kn4r9FFZRSr+l5/IIM8M/HyzjG4m3ZN7oEzcIsWb4Uy1b3Zp+tUJBtTPFr6c1esNJW6+IM3P2ZyDHOIcte7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173748; c=relaxed/simple;
	bh=7ez/y9SoR7GgwvoO0othTBNuBdwFuPF00uw0mKgomx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxfdBiYfVSx9pCGYOWdc+TC9ak930DV3V1sdjNjb7aQPiHEOkc6YNIW0KjOEh1qmqFhKTYqWDIlGpXMZi4wkw85uYIVRrmjQ0sMwYP57TEJfWc57/I+neLFt0PtZyDJeBC0UjyAhHXvkeZh+nPOR/fsy9PFeemRxVlHGaVI1K1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=KWboGCmW; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-88432e29adcso20406939f.2
        for <linux-pci@vger.kernel.org>; Thu, 14 Aug 2025 05:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755173746; x=1755778546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jH/A5TldJIt0r8HRzTTERB8tMOGIsMMgINBB+z4/hxw=;
        b=KWboGCmW2r2Ok3o1uFo3UCKfUr4Umu5rmWZT8M0mSv8Wdf3noCnvZKzy5nu2OE6Wkt
         alWfxgekgp08tUPxc3IHD+zt97zrfPxoNtDQBmcej+Mzw6O2Sywuh1E7WjmRd93+CnEI
         593IRj8G+wurx0rykj8BbrdW95Wro9jbRybFYYo0XzsuN9oJaJoSe52GvGEh7lDIJi5w
         CVFZUvRJGbx7e+j68G6Vd80sain+wJvbit34eGC4kIxGHaBarpfTzSmGQscX5lQJFtCr
         9OMGffYigIHiT1lSgh9bTHJGar31UWoVYCoWgFdJptH+IItfuUkGTHxEBiOhyBk0EO/u
         EodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755173746; x=1755778546;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jH/A5TldJIt0r8HRzTTERB8tMOGIsMMgINBB+z4/hxw=;
        b=VzyeSJzYxXfOISnNTL78H5gy9ITUoLINVYDxHzeH5IqOzagcGU4RgqJYQnjq+JnWdu
         +1jfREaMV8wFSP3lCwMG4YXT+ijSpSeDLBSZf1iQHaxJg+pcW7MzVk2Fwa7Xgjl7AvaM
         GkgmVLcGLrikiso3f3BdL6j47fBob/MVrKGQt0XQtTZLKbEJsgAZltK15T2jfx3pcg0B
         3mtgFdDRENNSiOWQMYU4IUr5h/1myW+s38fAs+0k7mYDKZ55qlj/ZCJuvdFL4h9Cg2T9
         eZfQJRKSdYkPVM1hWvKDNS9B2FMDeqcV3m1lwg0ABs1F/wGpbClLxloGJ1dgZTAH3Glj
         ESeA==
X-Forwarded-Encrypted: i=1; AJvYcCUW9U5qeDtCYAD/xGImdNcFM6l7+yWoSGEsHgEjmdDrOfa4Es8bJQM2DDphIXpnDyvlLnqGYMutAKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzBk82Kqf7h+x+/Kf1Z6++W7WAi6guYg/bdX8HGHhk8P+slTP
	Zkansw9RhsoKdOHdUp4GzQHiiFxcZ9XV5BwXBEHlQcl9f5/S0sOHQ+UmxhT3sh7r88s=
X-Gm-Gg: ASbGnctjLFLaXYQKz6JyBxBJs6FvvVGN/SUKSHoD05Ke7Hb95SyRSkddjmJFRNaEmSO
	zzClG9mgUGGeJBSwcMLOx2BD9A2MeGttACCaFHNw2jHn52758LS9/l0gZagetRBgL9GC97ZmWqE
	rfjjbuFmrF+ZUsKGk3yyLn1ZaVQVaRuXnY6M2XiJS9QptGcCc08zuNHrWdOFV7e4lK33OHAu8n/
	nGk2LhXJTQ5bJOBZ0Q3iD9slfPyVFrGzyh8vnoTYfbPghVL90Kq58gvtkMM+GSYQDNiOQfDSlZj
	frtUKtski5ZAJiHURcqkooRKn2HKXXdTijmwxigR+2gkTiN06olghduFjmkznAQ/Z2guFl57nYh
	abUii1fT/FS3cB/Eh/QnODqMUmVKKN4zTsr4ak5ZQVfQkrp3sBI6bxMO4ejr5Uw==
X-Google-Smtp-Source: AGHT+IEk5Gf6e1UB1FErhDDdp2cqW5OM5qB7djdZQAW5/M0csvkRq5HHXBwlwGdJnT74jfJk+RYeIA==
X-Received: by 2002:a05:6e02:3bc7:b0:3e5:4631:54a5 with SMTP id e9e14a558f8ab-3e5709835e8mr60618705ab.18.1755173745691;
        Thu, 14 Aug 2025 05:15:45 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e55b077b34sm27683845ab.51.2025.08.14.05.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 05:15:45 -0700 (PDT)
Message-ID: <4eaa30bc-9a25-4fe0-b685-1d0d8fa503c2@riscstar.com>
Date: Thu, 14 Aug 2025 07:15:43 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] phy: spacemit: introduce PCIe/combo PHY
To: Inochi Amaoto <inochiama@gmail.com>, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 vkoul@kernel.org, kishon@kernel.org
Cc: dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
 tglx@linutronix.de, johan+linaro@kernel.org, thippeswamy.havalige@amd.com,
 namcao@linutronix.de, mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
 quic_schintav@quicinc.com, fan.ni@samsung.com, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Junzhong Pan <panjunzhong@linux.spacemit.com>
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-5-elder@riscstar.com>
 <valmrbddij2dn4fjxefr46zud2u6eco2isyaa62sd66d27foyl@4hrhafqftgb5>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <valmrbddij2dn4fjxefr46zud2u6eco2isyaa62sd66d27foyl@4hrhafqftgb5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/25 6:42 PM, Inochi Amaoto wrote:
> On Wed, Aug 13, 2025 at 01:46:58PM -0500, Alex Elder wrote:
>> Introduce a driver that supports three PHYs found on the SpacemiT
>> K1 SoC.  The first PHY is a combo PHY that can be configured for
>> use for either USB 3 or PCIe.  The other two PHYs support PCIe
>> only.
>>
>> All three PHYs must be programmed with an 8 bit receiver termination
>> value, which must be determined dynamically; only the combo PHY is
>> able to determine this value.  The combo PHY performs a special
>> calibration step at probe time to discover this, and that value is
>> used to program each PHY that operates in PCIe mode.  The combo
>> PHY must therefore be probed--first--if either of the PCIe-only
>> PHYs will be used.
>>
>> During normal operation, the USB or PCIe driver using the PHY must
>> ensure clocks and resets are set up properly.  However clocks are
>> enabled and resets are de-asserted temporarily by this driver to
>> perform the calibration step on the combo PHY.
>>
>> Tested-by: Junzhong Pan <panjunzhong@linux.spacemit.com>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/phy/Kconfig                |  11 +
>>   drivers/phy/Makefile               |   1 +
>>   drivers/phy/phy-spacemit-k1-pcie.c | 639 +++++++++++++++++++++++++++++
>>   3 files changed, 651 insertions(+)
>>   create mode 100644 drivers/phy/phy-spacemit-k1-pcie.c

. . .

>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>> index c670a8dac4680..20f0078e543c7 100644
>> --- a/drivers/phy/Makefile
>> +++ b/drivers/phy/Makefile

. . .

>> +static int k1_pcie_pll_lock(struct k1_pcie_phy *k1_phy, bool pcie)
>> +{
>> +	u32 val = pcie ? CFG_FORCE_RCV_RETRY : 0;
>> +	void __iomem *virt;
>> +
>> +	writel(val, k1_phy->regs + PCIE_RC_DONE_STATUS);
>> +
>> +	/*
>> +	 * Wait for indication the PHY PLL is locked.  Lanes for ports
>> +	 * B and C share a PLL, so it's enough to sample just lane 0.
>> +	 */
>> +	virt = k1_phy->regs + PCIE_PU_ADDR_CLK_CFG;	/* Lane 0 */
>> +
>> +	return readl_poll_timeout(virt, val, val & PLL_READY,
>> +				  POLL_DELAY, PLL_TIMEOUT);
>> +}
>> +
> 
> Can we use standard clk_ops and clk_mux to normalize this process?

I understand you're suggesting that we represent this as a clock.

Can you be more specific about how you suggest I do that?

For example, are you suggesting I create a separate clock driver
for this one PLL (in each PCIe register space)?

Or do you mean use clock structures and callbacks within this
driver to represent this?

I'm just not sure what you have in mind, and the two options I
mention seem a lot more complicated than this one function.

Thanks.

					-Alex

> Regards,
> Inochi


