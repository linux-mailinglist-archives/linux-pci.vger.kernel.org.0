Return-Path: <linux-pci+bounces-22922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F634A4F1AE
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 00:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6926E188C489
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 23:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAD81FE476;
	Tue,  4 Mar 2025 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRsSNod7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6351EBA1C
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 23:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131780; cv=none; b=o8TblOjHObKEvJ94rLM0PkWi8Fdg0wpuMWfQeYb3ofQE4RsE5E0p56BfUJyIj7yjP9hcLUGxMJYMrN7FMiQhlu5pYJSm7Ax9HoU2sj3CJtZUYXZkQgvBzMxMZvrw2PN1iPWL2pjt84+xe2ikiB4dINlhjl7lf1TxYGe35DcFF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131780; c=relaxed/simple;
	bh=GNy09R9SA50KY66wtTFup7w21UzMJ3LfIEDiKUkALpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGUxMbKSlguYIPbqaKMoD46yMqvz2Fr1rfzDgbBulfL4FO21+Q68rHJm4L4Y+ddyPyzK9BuP4uGTMGWEjjnpzUU8jlNW7W/LsVjyJA6Ux6RGKPYWNu3tJrypMvOY5sA3MVfTGWmBacyNHZ0v2SHtt2UD5oiECeQNuGaFpY7HtvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRsSNod7; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abf48293ad0so634930166b.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 15:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741131775; x=1741736575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaCVoR3XYstjmS4rWnFH46KY8E7buhHKlDcTl3JebCg=;
        b=dRsSNod7YNQEDOv1zFVef85yEAmtGp5RyetqY+J30nrPsXLGqf63p7TtbtHyXCU7no
         V0qL85DpVxmg+xfIc+LnyITw+xenDs5CUt+AjXoictcOQ/EauuOgUQueqq5tp6QNXP84
         XQ+azGiuetp8kuRw5MgatYmwaOywKsmh19w71TAIZGOqZlMG7Wckvj4+S0j/lNWbU17B
         TK6dpcVDuha7GTdFFK+rObOGkGkDV9KlgRUfHBRl0X4Jw3KEyqvITqt+071VOW5VV/Ei
         V9eDq9Ty1ZhGd2PcEf40DI8kg/pDJMEctH0gagOqk81YrhLr67jiFfk3cWryNZETmJjw
         0+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741131775; x=1741736575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaCVoR3XYstjmS4rWnFH46KY8E7buhHKlDcTl3JebCg=;
        b=cJ9b2ac4Ev55Zg3WJC547GO6jIGIOEYAusKht9bZGMBeCQh8/EeUybsxRHJyyPZaZL
         o4pKTue1Y2VFK3oL0lV+Ad8/4wiR9DoFShFV5bKxB7/DPiRU7aLbrZPi/MymotFI+D16
         WmsNfp0RResrTwHdmW8vrFQpGoFAKmRHAtle1CIncMa7yaX74jEmMGp3R2OJKfsxlMqI
         0le9sSJ0RIlivmimjZHfFaHiGtxrdm5hJ5B0t8Fq4O+XZYvfC9qbu2z7mOzaQsxq/s4P
         tTceeLyJpNLm6ElWnji+pfx9UCxf5/RMo0i+T+dA9xsf2TlfqfUdxY4UrCuETP3yJiDq
         Cpqw==
X-Forwarded-Encrypted: i=1; AJvYcCVA8neJJ/CmKVHbEbyUUZvSDsgmYJHoMUsHi+HAQfMK7sRUz7fh/JcSdME7ZZQIbLfGL5WYNEcHUog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXLLcf1RVJU69XSyUhBUovqo91ChSSf8jIb6fTmzB01XKZMnoT
	1SVt1CZ6XFf3kSYR1/nvHyoJtbR19fOcI1+U38MRpQ1z/YMOI5j1uyjT+hk9kge/xDuHlmjqBJF
	OKzl/WaSksQwz1ux4N0FG7FAomv4o4Sx6fOWntRtxiddGuQcGNil9hlE=
X-Gm-Gg: ASbGncsMnCLSmuWJC2mr1vabX1NsA7eJQ+1j6XAHDs2/82T7WfvILwjoV1FCRnsR410
	o9wUPUKDwUAILkLuLQLW+V0s7mpdBB0Ag4r2j96dTvc64mgvYkVCbPf1JSbWzBLZLknCDRLwbEr
	e71JMQ4RGNHZt1sauUkfKRC9SFB0QJmety99Amq4gXqt6NTWtnf1Dzft/6
X-Google-Smtp-Source: AGHT+IHehU7iQ0+Cm+v03cnHoldw43crkHM0NecCwrIelr3B3Y5CuO8+vlhIp2OuanQRcJYDmQ+K8JB3LbL9eVgW5Lw=
X-Received: by 2002:a17:907:962a:b0:ac1:f7a6:fba9 with SMTP id
 a640c23a62f3a-ac20db13a78mr96967966b.53.1741131774964; Tue, 04 Mar 2025
 15:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-6-pandoh@google.com>
 <Z5SVN8tt-xtCAHph@wunner.de> <20250131144355.00004065@huawei.com>
In-Reply-To: <20250131144355.00004065@huawei.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Tue, 4 Mar 2025 15:42:43 -0800
X-Gm-Features: AQ5f1JpcSrUgEEvrRY20itkmCmctAJmarAul3GZBO0N-NAuTXDuh8JfU5iGDfRg
Message-ID: <CAMC_AXUsEdHNDiK9jnuxqBncS-26iNiRo_uP=2Yrpkt4rtfLCA@mail.gmail.com>
Subject: Re: [PATCH 5/8] PCI/AER: Introduce ratelimit for AER IRQs
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Karolina Stolarek <karolina.stolarek@oracle.com>, linux-pci@vger.kernel.org, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 6:44=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sat, 25 Jan 2025 08:39:35 +0100
> Lukas Wunner <lukas@wunner.de> wrote:
> > Masking errors at the register level feels overzealous,
> > in particular because it also disables logging via tracepoints.
> >
> > Is there a concrete device that necessitates this change?
> > If there is, consider adding a quirk for this particular device
> > which masks specific errors, but doesn't affect other devices.
> > If there isn't, consider dropping this change until a buggy device
> > appears that actually needs it.
>
> Fully agree with this comment.  At very least this should default
> to not ratelimiting on the tracepoints unless a specific opt in has
> occurred (probably a platform or device driver quirk).

Hi Lukas and Jonathan,

Thanks for the comments. Since IRQ ratelimiting/masking is more
drastic, it requires more nuance/thought (split the series in v2[1] as
a result).

I am not targeting specific devices per say. The intent is to allow
userspace daemons/agents to dynamically collect telemetry/handle spam.
In the context of the datacenter (i.e. several OCP members), there are
many deployments of new HW/configurations where we may see/have seen
error spam when trying to enable native AER. Kernel quirks work in the
medium term (until the underlying device is fixed), but require a
kernel rollout. There is a desire to address this faster (i.e. without
rollout/reinstall) and I think IRQ ratelimiting fits the requirements.

I like the idea of having IRQ ratelimiting off as default though as it
is a big change.

> In particular I'd worry that you are masking whatever errors are
> finally trigger masking.  That might be the only one of that
> particular type that was seen and I think the only report we
> see is the 'I masked it message'.  So rasdaemon for example
> never sees the error at all.   So another tweak would be report
> one last time so we definitely see any given error type at least
> once.

Ack.

[1] https://lore.kernel.org/linux-pci/20250214023543.992372-1-pandoh@google=
.com/

Thanks,
Jon

