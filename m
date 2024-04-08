Return-Path: <linux-pci+bounces-5883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D8C89BE6A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 13:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8851C21BFF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E79B6A010;
	Mon,  8 Apr 2024 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="H0E/8Zh/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C60869E07
	for <linux-pci@vger.kernel.org>; Mon,  8 Apr 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577066; cv=none; b=NqfDw9J93KtnHy5YE0sBK+75txvnh9THuQ5VRtF2zfvSUdTsbNmqDGcn9u5aa7BLYxM20tSN0S3Bzvmq1wctEjcnaSW0q4GFvB0UQCqb61qv+XeKFx3dAegNtiq2k8oKm55VQ3R5g43caxTimMC57G6FgKl9qFLXs3xGANMqG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577066; c=relaxed/simple;
	bh=sg5Rs7iszd8hBUy/u/ziG0UuMLFssCmsp0ETgqg7BC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J91Ylpm3Bw0XQnj5finXFdsbAOgqtZjOVKNf4BT4K5A5oej4xpc1Tm5n6AoF+Bmwm5TPef1XQC8fF5zU2s+4wp/DVdigVWubMtz8rVISv3XgTfMudjKXxUaQJDw/s2M7rOCWkNPr1R/Bg8/tljTrcBo+g0hc78fLUPrM2BdVsAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=H0E/8Zh/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ddd1624beso2465183f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2024 04:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712577063; x=1713181863; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sg5Rs7iszd8hBUy/u/ziG0UuMLFssCmsp0ETgqg7BC4=;
        b=H0E/8Zh/faKiEVO1wE5GjPnvrcaTrw/9CjTwFdkBu4llHmi6FjHXvjaw97WOnbUr37
         RjeGJ3bxT4MetfOuc/m2pj4OJJMit60vJMhso7xFkIA57uDwvUBQs5MpisLdEk4uUncR
         VrHzo3tgaJDL2XZL+sZlgEv5CazVbWthTk5mJnIu3gZkmsZ2nFH6K+N8VBB+0jBrL2wY
         vdnME9Rj+OpRLtbW492pnPbPuF1HSsTFOtD0M/2zYBTvQPvFRZTzS++8ZAvhBHfCBdiL
         a3kOvSRb6hFHHqjs7xDhU32NDn5EdTJdR6NEVoxLAgFm4VDH0fzSCLV4rgcE4CnUYQMj
         e3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712577063; x=1713181863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sg5Rs7iszd8hBUy/u/ziG0UuMLFssCmsp0ETgqg7BC4=;
        b=JiKP9Gl/K6e9Jsi5WvE5q8ym31JHuW5JRhVCeQM7Ly8jK/ofH62GFfK3RTyfPqPrcH
         Fd38ND7i+eQu1visw/BJpUcyF5LtfwHtcmHsxLWI6p+lWZ0yWylU21MUHAiT0vcdhZY7
         hqIZ7IjeFXlwxkLqdhHa9l+XeyxY6qr2N66W+uXyw/PR0aPQFMj1vIQ5rRR08TquE+mb
         R+7JG16MUCSfNFxuid0/O6UdNWa6Xw5+6mtOFNtv40uaHFsLjuTR0ky7f6jNAhk2i1kx
         qnzINxCL1vsqfjhqIBZg+xj18Eyhc6TPs8GNUr6KZykhm4GK6oPIeohpATC/AQ4ggjdd
         Abug==
X-Forwarded-Encrypted: i=1; AJvYcCUKD3OpOVFq2mHc/X4F7IZo3TfgsXosnjYQklLdt4rBVRqou3icbWVxxyQSTvfUuqoYKNmxFBW0sKslgDjCeeKfzIxhTq8QPWj7
X-Gm-Message-State: AOJu0YzfH8I/+oak1CAB0Qmtmf6X24CBuCKErUNJKIMqjSPcgjHbchn/
	/jGvoIzQLO93Ik6zCPLOyZsEE0qY0UEi51zsqTMtb3HRoFJufsEY/47zgaF5qUY=
X-Google-Smtp-Source: AGHT+IFcGblPGcLiJnMPWn9XY2z75gypjkApCZH9jf/Dge/EeoXW5IcbcB36Z4EyIl4J5qLF+nC1cw==
X-Received: by 2002:a5d:4525:0:b0:343:b748:9af2 with SMTP id j5-20020a5d4525000000b00343b7489af2mr8017139wra.19.1712577062905;
        Mon, 08 Apr 2024 04:51:02 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id j15-20020a5d452f000000b00343e825d679sm8358205wra.87.2024.04.08.04.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 04:51:02 -0700 (PDT)
Date: Mon, 8 Apr 2024 13:50:58 +0200
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
Message-ID: <ZhPaIjlGKe4qcfh_@nanopsycho>
References: <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
 <20240404132548.3229f6c8@kernel.org>
 <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>

Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrote:
>On Fri, Apr 5, 2024 at 8:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>
>> On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
>> > > Alex already indicated new features are coming, changes to the core
>> > > code will be proposed. How should those be evaluated? Hypothetically
>> > > should fbnic be allowed to be the first implementation of something
>> > > invasive like Mina's DMABUF work? Google published an open userspace
>> > > for NCCL that people can (in theory at least) actually run. Meta would
>> > > not be able to do that. I would say that clearly crosses the line and
>> > > should not be accepted.
>> >
>> > Why not? Just because we are not commercially selling it doesn't mean
>> > we couldn't look at other solutions such as QEMU. If we were to
>> > provide a github repo with an emulation of the NIC would that be
>> > enough to satisfy the "commercial" requirement?
>>
>> My test is not "commercial", it is enabling open source ecosystem vs
>> benefiting only proprietary software.
>
>Sorry, that was where this started where Jiri was stating that we had
>to be selling this.

For the record, I never wrote that. Not sure why you repeat this over
this thread.

And for the record, I don't share Jason's concern about proprietary
userspace. From what I see, whoever is consuming the KAPI is free to do
that however he pleases.

But, this is completely distant from my concerns about this driver.


[...]


>> > I agree. We need a consistent set of standards. I just strongly
>> > believe commercial availability shouldn't be one of them.
>>
>> I never said commercial availability. I talked about open source vs
>> proprietary userspace. This is very standard kernel stuff.
>>
>> You have an unavailable NIC, so we know it is only ever operated with
>> Meta's proprietary kernel fork, supporting Meta's proprietary
>> userspace software. Where exactly is the open source?
>
>It depends on your definition of "unavailable". I could argue that for
>many most of the Mellanox NICs are also have limited availability as
>they aren't exactly easy to get a hold of without paying a hefty
>ransom.

Sorry, but I have to say this is ridiculous argument, really Alex.
Apples and oranges.

[...]


