Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7892C308204
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jan 2021 00:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhA1XkP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 18:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229828AbhA1XkM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 18:40:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E778364DE2;
        Thu, 28 Jan 2021 23:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611877171;
        bh=uCYlOxWFyGqfzsCOjgAMNaqNNqAKRulWHpgwkwEgtJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RQNMLRsXqregPQH2liQAw5L0gRasHqMLwn0Bz9kiNzAqOK0GMBn/pUCkD/S/iIv5k
         rltYgHbPb8y4r+8on6aa+T8GqVHL2CsYQhzzyenOwKqfLbof30U6FheCKJgyZW46Fc
         D+s1Xb+qcCbjYSNQ7XrcRKZCEvrbsNBdkT2Y6RRUxtqT6t1DKJmWXtRFy7oC1WSozc
         zd23P1uiAF9dkA8yQQAaTswCZ/Fo+U6IFokq7IxTQWf8GyFDTuEGMf9kf7LyZmWj+R
         as+D/W8BBFiCROZtd+kN9ZQH/yGtBf5ysvyHYPLjgDgu4AD8EXmgbKlIsp8cRkfZ1I
         bAL/Czktx315A==
Date:   Thu, 28 Jan 2021 17:39:29 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Jan Vesely <jano.vesely@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Dave Airlie <airlied@gmail.com>,
        Ben Skeggs <skeggsb@gmail.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        "A. Vladimirov" <vladimirov.atanas@gmail.com>
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
Message-ID: <20210128233929.GA39660@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222165840.GA214760@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Atanas -- thank you very much for the bug report!]

On Sat, Feb 22, 2020 at 10:58:40AM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 15, 2020 at 04:10:08PM -0600, Bjorn Helgaas wrote:
> > I think we have a problem with link bandwidth change notifications
> > (see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/bw_notification.c).
> > 
> > Here's a recent bug report where Jan reported "_tons_" of these
> > notifications on an nvme device:
> > https://bugzilla.kernel.org/show_bug.cgi?id=206197
> 
> AFAICT, this thread petered out with no resolution.
> 
> If the bandwidth change notifications are important to somebody,
> please speak up, preferably with a patch that makes the notifications
> disabled by default and adds a parameter to enable them (or some other
> strategy that makes sense).
> 
> I think these are potentially useful, so I don't really want to just
> revert them, but if nobody thinks these are important enough to fix,
> that's a possibility.

Atanas is also seeing this problem and went to the trouble of digging
up this bug report:
https://bugzilla.kernel.org/show_bug.cgi?id=206197#c8

I'm actually a little surprised that we haven't seen more reports of
this.  I don't think distros enable CONFIG_PCIE_BW, but even so, I
would think more people running upstream kernels would trip over it.
But maybe people just haven't turned CONFIG_PCIE_BW on.

I don't have a suggestion; just adding Atanas to this old thread.

> > There was similar discussion involving GPU drivers at
> > https://lore.kernel.org/r/20190429185611.121751-2-helgaas@kernel.org
> > 
> > The current solution is the CONFIG_PCIE_BW config option, which
> > disables the messages completely.  That option defaults to "off" (no
> > messages), but even so, I think it's a little problematic.
> > 
> > Users are not really in a position to figure out whether it's safe to
> > enable.  All they can do is experiment and see whether it works with
> > their current mix of devices and drivers.
> > 
> > I don't think it's currently useful for distros because it's a
> > compile-time switch, and distros cannot predict what system configs
> > will be used, so I don't think they can enable it.
> > 
> > Does anybody have proposals for making it smarter about distinguishing
> > real problems from intentional power management, or maybe interfaces
> > drivers could use to tell us when we should ignore bandwidth changes?
> > 
> > Bjorn
