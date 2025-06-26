Return-Path: <linux-pci+bounces-30799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D65AEA4C3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 19:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192CB1C43B6B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A002ECE88;
	Thu, 26 Jun 2025 17:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN5mwU0K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C052ECD3E;
	Thu, 26 Jun 2025 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750960413; cv=none; b=GUkTktJmkRgbPHQWRUoJLICq6m/01ojn4/d3AgJ70pannOOLyHlp6VpdAcNbkap577ius01oY45WvDdResI41f3wSeCcZl/zEQPQpsQRiIoAi/EGXI8wpg9vb3zyVz2oJsp2sNGEJWv8scdVLpiIF4outIKCZ93sVSdLseIAI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750960413; c=relaxed/simple;
	bh=3DW+isIgbcOam9K3su8rrNYApBVcaHJL5UXxTcvoqeA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FvdJ/9K+wV32NlfGd0KWpY4l27zWL3/uY7LWBpWC2/bm/rFZvL4fpl1J2bfO8YvBlN4HfTVQjfAPCOZpRUNaVZDnCPGexLjTO5ss+WRTGACu0lVaSpPneISkEuRMWzEl9jULsv/L3ApbOwRsuEUjk5xR/DHneHWpCI0dUVeCi78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN5mwU0K; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-236377f00easo16668745ad.1;
        Thu, 26 Jun 2025 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750960411; x=1751565211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3DW+isIgbcOam9K3su8rrNYApBVcaHJL5UXxTcvoqeA=;
        b=KN5mwU0KK7pXmP/CH45uebT/jMPCaGZnKvGm20uu8lP2kLrANHK+9MY1DHUVoviPnd
         NoQ2ahO4jkWZG69Wpz3Rvvyo7aociNoyrh71Qp2Zv7rtYNHYvcptMKKreFBdIC7rfjm8
         1tb1K+jbTDcsYLSQtR4yCrCb/qH+0jtkDqevLvutgzLrpCGs9ZlKCndjW0QcUitSqwAG
         o3Snn+fiFw3fVr3jd1x8zzhhqOWmIcWRvPyVTgKwO1qSnrI/acHUTNfY34N+ArT9lrzY
         1F2jgmKxv0plqzQKAuK6cd8hJ+wg7s/GTmXtNJO2yUD2/uwo9mgHDIuQ5MJiwXViCibf
         pzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750960411; x=1751565211;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3DW+isIgbcOam9K3su8rrNYApBVcaHJL5UXxTcvoqeA=;
        b=unPdtOc9NE/dtwJqG4bKt749VrX0X/ZFvgLP4L+SPIUWfIKvKhmOYgIMJF/WRjE2xm
         IfC7zvC9+CcRr5el2Dy0HsUqeAw7nSr37lNlo9tyVzSMqYzBAgfEG3Dh/kXWPbotYQXq
         lNbH1ULWuzBvmDndK3K5fpwg49QooeFkHPyYvroP4CqPf498Yb73ngL8TqKB/OgFieyd
         igQhcXNXfmZ+loXhS52yx3kZ8SfFuqkMMdYXraW/aZik/PRRdyu7G/u+SWpt0xljgeRh
         KD+89t3udqWTIEBaZ6oyi7aDj4HhvUeqUptPexn/CyQN5GDvirY1Z4h3Mf4BucrEBTRk
         tuog==
X-Forwarded-Encrypted: i=1; AJvYcCUhzCZyZ6NWSCn2YFD//lKhOIKmm12EjwT+LQR4ylWNlXviaAFFLQ6C0+8brUDsoY8wGwOoyDvx@vger.kernel.org, AJvYcCWm21K1DGcQcvSv7pkMPRTCPUQImhLXw4SJwnpTZUXbqkF6WHhH7OKhRLDn4r+ND7gIo/61jIn2nLae6OgKpgo=@vger.kernel.org, AJvYcCWxqO4z8K+DJAn3U5TdqCGAriX2H0vKpNFv/4YjXvXG5J6TF0R9OlyLFiyh5nQgzPeLIq2aWV2XbADn@vger.kernel.org, AJvYcCXN59WdDr8IBXnOkHX5cE7+mSqlZXh6LaXBoiVm/DlTmQpB5a2UXBKMRp00bEJIl9YecqrkgVpKhS1P@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqieERovBdSbAmzWK54ziQyyaq51Z6XHS7m6Ii8zXubIN6oE3
	OZyNvrf6+3HzFbNlcX/orx0MPclbUKP0/MYMOvrbouB9TmAhCOCS24mcx8qnPykwSCs=
X-Gm-Gg: ASbGncsv6sDHFjzWkwXWmV86Sm1RNh+8LSgutvo+1uMplZqbvFd8RZj2Lo52iszbgl8
	eSLxp+Z10p/xLR8od16Mku7B1l6DCYdEDEVE/6SyFuJLP5zqsTa8VpA9BoQTLKADKFsjcd2/Msg
	oiJVeJHXYs2zEerarnSmxiyqTd0FcP8Qpls7q6wmR40l9x+1ZaZ6abnjCqntX/hTxwvt9ptoz6O
	9w6eIDZ56pPltSF80yf1dk1DGuyMJLo5aA6PMDY5mULpXfYgfsi9T5aGX4a0BYx3K2n7x8Wpeqz
	KWwKsGd1LNeVZjGHlbRh7HUg/Wn3mXnxsdAb7P8ngCs0ITSEfvmL4++cTKUOX9H2iiemTp52uJj
	eugE=
X-Google-Smtp-Source: AGHT+IGMAGEXF0yV0ZZzuhQSFlpR4GVzlRjXoSxE+CF+J+ar1VbxUo+RYXwsDYzu1MLVP4aLNgLoyA==
X-Received: by 2002:a17:902:c950:b0:235:799:eca5 with SMTP id d9443c01a7336-23ac463e850mr3573485ad.44.1750960410691;
        Thu, 26 Jun 2025 10:53:30 -0700 (PDT)
Received: from [127.0.0.1] ([116.206.223.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe312819sm3768515ad.34.2025.06.26.10.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 10:53:30 -0700 (PDT)
Date: Thu, 26 Jun 2025 23:23:14 +0530
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_Instability_in_ALL_stable_an?=
 =?US-ASCII?Q?d_LTS_distro_kernels_=28IRQ_=2316_be?=
 =?US-ASCII?Q?ing_disabled=2C_PCIe_bus_errors=2C_a?=
 =?US-ASCII?Q?th10k=5Fpci=29_in_Dell_Inspiron_5567?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAEmM+Qg+xxMfXb=704OfwYLou7Mh_BNaTevLaGfiG2peZotJoA@mail.gmail.com>
References: <CAEmM+Qi-Waxk5qcR+nfip-QGXaKk0-Kq7QSq890e9oYOPjW+bA@mail.gmail.com> <20250625202014.GA1585022@bhelgaas> <CAEmM+Qg+xxMfXb=704OfwYLou7Mh_BNaTevLaGfiG2peZotJoA@mail.gmail.com>
Message-ID: <E8A26FD9-13E3-474A-87FF-ED8D27A1F27B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I think I found it=2E I used irqpoll and I didn't experience any hiccups w=
ith my mouse performance=2E But the Wi-Fi was still malfunctioning=2E

To linux-pci and linux-acpi:

It's an ath10k problem, sure, but there's something definitely problematic=
 happening if, in the normal state, these Wi-Fi bugs hamper the touchpad mo=
vement=2E

To ath10k and linux-wireless:

I tried out "options ath10k_core rawmode =3D 0" along with "skip_otp=3Dy' =
and the Wi-Fi seems to work perfectly as of now=2E It might be the fix, it =
might not be either=2E But I think there's something more important to ask:=
 Are there any good resources/documentation on referring to what the differ=
ent key-value pairs mean? Like, what's the exact documentation through whic=
h people arrive at "rawmode=3D0" or "skip_otp=3Dy"?



Bandhan


On 26 June 2025 4:20:13=E2=80=AFam IST, Bandhan Pramanik <bandhanpramanik0=
6=2Efoss@gmail=2Ecom> wrote:
> Please ignore the last email (I haven't replied to everyone)=2E Also,
> here's the actual updated dmesg (the previous one was the old one):
> https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a1=
6180/raw/78460e6931a055b6776afe756a95d467913d5ebd/updated-dmesg
>=20
> On Thu, Jun 26, 2025 at 4:16=E2=80=AFAM Bandhan Pramanik
> <bandhanpramanik06=2Efoss@gmail=2Ecom> wrote:
> >
> > Hello Bjorn,
> >
> > First of all, thanks a LOT for replying=2E
> >
> > I have included the files in my previous GitHub Gist=2E Sharing the ra=
w
> > files for easier analysis=2E
> >
> > lspci -vv: https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca=
2ea43a1d832a16180/raw/78460e6931a055b6776afe756a95d467913d5ebd/detailed-lsp=
ci=2Etxt
> > dmesg: https://gist=2Egithub=2Ecom/BandhanPramanik/ddb0cb23eca03ca2ea4=
3a1d832a16180/raw/78460e6931a055b6776afe756a95d467913d5ebd/dmesg=2Elog
> >
> > On a different note, I had to use pci=3Dnoaer, so that the ring buffer
> > wouldn't get cleared that fast=2E
> >
> > Regarding the ath10k thing, none of the fixes worked this time=2E Only
> > irqpoll worked=2E I don't know if it's because of a disparity b/w GNOM=
E
> > and KDE (because my daily driver is Fedora 42), but I'm 300% sure that
> > it's not just the Wi-Fi that's the issue here=2E It's most probably a
> > lot of issues here, and the harder issues to fix are usually the ones
> > closer to the hardware=2E
> >
> > Anyway, if you get something, please let me know=2E
> >
> > Bandhan
> >

