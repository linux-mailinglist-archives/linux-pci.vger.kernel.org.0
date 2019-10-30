Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB961E9CA0
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2019 14:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfJ3Nto (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Oct 2019 09:49:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:29031 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfJ3Ntn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Oct 2019 09:49:43 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 06:49:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,247,1569308400"; 
   d="scan'208";a="211327785"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 30 Oct 2019 06:49:40 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 30 Oct 2019 15:49:40 +0200
Date:   Wed, 30 Oct 2019 15:49:39 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v10 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Message-ID: <20191030134939.GG2593@lahna.fi.intel.com>
References: <SL2P216MB0187C1ACBE716693FD5622BD80600@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20191030132509.GE2593@lahna.fi.intel.com>
 <SL2P216MB0187F0B0630B8C5950342CA680600@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB0187F0B0630B8C5950342CA680600@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 30, 2019 at 01:33:26PM +0000, Nicholas Johnson wrote:
> On Wed, Oct 30, 2019 at 03:25:09PM +0200, mika.westerberg@linux.intel.com wrote:
> > On Wed, Oct 30, 2019 at 12:47:44PM +0000, Nicholas Johnson wrote:
> > > Remove checks for resource size in extend_bridge_window(). This is
> > > necessary to allow the pci_bus_distribute_available_resources() to
> > > function when the kernel parameter pci=hpmemsize=nn[KMG] is used to
> > > allocate resources. Because the kernel parameter sets the size of all
> > > hotplug bridges to be the same, there are problems when nested hotplug
> > > bridges are encountered. Fitting a downstream hotplug bridge with size X
> > > and normal bridges with non-zero size Y into parent hotplug bridge with
> > > size X is impossible, and hence the downstream hotplug bridge needs to
> > > shrink to fit into its parent.
> > > 
> > > Add check for if bridge is extended or shrunken and adjust pci_dbg to
> > > reflect this.
> > > 
> > > Reset the resource if its new size is zero (if we have run out of a
> > > bridge window resource) to prevent the PCI resource assignment code from
> > > attempting to assign a zero-sized resource.
> > > 
> > > Rename extend_bridge_window() to adjust_bridge_window() to reflect the
> > > fact that the window can now shrink.
> > > 
> > > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > 
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Do I need to re-post with this line in it?

No. Typically maintainers add these when they apply the patch.
