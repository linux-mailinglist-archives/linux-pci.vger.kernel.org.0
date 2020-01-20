Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5B6142197
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2020 03:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgATCd2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Jan 2020 21:33:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbgATCd2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Jan 2020 21:33:28 -0500
Received: from localhost (108.sub-174-195-2.myvzw.com [174.195.2.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9387206B7;
        Mon, 20 Jan 2020 02:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579487608;
        bh=1sYs9H8+JsDNq45a9MdMoXvIVGncR7j7QbIPXhvbpYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zRTBpwFLl5+RLb8xQmoK3vv43rDvPwct1C7dMIpW6c9+bMbr2jjIqGKnveeIGRJsh
         doH6uQxYWjjzzgjns6bZeRziMuG3ziUKa5wOAdde9sJj0hwD42yxE12WYMuv6kBqW3
         rSBXfRgsCQYr3aVF7Jaf3i7ou25Qq4SWwr4gaU+k=
Date:   Sun, 19 Jan 2020 20:33:26 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jan Vesely <jano.vesely@gmail.com>, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Issues with "PCI/LINK: Report degraded links via link bandwidth
 notification"
Message-ID: <20200120023326.GA149019@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115221008.GA191037@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc NVMe, GPU driver folks]

On Wed, Jan 15, 2020 at 04:10:08PM -0600, Bjorn Helgaas wrote:
> I think we have a problem with link bandwidth change notifications
> (see https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/bw_notification.c).
> 
> Here's a recent bug report where Jan reported "_tons_" of these
> notifications on an nvme device:
> https://bugzilla.kernel.org/show_bug.cgi?id=206197
> 
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

NVMe, GPU folks, do your drivers or devices change PCIe link
speed/width for power saving or other reasons?  When CONFIG_PCIE_BW=y,
the PCI core interprets changes like that as problems that need to be
reported.

If drivers do change link speed/width, can you point me to where
that's done?  Would it be feasible to add some sort of PCI core
interface so the driver could say "ignore" or "pay attention to"
subsequent link changes?

Or maybe there would even be a way to move the link change itself into
the PCI core, so the core would be aware of what's going on?

Bjorn
