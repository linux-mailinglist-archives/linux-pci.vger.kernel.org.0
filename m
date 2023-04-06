Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC49F6D9E18
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 18:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbjDFQ7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 12:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbjDFQ7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 12:59:14 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F405C86AD;
        Thu,  6 Apr 2023 09:59:11 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id 89so28344342uao.0;
        Thu, 06 Apr 2023 09:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680800351; x=1683392351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzgZMjmyilDK0vxgLwTlV9yeH+l2cEpSp2Bl21notZo=;
        b=o75whDe28ydpvkPSg6h/vGRc1PGHvKrIZtllG9FsuE0Uw1i9ETcfxIWiY+bbMRHreQ
         rzj20icFhtnbMRNEiJLHz1dDk1EnM5UXuEWKd7sTvvOIbj5nlZt10ol8nc5FI+7Gue3t
         zbHmT8VXdkW0AO89t21TH0p6KNqnxkx4Y2rL/+eWcsUuaWHC4Eo47go7cwsE/d8IoCDn
         7eMMvvhjkhnQRYekTICP2N4K3BykA6GS8ulmj2dAXxUIGzdEF8yN8cNMFqmJZYYUNzIn
         hi3ckYk/7LdG2Q8LKPo4nIfdiOS0g1R9mL8P2Pufh4smUjTPDIRFMaVOPrk8ahd1Hy3f
         SOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680800351; x=1683392351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzgZMjmyilDK0vxgLwTlV9yeH+l2cEpSp2Bl21notZo=;
        b=ljKSNK9fymwXC8rZVb8GpgyIUEUlQi2Ci6MZPETRNf9QLw6m7dR0z1KVHXIJ9CsBQ4
         I98KeljJiA54uURVN+MXYDMDureJAy1X1SI57cW43HSpcj6IhHiT/2WN6zT6Q3pJEGiD
         EZGWV3ef6LqaLW+N5HJOpwM+4+cxXaEVFFiV1n4WINl9ZSQLKhbJdVUO1en5LjfmpZpX
         kBntPltZtHu0u1szXCsLRByQveURGpY6GXDHo2mLCmZqu4YS4ATl8q5kdUzbg7Ss26s6
         lecZOjm/iousTM4v+CB5bVSDmdvSgQqPmY9oJpn44Zt7RijGuprLODYcr8a3z8gDHGTX
         npVQ==
X-Gm-Message-State: AAQBX9drB6i+Ghq9YNoMC9q5bF5UPaYvhv+CsG0Y8cIhja29WGTQYqsL
        85kbprZhbTyfzfuUbPnsjDxeZXKJCJZCks7AAB4=
X-Google-Smtp-Source: AKy350ZecX1xLXmTv4dqWxVP4QUFmOl+H6LGKFNRot6c2VPicJ/IwXePNfjoY5oXZsDeU/SzuynbQGg3j0Z0qRaeWd0=
X-Received: by 2002:a9f:305c:0:b0:68a:5c52:7f2b with SMTP id
 i28-20020a9f305c000000b0068a5c527f2bmr6999125uab.1.1680800350908; Thu, 06 Apr
 2023 09:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230406124625.41325-1-jim2101024@gmail.com> <20230406124625.41325-2-jim2101024@gmail.com>
 <d0bf241b-ead4-94b7-3f03-a26227f9eb58@i2se.com>
In-Reply-To: <d0bf241b-ead4-94b7-3f03-a26227f9eb58@i2se.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Thu, 6 Apr 2023 12:58:59 -0400
Message-ID: <CANCKTBsLxkPb1ajACkyhJk6J1aB2iwX0oKifHkADG0fFPUqMhQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: brcmstb: Add two optional props
To:     Stefan Wahren <stefan.wahren@i2se.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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

On Thu, Apr 6, 2023 at 11:39=E2=80=AFAM Stefan Wahren <stefan.wahren@i2se.c=
om> wrote:
>
> Hi Jim,
>
> Am 06.04.23 um 14:46 schrieb Jim Quinlan:
> > Regarding "brcm,enable-l1ss":
> >
> >    The Broadcom STB/CM PCIe HW -- which is also used by RPi SOCs -- req=
uires
> >    the driver probe to configure one of three clkreq# modes:
> >
> >    (a) clkreq# driven by the RC
> >    (b) clkreq# driven by the EP for ASPM L0s, L1
> >    (c) bidirectional clkreq#, as used for L1 Substates (L1SS).
> >
> >    The HW can tell the difference between (a) and (b), but does not kno=
w
> >    when to configure (c).  Further, the HW will cause a CPU abort on bo=
ot if
> >    guesses wrong regarding the need for (c).  So we introduce the boole=
an
> >    "brcm,enable-l1ss" property to indicate that (c) is desired.  This
> >    property is already present in the Raspian version of Linux, but the
> >    driver implementaion that will follow adds more details and discerns
> >    between (a) and (b).
> >
> > Regarding "brcm,completion-timeout-msecs"
> >
> >    Our HW will cause a CPU abort if the L1SS exit time is longer than t=
he
> >    completion abort timeout.  We've been asked to make this configurabl=
e, so
> >    we are introducing "brcm,completion-abort-msecs".
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >   .../devicetree/bindings/pci/brcm,stb-pcie.yaml       | 12 +++++++++++=
+
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b=
/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index 7e15aae7d69e..ef4ccc05b258 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -64,6 +64,18 @@ properties:
> >
> >     aspm-no-l0s: true
> >
> > +  brcm,enable-l1ss:
> > +    description: Indicates that the downstream device is L1SS
> > +      capable and L1SS is desired, e.g. by setting
> > +      CONFIG_PCIEASPM_POWER_SUPERSAVE=3Dy.  Note that CLKREQ#
>
> not sure about this, but maybe we should avoid references to Linux
> kernel config parameter in a DT binding. Since the driver already gaves
> warning in case the DT parameter is present, but kernel config doesn't
> fit, this should be enough.

Hello Stefan,
I will remove this reference.
>
> > +      assertion to clock active must be within 400ns.
> > +    type: boolean
> > +
> > +  brcm,completion-timeout-msecs:
> > +    description: Number of msecs before completion timeout
> > +      abort occurs.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> According to the driver at least 0 is not allowed, maybe we should
> define minimum and maximum here and let dtbs_check take care of invalid
> values?
I'm not sure I follow what you mean about a zero value;  the property
may have any value but the driver will clamp it
to a minimum of ~30msec.  Regardless, I can add a  "minimum: 30" line
to the YAML.

Thanks,
Jim Quinlan
Broadcom STB
>
> Best regards
>
> > +
> >     brcm,scb-sizes:
> >       description: u64 giving the 64bit PCIe memory
> >         viewport size of a memory controller.  There may be up to
