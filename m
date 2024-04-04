Return-Path: <linux-pci+bounces-5733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2289898B47
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 17:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8902832F9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90CC1292E5;
	Thu,  4 Apr 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="2yJpnP7b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E4B1C2BD
	for <linux-pci@vger.kernel.org>; Thu,  4 Apr 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245012; cv=none; b=sDV2pv+93f9qCvGg54EvMjpy1HKQhwStJlnoEFRCJ7IEdEVEkldZE/KA1D5/UT6muVBRtSdLk/95eyoI5VJhHvm5TwbEL+8xBeq6Byhl+Nnh8YTWXURysibB7zNNPKi7w0JZ0YvwuEmWJIuvVTCKQK/9tLZCvsP4d3YYrC6tzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245012; c=relaxed/simple;
	bh=Cw496rLqKiajsl/rJN7O++164SrkLoI9BKMp7KbHIOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTsO5rnLYcuo+54oWZthJARMoO0XsxS9a237K/7lEHe9M3pzvkqCAGq9axsKHlQpMrfPxJX3KOC6CAj3NYZpw+mKA131cXGeYY1FuSL0yVxewJUahEFu53oaHyGv0a/1B6lbmIkaT4asNwJZrPNK1hfkZ6asgLe8dUghcbRWwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=2yJpnP7b; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4162b5ba333so5159485e9.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Apr 2024 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712245008; x=1712849808; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cw496rLqKiajsl/rJN7O++164SrkLoI9BKMp7KbHIOU=;
        b=2yJpnP7b7M4Caph1ggwtNq8z7OAkW37w64caBNeQ4HLbhytvqUvsWOqZW/UiWm+8ip
         PHsPUFXbbdFVpubtXbMwmDUhSLvO2jMXQjj+lErEUqzmLPHApvfjbTM5q8yseDv+B5sd
         M9X5iiku/3gjH/8PouIobytvgHh2T1yoDhTxUWCV3GF81LEcavT2PyHGTmIf7Zsfl4wN
         i8vm29aJts/7EwDTqpNblHqwXZqbeRVk2A/IoE/drFzg3BMhoxJCzSmGCaSOKrJcHsVc
         TLvHvFV9KBiISIqtWdJrtgJbWdDg4ZnCAFTmt2yH1SDU7ZG3uGSfNV+vS86tOzK6kCzF
         NMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712245008; x=1712849808;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw496rLqKiajsl/rJN7O++164SrkLoI9BKMp7KbHIOU=;
        b=ubjNgp5UObtmEAeIngJlwvjFeRz2v+yoLurlUzg5Cut39ipSK4CLEaQQA1DaDixZk6
         GM5QEO8Hvv/A5bkTNfIhIw7W8WsixA0z2rcbbvQ0z8HAFDeliwmRyxiZ993A0oIyj62d
         QwjU6PLJvJN2UxDSdtj07NptDeD9ydIPPTo1Yp74JqpMe5Ygw59F6ZP7hZzdgSREb7nH
         KXuj5iR4LZ+QrMjnXe8YnLgtJRAU9fpSUlEmNKYmWR+C7d899vMwgaspO1NH73r0C9bs
         KRhg+oZpdMAyLEPQyW6ueSYXL0ckX7jMEsJPA3nZNaJUc/pYwEclpwpJXwpB9ImnIMie
         U6Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWEhvclbYMxD2+4yEILiFAV2G10gPWxw2tXxpnWpv1PY/kKa1CBDU6mnCRqTfc+Hg+WngPjcBTsi+gDVhjFK8BIRv5d4EPDIwoP
X-Gm-Message-State: AOJu0Yyvl0Bj2Sg8w8TdFl90dcf961d5QFd+TetYpHrew/+OSIAx2LdX
	vpCcpVcl2LUzh0T1fDJKSQjWCkRdwUYPF++sn4ztNNRh4QANguX4344AWvuopdM=
X-Google-Smtp-Source: AGHT+IHazlWnujPo7lc90IvIX22ZDkeN5ev5pfjmkLb4RbuFX4OoB28fvJaM5qEsmwTGi7XT5FaJoQ==
X-Received: by 2002:a5d:6644:0:b0:343:b942:32cb with SMTP id f4-20020a5d6644000000b00343b94232cbmr1751095wrw.21.1712245008378;
        Thu, 04 Apr 2024 08:36:48 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ck5-20020a5d5e85000000b0034349225fbcsm13313857wrb.114.2024.04.04.08.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 08:36:47 -0700 (PDT)
Date: Thu, 4 Apr 2024 17:36:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <Zg7JDL2WOaIf3dxI@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho>
 <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>

Thu, Apr 04, 2024 at 04:45:14PM CEST, alexander.duyck@gmail.com wrote:
>On Thu, Apr 4, 2024 at 4:37 AM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Wed, Apr 03, 2024 at 10:08:24PM CEST, alexander.duyck@gmail.com wrote:
>> >This patch set includes the necessary patches to enable basic Tx and Rx
>> >over the Meta Platforms Host Network Interface. To do this we introduce a
>> >new driver and driver and directories in the form of
>> >"drivers/net/ethernet/meta/fbnic".
>> >
>> >Due to submission limits the general plan to submit a minimal driver for
>> >now almost equivalent to a UEFI driver in functionality, and then follow up
>> >over the coming weeks enabling additional offloads and more features for
>> >the device.
>> >
>> >The general plan is to look at adding support for ethtool, statistics, and
>> >start work on offloads in the next set of patches.
>>
>> Could you please shed some light for the motivation to introduce this
>> driver in the community kernel? Is this device something people can
>> obtain in a shop, or is it rather something to be seen in Meta
>> datacenter only? If the second is the case, why exactly would we need
>> this driver?
>
>For now this is Meta only. However there are several reasons for
>wanting to include this in the upstream kernel.
>
>First is the fact that from a maintenance standpoint it is easier to
>avoid drifting from the upstream APIs and such if we are in the kernel
>it makes things much easier to maintain as we can just pull in patches
>without having to add onto that work by having to craft backports
>around code that isn't already in upstream.

That is making life easier for you, making it harder for the community.
O relevance.


>
>Second is the fact that as we introduce new features with our driver
>it is much easier to show a proof of concept with the driver being in
>the kernel than not. It makes it much harder to work with the
>community on offloads and such if we don't have a good vehicle to use
>for that. What this driver will provide is an opportunity to push
>changes that would be beneficial to us, and likely the rest of the
>community without being constrained by what vendors decide they want
>to enable or not. The general idea is that if we can show benefit with
>our NIC then other vendors would be more likely to follow in our path.

Yeah, so not even we would have to maintain driver nobody (outside Meta)
uses or cares about, you say that we will likely maintain more of a dead
code related to that. I think that in Linux kernel, there any many
examples of similarly dead code that causes a lot of headaches to
maintain.

You just want to make your life easier here again. Don't drag community
into this please.


>
>Lastly, there is a good chance that we may end up opening up more than
>just the driver code for this project assuming we can get past these
>initial hurdles. I don't know if you have noticed but Meta is pretty
>involved in the Open Compute Project. So if we want to work with third
>parties on things like firmware and hardware it makes it much easier
>to do so if the driver is already open and publicly available in the
>Linux kernel.

OCP, ehm, lets say I have my reservations...
Okay, what motivation would anyne have to touch the fw of a hardware
running inside Meta datacenter only? Does not make any sense.

I'd say come again when your HW is not limited to Meta datacenter.
For the record and FWIW, I NACK this.


>
>Thanks,
>
>- Alex

