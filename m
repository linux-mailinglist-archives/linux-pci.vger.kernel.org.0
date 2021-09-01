Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6653FE611
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 02:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245516AbhIAXXN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 19:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhIAXXN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Sep 2021 19:23:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BD3461026;
        Wed,  1 Sep 2021 23:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630538535;
        bh=jXPS/a24D1utOVnbt1L4/8EJW3UuQaHkPO3nCWKnCdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQVIA4TkOihYKfRuNMXv4y0K+Q+vaJk6XpSbYuZR6pNacXnh78OG02A5hOw1wsHZ/
         /NyZidOjkTPVr39B+YH3AmJ/L6vFlZWiV16gc3pEx2VlzYoNsFREoUBltKihHTii7R
         /wvvU7WNCoXpmReYYnb2QGsOY6o+fHQMEc0jbGJte7prhn00KPXgtHZB//jbI73eJU
         xaRu1s8q63gwKPGDYUIzojZkclchquMmTLbW0nb7TtYzHv5tmPNR9lVGZVbbLvQxtK
         Jykj0WNnZZd+uAKWt87y2Pl5+r0ul9Zy5RlzuOe6Q6OATYelM9FGGXwtp7NRf8BSyy
         QJbBIn5uPpw/g==
Date:   Wed, 1 Sep 2021 16:22:12 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Hariprasad Shenai <hariprasad@chelsio.com>, bhelgaas@google.com,
        linux-pci@vger.kernel.org, leedom@chelsio.com,
        nirranjan@chelsio.com
Subject: Re: [PATCH] pci: Add pci quirk to turnoff Nosnoop and Relaxed
 Ordering
Message-ID: <20210901232212.GA7334@dhcp-10-100-145-180.wdc.com>
References: <1445178304-14855-1-git-send-email-hariprasad@chelsio.com>
 <20210901222353.GA251391@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901222353.GA251391@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 01, 2021 at 05:23:53PM -0500, Bjorn Helgaas wrote:
> On Sun, Oct 18, 2015 at 07:55:04PM +0530, Hariprasad Shenai wrote:
> > Some devices violate the PCI Specification regarding echoing the Root
> > Port Transaction Layer Packet Request (TLP) No Snoop and Relaxed
> > Ordering Attributes into the TLP Response. The PCI Specification
> > "encourages" compliant Root Port implementation to drop such
> > malformed TLP Responses leading to device access timeouts. Many Root Port
> > implementations accept such malformed TLP Responses and a few more
> > strict implementations do drop them.
> > 
> > For devices which fail this part of the PCI Specification, we need to
> > traverse up the PCI Chain to the Root Port and turn off the Enable No
> > Snoop and Enable Relaxed Ordering bits in the Root Port's PCI-Express
> > Device Control register. This does affect all other devices which
> > are downstream of that Root Port.
> 
> While researching another thread about RO [1], I got concerned about
> setting RO for root ports.
> 
> Setting RO for *endpoints* makes sense: that allows (but does not
> require) the endpoint to issue writes that don't require strong
> ordering.
> 
> Setting RO for *root ports* seems more problematic.  It allows the
> root port to issue PCIe writes that don't require strong ordering.
> These would be CPU MMIO writes to devices.  But Linux currently does
> not have a way for drivers to indicate that some MMIO writes need to
> be ordered while others do not, and I think drivers assume that all
> MMIO writes are performed in order.

Is that not what writel_relaxed() is for? While it appears that most
archs just have that call the generic writel(), it does let drivers
indicate which writes are not strongly ordered.
