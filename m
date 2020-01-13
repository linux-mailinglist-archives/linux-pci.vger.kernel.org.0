Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A61D1139575
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 17:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAMQHM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 11:07:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:64300 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbgAMQHL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 11:07:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 08:07:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="244664707"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 13 Jan 2020 08:07:08 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 13 Jan 2020 18:07:08 +0200
Date:   Mon, 13 Jan 2020 18:07:08 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v1 3/3] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Message-ID: <20200113160708.GK2838@lahna.fi.intel.com>
References: <PSXP216MB0438C2BFD0FD3691ED9C83F4803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB0438C2BFD0FD3691ED9C83F4803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 06, 2020 at 03:46:13PM +0000, Nicholas Johnson wrote:
> Change pci_bus_distribute_available_resources() to better handle bridges
> with different resource alignment requirements.
> 
> The arguments io, mmio and mmio_pref represent the start and end
> addresses of resource, in which we must fit the current bridge window.
> 
> The steps taken by pci_bus_distribute_available_resources():
> 
> 	- For io, mmio and mmio_pref, increase .start to align with the
> 	  alignment of the current bridge window (otherwise the current
> 	  bridge window may not fit within the available range).
> 
> 	- For io, mmio and mmio_pref, adjust the current bridge window
> 	  to the size after the above.
> 
> 	- Count the number of hotplug bridges and normal bridges on this
> 	  bus.
> 
> 	- If the total number of bridges is one, give that bridge all of
> 	  the resources and return.
> 
> 	- If there are no hotplug bridges, return.
> 
> 	- For io, mmio and mmio_pref, increase .start by the amount
> 	  required for each bridge resource on the bus for non hotplug
> 	  bridges, giving extra room to make up for alignment of those
> 	  resources.
> 
> 	- For io, mmio and mmio_pref, calculate the resource size per
> 	  hotplug bridge which is available after the previous steps.
> 
> 	- For io, mmio and mmio_pref, distribute the resources to each
> 	  hotplug bridge, with the sizes calculated above.
> 
> The motivation for fixing this is Thunderbolt with native PCI
> enumeration, enabling external graphics cards and other devices with
> bridge alignment higher than 1MB. This fixes the use case where the user
> hot-adds Thunderbolt devices containing PCI devices with BAR
> alignment >1M and having the resources fail to assign.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199581
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Still solves the issue I reported above so,

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Also looks good to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
