Return-Path: <linux-pci+bounces-43888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC1CEC63C
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 18:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6DA73011757
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 17:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399A129E11A;
	Wed, 31 Dec 2025 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZ2AuByb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cti02kjO"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3D221D5BC
	for <linux-pci@vger.kernel.org>; Wed, 31 Dec 2025 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202577; cv=none; b=tpLzgyuFhhoYK7VUqqUwZXLEFDOoSpTSdVn7JuwZOtRBVqO2YiQPGmoIbwLew4eoTxXfndIsmPnzOPYj96lSMNulgsFJzsHwdrCxasCLG0pPE2iiru/r5imZNpY8p4ciDCIogVxOfHluqrfEjKEn5dwJ4tYVxWJEByCorf8ai8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202577; c=relaxed/simple;
	bh=Umu9Z5T6MB1JXXj1jGYkaLwvHPYFQEVFOey4XNHOi0s=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dHQU1wU/M98mgF0+a3AGhHWmiC1xdrdGVivqjny1bP0cIw3PLyD50H4Top+dzRkYoriC8lAYiUKSjoSyrzoCJoniNIqL+cmdyKKD/bOE5h4v5PNqawgyADvJmmq9ebfDbmLJNew1XKPgF96UXCrnIlz8sP2a68iDKzND++P8fSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZ2AuByb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cti02kjO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767202574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+hPaZspsreAv3BlbsaDeG27kbGxsQkCDH5b5xlUDn0=;
	b=fZ2AuBybq8ZGNrbY/g+kc3/hs+0+zQO806yV0MUm4gdR3Ax9vp2AT285848eaCjqikWS+A
	JUSPOCvtHFbgoTopaSo89c7i6yihTMJME0Q3efygQ5Vc2C7K96mf+3RA3Q3bdQJPsYW0KR
	sDZxS9m/QAOSM94Z6LFtTVrsiXYGoig=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-mIC43LlhMY2aQDC3sdLWXQ-1; Wed, 31 Dec 2025 12:36:13 -0500
X-MC-Unique: mIC43LlhMY2aQDC3sdLWXQ-1
X-Mimecast-MFC-AGG-ID: mIC43LlhMY2aQDC3sdLWXQ_1767202572
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b9b9e8b0812so18672367a12.0
        for <linux-pci@vger.kernel.org>; Wed, 31 Dec 2025 09:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767202564; x=1767807364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D+hPaZspsreAv3BlbsaDeG27kbGxsQkCDH5b5xlUDn0=;
        b=Cti02kjO/vgsLYU4FS/iI8NjqcKbjB56kjURtridVO3ayOiDjBxg8pdBjsIisF/WOh
         xqXbYXyJON1ojfFoxF6BtzA6LhBZ/hJAHFmCUyaoMGjUXq/A+1BBiHwmsy2yt5Gfvo4T
         B2D50vU6f9233HSk9+dJiEBbBUwXG5lre/xfzhN0/fKMdYinzINCUIJFROTydHoxPKmB
         z11gigJEhjmgkv7BMr5JuHzYLCEF08iqkAtP03sBME6qtMho30QosEKBy7pq8zJQ6Rch
         2LfHjkuaQcxejJwGs3De5GLlYtFHU8im9mIlKcHSriDMWjhTRFvmBzAEq1xKzaXPDB++
         asWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202564; x=1767807364;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+hPaZspsreAv3BlbsaDeG27kbGxsQkCDH5b5xlUDn0=;
        b=f7D1KpDtL7JNRHyY+8rIP2WFLaRl7Pq0JnJeL8GDToF6iPM84mKKzsn9pOimBDnK/d
         qFP5HwoRsaD2GnXBn3Rl4hIM1X+CoqyqN2XR/DzNJ51IVTyJ9DFzpwV64j1j9+Hvn0Hw
         JmK+m9ugaEmZ34frW4s1u46sdshaqSBLlj9U63MxAAPpP1ciXemYgSv6kETsjOzUzahO
         OT8h8/2OgdlghIEpKAqANQ6gR5A3U75PZSNOpXx7lsv/lxuFmQNDvxdaQwwiAJdPY/rR
         25udlfyZoCRVhEhxamdhc7idUA7tTLc1g5WmwI/WuH9ESWFQYbWZdvFDJcvlw9M+SbN9
         LtFw==
X-Forwarded-Encrypted: i=1; AJvYcCWWCDymkoKSiwymfkWU+zxdGgeVfCqQmZ+4YrY7AmX+VPXy0UV3pUPEnpf1zI9Z+3FsvVpP9o2/9B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq8CLlYRUMV7qVMzbK9WoDgMY+d16Ikt9MKRuK/Auf5ttyGshS
	9h5ZgeiexHXb4ieITOCjO8dc5qDL4r4F91w5PffkpzPkb72qBojGSIOzO6vIqkGR7ch0KbJLpLv
	Rrxy5I/VxOh4zTKHCr6Mpin+vSaFTepAKKj0tIISaWhH+IgBVhMDNSoZAPBM2Ww==
X-Gm-Gg: AY/fxX7nakVWm4xUxZz01iFcL8rYBNaBBhLnQ+P2Ge9WmOj+JehvBTDeUFoozHLWhsE
	xKJyqcFPzJdJeXhbkmIh3P7/LUzn+CcxtouSmKYh+ANTLOZ/kn5dIShMPq5RJRkUy3HT2ErY49C
	yWc93Et0zfHpJYhbGLMdr7FtfvNc5xTVouspq6ufxjCPQba4z5av/OZJEFYY/d4SeAFh8XEU7IJ
	Z5l283G/cOuE7RhNIAL6OegdhbJq1ZJ5jR89buftvCg7lZssOQw/GDA2QeqmyWwqRYCqfBWvpj4
	0mY2vi6A3u/6RbVJuxOjd+KVDapkWrQHu16zjbi0Nva1y8c3JfFW7Ui3yDL3sD4RjQfj+OP/0+R
	TKfPzDyZ4knNo6n4PHmDo5urZca69R681K7TEBd+JEp8Z+JZ0
X-Received: by 2002:a05:7022:6722:b0:11d:f464:38b3 with SMTP id a92af1059eb24-121722a9757mr33784172c88.2.1767202564098;
        Wed, 31 Dec 2025 09:36:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi3paBF328Dvc54FaF7ePmfKoOt8e8CqfUvXWomZaBGFhC0nmzfA+IqOZP166rR45yxweuTA==
X-Received: by 2002:a05:7022:6722:b0:11d:f464:38b3 with SMTP id a92af1059eb24-121722a9757mr33784129c88.2.1767202563623;
        Wed, 31 Dec 2025 09:36:03 -0800 (PST)
Received: from [10.61.55.87] (syn-184-074-098-043.biz.spectrum.com. [184.74.98.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ff8634csm87792829eec.3.2025.12.31.09.35.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 09:36:03 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f4228e20-62ff-4701-b6ce-59c99188d7b5@redhat.com>
Date: Wed, 31 Dec 2025 12:35:49 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] doc: Add housekeeping documentation
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-34-frederic@kernel.org>
 <370149fc-1624-4a16-ac47-dd9b2dd0ed29@redhat.com>
 <aVVAfb2eaeyd7l-h@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aVVAfb2eaeyd7l-h@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/31/25 10:25 AM, Frederic Weisbecker wrote:
> Le Fri, Dec 26, 2025 at 07:39:28PM -0500, Waiman Long a écrit :
>> On 12/24/25 8:45 AM, Frederic Weisbecker wrote:
>>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>> ---
>>>    Documentation/core-api/housekeeping.rst | 111 ++++++++++++++++++++++++
>>>    Documentation/core-api/index.rst        |   1 +
>>>    2 files changed, 112 insertions(+)
>>>    create mode 100644 Documentation/core-api/housekeeping.rst
>>>
>>> diff --git a/Documentation/core-api/housekeeping.rst b/Documentation/core-api/housekeeping.rst
>>> new file mode 100644
>>> index 000000000000..e5417302774c
>>> --- /dev/null
>>> +++ b/Documentation/core-api/housekeeping.rst
>>> @@ -0,0 +1,111 @@
>>> +======================================
>>> +Housekeeping
>>> +======================================
>>> +
>>> +
>>> +CPU Isolation moves away kernel work that may otherwise run on any CPU.
>>> +The purpose of its related features is to reduce the OS jitter that some
>>> +extreme workloads can't stand, such as in some DPDK usecases.
>> Nit: "usecases" => "use cases"
> Are you sure? I'm not a native speaker but at least the kernel
> has established its use:
>
> $ git grep usecase | wc -l
> 517
"usecase" is not a proper word by itself, but people do use it some times.
$ git grep "use case" | wc -l
694

Anyway, you can keep it if you want. It is not something that is worth 
arguing for. :-)

Cheers,
Longman


