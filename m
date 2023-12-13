Return-Path: <linux-pci+bounces-884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DA1811A27
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 17:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6E728294B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 16:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B43A3A8EC;
	Wed, 13 Dec 2023 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="STtM/iAE"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F864D0
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 08:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702486488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TDCWZoZHEnL9q9UlZCk5o8FDqw1MfF12zxN5vbn51B8=;
	b=STtM/iAE0PFB4xeBQcpBr0HYaWDSkP04f7kzZyT7+ZVrYzSErpi/9KS/J6fvGQGAvNM5gd
	FHn8KM7NZa+VJswzymlH/oGM81Z2hHM69Yu+LkEiNt7u0uZl+nm7xG6OtdTe/P2bEnS2BW
	Ljv7oa5wBdVxbe4qhXnJmYMAGIC5dyM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-KQhP_E5qOhi4yXC1WHHUGQ-1; Wed, 13 Dec 2023 11:54:47 -0500
X-MC-Unique: KQhP_E5qOhi4yXC1WHHUGQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1eb3f3dc2eso172522166b.2
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 08:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486486; x=1703091286;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDCWZoZHEnL9q9UlZCk5o8FDqw1MfF12zxN5vbn51B8=;
        b=SKf9sbTrVFVnK9glYbE/ijofd77jNklf0/21Ms7fbtYVnAnFKI0/Bl66CSrKCVd49I
         5rGoj/E1fdYSgJrXbTunYiZj0xLLBjy0mznKmqbm+8ec7w7dqcOUN61BrrVxazNobaRD
         YniPzk7LJe3iNPd0jdCjl+e/7Jz+Y55TMX8mIyFx4avE/jZ4mPH4EHEmcbFlpTfdBeWS
         XbImJfrY4K639mNAFLKJxenAxV4YPUTwD/lCYb5ab3fu2shMYQjNHLhxYK3cDONarx0j
         gNVhYDwL3PVsIqUyRrgAbF26DDmo45rCJAFYB1/T4YARpxhgTChp/VSmh7ec2pyLTSmH
         accQ==
X-Gm-Message-State: AOJu0YxgfE74uJYxsZE8oQGse2UlVPKKpswtaNmR6T1P6QXzTeBcXlsj
	DP5bTYklPiZOtLJY9MAqp/NFb7gtTHKs0ny3wsDkB4jWnm1XND6SFLCHHFtmj/iXsxCW1GhnW2F
	zMx0du7ABHcIOvJ7D5QKd
X-Received: by 2002:a17:906:2247:b0:a1f:a03d:2fdb with SMTP id 7-20020a170906224700b00a1fa03d2fdbmr2758552ejr.14.1702486485861;
        Wed, 13 Dec 2023 08:54:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDrym3BHQqr1gGWd0AZbVrLuc3zfrg6EtZUmOadG4ycS5fHuh89Cl4oMrZuV8jvPmVaQKjWA==
X-Received: by 2002:a17:906:2247:b0:a1f:a03d:2fdb with SMTP id 7-20020a170906224700b00a1fa03d2fdbmr2758543ejr.14.1702486485461;
        Wed, 13 Dec 2023 08:54:45 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
        by smtp.gmail.com with ESMTPSA id hw18-20020a170907a0d200b00a1cbe52300csm8108840ejc.56.2023.12.13.08.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:54:44 -0800 (PST)
Date: Wed, 13 Dec 2023 11:54:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
	Dongli Zhang <dongli.zhang@oracle.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, lenb@kernel.org, bhelgaas@google.com,
	mika.westerberg@linux.intel.com, boris.ostrovsky@oracle.com,
	joe.jin@oracle.com, stable@vger.kernel.org,
	Fiona Ebner <f.ebner@proxmox.com>,
	Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple
 devices at a time
Message-ID: <20231213115248-mutt-send-email-mst@kernel.org>
References: <20231213003614.1648343-1-imammedo@redhat.com>
 <20231213003614.1648343-3-imammedo@redhat.com>
 <CAJZ5v0gowV0WJd8pjwrDyHSJPvwgkCXYu9bDG7HHfcyzkSSY6w@mail.gmail.com>
 <CAMLWh55dr2e_R+TYVj=8cFfV==D-DfOZvAeq9JEehYs3nw6-OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMLWh55dr2e_R+TYVj=8cFfV==D-DfOZvAeq9JEehYs3nw6-OQ@mail.gmail.com>

On Wed, Dec 13, 2023 at 05:49:39PM +0100, Igor Mammedov wrote:
> On Wed, Dec 13, 2023 at 2:08 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Dec 13, 2023 at 1:36 AM Igor Mammedov <imammedo@redhat.com> wrote:
> > >
> > > previous commit ("PCI: acpiphp: enable slot only if it hasn't been enabled already"
> > > introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
> > > bridge reconfiguration in case of single HBA hotplug.
> > > However in virt environment it's possible to pause machine hotplug several
> > > HBAs and let machine run. That can hit the same race when 2nd hotplugged
> > > HBA will start re-configuring bridge.
> > > Do the same thing as SHPC and throttle down hotplug of 2nd and up
> > > devices within single hotplug event.
> > >
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > >  drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > > index 6b11609927d6..30bca2086b24 100644
> > > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > > @@ -37,6 +37,7 @@
> > >  #include <linux/mutex.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/acpi.h>
> > > +#include <linux/delay.h>
> > >
> > >  #include "../pci.h"
> > >  #include "acpiphp.h"
> > > @@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *dev)
> > >  static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> > >  {
> > >         struct acpiphp_slot *slot;
> > > +        int nr_hp_slots = 0;
> > >
> > >         /* Bail out if the bridge is going away. */
> > >         if (bridge->is_going_away)
> > > @@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
> > >
> > >                         /* configure all functions */
> > >                         if (slot->flags != SLOT_ENABLED) {
> > > +                               if (nr_hp_slots)
> > > +                                       msleep(1000);
> >
> > Why is 1000 considered the most suitable number here?  Any chance to
> > define a symbol for it?
> 
> Timeout was borrowed from SHPC hotplug workflow where it apparently
> makes race harder to reproduce.
> (though it's not excuse to add more timeouts elsewhere)
> 
> > And won't this affect the cases when the race in question is not a concern?
> 
> In practice it's not likely, since even in virt scenario hypervisor won't
> stop VM to hotplug device (which beats whole purpose of hotplug).
> 
> But in case of a very slow VM (overcommit case) it's possible for
> several HBA's to be hotplugged by the time acpiphp gets a chance
> to handle the 1st hotplug event. SHPC is more or less 'safe' with its
> 1sec delay.
> 
> > Also, adding arbitrary timeouts is not the most robust way of
> > addressing race conditions IMV.  Wouldn't it be better to add some
> > proper synchronization between the pieces of code that can race with
> > each other?
> 
> I don't like it either, it's a stop gap measure to hide regression on
> short notice,
> which I can fixup without much risk in short time left, before folks
> leave on holidays.
> It's fine to drop the patch as chances of this happening are small.
> [1/2] should cover reported cases.
> 
> Since it's RFC, I basically ask for opinions on a proper way to fix
> SCSI_ASYNC_SCAN
> running wild while the hotplug is in progress (and maybe SCSI is not
> the only user that
> schedules async job from device probe).

Of course not. And things don't have to be scheduled from probe right?
Can be triggered by an interrupt or userspace activity.

> So adding synchronisation and testing
> would take time (not something I'd do this late in the cycle).
> 
> So far I'm thinking about adding rw mutex to bridge with the PCI
> hotplug subsystem
> being a writer while scsi scan jobs would be readers and wait till hotplug code
> says it's safe to proceed.
> I plan to work in this direction and give it some testing, unless
> someone has a better idea.

> >
> > > +
> > > +                                ++nr_hp_slots;
> > >                                 enable_slot(slot, true);
> > >                         }
> > >                 } else {
> > > --
> >


