Return-Path: <linux-pci+bounces-5908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 508C589CDD1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 23:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B23FBB21975
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 21:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C521442F3;
	Mon,  8 Apr 2024 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkX++shC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEE511725;
	Mon,  8 Apr 2024 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612975; cv=none; b=aB4+gayCLk/bgAHGAyvQz/Foyv34H19zPhVahEiaCNbYSugxsGw4+/PnwX9SHsZwntIsbMS9FdgbbQ/nFeuA1Vm2rcn5ISrdfaYXDCJAL2zijpKPelPPCzcphRUP1o6dF4HQJivWMVgUgIxLZzUhe1eoEqcMdp19ADhdR1s9NxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612975; c=relaxed/simple;
	bh=LKPnWiTJXmCozHWVTeeMRgpk04GJwmAMX6odIBEbfC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d0Jen0p/zwu4sFw3PxhoDVPOKzoSj0oFzRoSJStookG58Ug9UC7pnC1OW20AXrmSrfQSGBAPq1GN/uc5m2bwIkainQpJLROXts8uBEOpxOWeMX7v0cFbMEQgqTiebgcx2eigixRMGgZL81u8kcRuAe5qhj/4DhbRk/ycKzvMs/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkX++shC; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78d5f0440d3so156860485a.2;
        Mon, 08 Apr 2024 14:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712612972; x=1713217772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iD6zDjCWvz4YFRVtFhzQxnseOjPCjKVXg++Ec5xmhI4=;
        b=KkX++shCCKTJWZKgKf742Sx/VQzIQJRu6x+YhTs0AFjtYiUGA53w1YC4WWeu5NlPLS
         htuGcCKI/U769kMsGVh9Mu+CXDWf6B3eSeosa4VO+SG1XO+NyhFtViA6u5eHDT8xP8uO
         cG3JbaguBfPMMcf+QsKW0TIlfA8RHlDfiJBVC4iGVar83hkaTtFFx58nANYDw0cUEUQ+
         Ww7d5jUholAnaJEuyfDdlqV078o0aE58ejO9YF50f7jiSZYXbeFgoaJ2vCYCV3kkAJEo
         XXiMqT2Uq89FaEIAJUOGIY5W3k8cD1fJ40IxeEf4wQafj7dm1/MfFI5fxZcgTjUwzK0T
         +A8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612972; x=1713217772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iD6zDjCWvz4YFRVtFhzQxnseOjPCjKVXg++Ec5xmhI4=;
        b=oCtGN30v3jhcHXKjAv/xYM61SL5MApMPk/GtIYAEleahEnZs6+Jk5jNlxY7Grdr3aE
         ECqnDUEi62YQks5xJT3sZkKSyU1iEJH5G/yGGa4FPdr0rAiPEEBV769n/zsiYpHU9n3Z
         TkiGkCa/puPVb2sbwDAvwxbQ50fdzfiWGGFVrEMMh1RnNTqhmHtipz6OuNZ9gOJkfe4e
         7C0omw1N2bUm35uqXBvSbDLDtzBWDdvJ3kQF6nfgpetkrRkRjucWx6l9w3LjaIoWBRqS
         C22j/X01VxBHVvQYFL4sCOkV3oK0nfxGcXectJiyFU7ppaDtiHQwaCugXEIdoVboDHgi
         n8yA==
X-Forwarded-Encrypted: i=1; AJvYcCUUjifg49IkcIBPSSr3TMJKatrK4JB5kTWVygegKLtEBcYDMg1jdkb0ZByN7Ql+0yryOhv9uFkLZo0lMswQX81K2OGUThlz72iKk34FiOf+UgZKJee/GPtNjbVoFMV79oaT
X-Gm-Message-State: AOJu0YxUBxhwx8oe54T2GgPDqskWNjaCU6dFuDoT+g+IKEdRKXUcFmOe
	+0hOKt4tlB5RsUVud/xmSh5J9aYCZ1vQXhuirdXMk8Od54XSts5RR9l00EU8
X-Google-Smtp-Source: AGHT+IF8nYgpLnGrm/cgrjEj7bvCeIGyu6FXEd28j321+N78nFCwdE7gFdtX32QwwaO9IlHQp8rqKg==
X-Received: by 2002:a05:620a:15b1:b0:78d:67aa:9d66 with SMTP id f17-20020a05620a15b100b0078d67aa9d66mr3081393qkk.15.1712612972563;
        Mon, 08 Apr 2024 14:49:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i4-20020a05620a0a0400b0078bdbba4993sm3556541qka.47.2024.04.08.14.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 14:49:31 -0700 (PDT)
Message-ID: <73ef7e23-d09d-42ec-8a11-0a42b8b6e459@gmail.com>
Date: Mon, 8 Apr 2024 14:49:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Content-Language: en-US
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Leon Romanovsky <leon@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
 pabeni@redhat.com
References: <Zg7JDL2WOaIf3dxI@nanopsycho>
 <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org> <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <20240404193817.500523aa@kernel.org>
 <CAKgT0UdAz1mb48kFEngY5sCvHwYM2vYtEK81VceKj-xo6roFyA@mail.gmail.com>
 <20240408061846.GA8764@unreal>
 <CAKgT0UcE5cOKO4JgR-PBstP3e9r02+NyG3YrNQe8p2_25Xpf8g@mail.gmail.com>
 <20240408184102.GA4195@unreal>
 <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAKgT0UcLWEP5GOqFEDeyGFpJre+g2_AbmBOSXJsoXZuCprGH0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 13:43, Alexander Duyck wrote:
>>>
>>> Also as far as item 3 isn't hard for it to be a "user-visible"
>>> regression if there are no users outside of the vendor that is
>>> maintaining the driver to report it?
>>
>> This wasn't the case. It was change in core code, which broke specific
>> version of vagrant. Vendor caught it simply by luck.
> 
> Any more info on this? Without context it is hard to say one way or the other.

Believe this is the thread in question:

https://lore.kernel.org/netdev/MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com/
-- 
Florian


