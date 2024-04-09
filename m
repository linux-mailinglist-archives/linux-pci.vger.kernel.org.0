Return-Path: <linux-pci+bounces-5961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA0889E1BB
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 19:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBFA1F224D8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 17:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17375156678;
	Tue,  9 Apr 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sa9qh3IL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7914C85;
	Tue,  9 Apr 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712684573; cv=none; b=hJW4tOsIDGA1WFwXdYw142NOJ8Oln8kMT+3sZLze4NILbVCxyZ33dq7okVaeQ7CevGo4pxYyPrk2UtqzT86X8mzHsrMi2sDbra2YYseSQLDsHZCEvLJAoiq3hJeP00JHJ+hDjpbHGc1l/A+by1WOb7/DCbLJoaSRKhWpD+IfFAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712684573; c=relaxed/simple;
	bh=y4yPbOW7qBshpM0WkZh6ezHgsetm01AnkA/aNdq3fLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIB6u/RNUt7v0QyXX5WuHUl/s4eKmvoVwmr33aMkT5bvp6TIt+Bl04RnYihbXSHobFTcssR7G6vFoCF1gaFAJc2FFkM8+qSbZ+UIKH4wbnKY5Y1dMBShCs4bEMR6aRKczTYUef0sW6ZSAl2pVu+FK2lxm5qZw55l1PeF/Y6XPVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sa9qh3IL; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69943ef42b2so27703686d6.3;
        Tue, 09 Apr 2024 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712684570; x=1713289370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyJEVdf65G5mngbuhja1fnaYo/P2N0p8fC3BOf7G3NA=;
        b=Sa9qh3ILr+8wXh+5EoSMalqw9kvIZS8a7155IMTlXWLO0HvCHuR48AYwOaVJwBgOKX
         zW2E05wC6nb3vIqmKaRB2mzywMpCHcsAQXRvK5jqPTCcsLg4OIPdnXu+ICoy9cD67qKu
         kyeQ6E0Kq7vMV8XULxsOmoJnEBQnT7nbAeHWA4A5kcAWgMaE/dn7kGJv8vM9XKCw9ia2
         8aekA411zmIkEF5rKW4iiBvDvYB7Yv47YY9naVVyr008lwhB5Pf+18i8Wpr/agYkNNLz
         +YnFB+aTPakjv4lmhliW5MjYkvckbx4hsFFhlS3edBByTtIm+StEEFjtB2SemjQwNeMO
         cO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712684570; x=1713289370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyJEVdf65G5mngbuhja1fnaYo/P2N0p8fC3BOf7G3NA=;
        b=hvQn84x7zkW17F15C/ODzBb9O5n/IN4rsHn165jywkFDbvUonksv7AftOdqk7FemNr
         DxmLkAhwP4jBNAP2SEYrsF19YvWTE6Y1RinnEeEKqaiVv/wfgfwwa7wcIaUEt8X6CdTY
         zVZEOTnBC8xVXoFgGzYLJUJPiMeN4SzkL1SXI2jHSRhO4njc8S7V0cj1CVAeFSbEaDPi
         MPf0JlqSPLAEl9bjFupzHkhtjSHQRzTmKOFUZdPooV0b4DggW/DbD4BRwIc47HEHEs7O
         0E9yyOyRafm75IvgAg2zAI0oo3cGQHTLgFfkCfapDp72nQuR+jyKI+MD/E3arYKas7TQ
         APSw==
X-Forwarded-Encrypted: i=1; AJvYcCW3u+dfqka5uzBWjw8F1Fp8F+q+yREZ8jwa8ZBtBtXJBTXo/fnmCnwACjklC4oBdXSZDNAiPKQQg2rs/HeTamG+Y6tHqnbrHGjjmVg7kUawa3dzHs9x+MWTUYHivmz39ypY
X-Gm-Message-State: AOJu0YysSjr2L6jUmgI6t8P0IlGCd+YETjkIcGG7LwwoiByXbqds3m+7
	ZynrOskXgL+4nMQ9Jupwdh7Wzte1OslPCn4+KOCjpWBVpHNWA5iU
X-Google-Smtp-Source: AGHT+IFj+BVzECEn2HaF1nQsPqqlZFIQaVpBm30sGDqGq6GHAeJofCc1k/lUf/Y9lkOG+9pbY3TrPg==
X-Received: by 2002:ad4:5744:0:b0:69b:33fc:e1d4 with SMTP id q4-20020ad45744000000b0069b33fce1d4mr218175qvx.43.1712684569799;
        Tue, 09 Apr 2024 10:42:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d6-20020a0ce446000000b0069945e9d305sm3702230qvm.42.2024.04.09.10.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 10:42:49 -0700 (PDT)
Message-ID: <22f44220-80ae-49f7-bc7a-246e017cb77b@gmail.com>
Date: Tue, 9 Apr 2024 10:42:44 -0700
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
To: Jiri Pirko <jiri@resnulli.us>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
 Christoph Hellwig <hch@lst.de>
References: <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <ZhPaIjlGKe4qcfh_@nanopsycho>
 <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
 <ZhQgmrH-QGu6HP-k@nanopsycho>
 <ae67d1a6-8ca6-432e-8f1d-2e3e45cad848@gmail.com>
 <ZhUexUl-kD6F1huf@nanopsycho>
 <49d7e1ba-0d07-43d2-a5e7-81f142152f8a@gmail.com>
 <ZhVQo32UiiSxDC6h@nanopsycho>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ZhVQo32UiiSxDC6h@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/9/24 07:28, Jiri Pirko wrote:
> Tue, Apr 09, 2024 at 03:05:47PM CEST, f.fainelli@gmail.com wrote:
>>
>>
>> On 4/9/2024 3:56 AM, Jiri Pirko wrote:
>>> Mon, Apr 08, 2024 at 11:36:42PM CEST, f.fainelli@gmail.com wrote:
>>>> On 4/8/24 09:51, Jiri Pirko wrote:
>>>>> Mon, Apr 08, 2024 at 05:46:35PM CEST, alexander.duyck@gmail.com wrote:
>>>>>> On Mon, Apr 8, 2024 at 4:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>>>
>>>>>>> Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrote:
>>>>>>>> On Fri, Apr 5, 2024 at 8:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>>>>>>>
>>>>>>>>> On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
>>>>>>>>>>> Alex already indicated new features are coming, changes to the core
>>>>>>>>>>> code will be proposed. How should those be evaluated? Hypothetically
>>>>>>>>>>> should fbnic be allowed to be the first implementation of something
>>>>>>>>>>> invasive like Mina's DMABUF work? Google published an open userspace
>>>>>>>>>>> for NCCL that people can (in theory at least) actually run. Meta would
>>>>>>>>>>> not be able to do that. I would say that clearly crosses the line and
>>>>>>>>>>> should not be accepted.
>>>>>>>>>>
>>>>>>>>>> Why not? Just because we are not commercially selling it doesn't mean
>>>>>>>>>> we couldn't look at other solutions such as QEMU. If we were to
>>>>>>>>>> provide a github repo with an emulation of the NIC would that be
>>>>>>>>>> enough to satisfy the "commercial" requirement?
>>>>>>>>>
>>>>>>>>> My test is not "commercial", it is enabling open source ecosystem vs
>>>>>>>>> benefiting only proprietary software.
>>>>>>>>
>>>>>>>> Sorry, that was where this started where Jiri was stating that we had
>>>>>>>> to be selling this.
>>>>>>>
>>>>>>> For the record, I never wrote that. Not sure why you repeat this over
>>>>>>> this thread.
>>>>>>
>>>>>> Because you seem to be implying that the Meta NIC driver shouldn't be
>>>>>> included simply since it isn't going to be available outside of Meta.
>>>>>> The fact is Meta employs a number of kernel developers and as a result
>>>>>> of that there will be a number of kernel developers that will have
>>>>>> access to this NIC and likely do development on systems containing it.
>>>>>> In addition simply due to the size of the datacenters that we will be
>>>>>> populating there is actually a strong likelihood that there will be
>>>>>> more instances of this NIC running on Linux than there are of some
>>>>>> other vendor devices that have been allowed to have drivers in the
>>>>>> kernel.
>>>>>
>>>>> So? The gain for community is still 0. No matter how many instances is
>>>>> private hw you privately have. Just have a private driver.
>>>>
>>>> I am amazed and not in a good way at how far this has gone, truly.
>>>>
>>>> This really is akin to saying that any non-zero driver count to maintain is a
>>>> burden on the community. Which is true, by definition, but if the goal was to
>>>> build something for no users, then clearly this is the wrong place to be in,
>>>> or too late. The systems with no users are the best to maintain, that is for
>>>> sure.
>>>>
>>>> If the practical concern is wen you make tree wide API change that fbnic
>>>> happens to use, and you have yet another driver (fbnic) to convert, so what?
>>>> Work with Alex ahead of time, get his driver to be modified, post the patch
>>>> series. Even if Alex happens to move on and stop being responsible and there
>>>> is no maintainer, so what? Give the driver a depreciation window for someone
>>>> to step in, rip it, end of story. Nothing new, so what has specifically
>>>> changed as of April 4th 2024 to oppose such strong rejection?
>>>
>>> How you describe the flow of internal API change is totally distant from
>>> reality. Really, like no part is correct:
>>> 1) API change is responsibility of the person doing it. Imagine working
>>>      with 40 driver maintainers for every API change. I did my share of
>>>      API changes in the past, maintainer were only involved to be cced.
>>
>> As a submitter you propose changes and silence is acknowledgement. If one of
>> your API changes broke someone's driver and they did not notify you of the
>> breakage during the review cycle, it falls on their shoulder to fix it for
>> themselves and they should not be holding back your work, that would not be
> 
> Does it? I don't think so. If you break something, better try to fix it
> before somebody else has to.



> 
> 
>> fair. If you know about the breakage, and there is still no fix, that is an
>> indication the driver is not actively used and maintained.
> 
> So? That is not my point. If I break something in fbnic, why does anyone
> care? Nobody is ever to hit that bug, only Meta DC.

They care, and they will jump in to fix it. There is no expectation that 
as a community member you should be able to make 100% correct patches, 
this is absolutely not humanly possible, even less so with scarce access 
to the hardware. All you can hope for is that your changes work, and 
that someone catches it, sooner rather than later.

> 
> 
>>
>> This also does not mean you have to do the entire API changes to a driver you
>> do not know about on your own. Nothing ever prevents you from posting the
>> patches as RFC and say: "here is how I would go about changing your driver,
>> please review and help me make corrections". If the driver maintainers do not
>> respond there is no reason their lack of involvement should refrain your
>> work, and so your proposed changes will be merged eventually.
> 
> Realistically, did you see that ever happen. I can't recall.

This happens all of the time, if you make a netdev tree wide change, how 
many maintainer's Acked-by do we collect before merging those changes: 
none typically because some netdev maintainers are just quicker than 
reviewers could be. In other subsystems we might actually wait for 
people to give a change to give their A-b or R-b tags, not always though.

> 
> 
>>
>> Is not this the whole point of being a community and be able to delegate and
>> mitigate the risk of large scale changes?
>>
>>> 2) To deprecate driver because the maintainer is not responsible. Can
>>>      you please show me one example when that happened in the past?
>>
>> I cannot show you an example because we never had to go that far and I did
>> not say that this is an established practice, but that we *could* do that if
>> we ever reached that point.
> 
> You are talking about a flow that does not exist. I don't understand how
> is that related to this discussion then.

I was trying to appease your concerns about additional maintenance 
burden. If the burden becomes real, we ditch it. We can dismiss this 
point as being not relevant if you want.

> 
> 
>>
>>>
>>>
>>>>
>>>> Like it was said, there are tons of drivers in the Linux kernel that have a
>>>> single user, this one might have a few more than a single one, that should be
>>>> good enough.
>>>
>>> This will have exactly 0. That is my point. Why to merge something
>>> nobody will ever use?
>>
>> Even if Alex and his firmware colleague end up being the only two people
>> using this driver if the decision is to make it upstream because this is the
>> desired distribution and development model of the driver we should respect
>> that.
>>
>> And just to be clear, we should not be respecting that because Meta, or Alex
>> or anyone decided that they were doing the world a favor by working in the
>> open rather than being closed door, but simply because we cannot *presume*
> 
> I don't see any favor for the community. What's the favor exactly?

There is no exchange of favors or "this" for "that", this is not how a 
community works. You bring your code to the table, solicit review 
feedback, then go on to maintain it within your bounds, and, time 
permitting, beyond your driver. What we gain as a community is 
additional visibility, more API users (eventually real world users, 
too), and therefore a somewhat more objective way of coming up with new 
APIs and features, and just a broader understanding of what is out 
there. This is better than speculation since that creates a less skewed 
mental model.

Let us say that someone at Meta wanted to get this core netdev feature 
that could be super cool for others included in the upstream kernel, we 
would shut it down on the basis that no user exists and we would be 
right about doing it that. Turns out there is a user, but the driver 
lives out of tree, but now we also reject that driver? Who benefits from 
doing that: nobody.

You need a membership card to join the club that you can only enter if 
you have a membership card already? No thank you.

> The only favor I see is the in the opposite direction, community giving
> Meta free cycles saving their backporting costs. Why?

Technically it would be both forward porting cycles, since they would no 
longer need to rebase the driver against their most recent kernel used, 
and backporting cycles for the first kernel including fbnic onwards.

That comes almost for free these days anyways thanks to static analysis 
tools. The overwhelming cost of the maintenance remains on Meta 
engineers, being the only ones with access to the hardware. If they end 
up with customers in the future, they can offload some of that to their 
customers, too.

Let's just look at a few high profile drivers by lines changed:

Summary for: drivers/net/ethernet/mellanox/mlxsw
Total: 133422 (+), 44952 (-)
Own: 131180 (+), 42725 (-)
Community: 2242 (+) (1.680 %), 2227 (-) (4.954 %)

Summary for: drivers/net/ethernet/mellanox/mlx5
Total: 265368 (+), 107690 (-)
Own: 259213 (+), 100328 (-)
Community: 6155 (+) (2.319 %), 7362 (-) (6.836 %)%

Summary for: drivers/net/ethernet/broadcom/bnxt
Total: 70355 (+), 25402 (-)
Own: 68458 (+), 23358 (-)
Community: 1897 (+) (2.696 %), 2044 (-) (8.047 %)

Summary for: drivers/net/ethernet/intel/e1000e/
Total: 39760 (+), 9924 (-)
Own: 38514 (+), 8905 (-)
Community: 1246 (+) (3.134 %), 1019 (-) (10.268 %)

I admit this is simplistic because both mlxsw and mlx5 drivers helped 
greatly improve the networking stack in parts that I benefited directly 
from within DSA for instance.

The point is, you paid the maintenance price though, the community did not.

> 
> 
>> about their intentions and the future.
> 
> Heh, the intention is pretty clear from this discussion, isn't it? If
> they ever by any chance decide to go public with their device, driver
> for that could be submitted at a time. But this is totally hypothetical.

I think your opposition is unreasonable and is unfair. Using your 
argument to the extreme, I may go as far as saying that it encourages 
working out of tree, rather than in tree. This is the exact opposite of 
what made Linux successful as an OS.

Can I buy a Spectrum switch off Amazon?
-- 
Florian


