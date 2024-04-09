Return-Path: <linux-pci+bounces-5929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4E189D788
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 13:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79991F24F03
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 11:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A015A85629;
	Tue,  9 Apr 2024 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xQjy2pj2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E381AA5
	for <linux-pci@vger.kernel.org>; Tue,  9 Apr 2024 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660519; cv=none; b=dklsTZek/eK/HHGgXkYGAtAROCJukanZMumSzCuYHoIAt6k5zozZ4pYCf8sfPVgLZjeVb0/5q8mGMD6488aDyQNBUVF9HD0h3DUUkuN1993gz4v0JmaFNYLPGASvTM/tqq9wXgtG4mXcLDmkoWgQHgzo/frp2kmcgathVDq24Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660519; c=relaxed/simple;
	bh=cyKMv918CGWEOV5m/jVZ6fedw33r0JWxw/IGrvBc0Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nW9d3+eJXIcS69t3jrMSBTOz2xhOeb9Ljv4h/umbk3kcP0DHKZBkLKBaO/aKRAQZrwFsGOrW4QZzDvbuJDXH0fQ1IAIQ9zC3ST3IVY+uLjmMVKJp2/eD6qRwNcEGY8psETdfEdMTOWuJDTZszl1ZVHwMKh+ywojvE/SocMMrwJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xQjy2pj2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4169d794358so5440775e9.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Apr 2024 04:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712660516; x=1713265316; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ghzoZZbiK4pCy4yVHv3cKJnocQh3hGrEdW9JRT2mUaM=;
        b=xQjy2pj2W4jczdc7wGDNw3iiSAn18ne8PXTSKDrfWkrnebRD2uAT46N15MKcz12SEt
         kVz+FXwEUov6AVHNAqS4HSPsIUMg2Ev7yThhnwTzrDEoN6g8FaG2CRDQnRRqmRvjUGmA
         EQIJri1lO3zGUCrsNiCiCuuVsvgA3URfldoujnhdO/dADr+E1hDjvl2S9jONPzhKUdsa
         P8TaFzS8MrcpbP+2NJl4xUsqPiYEHsdI4LlP1ebBJncWnd+GSTOzrfbAA/mQwl7fUmjL
         G2aPepPSb9CcMomHhwFQKbWsgtLGwvF4q2e+IRQQnmSWRgpvhtHn4WYkItjIJkjFqR65
         g2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712660516; x=1713265316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghzoZZbiK4pCy4yVHv3cKJnocQh3hGrEdW9JRT2mUaM=;
        b=CswwmgHx7eL9iJRxvjDkO30lSeX3F8gEngheXkWiaubzuvTCTewqwCvKU9AfP9tOT9
         XOSxtC8zvCPvGuqNWPovKNoUYI/BPIK1tB6VkXQ0/6r+E38DvUr+GI8vEyACHdkjUvCJ
         nnSIzQwHTem6h1qHQlnMLEmoEOUagYm9SbFO73U0coQtiAtUleZ0TjdXUvP94OqJwTa5
         2DFBB9qjc3QQdf9EwM2w4TK0xKOXSoCv+feioE8n8A5JUM7csDLbnhR2D4w3TZpsjtTV
         SZyve3516HuvEtM5fbs7gQhDrDp5cFc1mygJft97qdd4S4gSexgKVZmh5l5iDJ3RUyVM
         mHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1/0wLyqCxOxmqxsduz4ObhAFZC4KH7NyzISi2Mb4dDvz9ZsJC9iFIoh8UpRxx1/GdzH1u7x74LK0uxAfVGGej3RrGbA1E9/AH
X-Gm-Message-State: AOJu0YyngJ8Snwycx76BwyISWCm93+ZkNKsLtzdkO6ZvnmBNdyZa8Nuq
	9iVJBzk+9dBzaZliltJsd75q0fuB0AwMdz5LISnfL3ToJwcbjSis3Wt5OQ+N/XQ=
X-Google-Smtp-Source: AGHT+IFOvJd21kmVeIM6N9PkG+qQRefctpXlG9vlyyHwj2ExttRLNEEhInVzA6Ph+qNg7LoR/crftg==
X-Received: by 2002:a05:600c:4fc3:b0:416:a36b:995 with SMTP id o3-20020a05600c4fc300b00416a36b0995mr1298568wmq.18.1712660515782;
        Tue, 09 Apr 2024 04:01:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id n1-20020a05600c4f8100b004169836bf9asm3487052wmq.23.2024.04.09.04.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 04:01:55 -0700 (PDT)
Date: Tue, 9 Apr 2024 13:01:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhUgH9_beWrKbwwg@nanopsycho>
References: <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <ZhPaIjlGKe4qcfh_@nanopsycho>
 <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
 <ZhQgmrH-QGu6HP-k@nanopsycho>
 <66142a4b402d5_2cb7208ec@john.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66142a4b402d5_2cb7208ec@john.notmuch>

Mon, Apr 08, 2024 at 07:32:59PM CEST, john.fastabend@gmail.com wrote:
>Jiri Pirko wrote:
>> Mon, Apr 08, 2024 at 05:46:35PM CEST, alexander.duyck@gmail.com wrote:
>> >On Mon, Apr 8, 2024 at 4:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrote:
>> >> >On Fri, Apr 5, 2024 at 8:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>> >> >>
>> >> >> On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
>> >> >> > > Alex already indicated new features are coming, changes to the core
>> >> >> > > code will be proposed. How should those be evaluated? Hypothetically
>> >> >> > > should fbnic be allowed to be the first implementation of something
>> >> >> > > invasive like Mina's DMABUF work? Google published an open userspace
>> >> >> > > for NCCL that people can (in theory at least) actually run. Meta would
>> >> >> > > not be able to do that. I would say that clearly crosses the line and
>> >> >> > > should not be accepted.
>> >> >> >
>> >> >> > Why not? Just because we are not commercially selling it doesn't mean
>> >> >> > we couldn't look at other solutions such as QEMU. If we were to
>> >> >> > provide a github repo with an emulation of the NIC would that be
>> >> >> > enough to satisfy the "commercial" requirement?
>> >> >>
>> >> >> My test is not "commercial", it is enabling open source ecosystem vs
>> >> >> benefiting only proprietary software.
>> >> >
>> >> >Sorry, that was where this started where Jiri was stating that we had
>> >> >to be selling this.
>> >>
>> >> For the record, I never wrote that. Not sure why you repeat this over
>> >> this thread.
>> >
>> >Because you seem to be implying that the Meta NIC driver shouldn't be
>> >included simply since it isn't going to be available outside of Meta.
>> >The fact is Meta employs a number of kernel developers and as a result
>> >of that there will be a number of kernel developers that will have
>> >access to this NIC and likely do development on systems containing it.
>> >In addition simply due to the size of the datacenters that we will be
>> >populating there is actually a strong likelihood that there will be
>> >more instances of this NIC running on Linux than there are of some
>> >other vendor devices that have been allowed to have drivers in the
>> >kernel.
>> 
>> So? The gain for community is still 0. No matter how many instances is
>> private hw you privately have. Just have a private driver.
>
>The gain is the same as if company X makes a card and sells it
>exclusively to datacenter provider Y. We know this happens.

Different story. The driver is still the same. Perhaps only some parts
of it are tailored to fit one person's need, maybe. But here, the whole
thing is obviously is targeted to one person. Can't you see the scale on
which these are different?


>Vendors would happily spin up a NIC if a DC with scale like this
>would pay for it. They just don't advertise it in patch 0/X,
>"adding device for cloud provider foo".
>
>There is no difference here. We gain developers, we gain insights,
>learnings and Linux and OSS drivers are running on another big
>DC. They improve things and find bugs they upstream them its a win.
>
>The opposite is also true if we exclude a driver/NIC HW that is
>running on major DCs we lose a lot of insight, experience, value.

Could you please describe in details and examples what exactly is we
are about to loose? I don't see it.


>DCs are all starting to build their own hardware if we lose this
>section of HW we lose those developers too. We are less likely
>to get any advances they come up with. I think you have it backwards.
>Eventually Linux networking becomes either commodity and irrelevant
>for DC deployments.
>
>So I strongly disagree we lose by excluding drivers and win by
>bringing it in.
>
>> 
>> 
>> >
>> >So from what I can tell the only difference is if we are manufacturing
>> >this for sale, or for personal use. Thus why I mention "commercial"
>> >since the only difference from my perspective is the fact that we are
>> >making it for our own use instead of selling it.
>> 
>> Give it for free.
>
>Huh?
>
>> 
>> 
>> >
>> >[...]
>> >
>> >> >> > I agree. We need a consistent set of standards. I just strongly
>> >> >> > believe commercial availability shouldn't be one of them.
>> >> >>
>> >> >> I never said commercial availability. I talked about open source vs
>> >> >> proprietary userspace. This is very standard kernel stuff.
>> >> >>
>> >> >> You have an unavailable NIC, so we know it is only ever operated with
>> >> >> Meta's proprietary kernel fork, supporting Meta's proprietary
>> >> >> userspace software. Where exactly is the open source?
>> >> >
>> >> >It depends on your definition of "unavailable". I could argue that for
>> >> >many most of the Mellanox NICs are also have limited availability as
>> >> >they aren't exactly easy to get a hold of without paying a hefty
>> >> >ransom.
>> >>
>> >> Sorry, but I have to say this is ridiculous argument, really Alex.
>> >> Apples and oranges.
>> >
>> >Really? So would you be making the same argument if it was
>> >Nvidia/Mellanox pushing the driver and they were exclusively making it
>> >just for Meta, Google, or some other big cloud provider? I suspect
>> 
>> Heh, what ifs :) Anyway, chance that happens is very close to 0.
>> 
>> 
>> >not. If nothing else they likely wouldn't disclose the plan for
>> >exclusive sales to get around this sort of thing. The fact is I know
>> >many of the vendors make proprietary spins of their firmware and
>> >hardware for specific customers. The way I see it this patchset is
>> >being rejected as I was too honest about the general plan and use case
>> >for it.
>> >
>> >This is what I am getting at. It just seems like we are playing games
>> >with semantics where if it is a vendor making the arrangement then it
>> >is okay for them to make hardware that is inaccessible to most, but if
>> >it is Meta then somehow it isn't.
>
>

