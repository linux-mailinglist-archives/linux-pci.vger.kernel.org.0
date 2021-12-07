Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D3446C433
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 21:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbhLGUMO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 15:12:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51316 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhLGUMN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 15:12:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8A97B81858;
        Tue,  7 Dec 2021 20:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CECFC341C3;
        Tue,  7 Dec 2021 20:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638907720;
        bh=7iECsE/Y/3WDH+hSKw/CvU9fAhHAsdUBKvj/iNSMXUA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eB2WlEkOxMKqWBG4/cC0k1LNrwvjHA7Tb0FsOXXKQXKo3OjZhY/XQ9H+7mTefDAnl
         TrPVdp5vn0/aHzmEenk/h+aWRxylWK2SZp3xXQMeXPG9JVcwB8IaSfb0aeYSG5lka2
         hWzXOkTh4wyXOGMqf0jDC80GmhIFAnYEl58IwHw5j9G8dFzNKOafKof7eub6qB3vOG
         v+uQ+UH13bh0RK4By3SgvYZGOGjS6Bo4z00wNXO5GorHJDVL65klhKPUcm8KA+E3Xx
         WwRln8ZGWbhHFYBUjOMYUraOFvE0Ubv+IS2Achv9Reay/Vs4iCUlNuYw2FIRydr/ok
         P6EQacgcAurBg==
Received: by mail-ed1-f44.google.com with SMTP id l25so374369eda.11;
        Tue, 07 Dec 2021 12:08:40 -0800 (PST)
X-Gm-Message-State: AOAM532X852r65PWOPHdNl0AP18qWjbxfUnhLF75DHXRBxXU3EImmM47
        bpEnQjYTAjTbehh5o2LToyvKvB1zdChJksiPLg==
X-Google-Smtp-Source: ABdhPJwA9TV+fIIiAm/3KclR1rrQon8NWQlFgkZJrXmBPVhVXjSQmWIYfL8TqwTlEeryByAj0Jv4ANoqhh9Y7EZxl9Y=
X-Received: by 2002:a05:6402:4251:: with SMTP id g17mr12237548edb.89.1638907718587;
 Tue, 07 Dec 2021 12:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20211206185242.2098683-1-f.fainelli@gmail.com>
 <20211206185242.2098683-2-f.fainelli@gmail.com> <CAL_JsqKaOkByjwYzyW6G_b90zRjCWVHvi2V0gBx_MJ8v2FmOaw@mail.gmail.com>
 <fc263ef8-10f8-206e-5df7-76f0b9d50fae@gmail.com>
In-Reply-To: <fc263ef8-10f8-206e-5df7-76f0b9d50fae@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 Dec 2021 14:08:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL6HV-C6+9Pna_8GVT5V+uEzcYcPDaS1m6AK8LhsWnFaw@mail.gmail.com>
Message-ID: <CAL_JsqL6HV-C6+9Pna_8GVT5V+uEzcYcPDaS1m6AK8LhsWnFaw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] ARM: dts: Cygnus: Fixed iProc PCIe controller properties
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 7, 2021 at 11:44 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 12/7/21 5:49 AM, Rob Herring wrote:
> > On Mon, Dec 6, 2021 at 12:52 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> Rename the msi controller unit name to 'msi' to avoid collisions
> >> with the 'msi-controller' boolean property and add the missing
> >> 'interrupt-controller' property which is necessary. We also need to
> >> re-arrange the 'ranges' property to show the two cells as being separate
> >> instead of combined since the DT checker is not able to differentiate
> >> otherwise.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  arch/arm/boot/dts/bcm-cygnus.dtsi | 14 ++++++++------
> >>  1 file changed, 8 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> >> index 8ecb7861ce10..ea19d1b56400 100644
> >> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> >> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> >> @@ -263,6 +263,7 @@ pcie0: pcie@18012000 {
> >>                         compatible = "brcm,iproc-pcie";
> >>                         reg = <0x18012000 0x1000>;
> >>
> >> +                       interrupt-controller;
> >
> > How is this a fix? This doesn't even work before v5.16 with commit
> > 041284181226 ("of/irq: Allow matching of an interrupt-map local to an
> > interrupt controller").
>
> What is the path forward? I suppose I could make the
> interrupt-controller property not required for this controller but then
> the default interrupt-controller schema is not terribly happy about
> seeing an interrupt-map/interrupt-map-mask properties without
> interrupt-controller.

There's certainly no requirement for having 'interrupt-controller'.
What error are you getting?

Rob
