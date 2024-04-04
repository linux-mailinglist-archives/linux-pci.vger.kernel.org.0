Return-Path: <linux-pci+bounces-5744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E52898EEF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 21:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB152B284A0
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 19:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12F5134435;
	Thu,  4 Apr 2024 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiI6kx6I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75251339A2;
	Thu,  4 Apr 2024 19:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258563; cv=none; b=Dl1HZ6vDfArY+9CbiaM5UbZjLc7YP7etuhm4mHIs1107v5fRQaLu1HydRxgNe0vhqR0W/vD5XIDf7X8aHF9OJvJbHZbciTbWu9uhgDdYS7QRq9FrzRst7snAeEZkIcjVHphbRXC/IJ1WvohnnHTiPbRoaYHdr8VxB6aqcGqPNas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258563; c=relaxed/simple;
	bh=L3u8qdzYK3tIcgSok6qUXAH/WJMn6GRjOGj6lME/65w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JD8uwzvodVILqRJDF1fh+R8uYKzzGEbiMih834jrkwq28npi6rXt/WpZRQLPlEX9YeIZ5DSNIoLPIiNvth3jKXNbAIrc+rCdxdytNOjSYvbztRJeZTShrIig94Hc+cjtGq5MrP59l22Y7LSATAVPTeWd9Af3Da640f2Kx4C9BV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiI6kx6I; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343c7fae6e4so574167f8f.1;
        Thu, 04 Apr 2024 12:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712258560; x=1712863360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3u8qdzYK3tIcgSok6qUXAH/WJMn6GRjOGj6lME/65w=;
        b=EiI6kx6IsJ8E+L6sSNQfWoqIXDY83JKJh8cGt2WS3kUkN+TkMKlyl23lLS2h6KJsnB
         mQde0YDTn6EZ6UseJ3VaaWJicfklY49azEeumwcKpKArlY6YZauoZLDZJ1LISagJutw3
         AvjfBM69UEPzaB+SQmE9wmD8VYOL47YKccjR9oxhlDH61XGmS9mBEeW3ys8WqfBYdwa6
         Gr94oFUb6GL8DqxREExYY6mD8ZwJDEtoTYpCKJDlFiY7Ts2tzqtaT+RcyLu27H9/uSOC
         NbyaV2FYx9aOzaEK7l9fL1Gsr21g5CbgFWhiT53xJEirW3EnTYwW0F/CEidlNdOE0cu8
         Fqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712258560; x=1712863360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3u8qdzYK3tIcgSok6qUXAH/WJMn6GRjOGj6lME/65w=;
        b=JgglhC62a6N4rU2L6Xjp7/JSPQmMAVr/3ck+zxlAw7sI9fp9PaZ9P+KqplXNgnKVXi
         xBFLsrXmNHgsNKUKGas9NbdWUiq/YR1kQ8hnckpijLTnFYTP0I5zxqr81lvjcW+2/LjT
         8hTmvwXU5XIY7J05R0T/UansQ3KXQ/qQU8tACLauxapm7vT031I/S6jD9dGTbytjw1fa
         wGsmiteJBtyfyGO7i4Z/LPUWmX44AHYaY2tF+Bm4S7FODW/YwQ+5w3pHr2Vi4ssonWL5
         2/V5+qtvAxOVVCRZwdlOa0eSsjjMnNRTOtlCYioVQsq6q2hipmzd+XYebLRA+OOi0pin
         NKpA==
X-Forwarded-Encrypted: i=1; AJvYcCXk34UD591MkqNlOL0xw9KF7jaa+6SNC0MiY49OYnh/ED80ag0Q7zmdErJ665+1LyYWZFwBs9zZIeXRmAP+4/zbxZM22sw+V9D8
X-Gm-Message-State: AOJu0YyVKGaUJmcpbMweSVhbhm+yQh7vTGCzgbWK0m7XX+b31TIuF/xU
	furzmbuGDZOcNcCPUDMjfXMnX0oCTRbQAUyjR8gRX6giy34ROltFyeaASX3JfZfbOG/Q6HA9rMz
	uF81lY3+YBlbc5WeuvM0IkleMx7M=
X-Google-Smtp-Source: AGHT+IEW05YFY+qf0bLGERKY4/mx/eBoZkSo9D9PDYEuATnlM5TZB3b6m/CIaZeGQKcR/Ryro0r2FgB5lcc2VfQg4kY=
X-Received: by 2002:adf:edcb:0:b0:342:a8db:603f with SMTP id
 v11-20020adfedcb000000b00342a8db603fmr2536153wro.26.1712258559994; Thu, 04
 Apr 2024 12:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <Zg6Q8Re0TlkDkrkr@nanopsycho> <CAKgT0Uf8sJK-x2nZqVBqMkDLvgM2P=UHZRfXBtfy=hv7T_B=TA@mail.gmail.com>
 <Zg7JDL2WOaIf3dxI@nanopsycho>
In-Reply-To: <Zg7JDL2WOaIf3dxI@nanopsycho>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 4 Apr 2024 12:22:02 -0700
Message-ID: <CAKgT0Ufgm9-znbnxg3M3wQ-A13W5JDaJJL0yXy3_QaEacw9ykQ@mail.gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 8:36=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Thu, Apr 04, 2024 at 04:45:14PM CEST, alexander.duyck@gmail.com wrote:
> >On Thu, Apr 4, 2024 at 4:37=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wro=
te:
> >>
> >> Wed, Apr 03, 2024 at 10:08:24PM CEST, alexander.duyck@gmail.com wrote:

<...>

> >> Could you please shed some light for the motivation to introduce this
> >> driver in the community kernel? Is this device something people can
> >> obtain in a shop, or is it rather something to be seen in Meta
> >> datacenter only? If the second is the case, why exactly would we need
> >> this driver?
> >
> >For now this is Meta only. However there are several reasons for
> >wanting to include this in the upstream kernel.
> >
> >First is the fact that from a maintenance standpoint it is easier to
> >avoid drifting from the upstream APIs and such if we are in the kernel
> >it makes things much easier to maintain as we can just pull in patches
> >without having to add onto that work by having to craft backports
> >around code that isn't already in upstream.
>
> That is making life easier for you, making it harder for the community.
> O relevance.
>
>
> >
> >Second is the fact that as we introduce new features with our driver
> >it is much easier to show a proof of concept with the driver being in
> >the kernel than not. It makes it much harder to work with the
> >community on offloads and such if we don't have a good vehicle to use
> >for that. What this driver will provide is an opportunity to push
> >changes that would be beneficial to us, and likely the rest of the
> >community without being constrained by what vendors decide they want
> >to enable or not. The general idea is that if we can show benefit with
> >our NIC then other vendors would be more likely to follow in our path.
>
> Yeah, so not even we would have to maintain driver nobody (outside Meta)
> uses or cares about, you say that we will likely maintain more of a dead
> code related to that. I think that in Linux kernel, there any many
> examples of similarly dead code that causes a lot of headaches to
> maintain.
>
> You just want to make your life easier here again. Don't drag community
> into this please.

The argument itself doesn't really hold water. The fact is the Meta
data centers are not an insignificant consumer of Linux, so it isn't
as if the driver isn't going to be used. This implies some lack of
good faith from Meta. I don't understand that as we are contributing
across multiple areas in the kernel including networking and ebpf. Is
Meta expected to start pulling time from our upstream maintainers to
have them update out-of-tree kernel modules since the community isn't
willing to let us maintain it in the kernel? Is the message that the
kernel is expected to get value from Meta, but that value is not meant
to be reciprocated? Would you really rather have us start maintaining
our own internal kernel with our own "proprietary goodness", and ask
other NIC vendors to have to maintain their drivers against yet
another kernel if they want to be used in our data centers?

As pointed out by Andew we aren't the first data center to push a
driver for our own proprietary device. The fact is there have been
drivers added for devices that were for purely emulated devices with
no actual customers such as rocker. Should the switch vendors at the
time have pushed back on it stating it wasn't a real "for sale"
device? The whole argument seems counter to what is expected. When a
vendor creates a new device and will likely be enabling new kernel
features my understanding is that it is better to be in the kernel
than not.

Putting a criteria on it that it must be "for sale" seems rather
arbitrary and capricious, especially given that most drivers have to
be pushed out long before they are available in the market in order to
meet deadlines to get the driver into OSV releases such as Redhat when
it hits the market. By that logic should we block all future drivers
until we can find them for sale somewhere? That way we don't run the
risk of adding a vendor driver for a product that might be scrapped
due to a last minute bug that will cause it to never be released.

