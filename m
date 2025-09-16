Return-Path: <linux-pci+bounces-36305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 415C8B5A37C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 22:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABAE21BC3447
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 20:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2D8278771;
	Tue, 16 Sep 2025 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYGwE6KE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0631BC89
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056187; cv=none; b=hbFp2OtLLOHvieRv/Ca1ILxVo/cd3mQPDeo9fN3rIsvpbBD9pCiS/gw7SFJIxow8fk9W8T9WpMYLLAX1dj42qHr6O++c/6ZC4nLFGXYeJKTXC+o1jzYKDtyhBUjwmJROtXSwy0aQq8/qKUhi+/lp5KLEcadIzVno5OntQgSB/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056187; c=relaxed/simple;
	bh=IEXzLdo+fifSjJiTGFmuvMOjPLyCYOppL/97VmjkW5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZQk0YryE+Wi/KD8VfENuK08UB/aso6kmC1PyDDA3px8gTYmdiqrJ08b2nxq0O2K5bhwzCSeBlnJ6EdkIGKJooqdsncJ0HPUOazLBpcVXGrnWLAdVRYAVGjUdfU9qpCMjYC/m3T/vXpOOHU6rNeBFnadf4p9sxqzwy97d4DPysE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYGwE6KE; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3eb3f05c35bso1997740f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758056183; x=1758660983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tST7ChoMLtpPZGS95Y8CJgYhrNYZbL3f0dl6p0aVNAo=;
        b=AYGwE6KESm/o5+L0ivT5biniK85rXRR1HUgMQ6pC93hl7Kh7KWi4X8HjMqKaSzOqaU
         HYEpZbib8gsHKUBF5UdCyytB2EvlTyilbWli1jRm9+WldlwqJAs8vY4AQdMIunNjks+r
         DCVw3U+S1U0BBAwb41q9uuql6wr9u2g1k9j9tGD2Ozdbk/5ElrAyvf2W4o4qZGe4cCBV
         ERlixUKoYSdoCF7Rfkdduw1OcqRP5x9i+7TNSkdRAFzmCQ92izZB+jN/bTxaM/EA0IHM
         IAd5tc6rKPDzdYMZYxkr10p08es9rk1/jFsfUtWJpYc0eFGWkE1/7yRy2nej/gp/gUdB
         6r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056183; x=1758660983;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tST7ChoMLtpPZGS95Y8CJgYhrNYZbL3f0dl6p0aVNAo=;
        b=xSwvomxYBukoJ3WtDIuDRUcxOygCQmqnkFTXIv1ICE4t3mg7yv0ZTgq6k3Fcm5aJhH
         B5NJpTSlMTYmdlS2oB7rOx7KvohiKusrmPA0WJcTT2eFyNLZiUqtluZYosl+hl1jSfqB
         +x6SJJr/rs2YdOo2EAgP4AmRH++ki0KrMRWS17qyEIESChXP4isaqXDd979N03k2OuZa
         3H0tswuYQN5yoHq3f36VNFTJWLIGPHibaMZvFFDdD2hzoTFExMr4I/jWPofcxvBQg445
         E13U4fQFfn9gybk3qoZL/EMaxD2U4JOUh4a8KhrYQJrNd3nxZJO8W5pcFcbQsY1heYcd
         zJXA==
X-Forwarded-Encrypted: i=1; AJvYcCU/pW1igzSG1Ngyco/zf+2KmAHAz5btMejU390ZaAi+oTVIpsaf02kUWpS7vi/bmBoFkYPhrh4yLfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXfiM1N8dXA0fNfvJDFMAx67MzcTvAy/cw50ubOS2kab0W4AD
	YvtGdhU17lZe74d4/7PMZ+cQvvcp+i+qv5GAWrg9v9Dj6v5CfLDDoRRg
X-Gm-Gg: ASbGncsPPUsGoY23DaQZ/Nhm4BVCIDjwzGcJEu6sD9xShDx3ykri18IsB+2nd/m7y2w
	37yVvFCZtWwvVrPofdTps9dLz+8ORpfbux4Mo2Naydv6ihwo0fcBbqimzc20qtzvR09FaLQPM6V
	3M+Rj2YtSQRbGyEn9C9e2msjc8j8Mpm1LNPW7vHDgPWbJ5/pEV0H+vRbYias/mtSlPys1fLP9js
	eN+hd5ZF6Od7+zRRFOP5LYHOcZB6ysVWQsF2tlo4lqtheuc0cOx5A2QRwrOyt4IinmQQNWDmb01
	WzoyTVlcmZhSTT2xOAp9+9dpyT3XbLfVes3P2js1yhSK9m5jeXVX/x/OKgqoy/JOZFze5Re5ZMV
	OCtZo9/r8S7alkb/j1wPmXe5Vv7pf/2FM/Je4P6ozR2T6gN6gsAxZES1D4YC2v4SB4DZe/LeolJ
	4JtM+y3re66dsQs9/N9gln7ZEZcHr8LmPId1FV1e9/H9Li6GgBQApNppNwz3xMUA==
X-Google-Smtp-Source: AGHT+IF0wJjGNc3QC3+1XWiiSXDuaIElYYgcjHBcVfjXuChYgPQxribyfTCHm5YqhunGO3Ik26VKgA==
X-Received: by 2002:a05:6000:250f:b0:3e7:64c8:2dba with SMTP id ffacd0b85a97d-3e765a051e9mr17310680f8f.38.1758056183310;
        Tue, 16 Sep 2025 13:56:23 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f0c:3300:d82c:9b4c:1c3c:2591? (p200300ea8f0c3300d82c9b4c1c3c2591.dip0.t-ipconnect.de. [2003:ea:8f0c:3300:d82c:9b4c:1c3c:2591])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ecdd1ef000sm1200246f8f.24.2025.09.16.13.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 13:56:22 -0700 (PDT)
Message-ID: <b54c5083-fd3a-40ad-98ee-f102fd28e230@gmail.com>
Date: Tue, 16 Sep 2025 22:56:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Question on generic PCI ACPI/DT device property wrt ASPM
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 Chia-Lin Kao <acelan.kao@canonical.com>
References: <20250916202531.GA1814806@bhelgaas>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250916202531.GA1814806@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/2025 10:25 PM, Bjorn Helgaas wrote:
> [+cc AceLan]
> 
> On Tue, Sep 16, 2025 at 09:48:06PM +0200, Heiner Kallweit wrote:
>> There are drivers (in my case r8169) disabling ASPM for a device per default
>> because there are known issues on a number of systems. However on other
>> systems ASPM works flawlessly, and vendors (especially of notebooks) would
>> like to (re-)enable ASPM for this device on such systems.
> 
> I would definitely love to be able to fully enable ASPM on these
> devices everywhere and rip the ASPM code out of r8169.
> 
>> Reference:
>> https://lore.kernel.org/netdev/20250912072939.2553835-1-acelan.kao@canonical.com/
>>
>> Realtek NICs are used on more or less every consumer device, and maintaining
>> long DMI-based whitelists wouldn't be too nice.
>>
>> Therefore idea is to use a device property (working title: aspm-is-safe), that
>> can be set via ACPI or DT. In my case it's a PCIe NIC, but in general the
>> property could be applicable on every PCIe device.
>> So question is to which schema such a property would belong. Here?
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/pci/pci-ep.yaml?h=next-20250916
> 
> I'm not super enthused about yet more knobs to control ASPM based on
> issues we don't completely understand.
> 
> Quirks that say "X is broken on this device" are to be expected, but I
> have a hard time understanding a quirk that says "this feature works
> as it's supposed to."
> 
> If ASPM works on some systems but not others, it's either because some
> Downstream Ports leading to the NIC have defects or Linux (or BIOS) is
> configuring ASPM incorrectly sometimes.
> 
> I think we just need to figure this out.

I'm tempted to say we've been having the ASPM issues with Realtek NICs
for decades now, and so far there was no good way to "just figure this out".
Some issues:
- We only see the tip of the iceberg (the users reporting ASPM issues to
  linux kernel bugzilla)
- These Realtek NICs are on hundreds of consumer mainboard/system types,
  with endless chances of problematic NIC chip version / PCIe chipset / BIOS
  issues combinations.

Therefore a whitelist property might be the least bad option.

