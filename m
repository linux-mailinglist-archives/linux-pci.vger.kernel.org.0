Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08AC7F30C0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 15:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfKGODE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 09:03:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:31664 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfKGODD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 09:03:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 06:03:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="213028106"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 07 Nov 2019 06:03:00 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 07 Nov 2019 16:02:59 +0200
Date:   Thu, 7 Nov 2019 16:02:59 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Valerio Passini <passini.valerio@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Allocate resources directly under
 the non-hotplug bridge
Message-ID: <20191107140259.GN2552@lahna.fi.intel.com>
References: <20191107090333.GG2552@lahna.fi.intel.com>
 <20191107135246.GA90684@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107135246.GA90684@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 07:52:46AM -0600, Bjorn Helgaas wrote:
> > > What would happen if a device below one of the non-hotplug bridges,
> > > e.g., 3a:00.0, had an I/O BAR?  Would this patch still work?
> > 
> > I think it would still work because now we call pci_bus_size_bridges()
> > only for non-hotplug bridge which do not have I/O window open so
> > pbus_size_io() fails to find the "free" I/O resource on that bus and the
> > kernel then fails to assign that I/O resource for the device.
> 
> Not sure I understand; are you saying that we wouldn't have the EC/GPE
> issue, but we'd be unable to use a device below 3a:00.0 that happened
> to have an I/O BAR?

Yes.

> That doesn't sound optimal because there is I/O space available that
> could be routed to 3a:00.0

If the none of the upstream bridges up to the PCIe root port does not
have I/O window open, I don't think we can do much about it. Unless I'm
missing something of course.
