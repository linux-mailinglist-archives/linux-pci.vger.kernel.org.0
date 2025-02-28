Return-Path: <linux-pci+bounces-22685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB5FA4A689
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 00:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191621899E15
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 23:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ADD1DED5E;
	Fri, 28 Feb 2025 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXxp2fmT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E51DE4FE
	for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740784304; cv=none; b=bnRuxYgCqG4b2KCsCXishZeT/x4q4JBUY0S/WX+NDeBZ1qxbpuss9z3y0+kMHaqbQ6wK6cuGXMr6laFqztMs/LRGSfsGHbefXR8P0TW5WHY2TNzX72NT/fG61u9lmC6hPFJRPXMnNCZ/kw5RWIY6KTo6DvCq71zWJWIpRytAgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740784304; c=relaxed/simple;
	bh=ynT6DFw5jjnvQgeUZq0e1twveCtWGC07q5CaVMaQ0MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLGa5Cc88bfJFuLh5oUwF1UR3MBXlxFoKrNrRbsO0qS2wliEq+RZZGu/c5ePf8PYTI53VMY8gQPagiq1nIjn+9PjZ+NQ6tAuFhiaBZq/WgctvRj1eZIRvma2xmIb+sTrpEAy25D6+OLlz7a/ecg7+sO8VLiufrvS7jT4mDtWRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FXxp2fmT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e4d3f92250so2878367a12.1
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2025 15:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740784300; x=1741389100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dNLJztlebdlE9O05ciaOcUiUoMeXw+0uP2uLpVH5gQ=;
        b=FXxp2fmTywLuY0Uai1Q1kzgVEqHLPFqC/0VllimIKmrRFb4EeaorOGaUFc4VoYW8HX
         NoDPMS90Kqi7gWycWsrJ5t3Kr6x3G3d4ZuXEQXxXoOcW/nY7pxt+in6WUEV6tahXFeQP
         +RKTNtVSdFVXw8/IyGWYe3slPsvK/NK5cfWe4kwfmNINtcoRtyZAaR9ZE4qVIjUB4Mv4
         scKua1nDypoUVwj6M1DPA+5ZFHbKnOuNBWoNc9Syp4OcAiS8GiApmzflpB6HTZVVy2qo
         V101Lx/JZWX6B5TDLDciG46zuby9eGmVG2nkg2kvuJne597c37CABLgaaw9a4hRNm1sA
         b3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740784300; x=1741389100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dNLJztlebdlE9O05ciaOcUiUoMeXw+0uP2uLpVH5gQ=;
        b=ldQtcTwV4Y4Qa4oQF58MkEjTXEhWiLaPAwoYxl3peYwVW9XETpkpLL8U0K9ZFpaZXg
         zqd1M6ZfSz4iaMDJ0u8+ZB2Uk6GkUDjQaTpMccVEeAKaCm+4WeRWkuio55t+i/09/i93
         XeH4MInIYncWe0vvKY20Gxz7z6ZQAJ45wUeBtbKqoQmYXT7xZJQATK94BUjxIwAg6Oq8
         Dcvkvfl+SYgZDKa850xDQ79lcIPTVVIFrWCxxArxdlBZFKcDn+acmd8b9PO2J6oOynvR
         rQU+2vpTUaw6djBCJ0hK4Oru6xzPnrgEkdxbJ8T+WfdY0UisD5Ps0n6IkxAB2ne/xgZX
         UuIA==
X-Forwarded-Encrypted: i=1; AJvYcCWrguyX6ROYZnCCyIP7+UebK5G6AVU9H7gP4jcNnuqilyFfXlJJ32v23qwoCL+8YVyQxcCP469itqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWNxy23CtHq5c54Q6WKwtM61wVVKmBMnVtcA+Hdd/Xxsdq7Er
	5/phYTenmpWGavnqIyhSvF+bOFq17lYGcp6d4qQqD3RB3VwlnTGyB6GSQd1lC/4boXzJj6lKb9h
	dIkGiATInrCSTh6i6QJ1C3jB5lEHi2aDwBI5E
X-Gm-Gg: ASbGncuZiYda/a0lFD24y9hve9CTS+LYk0LUl+FTJd+n9RNoqnWzV5B6/M+fnULhNg7
	nHf64cHQEH0skqw45iSoczU/2ENqjfpNyE17PD1GFpPlHLer6OMammEwGUsmt++mUJY1gs4k6n0
	w/0VN9UWlk/XQspefCwnjpF/sZ0KkUWsR963qgm0c60/l7GgqE02PQLZo=
X-Google-Smtp-Source: AGHT+IHN5IRDXPCQxt8GI8dNXJu5dcVfcVKRAYMCIujOB6MQ+W8XZhYE+J+/RQQksrJjt/5qZ2Ik02JZUPStrsU+vsA=
X-Received: by 2002:a17:907:6ea8:b0:ab7:ca9:44e4 with SMTP id
 a640c23a62f3a-abf2642afaamr474205866b.15.1740784300457; Fri, 28 Feb 2025
 15:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-7-pandoh@google.com>
 <20250131143246.000037a2@huawei.com>
In-Reply-To: <20250131143246.000037a2@huawei.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Fri, 28 Feb 2025 15:11:28 -0800
X-Gm-Features: AQ5f1JpIdsimW6Z0sg_mE2q-wwMMDLqOgdpZkyNnX7D4UZ05Hb0YHtHAFa48qak
Message-ID: <CAMC_AXW9nE-q_8qqX+1KOeYdTQVoUDovY03aPbLGZBpe9HCcWQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] PCI/AER: Add AER sysfs attributes for ratelimits
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Karolina Stolarek <karolina.stolarek@oracle.com>, 
	linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
	Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
	Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 6:33=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 14 Jan 2025 23:42:58 -0800
> Jon Pan-Doh <pandoh@google.com> wrote:
> > +
> > +These attributes show up under all the devices that are AER capable. P=
rovides
> > +configurable ratelimits of logs/irq per error type. Writing a nonzero =
value
> > +changes the number of errors (burst) allowed per 5 second window befor=
e
> > +ratelimiting. Reading gets the current ratelimits.
> > +
> > +What:                /sys/bus/pci/devices/<dev>/aer/ratelimit_cor_irq
> > +Date:                Jan 2025
> > +KernelVersion:       6.14.0
> > +Contact:     linux-pci@vger.kernel.org, pandoh@google.com
> > +Description: IRQ ratelimit for correctable errors.
>
> I would add enough info that we can understand what values to write and w=
hat
> to read to each description.  This doc didn't lead me to the comment belo=
w
> and it should have done...

Since there's a lot of commonality in the descriptions, I opted for
putting the bulk of info at the top of "PCIe AER ratelimits" section.
I believe I already wrote what should be written/read. Is there extra
specificity you are looking for?

How does this look?

PCIe AER ratelimits
-------------------

These attributes show up under all the devices that are AER capable.
They represent configurable ratelimits of logs per error type. Writing a
value changes the number of errors (burst) allowed per interval
(5 second window) before ratelimiting. Reading gets the current ratelimit
burst.

See Documentation/PCI/pcieaer-howto.rst for more info on ratelimits.

What:           /sys/bus/pci/devices/<dev>/aer/ratelimit_in_5secs_cor_log
Date:           March 2025
KernelVersion:  6.15.0
Contact:        linux-pci@vger.kernel.org, pandoh@google.com
Description:    Ratelimit burst for correctable error logs.

> > +#define aer_ratelimit_attr(name, ratelimit)                          \
> > +     static ssize_t                                                  \
> > +     name##_show(struct device *dev, struct device_attribute *attr,  \
> > +                  char *buf)                                         \
> > +{                                                                    \
> > +     struct pci_dev *pdev =3D to_pci_dev(dev);                        =
 \
> > +     return sysfs_emit(buf, "%u errors every %u seconds\n",  \
> > +                       pdev->aer_info->ratelimit.burst,              \
> > +                       pdev->aer_info->ratelimit.interval / HZ);     \
>
> Usual rule of thumb is you need a very strong reason to read something
> different from what was written to a sysfs file.

Ack. Will make read/write symmetric in v3.

> I think your interval is fixed? If so name the files so that is apparent
> and just have a count returned here.  Or if you want to future proof
> add a read only ratelimit_period_secs file that prints 5
>
> ratelimit_in_5secs_uncor_log etc.

Yes, the interval is fixed. Will update sysfs entry names to be more
specific in v3.

Thanks,
Jon

