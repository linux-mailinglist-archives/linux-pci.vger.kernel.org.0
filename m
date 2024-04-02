Return-Path: <linux-pci+bounces-5570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BFF895C36
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 21:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9951C236C9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 19:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C93C15B545;
	Tue,  2 Apr 2024 19:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne0XXEkS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FE415B57F
	for <linux-pci@vger.kernel.org>; Tue,  2 Apr 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712084786; cv=none; b=Aj/BlDLtQequkFOBXkInpCHarzWSlPsUB/BCQdzGyeIfDAr+2KjURy1CjULP9SvGpRoLopPuXHhQtw0EhqA4/duBYIYBo6qKw1wq/BzVLqoP9FojvlDjf+ektOBuwGqBGU3TKN2TJPgRYfmfORHSeiHu3TweKIftp+WjCYscdvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712084786; c=relaxed/simple;
	bh=K66RHGeuP77VfIZBGsB9pS3JJ8V9EP9EZMeIGcX0yfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjVqDaF7SQoYOuPLNswgertgIgjCuqRoSyj9lQ3Ei95pXCurHmVjYUpukILlWmqabSfRQQHOLeZ6ogmo7+T6kA3Kwmv1XG/Xf/Qn2GsI1zb9pIn5h6aqmW5EAK0BixsRi1wDKMBTWZ1dSfSYxXKR/AwpBdSXhX5wVsX5KcqXS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ne0XXEkS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56df8e6a376so382965a12.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Apr 2024 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712084782; x=1712689582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xmaIaiCBJidCnGkPJTLuYVmDgb6jx3E1KqegOtb/ofw=;
        b=ne0XXEkS9TdnUXMVBW/ToUlAaONntljdE+IAoULG0fpiagxkJ/2nKndMH4YvZxObue
         uqmczVZz75yVh6gmxTzJ8Ues+iaSV7/ZIXIcniprzN7pH0y+1hDnVEOAbuEA436MCoNy
         IY0X4et2wWlqdMqYbJ27BZQ0/ozQw+xD/BOHNeZdaS4jUQ3rAt9AxOeGiTuoDuTMVcDC
         MN3WKdfpiO91NOmaYuwwV1oodGDaMGj4BsXqpJmry8Kk2htGXTFmJsdbBZMJuLSvXqdx
         QYkvoXmncMulGbtVcBEDE46p9JcGELbl85Kj8IXL/5wA1goeCmiH2Xaee6G3x9PqZ5gY
         2RMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712084782; x=1712689582;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmaIaiCBJidCnGkPJTLuYVmDgb6jx3E1KqegOtb/ofw=;
        b=BFyrSIk+vBzPbQlKDjFXZ/5cw4hNIseoRyQUgMxY9+LWrXQkJiuv3hf/BcmYsG5Xlb
         IK83kvOGBR7NfMk3/3kcij538dakwcULIwZFoqooqX5WbfYl4ZJvbqdbaL1Ii6CnzhXN
         SZ7zuDkzFwTtaiORAgzlpbOYzXKiycZh2mCqlwcKB/KTXwRLlb0UWmm6EVKFEcToD6Ik
         PxBcItgQxAcOmSpRUC08djHFj4bI2NgiQ1ORWzKpcTYDOO6IFKLEK9SS0Y+y3TddAqji
         5OQPGLh2gIf6WHENTqx4vlvJ72UddU8O1a7aA2epiiGcM8V2E0URCJoX0VNRweZZBDnD
         QiBA==
X-Gm-Message-State: AOJu0Yy1c5ueBaqYe8ev3cThDQmd9GIJjeI28ZGJiYA4ptjDgpidyXeL
	DFh5ycAZRS9s4PXv/kgx0FWOt3zclxh6JURHPTKarmw/LA5PqsMjfe+x0HAD
X-Google-Smtp-Source: AGHT+IHOn4/C4JNiGXT31jro1A7iBqDM/mqpZaFbxknYoylGD+EHQGUHypp4K+WFZbTPk4jzKCpvnQ==
X-Received: by 2002:a50:bb65:0:b0:56b:d013:a67e with SMTP id y92-20020a50bb65000000b0056bd013a67emr344597ede.18.1712084782071;
        Tue, 02 Apr 2024 12:06:22 -0700 (PDT)
Received: from ?IPV6:2a02:3100:94b4:ad00:3cf8:1b44:336b:8ffe? (dynamic-2a02-3100-94b4-ad00-3cf8-1b44-336b-8ffe.310.pool.telefonica.de. [2a02:3100:94b4:ad00:3cf8:1b44:336b:8ffe])
        by smtp.googlemail.com with ESMTPSA id z3-20020a50eb43000000b0056dc82d630csm3924932edp.31.2024.04.02.12.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 12:06:21 -0700 (PDT)
Message-ID: <f24da293-a996-4fe6-a216-a9f9f79df71a@gmail.com>
Date: Tue, 2 Apr 2024 21:06:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PCI: Add and use pcim_iomap_region()
To: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
 <4cf0d7710a74095a14bedc68ba73612943683db4.camel@redhat.com>
 <348fa275-3922-4ad1-944e-0b5d1dd3cff5@gmail.com>
 <7af7182d-0f14-4111-b0c4-b57d2d24edd9@gmail.com>
 <a0d0b6b1269babb6a8f4e3bcceafee87bb49dcd1.camel@redhat.com>
 <38eb4bed-f2e9-4e3e-993b-78da54bf988e@gmail.com>
 <dada4d02089cc2e60a7de04970aeb0327dec7059.camel@redhat.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <dada4d02089cc2e60a7de04970aeb0327dec7059.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02.04.2024 16:11, Philipp Stanner wrote:
> On Tue, 2024-04-02 at 15:54 +0200, Heiner Kallweit wrote:
>> On 02.04.2024 15:17, Philipp Stanner wrote:
>>> On Thu, 2024-03-28 at 23:03 +0100, Heiner Kallweit wrote:
>>>> On 28.03.2024 18:35, Heiner Kallweit wrote:
>>>>> On 27.03.2024 14:20, Philipp Stanner wrote:
>>>>>> On Wed, 2024-03-27 at 12:52 +0100, Heiner Kallweit wrote:
>>>>>>> Several drivers use the following sequence for a single
>>>>>>> BAR:
>>>>>>> rc = pcim_iomap_regions(pdev, BIT(bar), name);
>>>>>>> if (rc)
>>>>>>>         error;
>>>>>>> addr = pcim_iomap_table(pdev)[bar];
>>>>>>>
>>>>>>> Let's create a simpler (from implementation and usage
>>>>>>> perspective)
>>>>>>> pcim_iomap_region() for this use case.
>>>>>>
>>>>>> I like that idea – in fact, I liked it so much that I wrote
>>>>>> that
>>>>>> myself, although it didn't make it vor v6.9 ^^
>>>>>>
>>>>>> You can look at the code here [1]
>>>>>>
>>>>>> Since my series cleans up the PCI devres API as much as
>>>>>> possible,
>>>>>> I'd
>>>>>> argue that prefering it would be better.
>>>>>>
>>>>> Thanks for the hint. I'm not in a hurry, so yes: We should
>>>>> refactor
>>>>> the
>>>>> pcim API, and then add functionality.
>>>>>
>>>>>> But maybe you could do a review, since you're now also
>>>>>> familiar
>>>>>> with
>>>>>> the code?
>>>>>>
>>>>> I'm not subscribed to linux-pci, so I missed the cover letter,
>>>>> but
>>>>> had a
>>>>> look at the patches in patchwork. Few remarks:
>>>>>
>>>>> Instead of first adding a lot of new stuff and then cleaning
>>>>> up,
>>>>> I'd
>>>>> propose to start with some cleanups. E.g. patch 7 could come
>>>>> first,
>>>>> this would already allow to remove member mwi from struct
>>>>> pci_devres.
>>>>>
>>>> When looking at the intx members of struct pci_devres:
>>>> Why not simply store the initial state of bit
>>>> PCI_COMMAND_INTX_DISABLE
>>>> in struct pci_dev and restore this bit in
>>>> do_pci_disable_device()?
>>>> This should allow us to get rid of these members.
>>>
>>> Those members have been there before I touched anything.
>>> Patch #8 removes them entirely, so I'd say that result has been
>>> achieved.
>>>
>>
>> - all the networking people because discussion is solely about PCI
>> core now
>>
>> I think the proposed pcim_intx() is more complex than needed,
> 
> It is complex – but that complexity has been there before. It's just
> moved from pci.c to devres.c and gets coupled with devres.
> 
> Note that it's very hard to clean up the PCI devres API because it's
> ossificated and used everywhere. That's why several hybrid functions in
> pci.c get redirected to devres.c, including pci_intx().
> 
>>  and I see
>> issues if it's called multiple times.
> 
> Which issues would that be?
> 
If pcim_intx() is called more than once, then you don't know what the
initial status at driver load time was. And it's my understanding that
we do our best to restore the initial state.

> If I implemented everything correctly (please say if I didn't), then a
> driver using pcim_enable_device() + pci_intx() (without 'm') will
> experience exactly the same behavior as before.
> 
> If pcim_intx() is buggy or problematic, it only is because pci_intx()
> has always been that way.
> 
> So this would be bug-for-bug-compatible.
> pci_intx() and pcim_intx() should be removed in the long term.
> 
>> In addition you state that pci_intx()
>> is outdated, but add an API call for the same functionality.
> 
> I do that because that's the only way to kill struct pci_devres in
> pci.h.
> Take a look at the current implementation of pci_intx(). This is a
> hybrid function. We can not just remove the devres part because we'd
> break backwards compatiblity.
> 
> And, on Andy Shevchenko's request, the pcim_intx() call is not exposed
> to users. It's just visible within the subsystem, to maintain
> pci_intx()'s hybrid nature while being.
> 
> We could add a more detailed comment explaining the reasoning, if you
> think that's worthwhile.
> 
>>
>> Did you see the RFC patches I sent? they could help to reduce the
>> complexity
>> of the pcim refactoring.
> 
> Nope. Do you have a pointer?
> 
https://www.spinics.net/lists/linux-pci/msg151308.html

You were on the addressee list, so you should have the series in your
mailbox.

> 
> P.
> 
>>
>>> Besides, considering the current fragmentation of devres within the
>>> PCI
>>> subsystem, I think it's wise to do 100% of devres operations in
>>> devres.c
>>>
>>> P.
>>>
>>>>
>>>>> By the way, in patch 7 it may be a little simpler to have the
>>>>> following
>>>>> sequence:
>>>>>
>>>>> rc = pci_set_mwi()
>>>>> if (rc)
>>>>>         error
>>>>> rc = devm_add_action_or_reset(.., __pcim_clear_mwi, ..);
>>>>> if (rc)
>>>>>         error
>>>>>
>>>>> This would avoid the call to devm_remove_action().
>>>>>
>>>>> We briefly touched the point whether the proposed new function
>>>>> returns
>>>>> NULL or an ERR_PTR. I find it annoying that often the kernel
>>>>> doc
>>>>> function
>>>>> description doesn't mention whether a function returns NULL or
>>>>> an
>>>>> ERR_PTR
>>>>> in the error case. So I have to look at the function code. It's
>>>>> also a
>>>>> typical bug source.
>>>>> We won't solve this in general here. But I think we should be
>>>>> in
>>>>> line
>>>>> with what related functions do.
>>>>> The iomap() functions typically return NULL in the error case.
>>>>> Therefore
>>>>> I'd say any new pcim_...iomap...() function should return NULL
>>>>> too.
>>>>>
>>>>> Then you add support for mapping BAR's partially. I never had
>>>>> such
>>>>> a use
>>>>> case. Are there use cases for this?
>>>>> Maybe we could omit this for now, if it helps to reduce the
>>>>> complexity
>>>>> of the refactoring.
>>>>>
>>>>> I also have bisectability in mind, therefore my personal
>>>>> preference
>>>>> would
>>>>> be to make the single patches as small as possible. Not sure
>>>>> whether there's
>>>>> a way to reduce the size of what currently is the first patch
>>>>> of
>>>>> the series.
>>>>>
>>>>>> Greetings,
>>>>>> P.
>>>>>>
>>>>>> [1]
>>>>>> https://lore.kernel.org/all/20240301112959.21947-1-pstanner@redhat.com/
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Note: The check for !pci_resource_len() is included in
>>>>>>> pcim_iomap(), so we don't have to duplicate it.
>>>>>>>
>>>>>>> Make r8169 the first user of the new function.
>>>>>>>
>>>>>>> I'd prefer to handle this via the PCI tree.
>>>>>>>
>>>>>>> Heiner Kallweit (2):
>>>>>>>   PCI: Add pcim_iomap_region
>>>>>>>   r8169: use new function pcim_iomap_region()
>>>>>>>
>>>>>>>  drivers/net/ethernet/realtek/r8169_main.c |  8 +++----
>>>>>>>  drivers/pci/devres.c                      | 28
>>>>>>> +++++++++++++++++++++++
>>>>>>>  include/linux/pci.h                       |  2 ++
>>>>>>>  3 files changed, 33 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>
>>>>>
>>>>> Heiner
>>>>
>>>
>>
> 


