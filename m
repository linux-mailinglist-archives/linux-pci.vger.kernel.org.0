Return-Path: <linux-pci+bounces-24476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85615A6D335
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 04:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB57D18936A8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 03:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E219613B2A9;
	Mon, 24 Mar 2025 03:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/CipjFj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEA83F9D2;
	Mon, 24 Mar 2025 03:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742785366; cv=none; b=YrxelGF8dqlr4mwZ98aDKcy4+7rQZSEislpTwZANNhBGMyJmxU+iCkB+2dAY5OPg1ckNeBKSejWqpO3ESqsYngHXvuBF4qzl1kGhZuqN7I3X6AgBGhdaU8LEAA/vw4SgKk7QwtLWAMO7fiXahsFfqWCr7mlii1D11XYDvjuxiPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742785366; c=relaxed/simple;
	bh=Jdg9Ie4tupQEDdKE6ha8cjq3LZaVT10vZJv2WgB5PaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbGrDb2EdBvKg54nlsy4wL6L5K6n5hp0CWlnW7Gj4ZPngX3zQy5HW/krFuouYBFEYBLAg5arDxN5tIpJGqsMbGBkJv1jHRPpF7VfsGs0l0/HWqWCsJuFlnMbTRmmCPB9Pfn04RQIogmenBZQiKdKQexe31QciH8Hr4/cjYNlxW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/CipjFj; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-523eb86b31aso1610674e0c.0;
        Sun, 23 Mar 2025 20:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742785364; x=1743390164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SrNXGDrwHjRsqs5k+yb+hLQTlI2OJi6KsI6anZ+wbc=;
        b=X/CipjFjmIkG+D4BMw4/G0scjqchkah2BlDyngxZ/ru2WKCFjSBVgz2iH4p9mYxYLI
         1sF8LJ0iI8+QsOhAnpuF1jaySl/9PhzYZS1WLV5+KEwLKxz0f+DREW+a5drtmjT/xXQF
         Sjl0gTYoaxhXc+5qvewdNCqkiXUU4Vdn4IzssUBXYx3O14zwXUQHqtMP7bWcv4Y1C2sz
         nMzrlPE/Xm6b2ypSI3xH6evY3JpQk6DAbflB8zOFZrOCTLjaRYFizLAuzPUA8Hv8HFzA
         PG4c0YWflMs1m60AqPJFRgPgzR0fwcjnxPqlfjVzfSU8Xt2PLRE7AWZyctSXJP8O+zYO
         vNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742785364; x=1743390164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SrNXGDrwHjRsqs5k+yb+hLQTlI2OJi6KsI6anZ+wbc=;
        b=f6W84Ed/unrLTw83bV+Xbp3b2Rt2HMtkUG5huQjovdN4KONKHG55f0vz1OlKRIGZ4g
         ngpiZ25VK+4O2oxw6wXUk0SSqeCkKa53gaRWCBd271w9i3+e78LMAHk++2i1ABuTtxXa
         jGwZ8iwd3CdpBeoipNaRtLLeVfvjblxUytOjK+Qt3QMpwDA4wHF8it1nepKUtZiNLPnV
         aIsByFgA5jQr7dcOtbjWIoURLnIYXML5nUOv95Gz6Lgh71Wr9CWINg/0Ldqo6NHo/FhD
         KbEaMy1WWe6ihLKFP85W7DjQ6EwaXHNl71LUNllfxPBshZKW45vRmbA2oX0Nr1+bYl21
         WUTg==
X-Forwarded-Encrypted: i=1; AJvYcCUg9WaD7tzmqTlTt4mWUCLvKXjIlDVvG5WRLY4gMdgrzodB3tnzI7yGhX7Oi6JBj5gVrxh8x7spvczWsDo=@vger.kernel.org, AJvYcCXDDOaxTi5B9pH2En6MDf1bEgBf1pJY59P8w+obysXSgjqkUx2ifV64N3Qfs1OcYagixI4IC75bLTwZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwPY1L0cGO/p5g8SQf+fOu6sVVYy+bsOfwA5n3qKNis+mm7KkXK
	atqyB2d3krlg+KKtFeNpSMufCLPIrYZ6sMJ9WhpjRHHMMOftIrWLYySOr9lZxM8L6xsOlLS51zq
	cEXzP3J/LaPlwqJ3gX1x/CoDRKkg=
X-Gm-Gg: ASbGncuzHnihFg6tjiwVgT3eSjObqRahYSVg1WxK8ZI1HFOVKG88Cr1U07NromQMpiq
	f6c09BEDRZz1Riy1gbAnvuVifkqy+XtYkLj3WdQg7ueT1GVwXDYiNDWhalnhKTLlkX6hZ9as5Bl
	FaIj7qVZEXi0jtLx0S3MrA1B4HWvJTK8Cz2THThSC9mp5jIxAEvncpHKOYRZli8bYyPQ==
X-Google-Smtp-Source: AGHT+IHKGpeTYLoB8DaPoFqCfjGVCWaObSzVfxqX+JuEJ+cAjPF7UyNO+06AU6tEgsrCIYRWGyRH901MaJL64KpHTeM=
X-Received: by 2002:a05:6102:54ac:b0:4c1:9526:a635 with SMTP id
 ada2fe7eead31-4c50d62702emr7645909137.17.1742785364081; Sun, 23 Mar 2025
 20:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306075211.1855177-3-alistair@alistair23.me> <20250321214158.GA1162292@bhelgaas>
In-Reply-To: <20250321214158.GA1162292@bhelgaas>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Mar 2025 13:02:17 +1000
X-Gm-Features: AQ5f1Jq_Ck5J9IXrCr1u-CLR_Nwd77YRgnErAOXE_D7wvvttijFnAvBx2vN0BUA
Message-ID: <CAKmqyKOOvE978qsWccXm5TYp2=FSg4Kc8xtk1nLd+KrhQA56Qw@mail.gmail.com>
Subject: Re: [PATCH v17 3/4] PCI/DOE: Expose the DOE features via sysfs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alistair Francis <alistair@alistair23.me>, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, lukas@wunner.de, alex.williamson@redhat.com, 
	christian.koenig@amd.com, kch@nvidia.com, gregkh@linuxfoundation.org, 
	logang@deltatee.com, linux-kernel@vger.kernel.org, chaitanyak@nvidia.com, 
	rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 7:42=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Mar 06, 2025 at 05:52:10PM +1000, Alistair Francis wrote:
> > The PCIe 6 specification added support for the Data Object
> > Exchange (DOE).
> > When DOE is supported the DOE Discovery Feature must be implemented per
> > PCIe r6.1 sec 6.30.1.1. DOE allows a requester to obtain
> > information about the other DOE features supported by the device.
>
> > +#ifdef CONFIG_SYSFS
> > +static ssize_t doe_discovery_show(struct device *dev,
> > +                               struct device_attribute *attr,
> > +                               char *buf)
> > +{
> > +     return sysfs_emit(buf, "0001:00\n");
> > +}
> > +DEVICE_ATTR_RO(doe_discovery);
>
> I think this needs:
>
>   static DEVICE_ATTR_RO(doe_discovery);
>
> Otherwise sparse complains:
>
>   $ make C=3D2 drivers/pci/doe.o
>     CHECK   scripts/mod/empty.c
>     CALL    scripts/checksyscalls.sh
>     DESCEND objtool
>     INSTALL libsubcmd_headers
>     CHECK   drivers/pci/doe.c
>   drivers/pci/doe.c:109:1: warning: symbol 'dev_attr_doe_discovery' was n=
ot declared. Should it be static?
>
>
> Right?  I added this in, so we're all set unless you think that's
> wrong.

Yeah, I think it's missing a `static`. Thanks for adding it, sorry
that I missed this in the first place

Alistair

>
> Bjorn

