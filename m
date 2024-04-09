Return-Path: <linux-pci+bounces-5941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698D889DC4A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 16:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F949285A6D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 14:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF49C12FF80;
	Tue,  9 Apr 2024 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JMftEASl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2413612FF72
	for <linux-pci@vger.kernel.org>; Tue,  9 Apr 2024 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672937; cv=none; b=FQJXpteQe4byhc3nFClum57OMdvcQ57AWmqf5bw/azfwAR8VI8cmMawUuCFW+nuWmSPtjtG9U/PRKYiSKIThEeJzdWnyAETve0kljtb5vyfNJkmD79AC9nJe6YpgjejoNHeWjjM6HzCzR7jgwzgsW3gOaOOZmrC3xUbYTpYBiOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672937; c=relaxed/simple;
	bh=H4jk50MLg+xWXxh8Mg0A62SnnjW5oUPfdr8xOtp+NNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nimHXsKICOfXYt5Lm0eC0ggzL5YrzHPWSBPHSterBVuEHIVdR0ws/ZGE0WKOFzys+rJGD88iVpkUwu4rCPius1NKACba8Ob1Qez89ADpV8kQMTi+L/gOz7N4QQqDGEN43BMwdiVcSucYoTq1k++HGI2fXTroZi6Lkeu5wRKb0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JMftEASl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a51d0dda061so328801166b.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Apr 2024 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712672933; x=1713277733; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CNHD4l5zzzHwv6LeHcOWpIcEgMmhxX1t4o2xUqNJQLI=;
        b=JMftEASlY1eCFbp2Ajqs2B/x0p4oSGVrUcohKWIBRiFpPvgPpxqCrO7a4zJ9OvD+m8
         qGCI7QXUSXqAWYOi+seKTeHsaEpMj+p9Kx/9ReHGWW/nep1nJ9v5iEozmUzMfHeKk6P3
         gAycNxE4xYk6Hh+CHCiu+JYeGqKI54uBmF2+NIb5sgSWfnyJkNWWKG5VrfSm/45dZL3o
         4XzKJk9SKyUk49+RU6PFWDV5sBoj2b3ZmtxnRXWt4ayJ+dGSbLTkgzMdMYcyhFEkThEX
         d6yYZkPiWftZlb+GC1bf7mrBSxpSaWZhMFobbWC0TtaLnoo+9vpIOkuX3nsrqMDtrT2R
         nlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712672933; x=1713277733;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNHD4l5zzzHwv6LeHcOWpIcEgMmhxX1t4o2xUqNJQLI=;
        b=dOFXkd3j80jhRo1NH+qWDMr04g57IMGo5hNZThn3rVS8rU/KwiW7+yc+/kws4nLnWr
         m+bKGBG8382919barAtYaOZISxcQsE3aFRM5zCsRTFS1KERqIitaXURs8yVDnTsQpQVy
         PFjWwyhi+QAh6nzL/tY92yR0FmRw6N4hmpuhqeUT/u8ahLca9Hg3ROZFo3nRSqiyeO8m
         BI4idkri2sQFVb8vbD1cchmwW5q3IbPrZVdY83UDZy+vV7ST2GlZwVytpn5q9UbzefMQ
         yXsrQ99kPXDqrTBbdnd04nwUEiPsHigo4SHD1Jea5ZrjUpN4edDitGS88BfdfAFfl1UA
         0R9w==
X-Forwarded-Encrypted: i=1; AJvYcCW/caV0wU2uN/0Fvc7jDKVkDWiVFPgulHRcerO7DdT9Bw1cNGAJrdiwFnxFG2swLkEiYc1G9vlFGQhM8NFE78iYbHxWu3pW9y+K
X-Gm-Message-State: AOJu0YxORpLlahG3f5Oxas7nbilKAUV5cwQysFk8oXP8ZeFgdaaO/+RH
	PkedA5wF4Ae3wNhCEpa4q8jD3R+wnhnXoQZV/pInQRXgHE4my+VyICd7mVNCrq0=
X-Google-Smtp-Source: AGHT+IHqFoYP0VeHlWPkMirjSvMdnIdKXGg/PdZLQKr3uKi3kwKAZaO8eyrvRLUozgLQKgivBv9Jjg==
X-Received: by 2002:a17:906:1398:b0:a4a:36e4:c3f9 with SMTP id f24-20020a170906139800b00a4a36e4c3f9mr2368706ejc.7.1712672932951;
        Tue, 09 Apr 2024 07:28:52 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id jy23-20020a170907763700b00a4ea0479235sm5763767ejc.107.2024.04.09.07.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:28:52 -0700 (PDT)
Date: Tue, 9 Apr 2024 16:28:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhVQo32UiiSxDC6h@nanopsycho>
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
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49d7e1ba-0d07-43d2-a5e7-81f142152f8a@gmail.com>

Tue, Apr 09, 2024 at 03:05:47PM CEST, f.fainelli@gmail.com wrote:
>
>
>On 4/9/2024 3:56 AM, Jiri Pirko wrote:
>> Mon, Apr 08, 2024 at 11:36:42PM CEST, f.fainelli@gmail.com wrote:
>> > On 4/8/24 09:51, Jiri Pirko wrote:
>> > > Mon, Apr 08, 2024 at 05:46:35PM CEST, alexander.duyck@gmail.com wrote:
>> > > > On Mon, Apr 8, 2024 at 4:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> > > > > 
>> > > > > Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrote:
>> > > > > > On Fri, Apr 5, 2024 at 8:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>> > > > > > > 
>> > > > > > > On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
>> > > > > > > > > Alex already indicated new features are coming, changes to the core
>> > > > > > > > > code will be proposed. How should those be evaluated? Hypothetically
>> > > > > > > > > should fbnic be allowed to be the first implementation of something
>> > > > > > > > > invasive like Mina's DMABUF work? Google published an open userspace
>> > > > > > > > > for NCCL that people can (in theory at least) actually run. Meta would
>> > > > > > > > > not be able to do that. I would say that clearly crosses the line and
>> > > > > > > > > should not be accepted.
>> > > > > > > > 
>> > > > > > > > Why not? Just because we are not commercially selling it doesn't mean
>> > > > > > > > we couldn't look at other solutions such as QEMU. If we were to
>> > > > > > > > provide a github repo with an emulation of the NIC would that be
>> > > > > > > > enough to satisfy the "commercial" requirement?
>> > > > > > > 
>> > > > > > > My test is not "commercial", it is enabling open source ecosystem vs
>> > > > > > > benefiting only proprietary software.
>> > > > > > 
>> > > > > > Sorry, that was where this started where Jiri was stating that we had
>> > > > > > to be selling this.
>> > > > > 
>> > > > > For the record, I never wrote that. Not sure why you repeat this over
>> > > > > this thread.
>> > > > 
>> > > > Because you seem to be implying that the Meta NIC driver shouldn't be
>> > > > included simply since it isn't going to be available outside of Meta.
>> > > > The fact is Meta employs a number of kernel developers and as a result
>> > > > of that there will be a number of kernel developers that will have
>> > > > access to this NIC and likely do development on systems containing it.
>> > > > In addition simply due to the size of the datacenters that we will be
>> > > > populating there is actually a strong likelihood that there will be
>> > > > more instances of this NIC running on Linux than there are of some
>> > > > other vendor devices that have been allowed to have drivers in the
>> > > > kernel.
>> > > 
>> > > So? The gain for community is still 0. No matter how many instances is
>> > > private hw you privately have. Just have a private driver.
>> > 
>> > I am amazed and not in a good way at how far this has gone, truly.
>> > 
>> > This really is akin to saying that any non-zero driver count to maintain is a
>> > burden on the community. Which is true, by definition, but if the goal was to
>> > build something for no users, then clearly this is the wrong place to be in,
>> > or too late. The systems with no users are the best to maintain, that is for
>> > sure.
>> > 
>> > If the practical concern is wen you make tree wide API change that fbnic
>> > happens to use, and you have yet another driver (fbnic) to convert, so what?
>> > Work with Alex ahead of time, get his driver to be modified, post the patch
>> > series. Even if Alex happens to move on and stop being responsible and there
>> > is no maintainer, so what? Give the driver a depreciation window for someone
>> > to step in, rip it, end of story. Nothing new, so what has specifically
>> > changed as of April 4th 2024 to oppose such strong rejection?
>> 
>> How you describe the flow of internal API change is totally distant from
>> reality. Really, like no part is correct:
>> 1) API change is responsibility of the person doing it. Imagine working
>>     with 40 driver maintainers for every API change. I did my share of
>>     API changes in the past, maintainer were only involved to be cced.
>
>As a submitter you propose changes and silence is acknowledgement. If one of
>your API changes broke someone's driver and they did not notify you of the
>breakage during the review cycle, it falls on their shoulder to fix it for
>themselves and they should not be holding back your work, that would not be

Does it? I don't think so. If you break something, better try to fix it
before somebody else has to.


>fair. If you know about the breakage, and there is still no fix, that is an
>indication the driver is not actively used and maintained.

So? That is not my point. If I break something in fbnic, why does anyone
care? Nobody is ever to hit that bug, only Meta DC.


>
>This also does not mean you have to do the entire API changes to a driver you
>do not know about on your own. Nothing ever prevents you from posting the
>patches as RFC and say: "here is how I would go about changing your driver,
>please review and help me make corrections". If the driver maintainers do not
>respond there is no reason their lack of involvement should refrain your
>work, and so your proposed changes will be merged eventually.

Realistically, did you see that ever happen. I can't recall.


>
>Is not this the whole point of being a community and be able to delegate and
>mitigate the risk of large scale changes?
>
>> 2) To deprecate driver because the maintainer is not responsible. Can
>>     you please show me one example when that happened in the past?
>
>I cannot show you an example because we never had to go that far and I did
>not say that this is an established practice, but that we *could* do that if
>we ever reached that point.

You are talking about a flow that does not exist. I don't understand how
is that related to this discussion then.


>
>> 
>> 
>> > 
>> > Like it was said, there are tons of drivers in the Linux kernel that have a
>> > single user, this one might have a few more than a single one, that should be
>> > good enough.
>> 
>> This will have exactly 0. That is my point. Why to merge something
>> nobody will ever use?
>
>Even if Alex and his firmware colleague end up being the only two people
>using this driver if the decision is to make it upstream because this is the
>desired distribution and development model of the driver we should respect
>that.
>
>And just to be clear, we should not be respecting that because Meta, or Alex
>or anyone decided that they were doing the world a favor by working in the
>open rather than being closed door, but simply because we cannot *presume*

I don't see any favor for the community. What's the favor exactly?
The only favor I see is the in the opposite direction, community giving
Meta free cycles saving their backporting costs. Why?


>about their intentions and the future.

Heh, the intention is pretty clear from this discussion, isn't it? If
they ever by any chance decide to go public with their device, driver
for that could be submitted at a time. But this is totally hypothetical.


>
>For drivers specifically, yes, there is a question of to which degree can we
>scale horizontally, and I do not think there is ever going to be an answer to
>that, as we will continue to see new drivers emerge, possibly with few users,
>for some definition of few.
>-- 
>Florian

