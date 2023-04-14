Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536156E2CBF
	for <lists+linux-pci@lfdr.de>; Sat, 15 Apr 2023 01:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjDNXOV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 19:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNXOT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 19:14:19 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEA230D8;
        Fri, 14 Apr 2023 16:14:14 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id f10so6435157vsv.13;
        Fri, 14 Apr 2023 16:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681514054; x=1684106054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3KoqWEFOQErtfJ1mUHNd+4peLdmkbt18zhWyKIO3VU=;
        b=UUeZ1FlVobxdVDawxsaGCTLhs2wGIPZcn8by17G1yOIAzPa0sU4ChcIiC1WSYNbjSC
         j0/qQ1j4ugG2A4Mx7G1CHx2TViJ1zPly+Fp9tGnPJ0h+AGMDsiTX+kystbCZ97dLCypE
         Gg+G447QEZ1G4RydZnKj/va+QhcTve8fseSiTyU6xB3viP95PJ60Pjrwat05vIsAPGJL
         VCNwGwrwBXXKw/2FRJFEo9X8MXQHXhGm8rfJX1Hq+ZMVTepYK/AZ6/OQZqOccXBhOX6r
         GaIrVL3w+b877sy5cqZSxmbxPzcpmf4GUIUbQJb/B7GjsLg+5TUZMrjkfVRetMW24tBS
         8Ggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681514054; x=1684106054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3KoqWEFOQErtfJ1mUHNd+4peLdmkbt18zhWyKIO3VU=;
        b=PVeCcog0cpK964WPKlmx4Hr5twpQtxCX33PP4y5uYSoOyyHSvqAJ86TzzyQf99WYH7
         f1r05g/NpjHVOcp5t3WqrdwnmFZVHOjJN9x62IZUDJ8BKPEMheXuPJjEqIgYmnCSeMOH
         A8lgcitjhGTaSi7XYGR6x/YhEv1a6QtBXJ0lCY0uHd4avicHRzaKhyQFUGws2iwcZ7Cr
         tehQFl/vgYd3R8PtNOqtclRZrMjrWQ6rqc/N0GHLC02zTOD/k+keRVp7qOlU8yUMNSJC
         oR70Kb3nui9CkTvIavPX5bNVt4INJ0qPY1BtnIO5rQm9COOpcydBHltaMzsaB+mnQREM
         ZBMA==
X-Gm-Message-State: AAQBX9fjipkwoCnHbHPjWlVFP1PYhIKfv7tx33SmTUSMwHvuhTTnYr+M
        bId4CLMBkBGU1oqXhMOS1tZuH3QcAyrarFnrpUg=
X-Google-Smtp-Source: AKy350bY+Rj1iBv3+I4DNMQl7Y0A6jOIUaTT7SrTg17WbxYSAT8/tn4nWscFldhdXk/dTv10vUqQr5rlXwCIItyaW10=
X-Received: by 2002:a67:d514:0:b0:423:e2c4:351e with SMTP id
 l20-20020a67d514000000b00423e2c4351emr4145114vsj.6.1681514053897; Fri, 14 Apr
 2023 16:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230411165919.23955-3-jim2101024@gmail.com> <20230414202720.GA215111@bhelgaas>
In-Reply-To: <20230414202720.GA215111@bhelgaas>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 14 Apr 2023 19:14:02 -0400
Message-ID: <CANCKTBuBZ5j+MqD9_uudvESO5WGC5hqCK1Sd4vD-CBzHsv+0zA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: brcmstb: CLKREQ# accomodations of downstream device
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 14, 2023 at 4:27=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> This subject line no verb.  Can you add a leading verb to suggest what
> this patch does?
>
> s/accomodations/accommodations/
>
> On Tue, Apr 11, 2023 at 12:59:17PM -0400, Jim Quinlan wrote:
> > The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, must =
be
> > deliberately set by the probe() into one of three mutually exclusive mo=
des:
> >
> >   (a) No CLKREQ# expected or required, refclk is always available.
> >   (b) CLKREQ# is expected to be driven by downstream device when needed=
.
> >   (c) Bidirectional CLKREQ# for L1SS capable devices.
> >
> > Previously, only (b) was supported by the driver, as almost all STB/CM
> > boards operate in this mode.  But now there is interest in activating L=
1SS
> > power savings from STB/CM customers, and also interest in accomodating =
mode
> > (a) for designs such as the RPi CM4 with IO board.
>
> accommodating
>
> > The HW+driver is able to tell us when mode (a) mode is needed.  But the=
re
> > is no easy way to tell if L1SS mode should be configured.  In certain
> > situations, getting this wrong may cause a panic during boot time.  So =
we
> > rely on the DT prop "brcm,enable-l1ss" to tell us when mode (c) is desi=
red.
> > Using this mode only makes sense when the downstream device is L1SS-cap=
able
> > and the OS has been configured to activate L1SS
> > (e.g. policy=3D=3Dpowersupersave).
>
> I'm really concerned about the user experience here.  I assume users
> do not want to edit the DT based on what device they plug in.  They
> shouldn't need to (and probably won't) know whether the device
> supports L1SS.
>
> I hate kernel/module parameters, but I think even that would be better
> then having to edit the DT.
>
> There's obviously a period of time when L1SS is supported but not yet
> enabled, so I'm *guessing* the "OS has been configured to activate
> L1SS" is not actually a requirement, and choosing (c) really just
> opens the possibility that L1SS can be used?

Yes.  Before this patch series we had two panic scenarios:

(a) Endpoint devices with no CLKREQ# connection
(b) Endpoints that are L1SS-capable

Even without  the "brcm,enable-l1ss" property present, both (a) and
(b) should be eliminated.
The reason (b) is eliminated is because the RC driver now unadvertises
 RC L1SS by default; subsequently, Linux does
not turn it on.  So the default setting should be fine for all devices.

For those folks who have L1SS capable devices and desire L1SS power
savings, they can add
the brcm,enable-l1ss property.  But everyone should have functionality
 w/o doing anything.

As I am typing this I realize that my comments and dev_info()s  are not
aligned with what I am saying so I will change them in V3.  Sorry
about the confusion.

>
> Would be nice to have a hint (maybe a line or two of the panic
> message) to help users find the fix for a problem they're seeing.SS
>
> Obviously the ideal would be if we could use (c) in all cases, so I
> assume that's where a panic might happen.  What situation would that
> be?  An endpoint that doesn't support L1SS?  One that supports L1SS
> but it's not enabled?  Maybe if L1SS isn't configured correctly, e.g.,
> LTR values programmed wrong?

Let me test everything on Monday and get back to you before I make any
statements.


Regards,
Jim Quinilan
Broadcom STB

>
> Bjorn
