Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE1D8167EE
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2019 18:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfEGQbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 May 2019 12:31:21 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59100 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfEGQbV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 May 2019 12:31:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C93E8374;
        Tue,  7 May 2019 09:31:20 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EA733F5AF;
        Tue,  7 May 2019 09:31:19 -0700 (PDT)
Date:   Tue, 7 May 2019 17:30:41 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 00/3] MIPS: SGI-IP27 rework part2
Message-ID: <20190507163041.GA640@e121166-lin.cambridge.arm.com>
References: <20190319154755.31049-1-tbogendoerfer@suse.de>
 <20190418205726.GB126710@google.com>
 <20190507153117.GA21665@e121166-lin.cambridge.arm.com>
 <20190507174820.381fd56f678609416fd8b617@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507174820.381fd56f678609416fd8b617@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 07, 2019 at 05:48:20PM +0200, Thomas Bogendoerfer wrote:
> On Tue, 7 May 2019 16:31:17 +0100
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> > On Thu, Apr 18, 2019 at 03:57:26PM -0500, Bjorn Helgaas wrote:
> > > Hi Thomas,
> > > 
> > > On Tue, Mar 19, 2019 at 04:47:49PM +0100, Thomas Bogendoerfer wrote:
> > > > SGI IP27 (Origin/Onyx2) and SGI IP30 (Octane) have a similair
> > > > architecture and share some hardware (ioc3/bridge). To share
> > > > the software parts this patchset reworks SGI IP27 interrupt
> > > > and pci bridge code. By using features Linux gained during the
> > > > many years since SGI IP27 code was integrated this even results
> > > > in code reduction and IMHO cleaner code.
> > > > 
> > > > Tests have been done on a two module O200 (4 CPUs) and an
> > > > Origin 2000 (8 CPUs).
> > > 
> > > Thanks for doing all this work!  It seems like it basically converts
> > > some of the SGI PCI code to the structure typical of current host
> > > controller drivers and moves it to drivers/pci/controller, which all
> > > seems great to me.
> > 
> > I had a look and the code is really, really MIPS specific, actually
> > I would be interested in understanding how many platforms it supports,
> > it is not even FW configurable.
> 
> it's MIPS only and used in basically 3 different SGI platforms.
> 
> > With hard-coded resources, <asm/...> includes in driver code and MIPS
> > specific kludges even if it does reuse some APIs shared with controller
> > drivers I am not 100% certain that moving it to drivers/pci/controller
> > buys us anything, this is really arch specific code, however we slice
> > it.
> 
> hmm, I thought the idea of having one drivers/pci/controller directory
> is to have all of them in one place.

Well, drivers/pci/controller code should at least try to be arch
agnostic to belong there, there are exceptions, as I said but
they are the exception not the rule.

> > The line between what stays in arch and what goes to
> > drivers/pci/controller is thin but this code is definitely more on the
> > arch side IMHO.
> 
> what makes the xgene driver different from the xtalk-bridge driver ? Ok
> it used DT, but it's still just for a specific type of SOCs from one
> vendor, isn't it ?

Eg no <asm/...> includes required; its code can in principle be
reused on other arches, this series can't, it is arch code IMO.

> > I do not question Thomas' effort, which I appreciate, I question
> > the end result and its usefulness, this series is even increasing
> > lines of kernel code, I would like to see the benefits.
> 
> the move from arch/mips/pci to drivers/pci/controller increases lines of
> code by two lines. The whole patchset adds 155 lines, but also adds
> functionality to be able to use the driver with different platforms.

I am not convinced it will buy you much to be honest, I might be wrong.

If we move the code we have to have a compelling reason for it to
happen and at the moment I do not necessarily see one, happy to
be proven wrong if you extend it to support other platforms cleanly
(eg with firmware bindings) on top of this series.

> Anyway I can live with not moving to drivers/pci/controller if you don't
> like it there.

I can't certainly maintain it, it is too MIPS specific and I do not like
this code either but that's certainly not your fault.

- Hardcoded resources
- No firmware bindings
- Lots of MIPS specific workarounds
- arch code dependency

I do not think that as it stands it belongs in driver/pci/controller,
no.

Thanks,
Lorenzo
