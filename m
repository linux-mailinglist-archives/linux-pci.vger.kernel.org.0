Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C4616908D
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2020 17:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBVQ6n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Feb 2020 11:58:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgBVQ6m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Feb 2020 11:58:42 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8BBF20702;
        Sat, 22 Feb 2020 16:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582390722;
        bh=gkjFs/1a+pJHG97GNGxiu0bTzUWm8c+N+Zh6h+i2bpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1g1mqO0MCzSViG9n4r2G+9mRMtxkY+CMmvJJt9rUAPfG17iazzt2KeWAsjnYAzzkk
         e6oc/woJRK+lLRz2SU/p6BFtUwXexTix4uUDruhnWMIlSmbrxG07v/LMs5VKADBn33
         SREmsw7MAfw1SBcwAdy54eZ9Ouvf7ImAjKGEXOz0=
Date:   Sat, 22 Feb 2020 10:58:40 -0600
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
        Myron Stowe <myron.stowe@redhat.com>
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
Message-ID: <20200222165840.GA214760@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115221008.GA191037@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christoph, Lucas, Dave, Ben, Alex, Myron]

On Wed, Jan 15, 2020 at 04:10:08PM -0600, Bjorn Helgaas wrote:
> I think we have a problem with link bandwidth change notifications
> (see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/bw_notification.c).
> 
> Here's a recent bug report where Jan reported "_tons_" of these
> notifications on an nvme device:
> https://bugzilla.kernel.org/show_bug.cgi?id=206197

AFAICT, this thread petered out with no resolution.

If the bandwidth change notifications are important to somebody,
please speak up, preferably with a patch that makes the notifications
disabled by default and adds a parameter to enable them (or some other
strategy that makes sense).

I think these are potentially useful, so I don't really want to just
revert them, but if nobody thinks these are important enough to fix,
that's a possibility.

> There was similar discussion involving GPU drivers at
> https://lore.kernel.org/r/20190429185611.121751-2-helgaas@kernel.org
> 
> The current solution is the CONFIG_PCIE_BW config option, which
> disables the messages completely.  That option defaults to "off" (no
> messages), but even so, I think it's a little problematic.
> 
> Users are not really in a position to figure out whether it's safe to
> enable.  All they can do is experiment and see whether it works with
> their current mix of devices and drivers.
> 
> I don't think it's currently useful for distros because it's a
> compile-time switch, and distros cannot predict what system configs
> will be used, so I don't think they can enable it.
> 
> Does anybody have proposals for making it smarter about distinguishing
> real problems from intentional power management, or maybe interfaces
> drivers could use to tell us when we should ignore bandwidth changes?
> 
> Bjorn
