Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9CDF5DEBA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 09:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfGCHTB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 03:19:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727004AbfGCHTA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 03:19:00 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4196C6085508A1E1A9B6;
        Wed,  3 Jul 2019 15:18:57 +0800 (CST)
Received: from localhost (10.227.98.71) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Wed, 3 Jul 2019
 15:18:47 +0800
Date:   Wed, 3 Jul 2019 15:18:36 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>,
        Martin =?GB18030?B?TWFyZYEwlDg=?= <mj@ucw.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <jcm@redhat.com>, <nariman.poushin@linaro.org>,
        <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 0/2] lspci: support for CCIX DVSEC
Message-ID: <20190703151836.0000627a@huawei.com>
In-Reply-To: <20190702212829.GE128603@google.com>
References: <20190627144355.27913-1-Jonathan.Cameron@huawei.com>
        <20190702212829.GE128603@google.com>
Organization: Huawei R&D UK Ltd.
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="GB18030"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.227.98.71]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for taking a look.

On Tue, 2 Jul 2019 16:28:29 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Thu, Jun 27, 2019 at 10:43:53PM +0800, Jonathan Cameron wrote:
> > This series adds support for near complete interpretation of CCIX DVSEC.
> > Most of the CCIX base 1.0 specification is covered, but a few minor
> > elements are not currently printed (some of the timeouts and credit
> > types). That can be rectified in a future version or follow up patch
> > and isn't necessary for this discussion.
> > 
> > CCIX (www.ccixconsortium.org) is a coherent interconnect specification.
> > It is flexible in allowed interconnect topologies, but is overlayed
> > on top of a traditional PCIe tree.  Note that CCIX physical devices
> > may turn up in a number of different locations in the PCIe tree.
> > 
> > The topology configuration and physical layer controls and description
> > are presented using PCIe DVSEC structures defined in the CCIX 1.0
> > base specification.  These use the unique ID granted by the PCISIG.
> > Note that, whilst it looks like a Vendor ID for this usecase it is
> > not one and can only be used to identify DVSEC and related CCIX protocol
> > messages.
> > 
> > So why an RFC?
> > * Are the lspci maintainers happy to have the tool include support for
> >   PCI configuration structures that are defined in other standards?
> > * Is the general approach and code structure appropriate?
> > * It's a lot of description so chances are some of it isn't in a format
> >   consistent with the rest of lspci!
> > 
> > The patch set includes and example that was manually created to exercise
> > much of the parser.  We also have qemu patches to emulate more complex
> > topologies if anyone wants to experiment.
> > 
> > https://patchwork.kernel.org/cover/11015357/
> > 
> > Example output from lspci -t -F ccix-specex1 -s 03:00.0
> > 
> > 03:00.0 Class 0700: Device 19ec:0003 (prog-if 01)
> > ...  
> 
> > 	Capabilities: [600 v0] Designated Vendor-Specific <>
> > 		Vendor:1e2c Version:0
> > 		<CCIX Transport 600>
> > 			TranCap:	ESM+ SR/LR RecalOnrC- CalTime: 500us QuickEqTime: 200ms/208ms
> > 			ESMRateCap:	2.5 GT/s 5 GT/s 8 GT/s 16 GT/s 20 GT/s 25 GT/s 
> > 			ESMStatus:	25 GT/s Cal+
> > 			ESMCtl:		ESM0: 16 GT/s ESM1: 25 GT/s ESM+ ESMCompliance- LR
> > 					ExtEqPhase2TimeOut: 400 ms / 408 ms  ExtEqPhase3TimeOut: 600 ms / 608 ms 
> > 					QuickEqTimeout: Unknown
> > 			ESMEqCtl 20GT/s:	Lane #00: Trans Presets US: 0x1 DS: 0x2  
> 
> It's a minor annoyance that all these lines are longer than 80 columns.  I
> know there are existing things in lspci that are wider, which are also
> slightly annoying.  But you're adding a TON of them and there's a bunch of
> whitespace at the beginning of each line :)

I agree entirely, but not sure what to do about it whilst fitting in
the style that lscpi already has.

We could:
1. Wrap where possible, but leave the same deep indents.  That would get rid
   of some of the long lines but still leave an excessive seeming amount
   of indentation.
2. Reduce the indent, perhaps by not having the separate layer for
   which DVSEC it is.

	Capabilities: [600 v0] DVSEC: CCIX - Transport Layer

The second 600 is redundant anyway.

I'm not sure if that potentially overloads things too much as hard
to know what future DVSECs will be defined with really long names.

> 
> > The following grants the 'pciutils' project trademark usage of
> > CCIX tradmark where relevant.
> > 
> > This patch is being distributed by the CCIX Consortium, Inc. (CCIX) to
> > you and other parties that are paticipating (the "participants") in the
> > pciutils with the understanding that the participants will use CCIX's
> > name and trademark only when this patch is used in association with the
> > pciutils project.
> > 
> > CCIX is also distributing this patch to these participants with the
> > understanding that if any portion of the CCIX specification will be
> > used or referenced in the pciutils project, the participants will not modify
> > the cited portion of the CCIX specification and will give CCIX propery
> > copyright attribution by including the following copyright notice with
> > the cited part of the CCIX specification:
> > "© 2019 CCIX CONSORTIUM, INC. ALL RIGHTS RESERVED."  
> 
> s/tradmark/trademark/
> s/paticipating/participating/
> s/propery/proper/

Gah. That's what I get for copy typing that stuff between two machines rather
than figuring out the games to get it from one to the other.
Sorry about that!

> 
> I guess "will not modify the cited portion" just means people will
> quote it accurately?  It seems obvious that people proposing changes
> to pciutils can't really modify the CCIX spec.

True enough. Note this stuff only applies if a section of the spec is
actually quoted.  As I understand it, things like field names etc
are covered by fair use.  Note that this whole series doesn't have
such a copyright notice, because I don't believe there are any
quotations from the specification in here.

> 
> The above all sounds a little onerous and I doubt I would sign up to
> it because I'd be afraid to mention "CCIX" in an email and I'm pretty
> sure I'd forget to add the copyright notice somewhere.  But
> fortunately that's up to Martin, not me.

The whole thing is a bit unfortunate, but the intent on the copyright stuff is
that any substantial quotes from any spec should have that anyway.  The
real aim is the trademark grant bit. I gather that's all about showing
you are actively maintaining your trademark (granting it's use with particular
scope counts).

As a non lawyer I'm certainly not a good source on this, but as I understand
it there is no problem in using it to describe a CCIX device etc, but that
it only gets dodgy if it becomes part of a 'product' name or similar.

It is also worth noting that anything using PCI-SIG terms is also under
a trademark policy...
http://pcisig.com/sites/default/files/newsroom_attachments/Trademark_and_Logo_Usage_Guidelines_updated_112206.pdf

That's probably not a can of worms to open though (it makes a scary
read)

> 
> > Jonathan Cameron (2):
> >   CCIX DVSEC initial support
> >   DVSEC Add an example from the ccix spec.  
> 
> s/ccix/CCIX/ so they match.  No period necessary in subject line.
> 
> I don't maintain pciutils, but I like to have subject lines match in
> grammatical style.  One of the above is a sentence and the other is not.
> Maybe:
> 
>   Add CCIX DVSEC decoding support
>   Add DVSEC example from CCIX spec

I'll tidy them up for V2. Thanks!
> 
> Bjorn


