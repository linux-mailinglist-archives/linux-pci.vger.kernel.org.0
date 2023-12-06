Return-Path: <linux-pci+bounces-538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB04F8064E4
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 03:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C1F1C2110C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 02:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51D353B8;
	Wed,  6 Dec 2023 02:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Fk6GVZNu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81A218D
	for <linux-pci@vger.kernel.org>; Tue,  5 Dec 2023 18:19:10 -0800 (PST)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 393F93F65A
	for <linux-pci@vger.kernel.org>; Wed,  6 Dec 2023 02:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1701829149;
	bh=+zuYEp3yff8WWzahjssd0iIp8sW0Emgd+VXlxZsGd9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Fk6GVZNu8ZCCm/s1ZmB1jPbCB+TxaINqOa+jCcZDrAdGnXgubVJh5CZR35wkVbFrU
	 8/XXxmXguu0oNBkmmdX/r726Xj8iaK/tXadwFFU2NOVPS6YXHi35kS19xCMT6bccWd
	 Bwum8Nb0v2zkaRCSZqcbFGlYqN/wd4+BQulrcqbrJADLuWg9fRtcPsbPt5lzYwDVk1
	 8jFgXlCXD6V04br6M6bhzHpZOtsSc8hN2w0udffkty0P3Z4F0y2iAFc+m3e5jbLx3i
	 CQKKXRRsUKS7d+XVMxBuee6BcEu1BugMsEupdweZvnMpX13wCN06JMBYaE2w9isLYd
	 Mk4ROyMT/bDZg==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5c6245bc7caso2866257a12.3
        for <linux-pci@vger.kernel.org>; Tue, 05 Dec 2023 18:19:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701829148; x=1702433948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zuYEp3yff8WWzahjssd0iIp8sW0Emgd+VXlxZsGd9g=;
        b=SBSS8JzykJ7OH0Dkfn5mB2nSxUhL747SUdUucJ3rw99zOZrttUt1aFbZkPsAzlBdGX
         S5c2W7RzWDxTWxh7Ht08d9mtST4WSYkdgTlwGq+ApjubMO95UPdVIgRCSNr8uR5cmPnt
         HA7XAjEVRhHjyVe/mN08EGpV/zqin2BHgzh5c8fH6DCfXTN7Ok4gbi7WY18OlsKOxmxi
         R6AmFCeE9nFx9ZF0BfBwGr8PGK34FFi58B95sAsearpHJb1GCB4zV+jM1AmfUop9mw2S
         71lxBcRoEh5Lw3KFe0e8aVYbJ3cLf/0/cNrzTrctLgnfEtR/CPLFcn6DjFr68GQ9U4Vj
         mmIw==
X-Gm-Message-State: AOJu0YzasEFfaZV7J24C7GXkC8ujefK3RWK7SuGkVC62nbtxPrJi5YQi
	I3U/HogfXXCEYFPojtEG8jnWxNKv40cdcOLVxLOEaIrkHsucSrALf5Gnuj024mAiLrNFwwL5um4
	MqGFHchQpXIbmEjHCRMdJUAEDjYs90/Fu0oOcDwXyTKSQt1M2IbxbdQ==
X-Received: by 2002:a05:6a20:670a:b0:18f:1a27:11dd with SMTP id q10-20020a056a20670a00b0018f1a2711ddmr101564pzh.92.1701829147844;
        Tue, 05 Dec 2023 18:19:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7F7ftL4ijkAw3Pon4mlBhWf9qrJLbHLsv7vjCQAEDv9gChPxs2wd+UC8bxCmX4ecpXdEN7S2cRy7gKFYshrs=
X-Received: by 2002:a05:6a20:670a:b0:18f:1a27:11dd with SMTP id
 q10-20020a056a20670a00b0018f1a2711ddmr101558pzh.92.1701829147549; Tue, 05 Dec
 2023 18:19:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a623e811037972c7cdf1fe05fcb7ace2b445a323.camel@linux.intel.com>
 <20231107223037.GA303668@bhelgaas> <CAAd53p5CqviDy-Y3FxO2sP2-q+LjHzDOe6x6upuw+V5Jh3k0uQ@mail.gmail.com>
 <cf8ce69c8cc0a23609f747464ee3c03147088c57.camel@linux.intel.com>
In-Reply-To: <cf8ce69c8cc0a23609f747464ee3c03147088c57.camel@linux.intel.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 6 Dec 2023 10:18:56 +0800
Message-ID: <CAAd53p5+x44XLLXYDKceZrgO0z-bCbFPqwR1Qw6Esjv+dUjh2w@mail.gmail.com>
Subject: Re: [PATCH] PCI: vmd: Enable Hotplug based on BIOS setting on VMD rootports
To: Nirmal Patel <nirmal.patel@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, orden.e.smith@intel.com, 
	samruddh.dhope@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nirmal,

On Wed, Nov 15, 2023 at 5:00=E2=80=AFAM Nirmal Patel
<nirmal.patel@linux.intel.com> wrote:
>
> On Wed, 2023-11-08 at 16:49 +0200, Kai-Heng Feng wrote:
> > On Wed, Nov 8, 2023 at 12:30=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.o=
rg>
> > wrote:
> > > [+cc Rafael, just FYI re 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC
> > > on PCIe features")]
> > >
> > > On Tue, Nov 07, 2023 at 02:50:57PM -0700, Nirmal Patel wrote:
> > > > On Thu, 2023-11-02 at 16:49 -0700, Nirmal Patel wrote:
> > > > > On Thu, 2023-11-02 at 15:41 -0500, Bjorn Helgaas wrote:
> > > > > > On Thu, Nov 02, 2023 at 01:07:03PM -0700, Nirmal Patel wrote:
> > > > > > > On Wed, 2023-11-01 at 17:20 -0500, Bjorn Helgaas wrote:
> > > > > > > > On Tue, Oct 31, 2023 at 12:59:34PM -0700, Nirmal Patel
> > > > > > > > wrote:
> > > > > > > > > On Tue, 2023-10-31 at 10:31 -0500, Bjorn Helgaas wrote:
> > > > > > > > > > On Mon, Oct 30, 2023 at 04:16:54PM -0400, Nirmal
> > > > > > > > > > Patel
> > > > > > > > > > wrote:
> > > > > > > > > > > VMD Hotplug should be enabled or disabled based on
> > > > > > > > > > > VMD
> > > > > > > > > > > rootports' Hotplug configuration in BIOS.
> > > > > > > > > > > is_hotplug_bridge
> > > > > > > > > > > is set on each VMD rootport based on Hotplug
> > > > > > > > > > > capable bit
> > > > > > > > > > > in
> > > > > > > > > > > SltCap in probe.c.  Check is_hotplug_bridge and
> > > > > > > > > > > enable or
> > > > > > > > > > > disable native_pcie_hotplug based on that value.
> > > > > > > > > > >
> > > > > > > > > > > Currently VMD driver copies ACPI settings or
> > > > > > > > > > > platform
> > > > > > > > > > > configurations for Hotplug, AER, DPC, PM, etc and
> > > > > > > > > > > enables
> > > > > > > > > > > or
> > > > > > > > > > > disables these features on VMD bridge which is not
> > > > > > > > > > > correct
> > > > > > > > > > > in case of Hotplug.
> > > > > > > > > >
> > > > > > > > > > This needs some background about why it's correct to
> > > > > > > > > > copy
> > > > > > > > > > the
> > > > > > > > > > ACPI settings in the case of AER, DPC, PM, etc, but
> > > > > > > > > > incorrect
> > > > > > > > > > for hotplug.
> > > > > > > > > >
> > > > > > > > > > > Also during the Guest boot up, ACPI settings along
> > > > > > > > > > > with
> > > > > > > > > > > VMD
> > > > > > > > > > > UEFI driver are not present in Guest BIOS which
> > > > > > > > > > > results
> > > > > > > > > > > in
> > > > > > > > > > > assigning default values to Hotplug, AER, DPC, etc.
> > > > > > > > > > > As a
> > > > > > > > > > > result Hotplug is disabled on VMD in the Guest OS.
> > > > > > > > > > >
> > > > > > > > > > > This patch will make sure that Hotplug is enabled
> > > > > > > > > > > properly
> > > > > > > > > > > in Host as well as in VM.
> > > > > > > > > >
> > > > > > > > > > Did we come to some consensus about how or whether
> > > > > > > > > > _OSC for
> > > > > > > > > > the host bridge above the VMD device should apply to
> > > > > > > > > > devices
> > > > > > > > > > in the separate domain below the VMD?
> > > > > > > > >
> > > > > > > > > We are not able to come to any consensus. Someone
> > > > > > > > > suggested
> > > > > > > > > to
> > > > > > > > > copy either all _OSC flags or none. But logic behind
> > > > > > > > > that
> > > > > > > > > assumption is that the VMD is a bridge device which is
> > > > > > > > > not
> > > > > > > > > completely true. VMD is an endpoint device and it owns
> > > > > > > > > its
> > > > > > > > > domain.
> > > > > > > >
> > > > > > > > Do you want to facilitate a discussion in the PCI
> > > > > > > > firmware SIG
> > > > > > > > about this?  It seems like we may want a little text in
> > > > > > > > the
> > > > > > > > spec
> > > > > > > > about how to handle this situation so platforms and OSes
> > > > > > > > have
> > > > > > > > the
> > > > > > > > same expectations.
> > > > > > >
> > > > > > > The patch 04b12ef163d1 broke intel VMD's hotplug
> > > > > > > capabilities and
> > > > > > > author did not test in VM environment impact.
> > > > > > > We can resolve the issue easily by
> > > > > > >
> > > > > > > #1 Revert the patch which means restoring VMD's original
> > > > > > > functionality
> > > > > > > and author provide better fix.
> > > > > > >
> > > > > > > or
> > > > > > >
> > > > > > > #2 Allow the current change to re-enable VMD hotplug inside
> > > > > > > VMD
> > > > > > > driver.
> > > > > > >
> > > > > > > There is a significant impact for our customers hotplug use
> > > > > > > cases
> > > > > > > which
> > > > > > > forces us to apply the fix in out-of-box drivers for
> > > > > > > different
> > > > > > > OSs.
> > > > > >
> > > > > > I agree 100% that there's a serious problem here and we need
> > > > > > to fix
> > > > > > it, there's no argument there.
> > > > > >
> > > > > > I guess you're saying it's obvious that an _OSC above VMD
> > > > > > does not
> > > > > > apply to devices below VMD, and therefore, no PCI Firmware
> > > > > > SIG
> > > > > > discussion or spec clarification is needed?
> > > > >
> > > > > Yes. By design VMD is an endpoint device to OS and its domain
> > > > > is
> > > > > privately owned by VMD only. I believe we should revert back to
> > > > > original design and not impose _OSC settings on VMD domain
> > > > > which is
> > > > > also a maintainable solution.
> > > >
> > > > I will send out revert patch. The _OSC settings shouldn't apply
> > > > to private VMD domain.
> > >
> > > I assume you mean to revert 04b12ef163d1 ("PCI: vmd: Honor ACPI
> > > _OSC
> > > on PCIe features").  That appeared in v5.17, and it fixed (or at
> > > least
> > > prevented) an AER message flood.  We can't simply revert
> > > 04b12ef163d1
> > > unless we first prevent that AER message flood in another way.
> >
> > The error is "correctable".
> > Does masking all correctable AER error by default make any sense? And
> > add a sysfs knob to make it optional.
> I assume sysfs knob requires driver reload. right? Can you send a
> patch?

What I mean is to mask Correctable Errors by default on *all*
rootports, and create a new sysfs knob to let user decide if
Correctable Errors should be unmasked.

I can send a patch, but of course I'd like to hear what Bjorn thinks
about this approach.

Kai-Heng

>
> nirmal
> >
> > Kai-Heng
> >
> > > Bjorn
> > >
> > > > Even the patch 04b12ef163d1 needs more changes to make sure _OSC
> > > > settings are passed on from Host BIOS to Guest BIOS which means
> > > > involvement of ESXi, Windows HyperV, KVM.
>

