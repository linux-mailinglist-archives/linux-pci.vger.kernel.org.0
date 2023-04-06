Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0716DA227
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbjDFUDU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 16:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbjDFUDT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 16:03:19 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF4D83F6;
        Thu,  6 Apr 2023 13:03:17 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id 89so28679712uao.0;
        Thu, 06 Apr 2023 13:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680811397; x=1683403397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9YviVE4toQnrtzCPO6XOjjEzLVIEKbX+K4ppRd4TZg=;
        b=GHAtblByljW2ipQbn8M/4ZR0hTZ3zT8TMsAiD8KPNWUH/LxlspKJYQZBHcUQMQXbOT
         s1uD04wTWGlL6ed+7Q5T3fMZLedG7ZLlnrLdVyuFhQyfjULNf97+9fu1MhoCxqNFk0BT
         uIr8EznJoOWiF8tg6pILJHNXm0pTJ6yqVN4tMG7KWnh7xu2QFwUdG8DdXQ/NK3PAr9SE
         9ynCHGOljuvy9GGfinlSLik+ZS+WGxIf26YsKs+4DhOkx64EUettEa7Qdo9vz2c8xVMa
         jlXRaZ6IKwG3B1msopw/xL37jzNprOUX/ZuepnQ2WPfcOqn9dX8yvke4f4Ulx+lbBFPc
         dnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680811397; x=1683403397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9YviVE4toQnrtzCPO6XOjjEzLVIEKbX+K4ppRd4TZg=;
        b=HDHEj/rukQaVBwKf/mdcxK3WI2JVSEsUDQSkgSREm3mu76q9vFUKK4pi1zJGaVM0Rd
         nKpfl0sc1vBsDq8GeIONTBWeFAJfhg4DfInXLsYdCse+EhVnokAeeVNFC4HK7ixz38g8
         cL+OKnj8PULd1tDOabwMa5bySLxM8SJUiwyaPjl3VKpMR+dFuQB2MfpnilOs+WdkbsH6
         tTdhSm0EZU52N4RllKYP1SD9PuWMauAyFsZysCm1AiSd3/bhDP1htKHWqsmyq0v/n4wR
         6fZT5kecx6OaE33MG2hR7dqprh90d4fIdo5/NoiEl5st4YDh7CvYErOwTi9L21/jVsUq
         mK+w==
X-Gm-Message-State: AAQBX9eXBKooyeDIHdBekiAhBp5+wx2ZXLtdEHEgQLaSF3kO18cpmfwi
        mKs5FOISvkClOcjfIvVTqgnW/5kOt6KqPa0513M=
X-Google-Smtp-Source: AKy350YHD3+dB/WoMTUGvAh8mayipMNsIw5IpvaixWZ6REcZ8LZF53uTV2/6njC+FuE7d+bQnnGbcjCZcT7EVT2Afdo=
X-Received: by 2002:ab0:7ce:0:b0:68d:6360:77b with SMTP id d14-20020ab007ce000000b0068d6360077bmr7357349uaf.1.1680811396706;
 Thu, 06 Apr 2023 13:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230406124625.41325-3-jim2101024@gmail.com> <20230406190953.GA3723665@bhelgaas>
In-Reply-To: <20230406190953.GA3723665@bhelgaas>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Thu, 6 Apr 2023 16:03:05 -0400
Message-ID: <CANCKTBsLuxGq1fBNcasLRuStELSknDGH3C-e+EbKy-rfw4L18Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] PCI: brcmstb: Clkreq# accomodations of downstream device
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 6, 2023 at 3:09=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Thu, Apr 06, 2023 at 08:46:23AM -0400, Jim Quinlan wrote:
> > The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, may b=
e
> > set into three mutually exclusive modes:
> >
> >   (a) No clkreq# expected or required, refclk is always available.
> >   (b) Clkreq# is expected to be driven by downstream device when needed=
.
> >   (c) Bidirectional clkreq# for L1SS capable devices.
> >
> > Previously, only (b) was supported by the driver, as almost all STB boa=
rds
> > operate in this mode.  But now there is interest in activating L1SS pow=
er
> > savings from STB customers, and also interest in accomodating mode (a) =
for
> > designs such as the RPi CM4 with IO board.
> >
> > The HW can tell us when mode (a) mode is needed.  But there is no easy =
way
> > to tell if L1SS mode is needed.  Unfortunately, getting this wrong caus=
es a
> > panic during boot time.  So we rely on the DT prop "brcm,enable-l1ss" t=
o
> > tell us when mode (c) is desired.  This property has already been in
> > use by Raspian Linux, but this immplementation adds more details and
> > discerns between (a) and (b) automatically.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217276
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
>
> > +      * We have "seen" clkreq# if it is asserted or has been in the pa=
st.
> > +      * Note that the CLKREQ_IN_MASK is 1 if clkreq# is asserted.
>
> "CLKREQ#" to match PCIe spec and comments below.

Will do.
>
> > +     if (l1ss && IS_ENABLED(CONFIG_PCIEASPM)) {
> > +             /*
> > +              * Note: This (l1ss) mode may not meet requirement for
> > +              * Endpoints that require CLKREQ# assertion to clock acti=
ve
> > +              * within 400ns.
> > +              */
> > +             clkreq_set |=3D PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABL=
E_MASK;
> > +             dev_info(pcie->dev, "bi-dir clkreq; l1ss-capable devs onl=
y\n");
> > +             dev_info(pcie->dev, "ASPM policy must be set to powersupe=
rsave\n");
>
> Seems problematic since L1SS can be enabled/disabled at run-time:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/ABI/testing/sysfs-bus-pci?id=3Dv6.2#n420

Yes it is problematic.  AFAICT there are no notifier chain for
changing modes; you probably don't want me to add one and neither do I
:-).
Our HW should shift gears when there is a change the standard L1SS
control field, but it does not -- more on this below.

>
> The simplistic answer is to advertise L1SS support if and only if you
> can safely support it.
We can only safely support it if we know a priori that (a) the
downstream device is ASPM capable and (b) the policy is set to
"power_supersave" and will not be changed.

For (a), I thought about having the RC probe "peek" at the downstream
devices capabilities, but that would require it to go through the
capability linked-list.  I have a feeling that would not be approved
by you folks.

For (b), there is no way to know at RC probe-time that the policy is
going to be "power_supersave".  This calculation happens after the RC
probe exits, and besides, pcie_aspm_get_policy() is a static function.
And as you mentioned, the ASPM policy may be changed at runtime.
That is the reason for the "brcm,enable-l1ss" property.

>
> I don't know why this is an issue for this device but not others.  Is
> it because there's some problem in the way the board is designed?  Or
> (after skimming the bugzilla) maybe a problem with the plug-in cards?
FWIW,  it's  not clear that all of the devices for drivers in
drivers/pci/controller/  support L1SS -- our driver had no mention of
ti until now.

However, I asked the PCIe HW design engineer a question similar to
yours; i.e. from looking at all of the drivers' code  as well as
pcie/asmp.c,  there doesn't seem to be any issue wrt  seamlessly
switching between uni-dir and bi-dir CLKREQ# in response to ASPM
control settings.  He just answered something on the lines that for
this design, one has to make a deliberate choice of L1SS or !L1SS and
stick with it.

Regards,
Jim Quinlan
Broadcom STB


>
> Bjorn
