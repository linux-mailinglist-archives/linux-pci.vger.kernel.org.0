Return-Path: <linux-pci+bounces-5881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0620789BDBD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 13:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6781F225BE
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 11:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62052627F8;
	Mon,  8 Apr 2024 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="i5OSdp55"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5583A6168C
	for <linux-pci@vger.kernel.org>; Mon,  8 Apr 2024 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574359; cv=none; b=gwXBiktKq9MsCUMNQjLbMqaxsrcnz1+XKMwGpCikkTlIdH2uMtlXjaSOPVUsVZ/BD8nilqTiHvJKGrM+yxeMcpYpH/DTqdDcV9M/lc6EWvM18U3aPlSM73B2DLvtCMZ5MW25Nfc0pFkspghiJZja7q/8+awhpYppD+BdHbJitkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574359; c=relaxed/simple;
	bh=zM2KL1dlfHVkNTCdDlpu+garEC5EGnZ6scFm29Gurnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sg//Kfkg53vpDEN40STbep6Vi4ov+1XnJ3f7qzKv8HpbK/RlDc3SEp2KQvlxhrQzPpjnmYRjBoPlyZuv5k+mLBhZ4KfIRRBIhkFsVq4ytGL6+OXSUsmVOdqmT687O4T3L/LRijnDG0II+xmzrAS9mz5E8mh55vtW062TKCgBM64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=i5OSdp55; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41634598125so14077555e9.3
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2024 04:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712574355; x=1713179155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMnCEktl6VPEor/EtmygqHdTOC4ZhH17Kew2a55Br6I=;
        b=i5OSdp55h7WeBx7+AOh2Kx+ZEUMKA8Pv4BVH2A69VrAbcWiEkVz8tm2tkc3OebrdeA
         TujfVovm/A8wliDWlb7B9PGbktidK1PopuOwq9/s8QKXAYjdJPLbmywj2Ztmx2z+xwqd
         km6Z4wVz33WHpYDPIjXw4NVv3aJaWC2WnG7ZO3W6hspLUrbMZbtbJfgnBBHb1b9k8OfA
         8VPAmjFJRtsYrQWyJgjetmA8g7/tXszgeQK5cXUSjphxHFmy0q8j5+WD7Habccbvh+s0
         /yn6dTz+IIS0jdZKdDQuExIKk+T8iaXhzPzD7q6/Uj5sp3sPf7OzN3qUHvbXJj0XCv0H
         +2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712574355; x=1713179155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMnCEktl6VPEor/EtmygqHdTOC4ZhH17Kew2a55Br6I=;
        b=Q7AML219atIXIXRN2edq1hgitzWXb8rPpyiDntkAHrirsvuqRERh3KaopHTZO6vrzq
         WvWG365Skx2KxKZZa8kkDZluM/6IvzT56Yn329KS3YC+pr9ywSd3l0mkRgU0a9vXhvl7
         Gz8D5eW8YMNoqJdy4RsTMsDBjWOHYvE6LrqnQpPiGil30scD3YBhwYJCL3RT1mPcwzUn
         R10gRluVrC3xIREij/35DUy5EDqmC/lxMPfkEgLuIxowFIqpXFXPL1QAdQ3CPXq1BIsW
         xSHAaXW6AvpvU4s+sn6KK8gPIFAGHRxKohQnAsWPZ6w12v1pg18wqxRvnXwbIzr8ULTn
         dD9A==
X-Forwarded-Encrypted: i=1; AJvYcCUO31o2B/S4bEhFO2EUgUYhPZ4vv7OOy4tWvxH3apC35C8FuAKqtsz5O1FFdit7r3bHTqo77uLUjLoGmW/YGjGDbgJuDmhp0iRr
X-Gm-Message-State: AOJu0YwTRtfKy26nCckUtOB1WYqpZnBZUNH7vOSvRHvCYnNg1kHQpqSI
	69PKgQRIPlD+eeo0PmJf4NYNDE8zzLoslLQ3YjtFMLGJCqzDYaJH5K96s0PStaQ=
X-Google-Smtp-Source: AGHT+IFEu0SHGL5hRh1blS9YTewqyjw2lrCuZ05aUmjypwpaXpgEpZOFspLhJjl70xWRRNoAsXlPVQ==
X-Received: by 2002:a05:600c:358f:b0:415:4853:f722 with SMTP id p15-20020a05600c358f00b004154853f722mr6251223wmq.10.1712574355244;
        Mon, 08 Apr 2024 04:05:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id t21-20020adfa2d5000000b00345690c160esm4620787wra.15.2024.04.08.04.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 04:05:54 -0700 (PDT)
Date: Mon, 8 Apr 2024 13:05:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhPPjzEuOyne8qX7@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho>
 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho>
 <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org>
 <660f22c56a0a2_442282088b@john.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <660f22c56a0a2_442282088b@john.notmuch>

Thu, Apr 04, 2024 at 11:59:33PM CEST, john.fastabend@gmail.com wrote:
>Jakub Kicinski wrote:
>> On Thu, 4 Apr 2024 12:22:02 -0700 Alexander Duyck wrote:
>> > The argument itself doesn't really hold water. The fact is the Meta
>> > data centers are not an insignificant consumer of Linux, 
>> 
>> customer or beneficiary ?
>> 
>> > so it isn't as if the driver isn't going to be used. This implies
>> > some lack of good faith from Meta.
>> 
>> "Good faith" is not a sufficient foundation for a community consisting
>> of volunteers, and commercial entities (with the xz debacle maybe even
>> less today than it was a month ago). As a maintainer I really don't want
>> to be in position of judging the "good faith" of corporate actors.
>> 
>> > I don't understand that as we are
>> > contributing across multiple areas in the kernel including networking
>> > and ebpf. Is Meta expected to start pulling time from our upstream
>> > maintainers to have them update out-of-tree kernel modules since the
>> > community isn't willing to let us maintain it in the kernel? Is the
>> > message that the kernel is expected to get value from Meta, but that
>> > value is not meant to be reciprocated? Would you really rather have
>> > us start maintaining our own internal kernel with our own
>> > "proprietary goodness", and ask other NIC vendors to have to maintain
>> > their drivers against yet another kernel if they want to be used in
>> > our data centers?
>> 
>> Please allow the community to make rational choices in the interest of
>> the project and more importantly the interest of its broader user base.
>> 
>> Google would also claim "good faith" -- undoubtedly is supports 
>> the kernel, and lets some of its best engineers contribute.
>> Did that make them stop trying to build Fuchsia? The "good faith" of
>> companies operates with the limits of margin of error of they consider
>> rational and beneficial.
>> 
>> I don't want to put my thumb on the scale (yet?), but (with my
>> maintainer hat on) please don't use the "Meta is good" argument, because
>> someone will send a similar driver from a less involved company later on
>> and we'll be accused of playing favorites :( Plus companies can change
>> their approach to open source from "inclusive" to "extractive" 
>> (to borrow the economic terminology) rather quickly.
>> 
>
>I'll throw my $.02 in. In this case you have a driver that I only scanned
>so far, but looks well done. Alex has written lots of drivers I trust he
>will not just abondon it. And if it does end up abondoned and no one
>supports it at some future point we can deprecate it same as any other
>driver in the networking tree. All the feedback is being answered and
>debate is happening so I expect will get a v2, v3 or so. All good signs
>in my point.
>
>Back to your point about faith in a company. I don't think we even need
>to care about whatever companies business plans. The author could have
>submitted with their personal address for what its worth and called it
>drivers/alexware/duyck.o Bit extreme and I would have called him on it,
>but hopefully the point is clear.
>
>We have lots of drivers in the tree that are hard to physically get ahold
>of. Or otherwise gated by paying some vendor for compute time, etc. to
>use. We even have some drivers where the hardware itself never made
>it out into the wild or only a single customer used it before sellers 
>burned it for commercial reasons or hw wasn't workable, team was cut, etc.
>
>I can't see how if I have a physical NIC for it on my desk here makes
>much difference one way or the other.
>
>The alternative is much worse someone builds a team of engineers locks
>them up they build some interesting pieces and we never get to see it
>because we tried to block someone from opensourcing their driver?
>Eventually they need some kernel changes and than we block those too
>because we didn't allow the driver that was the use case? This seems
>wrong to me.
>
>Anyways we have zero ways to enforce such a policy. Have vendors
>ship a NIC to somebody with the v0 of the patch set? Attach a picture? 

Come on. Are you kidding? Isn't this case crystal clear?


>Even if vendor X claims they will have a product in N months and
>than only sells it to qualified customers what to do we do then.
>Driver author could even believe the hardware will be available
>when they post the driver, but business may change out of hands
>of the developer.
>
>I'm 100% on letting this through assuming Alex is on top of feedback
>and the code is good. I think any other policy would be very ugly
>to enforce, prove, and even understand. Obviously code and architecture
>debates I'm all for. Ensuring we have a trusted, experienced person
>signed up to review code, address feedback, fix whatever syzbot finds
>and so on is also a must I think. I'm sure Alex will take care of
>it.

You are for some reason making this submission very personal on Alex.
Just to be clear, this has nothing to do with Alex.


>
>Thanks,
>John

