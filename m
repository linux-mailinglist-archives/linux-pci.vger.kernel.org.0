Return-Path: <linux-pci+bounces-5943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3807189DD11
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 16:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5C31F23FBA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 14:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A484312FF99;
	Tue,  9 Apr 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BW0d5GQ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9224D85652
	for <linux-pci@vger.kernel.org>; Tue,  9 Apr 2024 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673676; cv=none; b=jBopwECNWGogah/KtciMXa7JeApumpIoFrMrJkxOMZDMGGLx3vxnjM49vEcI70aDWVji9vi0+aia/abmGnPosCiFRzrzI7teC7Uw4EtxxbEA1+A3CxKNrbLvKEiwL1VbVUvnro+JcJGF+xjKo0PGpXN1JiaXI3kNIbhXYV6mVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673676; c=relaxed/simple;
	bh=crZHliPSczw38fmT73x6jx2VXnB+ZuL4FAMKSW97us4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXamHNwVyChv9bc8uOf2Ytx6RqIz64CMSwdLBqBWwpE6YS+wCTNL0HAryZgw5tUiAjvtCsbd89bOyRlb1TpzITwYOUoE3jhm2R8kIC1E52lcwHSRtLqmxQ8lMHNR669WKLEmVXn8qV5+pFb428AY5Bz3u+nF6U5L6dGZC8eRee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BW0d5GQ+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e136cbcecso7950475a12.3
        for <linux-pci@vger.kernel.org>; Tue, 09 Apr 2024 07:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712673673; x=1713278473; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3YM0svOKwvw0vj20M9m4hQD/WKGUTfYpCfTIb0VEe5Y=;
        b=BW0d5GQ+cU+MHypDX38aEB1KvT3DIEHGUjnTWt7aZ/E2LH/74iVHO9mCippxcz2kIg
         FjD6o/0JF6Z4V0VoqcTvRLnAiTDe1EIcWDGKclRPGweelma3BZZqSs44ELZrPzBGWOGO
         /SaRdnR0FAqqZjwOMhWDobWzN++7uD0jEk2uiEZ7JZSVapOKuI6SFZMoegHBNqnAX7J+
         CjXrdE2aivd8fb3ttmWRz8ku3/CRoU9Iba1ZG57ZcECoC+MKCps8GbpbldCakuymIBuD
         ij0HowEEIORpDxkIQYB6DSsfZZwcnsSD6YUGbzNyn1Z9eD7NLQ1uBsCvOJTIrH6+b4RA
         l2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712673673; x=1713278473;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YM0svOKwvw0vj20M9m4hQD/WKGUTfYpCfTIb0VEe5Y=;
        b=QPzaaooaeSsFrtFQfA6y65hFtYH5BJaOkNNk64jmD7tuFJtXk8LFGlBoTQWpyLtdUD
         X4fHggOzxeBJLggU3NivUb0YqAqgd65lpsv/6ec3a7Rhq4P1YI68qn3+IFVWi6nZprwj
         AnyQqzNsj9P+4jimtu/2JSQb3xffMFNSbjedUkcb9upfrtLYkCcnpB9lUfRLl4dye748
         RJGAdtPSDDRkQZ6ma4ym92lmubh1r53Ch+G21s96dEqjt5lZpFliagPZ2TFfEtnqnb2z
         IWA+Br23SlHBGhtqz/E+1aSpWPLzw1wwtj3TV6nWF3y17Aboq/6mS6y0uaEQCiYMGOVn
         i8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUphRaS3jXGAnuS6E9jipINhfCTTZVi83v3HFFkZqNeISTQM0Pkhw+zIrRCbG5SnoVl5WAb6ohJx6gAGRHiQexEXLnTG3/nQDpy
X-Gm-Message-State: AOJu0YxqvvLPirH6k1GJOHr0Lr7HcJ5cjX5/+N748c+WR9ytkAlm3t0u
	w0GmjnMq2Opr9OpLjbQ3+qhPcC2XJzAWB0EflPnIsmhG1f6+UVEVZp6bypTS070=
X-Google-Smtp-Source: AGHT+IE8BN7L+U9byp33eLZHsIGbXcOcBnUDnv+w8oAvonuY0OxyonFU4AewVbRCx1e8iaeM4hOIoQ==
X-Received: by 2002:a50:c358:0:b0:56e:6d9:7bd6 with SMTP id q24-20020a50c358000000b0056e06d97bd6mr11113651edb.34.1712673672424;
        Tue, 09 Apr 2024 07:41:12 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id bc23-20020a056402205700b0056e064a6d2dsm5321689edb.2.2024.04.09.07.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 07:41:11 -0700 (PDT)
Date: Tue, 9 Apr 2024 16:41:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhVThhwFSV0HgQ0B@nanopsycho>
References: <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <ZhPaIjlGKe4qcfh_@nanopsycho>
 <CAKgT0UfcK8cr8UPUBmqSCxyLDpEZ60tf1YwTAxoMVFyR1wwdsQ@mail.gmail.com>
 <ZhQgmrH-QGu6HP-k@nanopsycho>
 <66142a4b402d5_2cb7208ec@john.notmuch>
 <ZhUgH9_beWrKbwwg@nanopsycho>
 <9dd78c52-868e-4955-aba2-36bbaf3e0d88@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dd78c52-868e-4955-aba2-36bbaf3e0d88@intel.com>

Tue, Apr 09, 2024 at 03:11:21PM CEST, aleksander.lobakin@intel.com wrote:
>From: Jiri Pirko <jiri@resnulli.us>
>Date: Tue, 9 Apr 2024 13:01:51 +0200
>
>> Mon, Apr 08, 2024 at 07:32:59PM CEST, john.fastabend@gmail.com wrote:
>>> Jiri Pirko wrote:
>>>> Mon, Apr 08, 2024 at 05:46:35PM CEST, alexander.duyck@gmail.com wrote:
>>>>> On Mon, Apr 8, 2024 at 4:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>>>>>
>>>>>> Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrote:
>>>>>>> On Fri, Apr 5, 2024 at 8:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>>>>>>
>>>>>>>> On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
>>>>>>>>>> Alex already indicated new features are coming, changes to the core
>>>>>>>>>> code will be proposed. How should those be evaluated? Hypothetically
>>>>>>>>>> should fbnic be allowed to be the first implementation of something
>>>>>>>>>> invasive like Mina's DMABUF work? Google published an open userspace
>>>>>>>>>> for NCCL that people can (in theory at least) actually run. Meta would
>>>>>>>>>> not be able to do that. I would say that clearly crosses the line and
>>>>>>>>>> should not be accepted.
>>>>>>>>>
>>>>>>>>> Why not? Just because we are not commercially selling it doesn't mean
>>>>>>>>> we couldn't look at other solutions such as QEMU. If we were to
>>>>>>>>> provide a github repo with an emulation of the NIC would that be
>>>>>>>>> enough to satisfy the "commercial" requirement?
>>>>>>>>
>>>>>>>> My test is not "commercial", it is enabling open source ecosystem vs
>>>>>>>> benefiting only proprietary software.
>>>>>>>
>>>>>>> Sorry, that was where this started where Jiri was stating that we had
>>>>>>> to be selling this.
>>>>>>
>>>>>> For the record, I never wrote that. Not sure why you repeat this over
>>>>>> this thread.
>>>>>
>>>>> Because you seem to be implying that the Meta NIC driver shouldn't be
>>>>> included simply since it isn't going to be available outside of Meta.
>
>BTW idpf is also not something you can go and buy in a store, but it's
>here in the kernel. Anyway, see below.

IDK, why so many people in this thread are so focused on "buying" nic.
IDPF device is something I assume one may see on a VM hosted in some
cloud, isn't it? If yes, it is completely legit to have it in. Do I miss
something?


>
>>>>> The fact is Meta employs a number of kernel developers and as a result
>>>>> of that there will be a number of kernel developers that will have
>>>>> access to this NIC and likely do development on systems containing it.
>
>[...]
>
>>> Vendors would happily spin up a NIC if a DC with scale like this
>>> would pay for it. They just don't advertise it in patch 0/X,
>>> "adding device for cloud provider foo".
>>>
>>> There is no difference here. We gain developers, we gain insights,
>>> learnings and Linux and OSS drivers are running on another big
>>> DC. They improve things and find bugs they upstream them its a win.
>>>
>>> The opposite is also true if we exclude a driver/NIC HW that is
>>> running on major DCs we lose a lot of insight, experience, value.
>> 
>> Could you please describe in details and examples what exactly is we
>> are about to loose? I don't see it.
>
>As long as driver A introduces new features / improvements / API /
>whatever to the core kernel, we benefit from this no matter whether I'm
>actually able to run this driver on my system.
>
>Some drivers even give us benefit by that they are of good quality (I
>don't speak for this driver, just some hypothetical) and/or have
>interesting design / code / API / etc. choices. The drivers I work on
>did gain a lot just from that I was reading new commits / lore threads
>and look at changes in other drivers.
>
>I saw enough situations when driver A started using/doing something the
>way it wasn't ever done anywhere before, and then more and more drivers
>stated doing the same thing and at the end it became sorta standard.

So bottom line is, the unused driver *may* introduce some features and
*may* provide as an example of how to do things for other people.
Is this really that beneficial for the community that it overweights
the obvious cons (not going to repeat them)?

Like with any other patch/set we merge in, we always look at the cons
and pros. I'm honestly surprised that so many people here
want to make exception for Meta's internal toy project.


>
>I didn't read this patchset and thus can't say if it will bring us good
>immediately or some time later, but I believe there's no reason to
>reject the driver only because you can't buy a board for it in your
>gadget store next door.

Again with "buying", uff.


>
>[...]
>
>Thanks,
>Olek

