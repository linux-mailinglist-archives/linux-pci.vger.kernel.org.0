Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4DF91055F8
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 16:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKUPr0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 10:47:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40295 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUPr0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 10:47:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id m15so3315224otq.7;
        Thu, 21 Nov 2019 07:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cENdR/YNP8WrkCnrRlfKo/wx15sIIepZ4jmxr2d85Gc=;
        b=NEV0BMMzi2ceMhmYh2NvynkD/34CXFFAdYcLzHubxWKPYdscnVzC/H4kOciDL4QNol
         5kpkxPLbg4RF0hyvKNf29ZbS3JiQ3IErLbCeOoo/R/qKP6j5sl+j2S9fABBwNkVgT8pR
         eGcRZelB9Xa18K0oUK1XZMQWehCQlfmYmsuf5Enn1b14J/0TkwLinKDWYs2PpURrVlfd
         m1XGOZjN7IkFNwMFGYiLmw4Ekmap0QA29A0GPzbJqgnGE5U4lN0ZiPYyyBMOFsb2OGC5
         Gecr9LsJIaH+tlySm5fzp1gcOh5FQyCoM6qr56TzzpRqgwExG+2u9wrWTRAIAOK+8hW+
         Yv/w==
X-Gm-Message-State: APjAAAXd/NmrBZf+RU9PhJYE/L8AS18+kuKLDz9dENCkS7bBKkvBYGxn
        Sp18+qkh6R0oAs9Q6ieuRnxHWYypCErTtcWOsji1JA==
X-Google-Smtp-Source: APXvYqw1iwAHzb0NCqnuFton0CCPRqV6XwmgvO+O7iPDqA3/HjpBzqll2kKyoYasjd6DGrsXRz/cJtR9Xj0PRUbIR3g=
X-Received: by 2002:a05:6830:103:: with SMTP id i3mr7223613otp.266.1574351245103;
 Thu, 21 Nov 2019 07:47:25 -0800 (PST)
MIME-Version: 1.0
References: <20191120120913.GE11621@lahna.fi.intel.com> <CACO55tsHy6yZQZ8PkdW8iPA7+uc5rdcEwRJwYEQ3iqu85F8Sqg@mail.gmail.com>
 <20191120151542.GH11621@lahna.fi.intel.com> <CACO55tvo3rbPtYJcioEgXCEQqVXcVAm-iowr9Nim=bgTdMjgLw@mail.gmail.com>
 <20191120155301.GL11621@lahna.fi.intel.com> <CAJZ5v0hkT-fHFOQKzp2qYPyR+NUa4c-G-uGLPZuQxqsG454PiQ@mail.gmail.com>
 <CACO55ttTPi2XpRRM_NYJU5c5=OvG0=-YngFy1BiR8WpHkavwXw@mail.gmail.com>
 <CAJZ5v0h=7zu3A+ojgUSmwTH0KeXmYP5OKDL__rwkkWaWqcJcWQ@mail.gmail.com>
 <20191121112821.GU11621@lahna.fi.intel.com> <CAJZ5v0hQhj5Wf+piU11abC4pF26yM=XHGHAcDv8Jsgdx04aN-w@mail.gmail.com>
 <20191121114610.GW11621@lahna.fi.intel.com> <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
In-Reply-To: <CACO55ttXJgXG32HzYP_uJDfQ6T-d8zQaGjXK_AZD3kF0Rmft4g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Nov 2019 16:47:13 +0100
Message-ID: <CAJZ5v0ibzcLEm44udUxW2uVgaF9NapdNBF8Ag+RE++u7gi2yNA@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Karol Herbst <kherbst@redhat.com>
Cc:     Mika Westerberg <mika.westerberg@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 1:53 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> On Thu, Nov 21, 2019 at 12:46 PM Mika Westerberg
> <mika.westerberg@intel.com> wrote:
> >
> > On Thu, Nov 21, 2019 at 12:34:22PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Nov 21, 2019 at 12:28 PM Mika Westerberg
> > > <mika.westerberg@intel.com> wrote:
> > > >
> > > > On Wed, Nov 20, 2019 at 11:29:33PM +0100, Rafael J. Wysocki wrote:
> > > > > > last week or so I found systems where the GPU was under the "PCI
> > > > > > Express Root Port" (name from lspci) and on those systems all of that
> > > > > > seems to work. So I am wondering if it's indeed just the 0x1901 one,
> > > > > > which also explains Mikas case that Thunderbolt stuff works as devices
> > > > > > never get populated under this particular bridge controller, but under
> > > > > > those "Root Port"s
> > > > >
> > > > > It always is a PCIe port, but its location within the SoC may matter.
> > > >
> > > > Exactly. Intel hardware has PCIe ports on CPU side (these are called
> > > > PEG, PCI Express Graphics, ports), and the PCH side. I think the IP is
> > > > still the same.
> > > >
>
> yeah, I meant the bridge controller with the ID 0x1901 is on the CPU
> side. And if the Nvidia GPU is on a port on the PCH side it all seems
> to work just fine.

But that may involve different AML too, may it not?

> > > > > Also some custom AML-based power management is involved and that may
> > > > > be making specific assumptions on the configuration of the SoC and the
> > > > > GPU at the time of its invocation which unfortunately are not known to
> > > > > us.
> > > > >
> > > > > However, it looks like the AML invoked to power down the GPU from
> > > > > acpi_pci_set_power_state() gets confused if it is not in PCI D0 at
> > > > > that point, so it looks like that AML tries to access device memory on
> > > > > the GPU (beyond the PCI config space) or similar which is not
> > > > > accessible in PCI power states below D0.
> > > >
> > > > Or the PCI config space of the GPU when the parent root port is in D3hot
> > > > (as it is the case here). Also then the GPU config space is not
> > > > accessible.
> > >
> > > Why would the parent port be in D3hot at that point?  Wouldn't that be
> > > a suspend ordering violation?
> >
> > No. We put the GPU into D3hot first, then the root port and then turn
> > off the power resource (which is attached to the root port) resulting
> > the topology entering D3cold.
> >
>
> If the kernel does a D0 -> D3hot -> D0 cycle this works as well, but
> the power savings are way lower, so I kind of prefer skipping D3hot
> instead of D3cold. Skipping D3hot doesn't seem to make any difference
> in power savings in my testing.

OK

What exactly did you do to skip D3cold in your testing?
