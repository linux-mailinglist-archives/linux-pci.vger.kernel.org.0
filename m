Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519373FE61E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 02:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhIAXgn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 19:36:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232009AbhIAXgm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Sep 2021 19:36:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33B1C61075;
        Wed,  1 Sep 2021 23:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630539345;
        bh=upR4D5YdCzMrxzbFRw1VjnLPBd3cwv9yzn+ZYnxdxvg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TtZh8FV1VkGQZ+IoK42CHKlRaFWbbGWzMFO1vl61OnUpCuKma+rsGyRKI++GNes3Q
         OMu2/XqDmoXo3nDyd3ig9GRaoDIVRRuo0t/Wa+2k8VD8JjNvrlvn72BTvNa/jgnh1S
         QTnrNZCV2r9X+TRv5OK8yZr/Zdh9kJIi+GAh554NHkjJfk8RH08bNP2vegJkSRCQH2
         r0cWnUcAI/dpks6QZ+v6eqb/P9K9NwinMfET0B0Gab38tvd4seBWRbcnVDTWnj2iBN
         c+29jUBvCfZ3TWgcyQZMOs26zZC77xh7lgtZ1VIrozWHa3o7jB/jGgVqCsbWQZ6vRL
         clacVNCNhgRYw==
Date:   Wed, 1 Sep 2021 18:35:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Hariprasad Shenai <hariprasad@chelsio.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, leedom@chelsio.com,
        nirranjan@chelsio.com
Subject: Re: [PATCH] pci: Add pci quirk to turnoff Nosnoop and Relaxed
 Ordering
Message-ID: <20210901233543.GA260178@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901232212.GA7334@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 01, 2021 at 04:22:12PM -0700, Keith Busch wrote:
> On Wed, Sep 01, 2021 at 05:23:53PM -0500, Bjorn Helgaas wrote:
> > On Sun, Oct 18, 2015 at 07:55:04PM +0530, Hariprasad Shenai wrote:
> > > Some devices violate the PCI Specification regarding echoing the Root
> > > Port Transaction Layer Packet Request (TLP) No Snoop and Relaxed
> > > Ordering Attributes into the TLP Response. The PCI Specification
> > > "encourages" compliant Root Port implementation to drop such
> > > malformed TLP Responses leading to device access timeouts. Many Root Port
> > > implementations accept such malformed TLP Responses and a few more
> > > strict implementations do drop them.
> > > 
> > > For devices which fail this part of the PCI Specification, we need to
> > > traverse up the PCI Chain to the Root Port and turn off the Enable No
> > > Snoop and Enable Relaxed Ordering bits in the Root Port's PCI-Express
> > > Device Control register. This does affect all other devices which
> > > are downstream of that Root Port.
> > 
> > While researching another thread about RO [1], I got concerned about
> > setting RO for root ports.
> > 
> > Setting RO for *endpoints* makes sense: that allows (but does not
> > require) the endpoint to issue writes that don't require strong
> > ordering.
> > 
> > Setting RO for *root ports* seems more problematic.  It allows the
> > root port to issue PCIe writes that don't require strong ordering.
> > These would be CPU MMIO writes to devices.  But Linux currently does
> > not have a way for drivers to indicate that some MMIO writes need to
> > be ordered while others do not, and I think drivers assume that all
> > MMIO writes are performed in order.
> 
> Is that not what writel_relaxed() is for? While it appears that most
> archs just have that call the generic writel(), it does let drivers
> indicate which writes are not strongly ordered.

Sheesh, I hate when I spend a whole afternoon making a fool of myself.

I was thinking just from the PCI core perspective, expecting a
separate window or something for relaxed ordering, but I'm sure
writel_relaxed() could be implemented using different CPU bus
transactions that the Root Complex knows how to interpret, and that
would be essentially invisible to the PCI core.

Sorry for the noise and thanks for the hint :)
