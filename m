Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDBA954F1C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 14:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfFYMnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 08:43:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:26004 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbfFYMnF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 08:43:05 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 05:43:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,415,1557212400"; 
   d="scan'208";a="182879420"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 25 Jun 2019 05:43:02 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Jun 2019 15:43:01 +0300
Date:   Tue, 25 Jun 2019 15:43:01 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: Skip resource distribution when no hotplug
 bridges
Message-ID: <20190625124301.GG2640@lahna.fi.intel.com>
References: <20190622210310.180905-1-helgaas@kernel.org>
 <20190622210310.180905-3-helgaas@kernel.org>
 <20190624112449.GJ2640@lahna.fi.intel.com>
 <8a53232416cce158fad35b781eb80b3ace3afc08.camel@kernel.crashing.org>
 <20190625100534.GZ2640@lahna.fi.intel.com>
 <c4daf43a302eeb1c507b9cf4a353200669e04ad8.camel@kernel.crashing.org>
 <20190625120455.GF2640@lahna.fi.intel.com>
 <5c1b2d42b21be354894ea5ae6a208664ad0df9e0.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c1b2d42b21be354894ea5ae6a208664ad0df9e0.camel@kernel.crashing.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 10:23:33PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2019-06-25 at 15:04 +0300, Mika Westerberg wrote:
> > > What's your experience in that area ? How (well) do they handle it in
> > > the boot firmware ? at least on arm64, boot firmwares are rather
> > > catastrophic when it comes to PCI, and on other embedded devices they
> > > are basically non-existent.
> > 
> > Well my experience is quite limited to recent Macs and PCs which usually
> > handle the initial resource allocation just fine. In case of Thunderbolt
> > some "older" PCs handle everything in firmware, even the runtime
> > resource allocation via SMI handler accompanied with ACPI hotplug.
> 
> Ah so this is what Lenovo calls "Thunderbolt firmware assist" in the
> BIOS ?

Yes, exactly.

> I turned that on, it did help with Linux :)

Well, it should also work using native PCIe with recent kernels. At
least that's what I've been trying to get working since last year ;-)
