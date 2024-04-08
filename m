Return-Path: <linux-pci+bounces-5889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6E889CA17
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 18:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451751F27031
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 16:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD9914291D;
	Mon,  8 Apr 2024 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kVoJFHA7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B12140E2B
	for <linux-pci@vger.kernel.org>; Mon,  8 Apr 2024 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595107; cv=none; b=OhJOoJEiDOg2a7ai2Ac8KiGud1jr9SwX+E0j7raQpLRI31Hzv0llRiZwL0geMRl6kWhjg7RVIIxqqk8e72ikvSvSGy+LsQqcA0vnB2O2mcwLjPFa75/r4lr535KUzP3WpTQ53waQIFC6aCuZKN1kTIHmUROQ8v/28xpBD+gGjgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595107; c=relaxed/simple;
	bh=8XojHk/3pPsmqDjvn1sGwqTxWEERTHj83CZMNXcpSV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fw8hNmzSWfp7e0JQt4ibBOzw3IWahnbts71G25ndtv1eqEqtggEO5YGom97qo4GMgPxMLCd67Q7c92S6BnnWSKrFRHasv8vJX1VvuwCOZqK6toA17oSS/UPyv6vyAPn+XsIr4fHWLh3RvPaXIb2IANURUbYhQXjDyu4r/0JQXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kVoJFHA7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-416511f13aaso11035915e9.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2024 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712595103; x=1713199903; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8XojHk/3pPsmqDjvn1sGwqTxWEERTHj83CZMNXcpSV8=;
        b=kVoJFHA7zyLcsgPsvqpLU0nRBZ3p5bbRKNGe4y0WEFqpHm2wF4c/i8Vj7bitlsGijp
         b2jZcrfDbeEKEL4SnPtHeWWGEtXGEucYlcq+dzyfooGy+AYu+8DtQNZQElmQkp2J1QPu
         4+ejq5GyI1DX6bPs3zxyUr1J7y7EHFKjmNjYUCtesvBdWYmq+a9z/199zgDBhTbDgBJ+
         cv5aqdXRDt42Yw/WjStuqcJAOwrC1aaUjazaAcQId9yLbHAfH3TGnQ5qxvGmk7SQPocc
         BJFItWITkGAflS6v62R49ZQgNPmLX+swIT7ie/0BAoMWbfFvBvLvfyKHoD19XHMVdYah
         qRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712595103; x=1713199903;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XojHk/3pPsmqDjvn1sGwqTxWEERTHj83CZMNXcpSV8=;
        b=Bc3OFz0aZDW+7VDlYasOTXnItiF8znqUeB1dNIUCKporfCvp+d8nckzsNV4A5vWM/H
         0P/B1CGefQcvtHYesNys/mDoNTagEi1pWFk7AUqRDEBMA89pD03HGzbCU9/vfBSzhjGd
         A+quKWGuXQ+TyzELmmxLM7miOeg0L8t0+RoZLtFPbYSFIiTlRkFw2BRZZJWNTCaVau99
         XXs3xZ6KvWKHk+N16D6dPFa6a+K/cKK8vK7FwI2Dxrd2gbowxB8QqucqMKMFTpYoMWVH
         Sejy6oKmVkp7hTdC/lSzFKJDkxq+vsjFbEqCG+zeTfJXqPK+JC7BBggSJwW+0lyWub3j
         sWcg==
X-Forwarded-Encrypted: i=1; AJvYcCWN9hVVouYaT080+6sZOtO8Ww/6EWE8agDgafDWukiSgxZPi8vv85zEBTTr4HpqfURtE7o5XzZwPbPdVVPcWItfMUVtROOM1CHt
X-Gm-Message-State: AOJu0YzmWP4n1Hr3O3knpsaX8l6iEUOhlLSA/1Grp3RNfIaLZta3QZ6S
	5s5YvAU+94DuFo2lSxQvjA+yoUJbtE+ueO6wmRxJj2dGFcsPZRmdpIzh9sUbEuQ=
X-Google-Smtp-Source: AGHT+IGLLqkpjRAbFq72q9reOMafWhGH7w1CQAxqtd+p8vWMzIwb5VmOywyfqCAWNrUdJ82kK2WaNg==
X-Received: by 2002:a05:600c:34d5:b0:416:3db7:74b4 with SMTP id d21-20020a05600c34d500b004163db774b4mr4084658wmq.24.1712595103085;
        Mon, 08 Apr 2024 09:51:43 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id j31-20020a05600c1c1f00b004163de5135dsm9114890wms.34.2024.04.08.09.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 09:51:42 -0700 (PDT)
Date: Mon, 8 Apr 2024 18:51:38 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhQgmrH-QGu6HP-k@nanopsycho>
References: <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <ZhPaIjlGKe4qcfh_@nanopsycho>
 <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>

Mon, Apr 08, 2024 at 05:46:35PM CEST, alexander.duyck@gmail.com wrote:
>On Mon, Apr 8, 2024 at 4:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrote:
>> >On Fri, Apr 5, 2024 at 8:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>> >>
>> >> On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
>> >> > > Alex already indicated new features are coming, changes to the core
>> >> > > code will be proposed. How should those be evaluated? Hypothetically
>> >> > > should fbnic be allowed to be the first implementation of something
>> >> > > invasive like Mina's DMABUF work? Google published an open userspace
>> >> > > for NCCL that people can (in theory at least) actually run. Meta would
>> >> > > not be able to do that. I would say that clearly crosses the line and
>> >> > > should not be accepted.
>> >> >
>> >> > Why not? Just because we are not commercially selling it doesn't mean
>> >> > we couldn't look at other solutions such as QEMU. If we were to
>> >> > provide a github repo with an emulation of the NIC would that be
>> >> > enough to satisfy the "commercial" requirement?
>> >>
>> >> My test is not "commercial", it is enabling open source ecosystem vs
>> >> benefiting only proprietary software.
>> >
>> >Sorry, that was where this started where Jiri was stating that we had
>> >to be selling this.
>>
>> For the record, I never wrote that. Not sure why you repeat this over
>> this thread.
>
>Because you seem to be implying that the Meta NIC driver shouldn't be
>included simply since it isn't going to be available outside of Meta.
>The fact is Meta employs a number of kernel developers and as a result
>of that there will be a number of kernel developers that will have
>access to this NIC and likely do development on systems containing it.
>In addition simply due to the size of the datacenters that we will be
>populating there is actually a strong likelihood that there will be
>more instances of this NIC running on Linux than there are of some
>other vendor devices that have been allowed to have drivers in the
>kernel.

So? The gain for community is still 0. No matter how many instances is
private hw you privately have. Just have a private driver.


>
>So from what I can tell the only difference is if we are manufacturing
>this for sale, or for personal use. Thus why I mention "commercial"
>since the only difference from my perspective is the fact that we are
>making it for our own use instead of selling it.

Give it for free.


>
>[...]
>
>> >> > I agree. We need a consistent set of standards. I just strongly
>> >> > believe commercial availability shouldn't be one of them.
>> >>
>> >> I never said commercial availability. I talked about open source vs
>> >> proprietary userspace. This is very standard kernel stuff.
>> >>
>> >> You have an unavailable NIC, so we know it is only ever operated with
>> >> Meta's proprietary kernel fork, supporting Meta's proprietary
>> >> userspace software. Where exactly is the open source?
>> >
>> >It depends on your definition of "unavailable". I could argue that for
>> >many most of the Mellanox NICs are also have limited availability as
>> >they aren't exactly easy to get a hold of without paying a hefty
>> >ransom.
>>
>> Sorry, but I have to say this is ridiculous argument, really Alex.
>> Apples and oranges.
>
>Really? So would you be making the same argument if it was
>Nvidia/Mellanox pushing the driver and they were exclusively making it
>just for Meta, Google, or some other big cloud provider? I suspect

Heh, what ifs :) Anyway, chance that happens is very close to 0.


>not. If nothing else they likely wouldn't disclose the plan for
>exclusive sales to get around this sort of thing. The fact is I know
>many of the vendors make proprietary spins of their firmware and
>hardware for specific customers. The way I see it this patchset is
>being rejected as I was too honest about the general plan and use case
>for it.
>
>This is what I am getting at. It just seems like we are playing games
>with semantics where if it is a vendor making the arrangement then it
>is okay for them to make hardware that is inaccessible to most, but if
>it is Meta then somehow it isn't.

