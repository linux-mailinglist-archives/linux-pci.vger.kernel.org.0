Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0399D2B0669
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 14:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgKLNZS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 08:25:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgKLNZR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Nov 2020 08:25:17 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEB512224E;
        Thu, 12 Nov 2020 13:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605187516;
        bh=0S9Ca5zJ7bjT8Vjgj3PHZvQXR6APITbF8c6A9gq6VTg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D6gEoa6uMrlTcVmKpU1ba4gwfaufRkvsEMPvXWRtboTzCIk4XNL6UpgqlfqSZ9Zin
         fVoz3dY/YI/fxztgPKI3oe1+o9nA51ao9m8Di3mYYaKIprIKdD3yut4xBnNZBSWdad
         /bvIXoFxYPFLLpnAlePjN/3gGIfnwQnmim/XkmmM=
Received: by mail-oi1-f169.google.com with SMTP id t143so6297134oif.10;
        Thu, 12 Nov 2020 05:25:16 -0800 (PST)
X-Gm-Message-State: AOAM531DcpijDvw4ZoU3aJPd2K6yCEhi3SxokEKH4BLbsEt2xsMSdVKf
        OflK8tsJ0qdOmV47Bqj+65qPVpEG6/FqPWzFyRY=
X-Google-Smtp-Source: ABdhPJymDESsvudCUun4XJC3EAUxQ5lXPZ0Iyd9DNYW1P1XChwL4Y3Hh/ut77Mm2Ni1RNDAYtpKfxIYCd7jOm5tT7P0=
X-Received: by 2002:aca:3c54:: with SMTP id j81mr5673905oia.11.1605187515847;
 Thu, 12 Nov 2020 05:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20200930153519.7282-16-kishon@ti.com> <VI1PR04MB496061EAB6F249F1C394F01092EA0@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <d6d27475-3464-6772-2122-cc194b8ae022@ti.com> <VI1PR04MB49602D24F65E11FF1F14294F92E90@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <30c8f7a1-baa5-1eb4-d2c2-9a13be896f0f@ti.com> <CAK8P3a38vBXbAWE09H+TSoZUTkFdYDcQmXX97foT4qXQc8t5ZQ@mail.gmail.com>
 <5a9115c8-322e-ffd4-6274-ae98c375b21d@ti.com>
In-Reply-To: <5a9115c8-322e-ffd4-6274-ae98c375b21d@ti.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 12 Nov 2020 14:24:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a33XSvenqBhuQpGmtLbYydyzY2OQh73150TJtpzW24DTw@mail.gmail.com>
Message-ID: <CAK8P3a33XSvenqBhuQpGmtLbYydyzY2OQh73150TJtpzW24DTw@mail.gmail.com>
Subject: Re: [PATCH v7 15/18] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Sherry Sun <sherry.sun@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "tjoseph@cadence.com" <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 10, 2020 at 4:42 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> On 10/11/20 8:29 pm, Arnd Bergmann wrote:
> > On Tue, Nov 10, 2020 at 3:20 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >> On 10/11/20 7:55 am, Sherry Sun wrote:
> >
> >>> But for VOP, only two boards are needed(one board as host and one board as card) to realize the
> >>> communication between the two systems, so my question is what are the advantages of using NTB?
> >>
> >> NTB is a bridge that facilitates communication between two different
> >> systems. So it by itself will not be source or sink of any data unlike a
> >> normal EP to RP system (or the VOP) which will be source or sink of data.
> >>
> >>> Because I think the architecture of NTB seems more complicated. Many thanks!
> >>
> >> yeah, I think it enables a different use case all together. Consider you
> >> have two x86 HOST PCs (having RP) and they have to be communicate using
> >> PCIe. NTB can be used in such cases for the two x86 PCs to communicate
> >> with each other over PCIe, which wouldn't be possible without NTB.
> >
> > I think for VOP, we should have an abstraction that can work on either NTB
> > or directly on the endpoint framework but provide an interface that then
> > lets you create logical devices the same way.
> >
> > Doing VOP based on NTB plus the new NTB_EPF driver would also
> > work and just move the abstraction somewhere else, but I guess it
> > would complicate setting it up for those users that only care about the
> > simpler endpoint case.
>
> I'm not sure if you've got a chance to look at [1], where I added
> support for RP<->EP system both running Linux, with EP configured using
> Linux EP framework (as well as HOST ports connected to NTB switch,
> patches 20 and 21, that uses the Linux NTB framework) to communicate
> using virtio over PCIe.
>
> The cover-letter [1] shows a picture of the two use cases supported in
> that series.
>
> [1] -> http://lore.kernel.org/r/20200702082143.25259-1-kishon@ti.com

No, I missed, that, thanks for pointing me to it!

This looks very  promising indeed, I need to read up on the whole
discussion there. I also see your slides at [1]  that help do explain some
of it. I have one fundamental question that I can't figure out from
the description, maybe you can help me here:

How is the configuration managed, taking the EP case as an
example? Your UseCase1 example sounds like the system that owns
the EP hardware is the one that turns the EP into a vhost device,
and creates a vhost-rpmsg device on top, while the RC side would
probe the pci-vhost and then detect a virtio-rpmsg device to talk to.
Can it also do the opposite, so you end up with e.g. a virtio-net
device on the EP side and vhost-net on the RC?

     Arnd

[1] https://linuxplumbersconf.org/event/7/contributions/849/attachments/642/1175/Virtio_for_PCIe_RC_EP_NTB.pdf
