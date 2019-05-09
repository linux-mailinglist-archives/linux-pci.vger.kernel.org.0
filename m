Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC9DB18B28
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfEIOD3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfEIOD3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 10:03:29 -0400
Received: from localhost (50-81-63-4.client.mchsi.com [50.81.63.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41EE82053B;
        Thu,  9 May 2019 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557410608;
        bh=trlSzHZslliX2aiCuWV+5Pq822etwMk/tnPXDc/ZDP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zEKUSXZ/qTg7Fu5pzthQsMr3B5zLt3jj5mTUV7LDP0ZyR1A8rQkDCazvpnCM1JnPz
         6+4rEROACrzW5j2j5QTgmVHXdTK/E/Kn/HbSlmngLh38lvuKg1hSgnMgxMFPFSin4b
         NqpJiOsLhFklDj4Q4+wGDdb10Y05AEnqOcdjD56c=
Date:   Thu, 9 May 2019 09:03:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH v2 9/9] PCI: hotplug: Prefix ctrl_*() dmesg logs with
 pciehp slot name
Message-ID: <20190509140326.GA88424@google.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
 <20190503035946.23608-10-fred@fredlawl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503035946.23608-10-fred@fredlawl.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 02, 2019 at 10:59:46PM -0500, Frederick Lawler wrote:
> Remove current uses of "Slot(%s)" and then prefix ctrl_*() dmesg
> with pciehp slot name to include the slot name for all uses of ctrl_*()
> wrappers.
> 
> Signed-off-by: Frederick Lawler <fred@fredlawl.com>
> ---
>  drivers/pci/hotplug/pciehp.h      | 12 ++++---
>  drivers/pci/hotplug/pciehp_core.c |  9 +++--
>  drivers/pci/hotplug/pciehp_ctrl.c | 58 ++++++++++++-------------------
>  drivers/pci/hotplug/pciehp_hpc.c  |  5 ++-
>  4 files changed, 38 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 06ff9d31405e..e1cdc3565c62 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -32,13 +32,17 @@ extern int pciehp_poll_time;
>  extern bool pciehp_debug;
>  
>  #define ctrl_dbg(ctrl, format, arg...)					\
> -	pci_dbg(ctrl->pcie->port, format, ## arg)
> +	pci_dbg(ctrl->pcie->port, "Slot(%s): " format,			\
> +		slot_name(ctrl), ## arg)

This would be nice to do, but given the current code organization, I don't
think it's actually feasible to use slot_name() in these wrappers because
the slot name is initialized in init_slot(), but there are lots of places
we can emit messages before that, especially if debug is enabled:

  pciehp_probe
    pcie_init
      dbg_ctrl
        ctrl_info                          # no slot yet
      ctrl_info("Slot #%d AttnBtn%c ...")  # no slot yet
      if (POWER_CTRL)
        pciehp_get_power_status
	  ctrl_dbg("SLOTCTRL")             # no slot yet
	if (...)
	  pcie_disable_notification
	    pcie_write_cmd
	      pcie_do_write_cmd
	        ctrl_info("no response")   # no slot yet
	    ctrl_dbg("SLOTCTRL")           # no slot yet
	  pciehp_power_off_slot
	    ctrl_dbg("SLOTCTRL")           # no slot yet
    init_slot                              # slot valid after this returns
