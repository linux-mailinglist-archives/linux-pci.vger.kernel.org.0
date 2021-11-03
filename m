Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F9A44499A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 21:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhKCUhY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 16:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKCUhY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 16:37:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350F5C061203
        for <linux-pci@vger.kernel.org>; Wed,  3 Nov 2021 13:34:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o14so5366501wra.12
        for <linux-pci@vger.kernel.org>; Wed, 03 Nov 2021 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yco9evUJj0CBgwCmjM2Iq7hySweqrEh+7cAP7IGEsfA=;
        b=OMJBnz0JgdbyGPIYCxZw64eTbuYgtnzgFLs5YAgMI+PzhnDW7MVC/uEsyGf4fGrblZ
         CTIzjyNi7zTOV5kvEmCgpX9auPo1y0ZPyI5lHGYkYarjBjMvkAVmZ/pH2FCM9W7zGU2/
         XHwennbVtuFNnz2FmOC9TuXEP+GR3Vm+STANs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yco9evUJj0CBgwCmjM2Iq7hySweqrEh+7cAP7IGEsfA=;
        b=nh5uL9JXCSggs9qMw6AphHntqIf6N8mf2PaSs75xuOn5UV/m3JCMAJoGkwso0gJOlr
         rGzG5Olz30TAaNQcIxI/dzrNJvUGOGnRG/ljprez/lVwgIBgunRJ49HQ84KvYXKfHhg/
         sElGC1t1Te9oWU34fppjshy9Ee6WxCJ+JlOlI9LzWQFuWT+ceh4WxS5WljtVU74w5Per
         T9gGAC63hdkHK/6aCtI5xyiK5Z4gIKk/KCS49Uqg3CvR4YHwdGwmtEo6u6Z0OvJd03Ri
         OLexwl4/aZo5+4linYFOpzk3scqVTu5fz7GOLWdG1H4NdS7Mqhv8YdvMmhf7HL4Hg2Dq
         J1XQ==
X-Gm-Message-State: AOAM533edDeP/IJ29PS0piyBb0Sh0pN672JFVZggsz8xe51uC8Qn5g1u
        P9FG0eH8fbdAX9jhHKlVNwYH0AIVZVD+Is/F2Tv7sg==
X-Google-Smtp-Source: ABdhPJxWOzzblfarSMnvULC1Bu1z2O8qU/zTIWQbnShf1doancfUJreB7+Z8Yen6p47mS7hcOyU1jg6y2XGz79dFD2k=
X-Received: by 2002:adf:ba87:: with SMTP id p7mr58590678wrg.282.1635971685804;
 Wed, 03 Nov 2021 13:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211103184939.45263-1-jim2101024@gmail.com> <20211103184939.45263-6-jim2101024@gmail.com>
 <YYLm3z0MAgBK24z5@sirena.org.uk> <CA+-6iNzkg4R8Kt=Q=sgdB++HHStRSHRUOUTvAfjZr31-FUrzNA@mail.gmail.com>
In-Reply-To: <CA+-6iNzkg4R8Kt=Q=sgdB++HHStRSHRUOUTvAfjZr31-FUrzNA@mail.gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 3 Nov 2021 16:34:34 -0400
Message-ID: <CA+-6iNziZv0UycoaoFhscmp39Z2Y2bHrWUpFW4f9MBK-uM24qA@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] PCI: brcmstb: Add control of subdevice voltage regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 3, 2021 at 4:25 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> On Wed, Nov 3, 2021 at 3:45 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Wed, Nov 03, 2021 at 02:49:35PM -0400, Jim Quinlan wrote:
> >
> > > +     for_each_property_of_node(dn, pp) {
> > > +             for (i = 0; i < ns; i++) {
> > > +                     char prop_name[64]; /* 64 is max size of property name */
> > > +
> > > +                     snprintf(prop_name, 64, "%s-supply", supplies[i]);
> > > +                     if (strcmp(prop_name, pp->name) == 0)
> > > +                             break;
> > > +             }
> > > +             if (i >= ns || pcie->num_supplies >= ARRAY_SIZE(supplies))
> > > +                     continue;
> > > +
> > > +             pcie->supplies[pcie->num_supplies++].supply = supplies[i];
> > > +     }
> >
> > Why are we doing this?  If the DT omits the supplies the framework will
> > provide dummy supplies so there is no need to open code handling for
> > supplies not being present at all in client drivers.  Just
> > unconditionally ask for all the supplies.
>
> I did it to squelch the "supply xxxxx not found, using dummy
> regulator" output.  I'll change it.
Now I remember: if I know there are no vpciexxx-supplly props in the
DT, I can skip executing all of the buik regulator calls entirely, as
well as walking the PCI bus as in brcm_regulators_off().

Do you consider this a valid reason?

Jim

Jim

Jim

> Regards, Jim
