Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1AB755A1B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 05:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGQDe2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Jul 2023 23:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGQDe0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Jul 2023 23:34:26 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABC0F1
        for <linux-pci@vger.kernel.org>; Sun, 16 Jul 2023 20:34:25 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EAE573F1A3
        for <linux-pci@vger.kernel.org>; Mon, 17 Jul 2023 03:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689564862;
        bh=DnRdLOx1Ivb7fT2g6W01ng/Xf0iUV7nR0rj9XNZC/LM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=YScDs5NSTgrjvGvYElJqP9C9Uomdc8jqAP9qrg5iHYHHKjE2WMLTvhyI/XFFYi/X1
         VEMpeJZE5tQ+0Yta1gWvSNMoxFitZFPB1wlb9uOfCgYVq+CxNMr5lU0mYZP5wOzYFf
         IIjILyz8FldwjynYORrtJHpkWmKY4QfYYhsxkSeAQGvg+g283SfRn5qZ5eivwfiCKb
         Nx1WvJIJADA1eAdn/GuluC3ofk6CaduWjpluXqk2qf08c782vi5NTlZSDgLd8YaxFU
         95Ju4q3CbyKTvRMr2/qf1H1JMhnR1K3UIJVQ02Rxe6j+Cc3OlXiY7AmcQ41Oo0D9Qi
         iLFCJHgG0TZDA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4039e119f40so51297381cf.0
        for <linux-pci@vger.kernel.org>; Sun, 16 Jul 2023 20:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689564862; x=1692156862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnRdLOx1Ivb7fT2g6W01ng/Xf0iUV7nR0rj9XNZC/LM=;
        b=MyE/asm0IfxbdeyjdbT7+mNf1gH/0ej31d+0C5KA543o8hzA5i/p+LN1t+nHGchuCq
         UYB/7H9uOVLIcwDrPcO1ldLTaOpqu0GMV5AdMRYKyeiRPmwL72P/HtvWhl2iUAW6U1VX
         mOgKy+UaTn6dcX9ICNR8R6mjSg4564aP5Lki38SEYAv/s9BUfVSasAJWQwf/myVeKBGm
         SORIAOyEhclykjwjKeYQyOubiU5LNbkLFPfuc3xeJqb4b3zAUO2OanWeErPQ12S3RCW2
         nfGnBomY8IEjzuahHUj4DVNYvof0XrJro76GACwpV6expPtwWuzGb2YtYs8qaal47VFf
         Iz+A==
X-Gm-Message-State: ABy/qLajIAQ8e2iuJPOioi5rps2kOTOtHTLmojHhM/ysfFwFiwBbeYRZ
        UnlXqZdzeFbMP+8+igvJQVSUUwYgm1vvUhiRkJC+PSAgX3aY0H+P6mkqarhdoVgKLaQIlDCHmsr
        khOVT0Tm07L67U8QYjWC3LoY0JMkvWXRvyjB0Gi/lVwxnhO6sPDrix6E/9zVRsw==
X-Received: by 2002:a05:622a:1113:b0:403:eb71:1fa6 with SMTP id e19-20020a05622a111300b00403eb711fa6mr3643081qty.5.1689564861891;
        Sun, 16 Jul 2023 20:34:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFL0RrWSbm/eHaMFX84hG1Bm9HWdXpoOqnEIJ9bXrUWpBRxfKw3w6Qjf11YyL6jSsCIllYQFoOjL4W9r/AWpug=
X-Received: by 2002:a05:622a:1113:b0:403:eb71:1fa6 with SMTP id
 e19-20020a05622a111300b00403eb711fa6mr3643069qty.5.1689564861653; Sun, 16 Jul
 2023 20:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230705200617.GA72825@bhelgaas> <9d1095ab-23e5-3df3-58d6-b2974f87ee72@amd.com>
 <CAAd53p7L27dkzwb_Q9vhENhBye-JTcx2AuCG_YXAgb0F6MG-9w@mail.gmail.com> <60b2f5fb-8294-d104-16d8-0acfc70426c1@amd.com>
In-Reply-To: <60b2f5fb-8294-d104-16d8-0acfc70426c1@amd.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 17 Jul 2023 11:34:10 +0800
Message-ID: <CAAd53p42jiTCOsRZwEY0jtBejMDs1FbTOBNEknijnVNk3ENxuA@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 15, 2023 at 12:37=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 7/14/23 03:17, Kai-Heng Feng wrote:
> > On Thu, Jul 6, 2023 at 12:07=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> On 7/5/23 15:06, Bjorn Helgaas wrote:
> >>> On Wed, Jun 28, 2023 at 01:09:49PM +0800, Kai-Heng Feng wrote:
> >>>> On Wed, Jun 28, 2023 at 4:54=E2=80=AFAM Bjorn Helgaas <helgaas@kerne=
l.org> wrote:
> >>>>> On Tue, Jun 27, 2023 at 04:35:25PM +0800, Kai-Heng Feng wrote:
> >>>>>> On Fri, Jun 23, 2023 at 7:06=E2=80=AFAM Bjorn Helgaas <helgaas@ker=
nel.org> wrote:
> >>>>>>> On Tue, Jun 20, 2023 at 01:36:59PM -0500, Limonciello, Mario wrot=
e:
> >>>
> >>>>> It's perfectly fine for the IP to support PCI features that are not
> >>>>> and can not be enabled in a system design.  But I expect that
> >>>>> strapping or firmware would disable those features so they are not
> >>>>> advertised in config space.
> >>>>>
> >>>>> If BIOS leaves features disabled because they cannot work, but at t=
he
> >>>>> same time leaves them advertised in config space, I'd say that's a
> >>>>> BIOS defect.  In that case, we should have a DMI quirk or something=
 to
> >>>>> work around the defect.
> >>>>
> >>>> That means most if not all BIOS are defected.
> >>>> BIOS vendors and ODM never bothered (and probably will not) to chang=
e
> >>>> the capabilities advertised by config space because "it already work=
s
> >>>> under Windows".
> >>>
> >>> This is what seems strange to me.  Are you saying that Windows never
> >>> enables these power-saving features?  Or that Windows includes quirks
> >>> for all these broken BIOSes?  Neither idea seems very convincing.
> >>>
> >>
> >> I see your point.  I was looking through Microsoft documentation for
> >> hints and came across this:
> >>
> >> https://learn.microsoft.com/en-us/windows-hardware/customize/power-set=
tings/pci-express-settings-link-state-power-management
> >>
> >> They have a policy knob to globally set L0 or L1 for PCIe links.
> >>
> >> They don't explicitly say it, but surely it's based on what the device=
s
> >> advertise in the capabilities registers.
> >
> > So essentially it can be achieved via boot time kernel parameter
> > and/or sysfs knob.
> >
> > The main point is OS should stick to the BIOS default, which is the
> > only ASPM setting tested before putting hardware to the market.
>
> Unfortunately; I don't think you can jump to this conclusion.
>
> A big difference in the Windows world to Linux world is that OEMs ship
> with a factory Windows image that may set policies like this.  OEM
> "platform" drivers can set registry keys too.

Thanks. This is new to me.

>
> I think the next ASPM issue that comes up what we (collectively) need to
> do is compare ASPM policy and PCI registers for:
> 1) A "clean" Windows install from Microsoft media before all the OEM
> drivers are installed.
> 2) A Windows install that the drivers have been installed.
> 3) A up to date mainline Linux kernel.
>
> Actually as this thread started for determining policy for external PCIe
> devices, maybe that would be good to check with those.

Did that before submitting the patch.
From very limited devices I tested, ASPM is enabled for external
connected PCIe device via TBT ports.

I wonder if there's any particular modification should be improved for
this patch?

Kai-Heng

>
> >
> > Kai-Heng
> >
> >>
> >>>>>> So the logic is to ignore the capability and trust the default set
> >>>>>> by BIOS.
> >>>>>
> >>>>> I think limiting ASPM support to whatever BIOS configured at boot-t=
ime
> >>>>> is problematic.  I don't think we can assume that all platforms hav=
e
> >>>>> firmware that configures ASPM as aggressively as possible, and
> >>>>> obviously firmware won't configure hot-added devices at all (in
> >>>>> general; I know ACPI _HPX can do some of that).
> >>>>
> >>>> Totally agree. I was not suggesting to limiting the setting at all.
> >>>> A boot-time parameter to flip ASPM setting is very useful. If none h=
as
> >>>> been set, default to BIOS setting.
> >>>
> >>> A boot-time parameter for debugging and workarounds is fine.  IMO,
> >>> needing a boot-time parameter in the course of normal operation is
> >>> not OK.
> >>>
> >>> Bjorn
> >>
>
