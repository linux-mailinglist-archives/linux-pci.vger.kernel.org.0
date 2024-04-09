Return-Path: <linux-pci+bounces-5928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92A689D752
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 12:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204DA1F24F39
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D02C82D7F;
	Tue,  9 Apr 2024 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oL1D7pwC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0978981AA5
	for <linux-pci@vger.kernel.org>; Tue,  9 Apr 2024 10:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660175; cv=none; b=dX+Plt2Mmk+IX8Co8f3EHJ+5gR8ur4hgq6nXpKakTUYsm5FG0bzICkDWrhC04h7z+zSg2Zu9jdfxBluHjEGJWU5VN3DbzzL4+m7feNMAURsQX/akXWlAxQb5UITMkk8gIsnLSVp9U98zsNyie7CRWxxKzU4FTxlxEmsHQS/3ZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660175; c=relaxed/simple;
	bh=6y89ex60K2u4aYRRegTZ7ifaOtdL3U4CSFJzYwsl4+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGxts65NDguBxKzbh9h0G5aIr42CImWnCVHcP0Xh3JL3/gfA+6t5fNI1rmoo2LvMXSWt5JZhy+DiKlOo9DBtaIQ+8rK4lWK106auOwHLT89DK7eBuKYVSPJkBS7wt4ALiJWWSmVTejwKkNois91d5Izf8oqlqYIhiimxRjeSIMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oL1D7pwC; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d717603aa5so64616701fa.0
        for <linux-pci@vger.kernel.org>; Tue, 09 Apr 2024 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712660171; x=1713264971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2lLoy9rmgjgwScKRCHTbVCLRe4qHVdiF76SVyXj+DFY=;
        b=oL1D7pwCOzD5gooa0X7xyW2iXD0E90umsYr8DBZED7wTGLcHYayPfy8YRsjaNdY0Q1
         QF/D/xsUnW4ReSgo70iZR+Ty0loUk6LFBF1ag3B2BfOc34En57KnrzwUVaHdftZQIgHa
         Aalh15tOuxv1STeLxWFDruUyBcH3DbD/+t5U4fbUjEcFVHMnw4iwWS6uK1HnhDylUPsj
         1N6MAQ6o7oghMxPI6KJV63bGfQvGCGWT+HwOY0LptQAULCmRf0O1MSbEClX1Zix/OVzb
         zL1M+GuS2RX8OxeF3YWJ9krSYJJBBV+YxyHcrGczBAaNvLXCKJJqpH41D4qm9R/6/9ED
         LQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712660171; x=1713264971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lLoy9rmgjgwScKRCHTbVCLRe4qHVdiF76SVyXj+DFY=;
        b=qQJ6POQ1MvebpS+WyLy4DR+ib9K7WRooOhWNonCp1xis8WHf+kxj3Skw52nLTLs0Z3
         Jk6ArYBwX5To6xbtiX74idBPznh9+ftfIQZSJOMC26dkPTTXk6nCZRpWNH+fTQPO1Deh
         HjBASfQFU2tLNs+xkSGC/iAvCZFS588zcDRAqUdixfJ1DEnvbbH2khZvlUpWiF6OM2yD
         jMhB8eIPPEmbXbmMMi7R8SRNao8sUUPyj6lU8akux7OlcNQMCWbG8A1+wrjUayig0BiM
         RqpzPAFbDA7lZX2NUzubGaOV5QPSyIrLDvTK2kDfJLdofoiVwqP3SUxJDo6bNdQizzAW
         eurw==
X-Forwarded-Encrypted: i=1; AJvYcCVbjlNNuQO5qncTcv4hZC3ffvXh8WozkGkkaET29jNGAC9pA5CcS1uarGjyxLqvAnqfJMPo9hfGB9z2BkwsBc48O1QVY+126HYm
X-Gm-Message-State: AOJu0YxbsTQ6sFa86e+8OX3JC5tCl/pkIwvudIUqm33VsgR9XzetbeL2
	xFeCzf/GCfODFlsFOOKsZeCt6IEasMZEjAfFO6Y4uXJhAJJj/6SMyxpprVUzdXY=
X-Google-Smtp-Source: AGHT+IGYdleoQk8Sk3Y8LauYX0LG7vjnwVtCQfGveRWFnQHINd7pKGpDrS/pEVDoleWGVw0JKctwqA==
X-Received: by 2002:a2e:90d4:0:b0:2d8:4cff:73e9 with SMTP id o20-20020a2e90d4000000b002d84cff73e9mr7513284ljg.46.1712660170813;
        Tue, 09 Apr 2024 03:56:10 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id x8-20020adfffc8000000b00343c1cd5aedsm11089617wrs.52.2024.04.09.03.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:56:10 -0700 (PDT)
Date: Tue, 9 Apr 2024 12:56:05 +0200
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
Message-ID: <ZhUexUl-kD6F1huf@nanopsycho>
References: <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <ZhPaIjlGKe4qcfh_@nanopsycho>
 <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
 <ZhQgmrH-QGu6HP-k@nanopsycho>
 <ae67d1a6-8ca6-432e-8f1d-2e3e45cad848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae67d1a6-8ca6-432e-8f1d-2e3e45cad848@gmail.com>

Mon, Apr 08, 2024 at 11:36:42PM CEST, f.fainelli@gmail.com wrote:
>On 4/8/24 09:51, Jiri Pirko wrote:
>> Mon, Apr 08, 2024 at 05:46:35PM CEST, alexander.duyck@gmail.com wrote:
>> > On Mon, Apr 8, 2024 at 4:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> > > 
>> > > Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrote:
>> > > > On Fri, Apr 5, 2024 at 8:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>> > > > > 
>> > > > > On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
>> > > > > > > Alex already indicated new features are coming, changes to the core
>> > > > > > > code will be proposed. How should those be evaluated? Hypothetically
>> > > > > > > should fbnic be allowed to be the first implementation of something
>> > > > > > > invasive like Mina's DMABUF work? Google published an open userspace
>> > > > > > > for NCCL that people can (in theory at least) actually run. Meta would
>> > > > > > > not be able to do that. I would say that clearly crosses the line and
>> > > > > > > should not be accepted.
>> > > > > > 
>> > > > > > Why not? Just because we are not commercially selling it doesn't mean
>> > > > > > we couldn't look at other solutions such as QEMU. If we were to
>> > > > > > provide a github repo with an emulation of the NIC would that be
>> > > > > > enough to satisfy the "commercial" requirement?
>> > > > > 
>> > > > > My test is not "commercial", it is enabling open source ecosystem vs
>> > > > > benefiting only proprietary software.
>> > > > 
>> > > > Sorry, that was where this started where Jiri was stating that we had
>> > > > to be selling this.
>> > > 
>> > > For the record, I never wrote that. Not sure why you repeat this over
>> > > this thread.
>> > 
>> > Because you seem to be implying that the Meta NIC driver shouldn't be
>> > included simply since it isn't going to be available outside of Meta.
>> > The fact is Meta employs a number of kernel developers and as a result
>> > of that there will be a number of kernel developers that will have
>> > access to this NIC and likely do development on systems containing it.
>> > In addition simply due to the size of the datacenters that we will be
>> > populating there is actually a strong likelihood that there will be
>> > more instances of this NIC running on Linux than there are of some
>> > other vendor devices that have been allowed to have drivers in the
>> > kernel.
>> 
>> So? The gain for community is still 0. No matter how many instances is
>> private hw you privately have. Just have a private driver.
>
>I am amazed and not in a good way at how far this has gone, truly.
>
>This really is akin to saying that any non-zero driver count to maintain is a
>burden on the community. Which is true, by definition, but if the goal was to
>build something for no users, then clearly this is the wrong place to be in,
>or too late. The systems with no users are the best to maintain, that is for
>sure.
>
>If the practical concern is wen you make tree wide API change that fbnic
>happens to use, and you have yet another driver (fbnic) to convert, so what?
>Work with Alex ahead of time, get his driver to be modified, post the patch
>series. Even if Alex happens to move on and stop being responsible and there
>is no maintainer, so what? Give the driver a depreciation window for someone
>to step in, rip it, end of story. Nothing new, so what has specifically
>changed as of April 4th 2024 to oppose such strong rejection?

How you describe the flow of internal API change is totally distant from
reality. Really, like no part is correct:
1) API change is responsibility of the person doing it. Imagine working
   with 40 driver maintainers for every API change. I did my share of
   API changes in the past, maintainer were only involved to be cced.
2) To deprecate driver because the maintainer is not responsible. Can
   you please show me one example when that happened in the past?


>
>Like it was said, there are tons of drivers in the Linux kernel that have a
>single user, this one might have a few more than a single one, that should be
>good enough.

This will have exactly 0. That is my point. Why to merge something
nobody will ever use?


>
>What the heck is going on?
>-- 
>Florian
>

