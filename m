Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACED34CEFE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 15:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFTNhQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 09:37:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:63087 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbfFTNhQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 09:37:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 06:37:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,397,1557212400"; 
   d="scan'208";a="181857959"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 20 Jun 2019 06:37:11 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 20 Jun 2019 16:37:10 +0300
Date:   Thu, 20 Jun 2019 16:37:10 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI / ACPI: Use cached ACPI device state to get
 PCI device power state
Message-ID: <20190620133710.GB2640@lahna.fi.intel.com>
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
 <20190618161858.77834-2-mika.westerberg@linux.intel.com>
 <20190619212801.GC143205@google.com>
 <20190620082730.GM2640@lahna.fi.intel.com>
 <20190620131649.GG143205@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620131649.GG143205@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 08:16:49AM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 20, 2019 at 11:27:30AM +0300, Mika Westerberg wrote:
> > On Wed, Jun 19, 2019 at 04:28:01PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Jun 18, 2019 at 07:18:56PM +0300, Mika Westerberg wrote:
> > > > Intel Ice Lake has an integrated Thunderbolt controller which
> > > > means that the PCIe topology is extended directly from the two
> > > > root ports (RP0 and RP1).
> > > 
> > > A PCIe topology is always extended directly from root ports,
> > > regardless of whether a Thunderbolt controller is integrated, so I
> > > guess I'm missing the point you're making.  It doesn't sound like
> > > this is anything specific to Thunderbolt?
> >
> > The point I'm trying to make here is to explain why this is problem
> > now and not with the previous discrete controllers. With the
> > previous there was only a single ACPI power resource for the root
> > port and the Thunderbolt host router was connected to that root
> > port. PCIe hierarchy was extended through downstream ports (not root
> > ports) of that controller (which includes PCIe switch).
> 
> Sounds like you're using "PCIe topology extension" to mean
> specifically something below a Thunderbolt controller, excluding a
> subtree below a root port.  I don't think the PCI core is aware of
> that distinction.

Right it is not.

> > Now the thing is part of the SoC so power management is different
> > and causes problems in Linux.
> 
> The SoC is a physical packaging issue that really doesn't enter into
> the specs directly.  I'm trying to get at the logical topology
> questions in terms of the PCIe and ACPI specs.
> 
> I assume we could dream up a non-Thunderbolt topology that would show
> the same problem?

Yes.

> > > > Power management is handled by ACPI power resources that are
> > > > shared between the root ports, Thunderbolt controller (NHI) and xHCI
> > > > controller.
> > > > 
> > > > The topology with the power resources (marked with []) looks like:
> > > > 
> > > >   Host bridge
> > > >     |
> > > >     +- RP0 ---\
> > > >     +- RP1 ---|--+--> [TBT]
> > > >     +- NHI --/   |
> > > >     |            |
> > > >     |            v
> > > >     +- xHCI --> [D3C]
> > > > 
> > > > Here TBT and D3C are the shared ACPI power resources. ACPI
> > > > _PR3() method returns either TBT or D3C or both.
> 
> I'm not very familiar with _PR3.  I guess this is under an ACPI object
> representing a PCI device, e.g., \_SB.PCI0.RP0._PR3?

Correct.

> > > > Say we runtime suspend first the root ports RP0 and RP1, then
> > > > NHI. Now since the TBT power resource is still on when the root
> > > > ports are runtime suspended their dev->current_state is set to
> > > > D3hot. When NHI is runtime suspended TBT is finally turned off
> > > > but state of the root ports remain to be D3hot.
> 
> So in this example we might have:
> 
>   _SB.PCI0.RP0._PR3: TBT
>   _SB.PCI0.RP1._PR3: TBT
>   _SB.PCI0.NHI._PR3: TBT

and also D3C.

> And when Linux figures out that everything depending on TBT is in
> D3hot, it evaluates TBT._OFF, which puts them all in D3cold?  And part
> of the problem is that they're now in D3cold (where config access
> doesn't work) but Linux still thinks they're in D3hot (where config
> access would work)?

Exactly.

> I feel like I'm missing something because I don't know how D3C is
> involved, since you didn't mention suspending xHCI.

That's another power resource so we will also have D3C turned off when
xHCI gets suspended but I did not want to complicate things too much in
the changelog.

> And I can't mentally match up the patch with the D3hot/D3cold state
> change (if indeed that's the problem).  If we were updating the path
> that evaluates _OFF so it changed the power state of all dependent
> devices, *that* would make a lot of sense to me because it sounds like
> that's where the physical change happens that makes things out of
> sync.

I did that in the first version [1] but Rafael pointed out that it is
racy one way or another [2].

[1] https://www.spinics.net/lists/linux-pci/msg83583.html
[2] https://www.spinics.net/lists/linux-pci/msg83600.html
