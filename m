Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3CE559
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2019 16:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfD2OvH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Apr 2019 10:51:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbfD2OvG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Apr 2019 10:51:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56FD9307D96F;
        Mon, 29 Apr 2019 14:51:06 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39DC328982;
        Mon, 29 Apr 2019 14:51:05 +0000 (UTC)
Date:   Mon, 29 Apr 2019 08:51:04 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     mr.nuke.me@gmail.com, linux-pci@vger.kernel.org,
        austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add link_change error handler and vfio-pci user
Message-ID: <20190429085104.728aee75@x1.home>
In-Reply-To: <20190424175758.GC244134@google.com>
References: <155605909349.3575.13433421148215616375.stgit@gimli.home>
        <20190424175758.GC244134@google.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 29 Apr 2019 14:51:06 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 24 Apr 2019 12:57:58 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Apr 23, 2019 at 04:42:28PM -0600, Alex Williamson wrote:
> > The PCIe bandwidth notification service generates logging any time a
> > link changes speed or width to a state that is considered downgraded.
> > Unfortunately, it cannot differentiate signal integrity related link
> > changes from those intentionally initiated by an endpoint driver,
> > including drivers that may live in userspace or VMs when making use
> > of vfio-pci.  Therefore, allow the driver to have a say in whether
> > the link is indeed downgraded and worth noting in the log, or if the
> > change is perhaps intentional.
> > 
> > For vfio-pci, we don't know the intentions of the user/guest driver
> > either, but we do know that GPU drivers in guests actively manage
> > the link state and therefore trigger the bandwidth notification for
> > what appear to be entirely intentional link changes.
> > 
> > Fixes: e8303bb7a75c PCI/LINK: Report degraded links via link bandwidth notification
> > Link: https://lore.kernel.org/linux-pci/155597243666.19387.1205950870601742062.stgit@gimli.home/T/#u
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> > 
> > Changing to pci_dbg() logging is not super usable, so let's try the
> > previous idea of letting the driver handle link change events as they
> > see fit.  Ideally this might be two patches, but for easier handling,
> > folding the pci and vfio-pci bits together.  Comments?  Thanks,  
> 
> I'm a little uneasy about the bandwidth notification logging as a
> whole.  Messages in dmesg don't seem like a solid base for building
> management tools.
> 
> I assume the eventual goal would be some sort of digested notification
> along the lines of "hey mr/ms administrator, the link to device X
> unexpectedly became slower, you might want to check that out."
> 
> If I were building that, I don't think I would use dmesg.  I might
> write a daemon that polls /sys/.../current_link_{speed,width}, or
> maybe use some sort of netlink event.  Maybe it would be useful to
> have the admin designate devices of interest.
> 
> I'm hesitant about adding a .link_change() handler.  If there's
> something useful a driver could do with it, that's one thing.  But
> using it merely to suppress a message doesn't really seem worth the
> trouble, and it seems unfriendly to ask drivers to add it when they
> didn't ask for it and get no benefit from it.

So where do we go from here?  I agree that dmesg is not necessarily a
great choice for these sorts of events and if they went somewhere else,
maybe I wouldn't have the same concerns about them generating user
confusion or contributing to DoS vectors from userspace drivers.  As it
is though, we have known cases where benign events generate confusing
logging messages, which seems like a regression.  Drivers didn't ask
for a link_change handler, but nor did they ask that the link state to
their device be monitored so closely.  Maybe this not only needs some
sort of change to the logging mechanism, but also an opt-in by the
driver if they don't expect runtime link changes.  Thanks,

Alex
