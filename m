Return-Path: <linux-pci+bounces-3466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 550598554D8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 22:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F99CB28294
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 21:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E4313EFF3;
	Wed, 14 Feb 2024 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ui2XcTJW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E76134740
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707946405; cv=none; b=a2F5iGjJKWtmx5scidO7vhzUxFQeY7A2fSD1SaavU4gSrPGfvF2lrII3HSeuWURcXgeY21PEIaSYyol6dy31KyZ719SQXoG/hhjZbyC248mcrSLgltydK+8y6HupW2SyjvGVZiPsNGrThUYONsNK5D153GDznr5o37FhFEQKkWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707946405; c=relaxed/simple;
	bh=xxyACrWt2PwJkS0pdU4dWiP6K7ZzMm9WVJSfh/427dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9icroBE8k/w55amJB691kPhunjAeSKULcorOQFMUKfsaUyY+HuBHEZEPnOpu8pLGuyoBIOnPx4RCxuX85bDp+krroA7GxiF4CfKt45K/r6qfZ+bLkIR3yi/xHhFp53d8XJJcf1qrwXpZb2ZcsKvHGMW46IszBPpzTDXA8BCzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ui2XcTJW; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso273076a12.3
        for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 13:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707946402; x=1708551202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUHzAymlINFHw4AT1ThDN8yqkHJxGPn+LrVpBC58mtc=;
        b=Ui2XcTJWlnCKiCK9wTmt1fClG1Jr0CCieLV3JxtESualYR86iXtTFwFFyu1rF49Cnh
         ATns1+2nPxkeGfxaCVZcfJwFWgGRD19ihTAe7zZ7tAq75OFdR4oCAAvGlfd+Hq3kGmj0
         GvWWVbZ5knc+p2ZtHT30Ey+8Yd2BzQ5F5Y5U4eKzB3e6pdJjckD//HJdMkSa94cqdX/I
         +NBwo8QH1NWhvi1w+NX4er7eHMpAk/t1pNZ8Rj6FaxYp64Oyuf9TojLEifHDc9GqDMs+
         tsDJ8/H1PcgGZNhEIRliKMeCATbSEpaftuGDM///VWkh5zMVaXvUCWWGmEJrnPhKw6x2
         cRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707946402; x=1708551202;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUHzAymlINFHw4AT1ThDN8yqkHJxGPn+LrVpBC58mtc=;
        b=N3rkdNrRliCkc9Cf9uK7QtJZ4Md7q5mKFavkrP+ScrIHXutdrPE9zboW2mzab0DNpu
         kLcM3S6TUZD489tJpqML1581XCy0sDUzSxGElnwkeG4iRF1dsSkFDqLCt/ttkG7AR1wA
         YnPHcLDdhQUJ0ISZl2+Q941u/+nry2jx2zhdw/jYtx8g39Dq0zhpf8LxlrKHYVt5a4oD
         vHAO75+NRLSSm7l/B9Z5Kg2ZYihNv13S4hZqEKGrHhgNc5PWC7U0vXHS3nCzGR0Ijld4
         tuMYrNCFLYLPh8WTr1A+6DQp2rbRXb85/sFQb3s8h/9FL/G4Rxfus08KVJDf5EtzGP2C
         aP9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOLxVKyefg65qGme4a2KJO/3rb4LI66zIJPxIUqyIq8luo7PtFmu6WbSegXgVYb5bomvw5q3HxLayXFtn/4mHJeDbgg6Fb1baF
X-Gm-Message-State: AOJu0Yz+6Pn7YW7E00A0pKKfriLdLTERTIZDv9HYKqXYmEQYMKUD+hvL
	c3FQ2TKRZTKgkbhysdtSsXP5RC0HcxkmNXfgMEUT9EPxd5J31HS8aDG3e5uz+XI=
X-Google-Smtp-Source: AGHT+IH6oW3hMniMs7BZaUCXOI7d7wMy8AfX3ii+mWNpaRLanp1gpdeeS4h2MkrK+l8K1r2rsQL2zg==
X-Received: by 2002:a05:6402:22ca:b0:562:9e4f:6bd1 with SMTP id dm10-20020a05640222ca00b005629e4f6bd1mr2095725edb.9.1707946401721;
        Wed, 14 Feb 2024 13:33:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV+Y3B+Y40sfv2m3w7vtPBrJH3hXIBXNY7dZUsceCxzt2z7Qps2IJ5AGUnvODHwj98JB3VjhvYKqM71fmtxpXg1rUG1Arb8RWZKUy+NmIrRyxSTTjR3rf0QEobGyFkEd4Kgeocr4k6LZ3XPbYLbEWuIHSjC1rX4LMggc4DQ40q9EMmeNC/ECJwwsIMZSIkTRB5RElp8O1ys8vJjAB8iQ0pdYTKPxT5y2boe7u8LZn2B+EwzJdJq9SMzQkiXOxRz8DaqrWVV1Ir8nJijSaE86v2gWveuXfinBfWQKGTReb8OcV9dBdwt7PmcyaY5hZzkxPFgdFy9Eb3UfYJwNbTIly213RGojN27SSoedBHOEWSfAM+RX6wHEtMI8PvoJK63TuXqfmrLJC5nDI2GfnyfsOQOI6V9kV8SdnZQHgZD0/Xp
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7de82000000b005621b45daffsm1159426edv.28.2024.02.14.13.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 13:33:21 -0800 (PST)
Message-ID: <27560098-ced3-4672-bc60-6c1b7c0dc807@linaro.org>
Date: Wed, 14 Feb 2024 22:33:19 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI: qcom: properly implement RC shutdown/power up
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20240212213216.GA1145794@bhelgaas>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240212213216.GA1145794@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.02.2024 22:32, Bjorn Helgaas wrote:
> "Properly" is a noise word that suggests "we're doing it right this
> time" but doesn't hint at what actually makes this better.
> 
> On Sat, Feb 10, 2024 at 06:10:07PM +0100, Konrad Dybcio wrote:
>> Currently, we've only been minimizing the power draw while keeping the
>> RC up at all times. This is suboptimal, as it draws a whole lot of power
>> and prevents the SoC from power collapsing.
> 
> Is "power collapse" a technical term specific to this device, or is
> there some more common term that could be used?  I assume the fact
> that the RC remains powered precludes some lower power state of the
> entire SoC?

That's spot on, "power collapse" commonly refers to shutting down as many
parts of the SoC as possible, in order to achieve miliwatt-order power draw.


> 
>> Implement full shutdown and re-initialization to allow for powering off
>> the controller.
>>
>> This is mainly indended for SC8280XP with a broken power rail setup,
>> which requires a full RC shutdown/reinit in order to reach SoC-wide
>> power collapse, but sleeping is generally better than not sleeping and
>> less destructive suspend can be implemented later for platforms that
>> support it.
> 
> s/indended/intended/
> 
>>  config PCIE_QCOM
>>  	bool "Qualcomm PCIe controller (host mode)"
>>  	depends on OF && (ARCH_QCOM || COMPILE_TEST)
>> +	depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=n
> 
> Just out of curiosity since I'm not a Kconfig expert, what does
> "depends on X || X=n" mean?  

"not a module"

> 
> I guess it's different from
> "depends on (QCOM_COMMAND_DB || !QCOM_COMMAND_DB)", which I also see
> used for QCOM_RPMH?

Yep

> 
> Does this reduce compile testing?  I see COMPILE_TEST mentioned in a
> few other QCOM_COMMAND_DB dependencies.

I can add "&& COMPILE_TEST", yeah

> 
>> +	ret_l23 = readl_poll_timeout(pcie->parf + PARF_PM_STTS, val,
>> +				     val & PM_ENTER_L23, 10000, 100000);
> 
> Are these timeout values rooted in some PCIe or Qcom spec?  Would be
> nice to have a spec citation or other reason for choosing these
> values.
> 
>> +	reset_control_assert(res->rst);
>> +	usleep_range(2000, 2500);
> 
> Ditto, some kind of citation would be nice.

Both are magic values coming from Qualcomm BSP, that we suppose
we can safely assume (and that's a two-level assumption at this
point, I know..) is going to work fine, as it does so on millions
of shipped devices.

Maybe Mani or Bjorn A can find something interesting in the documentation.

Konrad

