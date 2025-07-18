Return-Path: <linux-pci+bounces-32541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9431AB0A885
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 18:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0531C46D3D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521BB2E6D06;
	Fri, 18 Jul 2025 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3D9Ba47"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA80F1DED53;
	Fri, 18 Jul 2025 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856531; cv=none; b=i9bnUxyo9GF5folLFEiCgd84Y0YAZJHTgggp/R13J29QrsSjSY+Gg3GVVhSMSb3+zbGtycp3ZTl1ci9ZrHzJXUmHCaAfI1BwlCIwTbGX7IkDTEEXJ0jKWfBf79M7ucWLSwR7PMsXymKt4XO9bSfggeXb70BGZuZVu9HJH30hxsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856531; c=relaxed/simple;
	bh=UDmAfnjy8pkg9BvFAmQ9gslBsr+Ob5O2A4EwZnWz7Bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQKrDbA0V4OixlCmjlLCDodrkC68yes4a8mESkz6JaYyfoeXkf3KGPm5uBK3sS8EGmG1ok6OMfhry45G1Ba0c6lvED4Kfk51kD1LPfht3m5spcJDAz6NZJg1UUMTMFNJMb/fXrvhO2pdWGRbt7ObLHuR3tI804oo41JlYH9io8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3D9Ba47; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2e9a38d2a3aso2125862fac.3;
        Fri, 18 Jul 2025 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752856529; x=1753461329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5fMBTsrhrDDK6xtK7LtgX4Zw2zx9+Mn87A7RF2ITBk=;
        b=K3D9Ba47ZcRHqFv5hoBf/PZyk2IqUflpJIzmbJtLXy7V86gDdLIigOoXdLcUL+S2kT
         Sz0B7NEezbaMf9/+ax4rikbIAdyJagRutel0FSmH8g6hCA2lBDfjQlnjMMyyBB+ra2L4
         2B8J5KOGz3QeYo29QxrBcZbTtAGDst9zT/gZ9XAwq/nYLUYzvIKYeqAFl1m4k1jp40V/
         NRh78rxqo5hiZ7pHLjfors9yhUpf96qHuiwc8J00Iu70Ul4j+SXpMSo2pXuOJka259ZF
         KNrEewVOXXBDCIiAJj0ibrczdIo1KajANAav6L5JEjtOS9gx6LJVqGxwkL9swRV9xXyk
         vsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752856529; x=1753461329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5fMBTsrhrDDK6xtK7LtgX4Zw2zx9+Mn87A7RF2ITBk=;
        b=up4HuyILC9rmLB38TdVgmcZLs8xZ2OQbifCSxnmZlC6lLpGYTqEB7OmHmRU1+YYxwT
         bva3jcgSXuHCS9b21Htu0XqPKaE4RAISnSPE12P+YHWSkZ2uWAszxUL6+EWtI6Xuhp5n
         jXfEseS/V79eFQ28KuASuYkQyBkc1/84WwHEMO+jlWforcX+CKIOp+DUvfH+Im67QJfN
         gDpFIKroRRNLEQylearjK5V5NpO2T59cqOdE8vr+/Pu0p4AE4kbnGjD8/Uv8sCJDTmKr
         qmkkLDmUHLP6KToL4/HO1hkVXf1wn6tBe77PYFm12M36mF+xkosZRyOL7z0JIeiFD0z+
         GZsA==
X-Forwarded-Encrypted: i=1; AJvYcCUvKxHpA4/DEVkKkNb/thg5+B3UhpKx/p00OoZ7yr5kylldgrbDwd5v/QQkrbWvUawfOb653PGWXLx+@vger.kernel.org, AJvYcCWglKENiuUXuB/ziEcbhbPLKfxzNZ5SByaK7sIN/NwOXHzUZe20LEE1E92uY/71O+fJ2xll7T+HKCjXJwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHXb1/X28fxaO+u/NxonvGBnKD4hQGW3rWaF0zaw6DCtldp828
	9lHeM3xMyjmsb44EV14jhu0YhAd7k+VqHe2V6MR2BmVCNJyS26bbrYAA44a9c5sy4HdPXDYVx8S
	ptemQUIy+Q1kKMPY1NXvlqDkSUwR9GZeP2w==
X-Gm-Gg: ASbGnctBL1o2Han0w6gchtwbvoL+t8t7mZbdJCoL+Ij0AJdt7TJk3wau+g9uTxPo8sj
	wBQgq3bdxQNb3dLvB5PO3Piw4CcbICBd2SVcyoLSrwwvvetSWj6Y8XPfzmn3eYSapocrtEShH6E
	zIi+Qu7WlHyypt6IIfrB35laYPKdgRx3yq3YzEJtSAAA/PmJ3+V8Dr/FBS61sG4IZEODOWtfzIi
	fxSobqLC5UaA1+x/Ie9KaA=
X-Google-Smtp-Source: AGHT+IELLiAsxvKTUzSoPTZZRRusNn9I6JdMO0/hSrsDIrFm2f2dPHV082nEnE44/odp5xiA8nVTltUi6hVD+2JPvo8=
X-Received: by 2002:ac8:5a91:0:b0:4ab:9551:476 with SMTP id
 d75a77b69052e-4abbf5574d4mr7492541cf.53.1752856040946; Fri, 18 Jul 2025
 09:27:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717165056.562728-1-thepacketgeek@gmail.com>
 <20250717165056.562728-2-thepacketgeek@gmail.com> <20250718113611.00003c78@huawei.com>
 <20250718125935-75fa0343-af78-42be-bc3f-e8f806a4aee5@linutronix.de>
In-Reply-To: <20250718125935-75fa0343-af78-42be-bc3f-e8f806a4aee5@linutronix.de>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Fri, 18 Jul 2025 09:27:10 -0700
X-Gm-Features: Ac12FXzeo9T-VEnjAi37swPr2fGHGP7zpQWlL-WrRlJfLia2ykFnSljiRcOLxgI
Message-ID: <CADvopvapHnuxztum4fPsZU5h3=977Y=h6xOVhyWfKU8tQ0wxeQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] PCI/sysfs: Expose PCIe device serial number
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Mario Limonciello <superm1@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:02=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Fri, Jul 18, 2025 at 11:36:11AM +0100, Jonathan Cameron wrote:
> > On Thu, 17 Jul 2025 09:50:54 -0700
> > Matthew Wood <thepacketgeek@gmail.com> wrote:
>
> (...)
>
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 268c69daa4d5..bc0e0add15d1 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -239,6 +239,22 @@ static ssize_t current_link_width_show(struct de=
vice *dev,
> > >  }
> > >  static DEVICE_ATTR_RO(current_link_width);
> > >
> > > +static ssize_t serial_number_show(struct device *dev,
> > > +                                  struct device_attribute *attr, cha=
r *buf)
> > > +{
> > > +   struct pci_dev *pci_dev =3D to_pci_dev(dev);
> > > +   u64 dsn;
> > > +
> > > +   dsn =3D pci_get_dsn(pci_dev);
> > > +   if (!dsn)
> > > +           return -EIO;
> > > +
> > > +   return sysfs_emit(buf, "%02llx-%02llx-%02llx-%02llx-%02llx-%02llx=
-%02llx-%02llx\n",
> > > +           dsn >> 56, (dsn >> 48) & 0xff, (dsn >> 40) & 0xff, (dsn >=
> 32) & 0xff,
> > > +           (dsn >> 24) & 0xff, (dsn >> 16) & 0xff, (dsn >> 8) & 0xff=
, dsn & 0xff);
> >
> > I wonder if doing the following i too esoteric. Eyeballing those shifts=
 is painful.
> >
> >       u8 bytewise[8]; /* naming hard... */
> >
> >       put_unaligned_u64(dsn, bytewise);
> >
> >       return sysfs_emit(buf, "%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x\n=
",
> >               bytewise[0], bytewise[1], bytewise[2], bytewise[3],
> >               bytewise[4], bytewise[5], bytewise[6], bytewise[7]);
>
> This looks endianess-unsafe.
>
> Maybe just do what some drivers are doing:
>
>         u8 bytes[8];
>
>         put_unaligned_be64(dsn, bytes);
>
>         return sysfs_emit(buf, "%8phD");

Thank you both for your continued review! That reads much nicer, I
should've known to look at how others were doing this formatting. I'll
have a new patch later today.

