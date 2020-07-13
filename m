Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23B421E3CD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 01:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGMXoj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 19:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgGMXoj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 19:44:39 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4A662137B;
        Mon, 13 Jul 2020 23:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594683879;
        bh=Txg1jiinDj8sU47yedDutEmMwD7qpMFKiakR+mJ7T+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=d5cX86aZwhy96couY3o9iPcQL1Pz7H2l3RXmscydSzD8IIukIcpDJNz3tuupH0cBs
         IjGX2pPfi0Evbcxyo8HkQacBEz2RN0EB8utUBK5T52l3eMwGxm7XlP+e6XsICLOixv
         ageW1rZnQEifuLm3uu+gP5bVX0A3JDBK8nPry0Y8=
Date:   Mon, 13 Jul 2020 18:44:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manish Raturi <raturi.manish@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: Dump of registers during endpoint link down
Message-ID: <20200713234437.GA291585@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHn-FMxBZdHPYQkorePnyK+aY_3S29xVnkjj2u3pWDHjTyyGmA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reply-all and don't top-post.  See
https://people.kernel.org/tglx/notes-about-netiquette

On Mon, Jul 13, 2020 at 03:31:02PM +0530, Manish Raturi wrote:
> Thanks, Bjorn, I am doing that (lspci -vvvxxxx) to dump all the
> register, but in case of Link down, are there any specific registers
> which we should look in, mostly I look below register:
> 
> 1) Link status /control/capability
> 2) Slot status /control/capability
> 3) Lane error status registers.
> 
> Any other register we can specifically look for.

I have no idea what the problem is, so can't really help you, sorry.
All you've said is that the link to an endpoint is down.  I don't know
whether the the slot is even powered up.  You could try a different
card to see whether that works.  You could try the same card in a
different machine to see if that works.  If you think the link
*should* be up, you could always debug it from a hardware point of
view with a PCIe analyzer.

> On Fri, Jul 10, 2020 at 12:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Jul 09, 2020 at 12:44:24PM +0530, Manish Raturi wrote:
> > > Hi Team,
> > >
> > > I have a generic query , if an hotplug pcie endpoint connected to the
> > > CPU root port shows link down, then from the debugging perspective
> > > w.r.t PCIE what all register can be dump during the failure condition,
> > > what I can think of is these registers from the root port side
> > >
> > > 1) Link status /control/capability
> > > 2) Slot status /control/capability
> > > 3) Lane error status registers.
> > >
> > > Anything else we can dump which gives us more insight into the issue.
> > > Also is there anything by which we can check from PCIE clock
> > > perspective.
> >
> > If you have this:
> >
> >   Root Port ----- Endpoint
> >
> > and the Link is down, you won't be able to read any registers from the
> > Endpoint.  You can dump all the Root Port registers, of course, e.g.,
> > with "lspci -vvvxxxx".
