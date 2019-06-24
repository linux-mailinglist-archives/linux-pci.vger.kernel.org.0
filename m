Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7D4509BB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 13:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfFXLYy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 07:24:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:51212 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbfFXLYy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 07:24:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 04:24:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,412,1557212400"; 
   d="scan'208";a="182616933"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 24 Jun 2019 04:24:50 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 24 Jun 2019 14:24:49 +0300
Date:   Mon, 24 Jun 2019 14:24:49 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: Skip resource distribution when no hotplug
 bridges
Message-ID: <20190624112449.GJ2640@lahna.fi.intel.com>
References: <20190622210310.180905-1-helgaas@kernel.org>
 <20190622210310.180905-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622210310.180905-3-helgaas@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 22, 2019 at 04:03:11PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> If "hotplug_bridges == 0", "!dev->is_hotplug_bridge" is always true, so the
> loop that divides the remaining resources among hotplug-capable bridges
> does nothing.
> 
> Check for "hotplug_bridges == 0" earlier, so we don't even have to compute
> the amount of remaining resources.  No functional change intended.
> 
> ---
> 
> I'm pretty sure this patch preserves the previous behavior of
> pci_bus_distribute_available_resources(), but I'm not sure that
> behavior is what we want.
> 
> For example, in the following topology, when we process bus 10, we
> find two non-hotplug bridges and no hotplug bridges, so IIUC we return
> without distributing any resources to them.  But I would think we
> should try to give 10:1c.0 more space if possible because it has a
> hotplug bridge below it.
> 
>   00:1c.0: hotplug bridge to [bus 10-2f]
>     10:1c.0: non-hotplug bridge to [bus 11-2e]
>       11:00.0: hotplug bridge to [bus 12-2e]
>     10:1c.1: non-hotplug bridge to [bus 2f]

Yes, I agree in this case we want to preserve more space for 10:1c.0.

For this patch,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
