Return-Path: <linux-pci+bounces-5930-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6368789D9C4
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 15:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9638B258AE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 13:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95B512DDAC;
	Tue,  9 Apr 2024 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4XU849l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C0129E7A;
	Tue,  9 Apr 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667954; cv=none; b=dfqScjOioRIDwkdmso2Bo+nTKYZHALRJRGqqhV/3HhOM2ScdVQpse14FsjebFDgUwzxQU6IBtpAdU/JVfDAomMqkGw835pSjzCqT6Q0NMwXv9oOV1ZYTPWmHQqHE7hD6Uvrz3M3NLBWng7FatalmiZKzYtmeclQ9my1tCp6E9Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667954; c=relaxed/simple;
	bh=FO+ORzJiSilGxUMRAWWqR0U48P+F3I6inohuLoPPM4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXwTX1nfr5gnpCfj6g11mKwL0hy1Ojgjs8lZMpR1h+DsjvEFiZbwUNju4+L8s3CkKbJ8gT6bUCwfuXsQt4h9Oi80wCyqpcrwLIiIeKp+zsAJmHredVacesPhqN4Crw+xhKde2mM1VGkwewo+l0WGOcpb4hsftioafC8Hn42BcaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4XU849l; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so2531887a91.3;
        Tue, 09 Apr 2024 06:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712667952; x=1713272752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hLrJ6jord7ioD87xPU4dXsplwp31JxzrQ+IqsL0p+OI=;
        b=K4XU849lQE4KvYa9pxr2Ml0+cUvrETuW4O7QvIV0KwkVAVojkvLiuL6YDeeCe2dltl
         xCoHb1u6Z1TE+w7OH1yXqN6PUXjdppMcsyyupQsl5N2YPlG3rXNyUV3BaL0/LgxCTFDm
         e0F6F3uWNApm0EbTx411zOxrU4Xs5Tny+tEeN/mwgkREs3H4UkomgsqQI5679KPoZlQj
         WEv3tNrDSNf+pkT0RE/Cgb8tTp6cmQC99Gudg1+creGiq1aOdW/aA6ILQ84pq8fPRSHS
         V4PUxCsXFbyQCjIppvpgfhDbSDJ7/BujCtzqCErmUsQdbekU/X6BiSShACcKL1gHFS4h
         KJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712667952; x=1713272752;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLrJ6jord7ioD87xPU4dXsplwp31JxzrQ+IqsL0p+OI=;
        b=sVXjoYojTX5TIKzks+GpLhPIlhaOwK2lixQUDAstn5R4qbRppS1iQRhiGWHlI1jjda
         BXRmeHECpQsGR5k2vYnG7sYHDMpq9JH+zffLhGHcUVFu+e31o3ziEFAv9By7iaOAThD/
         BChqVlQZfCPnGJEFrmL1u5EYcqAB9WqGhRIF3NvwdNethJD1sS22plV6ynvpGyanxOyI
         A27kfPbYc7wyYy4Fuu79eAiGUZ6jkyDd0Wd2WSCAB6Y8ZXcidSlrfpdNmm5s6i4JUkA5
         F1i4QG1iTkW8dn+xSvK1pZlfAmhjfvuyeIkb54Juba7ZoxD5fSAX7YBoWgS3cb0H8xJj
         Snuw==
X-Forwarded-Encrypted: i=1; AJvYcCVkqyutKOUXDrzJ3QkOw40eVlM5lCoaSBHnhaIyEgq6fnAVAnGRLaLHo+m0LGB4CThsMtcFx94Y6ZR59CVllGyPZz2h0aTG/g4ZjipEAERiRg+lLdg/5mT3eTnz+lxTNFq9
X-Gm-Message-State: AOJu0Yyh5iiNZd91j8YH6Y3Bv4ekZiVCkgY6qEyOXMZ62o9IXT0zCgtj
	lEG7EjyjLuEiXPLkeE6Q+UzNA9NwABOXqWtdQrE5ScJw/sFdRBRl
X-Google-Smtp-Source: AGHT+IGb2ne58Q5GkN6x7rPFJmdH/2KIXLfi/cS25KQKdoFx7yN48zpMpjUp1cdPUm5hmiqVcAkpHQ==
X-Received: by 2002:a17:90b:617:b0:2a2:c6fa:233 with SMTP id gb23-20020a17090b061700b002a2c6fa0233mr11297664pjb.31.1712667952337;
        Tue, 09 Apr 2024 06:05:52 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p22-20020a17090a0e5600b002a584b59ca4sm946400pja.43.2024.04.09.06.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 06:05:51 -0700 (PDT)
Message-ID: <49d7e1ba-0d07-43d2-a5e7-81f142152f8a@gmail.com>
Date: Tue, 9 Apr 2024 06:05:47 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jiri Pirko <jiri@resnulli.us>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
 Christoph Hellwig <hch@lst.de>
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
 <ZhUexUl-kD6F1huf@nanopsycho>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <ZhUexUl-kD6F1huf@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/9/2024 3:56 AM, Jiri Pirko wrote:
> Mon, Apr 08, 2024 at 11:36:42PM CEST, f.fainelli@gmail.com wrote:
>> On 4/8/24 09:51, Jiri Pirko wrote:
>>> Mon, Apr 08, 2024 at 05:46:35PM CEST, alexander.duyck@gmail.com wrote:
>>>> On Mon, Apr 8, 2024 at 4:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>
>>>>> Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrote:
>>>>>> On Fri, Apr 5, 2024 at 8:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>>>>>
>>>>>>> On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
>>>>>>>>> Alex already indicated new features are coming, changes to the core
>>>>>>>>> code will be proposed. How should those be evaluated? Hypothetically
>>>>>>>>> should fbnic be allowed to be the first implementation of something
>>>>>>>>> invasive like Mina's DMABUF work? Google published an open userspace
>>>>>>>>> for NCCL that people can (in theory at least) actually run. Meta would
>>>>>>>>> not be able to do that. I would say that clearly crosses the line and
>>>>>>>>> should not be accepted.
>>>>>>>>
>>>>>>>> Why not? Just because we are not commercially selling it doesn't mean
>>>>>>>> we couldn't look at other solutions such as QEMU. If we were to
>>>>>>>> provide a github repo with an emulation of the NIC would that be
>>>>>>>> enough to satisfy the "commercial" requirement?
>>>>>>>
>>>>>>> My test is not "commercial", it is enabling open source ecosystem vs
>>>>>>> benefiting only proprietary software.
>>>>>>
>>>>>> Sorry, that was where this started where Jiri was stating that we had
>>>>>> to be selling this.
>>>>>
>>>>> For the record, I never wrote that. Not sure why you repeat this over
>>>>> this thread.
>>>>
>>>> Because you seem to be implying that the Meta NIC driver shouldn't be
>>>> included simply since it isn't going to be available outside of Meta.
>>>> The fact is Meta employs a number of kernel developers and as a result
>>>> of that there will be a number of kernel developers that will have
>>>> access to this NIC and likely do development on systems containing it.
>>>> In addition simply due to the size of the datacenters that we will be
>>>> populating there is actually a strong likelihood that there will be
>>>> more instances of this NIC running on Linux than there are of some
>>>> other vendor devices that have been allowed to have drivers in the
>>>> kernel.
>>>
>>> So? The gain for community is still 0. No matter how many instances is
>>> private hw you privately have. Just have a private driver.
>>
>> I am amazed and not in a good way at how far this has gone, truly.
>>
>> This really is akin to saying that any non-zero driver count to maintain is a
>> burden on the community. Which is true, by definition, but if the goal was to
>> build something for no users, then clearly this is the wrong place to be in,
>> or too late. The systems with no users are the best to maintain, that is for
>> sure.
>>
>> If the practical concern is wen you make tree wide API change that fbnic
>> happens to use, and you have yet another driver (fbnic) to convert, so what?
>> Work with Alex ahead of time, get his driver to be modified, post the patch
>> series. Even if Alex happens to move on and stop being responsible and there
>> is no maintainer, so what? Give the driver a depreciation window for someone
>> to step in, rip it, end of story. Nothing new, so what has specifically
>> changed as of April 4th 2024 to oppose such strong rejection?
> 
> How you describe the flow of internal API change is totally distant from
> reality. Really, like no part is correct:
> 1) API change is responsibility of the person doing it. Imagine working
>     with 40 driver maintainers for every API change. I did my share of
>     API changes in the past, maintainer were only involved to be cced.

As a submitter you propose changes and silence is acknowledgement. If 
one of your API changes broke someone's driver and they did not notify 
you of the breakage during the review cycle, it falls on their shoulder 
to fix it for themselves and they should not be holding back your work, 
that would not be fair. If you know about the breakage, and there is 
still no fix, that is an indication the driver is not actively used and 
maintained.

This also does not mean you have to do the entire API changes to a 
driver you do not know about on your own. Nothing ever prevents you from 
posting the patches as RFC and say: "here is how I would go about 
changing your driver, please review and help me make corrections". If 
the driver maintainers do not respond there is no reason their lack of 
involvement should refrain your work, and so your proposed changes will 
be merged eventually.

Is not this the whole point of being a community and be able to delegate 
and mitigate the risk of large scale changes?

> 2) To deprecate driver because the maintainer is not responsible. Can
>     you please show me one example when that happened in the past?

I cannot show you an example because we never had to go that far and I 
did not say that this is an established practice, but that we *could* do 
that if we ever reached that point.

> 
> 
>>
>> Like it was said, there are tons of drivers in the Linux kernel that have a
>> single user, this one might have a few more than a single one, that should be
>> good enough.
> 
> This will have exactly 0. That is my point. Why to merge something
> nobody will ever use?

Even if Alex and his firmware colleague end up being the only two people 
using this driver if the decision is to make it upstream because this is 
the desired distribution and development model of the driver we should 
respect that.

And just to be clear, we should not be respecting that because Meta, or 
Alex or anyone decided that they were doing the world a favor by working 
in the open rather than being closed door, but simply because we cannot 
*presume* about their intentions and the future.

For drivers specifically, yes, there is a question of to which degree 
can we scale horizontally, and I do not think there is ever going to be 
an answer to that, as we will continue to see new drivers emerge, 
possibly with few users, for some definition of few.
-- 
Florian

