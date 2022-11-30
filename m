Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86EA63D9D8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 16:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiK3PtL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 10:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiK3Psv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 10:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C2D21834
        for <linux-pci@vger.kernel.org>; Wed, 30 Nov 2022 07:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669823265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zBW0tOhOc7GhgKWt1fVC1ymMlH4pE5gKymyGIbQXF2w=;
        b=Ks0ropWP3u0hXQkgE7tUwptPzWPgVNazz//YdIz3709rUmhVFA6EeyD++vGjOfJVp0qLxS
        BwYCBZ+EKHriOGm/GxFb6Teo7vAuqZ3sRHD61xodr/7doHqzwPheioVft/Om9eCotxHOaj
        JKysX3muRoFrzni8+lgpPDH66NSAz08=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-534-h1EjANjPMGecD1LKQjqy9g-1; Wed, 30 Nov 2022 10:47:44 -0500
X-MC-Unique: h1EjANjPMGecD1LKQjqy9g-1
Received: by mail-il1-f199.google.com with SMTP id s4-20020a056e02216400b003021b648144so15877492ilv.19
        for <linux-pci@vger.kernel.org>; Wed, 30 Nov 2022 07:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBW0tOhOc7GhgKWt1fVC1ymMlH4pE5gKymyGIbQXF2w=;
        b=zJzilDmQxb2vKBx1UOXJnHoHsp6H9nyvjmezSgeRYu7WkF19QXTcGyuTSNFq/VQD/y
         iknald11QPB1KRvQ37qG7i6Nkujf9cHHRJn/MiZpKWqY/3NcTVk02w5J2E5T1EqxfIH2
         QehDkWUVueGZfHXqGcOdYekrc11fvUs73c56ww+dBZnwbZ7xYNX+ALGWtZqxYyUWwG+C
         rfkahTdR1urgdjjP+oKPpMlmgvSSn069Jcc1HWoQa0eylxlpPnKp4NnbWV9hMCN1SwTd
         J0qnOSQlARMQtFRnCf3pkosw/TwmfOxtkwCJSsXIlY9bXTApMOusby0zEDXlpMHNyTf8
         gFfw==
X-Gm-Message-State: ANoB5pmBeSGxLcvDpnlqOLqpSly3gzzjctbmek4syXqM1oHRf4aq29sG
        LeIllcvR03H/Kmi4H7zEbLB6zr95AxfeaUFqPMC561D8+N6+pubtPbjHmK28fYbsDi8oU8BDqGL
        L7i1CGYbJc9yHwiDU/Tnd
X-Received: by 2002:a02:7425:0:b0:375:192c:9c93 with SMTP id o37-20020a027425000000b00375192c9c93mr30185653jac.297.1669823263260;
        Wed, 30 Nov 2022 07:47:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7Hak8+7x5qf4MMIyOF+GV4cHllYYLGblN/O1oizgFvn8/nsJdPh4ERhRxQRXNxYj70+aICSA==
X-Received: by 2002:a02:7425:0:b0:375:192c:9c93 with SMTP id o37-20020a027425000000b00375192c9c93mr30185641jac.297.1669823262957;
        Wed, 30 Nov 2022 07:47:42 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x10-20020a02970a000000b003759b13c639sm681847jai.97.2022.11.30.07.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 07:47:42 -0800 (PST)
Date:   Wed, 30 Nov 2022 08:47:38 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI resource allocation mismatch with BIOS
Message-ID: <20221130084738.57281dac.alex.williamson@redhat.com>
In-Reply-To: <Y4cM3qYnaHl3fQsU@black.fi.intel.com>
References: <Y4SYBtaP1hTWGsYn@black.fi.intel.com>
        <20221128203932.GA644781@bhelgaas>
        <20221128150617.14c98c2e.alex.williamson@redhat.com>
        <20221129064812.GA1555@wunner.de>
        <20221129065242.07b5bcbf.alex.williamson@redhat.com>
        <Y4YgKaml6nh5cB9r@black.fi.intel.com>
        <20221129084646.0b22c80b.alex.williamson@redhat.com>
        <20221129160626.GA19822@wunner.de>
        <20221129091249.3b60dd58.alex.williamson@redhat.com>
        <20221130074347.GC8198@wunner.de>
        <Y4cM3qYnaHl3fQsU@black.fi.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 30 Nov 2022 09:57:18 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi,
>=20
> On Wed, Nov 30, 2022 at 08:43:47AM +0100, Lukas Wunner wrote:
> > On Tue, Nov 29, 2022 at 09:12:49AM -0700, Alex Williamson wrote: =20
> > > On Tue, 29 Nov 2022 17:06:26 +0100 Lukas Wunner <lukas@wunner.de> wro=
te: =20
> > > > On Tue, Nov 29, 2022 at 08:46:46AM -0700, Alex Williamson wrote: =20
> > > > > Maybe the elephant in the room is why it's apparently such common
> > > > > practice to need to perform a hard reset these devices outside of
> > > > > virtualization scenarios...   =20
> > > >=20
> > > > These GPUs are used as accelerators in cloud environments.
> > > >=20
> > > > They're reset to a pristine state when handed out to another tenant
> > > > to avoid info leaks from the previous tenant.
> > > >=20
> > > > That should be a legitimate usage of PCIe reset, no? =20
> > >=20
> > > Absolutely, but why the whole switch?  Thanks, =20
> >=20
> > The reset is propagated down the hierarchy, so by resetting the
> > Switch Upstream Port, it is guaranteed that all endpoints are
> > reset with just a single operation.  Per PCIe r6.0.1 sec 6.6.1:
> >=20
> >    "For a Switch, the following must cause a hot reset to be sent
> >     on all Downstream Ports:
> >     [...]
> >     Receiving a hot reset on the Upstream Port" =20

This was never in doubt.
=20
> Adding here the reason I got from the GPU folks:
>=20
> In addition to the use case when the GPU is reset when switched to
> another tenant, this is used for recovery. The "first level" recovery is
> handled by the graphics driver that does Function Level Reset but if
> that does not work data centers may trigger reset at higher level (root
> port or switch upstream port) to reset the whole card. So called "big
> hammer".

Ok, so the first level issue can be solved by the reset_method
attribute, allowing userspace to trigger a SBR for a signle function
endpoint rather than an FLR (though this might suggest some hardware
issues in the FLR implementation).  This will save and restore the
device config space, so there should be no resource reallocation issues.
=20
> There is another use case too - firmware upgrade. This allows data
> centers to upgrade firmware on those cards without need to reboot - they
> just reset the whole thing to make it run the new firmware.

The above can also be used for this, so long as the firmware update
only targets the GPU and device config space layout and features is not
modified by the update.  This touches on a long standing issue Bjorn
has had with performing bus resets where we assume we get back
essentially the same devices after the reset.  That's not guaranteed
with a pending firmware update.

=46rom the logs in this case, I notice that the BIOS didn't assigned the
ROM BAR for the GPU while Linux did when re-scanning.  That's a
different address space from the SR-IOV BARs, so doesn't explain this
failure, but I wonder if there's another resource in the hierarchy that
the BIOS didn't program, ex. BAR0 on the upstream switch maybe?
Possibly if the host were booted with pci=3Drealloc, Linux might expand
the resources to something it's happy with, allowing future re-scans.
Otherwise I think we'd need a log of all BIOS vs Linux resource
allocations from the root port down to see what might be the issue with
the rescan.  Thanks,

Alex

