Return-Path: <linux-pci+bounces-5880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC3389BD9B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 12:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AF92838BC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A1662172;
	Mon,  8 Apr 2024 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rT4d0WfH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD725FB95
	for <linux-pci@vger.kernel.org>; Mon,  8 Apr 2024 10:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573673; cv=none; b=Db1R4DIt1L9CytpgQwxIbznzQXol6i+V9jGfZ4CmfDJignvbOmMdbbe4Z9Xr98iqXSbjpAy8gGleozAUHTzxESnxrb5FeqH8rLLko1GK4dlDBYH0KW0NwR4yvzDP82EV7oYBKh0z75aFNjMHxi4AV5bOk6L3YtDtXKRBYMH+Y40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573673; c=relaxed/simple;
	bh=6rQbGDsfroHgeS23XMLeLhOkDNTsoatJ5SVogpp5BSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifI8r93wpzdPfXQkfkUb4+Sie+cx1M1IuBsGCnTZdANrDAKK76FFxoybqUAQxLVvzQhY9H8aAd7G8FRVCHsCwI02tdHXj7d8VOz4o2C9ZcwYGacOrRKNV6mVItCwn02Sg2OkBONNm4wGmwe2N2qR+MGW3UKL4yPX5Wpq4JY3ZjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rT4d0WfH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4165d03308fso9896015e9.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Apr 2024 03:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712573669; x=1713178469; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6rQbGDsfroHgeS23XMLeLhOkDNTsoatJ5SVogpp5BSM=;
        b=rT4d0WfHF2dL07Rlz7IQS/Fj7eyXFaR0potayVHoA60IS048NReluVwbFuxV5gXzxY
         scKKVUMRePUnY8RmyFN12xm8nlTkxzDpqKTTbl5w1C7PAyEWjuZN1WGiGzv8/iEdsNBl
         ED1f/Fee0zZfEoJOaOtqFqIx+gMGNMIcI3OT389R38SZpCGh/KCqlDC60SOSz0mU7Dyd
         +xzDZzfI397wdi38/ID4fljKpGA5JUN8A3mzhiyQDf2eTcdQcB4j2GwSr6DQQnv/OmLI
         Ss57w9f0XL8FsyeZwwSPFMeGQy+W6qL5uxCOkZuYrg0m+RZLFGe6hGtj75nHE1QtFlWZ
         4DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712573669; x=1713178469;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rQbGDsfroHgeS23XMLeLhOkDNTsoatJ5SVogpp5BSM=;
        b=Xxh0gJ+N/tk1Il+Rz48dx00nQBQ++KNYzWBlIXve8taX9fpLkhnQOgCRZNojebF4ri
         3W4dIlfWrWJEU0pImLMvNa5tOgw6lfXTfvuIcKf6EO8F3hAtVvCeBz69nLOS8IFuiaPv
         /LcnUd315naWsLrCv0dvOnvkScDMOE4hSzaTBPXATyApqtz+99OZ2Xu5+AnlYesTKill
         tv4dmZHsodGfv6a16fL/lUtDAq8BaTcM6lwI6IFQHNu6AZD2/E2Bu2y9ZAfMJ50C8P/2
         t2YcXx7r66bUMR4+L3+wlTKBZz8NtWNalDK31xhQh2XgVpzfDcN5lGdhzlMzsZ3l0aP+
         u95A==
X-Forwarded-Encrypted: i=1; AJvYcCUj0tD0VXLfPXuHplViNVwt8Fm9uv+RWfFyHwYrh8Hr5PxiZ6QlV2mkN5UFBrxz1fj1IfG1EJfmwbGai0H+UB4+s4Vhs6pbZaVe
X-Gm-Message-State: AOJu0YwwvvTVD1XYwuduELuP0IvnbfKXWnt+vh1sfRUFZaq4qdipLgl9
	ij4KK3mRYfXBoJE3xDXePprrll4PUM+sQKCWOVblVybXS2Il390+HfU4Pfxi2Uo=
X-Google-Smtp-Source: AGHT+IGwy/kPE65E40JO6QVimf0nyv7DMYmiAQafCkhNnlqKE0bFuKUurbfULGZMwtlbHvxLsbi1Jg==
X-Received: by 2002:a05:600c:3501:b0:416:6344:895e with SMTP id h1-20020a05600c350100b004166344895emr2961268wmq.31.1712573669408;
        Mon, 08 Apr 2024 03:54:29 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fm13-20020a05600c0c0d00b00416458c71f2sm7273106wmb.45.2024.04.08.03.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 03:54:28 -0700 (PDT)
Date: Mon, 8 Apr 2024 12:54:24 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhPM4Kr6wkAfJhCT@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho>
 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho>
 <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>

Thu, Apr 04, 2024 at 09:22:02PM CEST, alexander.duyck@gmail.com wrote:
>On Thu, Apr 4, 2024 at 8:36 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Thu, Apr 04, 2024 at 04:45:14PM CEST, alexander.duyck@gmail.com wrote:
>> >On Thu, Apr 4, 2024 at 4:37 AM Jiri Pirko <jiri@resnulli.us> wrote:
>> >>
>> >> Wed, Apr 03, 2024 at 10:08:24PM CEST, alexander.duyck@gmail.com wrote:
>
><...>
>
>> >> Could you please shed some light for the motivation to introduce this
>> >> driver in the community kernel? Is this device something people can
>> >> obtain in a shop, or is it rather something to be seen in Meta
>> >> datacenter only? If the second is the case, why exactly would we need
>> >> this driver?
>> >
>> >For now this is Meta only. However there are several reasons for
>> >wanting to include this in the upstream kernel.
>> >
>> >First is the fact that from a maintenance standpoint it is easier to
>> >avoid drifting from the upstream APIs and such if we are in the kernel
>> >it makes things much easier to maintain as we can just pull in patches
>> >without having to add onto that work by having to craft backports
>> >around code that isn't already in upstream.
>>
>> That is making life easier for you, making it harder for the community.
>> O relevance.
>>
>>
>> >
>> >Second is the fact that as we introduce new features with our driver
>> >it is much easier to show a proof of concept with the driver being in
>> >the kernel than not. It makes it much harder to work with the
>> >community on offloads and such if we don't have a good vehicle to use
>> >for that. What this driver will provide is an opportunity to push
>> >changes that would be beneficial to us, and likely the rest of the
>> >community without being constrained by what vendors decide they want
>> >to enable or not. The general idea is that if we can show benefit with
>> >our NIC then other vendors would be more likely to follow in our path.
>>
>> Yeah, so not even we would have to maintain driver nobody (outside Meta)
>> uses or cares about, you say that we will likely maintain more of a dead
>> code related to that. I think that in Linux kernel, there any many
>> examples of similarly dead code that causes a lot of headaches to
>> maintain.
>>
>> You just want to make your life easier here again. Don't drag community
>> into this please.
>
>The argument itself doesn't really hold water. The fact is the Meta
>data centers are not an insignificant consumer of Linux, so it isn't
>as if the driver isn't going to be used. This implies some lack of

Used by one user. Consider a person creating some custom proprietary
FPGA based pet project for himself, trying to add driver for it to the
mainline kernel. Why? Nobody else will ever see the device, why the
community should be involved at all? Does not make sense. Have the
driver for your internal cook-ups internal.


>good faith from Meta. I don't understand that as we are contributing
>across multiple areas in the kernel including networking and ebpf. Is
>Meta expected to start pulling time from our upstream maintainers to
>have them update out-of-tree kernel modules since the community isn't
>willing to let us maintain it in the kernel? Is the message that the

If Meta contributes whatever may be useful for somebody else, it is
completely fine. This driver is not useful for anyone, except Meta.


>kernel is expected to get value from Meta, but that value is not meant
>to be reciprocated? Would you really rather have us start maintaining
>our own internal kernel with our own "proprietary goodness", and ask

I don't care, maintain whatever you want internally. Totally up to you.
Just try to understand my POV. I may believe you have good faith and
everything. But still, I think that community has to be selfish.


>other NIC vendors to have to maintain their drivers against yet
>another kernel if they want to be used in our data centers?
>
>As pointed out by Andew we aren't the first data center to push a
>driver for our own proprietary device. The fact is there have been

If you proprietary device is used by other people running virtual
machines on your systems, that is completely fine. But that is incorrect
analogy to your nic, no outside-Meta person will ever see it!


>drivers added for devices that were for purely emulated devices with
>no actual customers such as rocker. Should the switch vendors at the

This is completely fault analogy. Rocker was introduced to solve
chicken-egg problem to ass switch device support into kernel. It served
the purpose quite well. Let it rot now.



>time have pushed back on it stating it wasn't a real "for sale"
>device? The whole argument seems counter to what is expected. When a
>vendor creates a new device and will likely be enabling new kernel
>features my understanding is that it is better to be in the kernel
>than not.
>
>Putting a criteria on it that it must be "for sale" seems rather

Not "for sale", but "available to the outside person".


>arbitrary and capricious, especially given that most drivers have to

Not capricious at all, I sorry you feel that way. You proceed your
company goals, my position here is to defend the community and
the unnecessary and pointless burden you are putting on it.


>be pushed out long before they are available in the market in order to
>meet deadlines to get the driver into OSV releases such as Redhat when
>it hits the market. By that logic should we block all future drivers
>until we can find them for sale somewhere? That way we don't run the

That is or course obviously complete fault analogy again. You never plan
to introduce your device to public. Big difference. Don't you see it?


>risk of adding a vendor driver for a product that might be scrapped
>due to a last minute bug that will cause it to never be released.

