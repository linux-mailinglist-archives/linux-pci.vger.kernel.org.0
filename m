Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1104A14151F
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2020 01:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgARASV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 19:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730260AbgARASU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jan 2020 19:18:20 -0500
Received: from localhost (187.sub-174-234-133.myvzw.com [174.234.133.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01B622464;
        Sat, 18 Jan 2020 00:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579306700;
        bh=8uI/K7Y6Es7q0e+hhcYC+JgxXkh7RpWbPmPMa1q5qhg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kDAr3zEDGKHalfB8SOCXhQPzo7vhw52DNxtBvQe2dvgnHzdDH912adBsLSrYLKeSs
         167J45lhvYF6+Vp+iOzuhZ2Oh+k0OjaJTs6HWAPp2gvzUISercIjEmilMIvcaCMh74
         g0Il2rAJMsfykoxXK71YlFXhC1rdf5ng23qbVLB8=
Date:   Fri, 17 Jan 2020 18:18:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alex G <mr.nuke.me@gmail.com>
Cc:     Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Jan Vesely <jano.vesely@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
Message-ID: <20200117234627.GA144414@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <967fb44c-b1cd-875c-2354-b6ad0b8ae6d7@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 08:44:21PM -0600, Alex G wrote:
> Hi Bjorn,
> 
> I'm no longer working on this, so my memory may not be up to speed. If the
> endpoint is causing the bandwidth change, then we should get an _autonomous_
> link management interrupt instead. I don't think we report those, and that
> shouldn't spam the logs
> 
> If it's not a (non-autonomous) link management interrupt, then something is
> causing the downstream port to do funny things. I don't think ASPM is
> supposed to be causing this.
> 
> Do we know what's causing these swings?
> 
> For now, I suggest a boot-time parameter to disable link speed reporting
> instead of a compile time option.

If we add a parameter, it would have to be that reporting is disabled
by default, and the parameter would enable it.  That way the default
will not spam the logs and cause more problem reports.

I don't have time to debug this and I don't like boot parameters in
general, so somebody else will have to step up to resolve this.

At the very least, we need a Kconfig update to warn about the
possibility, and we may need to consider reverting this if we don't
have a better solution.

> On 1/15/20 4:10 PM, Bjorn Helgaas wrote:
> > I think we have a problem with link bandwidth change notifications
> > (see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/bw_notification.c).
> > 
> > Here's a recent bug report where Jan reported "_tons_" of these
> > notifications on an nvme device:
> > https://bugzilla.kernel.org/show_bug.cgi?id=206197
> > 
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
> > 
