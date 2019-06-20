Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5D34CE6F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 15:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbfFTNQw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 09:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbfFTNQw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 09:16:52 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C27A206E0;
        Thu, 20 Jun 2019 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561036611;
        bh=Qo3z6N5WVyTNvA5VM1U24plWRT+DnbPtddbFCjt97l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CE0uXHPAvlk5vq/ZN61+Q6tU5qzT49/b6jW4ojcIo7XMSr3CenTvZYcVK+ZYZmo+B
         4x9tUqTDeR6bE9lXmEHWrSnMEIzIVF2B0jdH+0UNI4Oxmt8C+ph+AnKNTsT5GgPE8/
         Xwn+56zBaKXebkzNrAJAj4dkjtdEouUglgQblI+0=
Date:   Thu, 20 Jun 2019 08:16:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI / ACPI: Use cached ACPI device state to get
 PCI device power state
Message-ID: <20190620131649.GG143205@google.com>
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
 <20190618161858.77834-2-mika.westerberg@linux.intel.com>
 <20190619212801.GC143205@google.com>
 <20190620082730.GM2640@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620082730.GM2640@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 11:27:30AM +0300, Mika Westerberg wrote:
> On Wed, Jun 19, 2019 at 04:28:01PM -0500, Bjorn Helgaas wrote:
> > On Tue, Jun 18, 2019 at 07:18:56PM +0300, Mika Westerberg wrote:
> > > Intel Ice Lake has an integrated Thunderbolt controller which
> > > means that the PCIe topology is extended directly from the two
> > > root ports (RP0 and RP1).
> > 
> > A PCIe topology is always extended directly from root ports,
> > regardless of whether a Thunderbolt controller is integrated, so I
> > guess I'm missing the point you're making.  It doesn't sound like
> > this is anything specific to Thunderbolt?
>
> The point I'm trying to make here is to explain why this is problem
> now and not with the previous discrete controllers. With the
> previous there was only a single ACPI power resource for the root
> port and the Thunderbolt host router was connected to that root
> port. PCIe hierarchy was extended through downstream ports (not root
> ports) of that controller (which includes PCIe switch).

Sounds like you're using "PCIe topology extension" to mean
specifically something below a Thunderbolt controller, excluding a
subtree below a root port.  I don't think the PCI core is aware of
that distinction.

> Now the thing is part of the SoC so power management is different
> and causes problems in Linux.

The SoC is a physical packaging issue that really doesn't enter into
the specs directly.  I'm trying to get at the logical topology
questions in terms of the PCIe and ACPI specs.

I assume we could dream up a non-Thunderbolt topology that would show
the same problem?

> > > Power management is handled by ACPI power resources that are
> > > shared between the root ports, Thunderbolt controller (NHI) and xHCI
> > > controller.
> > > 
> > > The topology with the power resources (marked with []) looks like:
> > > 
> > >   Host bridge
> > >     |
> > >     +- RP0 ---\
> > >     +- RP1 ---|--+--> [TBT]
> > >     +- NHI --/   |
> > >     |            |
> > >     |            v
> > >     +- xHCI --> [D3C]
> > > 
> > > Here TBT and D3C are the shared ACPI power resources. ACPI
> > > _PR3() method returns either TBT or D3C or both.

I'm not very familiar with _PR3.  I guess this is under an ACPI object
representing a PCI device, e.g., \_SB.PCI0.RP0._PR3?

> > > Say we runtime suspend first the root ports RP0 and RP1, then
> > > NHI. Now since the TBT power resource is still on when the root
> > > ports are runtime suspended their dev->current_state is set to
> > > D3hot. When NHI is runtime suspended TBT is finally turned off
> > > but state of the root ports remain to be D3hot.

So in this example we might have:

  _SB.PCI0.RP0._PR3: TBT
  _SB.PCI0.RP1._PR3: TBT
  _SB.PCI0.NHI._PR3: TBT

And when Linux figures out that everything depending on TBT is in
D3hot, it evaluates TBT._OFF, which puts them all in D3cold?  And part
of the problem is that they're now in D3cold (where config access
doesn't work) but Linux still thinks they're in D3hot (where config
access would work)?

I feel like I'm missing something because I don't know how D3C is
involved, since you didn't mention suspending xHCI.

And I can't mentally match up the patch with the D3hot/D3cold state
change (if indeed that's the problem).  If we were updating the path
that evaluates _OFF so it changed the power state of all dependent
devices, *that* would make a lot of sense to me because it sounds like
that's where the physical change happens that makes things out of
sync.

> > > If the user now runs lspci for instance, the result is all 1's like in
> > > the below output (07.0 is the first root port, RP0):
> > > 
> > > 00:07.0 PCI bridge: Intel Corporation Device 8a1d (rev ff) (prog-if ff)
> > >     !!! Unknown header type 7f
> > >     Kernel driver in use: pcieport
