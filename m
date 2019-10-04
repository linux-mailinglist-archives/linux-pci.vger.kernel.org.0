Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F6BCBE65
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 17:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbfJDPAg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Oct 2019 11:00:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:57546 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388802AbfJDPAg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Oct 2019 11:00:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 08:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="205876407"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 04 Oct 2019 08:00:32 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 04 Oct 2019 18:00:32 +0300
Date:   Fri, 4 Oct 2019 18:00:32 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v8 0/6] Patch series to support Thunderbolt without any
 BIOS support
Message-ID: <20191004150032.GK2819@lahna.fi.intel.com>
References: <20191003121946.GS2819@lahna.fi.intel.com>
 <20191004130803.GA41961@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004130803.GA41961@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 04, 2019 at 08:08:03AM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 03, 2019 at 03:19:46PM +0300, mika.westerberg@linux.intel.com wrote:
> > On Fri, Jul 26, 2019 at 12:52:58PM +0000, Nicholas Johnson wrote:
> > > Patch series rebased to 5.3-rc1.
> > > 
> > > If possible, please have a quick read over while I am away (2019-07-27
> > > to mid 2019-08-04), so I can fix any mistakes or make simple changes to
> > > get problems out of the way for a more thorough examination later.
> > > 
> > > Thanks!
> > > 
> > > Kind regards,
> > > Nicholas
> > > 
> > > Nicholas Johnson (6):
> > >   PCI: Consider alignment of hot-added bridges when distributing
> > >     available resources
> > >   PCI: In extend_bridge_window() change available to new_size
> > >   PCI: Change extend_bridge_window() to set resource size directly
> > >   PCI: Allow extend_bridge_window() to shrink resource if necessary
> > >   PCI: Add hp_mmio_size and hp_mmio_pref_size parameters
> > >   PCI: Fix bug resulting in double hpmemsize being assigned to MMIO
> > >     window
> > 
> > Hi Bjorn,
> > 
> > What's the status of this series? I don't see them in v5.4-rc1.
> 
> They're still on my to-do list but are currently languishing because
> they touch critical but complicated code that I don't understand and
> nobody else has chimed in to help review them.  Testing reports would
> also be helpful.

I will test this next week as it solves one issue I reported some time ago.

I can also help you to review this, at least parts touching
extend_bridge_window() and pci_bus_distribute_available_resources(),
because those functions were added by me ;-)
