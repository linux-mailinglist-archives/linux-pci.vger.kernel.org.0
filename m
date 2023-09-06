Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809B37943CF
	for <lists+linux-pci@lfdr.de>; Wed,  6 Sep 2023 21:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244198AbjIFTaC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Sep 2023 15:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242758AbjIFTaA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Sep 2023 15:30:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F049EE41
        for <linux-pci@vger.kernel.org>; Wed,  6 Sep 2023 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694028548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BkNqqrFNSye+85FOkqcxyjqr5JGuixiZESeFlYs5s54=;
        b=IsTS3+6fEHweIbXR6J/mJPEfQ9EPsjkIHiBk7ChChv4w0trKNxcjHsypXHP/n5hU391G/Y
        mERCo2JMncadXJxedTyM/Qox3Zf8/nBBfF8lf2hxg2+SPCgrfh4mv8MobDZaxrlntIbUz7
        7UVX+5Zr8tn/DGaC4k/DtB2yDlKCnMM=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-UnGz1_mYPQClVWHDlWuaTg-1; Wed, 06 Sep 2023 15:29:07 -0400
X-MC-Unique: UnGz1_mYPQClVWHDlWuaTg-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-34bb89fa29eso1264535ab.3
        for <linux-pci@vger.kernel.org>; Wed, 06 Sep 2023 12:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694028546; x=1694633346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkNqqrFNSye+85FOkqcxyjqr5JGuixiZESeFlYs5s54=;
        b=IZ0nJJhiH68PGHR/7c3kMEmkG9/Xus3oFqJBcCC6h3u4T8Veu4z5a1+6N+UQXUxbTT
         fXmrECt/4p8/y4MpYjQdIMNbgLbje0YuIVtICv59A3BIsY9KXeYStxW8iwyq9vRwBex6
         cFSLdg6OxgaEnLUtTq/7aAne6eV2TXKlIC8W7jguebqwre3lIuT1Vklb8bn15ce5d+bC
         DmMHk+9q3zTbF0YQSWxxiWC6PAu8JO9vFAAWrfsbFhcUtutDBf736aV1dHsqQi9XZFWi
         +B7j1im8vnAOoNvpG2PdBTzUlPGH+6pgasNjghIljeo2lCg+ubQZwlSQDHs01FnjzkgK
         iBqA==
X-Gm-Message-State: AOJu0YwHbFaZFVRLyZ1ljBWx34vtXKrYtnjroO93ouAJfh0ML4JfWcvQ
        Yrq/WsXoQoZuxP0iLDdfWoSFGeVKpQUHb6CQ7oT/xNS5ttXdaoL2dEj76d+pbHXH8S+6dsPg91c
        vVjkFWiIhQUdwbEhgbLE+
X-Received: by 2002:a05:6e02:1d11:b0:347:6b30:5bd3 with SMTP id i17-20020a056e021d1100b003476b305bd3mr21867132ila.13.1694028546537;
        Wed, 06 Sep 2023 12:29:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyKFIvkN7zuLMbU6PvggO334g+2dgeQZvJcZ8JKJqA6E6EEEA4iTKmp69E/q99AN/ZBKFIOQ==
X-Received: by 2002:a05:6e02:1d11:b0:347:6b30:5bd3 with SMTP id i17-20020a056e021d1100b003476b305bd3mr21867112ila.13.1694028546213;
        Wed, 06 Sep 2023 12:29:06 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id m11-20020a92710b000000b0034e28100d1csm3233596ilc.58.2023.09.06.12.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 12:29:05 -0700 (PDT)
Date:   Wed, 6 Sep 2023 13:29:04 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Sui Jingfeng <suijingfeng@loongson.cn>,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: [RFC, drm-misc-next v4 0/9] PCI/VGA: Allowing the user to
 select the primary video adapter at boot time
Message-ID: <20230906132904.4e49e269.alex.williamson@redhat.com>
In-Reply-To: <a6337007-b6fa-2ce9-d0cd-46465b540205@linux.dev>
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
        <20230905085243.4b22725e.alex.williamson@redhat.com>
        <a6337007-b6fa-2ce9-d0cd-46465b540205@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 6 Sep 2023 11:51:59 +0800
Sui Jingfeng <sui.jingfeng@linux.dev> wrote:

> Hi,
>=20
>=20
> On 2023/9/5 22:52, Alex Williamson wrote:
> > On Tue,  5 Sep 2023 03:57:15 +0800
> > Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> > =20
> >> From: Sui Jingfeng <suijingfeng@loongson.cn>
> >>
> >> On a machine with multiple GPUs, a Linux user has no control over which
> >> one is primary at boot time. This series tries to solve above mentioned
> >> problem by introduced the ->be_primary() function stub. The specific
> >> device drivers can provide an implementation to hook up with this stub=
 by
> >> calling the vga_client_register() function.
> >>
> >> Once the driver bound the device successfully, VGAARB will call back to
> >> the device driver. To query if the device drivers want to be primary or
> >> not. Device drivers can just pass NULL if have no such needs.
> >>
> >> Please note that:
> >>
> >> 1) The ARM64, Loongarch, Mips servers have a lot PCIe slot, and I would
> >>     like to mount at least three video cards.
> >>
> >> 2) Typically, those non-86 machines don't have a good UEFI firmware
> >>     support, which doesn't support select primary GPU as firmware stag=
e.
> >>     Even on x86, there are old UEFI firmwares which already made undes=
ired
> >>     decision for you.
> >>
> >> 3) This series is attempt to solve the remain problems at the driver l=
evel,
> >>     while another series[1] of me is target to solve the majority of t=
he
> >>     problems at device level.
> >>
> >> Tested (limited) on x86 with four video card mounted, Intel UHD Graphi=
cs
> >> 630 is the default boot VGA, successfully override by ast2400 with
> >> ast.modeset=3D10 append at the kernel cmd line.
> >>
> >> $ lspci | grep VGA
> >>
> >>   00:02.0 VGA compatible controller: Intel Corporation CoffeeLake-S GT=
2 [UHD Graphics 630] =20
> > In all my previous experiments with VGA routing and IGD I found that
> > IGD can't actually release VGA routing and Intel confirmed the hardware
> > doesn't have the ability to do so. =20
>=20
> Which model of the IGD you are using?=C2=A0even for the IGD in Atom D2550,
> the legacy 128KB VGA memory range can be=C2=A0tuned to be mapped to IGD
> or to the DMI Interface. See the 1.7.3.2 section of the N2000 datasheet[1=
].

I believe it's the VGA I/O that can't be disabled, there's no means to
do so other than the I/O enable bit in the command register and iirc
the driver depends on this for other features.  The history of this is
pretty old, but here are some links:

https://lore.kernel.org/all/1376486637.31494.19.camel@ul30vt.home/
https://bbs.archlinux.org/viewtopic.php?pid=3D1400212#p1400212
https://lore.kernel.org/all/20130815223917.27890.28003.stgit@bling.home/
https://lore.kernel.org/all/20130824144701.23370.42110.stgit@bling.home/
https://lore.kernel.org/all/20140509201655.2849.97478.stgit@bling.home/

I think the issue was that i915 doesn't claim to the VGA arbiter to be
controlling legacy VGA ranges, but in fact the hardware does claim
those ranges.  We can "fix" i915 to report that VGA MMIO space is
owned and can be controlled, but then Xorg likely sees multiple VGA
arbiter clients and disables DRI because it wants to mmap VGA MMIO
space.

Therefore unless something has changed in the past 10yrs, i915 owns but
does not advertise ownership of the VGA address spaces and therefore
the arbiter can't and doesn't know to change VGA routing to enable a
"be_primary" path to another device.
=20
> If a specific model of Intel has a bug in the VGA routing hardware logic =
unit,
> I would like to ignore it. Or switch to the UEFI firmware on such hardwar=
e.

That's a convenient and impractical approach.  I expect all Intel HD
graphics has this issue.  Unknown for Xe.

> It is the hardware engineer's responsibility, I will not worry about it.

We often need to deal with broken hardware in the kernel.

> Thanks for you tell this.
>=20
> [1] https://www.intel.com/content/dam/doc/datasheet/atom-d2000-n2000-vol-=
2-datasheet.pdf
>=20
>=20
> >   It will always be primary from a
> > VGA routing perspective.  Was this actually tested with non-UEFI? =20
>=20
>=20
> As you already said,=C2=A0the generous Intel already have confirmed that =
the hardware defect.
> So probably this is a good chance to switch to UEFI to solve the problem.=
 Then, no
> testing for legacy is needed.

Then why are we hacking on VGA arbitration in this series at all?

> > I suspect it might only work in UEFI mode where we probably don't
> > actually have a dependency on VGA routing.  This is essentially why
> > vfio requires UEFI ROMs when assigning GPUs to VMs, VGA routing is too
> > broken to use on Intel systems with IGD.  Thanks, =20
>=20
> Thanks for you tell me this.
>=20
> To be honest, I have only tested my patch on machines with UEFI=C2=A0firm=
ware.
> Since UEFI because the main stream, but if this patch is really useful for
> majority machine, I'm satisfied. The results is not too bad.

This looks like a pretty significant scoping issue if you're proposing
changes to the VGA arbiter which specifically handles the routing of
legacy VGA address spaces but are not willing to commit to testing
legacy configurations.  Thanks,

Alex

