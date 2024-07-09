Return-Path: <linux-pci+bounces-9970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3041592AD3F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 02:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA890282350
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 00:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15061EA80;
	Tue,  9 Jul 2024 00:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwYc0puv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED110FA;
	Tue,  9 Jul 2024 00:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720486256; cv=none; b=lfzpIKwmcvmE9WXDqQVhDZ9ZLkVFnzpOjgoZ9Loe3d6M52/4Eiuy+QUQC1+fOXZqn68nh17XhFDbcMvsnQMWul/ofOaIE9c/enzaGRgK4uG28SigNjlDtgKoVFbUbDcWlKxQUurWGxQz+4rFmulWl8CEu5IaHr2FRFCRSc+bA/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720486256; c=relaxed/simple;
	bh=BdXpEabngZDyg/iduns/YDXTEYzjjdakPHcMyl7lzlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amBmHJWKdI9ghFyF+23ZeWcr2NCkKfJCZlIGLB/PsGNSTf+NVhd3yCtdoLxut8CTBkeuReKeuIwMNQQH69KJg4tppMu+DXjcFyTIoXzEKSGaNC7ywi5dIceqL0JmA5wKBYwP/j9ovn452+EnwgLkl6luglBLYVq1+lnVeJ23Llg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwYc0puv; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48fe76c0180so1523297137.1;
        Mon, 08 Jul 2024 17:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720486250; x=1721091050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGCm7ULkHrxj85VKoDXAjcmHZHESjN0FxE0aujX1liU=;
        b=bwYc0puvP1MjnrwUV+NBpBYnizLM1WCMhkGAitm46e7O94TjgHCjqM9nOdPxxwLu73
         OSlqAUpPnjh8uBaiLREcNXd/8lEd0xqPnnQJb1hs2BGAtGA/bPeVOVRzn9W3Lk68QUWT
         GYB8wIc3sn4VOdUKiEjIF34OY0Xnl89ujY552l2oMJfE/wQyf/wLA+dAWOZjl2V8zopd
         2+FQ21aPJpM4mGjacHfay7sRQh7eueQoEqgzwcywgvL7oVYZeFBtTCWTPKNZxEfF7Lyu
         MrWt37oqlpxvljkT+awkl/CsYPFJJx6VEClPMIqLaz5M+KYJhxsnoYLtwiWnlm++WiqW
         uH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720486250; x=1721091050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGCm7ULkHrxj85VKoDXAjcmHZHESjN0FxE0aujX1liU=;
        b=AmAPJ2P0xSYaaRfUfcCfnvFbCCOnvkKOVRCRkmP6d0/rQJXXa6EW2som1zH+Gtiz8Y
         D0i0LEAhenqFveEeceTmZF5EBn9PUbe8TL4/xTlL1pyg1bgqLk7ZWP8fh9EMoUYm2/xu
         kK0NjNecFCPUW4VU3Rxk+UlJghWdU7rV2kCGMnSc51ymTLS4z2uBxl9MNJnZJV8J8Wba
         UrV7zS5ueRmjoyHNWQo7EMcXZ08gRpJGbHj9mI+8WVvPKVRkBijzZGT6QLIN7uMRZVwS
         gECGd2FpHXUpYxRwYZWqDtvuMgAjodml1x+BjDZ3wmsHP3yiRSpNbZfMGenwNWUNC8vn
         jqcA==
X-Forwarded-Encrypted: i=1; AJvYcCUJfXN7pultl9S4ROlLlbSe0XwZkKR1xQsRlirq94OCItOlMNUf6o/QluiUK/9LHCMeppMm3T+NxHbsFRrF0Nv0r1EnlYiI7p9IQiuwoAoQ0NKYH9Mb61LqEtStrXOVRNlV9kNrvp+O
X-Gm-Message-State: AOJu0YzEX7wzdZuNIjsQ49iXFfqYy3utqCNeEvUNhvdfO7LhgDSf6rFE
	0NN2JRKYUTPS2aPRryYS0SSaOuat3c22gtsvHgBHkfXkjiRykvGTy3hOd5N9FvM7GDuW/J2bJlt
	FF3CMDILjVKaQhkNDYa+K5NzyTP8=
X-Google-Smtp-Source: AGHT+IFXBIwiAdVJ2BbfSrFesf65v19ToW/by4CvTTpI4KW4/C2pWNEGAbprVYqYhVYM+Wxo7ApbBEdYo7ePOAaMkBI=
X-Received: by 2002:a05:6102:c13:b0:48f:e62f:8863 with SMTP id
 ada2fe7eead31-49032153e82mr1287941137.2.1720486250168; Mon, 08 Jul 2024
 17:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702060418.387500-1-alistair.francis@wdc.com>
 <20240702060418.387500-3-alistair.francis@wdc.com> <20240702145806.0000669b@Huawei.com>
 <CAKmqyKPEX632ywm5DiKvVZU=hr-yHNBJ=tcN2DasKpfWdykgZg@mail.gmail.com>
 <20240705112953.00007303@Huawei.com> <20240708005533.GC586698@rocinante>
In-Reply-To: <20240708005533.GC586698@rocinante>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 9 Jul 2024 10:50:24 +1000
Message-ID: <CAKmqyKOa2nf1yRuZ_zpkH422JRkoHi2cC0Yq8RnNap6Meu80Uw@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] PCI/DOE: Expose the DOE features via sysfs
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, lukas@wunner.de, alex.williamson@redhat.com, 
	christian.koenig@amd.com, kch@nvidia.com, gregkh@linuxfoundation.org, 
	logang@deltatee.com, linux-kernel@vger.kernel.org, chaitanyak@nvidia.com, 
	rdunlap@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 10:55=E2=80=AFAM Krzysztof Wilczy=C5=84ski <kw@linux=
.com> wrote:
>
> Hello,
>
> > > Any input from a PCI maintainer here?
>
> Something that I am curious about: can we make this a single file with a
> bitmask inside that denotes what DOE features are enabled?  Would this be
> approach be even feasible here?

In theory there can be any vendor ID (16-bits but not 0xFFFF) and any
feature (8-bits). So there is a huge possibility of values here.

>
> Thoughts?  Or is it too late to think about this now?

It's just too many possible options to use a bitmask. I guess we could
use a feature bit mask per vendor if people feel strongly

>
> > > There are basically two approaches.
> > >
> > >  1. We can have a pci_doe_sysfs_init() function that is called where
> > > we dynamically add the entries, like in v12
> > >  2. We can go down the dev->groups and device_add() path, like this
> > > patch and discussed at
> > > https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/
> > >
> > > For the second we will have to create a global pci_doe_sysfs_group
> > > that contains all possible DOE entries on the system and then have th=
e
> > > show functions determine if they should be displayed for that device.
> > >
> > > Everytime we call pci_doe_init() we can check for any missing entries
> > > in pci_doe_sysfs_group.attrs and then realloc
> > > pci_doe_sysfs_group.attrs to add them.
> > > Untested, but that should work
> > > even for hot-plugged devices. pci_doe_sysfs_group.attrs would just
> > > grow forever though as I don't think we have an easy way to deallocat=
e
> > > anything as we aren't sure if we are the only entry.
> >
> > I think this needs to be per device, not global and you'll have to manu=
ally
> > do the group visibility magic rather than using the macros.
>
> Lukas proposes a very interesting feature of kernfs recently per:
>
>   https://lore.kernel.org/linux-pci/16490618cbde91b5aac04873c39c8fb7666ff=
686.1719771133.git.lukas@wunner.de
>
> Would this help with DOE features?

That was the previous approach used here:
https://lore.kernel.org/linux-pci/20240626045926.680380-3-alistair.francis@=
wdc.com/

Bjorn wanted to try and avoid using a function pci_doe_sysfs_init()
[1], which is what I tried here. It sounds like the v12 approach is
the way to go then. I'll send a v14 based on v12 with the comments
addressed

1: https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/

Alistair

>
>         Krzysztof

