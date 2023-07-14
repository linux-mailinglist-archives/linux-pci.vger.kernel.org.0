Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E3A7534E6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 10:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjGNISL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 04:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbjGNIR6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 04:17:58 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9159830DE
        for <linux-pci@vger.kernel.org>; Fri, 14 Jul 2023 01:17:40 -0700 (PDT)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7668B3F1A5
        for <linux-pci@vger.kernel.org>; Fri, 14 Jul 2023 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689322657;
        bh=3A/0HA6ZWMQbciYz9VJPXRi0Ox92FUy0gWHLPShyPBU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=u+xSgpwltrpiAz3JxM7Nz+Gf/CZIgQNy7+6tOXMko3PtjnGPhvPP562ZKxfpB5dgp
         +JK4Wmgp8bouA5F2kGGTIzcjb47X05v112/d36g6wnyB6K3Ft3gNaMGA6jHSD0KRe3
         /yh83rhizwQwj2Xp8a1uH68EBC5DmfpohvpJCMsmCk3mQOUiztIx9z4xXUSPETufhH
         59zBXOC+NSd7eH9c5YpE4wTY7PIaPjaDd2ZVnTEufQwxIIduwXfo5yMlCh+/gjZzzf
         sdgntxKNd/mciIFHgWYALfNV4oejFxl70A4WO+w8kTu8qMkP5Gzxjnz98INfWUWp6O
         FX1NkM+U0LcjQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-262e0b15ad3so1169201a91.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Jul 2023 01:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689322656; x=1691914656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3A/0HA6ZWMQbciYz9VJPXRi0Ox92FUy0gWHLPShyPBU=;
        b=hAJ2t3KOMKdqFBn0bTy01O5q5I5o8SAGZW+9onm3pAF6AklWkAYSidN4bvcfaOSs7U
         TqPdZJntxYMmp5Ao4ACkzBAim/gTOE1gUz4xrOGg7hxIrBAj3qJpMysGpKhhXgt+pILS
         QeCzGgvcMwNGGUJmqVnyezNiUx8z32wa2w0yFrYMMNUMJNsoAZX3t1e7HJNYFE+dTldb
         7cQhOjsvJQQMeJv30LXqZDAo4jOnZlNHh4Ul9AJONwqH+njapcHTar0W3OxvPtDKnkcq
         r9Z0xqLcPHHEfHUPdoOmnJiwi8hrA9rnZ4b0yio3hwGOkcdJTwMeA8owfTNkPYS25n2w
         zj+Q==
X-Gm-Message-State: ABy/qLaxOWy8dr9VCpi2hlR/vziDSE42vZDOGSHUu/4uFxM3giiMYZEs
        ET0i8QxNJRsOImcRXZDefZA9QWgee3GAWI+S/7W75jSKbHDyEJjNxWmxFu9d2Ps5332gxVk+zra
        +Y27pAfVL05a8B6L77z+oYwtWUj/vy4J270McSnJdwJCgi27MeG03pZ6OYnGk5A==
X-Received: by 2002:a17:90a:2d8d:b0:262:e598:6046 with SMTP id p13-20020a17090a2d8d00b00262e5986046mr3727582pjd.28.1689322655926;
        Fri, 14 Jul 2023 01:17:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHxON4/AXRLxhYG285c3DgIbtfg/pDUKu1PUe+rASKqNPVZaH88A4YiyS+yuhcwBdAsxe3+anSxFsA/g9hfaUE=
X-Received: by 2002:a17:90a:2d8d:b0:262:e598:6046 with SMTP id
 p13-20020a17090a2d8d00b00262e5986046mr3727571pjd.28.1689322655622; Fri, 14
 Jul 2023 01:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230705200617.GA72825@bhelgaas> <9d1095ab-23e5-3df3-58d6-b2974f87ee72@amd.com>
In-Reply-To: <9d1095ab-23e5-3df3-58d6-b2974f87ee72@amd.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 14 Jul 2023 16:17:24 +0800
Message-ID: <CAAd53p7L27dkzwb_Q9vhENhBye-JTcx2AuCG_YXAgb0F6MG-9w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] PCI/ASPM: Enable ASPM on external PCIe devices
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        intel-wired-lan@osuosl.org, bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 6, 2023 at 12:07=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 7/5/23 15:06, Bjorn Helgaas wrote:
> > On Wed, Jun 28, 2023 at 01:09:49PM +0800, Kai-Heng Feng wrote:
> >> On Wed, Jun 28, 2023 at 4:54=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> >>> On Tue, Jun 27, 2023 at 04:35:25PM +0800, Kai-Heng Feng wrote:
> >>>> On Fri, Jun 23, 2023 at 7:06=E2=80=AFAM Bjorn Helgaas <helgaas@kerne=
l.org> wrote:
> >>>>> On Tue, Jun 20, 2023 at 01:36:59PM -0500, Limonciello, Mario wrote:
> >
> >>> It's perfectly fine for the IP to support PCI features that are not
> >>> and can not be enabled in a system design.  But I expect that
> >>> strapping or firmware would disable those features so they are not
> >>> advertised in config space.
> >>>
> >>> If BIOS leaves features disabled because they cannot work, but at the
> >>> same time leaves them advertised in config space, I'd say that's a
> >>> BIOS defect.  In that case, we should have a DMI quirk or something t=
o
> >>> work around the defect.
> >>
> >> That means most if not all BIOS are defected.
> >> BIOS vendors and ODM never bothered (and probably will not) to change
> >> the capabilities advertised by config space because "it already works
> >> under Windows".
> >
> > This is what seems strange to me.  Are you saying that Windows never
> > enables these power-saving features?  Or that Windows includes quirks
> > for all these broken BIOSes?  Neither idea seems very convincing.
> >
>
> I see your point.  I was looking through Microsoft documentation for
> hints and came across this:
>
> https://learn.microsoft.com/en-us/windows-hardware/customize/power-settin=
gs/pci-express-settings-link-state-power-management
>
> They have a policy knob to globally set L0 or L1 for PCIe links.
>
> They don't explicitly say it, but surely it's based on what the devices
> advertise in the capabilities registers.

So essentially it can be achieved via boot time kernel parameter
and/or sysfs knob.

The main point is OS should stick to the BIOS default, which is the
only ASPM setting tested before putting hardware to the market.

Kai-Heng

>
> >>>> So the logic is to ignore the capability and trust the default set
> >>>> by BIOS.
> >>>
> >>> I think limiting ASPM support to whatever BIOS configured at boot-tim=
e
> >>> is problematic.  I don't think we can assume that all platforms have
> >>> firmware that configures ASPM as aggressively as possible, and
> >>> obviously firmware won't configure hot-added devices at all (in
> >>> general; I know ACPI _HPX can do some of that).
> >>
> >> Totally agree. I was not suggesting to limiting the setting at all.
> >> A boot-time parameter to flip ASPM setting is very useful. If none has
> >> been set, default to BIOS setting.
> >
> > A boot-time parameter for debugging and workarounds is fine.  IMO,
> > needing a boot-time parameter in the course of normal operation is
> > not OK.
> >
> > Bjorn
>
