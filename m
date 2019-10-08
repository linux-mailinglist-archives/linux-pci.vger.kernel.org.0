Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 422A8CF953
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 14:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbfJHMJM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 08:09:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:29707 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730541AbfJHMJM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 08:09:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 05:09:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="206624790"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 08 Oct 2019 05:09:08 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Oct 2019 15:09:07 +0300
Date:   Tue, 8 Oct 2019 15:09:07 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v8 4/6] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Message-ID: <20191008120907.GI2819@lahna.fi.intel.com>
References: <SL2P216MB01879766498AA7746C2E5FB780C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB01879766498AA7746C2E5FB780C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 26, 2019 at 12:54:22PM +0000, Nicholas Johnson wrote:
> Remove checks for resource size in extend_bridge_window(). This is
> necessary to allow the pci_bus_distribute_available_resources() to
> function when the kernel parameter pci=hpmemsize=nn[KMG] is used to
> allocate resources. Because the kernel parameter sets the size of all
> hotplug bridges to be the same, there are problems when nested hotplug
> bridges are encountered. Fitting a downstream hotplug bridge with size X
> and normal bridges with size Y into parent hotplug bridge with size X is
> impossible, and hence the downstream hotplug bridge needs to shrink to
> fit into its parent.

Maybe you could show the topology here which needs shrinking.

> Add check for if bridge is extended or shrunken and adjust pci_dbg to
> reflect this.
> 
> Reset the resource if its new size is zero (if we have run out of a
> bridge window resource). If it is set to zero size and left, it can
> cause significant problems when it comes to enabling devices.

Same comment here about explaining the "significant problems".
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---
>  drivers/pci/setup-bus.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index a072781ab..7e1dc892a 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1823,13 +1823,19 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,

Since it is also shrinking now maybe name it adjust_bridge_window() instead?
