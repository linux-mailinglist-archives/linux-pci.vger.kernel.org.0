Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187A11031D
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 01:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfD3XJl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 19:09:41 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:33607 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfD3XJl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Apr 2019 19:09:41 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 6CC8C300002A0;
        Wed,  1 May 2019 01:09:39 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 21B39C2785; Wed,  1 May 2019 01:09:39 +0200 (CEST)
Date:   Wed, 1 May 2019 01:09:39 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Alex G <mr.nuke.me@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Alexandru Gagniuc <alex_gagniuc@dellteam.com>,
        Keith Busch <keith.busch@intel.com>,
        Shyam Iyer <Shyam_Iyer@dell.com>,
        Sinan Kaya <okaya@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI/LINK: Report degraded links via link
 bandwidth notification"
Message-ID: <20190430230939.5bn5ktirkbrx3vhy@wunner.de>
References: <20190429185611.121751-1-helgaas@kernel.org>
 <20190429185611.121751-2-helgaas@kernel.org>
 <d902522e-f788-5e12-6b63-18ac5d5fa955@gmail.com>
 <20190430161151.GB145057@google.com>
 <20190430180508.GB25654@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430180508.GB25654@localhost.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 30, 2019 at 12:05:09PM -0600, Keith Busch wrote:
> On Tue, Apr 30, 2019 at 11:11:51AM -0500, Bjorn Helgaas wrote:
> > > I'm not convinced a revert is the best call.
> > 
> > I have very limited options at this stage of the release, but I'd be
> > glad to hear suggestions.  My concern is that if we release v5.1
> > as-is, we'll spend a lot of energy on those false positives.
> 
> May be too late now if the revert is queued up, but I think this feature
> should have been a default 'false' Kconfig bool rather than always on.

Good idea, this would seem to be a less harsh solution than a revert.

Enabling the feature by default for everyone was probably overly confident.
I recall I did bring up in a review comment that all other port services
have a Kconfig option.  Alex replied that he's not using one because
on device enumeration, downtraining is checked unconditionally as well.

Bandwidth notification might be a feature that's not used by many operating
systems.  Such features don't get much real world exposure or aren't even
validated by manufacturers.  Inevitably, unpleasant side effects occur
once Linux supports them.

However if we keep the code and default to "N" in Kconfig, at least people
get a chance to test and validate the functionality and hopefully this
will lead to either better hardware or better driver support in the future.

Thanks,

Lukas
