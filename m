Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E039142F15
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2020 16:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgATP4w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jan 2020 10:56:52 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51033 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728935AbgATP4v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jan 2020 10:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579535810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4e5hNsjyX6zx1OYI6NvhnYccfBkWo6gxjd9Kp9Jqg/w=;
        b=Eq8su56cemFRQZNb2VRBKcQH/0uNy2G/Yc/wR0OEe51EDapI5gv1iplohStPv1JbnOmC2/
        nGqxIlktOWAvX/ZugDmQ1cwA2kYQR8vlxZGami/IW6wz4hBSdTGQwomr8IZqE31aV2aqKB
        qNqKKFTY1MnGzosoKda8siEnZqjQchA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-5ZYWsX5eNluUaNaSkmL5RQ-1; Mon, 20 Jan 2020 10:56:47 -0500
X-MC-Unique: 5ZYWsX5eNluUaNaSkmL5RQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7439910054E3;
        Mon, 20 Jan 2020 15:56:44 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E97767DB34;
        Mon, 20 Jan 2020 15:56:40 +0000 (UTC)
Date:   Mon, 20 Jan 2020 08:56:40 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jan Vesely <jano.vesely@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
Message-ID: <20200120085640.53dc9652@w520.home>
In-Reply-To: <20200120023326.GA149019@google.com>
References: <20200115221008.GA191037@google.com>
        <20200120023326.GA149019@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 19 Jan 2020 20:33:26 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc NVMe, GPU driver folks]
> 
> On Wed, Jan 15, 2020 at 04:10:08PM -0600, Bjorn Helgaas wrote:
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
> 
> NVMe, GPU folks, do your drivers or devices change PCIe link
> speed/width for power saving or other reasons?  When CONFIG_PCIE_BW=y,
> the PCI core interprets changes like that as problems that need to be
> reported.
> 
> If drivers do change link speed/width, can you point me to where
> that's done?  Would it be feasible to add some sort of PCI core
> interface so the driver could say "ignore" or "pay attention to"
> subsequent link changes?
> 
> Or maybe there would even be a way to move the link change itself into
> the PCI core, so the core would be aware of what's going on?

One case where we previously saw sporadic link change messages was
vfio-pci owned devices.  If the transitions are based on config space
manipulation then I can trap those accesses and wrap them in a PCI core
API, but I suspect that's not the exclusive (or potentially even
primary) mechanism for initiating link changes.  So I think we'd
probably need a mechanism for a driver to opt-out of link notification
for their devices (presumably the fn0 device per link would opt-out the
entire link?).  Thanks,

Alex

