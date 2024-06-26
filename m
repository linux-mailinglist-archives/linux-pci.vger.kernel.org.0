Return-Path: <linux-pci+bounces-9261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD03891770B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 06:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D43283BE0
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 04:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06243132139;
	Wed, 26 Jun 2024 03:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjNWlrY2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAD86AB8;
	Wed, 26 Jun 2024 03:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719374383; cv=none; b=kJcFOjSAIqBo0zfYDAXnitOVTVvqhquh7JorCWmWGrkhDauF2EbqEE2DQvwstaG6H1czgBrFZbuswF3A//7M0LPcbIvolccJoMayWTZUc7wEoDXMGFf1JnxFaWAjLuupH9MHWCnHut+OaxJMUyXNHBjKbINWFsFGCJZ2Q/Bd9xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719374383; c=relaxed/simple;
	bh=dpPCOC/uMGPKJTsqabOcLfFY25EY8q43sNHC3HD4sAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPbyIc+cSC6EXcqBF1klKoevIbyTYyGaNwDxxx/ppyHs1YqzvID4Ky/BjL+ZjGhAXVPKFSQp58w+H5ufUvWyAjeyirJjOTObtzRGqzJwJfwGt9X9jgQ85fN3RQ8CeIDBPK2y1jOURHVdLwRl+idDC/w2lzxwYnWxijkAkXf+qk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjNWlrY2; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4ef65ff63b4so90687e0c.0;
        Tue, 25 Jun 2024 20:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719374381; x=1719979181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fu5E10rtFHOxjPeBNIUOZwvJ+moAJTWkDhiyt0qGItg=;
        b=RjNWlrY2UdWLCKF9rB5gnQ0M27Xq9MTaYUADzJdknIAzCQ1Ery4+RvJtRaQxTqevH6
         9TUoPYGnmpuvlmtyKvPWoXzlZxBLc8NzVX22ooRjtKbLQi+omWgaEgiYcLtwP5Gr2m1k
         1oC53I3+9zdsVPuUy/gaTN32zZ4rsus+V7oA3muHNKg2Q45bjixTVHks+nOa2JyQpYBc
         Lrd98VnlowpQXgpxzq9qQ8BA8sM6FrSe9nr+dXkHJMBV8m1S6vtMNQtjBwn+EmMItIEo
         lINH1dCU0OWLO3pPQZjg2BNV9C+XYMcFcTMWDYa/YAyw1IAl7TenXGc4WVl+xzO2v2Ak
         yzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719374381; x=1719979181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fu5E10rtFHOxjPeBNIUOZwvJ+moAJTWkDhiyt0qGItg=;
        b=kvlUbycu8D3SBtDv8c/1OwG/jEj6xei/IfnLBCs+cgMEN1zraE+/6ZgySHMs2+OrjU
         vW/8bKEh6AdxHiGInVDq0kHfq6aGRb2zGVu0XU673ozxvIXz1SlttxlvHcO96rhzqyRP
         rmTg7LS3mbWhnht0Qj/SctulAdj12I/DYaTVPGHvPdfwEllh+ilNjKdzJLnmRaUfPYuF
         Qn8PuiooSx2NLsJGODvDpTObv23wvS3y7EVe/3eLbTmhW//h6kInDDm7VEFb0AEiiXP+
         NgGcKjtdB+oSjt6Xi+uxmemo400fh52zUL2Y6Ttxvol8vbEvPmDYyEwbnTJCS5qyisIU
         eJoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOI2TSAsXb/7W+WWKbH/9PgptJoPErnCezx6qd2hz8kdKXDbqddTg9qEN4lvE4J/FBhorysW/pYnBksXspqEmXliwV2gBivbZbSKMX791eE4NQt7m9+r+Ntui/jl2FJPcwRmoKmlRI
X-Gm-Message-State: AOJu0YwGx+0q2rv2wmjEl5VpALldf3DzHm6OTYTpVBtRURreIYqPFN9I
	MqPznalKh0x5v5zVCYDqYMqEy1btGAd2leCVQhrAFR/F/hShEqVlv2hQNYzhv1N2eP3lrWT7xQk
	OmyMpNSiLzah9hiTcHc49FCWjDCc=
X-Google-Smtp-Source: AGHT+IFAcKe+Q5gwexS4w0DISF+HeiNP5m1+3zt+e1ZM3VGUVj3KuYNPIYV9QIvYYv9jP4w1OK7DwKOp9F2Ag02tmRM=
X-Received: by 2002:ac5:cb46:0:b0:4ef:8574:ce18 with SMTP id
 71dfb90a1353d-4ef8574cef7mr5137309e0c.6.1719374380983; Tue, 25 Jun 2024
 20:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614001244.925401-1-alistair.francis@wdc.com>
 <20240614001244.925401-3-alistair.francis@wdc.com> <20240614095924.00004eb5@Huawei.com>
In-Reply-To: <20240614095924.00004eb5@Huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 13:59:14 +1000
Message-ID: <CAKmqyKN+e-cPP+PGQGAZStrBrXt8wPzfCD49wDq6o9cV_TgMuw@mail.gmail.com>
Subject: Re: [PATCH v11 3/4] PCI/DOE: Expose the DOE features via sysfs
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de, 
	alex.williamson@redhat.com, christian.koenig@amd.com, kch@nvidia.com, 
	gregkh@linuxfoundation.org, logang@deltatee.com, linux-kernel@vger.kernel.org, 
	chaitanyak@nvidia.com, rdunlap@infradead.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 6:59=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 14 Jun 2024 10:12:43 +1000
> Alistair Francis <alistair23@gmail.com> wrote:
>
> > The PCIe 6 specification added support for the Data Object
> > Exchange (DOE).
> > When DOE is supported the DOE Discovery Feature must be implemented per
> > PCIe r6.1 sec 6.30.1.1. The protocol allows a requester to obtain
> > information about the other DOE features supported by the device.
> >
> > The kernel is already querying the DOE features supported and cacheing
> > the values. Expose the values in sysfs to allow user space to
> > determine which DOE features are supported by the PCIe device.
> >
> > By exposing the information to userspace tools like lspci can relay the
> > information to users. By listing all of the supported features we can
> > allow userspace to parse the list, which might include
> > vendor specific features as well as yet to be supported features.
> >
> > As the DOE Discovery feature must always be supported we treat it as a
> > special named attribute case. This allows the usual PCI attribute_group
> > handling to correctly create the doe_features directory when registerin=
g
> > pci_doe_sysfs_group (otherwise it doesn't and sysfs_add_file_to_group()
> > will seg fault).
> >
> > After this patch is supported you can see something like this when
> > attaching a DOE device
> >
> > $ ls /sys/devices/pci0000:00/0000:00:02.0//doe*
> > 0001:01        0001:02        doe_discovery
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Hi Alistair,
>
> One question inline.  Feels like I'm either missing something or
> the code has evolved in a fashion that left us with a pointless check
> on attr visibility.

It's the second :)

>
> Jonathan
>
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index defc4be81bd4..9858b709c020 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
>
> > +static umode_t pci_doe_features_sysfs_attr_visible(struct kobject *kob=
j,
> > +                                                struct attribute *a, i=
nt n)
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
> > +     struct pci_doe_mb *doe_mb;
> > +     unsigned long index, j;
> > +     unsigned long vid, type;
> > +     void *entry;
> > +
> > +     xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> > +             xa_for_each(&doe_mb->feats, j, entry) {
>
> I'm confused.  What is the intent here?

I feel like this was required at some point, but you are right, it
doesn't seem useful now

>
> Given every DOE should have the discovery entry any call of this function
> that actually finds a DOE should return a->mode, so why search the
> actual entries?
>
> Given absence of the files anyway (due to the directory visible checks)
> if there are no DOEs, why not drop this function completely?

Done!

Alistair

>
> > +                     vid =3D xa_to_value(entry) >> 8;
> > +                     type =3D xa_to_value(entry) & 0xFF;
> > +
> > +                     if (vid =3D=3D 0x01 && type =3D=3D 0x00) {
> > +                             /*
> > +                              * This is the DOE discovery protocol
> > +                              * Every DOE instance must support this, =
so we
> > +                              * give it a useful name.
> > +                              */
> > +                             return a->mode;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
>
>
>

