Return-Path: <linux-pci+bounces-3491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D3285622E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 093AF28A622
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1781612B159;
	Thu, 15 Feb 2024 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3FWjtI1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D0112B141
	for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997904; cv=none; b=f9Gy3jq1QiWcaSxYKO3Pc/if5Uu8TXYL1AUIT49s4/W85qyw9uDestmTBpyoWQy5TUcw2vRbMSnRfI3pjoYsgWe3FNMrhSX6VDXYLfZA8wMjuyeLh+mtQ9gGOo1ISh+0Phxb/HqjmfMP1uH+4lE1qpRpwZJtkVptViBPpB5cg4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997904; c=relaxed/simple;
	bh=LfXbtTyJfdBafr8Nmb/3/6uRpRigTCz4GIYDnBXXRhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgu68Z8BaqUeE/BLtW/R4Z8bCv5EOc+dGXfKpgfM69DES6kvOrm4TdsuZmDDSbuflvMLqsADrxuNTCQyq7LNT6Nu7kZCfs68OJWposalStS196MTpqbdlMexEZaWZYjXIxSXE0fxgpVF2COu4M7Z1GifkZH9Sf346j03D/ad/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T3FWjtI1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5620c778052so1009173a12.0
        for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 03:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707997900; x=1708602700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7H+soaEw6AcQrP6dkKX2lz7OFWQ/K5+K149F+3iyFsI=;
        b=T3FWjtI1j78RvW3MYl5zOur1ThCwbbEe3dQ34YI4GuINLrckDKdd6aL3FBphqzn8kk
         MvqdWGydX8ZAU/rpbnCbd4uxNMDHOO6eymqpEDHzxWQKSEv84MElvnY2KhNCNhZMqad8
         tdsUVFBf3gtWwF6eQiklV5agAXBV48R8SM9acFTfLYJEv+Ro1IOokgTow9TaYJIo/8Pd
         AWt6RWZsG36eP1GhxZ/LtKrGl5LxriDPbV1lDbMUAyjEZwBasrWRcOMUxAz+FhxVbi/Z
         4NTXKoz+uU5rdRCjx3xvXefo2FEHnQH2TMOiFj54Z9IlwUY5rotp93N7v1LD8J18tpat
         Z3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707997900; x=1708602700;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7H+soaEw6AcQrP6dkKX2lz7OFWQ/K5+K149F+3iyFsI=;
        b=voccdM0BMdrb0mi6w8Lv4wscPAOBraERu/ohG1jOkcvV2NroFRaeVOl3NLHg+aMmJn
         yqRnuePhFBCS5i6olJtsKvscwbKDpz+undRoociYIOvfQM6pnMbyk55d2B9BbzgVx5C6
         HSC/zzOWpwuChGOJYo+k3bBxFcD3RRurq39ccWkJX3MXWe8oU59U//6WHEezIauu7ut8
         P9t2J6BwSpRr9MXrrKSROekmI01xnK7jIVThEgfcqEuA3hT8C0eskFQQRP9CAw8Y9mik
         ZeC7pizCIOLaawZDLUu6OUoajmnLYB8ijvEFywphO46x3wap9AvBDabTiKD4DQ5YQXHx
         AV1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaU0Mz+Kzh/ROvMht6f3TEcJHDZZW/FGTfsJNUAlbSHezrsI39ubPB4KBtloFoot3k80HG0dP5qf91Ou85sGInHDizRCyOPH4y
X-Gm-Message-State: AOJu0YxhSRIgS+oSD5CUBVl935mgHYrkbm/w9vmTX9ZitTmxczLr9/Xb
	TvrmXQbgOZP3xxYxiUI6ryp3O90cqBeDEHCAXA71xURtyJj/0m9A04sgwcXXyie96hyRV329ycM
	k
X-Google-Smtp-Source: AGHT+IFjyC4fiPAQVmXxyzWZpj/0Aye/E/BmLR4+E7Dz0O8nwav1eQvhRJqj2FBIT0xcCBO7N91rEA==
X-Received: by 2002:a17:906:a8c:b0:a3d:14d0:f253 with SMTP id y12-20020a1709060a8c00b00a3d14d0f253mr1169320ejf.9.1707997900535;
        Thu, 15 Feb 2024 03:51:40 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id ss11-20020a170907c00b00b00a3c625064e5sm462042ejc.100.2024.02.15.03.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 03:51:40 -0800 (PST)
Message-ID: <bfdb5271-8c1e-48f0-8589-deaddf50117c@linaro.org>
Date: Thu, 15 Feb 2024 12:51:38 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] PCI: qcom: reshuffle reset logic in 2_7_0 .init
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <20240212211432.GA1145620@bhelgaas>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240212211432.GA1145620@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.02.2024 22:14, Bjorn Helgaas wrote:
> Would be nice to have a hint in the subject line about what this does.
> Also capitalize to match the others ("PCI: qcom: <Capitalized verb>").
> 
> On Sat, Feb 10, 2024 at 06:10:05PM +0100, Konrad Dybcio wrote:
>> At least on SC8280XP, if the PCIe reset is asserted, the corresponding
>> AUX_CLK will be stuck at 'off'. This has not been an issue so far,
>> since the reset is both left de-asserted by the previous boot stages
>> and the driver only toggles it briefly in .init.
>>
>> As part of the upcoming suspend prodecure however, the reset will be
>> held asserted.
> 
> s/prodecure/procedure/

Before I get around to resending, does the commit look fine otherwise?

Konrad

