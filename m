Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7F246DCDB
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 21:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbhLHUUQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 15:20:16 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54558 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhLHUUP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 15:20:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2646BCE233D;
        Wed,  8 Dec 2021 20:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48D7C00446;
        Wed,  8 Dec 2021 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638994600;
        bh=ObuOO5WhMAOnf9+coMNNdUrPXL9BF1wt2mjnxkUZUQk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MKYapKUNIHxSlGKSnqD0tTLZYZd5p0t5E+i7kUhfp5BV1VLqwub9FhvAPtqRn8zvk
         x83/tp5i/Kqj7KZU0/fjrk+HSAlQ7PQN4tv12arprSRni4ajmv0NxLZ8Iqp4QNOoFq
         VemZgw+In9DbZaMQ93dwrH+Q+1KvAdRrroRxJakkHUXJE9PfrkT6Zm2BZaNVaXy1kE
         H9tQjytn0a+tVxq9H6Of+bqcEx0uDMZ0UXUhvm+MDfAG6pJK/qY3JWRD+CrunA1dec
         9KUtU21+HcSwe25gwmDLfFu6RsHXVf3ixugoYrxKfVZuF0aqI9/IgcVvaB0SC1CGv4
         XKkREC/87YLLA==
Date:   Wed, 8 Dec 2021 14:16:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Airlie <airlied@linux.ie>
Cc:     Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/3] agp: convert to generic power management
Message-ID: <20211208201638.GA150092@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.2112081942330.32242@skynet-temp.skynet.ie>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 08, 2021 at 07:55:08PM +0000, Dave Airlie wrote:
> On Wed, 8 Dec 2021, Bjorn Helgaas wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Vaibhav has converted around 180 drivers to generic power management, and
> > over 100 of those conversions have made it upstream.  If we can finish off
> > the remaining ones, we'll be able to remove quite a bit of ugly legacy code
> > from the PCI core.
> > 
> > This is a repost of Vaibhav's patches for AGP.  I rebased them to v5.16-rc1
> > and updated the commit logs to try to make it easier to verify them.
> > 
> > In the most recent posting here:
> > 
> >   https://lore.kernel.org/linux-pci/20211201025419.2797624-1-helgaas@kernel.org/
> > 
> > my commit log updates were incorrect.  This v3 has updates that I believe
> > to be correct, but of course I'd be grateful for more corrections.
> 
> Hi Bjorn,
> 
> Do you want to merge these via your tree?
> 
> if so,
> Acked-by: Dave Airlie <airlied@redhat.com>

Either way is fine; I'll merge them to save you the trouble.  I put
them on pci/legacy-pm-removal for v5.17 with your ack.  Thanks!

> > Vaibhav Gupta (3):
> >   amd64-agp: convert to generic power management
> >   sis-agp: convert to generic power management
> >   via-agp: convert to generic power management
> > 
> >  drivers/char/agp/amd64-agp.c | 24 ++++++------------------
> >  drivers/char/agp/sis-agp.c   | 25 ++++++-------------------
> >  drivers/char/agp/via-agp.c   | 25 +++++--------------------
> >  3 files changed, 17 insertions(+), 57 deletions(-)
> > 
> > 
