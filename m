Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5300A33E85F
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 05:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhCQEU6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 00:20:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhCQEUX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Mar 2021 00:20:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A42864E12;
        Wed, 17 Mar 2021 04:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615954822;
        bh=JvaItcyvxXGkCBmgfJOjXBqBqDQe30GOElsiPDt1c68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I319XESIuBcZmOlwpUL8TWVV8/VYvGBUWrck1U1SnJbTMABRtRTW7eN+bd/mRiGFe
         24owgLzn0cf+h62FW0tWszkhwmmuwORBVGVf50oK/KBvztGJvYwPkHl4xDouUoWiw0
         2D5/Wxic3UFQhWfvJJWc41vCBc+TK/fj1CqxaTrx9YSpO5SQ5tHf1Xy706cNggWtVR
         +N3HrWW2n5UKuoH2OonkloZDPRhR+5GVja4i6Jusbzs3kLBenpguNCmmzZY08cCnQ5
         6gWyDD3luoIkFInNZWQPqYiUrh15WjKOc9ceaoiQgvuuLcYwlJnsD9Lr1Qf8Yb4rjd
         EPQDDuqcC9Ojw==
Date:   Wed, 17 Mar 2021 06:20:18 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alay Shah <alay.shah@nutanix.com>,
        Suresh Gumpula <suresh.gumpula@nutanix.com>,
        Shyam Rajendran <shyam.rajendran@nutanix.com>,
        Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <YFGDgqdTLBhQL8mN@unreal>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
 <20210312173452.3855-5-ameynarkhede03@gmail.com>
 <20210314235545.girtrazsdxtrqo2q@pali>
 <20210315134323.llz2o7yhezwgealp@archlinux>
 <20210315135226.avwmnhkfsgof6ihw@pali>
 <20210315083409.08b1359b@x1.home.shazbot.org>
 <YE94InPHLWmOaH/b@unreal>
 <20210315153341.miip637z35mwv7fv@archlinux>
 <20210315102950.230de1d6@x1.home.shazbot.org>
 <20210315183226.GA14801@raphael-debian-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210315183226.GA14801@raphael-debian-dev>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 15, 2021 at 06:32:32PM +0000, Raphael Norwitz wrote:
> On Mon, Mar 15, 2021 at 10:29:50AM -0600, Alex Williamson wrote:
> > On Mon, 15 Mar 2021 21:03:41 +0530
> > Amey Narkhede <ameynarkhede03@gmail.com> wrote:
> >
> > > On 21/03/15 05:07PM, Leon Romanovsky wrote:
> > > > On Mon, Mar 15, 2021 at 08:34:09AM -0600, Alex Williamson wrote:
> > > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > > Pali Rohár <pali@kernel.org> wrote:
> > > > >
> > > > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:
> > > > > > > slot reset (pci_dev_reset_slot_function) and secondary bus
> > > > > > > reset(pci_parent_bus_reset) which I think are hot reset and
> > > > > > > warm reset respectively.
> > > > > >
> > > > > > No. PCI secondary bus reset = PCIe Hot Reset. Slot reset is just another
> > > > > > type of reset, which is currently implemented only for PCIe hot plug
> > > > > > bridges and for PowerPC PowerNV platform and it just call PCI secondary
> > > > > > bus reset with some other hook. PCIe Warm Reset does not have API in
> > > > > > kernel and therefore drivers do not export this type of reset via any
> > > > > > kernel function (yet).
> > > > >
> > > > > Warm reset is beyond the scope of this series, but could be implemented
> > > > > in a compatible way to fit within the pci_reset_fn_methods[] array
> > > > > defined here.  Note that with this series the resets available through
> > > > > pci_reset_function() and the per device reset attribute is sysfs remain
> > > > > exactly the same as they are currently.  The bus and slot reset
> > > > > methods used here are limited to devices where only a single function is
> > > > > affected by the reset, therefore it is not like the patch you proposed
> > > > > which performed a reset irrespective of the downstream devices.  This
> > > > > series only enables selection of the existing methods.  Thanks,
> > > >
> > > > Alex,
> > > >
> > > > I asked the patch author here [1], but didn't get any response, maybe
> > > > you can answer me. What is the use case scenario for this functionality?
> > > >
> > > > Thanks
> > > >
> > > > [1] https://lore.kernel.org/lkml/YE389lAqjJSeTolM@unreal/
> > > >
> > > Sorry for not responding immediately. There were some buggy wifi cards
> > > which needed FLR explicitly not sure if that behavior is fixed in
> > > drivers. Also there is use a case at Nutanix but the engineer who
> > > is involved is on PTO that is why I did not respond immediately as
> > > I don't know the details yet.
> >
> > And more generally, devices continue to have reset issues and we
> > impose a fixed priority in our ordering.  We can and probably should
> > continue to quirk devices when we find broken resets so that we have
> > the best default behavior, but it's currently not easy for an end user
> > to experiment, ie. this reset works, that one doesn't.  We might also
> > have platform issues where a given reset works better on a certain
> > platform.  Exposing a way to test these things might lead to better
> > quirks.  In the case I think Pali was looking for, they wanted a
> > mechanism to force a bus reset, if this was in reference to a single
> > function device, this could be accomplished by setting a priority for
> > that mechanism, which would translate to not only the sysfs reset
> > attribute, but also the reset mechanism used by vfio-pci.  Thanks,
> >
> > Alex
> >
>
> To confirm from our end - we have seen many such instances where default
> reset methods have not worked well on our platform. Debugging these
> issues is painful in practice, and this interface would make it far
> easier.
>
> Having an interface like this would also help us better communicate the
> issues we find with upstream. Allowing others to more easily test our
> (or other entities') findings should give better visibility into
> which issues apply to the device in general and which are platform
> specific. In disambiguating the former from the latter, we should be
> able to better quirk devices for everyone, and in the latter cases, this
> interface allows for a safer and more elegant solution than any of the
> current alternatives.

So to summarize, we are talking about test and debug interface to
overcome HW bugs, am I right?

My personal experience shows that once the easy workaround exists
(and write to generally available sysfs is very simple), the vendors
and users desire for proper fix decreases drastically. IMHO, we will
see increase of copy/paste in SO and blog posts, but reduce in quirks.

My 2-cents.

>
> CC Alay, Suresh, Shyam and Felipe in case they have anything to add.
