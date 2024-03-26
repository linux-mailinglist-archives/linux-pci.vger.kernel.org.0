Return-Path: <linux-pci+bounces-5140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0888B729
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 02:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B631E1F61355
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 01:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74851F16B;
	Tue, 26 Mar 2024 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mZTIafpR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9728E5A10F
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711418381; cv=none; b=jQE7bIJdsZZHz7eI1R2eBnowACtUHK70UMmqHuwgin5DjSSCOsm5iMEdPTxRiMULNVRQ57FtNXxqQWd1iDGlpSlGJpoiaHpGUiFIhw2rJclk9D+rdEahJPPfmkb221CdXTQvlZIaDvEkmF4VwqF2FWCr4qMLx2v3ntG/ICR1Hck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711418381; c=relaxed/simple;
	bh=uqqNM1zCxVTfxponKNYfYnUt9iTlR6yMECpHrzLkTYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPFt1yweYFOL4TLAx/cSNNUZ+WeBzBOJs/6PxgChDrFGn27I5l2LEOOz8K+0lXqbCIEAnMgcoc8fxj8LymL03uiKkDANaq/3rC9Zh5eAEJsBbLq+pcViTdX9KAZLneSLoL/qlKD3tYSiaSaG9YbVSQM+N7faHxvrTAXBaSjUZdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mZTIafpR; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 12E4C3F829
	for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 01:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1711418378;
	bh=Occ9TMq2LcRvlHFSuBA4b5X3bGxpRZyzouO7ghOTZqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=mZTIafpRhdMdxuGZdJej8xkahJ8Sl1euW1Uzhk2kWV/0i1SArTtRJ43waro/PGCf/
	 ps1lOVfFF6D+Icqa2zlPxi3gzAgkZojLSjBI3e3S0vgmE6oJxT2Hd/a153w421Q63x
	 fr1mQdmsGIa1kky5roJsQJruYP56so63lCz1fm/bEBP4uFGzOOhEnvHylQ8HcMDOHA
	 nik+I0tubJXBjBedQRqRCWkL0th2ojCCAf2U28QbFjJII8SJ3uCFf56HcA2W+442V3
	 bQPVE2pNhFkJR16bRQnlh6J2CBuQg/M1Des9xlzyXljTzv1pQsAMkjNaSjVQfRvvr3
	 3Kj255muoa4Yg==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29de02b98caso4150102a91.0
        for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 18:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711418376; x=1712023176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Occ9TMq2LcRvlHFSuBA4b5X3bGxpRZyzouO7ghOTZqM=;
        b=AqPDLr6/hKh8s5qwVQCSNPVaWuXZMT1z8rX7nA7dagbVnu8OuubhXY27gO17aSO7rT
         3xQhApS/Ingonz8wkra9yRXd+fy55ChrWqSu2w1omku08GcP2gWBoSO4tSmXMswsNtvU
         NZJa/J49oZMlq3LFwAnpXFotJBYzpZaLU2UFFa5b8qynYcUWSscugEsjaIpQDATLTk3C
         V8v9gmgH2/oiWVXtFu7xLEf4cl1O2dTuGfEvvY1UZ6XeXp6iC2ORhOZ0JRm8lS4rLoAt
         Lcrns4jjpPlhJ2xenMUliJr3HcosKxQCmnKCNvX9xqiraEmZIkk6QXsH3Dra0uD6jibI
         K2pw==
X-Forwarded-Encrypted: i=1; AJvYcCXLoX6JAMs4+waNQB1L9pAfuCEHE/Re0aIJkYYwpYRoWQ1TYzm196t/RlhHmuLPyvyJCweygGOnzekFhnv2J/4uFguREtqUswWn
X-Gm-Message-State: AOJu0YxC/Mu5ZyTA1HaVXXNuKALrdxUFomtlI5iZBHN8lvCkmFSJZ8+q
	0f+PpHP/aqH36i1eltoXW21ZUobIT+8e+eHxl4N3/XcChJl8v9MQv5aBq5EWEGaHUaEVZ6O7xCW
	OOi14Q7TIUpwCzipED4jU29kFiJhZDYFzyzFwfAMNHq9+cCeR+55QS+YbJ3bxVl3wu/hC4ICr46
	IAlG+deAlJTylXpzzdwKYTTPPom8wnucCxxW749tDdqVYnzbAV
X-Received: by 2002:a17:90b:2283:b0:29c:690e:1cb7 with SMTP id kx3-20020a17090b228300b0029c690e1cb7mr8107090pjb.15.1711418376524;
        Mon, 25 Mar 2024 18:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYffuiHetJ4O/oHruXWpdI8LKocfioN2Q4j33QvkZdV/hG8c7VS9oabDKzfJO5DCyGd6HDeptCbXU87TGhIgc=
X-Received: by 2002:a17:90b:2283:b0:29c:690e:1cb7 with SMTP id
 kx3-20020a17090b228300b0029c690e1cb7mr8107080pjb.15.1711418376225; Mon, 25
 Mar 2024 18:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7f37506e-4849-4c7d-b76c-27b02b7453af@intel.com>
 <20240322233637.GA1385969@bhelgaas> <20240325171743.000013e6@linux.intel.com>
In-Reply-To: <20240325171743.000013e6@linux.intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 26 Mar 2024 09:59:24 +0800
Message-ID: <CAAd53p6JmJoGjiC5nqRbA4x6fNZY5xCyGELXj0-9ux2LWVhroA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on VMD rootports
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 8:17=E2=80=AFAM Nirmal Patel
<nirmal.patel@linux.intel.com> wrote:
>
> On Fri, 22 Mar 2024 18:36:37 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> > On Fri, Mar 22, 2024 at 03:43:27PM -0700, Paul M Stillwell Jr wrote:
> > > On 3/22/2024 2:37 PM, Bjorn Helgaas wrote:
> > > > On Fri, Mar 22, 2024 at 01:57:00PM -0700, Nirmal Patel wrote:
> > > > > On Fri, 15 Mar 2024 09:29:32 +0800
> > > > > Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > > > > ...
> > > >
> > > > > > If there's an official document on intel.com, it can make
> > > > > > many things clearer and easier.
> > > > > > States what VMD does and what VMD expect OS to do can be
> > > > > > really helpful. Basically put what you wrote in an official
> > > > > > document.
> > > > >
> > > > > Thanks for the suggestion. I can certainly find official VMD
> > > > > architecture document and add that required information to
> > > > > Documentation/PCI/controller/vmd.rst. Will that be okay?
> > > >
> > > > I'd definitely be interested in whatever you can add to illuminate
> > > > these issues.
> > > >
> > > > > I also need your some help/suggestion on following alternate
> > > > > solution. We have been looking at VMD HW registers to find some
> > > > > empty registers. Cache Line Size register offset OCh is not
> > > > > being used by VMD. This is the explanation in PCI spec 5.0
> > > > > section 7.5.1.1.7: "This read-write register is implemented for
> > > > > legacy compatibility purposes but has no effect on any PCI
> > > > > Express device behavior." Can these registers be used for
> > > > > passing _OSC settings from BIOS to VMD OS driver?
> > > > >
> > > > > These 8 bits are more than enough for UEFI VMD driver to store
> > > > > all _OSC flags and VMD OS driver can read it during OS boot up.
> > > > > This will solve all of our issues.
> > > >
> > > > Interesting idea.  I think you'd have to do some work to separate
> > > > out the conventional PCI devices, where PCI_CACHE_LINE_SIZE is
> > > > still relevant, to make sure nothing breaks.  But I think we
> > > > overwrite it in some cases even for PCIe devices where it's
> > > > pointless, and it would be nice to clean that up.
> > >
> > > I think the suggestion here is to use the VMD devices Cache Line
> > > Size register, not the other PCI devices. In that case we don't
> > > have to worry about conventional PCI devices because we aren't
> > > touching them.
> >
> > Yes, but there is generic code that writes PCI_CACHE_LINE_SIZE for
> > every device in some cases.  If we wrote the VMD PCI_CACHE_LINE_SIZE,
> > it would obliterate whatever you want to pass there.
> >
> > Bjorn
> Our initial testing showed no change in value by overwrite from pci. The
> registers didn't change in Host as well as in Guest OS when some data
> was written from BIOS. I will perform more testing and also make sure
> to write every register just in case.

If the VMD hardware is designed in this way and there's an official
document states that "VMD ports should follow _OSC expect for
hotplugging" then IMO there's no need to find alternative.

Kai-Heng

> Thanks for the response.
>
> -nirmal
>

