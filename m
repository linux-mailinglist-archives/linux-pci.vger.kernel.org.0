Return-Path: <linux-pci+bounces-20520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E404FA219BC
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 10:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6463A512E
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 09:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF1F19DFB4;
	Wed, 29 Jan 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K23qrtcZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB761990AB
	for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738142246; cv=none; b=SIJ/jSMC36YX5FyKDYetGUFtVv6TxTHAFtoNL68hsXMiSJJIWSb+f2Xnkr9iVZfBtTen3vkJUCWTd7k4LE/F/OXIUglfOhGip9fl2EY9MjaZSxY2fjYLgEcVKRHO+couQZp6c7K0+jIESupHUpnJWtOszaLi3k1S6NaeJd1xrdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738142246; c=relaxed/simple;
	bh=KnM0SWkHYszZgGl5ocXIt4Nayp4o2tvzsXeokZWmpJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CeeCS18p/v7/o1DXjgvezZvRlDmwZ3Tulrsd4fma0R8p9cLCBj3OLAAzoJRj8mPZTshDz6+6DMcc8/kYH/vFVg7c+r77SSFmxVFBTsVI5WA7kHoQPQ2JA42FwxzDODxQ/hKUL+X3IaJZlss2RTvu2VwC0DqxtKEygSPKIkzi2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K23qrtcZ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa68b513abcso1304437066b.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2025 01:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738142242; x=1738747042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jY3VwszcUmlCwbph4D/VlW+dI7fVI6uIXSglAodg90E=;
        b=K23qrtcZKHFQhDgWmEPvTHSmvsL1R2aVMVlK679ODhFxIIqCvySSlm0o/Y/tbENJ81
         oX6OPwQVpXm3uMf4ESmS8JsFgTJz6zu9ybVU5vOtwDMwv2PcYz6q+zBaAV6vugCkU3NP
         yRcLqVHAng2QVba5CVtIfomp5eKqR/FY/K8XyXSQpQ6kH77pf1xvWEXYc1Rgngl/YTVk
         snwn5ket2fLrgy6WwiBmJQGR+YKw84Ug9UNXA645p8m1jOACkx7eZwFYNI9+aKa7VCgC
         dsR0vBDAXTcntHIYnzkuNjBhdAkVBOap7rE966PKF4+hR3aRxQkiLz8Qps0MhodXnm0y
         HnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738142242; x=1738747042;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jY3VwszcUmlCwbph4D/VlW+dI7fVI6uIXSglAodg90E=;
        b=bkfzopDH97KIeWqdxC0ga29V6y2H4cjt2d/JTLtGDki+rZNVFD501x4hJTXmRaO7Ps
         FKo9XCqFlFyy5nxn/zDNSzBWfhm9vb6wwA5wL1CRGvdgTXlYSQyoBmtsrtEWK1sxSnCJ
         D3snPVm3qMjYLEh2gnERxeXw6AOh55KdG1br5CJfMcSYX0zeKanc7ioWIDOtlrLwKYtB
         gPgh/qFH8RpXcya8FLfo91olDsxonJyEeIm2ugOWgipE58nYsmQjQ420ZJGlAsAcai06
         a+hvlrXb1zzTWMwQGmCMzd4KoU4hd4NiBsK2Aj/J9MLQP0wotYFgC1ZEUmMoas86cdVF
         He7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3o/SzIyINnLoiKPzacXERijrwSdUWVl11D03FhSVMeGxFeWO6Lw7oIbbnJpfNfo3gBRJ11wAzyH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwewDpeGpcYk93w/dQv+bV1ryqizKbID6SvRYTUm1VFsEKQdZq/
	Y723uol6syLqBA7vaed7WrgbPg0PVHBbtv48WTuVBtd+FrKEWbZci217Ll1pfxQQ9CMlmxk7WxY
	=
X-Gm-Gg: ASbGncuEJGrElAZC0kXFDuvbENgiHnphwqOzqakLl+axuoRIs04LBGTPl3s8j7f1iRg
	4Y3epf9WAcHB+d6UPL+4woYH06OcNIC7l63QFHwR5R938CBnG3qKCeUHqGBQAr6tCf0mVsEV3ke
	meHCYz2HcWsY7RMd4B5WG5PEPPEIa65RqDMRSVFIDa+I5v33RywUSZVlZ5yBLEtgdDDOkxXMor6
	nkiwsYcaqY4GViMJRClgrs10Qmobksgx7O9kDJXcjajvx07nNpgw//hc51ZcGRQvG0Ne117bCzu
	k5ZI3Wd7zhc7M4Tw4c65YIh4P+Mx7rOXLbZXVY2zqM2jbRC7k1kiUrH5Ht0G69gBEpd9kOPj1Yd
	K
X-Google-Smtp-Source: AGHT+IEptWmgc2PdXVVMpz3zp4lAqX67/4R5WHHT7DJzrvchdkCI70dr1F0VPJ8pj8HJuAcJBfIasw==
X-Received: by 2002:a17:907:1c16:b0:ab6:330c:7af0 with SMTP id a640c23a62f3a-ab6cfcdf591mr214805266b.20.1738142242113;
        Wed, 29 Jan 2025 01:17:22 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6924486dbsm692004966b.161.2025.01.29.01.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 01:17:21 -0800 (PST)
Message-ID: <22ad7276-624d-49fb-a2bb-1b7908318a4e@suse.com>
Date: Wed, 29 Jan 2025 10:17:20 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Config space access to Mediatek MT7922 doesn't work after device
 reset in Xen PV dom0 (regression, Linux 6.12)
To: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel <xen-devel@lists.xenproject.org>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
References: <Z5mOKQUrgeF_r6te@mail-itl> <20250129030315.GA392478@bhelgaas>
 <Z5mfA32bvEn6yD-C@mail-itl>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <Z5mfA32bvEn6yD-C@mail-itl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29.01.2025 04:22, Marek Marczykowski-Górecki wrote:
> On Tue, Jan 28, 2025 at 09:03:15PM -0600, Bjorn Helgaas wrote:
>> The report claims the problem only happens with Xen.  I'm not a Xen
>> person, and I don't know how to find the relevant config accessors.
>> The snippets of kernel messages I see at [1] all mention pciback, so
>> that's my only clue of where to look.  Bottom line, I have no idea
>> what the config accessor path is, and maybe we could learn something
>> by looking at whatever it is.
> 
> AFAIK there are no separate config accessors under Xen dom0, the default
> ones are used. xen-pcifront takes over PCI config space access (and few
> more) only in a domU (and only for PV), when PCI passthrough is used.
> Here, it didn't went that far...
> 
> But then, Xen may intercept such access [2]. If I read it right, it
> should allow all access (is_hardware_domain(dom0)==true, and also the
> device is not on ro_map - otherwise reset wouldn't work at all).

The other day you mentioned (on Matrix I think) that you observe mmcfg
not being used on that system. Am I misremembering? (Since the capability
where the control bit lives is an extended one, that capability would
neither be read nor modified when mmcfg is unavailable.)

Jan


