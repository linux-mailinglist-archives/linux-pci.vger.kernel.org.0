Return-Path: <linux-pci+bounces-20539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC14A21E36
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 14:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFCF3A56F4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0F130A7D;
	Wed, 29 Jan 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a9KJyHZH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D38172A
	for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2025 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158886; cv=none; b=WUYx7AfTX19K2N0aJLWnq/KaAAVNGEiORkkIY9Aa2LcuU6IfJ2r11mmj+QJLu4x1AA3NepaRb3QQfWn1692Xj8J9xDEbxHJz0zwMgGiY6mCNjaoG4BT1+5nx8DnM39rdlp71lLu00QfEC3WIx2R53JftCEAmyLCtQlYgqPynvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158886; c=relaxed/simple;
	bh=Bp8j6cdeU44uJZZirV15PQkOdv67IumSfT+gpLwKhU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQJYS2CrALR+W3vW1g7VJzT09mUUrkamJ/g+5iTL5x45rNzHwMOnaAO6j8yP/mLDukhnilzdDrjh7wq0muEp+vcN6FLTGAA6O09hDmQWjcB0GfaqDSKjhp7xgS6rD6DnvmcTykdKCuCe992VARV4oParonQD4wC4PN9X/2lkNIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a9KJyHZH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so12607125a12.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2025 05:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738158882; x=1738763682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OAzk2HvSci2RB9DJCTTtog02Zihvy8J06+hb0uPWlXE=;
        b=a9KJyHZH63EyingF5dKwGYhpj9U27AIyC4HQSk1tqbhip+0FmWgpqAHfDA18xN7vqu
         NFlodoKyOu89S3oqbG415tMGgXmrg4xHPmrMdfk6CbKdW3aJd71mT94K3oTfGslT7ZPs
         Nef/j1yi1km/O89yYbk2H43a8Du1N2dvALwLlNJvUfASwGYvljpCkGwkDFfebHXCDRtu
         T8luBhXvx+wWvyS5We3gso8Cn5VD1p1KhnraFjvICAcJT6+gUbxpMnyeccegRU/GQ/N7
         vejBFpM1QSxROuGWqX3QzAhx0YziX4cVlNWRO1lODxcB7lxS9QpNaJequ+TwmfBBSm8P
         0G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738158882; x=1738763682;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAzk2HvSci2RB9DJCTTtog02Zihvy8J06+hb0uPWlXE=;
        b=JKmqTL9Jiv0ZGmDEFmmufWM3t6ZKNhUWjFk6cUrtemGxdsSAvkecfD+sXPfsK7YAou
         oounp624U96kW5EybPhtz4GZfxaD4i07GbkQbWs/bli2mIiUlEhbXZx4FH+EVzWeP8zv
         EOHrRC9Cy/93VjJD+ghhB1j3XWgiVFAtLYQmNdLL5PfHL5f1DavtL68eFddt/86R4FcM
         BUJaBGSvOLBphOTfs8zLM7Z+t/4ZXxqw3Ye3SWRsMHi/Fp+q9yzrka/zyEFqivHTxNeg
         mAc1s3iNbzIqrlTtYyjHASHpqAb/h6n4kHMSVS10D4ejVDA8c/LooDdW5Uc3Kw0qKnqB
         93vw==
X-Forwarded-Encrypted: i=1; AJvYcCX7fz4Pw5iZXqXkNkkg9+sdOqXPSxVXVLU0o0Wv6ObyvGRsdre9K3PSg5QR8K95s870tnpdQBNn1r0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4oGzPJfbyJgILHuIZRkJuwg0zG70vTdHj0lED0rjv8zU+YCx4
	Zyt8XFJpUEjWEID9hYUQJOap30UEWRN+oyjuRW2i0rPe7UfmeelJTgwzWuU53Q==
X-Gm-Gg: ASbGncuhhK1uuRNekDExTHi1X4Ny6IDJ/T1b7oSgDIWB7TzTD5qp38Z5IMn1zBLtQi3
	Mrk6oNoFcdxazAO6t1j3LS2T6/6qav/Y10mf0DX9zZcJXfKgk4KZA7S+qXJzoQCYAnblTCsM0cf
	3eF+j2dtqrUqmS5zOdWZPEF+BlVL9bvsGomikczuL4QCXphi7+X8uTwuHGjz+5pnxAGmpF29Dm1
	hFi1UVup6Zrb1ZLm2qEb2XSTDFeFjBCxYRg75OiWOY3rmBDhzK0T40Y91i80Kq/y2huMBklzPVd
	+GRuUNOlv5rrVVNEyuqVw8jC88ih+8ovSphztCWPu18CPgC7esiOGymYzOaEBlLyKcQ83gwG2I0
	9HBFzc7lHc9w=
X-Google-Smtp-Source: AGHT+IFyfwTg1PMxVWwmOGjd5ZetF6IndRyOwzliuiWStKYzttmQsbLKfxXAr/xuK9TPm1p1YNzOiA==
X-Received: by 2002:a17:907:7b85:b0:aa6:81dc:6638 with SMTP id a640c23a62f3a-ab6cfcbb881mr280647966b.16.1738158882265;
        Wed, 29 Jan 2025 05:54:42 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbb2esm985639866b.140.2025.01.29.05.54.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 05:54:42 -0800 (PST)
Message-ID: <8acfd9b2-caae-4fe7-8d37-19e2d9be23a8@suse.com>
Date: Wed, 29 Jan 2025 14:54:41 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Config space access to Mediatek MT7922 doesn't work after device
 reset in Xen PV dom0 (regression, Linux 6.12)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel <xen-devel@lists.xenproject.org>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 linux-pci@vger.kernel.org
References: <20250129132843.GA451331@bhelgaas>
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
In-Reply-To: <20250129132843.GA451331@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29.01.2025 14:28, Bjorn Helgaas wrote:
> On Wed, Jan 29, 2025 at 10:17:20AM +0100, Jan Beulich wrote:
>> On 29.01.2025 04:22, Marek Marczykowski-Górecki wrote:
>>> On Tue, Jan 28, 2025 at 09:03:15PM -0600, Bjorn Helgaas wrote:
>>>> The report claims the problem only happens with Xen.  I'm not a Xen
>>>> person, and I don't know how to find the relevant config accessors.
>>>> The snippets of kernel messages I see at [1] all mention pciback, so
>>>> that's my only clue of where to look.  Bottom line, I have no idea
>>>> what the config accessor path is, and maybe we could learn something
>>>> by looking at whatever it is.
>>>
>>> AFAIK there are no separate config accessors under Xen dom0, the default
>>> ones are used. xen-pcifront takes over PCI config space access (and few
>>> more) only in a domU (and only for PV), when PCI passthrough is used.
>>> Here, it didn't went that far...
>>>
>>> But then, Xen may intercept such access [2]. If I read it right, it
>>> should allow all access (is_hardware_domain(dom0)==true, and also the
>>> device is not on ro_map - otherwise reset wouldn't work at all).
>>
>> The other day you mentioned (on Matrix I think) that you observe mmcfg
>> not being used on that system. Am I misremembering? (Since the capability
>> where the control bit lives is an extended one, that capability would
>> neither be read nor modified when mmcfg is unavailable.)
> 
> If you're referring to the Configuration RRS Software Visibility
> Enable bit, that's in the PCIe Capability Root Control register, which
> is in the PCI-compatible config space (the first 256 bytes), not the
> extended config space.

Oh, I clearly didn't read Marek's earlier mail correctly. I'm sorry for that.

Jan

