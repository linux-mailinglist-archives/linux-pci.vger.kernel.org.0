Return-Path: <linux-pci+bounces-5288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD188EF5C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 20:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8466B26C36
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6F114A634;
	Wed, 27 Mar 2024 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwS9S3ir"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035812F38A
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568268; cv=none; b=KaTsh/cnP0ttoodujYNDTD/OR/huK+LAAwcCcDsSclOFpwx+2nnoPs8aqXtQg3L3XoTEiYwtkVu8degVZCALfJcwuXeStYFBkPBhw9OAzUfn7xqONz/mSZxiFnh3598XNHTxTwprxI1lvFPEzgMHm133D45rknkf1P/n/FZqsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568268; c=relaxed/simple;
	bh=2gqZ4R2kRz1uznHqor1WK2GlQpJzKrC2SE0LyqyvmYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tq4Rx3xAELNf6+2mKEw1TACtlUfsu0wHXTK0W0GNz5BaKUe/EmIRVHtvAgQpmBzQUCZWRRLTxW5aezvnhOaitUkNZ+n+Vb/gb34QlIgXBQCiu5COpT9aELwcIdfZ+1OrJ3eHmgGWmspK+WmnQqudb45yJZBsDgpdxUBejPFJzaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QwS9S3ir; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512e4f4e463so178290e87.1
        for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711568265; x=1712173065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dzIicXHMZ050qTLYUr+hlMJXN5VMIm4RTBB+qAp88c4=;
        b=QwS9S3ir3Cf7b8aflI4zEEKy2c28C9K87cz5YrYzldHkjz2vV3X85d8DM5u7WV6xe5
         kx9gxgC7yBRyL2fObiRku/ZBQ76FRKIBb3+YW0ehwW1h/Q/NFJTwpGER3N1sS73Y4j+3
         PtlYFA8ZlR23HpSOZSOpjd2CvpXno3ssJq6DfsJZXaKf5XzDQOUx00gdI5ZLJOISjn2u
         zntNFhPx0MKAz1dCy+NOUjBRzK3QXLu9cSxZz/bxpYXB32FAg1Yn8naGxjGuuw6nC44U
         lY0mCYpSIYe4uC++NnfdtmIObsjCpghqN8GowootOwFut4kENtu7y/WJHWi4/cTuuR6h
         +yIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711568265; x=1712173065;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzIicXHMZ050qTLYUr+hlMJXN5VMIm4RTBB+qAp88c4=;
        b=phKC1pJIUatuAfWq6VG1gWkKm++KfeMOn2OYk4PHUnTOWqpVdm5X3vWr0K1PHTxKuE
         AxK7vH5g2ireczjBwkrSh+U8sPVTmCDbHWL6rGbgw8zql6KN48RO8pilXQqpG2qfv8br
         FBJyluyhg2M6hWFbFe4TXwX/iqrAhUQknR0CvalpInIUEcMB0WdSAA9KI8r6aTxnD2QL
         YygWGy2P6HVatL4n1Euoh4C3kU/EVisvBQvAfXt6SEJvffPO2WaV7pLGcybYnEHVAhlg
         pPfUAQPL1kWJru3iEDbmEoD8hP9cm6QLV1M2LhcL8POLjiB6OqEHikUpm5i0WPMJd51V
         fNVw==
X-Forwarded-Encrypted: i=1; AJvYcCUmbJQqEMatCW80QQM8W4bpqX7pHLdTzYFL+EQvLb1Q668XKxWajrwaPkj0JOlz7BvQgOlDkHvwM9QU3hf6tre14MOUV18xLhIO
X-Gm-Message-State: AOJu0YyUlhuuKU3sEyGxTb7tiFd8xB2i4LySWx4eieew6HHWmYMpLH59
	skA9plNDv+hT+LEIAA1kJIw7s05auQFrw7YCPU9A5SxDCE3qBB5rHIw5v0WPbeA=
X-Google-Smtp-Source: AGHT+IEf6n8+HGB5mPHNgIKF1cfGwXBuWdfrKeOX34punTu2BHULBlgFX79zgN9ioE38kwy+ZKWXww==
X-Received: by 2002:a19:5e4b:0:b0:513:21a9:79a8 with SMTP id z11-20020a195e4b000000b0051321a979a8mr242105lfi.62.1711568264830;
        Wed, 27 Mar 2024 12:37:44 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id lm9-20020a170906980900b00a4761c94a5esm4327268ejb.107.2024.03.27.12.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 12:37:44 -0700 (PDT)
Message-ID: <11a193b1-7a3f-43ca-b885-cac8fdf2190b@linaro.org>
Date: Wed, 27 Mar 2024 20:37:43 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: qcom: Read back PARF_LTSSM register
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Andersson
 <andersson@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <20240215161114.GA1292081@bhelgaas>
 <bc7d9859-f7ec-41c5-8a9e-170ccdfff46a@linaro.org>
 <Zc8GHrgdF7jJBgyu@hovoldconsulting.com>
 <c1f85249-32b1-41e2-adc3-5aa4ad7609b9@linaro.org>
 <ZfR7uCcflCiFTvBh@hovoldconsulting.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZfR7uCcflCiFTvBh@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.03.2024 5:47 PM, Johan Hovold wrote:
> On Fri, Mar 15, 2024 at 11:16:59AM +0100, Konrad Dybcio wrote:
>> On 2/16/24 07:52, Johan Hovold wrote:
> 
>>> This makes no sense. As Bjorn already said, you're just polling for the
>>> link to come up (for a second). And unless you have something else that
>>> depends on the write to have reached the device, there is no need to
>>> read it back. It's not going to be cached indefinitely if that's what
>>> you fear.
>>
>> The point is, if we know that the hardware is expected to return "done"
>> within the polling timeout value of receiving the request to do so, we
>> are actively taking away an unknown amount of time from that timeout.
> 
> We're talking about microseconds, not milliseconds or seconds as you
> seem to believe.
> 
>> So, if the polling condition becomes true after 980ms, but due to write
>> buffering the value reached the PCIe hardware after 21 ms, we're gonna
>> hit a timeout. Or under truly extreme circumstances, the polling may
>> time out before the write has even arrived at the PCIe hw.
> 
> So the write latency is not an issue here.

Right, I'm willing to believe the CPU will kick the can down the road
for this long. I'll drop this.

Konrad

