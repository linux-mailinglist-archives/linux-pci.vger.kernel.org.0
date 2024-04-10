Return-Path: <linux-pci+bounces-6074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABCA89FFD9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 20:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6521C252C7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 18:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1650617B4E6;
	Wed, 10 Apr 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVUdFG50"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7A1802C5;
	Wed, 10 Apr 2024 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773806; cv=none; b=r8nLxE4VNE4J34LhsgcK39CaZWxABPt/KP1Aabr05mILpsXz6Iv4WOLKadfrNgJMfYprTgkB0GEescs+SiWWQy5XAwazYUCQ2LJ0Pk5jmWnSkDktBy1SUyeB9k4OwKKiw2mOPW1aY17ylD7Z1I75Yj/sxXMjkiYyRvdDVbM/kGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773806; c=relaxed/simple;
	bh=HdpvUmlLxQqf3hqwiCw9X6V9dPJdpQkLfoHT0gRNzxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZctskYxvYUK0LY+zI4CtbiKTSRZ/AcEs7/am0/4zZV7c1rLsN84K1xFsYrLAFXm7iOLvyQyhzHRxvjYvPrfzrT9vfgDdVG1bPzgBEXwLGTL7CJLg6S2AxXsgHAMDj6mqRhJoq37NiB/v0T3Rp0m5KHfGRpo/5Bhy4tjlKN2fj+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVUdFG50; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so2855330b3a.0;
        Wed, 10 Apr 2024 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712773804; x=1713378604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Evg7ZUJLZAxXAzahid738WCdxJc9pyER+TodOdA7Ksc=;
        b=XVUdFG50RysnGiNMAd6ydW/1m0WHy/vbJoyFFwqfuiIQYXH+sqa04PcOgKjK5F+zLS
         cHdh/clfDKFD+WaLaM/UeVwtL31kHJycaEd7oPsV6nacAbRuN4eibi7Yg4OGXzBA8335
         7zlOfRhaGdTL3pyXLUWwILiBfzQjKDhPMZJj3L0itW8b7g5jMtu24EQxWESgHUhsMj1q
         VRkCCO32YLoq4MdRXsu2L8ZPEbi5SgBN3mJWGzrDtmKdY+qahbCtxrId2YbZyEL0qtmX
         uNhHnQmthRcnQmS3kb1eedBcop60c6qDaTVj843TA09W2r8JACb2OiunjvqVu6Ko/Wx0
         BBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712773804; x=1713378604;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Evg7ZUJLZAxXAzahid738WCdxJc9pyER+TodOdA7Ksc=;
        b=d7I+invsFKW02Q7P0hCM0H0aF9qkU5qfiw6gjPVJMBoCH0RCBBeg195yS70kay5iLT
         pp4UMXmN5/yvDw8yW7sgy5rM9TUKYr/hmsjsOaK1/tasTcEJEka50/DxcMrQ4WYLNdcd
         euYg2t/YUnsu0OsU+sRMMUgQBGraQSBNsrUnxWF/XZEh3OOYi/9qz5oJUKxI6nsqX1gM
         v0kIGa/DBo5VPjsFv6K1weDYERZTjgT8s0h3+fOM9KOGY64mVaHIPtLbYKaJHFB71I2/
         JsP7e9RaRzgxRx91AMBYgua3QyB5vV7GDadivF2yaryoHuCuH9DHBU2qnKPUkW4vg82W
         xM6g==
X-Forwarded-Encrypted: i=1; AJvYcCV7yWR+6bKWc9LYBSNaLtdpx0fTac54isSS4+9v998WcrYoesvTQSq6yKpgejkDDFngMOdbHFtTpb3cwAvPOcwItqoChjpAuzXRFKQ/fw7ORQwsQOQPoI6aNwEaPKw+tnv3
X-Gm-Message-State: AOJu0YzFZd1eJHeA8JHMyte+0pG3EB7icRXHlvesufxElpKn+S8Mlbtl
	Zhd/SuxI6aVnjhIyseh9T7vw0+Lsi/43oq3DMyW8GmE00A6DkOoG
X-Google-Smtp-Source: AGHT+IH9V9XoVDFF54ZjS8QDBAk65inM4OvgAdQVCmpqONrUyi8kdI/YTUmJUKWG48krhNrOQZEJ8A==
X-Received: by 2002:a17:903:2444:b0:1e3:e64e:e62c with SMTP id l4-20020a170903244400b001e3e64ee62cmr3468541pls.18.1712773803615;
        Wed, 10 Apr 2024 11:30:03 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001e4565a2596sm5369746plh.92.2024.04.10.11.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 11:30:03 -0700 (PDT)
Message-ID: <21c3855b-69e7-44a2-9622-b35f218fecbf@gmail.com>
Date: Wed, 10 Apr 2024 11:29:57 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, pabeni@redhat.com,
 John Fastabend <john.fastabend@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew@lunn.ch>, Daniel Borkmann <daniel@iogearbox.net>,
 Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org> <ZhZC1kKMCKRvgIhd@nanopsycho>
 <20240410064611.553c22e9@kernel.org> <ZhasUvIMdewdM3KI@nanopsycho>
 <20240410103531.46437def@kernel.org>
 <c0f643ee-2dee-428c-ac5f-2fd59b142c0e@gmail.com>
 <20240410105619.3c19d189@kernel.org>
 <CAKgT0UepNfYJN73J9LRWwAGqQ7YPwQUNTXff3PTN26DpwWix8Q@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <CAKgT0UepNfYJN73J9LRWwAGqQ7YPwQUNTXff3PTN26DpwWix8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/10/2024 11:01 AM, Alexander Duyck wrote:
> On Wed, Apr 10, 2024 at 10:56 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Wed, 10 Apr 2024 10:39:11 -0700 Florian Fainelli wrote:
>>>> Hm, we currently group by vendor but the fact it's a private device
>>>> is probably more important indeed. For example if Google submits
>>>> a driver for a private device it may be confusing what's public
>>>> cloud (which I think/hope GVE is) and what's fully private.
>>>>
>>>> So we could categorize by the characteristic rather than vendor:
>>>>
>>>> drivers/net/ethernet/${term}/fbnic/
>>>>
>>>> I'm afraid it may be hard for us to agree on an accurate term, tho.
>>>> "Unused" sounds.. odd, we don't keep unused code, "private"
>>>> sounds like we granted someone special right not took some away,
>>>> maybe "exclusive"? Or "besteffort"? Or "staging" :D  IDK.
>>>
>>> Do we really need that categorization at the directory/filesystem level?
>>> cannot we just document it clearly in the Kconfig help text and under
>>> Documentation/networking/?
>>
>>  From the reviewer perspective I think we will just remember.
>> If some newcomer tries to do refactoring they may benefit from seeing
>> this is a special device and more help is offered. Dunno if a newcomer
>> would look at the right docs.
>>
>> Whether it's more "paperwork" than we'll actually gain, I have no idea.
>> I may not be the best person to comment.
> 
> Are we going to go through and retro-actively move some of the drivers
> that are already there that are exclusive to specific companies? That
> is the bigger issue as I see it. It has already been brought up that
> idpf is exclusive. In addition several other people have reached out
> to me about other devices that are exclusive to other organizations.
> 
> I don't see any value in it as it would just encourage people to lie
> in order to avoid being put in what would essentially become a
> blacklisted directory.

Agreed.

> 
> If we are going to be trying to come up with some special status maybe
> it makes sense to have some status in the MAINTAINERS file that would
> indicate that this driver is exclusive to some organization and not
> publicly available so any maintenance would have to be proprietary.

I like that idea.
-- 
Florian

