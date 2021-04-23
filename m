Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A6236963C
	for <lists+linux-pci@lfdr.de>; Fri, 23 Apr 2021 17:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243021AbhDWPea (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Apr 2021 11:34:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242895AbhDWPe3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Apr 2021 11:34:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3745361404;
        Fri, 23 Apr 2021 15:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619192032;
        bh=QOp4de/9uQQA0OFirIJW02IaDZzDc3LM6U5v+efYCMc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hfbb83yBXNG1LPqHGrChhTYfrqMDkO0AYLoNYEUVHJSPSkiCD7gIjaLGAXvDJnNoe
         /LGY7+jwr83EX4BCwu80L+3R3Xqa0pYgkWhLpuvv5UAIndcLDcR6QAFjvJRXp8XrEO
         H4DkLsho94e33elxX/zA1xsB62CGU4Opm3/rcEkB0KAi8qlz8KXqtLSNYOPC/xzIvw
         7QpjFCFP+g10A1Son5Pky6fmXg3n4mXgUQwKgWs0O/KMKXQQMnQ1PqUYlsmTXjK9br
         ezVSX7PDgRctWdEpLY/WK7B2hm3KqrpE2IK+XSjw2i0tar0d+I/bOC4pmI2SVuR06U
         B8n0Cx269qUrQ==
Received: by mail-ej1-f43.google.com with SMTP id x12so53752792ejc.1;
        Fri, 23 Apr 2021 08:33:52 -0700 (PDT)
X-Gm-Message-State: AOAM530eaY2cCYNRrl6WmySzqSYqNT0ihu+9SDzA6BTxz86pCa5EYPxM
        /kx6ysRPMSN1mGX8yQpbYNWQ7Id1eeI9pfQmag==
X-Google-Smtp-Source: ABdhPJyfWOtsDBQROCjWq27rZ2l9c0TwkIqYqRDw6ibCGWrX5ABqUZ6666mg7n+477i1EzdvyCboYTXRxKYb0jvHExU=
X-Received: by 2002:a17:907:217b:: with SMTP id rl27mr4877151ejb.359.1619192030632;
 Fri, 23 Apr 2021 08:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210412123936.25555-1-pali@kernel.org> <CAL_JsqLSse=W3TFu=Wc=eEAV4fKDGfsQ6JUvO3KyG_pnGTVg6A@mail.gmail.com>
 <20210415083640.ntg6kv6ayppxldgd@pali> <20210415104537.403de52e@thinkpad>
 <CAL_JsqL2gjprb3MDv8KPSpe0CUBFjGajnMbF71DM+F9Yewp2uw@mail.gmail.com> <20210417144953.pznysgn5rdraxggx@pali>
In-Reply-To: <20210417144953.pznysgn5rdraxggx@pali>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 23 Apr 2021 10:33:38 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+fNGQ+qMuqQ_c1Nou1h4R=-R5sn2n0p7rx==+e2JybSg@mail.gmail.com>
Message-ID: <CAL_Jsq+fNGQ+qMuqQ_c1Nou1h4R=-R5sn2n0p7rx==+e2JybSg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Set linux,pci-domain to zero
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Marek Behun <marek.behun@nic.cz>, Andrew Lunn <andrew@lunn.ch>,
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

On Sat, Apr 17, 2021 at 9:49 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Thursday 15 April 2021 10:13:17 Rob Herring wrote:
> > On Thu, Apr 15, 2021 at 3:45 AM Marek Behun <marek.behun@nic.cz> wrote:
> > >
> > > On Thu, 15 Apr 2021 10:36:40 +0200
> > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > >
> > > > On Tuesday 13 April 2021 13:17:29 Rob Herring wrote:
> > > > > On Mon, Apr 12, 2021 at 7:41 AM Pali Roh=C3=A1r <pali@kernel.org>=
 wrote:
> > > > > >
> > > > > > Since commit 526a76991b7b ("PCI: aardvark: Implement driver 're=
move'
> > > > > > function and allow to build it as module") PCIe controller driv=
er for
> > > > > > Armada 37xx can be dynamically loaded and unloaded at runtime. =
Also driver
> > > > > > allows dynamic binding and unbinding of PCIe controller device.
> > > > > >
> > > > > > Kernel PCI subsystem assigns by default dynamically allocated P=
CI domain
> > > > > > number (starting from zero) for this PCIe controller every time=
 when device
> > > > > > is bound. So PCI domain changes after every unbind / bind opera=
tion.
> > > > >
> > > > > PCI host bridges as a module are relatively new, so seems likely =
a bug to me.
> > > >
> > > > Why a bug? It is there since 5.10 and it is working.
> >
> > I mean historically, the PCI subsystem didn't even support host
> > bridges as a module. They weren't even proper drivers and it was all
> > arch specific code. Most of the host bridge drivers are still built-in
> > only. This seems like a small detail that was easily overlooked.
> > unbind is not a well tested path.
>
> Ok! Just to note that during my testing I have not spotted any issue.
>
> > > > > > Alternative way for assigning PCI domain number is to use stati=
c allocated
> > > > > > numbers defined in Device Tree. This option has requirement tha=
t every PCI
> > > > > > controller in system must have defined PCI bus number in Device=
 Tree.
> > > > >
> > > > > That seems entirely pointless from a DT point of view with a sing=
le PCI bridge.
> > > >
> > > > If domain id is not specified in DT then kernel uses counter and as=
signs
> > > > counter++. So it is not pointless if we want to have stable domain =
id.
> > >
> > > What Rob is trying to say is that
> > > - the bug is that kernel assigns counter++
> > > - device-tree should not be used to fix problems with how kernel does
> > >   things
> > > - if a device has only one PCIe controller, it is pointless to define
> > >   it's pci-domain. If there were multiple controllers, then it would
> > >   make sense, but there is only one
> >
> > Yes. I think what we want here is a domain bitmap rather than a
> > counter and we assign the lowest free bit. That could also allow for
> > handling a mixture of fixed domain numbers and dynamically assigned
> > ones.
>
> Currently this code is implemented in pci_bus_find_domain_nr() function.
> IIRC domain number is 16bit integer, so plain bitmap would consume 8 kB
> of memory. I'm not sure if it is fine or some other tree-based structure
> for allocated domain numbers is needed.

It's an atomic_t but then shortened (potentially) to an 'int'. Surely
we don't need 8k (or 2^31) host bridges? Seems like we could start
with 64 and bump it as needed. Or the idr route is another option if
that works. We'd need to get the lowest free value and be able to
reserve values (when specified by firmware).

> > You could create scenarios where the numbers change on you, but it
> > wouldn't be any different than say plugging in USB serial adapters.
> > You get the same ttyUSBx device when you re-attach unless there's been
> > other ttyUSBx devices attached/detached.
>
> This should be fine for most scenarios. Dynamically attaching /
> detaching PCI domain is not such common action...
>
> Will you implement this new feature?

Yes, after I find a DT binding co-maintainer.

Rob
