Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B786DF824
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjDLOPB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 10:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjDLOPA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 10:15:00 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349B419C;
        Wed, 12 Apr 2023 07:14:59 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id e20so10506680vsj.10;
        Wed, 12 Apr 2023 07:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681308898; x=1683900898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tz0zRW94Z/hmkdTJSfqG3WhRFcEFleZV0tRiJIInS+o=;
        b=P7XSviNYBBN4/cBFWoeR8Bo2jx+nVtrKpzKhddaicAm0flKyF+IzsIrxZzM3vtGWtO
         0KdRlgaZm9KNWQRy28Uu47HtjY6gZ8iNET7syOuICPuOozzSSGw2IKRYIZNDwHVkixxR
         JUfFLdN8lZBYEE+URai9CavDuTmZK/TLlF2JVLBxNt87gllBTW/FehgBv8jo1yK32vUZ
         IqSdcv+yf2QVoRwMrB6FtM7/Zk2SMupZlsAt+t6Ojenr3HO1ezkZ+trZmJDedEfr5NPM
         c4iTyz7pTk6bZYITPqvAHLXBnEK4KfYwGbqGKOCZncsa1X6dNYY0eVqmATBsCJp4ar3l
         dChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681308898; x=1683900898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tz0zRW94Z/hmkdTJSfqG3WhRFcEFleZV0tRiJIInS+o=;
        b=ID9cVQKz9WNhq5ww1tZBMrMjcIdwaOLSjmBLyP9uphtvocc8+My0beu8o0eYF6vDBR
         OZ38QV/35FDrXhOwmD0MrMzEiawqCxWDRts2c19qc67mXsRPOgzCubEpA0BzIePOlsCl
         9FUIcIvPQ9FrEnSxqOuLRq40YHUc7yxy93X1LefOCVAZSetMBtCDCWY16gkeU4hNo01t
         5F8hsi8oc4QyeT4S9d5peSZsgdmbb9iApV2EsOhRgwDdXBaVuZJU/4zJXm2pbJExVudz
         XGalx1ClWHnjKAz4zy5I9oHF6tul3ulbb1jL6AxTO+j4pA9Sdl7lwg9U8iMzO+PUR68E
         SnBA==
X-Gm-Message-State: AAQBX9e1N0Gk/HwiB+hIe3QctD7IVZ4VOSQQNH/f2tD7/fKgQ4LWBxhd
        9zOy4oLYdsskKfptLQO2LweGUviSjR6OTy9YlEU=
X-Google-Smtp-Source: AKy350avWMjBT0JOfHwbQHUPSOKOOj9paUb8BFRtQEd7/VdSYxRrFONuSauNTrFOpHN5ZBgIyAv1a8jmw5b/tp4wE9A=
X-Received: by 2002:a67:c311:0:b0:42c:9733:de2f with SMTP id
 r17-20020a67c311000000b0042c9733de2fmr1002823vsj.6.1681308898270; Wed, 12 Apr
 2023 07:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230411165919.23955-1-jim2101024@gmail.com> <20230411165919.23955-2-jim2101024@gmail.com>
 <5a28e520-63e4-dbcf-5b3e-e5097f02dea2@linaro.org> <78c18cdb-5757-8d30-e2a6-414f09505cc6@gmail.com>
 <66b7d0b9-9569-ddaf-89ca-5a0133074a17@linaro.org>
In-Reply-To: <66b7d0b9-9569-ddaf-89ca-5a0133074a17@linaro.org>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Wed, 12 Apr 2023 10:14:46 -0400
Message-ID: <CANCKTBtZt9QRkT4yAW5LsfHGf5TTL7tQ025H42+PPEi-=rWE8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: brcmstb: Add two optional props
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 12, 2023 at 7:56=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/04/2023 13:49, Florian Fainelli wrote:
> >
> >
> > On 4/12/2023 1:09 AM, Krzysztof Kozlowski wrote:
> >> On 11/04/2023 18:59, Jim Quinlan wrote:
> >>> Regarding "brcm,enable-l1ss":
> >>>
> >>>    The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOC=
s --
> >>>    requires the driver probe() to deliberately place the HW one of th=
ree
> >>>    CLKREQ# modes:
> >>>
> >>>    (a) CLKREQ# driven by the RC unconditionally
> >>>    (b) CLKREQ# driven by the EP for ASPM L0s, L1
> >>>    (c) Bidirectional CLKREQ#, as used for L1 Substates (L1SS).
> >>>
> >>>    The HW+driver can tell the difference between downstream devices t=
hat
> >>>    need (a) and (b), but does not know when to configure (c).  Furthe=
r, the
> >>>    HW may cause a CPU abort on boot if guesses wrong regarding the ne=
ed for
> >>>    (c).  So we introduce the boolean "brcm,enable-l1ss" property to i=
ndicate
> >>>    that (c) is desired.  Setting this property only makes sense when =
the
> >>>    downstream device is L1SS-capable and the OS is configured to acti=
vate
> >>>    this mode (e.g. policy=3D=3Dsuperpowersave).
> >>>
> >>>    This property is already present in the Raspian version of Linux, =
but the
> >>>    upstream driver implementaion that will follow adds more details a=
nd
> >>
> >> typo, implementation
> >>
> >>>    discerns between (a) and (b).
> >>>
> >>> Regarding "brcm,completion-timeout-us"
> >>>
> >>>    Our HW will cause a CPU abort if the L1SS exit time is longer than=
 the
> >>>    PCIe transaction completion abort timeout.  We've been asked to ma=
ke this
> >>>    configurable, so we are introducing "brcm,completion-timeout-us".
> >>>
> >>> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> >>
> >> What happened here? Where is the changelog?
> >
> > It is in the cover letter:
> >
> > https://lore.kernel.org/all/20230411165919.23955-1-jim2101024@gmail.com=
/
> >
> > but it does not look like the cover letter was copied to you or Rob.
>
> As you said, I did not get it.

Yes, sorry about that; I use a wrapper over the "cocci_cc" script and
I need to modify one or both scripts to send the cover to the
superset of recipients in the constituent commits.

Regards,
Jim Quinan
Broadcom STB
>
> Best regards,
> Krzysztof
>
