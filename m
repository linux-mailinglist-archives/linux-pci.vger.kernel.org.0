Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294B6360E7A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 17:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhDOPQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 11:16:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233094AbhDOPNz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 11:13:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D360D613A9;
        Thu, 15 Apr 2021 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618499612;
        bh=gnCwUg8I/RSf0h2mo/u86eJvsrWWjx5n5P0C+aiTZms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jsXqeM1DZ9Pbi0TIf1LAc1x/cTz41yglDU1DiwKumU0UHb/AVzJeL/HbL9znhwHY+
         HGXBQr8kO3G578Ea+0v/daT5jKFjH7Wa3oAahxQeQTd9gTPPbjfw2imZ0Fz2bYQy4Z
         dwkeQC4/QQEST2sZl5pQ6mVxpPszSd3tBkmVsGI7Cw5i5haREtkOCtoDaj0qggwucL
         xIi+St1+gABHhiPraQFmFif6Ur7AkNNnrliCryDCVqeJxVKYkiZU12tYTSLf9bqlZD
         9tv6vF+HL/IjWgCTjrKhrNKeba7jdl0ScTrrfoiVkZiSJ/X+WzvQNR5og0UScJqRpx
         WJ9XujAE4TaSw==
Received: by mail-ed1-f53.google.com with SMTP id h10so28480775edt.13;
        Thu, 15 Apr 2021 08:13:32 -0700 (PDT)
X-Gm-Message-State: AOAM533sHoB5BLAv+Ovw5K+zmJaD1xcgchsObkzuEOU07WT0asnqPJZu
        rHJE+ZEEqeIIcFmO+zDARX3eHRC8DcA1SUocvA==
X-Google-Smtp-Source: ABdhPJwxfoJTLt7AJgzWRKNjUP7mZVPDURqIDUVhonvGhI1UgFtE8GSKjZvaIZcnAzBS3+qwQm+A9nTHwXqaPy5/22I=
X-Received: by 2002:a05:6402:1b1c:: with SMTP id by28mr4859088edb.62.1618499611519;
 Thu, 15 Apr 2021 08:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210412123936.25555-1-pali@kernel.org> <CAL_JsqLSse=W3TFu=Wc=eEAV4fKDGfsQ6JUvO3KyG_pnGTVg6A@mail.gmail.com>
 <20210415083640.ntg6kv6ayppxldgd@pali> <20210415104537.403de52e@thinkpad>
In-Reply-To: <20210415104537.403de52e@thinkpad>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 15 Apr 2021 10:13:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL2gjprb3MDv8KPSpe0CUBFjGajnMbF71DM+F9Yewp2uw@mail.gmail.com>
Message-ID: <CAL_JsqL2gjprb3MDv8KPSpe0CUBFjGajnMbF71DM+F9Yewp2uw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Set linux,pci-domain to zero
To:     Marek Behun <marek.behun@nic.cz>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 15, 2021 at 3:45 AM Marek Behun <marek.behun@nic.cz> wrote:
>
> On Thu, 15 Apr 2021 10:36:40 +0200
> Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> > On Tuesday 13 April 2021 13:17:29 Rob Herring wrote:
> > > On Mon, Apr 12, 2021 at 7:41 AM Pali Roh=C3=A1r <pali@kernel.org> wro=
te:
> > > >
> > > > Since commit 526a76991b7b ("PCI: aardvark: Implement driver 'remove=
'
> > > > function and allow to build it as module") PCIe controller driver f=
or
> > > > Armada 37xx can be dynamically loaded and unloaded at runtime. Also=
 driver
> > > > allows dynamic binding and unbinding of PCIe controller device.
> > > >
> > > > Kernel PCI subsystem assigns by default dynamically allocated PCI d=
omain
> > > > number (starting from zero) for this PCIe controller every time whe=
n device
> > > > is bound. So PCI domain changes after every unbind / bind operation=
.
> > >
> > > PCI host bridges as a module are relatively new, so seems likely a bu=
g to me.
> >
> > Why a bug? It is there since 5.10 and it is working.

I mean historically, the PCI subsystem didn't even support host
bridges as a module. They weren't even proper drivers and it was all
arch specific code. Most of the host bridge drivers are still built-in
only. This seems like a small detail that was easily overlooked.
unbind is not a well tested path.

> > > > Alternative way for assigning PCI domain number is to use static al=
located
> > > > numbers defined in Device Tree. This option has requirement that ev=
ery PCI
> > > > controller in system must have defined PCI bus number in Device Tre=
e.
> > >
> > > That seems entirely pointless from a DT point of view with a single P=
CI bridge.
> >
> > If domain id is not specified in DT then kernel uses counter and assign=
s
> > counter++. So it is not pointless if we want to have stable domain id.
>
> What Rob is trying to say is that
> - the bug is that kernel assigns counter++
> - device-tree should not be used to fix problems with how kernel does
>   things
> - if a device has only one PCIe controller, it is pointless to define
>   it's pci-domain. If there were multiple controllers, then it would
>   make sense, but there is only one

Yes. I think what we want here is a domain bitmap rather than a
counter and we assign the lowest free bit. That could also allow for
handling a mixture of fixed domain numbers and dynamically assigned
ones.

You could create scenarios where the numbers change on you, but it
wouldn't be any different than say plugging in USB serial adapters.
You get the same ttyUSBx device when you re-attach unless there's been
other ttyUSBx devices attached/detached.

Rob
