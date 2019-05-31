Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E0931388
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 19:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfEaRMY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 13:12:24 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38134 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfEaRMY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 May 2019 13:12:24 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hWl4l-0005iw-Dq; Fri, 31 May 2019 11:12:22 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hWl4k-0005Lw-PB; Fri, 31 May 2019 11:12:18 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 31 May 2019 11:12:15 -0600
Message-Id: <20190531171216.20532-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531171216.20532-1-logang@deltatee.com>
References: <20190531171216.20532-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, kchow@gigaio.com, yinghai@kernel.org, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH v3 1/2] PCI: Prevent 64-bit resources from being counted in 32-bit bridge region
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In some situations (described below), hierarchies of 32-bit resources can
fail to be assigned when the kernel has to attempt to assign a large
64-bit resource. When this happens, lspci will report
some PCI BAR resources as 'ignored' and some PCI Bridge windows
being left unset. Sample lspci lines may look like:

  Memory behind bridge: fff00000-000fffff

or

  Region 0: Memory at <ignored> (32-bit, non-prefetchable) [size=256K]

lspci reports a BAR as 'ignored' when the kernel does not populate
the struct resource and the corresponding entry in either
/proc/bus/pci/devices or /sys/bus/pci/devices/.../resource are all zero.
Any device driver that depends on one of these BARs are likely to fail
initializing and the device will not be usable. Typically when this
happens, the underlying Base Address Registers in the configuration
space are still set to whatever the firmware set them to, it's only
the kernel's view of this that is wrong.

The possible situations where this can happen will be a bit varied and
depend highly on the exact hierarchy, what the firmware has assigned
and what the kernel must do to properly re-assign resources. In the
setup that first hit this bug, it failed only with the 'pci=realloc'
command line parameter. The bug has also been hackily reproduced with
QEMU[1] without the realloc parameter.

The following things are required to hit this bug:

1) A large 64-bit prefetchable BAR that can't be assigned in any
   pass of pci_assign_unassigned_bridge_resources(). The resource must
   be large enough that it will not be able to fit with-in the 32-bit
   region. This resource may or may not be assignable into the 64-bit
   prefetchable region after additional passes.

2) A victim 32-bit non-prefetchable BAR that is a neighbor of the
   large BAR (so typically it will have to be behind a switch). When
   the bug is hit, this BAR's struct resource will not be assign and
   lspci will report it as ignored.

3) There must exist a 64-bit prefetchable window for the original large
   BAR to fit in. Which generally implies there is no 32-bit
   prefetchable window.

4) The kernel has to have a reason to re-assign the heirarchy that
   contains both BARs.

The cause of this bug is in __pci_bus_size_bridges() which tries to
calculate the total resource space required for each of the bridge windows
(typically IO, 64-bit, and 32-bit / non-prefetchable). The code, as
written, tries to allocate all the 64-bit prefetchable resources
followed by all the remaining resources. It uses three calls to
pbus_size_mem() for this:

  1) If bridge has a 64-bit prefetchable window, find the size of all
     64-bit prefetchable resources below the bridge

  2) If bridge has no 64-bit prefetchable window, find the size
     of all prefetchable resources below the bridge

  3) Find the size of everything else (non-prefetchable resources plus
     any prefetchable ones that couldn't be accommodated above)

By the requirement (3) above, the system has a 64-bit prefetchable
window, so the large 64-bit BAR *should* be assigned to the 64-bit
prefetchable region. However, if the 64-bit bus resource has already
been assigned, then this call to pbus_size_mem() will fail. (See
the find_free_bus_resource() helper). When the first call fails, it falls
to the second call but, by requirement (3) above, there is no 32-bit
prefetchable window so this call also fails. Thus, it falls to the last
call which tries to fit all the resources into the 32-bit
catch-all window. However, because of requirement (1), the large
BAR will overfill this region and cause the victim 32-bit BAR to not
be assignable.

Looking at the first call to pbus_size_mem(): there are only two reasons
for it to fail: if there is no 64-bit/prefetchable bridge window, or if that
window is already assigned. We know the former case can't be true because,
in __pci_bus_size_bridges(), its existence is checked before making the call.
So if the pbus_size_mem() call in question fails, the window must already
be assigned, and in this case, the code should not try to assign
64-bit resources into the 32-bit catch-all window.

Thus, the fix for the bug is to ensure mask, type2 and type3 are set in
cases where a 64-bit resource exists even if pbus_size_mem() fails. Once
we do this, the large BAR resource will never be attempted to be
assigned to the 32-bit catch-all window and the victim BAR will still
be correctly assigned.

[1] https://lore.kernel.org/lkml/de3e34d8-2ac3-e89b-30f1-a18826ce5d7d@deltatee.com/T/#u

Reported-by: Kit Chow <kchow@gigaio.com>
Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 drivers/pci/setup-bus.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ec44a0f3a7ac..0eb40924169b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1228,21 +1228,20 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
 		if (b_res[2].flags & IORESOURCE_MEM_64) {
 			prefmask |= IORESOURCE_MEM_64;
-			ret = pbus_size_mem(bus, prefmask, prefmask,
+			pbus_size_mem(bus, prefmask, prefmask,
 				  prefmask, prefmask,
 				  realloc_head ? 0 : additional_mem_size,
 				  additional_mem_size, realloc_head);
 
 			/*
-			 * If successful, all non-prefetchable resources
-			 * and any 32-bit prefetchable resources will go in
-			 * the non-prefetchable window.
+			 * Given the existence of a 64-bit resource for this
+			 * bus, all non-prefetchable resources and any 32-bit
+			 * prefetchable resources will go in the
+			 * non-prefetchable window.
 			 */
-			if (ret == 0) {
-				mask = prefmask;
-				type2 = prefmask & ~IORESOURCE_MEM_64;
-				type3 = prefmask & ~IORESOURCE_PREFETCH;
-			}
+			mask = prefmask;
+			type2 = prefmask & ~IORESOURCE_MEM_64;
+			type3 = prefmask & ~IORESOURCE_PREFETCH;
 		}
 
 		/*
-- 
2.20.1

