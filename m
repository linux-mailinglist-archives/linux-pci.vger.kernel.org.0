Return-Path: <linux-pci+bounces-5362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC108890CDE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 23:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618F6293771
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 22:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10A613B593;
	Thu, 28 Mar 2024 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKv/JHww"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB33BBCA;
	Thu, 28 Mar 2024 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663418; cv=none; b=D5chLfhfty7sDoIPuaj/F4KPkeMY3qEi7+ch2uJ8Fs+cADmd923osGjArp2hWGxJGtnhPOvLBW//DBlWH7ugk/83uTknXClb4ho1bln+yhu/22uRskbpbiTKIjCh1XkD4naHKNTnzf4Nt4uJcVHtqUJ494Q0un6wp5AJVqG1Pdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663418; c=relaxed/simple;
	bh=5dcSGXrF8KQyNTnCbN53mbpvUpc/W59FUx9ThjHKE60=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IMwOU3aA7Bd6+FZuY1pfep69yLBznkWOg/ubxIEdPZbT2+rmpX14YdDWs5U3gyNd1xeZvIyw2WQbNOgA6dLED93LaAnVkKV2V0THq0juGr/3h60MFAuruDSH7PMrY/FqrGrkFGC6R3IsmVDsgRGwLE+qSofijWF7hX4azJg0jbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKv/JHww; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41549a9dcbaso5583155e9.0;
        Thu, 28 Mar 2024 15:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711663415; x=1712268215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=msl3L0lFeJ10jqkQ5/0/h10K34mChSKUphPaqgw7AhM=;
        b=mKv/JHwwQZ6z5KVFxfw1+182cDYcA4NztPyoJ6IOuE5BtFiNOgR9cq+aGgoVn0SPMm
         sSlACZXPJeo7sWsnRxRh9BBtAD052ZUY/SHXAyE8DtKPQIDhuNFKdOYJxV93dzr9iRV4
         7VFvG8MrXhbtyMNAv4hdF75xF1iTCFcwv1YIQPXz7Xxf6T4b5AaTibdVZQkX6GPdx+NQ
         DSSvwLoxZQ/4u4HZ4iIHdQV9EwnWdcLKYngKxMbR5QR0z8SsRNiWL9kXsipSjMa4hljR
         CoY+LR7ISOAVmftMJPoaVb6ZuiabxZSjD4eQB6ZLelyR+wkuZTJzQUkO+Jz/v21qdUMR
         owOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663415; x=1712268215;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msl3L0lFeJ10jqkQ5/0/h10K34mChSKUphPaqgw7AhM=;
        b=BeEoCvx0bXj7hdlB1r+pRJ92xsQQfLJZxCdk8aBT+EZHTmm46BbxSuoMHt6+nGwq3l
         k3Y5bfGOAlT6ZEVn02uUhipkpv6uS7a7jUlOzHES6pIskIrrq6R2JtyYiANkv7kk4l4F
         1lrPKnfuP8wTSgQ3s/7Y7haFbQxkpQrsTWmWIMdtrI8kjnoRsSptfvY9g3m5Q4J8IIKN
         egRp8peULquQYQGLQFhpGIo1yMjOC4FY2n7icWYYJskM0ngB8WzKbhSDsn/tkJFhPvik
         Ph2c9TIu61AdDpLvl9M5Bg+xToDfsna+y2zH9gnu6bYkPAollbnBrVyI5ZiQbOEM/ks2
         PvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJO47ZaCHwjnqrhX1to/SPYqy2YCjE0B65Cr/DKp0Zr8cUIQyJyR/ccf0zKGxvS5XEPyfo0JkW2/m0TM0I0PFKNwEMVhFa
X-Gm-Message-State: AOJu0YzZ92PjXCIOpISAG4ZV5Jael/X11frkmdsHmROy98c38jhhamPL
	tUfd2tEjqI3bkZCMVLQGel6Nl2ke6SqkqPVSCxacU+u6ARfuFYtBbAiztVj/
X-Google-Smtp-Source: AGHT+IGIjxB2lt9KdFDxidYUE34te6chw9brazmEK+DgseCI/4DY9Wlnhv6CDw482qrPQNwnj/zF5A==
X-Received: by 2002:a05:600c:a06:b0:414:e0af:9b9f with SMTP id z6-20020a05600c0a0600b00414e0af9b9fmr405798wmp.30.1711663415167;
        Thu, 28 Mar 2024 15:03:35 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b9be:3500:9016:a3de:1f88:2f89? (dynamic-2a01-0c23-b9be-3500-9016-a3de-1f88-2f89.c23.pool.telefonica.de. [2a01:c23:b9be:3500:9016:a3de:1f88:2f89])
        by smtp.googlemail.com with ESMTPSA id p12-20020a05600c468c00b00413eb5aa694sm3520875wmo.38.2024.03.28.15.03.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 15:03:34 -0700 (PDT)
Message-ID: <7af7182d-0f14-4111-b0c4-b57d2d24edd9@gmail.com>
Date: Thu, 28 Mar 2024 23:03:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PCI: Add and use pcim_iomap_region()
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Philipp Stanner <pstanner@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <982b02cb-a095-4131-84a7-24817ac68857@gmail.com>
 <4cf0d7710a74095a14bedc68ba73612943683db4.camel@redhat.com>
 <348fa275-3922-4ad1-944e-0b5d1dd3cff5@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <348fa275-3922-4ad1-944e-0b5d1dd3cff5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28.03.2024 18:35, Heiner Kallweit wrote:
> On 27.03.2024 14:20, Philipp Stanner wrote:
>> On Wed, 2024-03-27 at 12:52 +0100, Heiner Kallweit wrote:
>>> Several drivers use the following sequence for a single BAR:
>>> rc = pcim_iomap_regions(pdev, BIT(bar), name);
>>> if (rc)
>>>         error;
>>> addr = pcim_iomap_table(pdev)[bar];
>>>
>>> Let's create a simpler (from implementation and usage perspective)
>>> pcim_iomap_region() for this use case.
>>
>> I like that idea – in fact, I liked it so much that I wrote that
>> myself, although it didn't make it vor v6.9 ^^
>>
>> You can look at the code here [1]
>>
>> Since my series cleans up the PCI devres API as much as possible, I'd
>> argue that prefering it would be better.
>>
> Thanks for the hint. I'm not in a hurry, so yes: We should refactor the
> pcim API, and then add functionality.
> 
>> But maybe you could do a review, since you're now also familiar with
>> the code?
>>
> I'm not subscribed to linux-pci, so I missed the cover letter, but had a
> look at the patches in patchwork. Few remarks:
> 
> Instead of first adding a lot of new stuff and then cleaning up, I'd
> propose to start with some cleanups. E.g. patch 7 could come first,
> this would already allow to remove member mwi from struct pci_devres.
> 
When looking at the intx members of struct pci_devres:
Why not simply store the initial state of bit PCI_COMMAND_INTX_DISABLE
in struct pci_dev and restore this bit in do_pci_disable_device()?
This should allow us to get rid of these members.

> By the way, in patch 7 it may be a little simpler to have the following
> sequence:
> 
> rc = pci_set_mwi()
> if (rc)
> 	error
> rc = devm_add_action_or_reset(.., __pcim_clear_mwi, ..);
> if (rc)
> 	error
> 
> This would avoid the call to devm_remove_action().
> 
> We briefly touched the point whether the proposed new function returns
> NULL or an ERR_PTR. I find it annoying that often the kernel doc function
> description doesn't mention whether a function returns NULL or an ERR_PTR
> in the error case. So I have to look at the function code. It's also a
> typical bug source.
> We won't solve this in general here. But I think we should be in line
> with what related functions do.
> The iomap() functions typically return NULL in the error case. Therefore
> I'd say any new pcim_...iomap...() function should return NULL too. 
> 
> Then you add support for mapping BAR's partially. I never had such a use
> case. Are there use cases for this?
> Maybe we could omit this for now, if it helps to reduce the complexity
> of the refactoring.
> 
> I also have bisectability in mind, therefore my personal preference would
> be to make the single patches as small as possible. Not sure whether there's
> a way to reduce the size of what currently is the first patch of the series.
> 
>> Greetings,
>> P.
>>
>> [1] https://lore.kernel.org/all/20240301112959.21947-1-pstanner@redhat.com/
>>
>>
>>>
>>> Note: The check for !pci_resource_len() is included in
>>> pcim_iomap(), so we don't have to duplicate it.
>>>
>>> Make r8169 the first user of the new function.
>>>
>>> I'd prefer to handle this via the PCI tree.
>>>
>>> Heiner Kallweit (2):
>>>   PCI: Add pcim_iomap_region
>>>   r8169: use new function pcim_iomap_region()
>>>
>>>  drivers/net/ethernet/realtek/r8169_main.c |  8 +++----
>>>  drivers/pci/devres.c                      | 28
>>> +++++++++++++++++++++++
>>>  include/linux/pci.h                       |  2 ++
>>>  3 files changed, 33 insertions(+), 5 deletions(-)
>>>
>>
> 
> Heiner


