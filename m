Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF831395B1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 17:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAMQVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 11:21:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:2775 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgAMQVy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 11:21:54 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 08:21:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="244739383"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 13 Jan 2020 08:21:51 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 13 Jan 2020 18:21:50 +0200
Date:   Mon, 13 Jan 2020 18:21:50 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v1 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Message-ID: <20200113162150.GO2838@lahna.fi.intel.com>
References: <PSXP216MB0438D3E2CFE64EBAA32AF691803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200107203435.GA137091@google.com>
 <PSXP216MB043869924730BFD3AA97B0A0803E0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB043869924730BFD3AA97B0A0803E0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 08, 2020 at 01:36:04AM +0000, Nicholas Johnson wrote:
> > Where's the patch that changes the caller so "new_size" may be smaller
> > than "size"?  I guess it must be "[3/3] PCI: Consider alignment of
> > hot-added bridges ..." because that's the only one that makes a
> > non-trivial change, right?
> 
> As above, there was always a possibility of the new_size being smaller. 
> For some reason, 1M is assigned to bridges, even if nothing is below 
> them (for example, unused non hotplug bridges in a Thunderbolt dock). It 
> may be an edge case if we are low on space, but theoretically it can 
> happen.
> 
> Also, when writing this, Mika was not interested in using hpmemsize, 
> which, when used, will cause new_size to be smaller than the current 
> size (actual size and add_size combined).

Just a small correction here about my motivation. So I'm testing on a
hardware where the BIOS assigns initial resources to the root/downstream
ports which is the majority of Thunderbolt capable PC systems nowadays.
Therefore the user does not need to pass any additional command line
parameters to get the ports working properly.

However, I'm of course interested in getting Linux PCI resource
management as good as possible regardless whether the firmware/BIOS
assigns them or not ;-)
