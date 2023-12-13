Return-Path: <linux-pci+bounces-883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29A9811A0A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 17:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38541F216B5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A344F1D684;
	Wed, 13 Dec 2023 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRc0XR/4"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF76AC
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 08:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702486194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAUBw1JbqJkoLEh9unPbe/skVaLgSM4WAzbnqm5FIlk=;
	b=eRc0XR/4y54juTn1111ME2sl3K7tSVLvKtz5d43JszKiXv48yXAmHy10ijO7dQ7drREhkn
	vgXqZHLKKQQ++Qhgkr9W94V807yv3YXUiyth5e40I0AOwmbIi6uAUOdoqN8r8R729zc391
	wOQmaNt/AZmB5e6hZMLJ7sp2yvONhWs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-x5IloJXXNSmyE0JpM10a7w-1; Wed, 13 Dec 2023 11:49:52 -0500
X-MC-Unique: x5IloJXXNSmyE0JpM10a7w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33340d20b90so6013307f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 08:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486191; x=1703090991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAUBw1JbqJkoLEh9unPbe/skVaLgSM4WAzbnqm5FIlk=;
        b=An3Rf4NPqWRge4LR6Gq1rwNv7dX+d07GkL6qep9HfXZLxr+8K4c7bb5FSMxAclQJdC
         O0uze2wN+QT0Opulmc8s9NFHSrHBkiOgjp2/mNfOPns2V9S2tVAXKxQ9PluO5aCkJcJt
         OXogNsdt+y0Z3wFUGgJa8h933A11YwV8LYN/O8vUdkj/uiv9/2iQaHO5ZUgdtosvyTQ1
         MvlXKCzaZoP/nbTnFTwEB8aOB6JC7xdyyeSKaCJr5C3MrWIw98weao/x/M0fV++mA05m
         bo1YMih3PJS0GFhTNGglsq9Ti86TODX8JnFRixk4hyh9gZmbfjrFSd9GBEk+pxSN3Z2W
         bRCg==
X-Gm-Message-State: AOJu0YxH4Vr8jl4lycfi1qklqJV+dnn04QeoOEXkDfcy0NMQRVhOJEnd
	LaVDbXMFJlMF57NlLH6SPrckjzePhJUvYcLFXFqAxsUOlATFgPbF8cQ9I5cpcprntjDgVA1xxEG
	Q31fn++Pmw7csH7Xka6FoySFRSXCggJrd9Pga
X-Received: by 2002:adf:e712:0:b0:336:30b5:3c19 with SMTP id c18-20020adfe712000000b0033630b53c19mr1551564wrm.126.1702486191415;
        Wed, 13 Dec 2023 08:49:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbtWOXbTiO49SRgCwSfAmRnGuTCtdSJbwL1Csvygxz4hMPMjM2yAakU6yql6/c0bJAuDlRelMBxmGAX8X5oPw=
X-Received: by 2002:adf:e712:0:b0:336:30b5:3c19 with SMTP id
 c18-20020adfe712000000b0033630b53c19mr1551559wrm.126.1702486191114; Wed, 13
 Dec 2023 08:49:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213003614.1648343-1-imammedo@redhat.com> <20231213003614.1648343-3-imammedo@redhat.com>
 <CAJZ5v0gowV0WJd8pjwrDyHSJPvwgkCXYu9bDG7HHfcyzkSSY6w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gowV0WJd8pjwrDyHSJPvwgkCXYu9bDG7HHfcyzkSSY6w@mail.gmail.com>
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 13 Dec 2023 17:49:39 +0100
Message-ID: <CAMLWh55dr2e_R+TYVj=8cFfV==D-DfOZvAeq9JEehYs3nw6-OQ@mail.gmail.com>
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple
 devices at a time
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dongli Zhang <dongli.zhang@oracle.com>, 
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, mst@redhat.com, 
	lenb@kernel.org, bhelgaas@google.com, mika.westerberg@linux.intel.com, 
	boris.ostrovsky@oracle.com, joe.jin@oracle.com, stable@vger.kernel.org, 
	Fiona Ebner <f.ebner@proxmox.com>, Thomas Lamprecht <t.lamprecht@proxmox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 2:08=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Dec 13, 2023 at 1:36=E2=80=AFAM Igor Mammedov <imammedo@redhat.co=
m> wrote:
> >
> > previous commit ("PCI: acpiphp: enable slot only if it hasn't been enab=
led already"
> > introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
> > bridge reconfiguration in case of single HBA hotplug.
> > However in virt environment it's possible to pause machine hotplug seve=
ral
> > HBAs and let machine run. That can hit the same race when 2nd hotplugge=
d
> > HBA will start re-configuring bridge.
> > Do the same thing as SHPC and throttle down hotplug of 2nd and up
> > devices within single hotplug event.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/a=
cpiphp_glue.c
> > index 6b11609927d6..30bca2086b24 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/slab.h>
> >  #include <linux/acpi.h>
> > +#include <linux/delay.h>
> >
> >  #include "../pci.h"
> >  #include "acpiphp.h"
> > @@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *dev)
> >  static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> >  {
> >         struct acpiphp_slot *slot;
> > +        int nr_hp_slots =3D 0;
> >
> >         /* Bail out if the bridge is going away. */
> >         if (bridge->is_going_away)
> > @@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp_br=
idge *bridge)
> >
> >                         /* configure all functions */
> >                         if (slot->flags !=3D SLOT_ENABLED) {
> > +                               if (nr_hp_slots)
> > +                                       msleep(1000);
>
> Why is 1000 considered the most suitable number here?  Any chance to
> define a symbol for it?

Timeout was borrowed from SHPC hotplug workflow where it apparently
makes race harder to reproduce.
(though it's not excuse to add more timeouts elsewhere)

> And won't this affect the cases when the race in question is not a concer=
n?

In practice it's not likely, since even in virt scenario hypervisor won't
stop VM to hotplug device (which beats whole purpose of hotplug).

But in case of a very slow VM (overcommit case) it's possible for
several HBA's to be hotplugged by the time acpiphp gets a chance
to handle the 1st hotplug event. SHPC is more or less 'safe' with its
1sec delay.

> Also, adding arbitrary timeouts is not the most robust way of
> addressing race conditions IMV.  Wouldn't it be better to add some
> proper synchronization between the pieces of code that can race with
> each other?

I don't like it either, it's a stop gap measure to hide regression on
short notice,
which I can fixup without much risk in short time left, before folks
leave on holidays.
It's fine to drop the patch as chances of this happening are small.
[1/2] should cover reported cases.

Since it's RFC, I basically ask for opinions on a proper way to fix
SCSI_ASYNC_SCAN
running wild while the hotplug is in progress (and maybe SCSI is not
the only user that
schedules async job from device probe). So adding synchronisation and testi=
ng
would take time (not something I'd do this late in the cycle).

So far I'm thinking about adding rw mutex to bridge with the PCI
hotplug subsystem
being a writer while scsi scan jobs would be readers and wait till hotplug =
code
says it's safe to proceed.
I plan to work in this direction and give it some testing, unless
someone has a better idea.

>
> > +
> > +                                ++nr_hp_slots;
> >                                 enable_slot(slot, true);
> >                         }
> >                 } else {
> > --
>


