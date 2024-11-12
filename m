Return-Path: <linux-pci+bounces-16496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE27C9C4EE5
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 07:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B62B20A85
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 06:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899642038C3;
	Tue, 12 Nov 2024 06:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4CIkATV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DFE1EBFFD;
	Tue, 12 Nov 2024 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393856; cv=none; b=lFOaHk07GsQ0QicnAuPfsyhwROcuVAKE8jIIsqVWtXKLYQTstpBjpBiXa0Cw7KisH6Wc0GaNOiEkQ9Qz5ll/3bh/MN3FfeKeWkZ4kUh+XAOVThjSAYonaikslDh5Pt91pef9VW0ynAfaVR+peJqY7ID3tBRXzwPygyewU+OjZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393856; c=relaxed/simple;
	bh=hwJWEVc7ghPwGe0DpNY16bT1ZRhxSTWdPz4Ev+N2KIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0jkWiGNOGCHNeteGxyLL1KMsou0wom+rjCgq5m2Kjq5lKrxDhEu/WfDE+cAghBGfEMXbO1Ff0GhODZYON7XKveS1CD67zjX7xVmVph3QbQFibZ/J8hNS/c3b3aawr8XoMxbZtg1K59cKobA0BLjq2Vhx/J+B2ltkF8QvklvIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4CIkATV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso898189266b.1;
        Mon, 11 Nov 2024 22:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731393852; x=1731998652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2+/5UGwACNaC6IjDOw3pwIj0bBxgX2UROi6IS3/UwFg=;
        b=V4CIkATVq8tyE/70VFVGc37PRh+AWIlA7JCYtWZDFBAxe7xmKaYK+SA0/kt/403n6v
         20I0mHnaW6DiUvFrkzMr1OeJJQwNkcxJRxzmNRm/yvYnYR8xM7V6C6coxwKp2RJLO15Y
         fQN+huvrJx4hChmMAbGgWVzrhubSDmUk96aBdGu8Fp0sXzznf9Ze4s6ucYGw5bo3gI01
         DuloHutwSHBvqLU1F3ZwsNyathv8lD4LD5Uhllwekf+LSgWH9f4hv9vlEFEhfV1dTqgk
         hjIL5kJWuG/as9KT6rYLtBGeEEcW7EwprSUDeZxPSFXtxkD2Ji/OvYlXSAr01jqtX3gK
         HdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731393852; x=1731998652;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+/5UGwACNaC6IjDOw3pwIj0bBxgX2UROi6IS3/UwFg=;
        b=sugRZ1Lz9u5dSDlcwVoiW4OI/eqjQ3w+gIp6CwZiRSBT5caDZMJThdRdMkmPcEYVem
         HIobiu5pPGxy5aU4VW1DRiwjmEzi7Hi4WtaYL7T+fUx7mp+bCiBrJk9Lxk+jrS2cpkXf
         aiJdFNOYosMa3ZlB6mwj262q3lXZx4wjcjFctKDNGgzmjWCOvqJwejP/XJDmMsB0wg0h
         4Xxe6lszVN+OTSq9FKLbfJnmuoJV05xPEZt41jeVuvwUhBu5ROmmANDW3hD7T1qjjGiR
         t+C1RVXc1BjFeeLCQMiuNxHFpyiM3guB+eIOyNrjlWVm7cPPvSZHOwXEnJLA1aImD5ww
         QQbw==
X-Forwarded-Encrypted: i=1; AJvYcCUH/y8aTtdEyCidBvotVP8rg9tipmKfi21hYcXbgCdLse3gbSLT0AS8SiLH6S0zCCruRVvwLgpJ/Lxb@vger.kernel.org, AJvYcCV+ID8rVUjYheZ1eAf+AjUy2D5rY+1yRh7MQFh5XsMXLN0GU1zyiS2arnNy3NdViy9aTf/hFRK3V7d8pwA=@vger.kernel.org, AJvYcCXdAWbspRNoUtz948OWphZwbKxMb1exczP8p+qwbS7nB/ZZKVYJjx69EApuuTiaChY++GUTjXYL@vger.kernel.org
X-Gm-Message-State: AOJu0YyR9P9RZbBclgrFchgyNpr+/AS0/v5IW/lm7YN1gUjdMTfekmRb
	+8HLLriBVCrjQ/foUOISBjoFxCDXm4WlqCeu17P79HeggjMamUqG
X-Google-Smtp-Source: AGHT+IF9ER6TaYOqPuWullDuUwrp3ovG+UuGX9KAgF6nx5zH87sAF5TYn2wCfnrz5/3B6owAoYmHBg==
X-Received: by 2002:a17:907:980b:b0:a99:92d3:7171 with SMTP id a640c23a62f3a-a9ef0052bf9mr1378610366b.61.1731393851699;
        Mon, 11 Nov 2024 22:44:11 -0800 (PST)
Received: from ?IPV6:2a02:3100:a46e:ea00:ad30:f6ed:5688:e357? (dynamic-2a02-3100-a46e-ea00-ad30-f6ed-5688-e357.310.pool.telefonica.de. [2a02:3100:a46e:ea00:ad30:f6ed:5688:e357])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9ee0e2d979sm686981666b.181.2024.11.11.22.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 22:44:10 -0800 (PST)
Message-ID: <18463054-abcf-4809-870c-051b16234e9c@gmail.com>
Date: Tue, 12 Nov 2024 07:44:09 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] PCI/sysfs: Change read permissions for VPD
 attributes
To: Stephen Hemminger <stephen@networkplumber.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, Ariel Almog <ariela@nvidia.com>,
 Aditya Prabhune <aprabhune@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 Arun Easi <aeasi@marvell.com>, Jonathan Chocron <jonnyc@amazon.com>,
 Bert Kenward <bkenward@solarflare.com>, Matt Carlson
 <mcarlson@broadcom.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Jean Delvare <jdelvare@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <f93e6b2393301df6ac960ef6891b1b2812da67f3.1731005223.git.leonro@nvidia.com>
 <20241111204104.GA1817395@bhelgaas> <20241111163430.7fad2a2a@hermes.local>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20241111163430.7fad2a2a@hermes.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.11.2024 01:34, Stephen Hemminger wrote:
> On Mon, 11 Nov 2024 14:41:04 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
>> On Thu, Nov 07, 2024 at 08:56:56PM +0200, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>> The Vital Product Data (VPD) attribute is not readable by regular
>>> user without root permissions. Such restriction is not really needed
>>> for many devices in the world, as data presented in that VPD is not
>>> sensitive and access to the HW is safe and tested.
>>>
>>> This change aligns the permissions of the VPD attribute to be accessible
>>> for read by all users, while write being restricted to root only.
>>>
>>> For the driver, there is a need to opt-in in order to allow this
>>> functionality.  
>>
>> I don't think the use case is very strong (and not included at all
>> here).
>>
>> If we do need to do this, I think it's a property of the device, not
>> the driver.
> 
> I remember some broken PCI devices, which will crash if VPD is read.
> Probably not worth opening this can of worms.

These crashes shouldn't occur any longer. There are two problematic cases:
1. Reading past end of VPD
   This used to crash certain devices and was fixed by stop reading at
   the VPD end tag.
2. Accessing VPD if device firmware isn't correctly loaded and initialized
   This affects certain LSI devices, which are blacklisted so that PCI core
   prevents VPD access.


