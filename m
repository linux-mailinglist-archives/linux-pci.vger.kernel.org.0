Return-Path: <linux-pci+bounces-20538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80437A21E30
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 14:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFFC188624D
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49C980C02;
	Wed, 29 Jan 2025 13:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DxmkxFK0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129722EE5
	for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2025 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158758; cv=none; b=kVGHTTDkblM1KVOGoVg46N1F/tkNf8OOixSrkre8H7J40GEY3jHdUc4V+NGBGuEfBSsAfr1tA4Gzt2j/A6WryERkFq3EYdqnn8xweBXEXekyJY1RZ9BEZOR1IX1rZ5hTHamqrkyk+csMZvbCeSBsC81BglTgKgMkg1vxoKKtTFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158758; c=relaxed/simple;
	bh=+1xZukUKwXtjex5ct0NGGMDZj25/Cnt/rW7lyksKsm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdTiZ9p7pHynIhEDnJ7smo67Nf1/QhQFbUi7lTN7VcpHYXETxoIv7FOUdmpZ7qRVWwyt9DB0PQz/ceL7mkv890ubWtFn0orhK3nVYPKGtYoDyE0dBUxIS/6dGRCTZjNXpzIgwmSAUJWgXgTsaAOLMU6aXdazAUdx1uyq5k3koVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DxmkxFK0; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab2b29dfc65so1066481766b.1
        for <linux-pci@vger.kernel.org>; Wed, 29 Jan 2025 05:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738158755; x=1738763555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8eKaDXN8nT3fRF/O7B9dAo9AcUGAfO6x7aOxDrfogQM=;
        b=DxmkxFK0fARWwwDZzzSELbmiaSQzHPJ8FwGmSeeAfeBgIBNVcX+mg10VjID9KyQeOQ
         S4U+pBqZgrBLaq9GzmVUvD+r/+KxOcHHOeuQ75juKE66PfT6s8o2FBWPC0nk/5rRh+kE
         4ED7OXwTo4oWCuws5ZHpux/ybyWdVzaYfYrpy3EexqShoJ2bacb5nGc7lfo3O1noLZmc
         iRNX/M0/nTUB46kTwjj9PTWEUnD5oevtXYRoP8e0+whnx7eWdXBraL1fDTE/lIbgBWn2
         M2I3WjNlGFSvc0UHNq1pAMoSIxsy998QvknCxaJ80eRTtZh0bYw2cotfEMV6+QskawcW
         m0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738158755; x=1738763555;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eKaDXN8nT3fRF/O7B9dAo9AcUGAfO6x7aOxDrfogQM=;
        b=kGzMk+9+CQ1TiqbCduuVyIQvObFLikbFBgZIrDrmvtw71qU0oDg1HUqxlGEHkO6PQw
         5PA+fCSsCyEnxK5HlDsUa4Fv4tI4OF2Cw2RIkiSHBj6lIAIryX3jQnMQLHKP0UjBppCS
         6YhbrQ3bnYE4EN/HhGC6gjj+7dCr7j07kf2YIazur1C7wdXHT7z8H/E6yanD+Oo+UDUq
         VyjhMTQaV24dLATbarloUqOIs77syjZY+c0QVco0YH4f1mWpbMdXaEDQSXffaK8TyAkx
         p3Z5xfvPN52H0v0eI1L4ZfK82BBrQTU6X7yeD003Y3f0otB8SyGkDkv6nG9cJbO4s721
         MqcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXahcZj3Uv1+z5K9nHANVYfDNHCW32ilXWy1cEFK4HdOiJBWr06EUTwvPZ3jnQHkhBWIvSh0/PmG3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpGqLi5b+xx+GS0GfDsKQvXf96mpcxvmXhZ7dnMBxZMgugHTyB
	6tWiuz373hZn7LkVNgYFe39Gh9xwpOxcTQQPd8Faw0qwXtXCLuj7wfIu4u90hA==
X-Gm-Gg: ASbGnctIgayt3V+SFRm68ZlKsF7X7lD/TsRz/eM1sLwHjjsLYEi0wc8saaFtUJnom0z
	s/Qh0vwepdvX7UIg5xOuwNbQ9Hw9Co9kPxIgUDtIqWnMyWgh7Ju+LlGYT2KfXXfns2EnArpQkX0
	1kz7GKu6NpMGd8kU0T2i157SBPUNz8jMzUMWt9Dd/iIxtYc6CA9uwUUywoDi1UzZHFqheOCzjWY
	Usq2WIPRd+nd3pJvDHx8zJJv+0NC0JxsHhAS884dqISkQZJmLe1pFMSGoz82xC09Dgaww5KCJeS
	33t84OW3HESfRxbE+MMqOo1jgovrzykVQMJmiyP00Yd51Fo96jvu6bm2sszQkgEvQWKEqA4mUFk
	v
X-Google-Smtp-Source: AGHT+IHcgMv7g287Jp7sQNzuwSuVOp0aN6zu3mmbpSWX1c3/xC3MYcqnhyGJQi8cda92/TBxiW4uDQ==
X-Received: by 2002:a17:907:2d0c:b0:aa6:995d:9ef1 with SMTP id a640c23a62f3a-ab6cfcb39e9mr349160266b.12.1738158754501;
        Wed, 29 Jan 2025 05:52:34 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760b76acsm975243866b.113.2025.01.29.05.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 05:52:34 -0800 (PST)
Message-ID: <841e1793-4635-4f06-b0c9-37530215c08b@suse.com>
Date: Wed, 29 Jan 2025 14:52:33 +0100
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
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel <xen-devel@lists.xenproject.org>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 linux-pci@vger.kernel.org,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
References: <20250129133252.GA451735@bhelgaas>
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
In-Reply-To: <20250129133252.GA451735@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29.01.2025 14:32, Bjorn Helgaas wrote:
> On Wed, Jan 29, 2025 at 04:47:28AM +0100, Marek Marczykowski-Górecki wrote:
>> On Tue, Jan 28, 2025 at 09:40:18PM -0600, Bjorn Helgaas wrote:
>>> I guess the code at [2] is running in user mode and uses Linux
>>> syscalls for config access?  Is it straceable?
>>
>> Nope, it's running as the hypervisor and mediates Linux's access to the
>> hardware. In fact, Linux PV kernel (which dom0 is by default under Xen)
>> is running in ring 3...
>>
>> But I can add some more logging there.
> 
> So I guess the hypervisor performs the config access on behalf of the
> Linux PV kernel?  Obviously Linux thinks CRS/RRS SV is enabled, but I
> suppose all the lspci output is similarly based on whatever the
> hypervisor does, so how do we know the actual hardware config?

The hypervisor only intercepts config space writes; reads, particularly
when going via mmcfg, ought to be unaffected, and hence what lspci shows
should be "the actual hardware config".

Jan

