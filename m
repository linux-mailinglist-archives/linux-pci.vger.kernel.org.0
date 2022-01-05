Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577794855D1
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jan 2022 16:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbiAEP0j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 10:26:39 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57208 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241450AbiAEP0g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 10:26:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14171617C3;
        Wed,  5 Jan 2022 15:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F42C36AE0;
        Wed,  5 Jan 2022 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641396395;
        bh=slM2wX1aXPZ46StffNG6KvEcOYLEvQzBDRbikq0reHo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mO2/e5QnMNDHD1nj24ysdJSzEJToyi1UzudVHADsE9lgyWT7/rTLkYSN9B3KruCIB
         DSxUUbeBRbfAVlUewoCUZj1GV23X0heRPXsJ6+n5qoU+/jB7pEmkEFbxESaPVFLdTS
         EpZmhdMbiJzcK/6DdTMYnUb2zGhRXcx0DTFY4rUybstc65BkGlQ7GXytVEMUp2AcwN
         nWkLBsq7mRmC5K5nU/Y/b3WbXhl/cFLsh9IWGIxNPNmEoeegLkXoVbsz0eDs197rEl
         fDOqmTk+sxvgNouw6qDBXDaHtbLfDGydTf/fBWY6Mxm4jEbNB7Wu7vlABVmuBRxpxp
         TP2I2BFANGpZw==
Received: by mail-ed1-f50.google.com with SMTP id f5so163533519edq.6;
        Wed, 05 Jan 2022 07:26:35 -0800 (PST)
X-Gm-Message-State: AOAM532oqxVgfhjhao7+/ajkU9UwIKTd4ITwxg3Vy0iZOCOxTR37F/+m
        0m+STpO+I//8+iq89iZ4WLOoEgBLuvvTi96Ztw==
X-Google-Smtp-Source: ABdhPJytbKnns8+DeaPupbr3BISVlmi3eh+3VheybhbJ++seK/2uRbtZU/Ume8Kv3P+qDWe4KcGStzMcca9da2Gaq+s=
X-Received: by 2002:a05:6402:1691:: with SMTP id a17mr53827521edv.109.1641396393769;
 Wed, 05 Jan 2022 07:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20211031150706.27873-1-kabel@kernel.org> <YY6HYM4T+A+tm85P@robh.at.kernel.org>
 <20220105151444.7b0b216e@thinkpad> <CAL_Jsq+HjnDfDb+V6dctNZy78Lbz92ULGzCvkTWwSyop_BKFtA@mail.gmail.com>
 <20220105151410.wm5ti6kbjmvm5dwf@pali>
In-Reply-To: <20220105151410.wm5ti6kbjmvm5dwf@pali>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 5 Jan 2022 09:26:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL0mfRb7k4V-wjyGgjpB3pu88yPNT38k8zs-HoiVYaekQ@mail.gmail.com>
Message-ID: <CAL_JsqL0mfRb7k4V-wjyGgjpB3pu88yPNT38k8zs-HoiVYaekQ@mail.gmail.com>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add 'slot-power-limit-milliwatt'
 PCIe port property
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 5, 2022 at 9:14 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Wednesday 05 January 2022 08:27:21 Rob Herring wrote:
> > On Wed, Jan 5, 2022 at 8:14 AM Marek Beh=C3=BAn <kabel@kernel.org> wrot=
e:
> > >
> > > On Fri, 12 Nov 2021 09:25:20 -0600
> > > Rob Herring <robh@kernel.org> wrote:
> > >
> > > > On Sun, Oct 31, 2021 at 04:07:05PM +0100, Marek Beh=C3=BAn wrote:
> > > > > From: Pali Roh=C3=A1r <pali@kernel.org>
> > > > >
> > > > > This property specifies slot power limit in mW unit. It is a form=
-factor
> > > > > and board specific value and must be initialized by hardware.
> > > > >
> > > > > Some PCIe controllers delegate this work to software to allow har=
dware
> > > > > flexibility and therefore this property basically specifies what =
should
> > > > > host bridge program into PCIe Slot Capabilities registers.
> > > > >
> > > > > The property needs to be specified in mW unit instead of the spec=
ial format
> > > > > defined by Slot Capabilities (which encodes scaling factor or dif=
ferent
> > > > > unit). Host drivers should convert the value from mW to needed fo=
rmat.
> > > > >
> > > > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > > > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/pci/pci.txt | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Docu=
mentation/devicetree/bindings/pci/pci.txt
> > > > > index 6a8f2874a24d..7296d599c5ac 100644
> > > > > --- a/Documentation/devicetree/bindings/pci/pci.txt
> > > > > +++ b/Documentation/devicetree/bindings/pci/pci.txt
> > > > > @@ -32,6 +32,12 @@ driver implementation may support the followin=
g properties:
> > > > >     root port to downstream device and host bridge drivers can do=
 programming
> > > > >     which depends on CLKREQ signal existence. For example, progra=
mming root port
> > > > >     not to advertise ASPM L1 Sub-States support if there is no CL=
KREQ signal.
> > > > > +- slot-power-limit-miliwatt:
> > > >
> > > > Typo.
> > > >
> > > > But we shouldn't be adding to pci.txt. This needs to go in the
> > > > schema[1]. Patch to devicetree-spec list or GH PR is fine.
> > >
> > > Hello Rob,
> > >
> > > Pali's PR draft https://github.com/devicetree-org/dt-schema/pull/64
> > > looks like it's going to take some time to work out.
> > >
> > > In the meantime, is it possible to somehow get the
> > > slot-power-limit-milliwatt property merged into pci.txt so that we ca=
n start
> > > putting it into existing device-trees?
> > >
> > > Or would it break dt_bindings_check if it isn't put into dt-schema's
> > > pci-bus.yaml?
> > >
> > > Or should we simply put it into current version of pci-bus.yaml and
> > > work out the split proposed by Pali's PR afterwards?
> >
> > In the existing pci-bus.yaml is fine.
>
> Hello Rob! I do not think that it is possible to add this property
> correctly in to the existing pci-bus.yaml file. As this file is not
> prepared for slot properties. And I guess that adding new property at
> "random" place is against the idea of schema validation (that validation
> procedure accepts only valid DTS files).

The only issue I see is the property would be allowed in host bridge
nodes rather than only root port or PCIe-PCIe bridge nodes because the
current file is a mixture of all of those. I think a note that the
property is not valid in host bridge nodes would be sufficient. It's
still better than documenting in pci.txt.

Rob
