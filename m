Return-Path: <linux-pci+bounces-23038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7146FA543B3
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 08:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B3DD16DEA7
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 07:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9431DF964;
	Thu,  6 Mar 2025 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd8VbByI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8311C8626;
	Thu,  6 Mar 2025 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741246161; cv=none; b=cVFI0CDbO+IJsQH8WIlJpNxRaLEcPlJhuWn9yNRF4f+TVa2J8Q+aF3nD3qNI/IyHK4tf44aZazMpkK8idGYjSGy5jaR5Mor2hMnRjObpRQG7+LqyIc7o2tWppYb7w+0Dx9QBBWtXVxPPyNWtfblC9v4+gR81Xp4vpTejcf8LAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741246161; c=relaxed/simple;
	bh=i7ExhBgA978RHYImcTQCeqSX0/Zh5bBRP9ci4OuuqkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYSEDZfVMbxeLi+Qpoe0JBkg8dfbTFeCuzkqXhEP/822qFtLDxF/GEoF9EBygMORjhTbWqIiMJceEjJzNA+7U8u0+028HjARzcvIAPnIKcPJwOIsxys0pJmO0ZGsZOPQtZMluaN5PnpwtSF+ZNYhoww3U8ieHcIEURLn6De2KjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd8VbByI; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523dc190f95so57154e0c.1;
        Wed, 05 Mar 2025 23:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741246159; x=1741850959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KkcPTIfTc4sfsJLkDZxF4Hju+VqKXHTeQia0r29BL4=;
        b=Xd8VbByIhyqu0gp5TcyScY9aB3ZXh14TAa1h7HHarDBIaRE7ORo/ZUoYZGtPq1PLW5
         YKY5ff/1Oy+8AJmB4jEblemOgK6OfH52oFXyR+KQlzmWAF3ThG8poRY9rC8/UanipKmq
         a+rITQxHK9Z3iMY5vTK1B6oX5ys+ehBhepXp0oNbNJCzmSKIxh/wugK+dTN5nlTDbH5S
         jM9zIYTpNLpePq4aZX83LbzSMulDtXr9ZMHSf7wqMRhd7VDouE2Jum9O/s44nXcOeSIc
         cf0w4B7ZeApssaJQ1wS/ZIsIs2Dgp+6/FC/sw0qY7QOcZPC8V7H1MDOC6FiZp2M9VqgY
         tOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741246159; x=1741850959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KkcPTIfTc4sfsJLkDZxF4Hju+VqKXHTeQia0r29BL4=;
        b=JFY1BwBteZxxb02LaTNCIrZq3Q55vs9RlrRkfTiDkH7Qoxzv8gSlkujRgEy4WHnQXW
         l9rqNiMaKfAWiiZPaKm8EwGRm4lcwx6SfSb4JOBUc6X7aegwmOCFZS2YiSQhCZ6vKi5S
         lBADTlntld7CWGv73nZysKzru8BAv6XkXJdIFlIJuuv8EGjS1ZzuNeE6+r8QSB7oOngz
         V/DuyXfxBxAYtLexRPRwrIDO67NomBm+4tyiA7V5JGj/90ky9FfqhKs8YDD/HYzmSwCm
         8msn83rM1i/BO7qQMKs9meGumQKdRq5rmOo5ItEZyPV8y587h49bZrm0MmTGqt5wxk6p
         Bhrg==
X-Forwarded-Encrypted: i=1; AJvYcCU2+i1TZKCY7COR1eX6PYKljYcBXrFmQbzvSQB7nAaOXObrPS2fdYSzJ+NbQsjCtnc+dxuw7qILVGT1@vger.kernel.org, AJvYcCV7tp2YdeFjeEUtlnDePSAfugbniMmz5Lp5kA6dC1iOdoBsHguat0850VuElLeiSuB8hU75Y7XF4LnJoz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA/w8pJCJiCCAFyOTKvmJD8W6SavfudiPgGyJX1QsoqByMX2ER
	YFuORnb+3xjkC2WJRW2UKgc4TnaO5LS7zj3jJjDsDDzR+FO7Iuf5Vzyxa14B4faQw9UMKHEHh2f
	ycyseGWr1ow39Ia+0Jzyrait/QO4=
X-Gm-Gg: ASbGncuMH3KJMU6EPDrGNFWJleitWmMYt7KjMxoQ9TDX3elk7K/7sB+4xSPxBobpQq4
	vK149MAriDdSyF1x9rVzD8TVzZWaY/7eUot67farhisYMi5wBvcyi1bSMpiyoqcb60nxjLyQh7Q
	3N5vmXS0RL19D9yv66h9NVYVsmeNKJRfsG+1CWq4GTuNv79u6fueaES3JJ
X-Google-Smtp-Source: AGHT+IE9RHUhV2i1KsMcxW3iQDyZwWP4bnXkAIg8Lfn08km3YJeQu5MWzEd+vqP6ki7AEf+017oCy4F6HuGpeAk3zE8=
X-Received: by 2002:a05:6122:2521:b0:50d:a31c:678c with SMTP id
 71dfb90a1353d-523c6114681mr3688028e0c.2.1741246158611; Wed, 05 Mar 2025
 23:29:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227043404.2452562-3-alistair@alistair23.me> <20250305200500.GA267333@bhelgaas>
In-Reply-To: <20250305200500.GA267333@bhelgaas>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 17:28:52 +1000
X-Gm-Features: AQ5f1Jq0TdzXzzPvJLrex4nos_RPb-WqnJC4TdxL-VSCnw-Jmi4cMCgm2G1I98A
Message-ID: <CAKmqyKNqYnULbtE0b3WCOe1VyEGJjo1qzeoLCedtm3mGP2K5fA@mail.gmail.com>
Subject: Re: [PATCH v16 3/4] PCI/DOE: Expose the DOE features via sysfs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alistair Francis <alistair@alistair23.me>, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, lukas@wunner.de, alex.williamson@redhat.com, 
	christian.koenig@amd.com, kch@nvidia.com, gregkh@linuxfoundation.org, 
	logang@deltatee.com, linux-kernel@vger.kernel.org, chaitanyak@nvidia.com, 
	rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 6:05=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Thu, Feb 27, 2025 at 02:34:02PM +1000, Alistair Francis wrote:
> > The PCIe 6 specification added support for the Data Object
> > Exchange (DOE).
>
> > +++ b/drivers/pci/probe.c
> > @@ -2662,6 +2662,9 @@ void pci_device_add(struct pci_dev *dev, struct p=
ci_bus *bus)
> >       WARN_ON(ret < 0);
> >
> >       pci_npem_create(dev);
> > +
> > +     ret =3D pci_doe_sysfs_init(dev);
> > +     WARN_ON(ret < 0);
>
> IIUC the "doe_features" directory is added implicitly by
> device_add_attrs() in device_add(), but the *contents* of that
> directory can't be done that way because they're dynamic, based on the
> DOE features we discovered.
>
> I see that we WARN_ON() for device_add() failure, but it doesn't
> really seem like much of an error handling strategy in either case.
> I think we'll just get a stack trace that's alarming and probably not
> useful.

I was just following the existing code.

>
> I think it might be more useful to use pci_warn() at the interesting
> places that might fail inside pci_doe_sysfs_init(), e.g., where we
> know the name of the relevant feature, and make pci_doe_sysfs_init()
> itself void.

Sure! Fixed in the next version

Alistair

