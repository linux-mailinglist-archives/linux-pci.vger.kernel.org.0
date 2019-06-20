Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2862B4C970
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 10:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbfFTI1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 04:27:35 -0400
Received: from mga02.intel.com ([134.134.136.20]:22482 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfFTI1f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 04:27:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 01:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,396,1557212400"; 
   d="scan'208";a="181815906"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 20 Jun 2019 01:27:32 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 20 Jun 2019 11:27:30 +0300
Date:   Thu, 20 Jun 2019 11:27:30 +0300
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
Message-ID: <20190620082730.GM2640@lahna.fi.intel.com>
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
 <20190618161858.77834-2-mika.westerberg@linux.intel.com>
 <20190619212801.GC143205@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619212801.GC143205@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 04:28:01PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 18, 2019 at 07:18:56PM +0300, Mika Westerberg wrote:
> > Intel Ice Lake has an integrated Thunderbolt controller which means that
> > the PCIe topology is extended directly from the two root ports (RP0 and
> > RP1).
> 
> A PCIe topology is always extended directly from root ports,
> regardless of whether a Thunderbolt controller is integrated, so I
> guess I'm missing the point you're making.  It doesn't sound like this
> is anything specific to Thunderbolt?

The point I'm trying to make here is to explain why this is problem now
and not with the previous discrete controllers. With the previous there
was only a single ACPI power resource for the root port and the
Thunderbolt host router was connected to that root port. PCIe hierarchy
was extended through downstream ports (not root ports) of that
controller (which includes PCIe switch).

Now the thing is part of the SoC so power management is different and
causes problems in Linux.

> > Power management is handled by ACPI power resources that are
> > shared between the root ports, Thunderbolt controller (NHI) and xHCI
> > controller.
> > 
> > The topology with the power resources (marked with []) looks like:
> > 
> >   Host bridge
> >     |
> >     +- RP0 ---\
> >     +- RP1 ---|--+--> [TBT]
> >     +- NHI --/   |
> >     |            |
> >     |            v
> >     +- xHCI --> [D3C]
> > 
> > Here TBT and D3C are the shared ACPI power resources. ACPI _PR3() method
> > returns either TBT or D3C or both.
> > 
> > Say we runtime suspend first the root ports RP0 and RP1, then NHI. Now
> > since the TBT power resource is still on when the root ports are runtime
> > suspended their dev->current_state is set to D3hot. When NHI is runtime
> > suspended TBT is finally turned off but state of the root ports remain
> > to be D3hot.
> > 
> > If the user now runs lspci for instance, the result is all 1's like in
> > the below output (07.0 is the first root port, RP0):
> > 
> > 00:07.0 PCI bridge: Intel Corporation Device 8a1d (rev ff) (prog-if ff)
> >     !!! Unknown header type 7f
> >     Kernel driver in use: pcieport
> > 
> > I short the hardware state is not in sync with the software state
> > anymore. The exact same thing happens with the PME polling thread which
> > ends up bringing the root ports back into D0 after they are runtime
> > suspended.
> 
> s/I /In /

Thanks, I'll fix it.
