Return-Path: <linux-pci+bounces-20535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31192A21D50
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 13:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947FE1677D0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 12:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683FF5C96;
	Wed, 29 Jan 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GzK9fsTd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471414C96
	for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2025 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738154966; cv=none; b=HEdK4MYGNNvbo7TV4LHnJae8PYHlMdPrVg09kfS9NlVNQL/4KlwUE5SATSS3h1pRDOcHu1sBxTL3hICm2Tsot4M4jPTv3nThk6yjHF5xp+KIigkBGgiqR4jYwV468SedrCXqW67wXOVjJaRe8gHvcJnZsDqR7spM+369fqz0dIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738154966; c=relaxed/simple;
	bh=2MhrTbBWhqb/rJZbfCQD7yFxdm/y7KJtRIxQhKUacy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tz2wFInCgrPZwpNPhkF+C71foN/rJCDhSs+scOI7xIBuaJlLjqxWrxT2tEMhf7S19L3sFViqxwJLWMrINjwKf/CJxj5mt/g3hUAuR/IzVDpeCCJ3yprtPBQz1KVESqtQI5uc5s40fqpoZtoqCUGOp+roW9wsMseK0C6Jbp+ZYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GzK9fsTd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so1311669166b.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2025 04:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738154962; x=1738759762; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P13nDXn0ksUze1YCLpPOQ4mzqk36RMO0+DPY/3Rbc7I=;
        b=GzK9fsTdpUoT/dH3vk1xQ0wjpoS4aXVj/i9Rhdwyz6Nx5NskptvrSUmJ2Q+jO9hGqa
         +1aHqcLMIlZ9o37vd+vRcfmEA8VPOHiQgfRbV+wCHzXunt1kk6SGc4e6zfj/ImOxJaRE
         l/Oo5P3qOvYEajO60Jn7WYdtP5OIiaRQTiyhBXzUROlrmndnIeNs2pAgvIoYJbyennCE
         iHKBtY/TlbVKPBoMGDAVjENfeQNl54OIvEV2Z2I2aZmK+IIcWdcMHxcxrs0ApI7OdgMD
         k2joP5yKklLCILvgU1YRwebf+nM46WQw5ifeB8aqhjeA0jUSV3F0x52GZZrPKeBNBNP2
         GpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738154962; x=1738759762;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P13nDXn0ksUze1YCLpPOQ4mzqk36RMO0+DPY/3Rbc7I=;
        b=DSWsUl943xUEx6DOu7aI9/QJkBizB2yWPyCKPXa3YNQq3pntideVDPAjdiK4P88CG8
         RB1AD1FFCxeZ3SDeT8OdUYJ6CKdpsPd4/phY4J+8SCNLFgvDfEq2oNnDXXzFn/beBJVS
         RjyYBbHEEBCAiwjvpgqQmiJs9brF0ptM8odQXnHFJQuGuEDH+JFA+UCvPiXtx8eB0M1r
         Y5Nuf5Iwbgp+EVKMbw4RmW10sB2MExpZ7qi5sXitWwKV0SjV2WvXi8aMWOaOe5uJ6wiJ
         7yO8fr0s+HaurtTz2YYMpwMJs7Bu2j3kWJy7YTajj7KWt7iJSmJ6irc90vN8kCw5UjuJ
         zNfw==
X-Forwarded-Encrypted: i=1; AJvYcCV7ymBznHpTDHn8BC+kFTBJ4GvnLzG5fMD2cIv8W1spH0bPripxuwDDKiftn7nimHbmki9kIBhc6ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3KypNvSgASdOJPO1igUEMdvOvXHX5b4wzr0KFq54Sd3/wfckV
	xlnEpX21S1XE43rF1pdNfivUj1Mt2LlzS8kwqFRql/G2R7PKwrAaO+Q+R9Tbjw==
X-Gm-Gg: ASbGncusaYrv0b8bijY5RqiPVL0UP9MfabmUl3Hk0VLR9HgmEddi9oBPjzBe1smmMew
	LgY0T4zcF5wo4Yjy6d7s2XcPdvp5Laay44fr/6JOyZg/Jxv0HHdXx+yuvwj6MycbhUKozEthyay
	kbr5KFG5S+QIGNqLQ5EpNEsmKncHiC7ab2PXApQ8oiDbAvYZCfHXt/rTbN0NMa7FffPqw6sUKXD
	Y/CKSI7BABrOkvsAlj3okHlcoj/tkGzZJxMxEkRGz9hkFU1qeven8vdurzGnhn211FtrkdmLViG
	CwyOpey3QOz8/qjuKNYpIQsA3VAHCq79v/4nMywg73kpY2O5s9/pxxgzPWtV/isRW8QqIk5o7wt
	+
X-Google-Smtp-Source: AGHT+IFbOOXBWI8FB+7yf4hzIic7jBHj46Y0AzXKI74CLRhnwt0JFJ60eK4jgC+pdzwi6Ic0HcyRYQ==
X-Received: by 2002:a17:907:7fa1:b0:ab2:ea29:b6 with SMTP id a640c23a62f3a-ab6cfdd851amr290915766b.35.1738154962327;
        Wed, 29 Jan 2025 04:49:22 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6963743d7sm706321566b.91.2025.01.29.04.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 04:49:22 -0800 (PST)
Message-ID: <4d7ed713-68b5-4e9c-8952-002d21d662d6@suse.com>
Date: Wed, 29 Jan 2025 13:49:20 +0100
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
 <Z5mfA32bvEn6yD-C@mail-itl> <22ad7276-624d-49fb-a2bb-1b7908318a4e@suse.com>
 <Z5oWq4YgMgwWvl2G@mail-itl>
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
In-Reply-To: <Z5oWq4YgMgwWvl2G@mail-itl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29.01.2025 12:53, Marek Marczykowski-Górecki wrote:
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
> Yes, but later (once dom0 starts) it switched back to mmcfg. Now I see
> this:
> (XEN) PCI: MCFG configuration 0: base e0000000 segment 0000 buses 00 - ff
> (XEN) PCI: Using MCFG for segment 0000 bus 00-ff
> 
> Another thing I noticed in the bug report - the reporter says warm
> reboot from 6.11 (where it works) to 6.12 avoids the issue (not sure
> about further reboots). Cold boot directly to 6.12 results in this buggy
> behavior.

Makes things yet more odd, imo.

Jan

