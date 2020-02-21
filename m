Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42AA5166EF4
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 06:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgBUFVt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Feb 2020 00:21:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgBUFVt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Feb 2020 00:21:49 -0500
Received: from localhost (c-98-207-104-244.hsd1.ca.comcast.net [98.207.104.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD0D208C4;
        Fri, 21 Feb 2020 05:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582262508;
        bh=k+xWkXE9GanKA1I/TU4Il80HQEcFWT0VW7It7YnO+zk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rZFfbt3Ind5n5SyHSLZN3GqLiBN5qUpHq45nLTBbtrWN4pYOamrXosFr3rLw5C/H3
         KXTCjKCkEVfNrc3FHCGrEZdoEj4qiNosTJKLYEpodgKj5VoLN/LxWXvyGg7shdIyqf
         2OguAs98pfUFkh7ppaynQ/11UWTr64XVMtVAZPTc=
Date:   Thu, 20 Feb 2020 23:21:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de
Subject: Re: [PATCH v4 3/3] PCI: pciehp: Add dmi table for in-band presence
 disabled
Message-ID: <20200221052147.GA154040@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025190047.38130-4-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 25, 2019 at 03:00:47PM -0400, Stuart Hayes wrote:
> Some systems have in-band presence detection disabled for hot-plug PCI
> slots, but do not report this in the slot capabilities 2 (SLTCAP2) register.

This doesn't seem quite accurate to me.  PCI_EXP_SLTCAP2_IBPD does not
actually tell us whether in-band presence detection is disabled.  It
only tells us whether it *can* be disabled.

I think I know what you mean, but this text suggests that
PCI_EXP_SLTCAP2_IBPD not being set is the defect, and I don't think it
is.  IIUC, even if PCI_EXP_SLTCAP2_IBPD were set,
PCI_EXP_SLTCTL_IBPD_DISABLE would have no effect because in-band
presence detect just isn't supported at all regardless of how we set
PCI_EXP_SLTCTL_IBPD_DISABLE.

> On these systems, presence detect can become active well after the link is
> reported to be active, which can cause the slots to be disabled after a
> device is connected.
> 
> Add a dmi table to flag these systems as having in-band presence disabled.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> ---
> v4
>   add comment to dmi table
> 
>  drivers/pci/hotplug/pciehp_hpc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 02d95ab27a12..9541735bd0aa 100644
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
> @@ -26,6 +27,24 @@
>  #include "../pci.h"
>  #include "pciehp.h"
>  
> +static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
> +	/*
> +	 * Match all Dell systems, as some Dell systems have inband
> +	 * presence disabled on NVMe slots (but don't support the bit to

Is there something that restricts these slots to being used only for
NVMe?  If not, I'd rather simply say that some Root Ports don't
support in-band presence detect.  You say it's "disabled", which
suggests that it could be *enabled*.  But I have the impression that
it's actually just not supported at all (or maybe it's disabled by the
BIOS via some non-architected mechanism).

> +	 * report it). Setting inband presence disabled should have no
> +	 * negative effect, except on broken hotplug slots that never
> +	 * assert presence detect--and those will still work, they will
> +	 * just have a bit of extra delay before being probed.
> +	 */
> +	{
> +		.ident = "Dell System",
> +		.matches = {
> +			DMI_MATCH(DMI_OEM_STRING, "Dell System"),
> +		},
> +	},
> +	{}
> +};
> +
>  static inline struct pci_dev *ctrl_dev(struct controller *ctrl)
>  {
>  	return ctrl->pcie->port;
> @@ -895,6 +914,9 @@ struct controller *pcie_init(struct pcie_device *dev)
>  		ctrl->inband_presence_disabled = 1;
>  	}
>  
> +	if (dmi_first_match(inband_presence_disabled_dmi_table))
> +		ctrl->inband_presence_disabled = 1;

This doesn't seem quite right: the DMI table should only apply to
built-in ports, not to ports on plugin cards.

If we plug in a switch with hotplug-capable downstream ports, and
those ports do not advertise PCI_EXP_SLTCAP2_IBPD, I think this code
sets "inband_presence_disabled" for those ports even though it is not
disabled.

IIUC, that will make this plugin card behave differently in a Dell
system than it will in other systems, and that doesn't seem right to
me.

>  	/*
>  	 * If empty slot's power status is on, turn power off.  The IRQ isn't
>  	 * requested yet, so avoid triggering a notification with this command.
> -- 
> 2.18.1
> 
