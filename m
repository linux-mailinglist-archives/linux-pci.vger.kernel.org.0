Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15BB516142
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 11:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEGJmu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 05:42:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48556 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfEGJmu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 May 2019 05:42:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19DF8374;
        Tue,  7 May 2019 02:42:50 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 944413F5AF;
        Tue,  7 May 2019 02:42:48 -0700 (PDT)
Date:   Tue, 7 May 2019 10:42:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 00/3] MIPS: SGI-IP27 rework part2
Message-ID: <20190507094245.GB10964@e121166-lin.cambridge.arm.com>
References: <20190319154755.31049-1-tbogendoerfer@suse.de>
 <20190418205726.GB126710@google.com>
 <20190506123724.5c78bcff04f722ae92e7f6a8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506123724.5c78bcff04f722ae92e7f6a8@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 06, 2019 at 12:37:24PM +0200, Thomas Bogendoerfer wrote:
> On Thu, 18 Apr 2019 15:57:26 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > Hi Thomas,
> > 
> > On Tue, Mar 19, 2019 at 04:47:49PM +0100, Thomas Bogendoerfer wrote:
> > > SGI IP27 (Origin/Onyx2) and SGI IP30 (Octane) have a similair
> > > architecture and share some hardware (ioc3/bridge). To share
> > > the software parts this patchset reworks SGI IP27 interrupt
> > > and pci bridge code. By using features Linux gained during the
> > > many years since SGI IP27 code was integrated this even results
> > > in code reduction and IMHO cleaner code.
> > > 
> > > Tests have been done on a two module O200 (4 CPUs) and an
> > > Origin 2000 (8 CPUs).
> > 
> > Thanks for doing all this work!  It seems like it basically converts
> > some of the SGI PCI code to the structure typical of current host
> > controller drivers and moves it to drivers/pci/controller, which all
> > seems great to me.
> > 
> > The patches were kind of in limbo as far as Patchwork.  Lorenzo
> > handles the native host controller drivers, so I just delegated them
> > to him, so now they should be on his radar.
> 
> Is there a chance to still get this into v5.2 ?

I do not think so, I will have a look as soon as possible, sorry
for the delay.

Lorenzo
