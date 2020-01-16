Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9615A13D7D4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 11:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgAPKXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 05:23:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:3718 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgAPKXE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jan 2020 05:23:04 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 02:23:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,325,1574150400"; 
   d="scan'208";a="257781971"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 16 Jan 2020 02:23:01 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 16 Jan 2020 12:23:00 +0200
Date:   Thu, 16 Jan 2020 12:23:00 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Message-ID: <20200116102300.GY2838@lahna.fi.intel.com>
References: <PSXP216MB0438DE9E25E07F3915B8E99880370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB0438DE9E25E07F3915B8E99880370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 05:58:05PM +0000, Nicholas Johnson wrote:
> Remove checks for resource size in extend_bridge_window(). This is
> necessary to allow the pci_bus_distribute_available_resources() to
> function when the kernel parameter pci=hpmemsize=nn[KMG] is used to
> allocate resources. Because the kernel parameter sets the size of all
> hotplug bridges to be the same, there are problems when nested hotplug
> bridges are encountered. Fitting a downstream hotplug bridge with size X
> and normal bridges with non-zero size Y into parent hotplug bridge with
> size X is impossible, and hence the downstream hotplug bridge needs to
> shrink to fit into its parent.
> 
> Add check for if bridge is extended or shrunken and reflect that in the
> call to pci_dbg().
> 
> Do not change resource size if new size is zero (if we have run out of a
> bridge window resource) to prevent the PCI resource assignment code from
> attempting to assign a zero-sized resource. If this happens, we are
> running out of resource space, anyway, so not shrinking the resource
> will not deny space for other resources. This prevents the following
> from happening:
> 
> pcieport 0000:07:04.0: can't enable device: BAR 13 [io  0x1000-0x0fff] not claimed
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
