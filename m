Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8B499B3
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 09:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfFRHB4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 03:01:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:44279 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfFRHB4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jun 2019 03:01:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5I5RJD1009174;
        Tue, 18 Jun 2019 00:27:22 -0500
Message-ID: <e406c7bc73971a3626cf587f3ee9970973b0782a.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 2/2] PCI: Fix disabling of bridge BARs when assigning
 bus resources
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>
Date:   Tue, 18 Jun 2019 15:27:18 +1000
In-Reply-To: <20190617135307.GA13533@google.com>
References: <20190531171216.20532-1-logang@deltatee.com>
         <20190531171216.20532-3-logang@deltatee.com>
         <20190617135307.GA13533@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2019-06-17 at 08:53 -0500, Bjorn Helgaas wrote:
> On Fri, May 31, 2019 at 11:12:16AM -0600, Logan Gunthorpe wrote:
> > One odd quirk of PLX switches is that their upstream bridge port has
> > 256K of space allocated behind its BAR0 (most other bridge
> > implementations do not report any BAR space).
> 
> Somewhat unusual, but completely legal, of course.

Ah yes, I've seen these. They have an MMIO path to their internal
registers in addition to cfg. Can be annoying.

> If a bridge has memory BARs, AFAIK it is impossible to enable a memory
> window without also enabling the BARs, so if we want to use the bridge
> at all, we *must* allocate space for its BARs, just like for any other
> device.

Right.

 .../... (agreeing violently)

> In my ideal world we wouldn't zap the flags of any resource.  I think
> we should derive the flags from the device's config space *once*
> during enumeration and remember them for the life of the device.

Amen brother. It will take a little while to get there. One thing we
should do is have a clearer way to mark a resource that failed to
assign/allocate (though technically parent=NULL is it really, as long
as all archs these days claim properly, it used not to be the case).

We do wipe *bridge* windows (nor BARs) all over the place, that is less
of an issue I suppose though I would be more comfortable if we also
wrote to the bridge to close those windows as we do so...

The problem of course is how much old weird quirky will break due to
subtle assumptions as we "fix" these things :-)

> This patch preserves res->flags for bridge BARs just like for any
> other device, so I think this is definitely a step in the right
> direction.
> 
> I'm not sure the "dev->subordinate" test is really correct, though.

Right, shouldn't it be pci_is_bridge() ?

> I think the original intent of this code was to clear res->flags for
> bridge windows under the assumptions that (a) we can identify bridges
> by "dev->subordinate" being non-zero, and (b) bridges only have
> windows and didn't have BARs.
> 
> This patch fixes assumption (b), but I think (a) is false, and we
> should fix it as well.  One can imagine a bridge device without a
> subordinate bus (maybe we ran out of bus numbers), so I don't think we
> should test dev->subordinate.

Yup.

> We could test something like pci_is_bridge(), although testing for idx
> being in the PCI_BRIDGE_RESOURCES range should be sufficient because I
> don't think we use those resource for anything other than windows.

Yeah quite possibly.

Cheers,
Ben.


