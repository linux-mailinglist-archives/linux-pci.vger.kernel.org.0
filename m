Return-Path: <linux-pci+bounces-28405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6F7AC40FC
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 16:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC62D3ABA0C
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C342F1FE44B;
	Mon, 26 May 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NViilAsC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EEB3C465
	for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748268419; cv=none; b=qCcKSkrNtSk9on4ys30C4kGsHud3fADNRIPF+jUcKgVz+9Uk/U8deVvQVjLUQDGZrkyjNuwMwOhSdZkJAXFVW4nMSnZ8lGlEMwXStH5J52bD8wOfVuj4IZPZSm3KE6RaV7TKmw0vVBy6C+4AxfS5NjVbpxpb/LPuW5stqlF/Heo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748268419; c=relaxed/simple;
	bh=QTeXWNX2iUXDBSxx5jGj9CcIe9hdPTaRCVCOms2e+b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjJvFhCmJWZduyzTYMEIt2zMGIoLUp7piUvpruxbsAeKn4nJ6LhG4s1otPOZaHJFHqDjT//+rdh3PEy5G0I5lqneSpzeQtn1OGd8AegkF6hTt7UeyRf0If7Gi1nN7LWlDJPAjoydGAzSkAPc41rAT5L8ekR4g9juvUIt0FMi5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NViilAsC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a37d24e607so210194f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 07:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748268416; x=1748873216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zUalJN5MUy3YAR3UhbDJtGyL6WBv2slh5mtlXFKO8b0=;
        b=NViilAsCn2xGDAq4FOPQ0O+rbmAKtR1y9M/EpUXRPhsLYuzOnc4Riy0hIuhq6t6l4A
         MVJiy9yv/Tbb/P6gBUY0AgLntktU9C83mf1QrpKce21ajCVDOwq56j4COXFgaN09dCo5
         +9QojH5rRaZ/3TA4K5UBIysnuAe+f4jkOUAPV6/WAdxHtv6EjPYZJPUfYw2e84qcu6yk
         VE3iErTgyIBThBWPVCQeb1PDqNKc1BfV/OGKXZeaA56HLtnjipmEh7LqoIu9Yh8Vpz7C
         n/FTweIowzD4V3cVmaFqDG627iheHLJkajisy2fjAA5QpnJ48+sMO2uCvCIip37F3jiJ
         nuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748268416; x=1748873216;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUalJN5MUy3YAR3UhbDJtGyL6WBv2slh5mtlXFKO8b0=;
        b=B7p8EPfCCeNIFNPW5HUwRJq5dICP0I1lHb14FEcDX9nKgyz6uJLaij9/DyvFoq21CN
         I5atqeB7no1eN6Hpk+jRNt/eORvnAbmjvipla1WSFhyo4q/p9LPVPe5luzIgUu52MDv0
         s91sv1LRFf8V63SpT+CN9kCL8LwYeO5L6OGIIz49oHk0nGLg05fyQw2LEU/XeRDVUasp
         ZRp1V0J77yiQKO6V1Hk6SSF044x2QQYMBSG3XWQd/+voeasYUjjbbY8AZc7epIcnRA0u
         X/B/3rVecCH7s4OyReyfkwRT5zQy8h2m6F+VcqE8iz2jJMUn+HctMIo39+vQV6FJwwYt
         TzxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBeA88AHVfcg2nOA48eIgAySJ8t3i3hjx/5jtcgB0Gn/o/Gges82qFQO8ltay6jaEjkDzE4LO/kGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBB4BFpbbnfGOfoGKB/eVPdq3KaInkD3lpasEtlE5qKEQbelU
	mBfbG85ySgFOe5yrYUvm3c2Zmj4bNG7PgbIxqK5PkAKIJx+bzCq/L1RjOT7HO0h6/9w=
X-Gm-Gg: ASbGnctcHVJnQ+uh1FbARPsQgaEQ+OqOzS59Tdo/9iFHlSt9UUC+8LLs95El9RAsxqw
	wbaKrgRqtLutNOMElUHfOzMRoDkwtj0qbOM/xUoFvVAoo5noCCDgg3o63+pnv+rDdiQ3vgtCwRW
	YhpwRdM2SVxV3kxggNnmZWo1Pljw774/kUGGFdfuu8eFcqNOV8XtygVg1kqcvXF+rY8gzsj306z
	BHnlE7ar3IDKE24zxveFokMJMrev1EjbO/4rZUB8Osbef+kHZ9wua1lFcl6j/nYBJC0KlmNXRgi
	Te0yIQAlpkLkvX4+YhRTYYnMJuTZWnjvgjxXtNeJujbWQ88Xo2Mz
X-Google-Smtp-Source: AGHT+IFn52fIeGag1IWUAYwZ0XrL+fmHEWUQ8gimnAH86GvLzi97W0zr1r99vIRe5MeCAnEzOnrUPA==
X-Received: by 2002:a05:6000:1886:b0:3a4:c909:ce2a with SMTP id ffacd0b85a97d-3a4cb489a8cmr7582347f8f.45.1748268415632;
        Mon, 26 May 2025 07:06:55 -0700 (PDT)
Received: from [192.168.2.177] ([91.116.220.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4db284261sm2418574f8f.67.2025.05.26.07.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 07:06:55 -0700 (PDT)
Message-ID: <3899c82c-d6a7-4daf-889b-b4d7f3185909@suse.com>
Date: Mon, 26 May 2025 16:06:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 -next 08/12] arm64: dts: bcm2712: Add external clock
 for RP1 chipset on Rpi5
To: Andrea della Porta <andrea.porta@suse.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij
 <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
 Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, kernel-list@raspberrypi.com
References: <cover.1745347417.git.andrea.porta@suse.com>
 <38514415df9c174be49e72b88410d56c8de586c5.1745347417.git.andrea.porta@suse.com>
 <aBp1wye0L7swfe1H@apocalypse>
 <96272e42-855c-4acc-ac18-1ae9c5d4617f@broadcom.com>
 <CAO50JKVF6x_=MUuzjhdK0QotcdUgHysMb9v1g0UvWjaJF2fjDA@mail.gmail.com>
 <48AFA657-5683-42A4-888E-3E98A515F3B1@broadcom.com>
 <aCIk40642nXZ3arz@apocalypse>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <aCIk40642nXZ3arz@apocalypse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/05/2025 18:42, Andrea della Porta wrote:
> Hi Florian,
> 
> On 15:02 Mon 12 May     , Florian Fainelli wrote:
>> On May 7, 2025 5:01:05 PM GMT+02:00, Andrea della Porta <andrea.porta@suse.com> wrote:
>>> Hi Florian, to accept the patches, what would work best for you?
>>>
>>> 1) Send only the relevant updated patches (maybe as an entirely new
>>> patchset with
>>>    only those specific patches)
>>
>> Only the updated patches work for me. I don't think there is that much coupling between the DT changes and the non-DT changes (other than without DT entries nothing is activated)
> 
> It's a little bit more involved than that:
> 
> - Patch 7 (misc driver) depends on 6 (RP1 common dts) which in turn
>    depends on 1 (clock binding header). Should be taken by Greg.

Greg gave an Acked-by so I think Florian is good to take that patch. Which 
leaves us to the clock patches (driver + dt-bindings).

> 
> - Patch 9 and 10 (board dts) depends on 6 (RP1 common dts) which again
>    depends on 1 (clock binding header). Should be taken by Florian.
> 
> - Patch 4 (clock driver) depends on 1 (clock binding header) and
>    should be taken by Stephen.
> 

Steven reviewed the patches (driver + dt-binding) so he is waiting for a new 
version which addresses the review. He offered to either take them and provide a 
branch that Florian can merge into his branch or provide a Acked-by tag.

@Florian what would you prefer?

Regards,
Matthias

> So patches 6 and 1 are in common between Florian and Greg, while patch 1
> is in common between everyone in the pool.
> 
> If I uniquely assign the patches in common to one of you, the others
> won't be able to compile their own branch because they will be missing
> the dependent patch.
> 
> If, on the other hand, I duplicate common patches to each of you to
> make the kernel compile for veryone, you should remember that there
> will be conflicts due to duplicated patches among different trees
> down the merge path.
> 
> Any advice about how to proceed is appreciated.
> 
> Many thanks,
> Andrea
> 
>>
>> Florian


