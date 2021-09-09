Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24757405C60
	for <lists+linux-pci@lfdr.de>; Thu,  9 Sep 2021 19:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241914AbhIIRxP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Sep 2021 13:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237575AbhIIRxP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Sep 2021 13:53:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F1A3610C9;
        Thu,  9 Sep 2021 17:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631209925;
        bh=oUZMfL7ZAWMinL2znEb3rswxHL9q/SpeoIUc9PmfoAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ktiDBzmqI9OfUMFTTBeQmT5TOmGHMixQTlQc/or59MyU68MS5vzwgnmUBZ/xjwGWc
         DyTQOC2+5zhSSYo4cyhQmyy6XTEGUZIipoEGNLESeWNLhXK5n8yqQ+i5zGi+1G6Uqp
         f136RIqHqEqz90ifAFMsojUT2PGGbar1IpKmJt2Y4wZIwKMD9JaQWBMXQxpRcI/6VN
         qtkD741e5AVpugUm2WfyJ/1B3y4nCEsF2zHm2S/aBihUr7RMcAB69S82HcSsnFgisu
         u95fb/6JBrVXN+YmF49ShrHLZXKqSTsV+Iq/nPeYUA7jTe3tRkj+K3XLBFzgJErfNX
         O89mkeafSshIQ==
Date:   Thu, 9 Sep 2021 12:52:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] PCI: Add ACS errata for Pericom PI7C9X2G404 switch
Message-ID: <20210909175203.GA996100@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+aJhH2v2kJ4qgNTNLQuodLuZ1EzK5Caom_=8U82pUZbOKVE4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 09, 2021 at 06:08:33PM +1000, Nathan Rossi wrote:
> On Thu, 9 Sept 2021 at 08:24, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Alex, beginning of thread:
> > https://lore.kernel.org/r/20210903034029.306816-1-nathan@nathanrossi.com]
> >
> > On Mon, Sep 06, 2021 at 04:01:20PM +1000, Nathan Rossi wrote:
> > > On Fri, 3 Sept 2021 at 16:18, Lukas Wunner <lukas@wunner.de> wrote:
> > > >
> > > > On Fri, Sep 03, 2021 at 03:40:29AM +0000, Nathan Rossi wrote:
> > > > > The Pericom PI7C9X2G404 PCIe switch has an errata for ACS P2P Request
> > > > > Redirect behaviour when used in the cut-through forwarding mode. The
> > > > > recommended work around for this issue is to use the switch in store and
> > > > > forward mode.
> >
> > Is there a URL for this erratum?  What is the issue?  Does the switch
> 
> Unfortunately the document is not public, it was provided under a NDA.
> However with that said, there is very little additional information in
> the document itself compared to the information provided in the commit
> message/code comments here. The only other information in the document
> that may be applicable is that the whole document is for a number of
> Pericom switch models, however I do not have access to the other two
> switch models and thus cannot validate if this fixup would also apply
> to them.
> 
> For reference the models with PCI IDs:
> - PI7C9X2G404 - 12d8:2404
> - PI7C9X2G304 - 12d8:2304
> - PI7C9X2G303 - 12d8:2303

I assume that running all these models in store and forward mode is
safe, even if it's not the highest-performance config.  If so, I'd
prefer to include all the documented Device IDs in the quirk so people
don't have to stumble over them before we can fix them.

If somebody complains about the performance and can verify that a
device *doesn't* need the quirk, we can remove it then.

Bjorn
