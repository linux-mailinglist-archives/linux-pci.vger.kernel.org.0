Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A476DEE43
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 15:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfJUNre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 09:47:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:50225 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbfJUNre (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 09:47:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 06:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="209446839"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 21 Oct 2019 06:47:30 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Oct 2019 16:47:29 +0300
Date:   Mon, 21 Oct 2019 16:47:29 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v3 3/3] PCI: pciehp: Add dmi table for in-band presence
 disabled
Message-ID: <20191021134729.GL2819@lahna.fi.intel.com>
References: <20191017193256.3636-1-stuart.w.hayes@gmail.com>
 <20191017193256.3636-4-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017193256.3636-4-stuart.w.hayes@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 17, 2019 at 03:32:56PM -0400, Stuart Hayes wrote:
> Some systems have in-band presence detection disabled for hot-plug PCI
> slots, but do not report this in the slot capabilities 2 (SLTCAP2) register.
> On these systems, presence detect can become active well after the link is
> reported to be active, which can cause the slots to be disabled after a
> device is connected.
> 
> Add a dmi table to flag these systems as having in-band presence disabled.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 02eb811a014f..4d377a2a62ce 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -14,6 +14,7 @@
>  
>  #define dev_fmt(fmt) "pciehp: " fmt
>  
> +#include <linux/dmi.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/jiffies.h>
> @@ -26,6 +27,16 @@
>  #include "../pci.h"
>  #include "pciehp.h"
>  
> +static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
> +	{
> +		.ident = "Dell System",
> +		.matches = {
> +			DMI_MATCH(DMI_OEM_STRING, "Dell System"),

Sorry if this has been discussed previously already but isn't this going
to apply on all Dell systems, not just the affected ones? Is this the
intention?
