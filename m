Return-Path: <linux-pci+bounces-5906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B0589CDAE
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 23:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8875E1C2196E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 21:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CB41487E0;
	Mon,  8 Apr 2024 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhhNxxi0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF3E1442F3;
	Mon,  8 Apr 2024 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612212; cv=none; b=XwZ9EeLAXpRdrnG1KpktziJDYd+Y39d/6oLcZn85/1Ns28TicfHgd+mnfAUdkyFMzc1faeH/jmaPDSzukfzsU5aLih0sJ2HCBN5w/jph4QiKW3qapVe9TRhCx378e2gNu4GZsiyPBWKFtBOeLdTb21fc1pCB1tEfNkUAKz7SOO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612212; c=relaxed/simple;
	bh=+fk1YFrgP1RijMlaqGbsWmb4JPRxZeRgA50F2z9IF9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJLr1cq00H75LvsBYJLbx2ydmZQhfNR+X2eOCEGu3aanpwzmOtYvZqLSq6Dk0d4cHFCVilI8UHumXFu2Br3ci+4sp4ggh2P2P1VBUByTkLP8ML2lsFXjOgjEpPPheTqe3doe5FFcLXJbBvgcUUInBeQYxd4DZrStmEEN+EPItro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhhNxxi0; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78d575054c8so139280585a.3;
        Mon, 08 Apr 2024 14:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712612209; x=1713217009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0a7cIgoqwCVBrfTgB2VfnvqDS5iR7DqyhxTtY9g5hWY=;
        b=XhhNxxi0iD4wxzojA3Qvs1QKD79kvEoJns10bdOmQIkID5FXmWPhlF4Ojeq382hw/G
         6dji7MGIbQaRJ5/CtURXyc/B1vRndfJ/fz8a/Kwi/ehuQ5OQzxtBm9kdlgELNvLcvcPP
         ky3/FFZV4btjl2idlM2hEdDTgyHgd5+swWtnaXmQM/Sg7vPSBiyJ3iK/fcymgaQywpyI
         tA255PJq+F9QG/4KfUYantuU8WmznEaFk5J5NyCx49WjNmvBaTpDaML9cyQm8yMWGJ2u
         lJhdHesqIgcOXQTjiCpQbiAaOg2vQmzl0SGGhhF4YWXEjn3H94RLWuwHXkpgsxrSo8BX
         yWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612209; x=1713217009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0a7cIgoqwCVBrfTgB2VfnvqDS5iR7DqyhxTtY9g5hWY=;
        b=mjo9sl70b+HETi9rlVkT0xUXTIELD7dmU6gkgPB85FUo2dILQm8+v3GS4iGREdlNzC
         p8Gq+5hnT80XzztKLXyhXB+biiKKoIcc0CIuacle/iRHTPqKdlbF1Ebag/rIonyElKB8
         oOeFlZGLwkhOogNqutSiy74Y5/aDrZtCMVOHoQip4Z/gBFvm/uzhDxis828CxJNleTPV
         gOS+L6LyD9090p3UoxlIOo0tZSMM8t538nDQh9SAPGfi9t2kNwFgNq1i+JIudacuvOS0
         Vqwc3YdSDMfhNsZq9EKgzYJranWDit9o/i1A1BQvRB2t9dBI+2jxMQW7HpRpByPLSQ5F
         zBRA==
X-Forwarded-Encrypted: i=1; AJvYcCU+kEEj1hGO5YQ/jzsOF33t4Z6SKmqa+kVsPNExIk/8na16RfZXNcdVEX04ib+fYfep+TwhUzTc6cz9gEAK3IhBjN4HC+jjDNWm485MGaAlK594V804Jp2rUoPNpcnH6npY
X-Gm-Message-State: AOJu0YwL9XcJ3nJ3vinH6yARNctHKllp/RrkXpBZ5J9EP3zXcW2uIidP
	KsLJX+tVQYNjxsAXkXyA9wYJFz71AJgxIzXAis4htTKyvZCj39Gr
X-Google-Smtp-Source: AGHT+IEBMCCFVf+5E9G2JwsWX6Wih3gNqk9OyU2aGFjVg2hyj+32gzvxHI7zZq8fb7ORDJBjkULS5A==
X-Received: by 2002:a05:620a:3b89:b0:78d:5079:7c3f with SMTP id ye9-20020a05620a3b8900b0078d50797c3fmr8058507qkn.75.1712612209140;
        Mon, 08 Apr 2024 14:36:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d7-20020a05620a158700b0078d5f7b9a2dsm2160980qkk.15.2024.04.08.14.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 14:36:48 -0700 (PDT)
Message-ID: <ae67d1a6-8ca6-432e-8f1d-2e3e45cad848@gmail.com>
Date: Mon, 8 Apr 2024 14:36:42 -0700
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
To: Jiri Pirko <jiri@resnulli.us>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
 Christoph Hellwig <hch@lst.de>
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
 <ZhQgmrH-QGu6HP-k@nanopsycho>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ZhQgmrH-QGu6HP-k@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/24 09:51, Jiri Pirko wrote:
> Mon, Apr 08, 2024 at 05:46:35PM CEST, alexander.duyck@gmail.com wrote:
>> On Mon, Apr 8, 2024 at 4:51 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>>
>>> Fri, Apr 05, 2024 at 08:38:25PM CEST, alexander.duyck@gmail.com wrote:
>>>> On Fri, Apr 5, 2024 at 8:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>>>>>
>>>>> On Fri, Apr 05, 2024 at 07:24:32AM -0700, Alexander Duyck wrote:
>>>>>>> Alex already indicated new features are coming, changes to the core
>>>>>>> code will be proposed. How should those be evaluated? Hypothetically
>>>>>>> should fbnic be allowed to be the first implementation of something
>>>>>>> invasive like Mina's DMABUF work? Google published an open userspace
>>>>>>> for NCCL that people can (in theory at least) actually run. Meta would
>>>>>>> not be able to do that. I would say that clearly crosses the line and
>>>>>>> should not be accepted.
>>>>>>
>>>>>> Why not? Just because we are not commercially selling it doesn't mean
>>>>>> we couldn't look at other solutions such as QEMU. If we were to
>>>>>> provide a github repo with an emulation of the NIC would that be
>>>>>> enough to satisfy the "commercial" requirement?
>>>>>
>>>>> My test is not "commercial", it is enabling open source ecosystem vs
>>>>> benefiting only proprietary software.
>>>>
>>>> Sorry, that was where this started where Jiri was stating that we had
>>>> to be selling this.
>>>
>>> For the record, I never wrote that. Not sure why you repeat this over
>>> this thread.
>>
>> Because you seem to be implying that the Meta NIC driver shouldn't be
>> included simply since it isn't going to be available outside of Meta.
>> The fact is Meta employs a number of kernel developers and as a result
>> of that there will be a number of kernel developers that will have
>> access to this NIC and likely do development on systems containing it.
>> In addition simply due to the size of the datacenters that we will be
>> populating there is actually a strong likelihood that there will be
>> more instances of this NIC running on Linux than there are of some
>> other vendor devices that have been allowed to have drivers in the
>> kernel.
> 
> So? The gain for community is still 0. No matter how many instances is
> private hw you privately have. Just have a private driver.

I am amazed and not in a good way at how far this has gone, truly.

This really is akin to saying that any non-zero driver count to maintain 
is a burden on the community. Which is true, by definition, but if the 
goal was to build something for no users, then clearly this is the wrong 
place to be in, or too late. The systems with no users are the best to 
maintain, that is for sure.

If the practical concern is wen you make tree wide API change that fbnic 
happens to use, and you have yet another driver (fbnic) to convert, so 
what? Work with Alex ahead of time, get his driver to be modified, post 
the patch series. Even if Alex happens to move on and stop being 
responsible and there is no maintainer, so what? Give the driver a 
depreciation window for someone to step in, rip it, end of story. 
Nothing new, so what has specifically changed as of April 4th 2024 to 
oppose such strong rejection?

Like it was said, there are tons of drivers in the Linux kernel that 
have a single user, this one might have a few more than a single one, 
that should be good enough.

What the heck is going on?
-- 
Florian


