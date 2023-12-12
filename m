Return-Path: <linux-pci+bounces-783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FB680E2B0
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 04:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3DB28247E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 03:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D17465;
	Tue, 12 Dec 2023 03:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="AvFjeO5+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03CDD1
	for <linux-pci@vger.kernel.org>; Mon, 11 Dec 2023 19:21:10 -0800 (PST)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A49893F20F
	for <linux-pci@vger.kernel.org>; Tue, 12 Dec 2023 03:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702351267;
	bh=SHTIpb4Hzm6jrSJs4/Qi7PyXvXDjK+GVk8SC59Pfu5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=AvFjeO5+qRCbJ2WQFMfmWb9ZzF57g8jafupeGtKUzT0wPCnbpUSYUR7ywA7S6zARi
	 n1pIDiSPAq7/5gqCePSU2j1KRsR9w4z6saJtro4KjEhFxRacEei4p13NhcWZf+7JLn
	 plc29uEVMw7KSWRga+J53eUu8HS0NtUWXOgg4zBI3ufuzj1mdQym7j2PwoLcEEobOL
	 a/J02G7rKr2gZWJFsyR65QhL9LPzfwtqmXE72xzJuIQanuO8MOtyfPh57+7A15VNAU
	 pGG2RH/OVe6lC+jJcSo2xsGWyD0mN8PQwGStY9GWh6QalkGvPb+rC0OpTbzE4f8OvU
	 cBcaewMXfhQVg==
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b9e053babcso7860736b6e.0
        for <linux-pci@vger.kernel.org>; Mon, 11 Dec 2023 19:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702351265; x=1702956065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHTIpb4Hzm6jrSJs4/Qi7PyXvXDjK+GVk8SC59Pfu5I=;
        b=eUwGAyzauZk16zmkXB4y6vZFcrvBSFd4EBrCllPNYK/3sm+bjg7KiOAk/c5t4v/p3Y
         vt8NqoFz9W2xB7VBHW+OWVkxFemSyTqGzpZ487jTFmPTuM3CfgOmj9wFvcfJmzOYKace
         5wd96egudHhX7AQIJxV3eQXh9Ehu1O8Kzya1GG0cI+oSrcrZ65I0NNZ0+7mtLqkJW/cr
         ItpTbiUAs644+Bc4eJc7l7VMI4WSsrSoEJ8zH0fBKkF8TkOjp8Hu8QJ1Cnyg/sDvIjhg
         DTbS7zZqytDp4NV5VdPLYQzZo9Kcl8LRG1bGr3bRi44YNiRu0LkIx26PbhiBc5SQXlWl
         uPqg==
X-Gm-Message-State: AOJu0YzrPV/QBLxdadJw7lVL7tKWBzv1FRZDaMjnPl71ITfdToAIeIsz
	DmZzFZZDP15exOQbC/jIOdfs6CM6rW1ieNBDF3nmel6AOitWHOmfyIquAS5EHo4Sd0Vk9Lxm+wN
	xBrSQwVaPGudHRcwbuWIChrKnNjhiecOvdViDFYkSpGDa5EChMnaiPg==
X-Received: by 2002:a05:6359:223:b0:170:6c3b:4f7b with SMTP id ej35-20020a056359022300b001706c3b4f7bmr6259653rwb.20.1702351265181;
        Mon, 11 Dec 2023 19:21:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJkcK6dzzraSMX4jvvFw1tM7Wrc9nfCJp3QnJbxDgPdG/I0O3J/3V+9sad/XvCkAUlYZ+qdEg06okAtdma35A=
X-Received: by 2002:a05:6359:223:b0:170:6c3b:4f7b with SMTP id
 ej35-20020a056359022300b001706c3b4f7bmr6259636rwb.20.1702351264777; Mon, 11
 Dec 2023 19:21:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206163026.GA716688@bhelgaas> <afacb1fc1ac204a786260f64de83e220d453b410.camel@linux.intel.com>
In-Reply-To: <afacb1fc1ac204a786260f64de83e220d453b410.camel@linux.intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Tue, 12 Dec 2023 11:20:52 +0800
Message-ID: <CAAd53p6VXAQeVdVjWEafcGo3LOePGE3C8yT+Swo=e_BvOZ-EMQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD rootports
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, orden.e.smith@intel.com, 
	samruddh.dhope@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Grant Grundler <grundler@chromium.org>, Rajat Khandelwal <rajat.khandelwal@linux.intel.com>, 
	Rajat Jain <rajatja@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nirmal,

On Tue, Dec 12, 2023 at 7:13=E2=80=AFAM Nirmal Patel
<nirmal.patel@linux.intel.com> wrote:
>
> On Wed, 2023-12-06 at 10:30 -0600, Bjorn Helgaas wrote:
> > [+cc Grant, Rajat, Rajat]
> >
> > On Wed, Dec 06, 2023 at 10:18:56AM +0800, Kai-Heng Feng wrote:
> > > On Wed, Nov 15, 2023 at 5:00=E2=80=AFAM Nirmal Patel <
> > > nirmal.patel@linux.intel.com> wrote:
> > > > On Wed, 2023-11-08 at 16:49 +0200, Kai-Heng Feng wrote:
> > > > > On Wed, Nov 8, 2023 at 12:30=E2=80=AFAM Bjorn Helgaas <
> > > > > helgaas@kernel.org> wrote:
> > > ...
> > > > > > I assume you mean to revert 04b12ef163d1 ("PCI: vmd: Honor
> > > > > > ACPI _OSC on PCIe features").  That appeared in v5.17, and it
> > > > > > fixed (or at least prevented) an AER message flood.  We can't
> > > > > > simply revert 04b12ef163d1 unless we first prevent that AER
> > > > > > message flood in another way.
> > > > >
> > > > > The error is "correctable".  Does masking all correctable AER
> > > > > error by default make any sense? And add a sysfs knob to make
> > > > > it
> > > > > optional.
> > > >
> > > > I assume sysfs knob requires driver reload. right? Can you send a
> > > > patch?
> > >
> > > What I mean is to mask Correctable Errors by default on *all*
> > > rootports, and create a new sysfs knob to let user decide if
> > > Correctable Errors should be unmasked.
> >
> > I don't think we should mask Correctable Errors by default.  Even
> > though they've been corrected by hardware and no software action is
> > required, I think these errors are valuable signals about Link
> > integrity.
> >
> > I think rate-limiting and/or reporting on the *frequency* of
> > Correctable Errors would make a lot of sense.  We had some work
> > toward
> > this recently, but it hasn't quite gotten finished yet.
> >
> > The most recent work I'm aware of is this:
> > https://lore.kernel.org/r/20230606035442.2886343-1-grundler@chromium.or=
g
>
> Hi Kai-Heng, Bjorn,
>
> I believe the rate limit will not alone fix the issue rather will act
> as a work around. Without 04b12ef163d1, the VMD driver is not aware of
> OS native AER support setting, then we will see AER flooding issue
> which is a bug in VMD driver since it will always enable the AER.

Agree. Rate limiting doesn't stop the AER interrupt, so it won't flood
the kernel message but will still hog CPU time.

Kai-Heng

> There is a setting in BIOS that allows us to enable OS native AER
> support on the platform. This setting is located in EDK Menu ->
> Platform configuration -> system event log -> IIO error enabling -> OS
> native AER support. I have verified that the above BIOS setting alters
> the native AER flag of _OSC. We can also verify it on Kai-Heng's
> system.
>
> I believe instead of going in the direction of rate limit, vmd driver
> should honor OS native AER support setting.
>
> Do you have any suggestion on this?
>
> nirmal
> >
> > Bjorn
>

