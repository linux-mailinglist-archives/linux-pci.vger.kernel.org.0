Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568F945F346
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 18:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbhKZSB4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 13:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbhKZR7z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 12:59:55 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01631C07E5F3
        for <linux-pci@vger.kernel.org>; Fri, 26 Nov 2021 09:33:11 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id EA7AE3003E162;
        Fri, 26 Nov 2021 18:33:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D26AF272577; Fri, 26 Nov 2021 18:33:09 +0100 (CET)
Date:   Fri, 26 Nov 2021 18:33:09 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: clear cmd_busy bit when Command Completed
 in polling mode
Message-ID: <20211126173309.GA12255@wunner.de>
References: <20211111054258.7309-1-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111054258.7309-1-zhangliguang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 11, 2021 at 01:42:58PM +0800, Liguang Zhang wrote:
> This patch fixes this problem that on driver probe from system startup,
> pciehp checks the Presence Detect State bit in the Slot Status register
> to bring up an occupied slot or bring down an unoccupied slot. If empty
> slot's power status is on, turn power off. The Hot-Plug interrupt isn't
> requested yet, so avoid triggering a notification by calling
> pcie_disable_notification().
> 
> Both the CCIE and HPIE bits are masked in pcie_disable_notification(),
> when we issue a hotplug command, pcie_wait_cmd() will polling the
> Command Completed bit instead of waiting for an interrupt. But cmd_busy
> bit was not cleared when Command Completed which results in timeouts
> like this in pciehp_power_off_slot() and pcie_init_notification():
> 
>   pcieport 0000:00:03.0: pciehp: Timeout on hotplug command 0x01c0
> (issued 2264 msec ago)
>   pcieport 0000:00:03.0: pciehp: Timeout on hotplug command 0x05c0
> (issued 2288 msec ago)
> 
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>

Fixes: a5dd4b4b0570 ("PCI: pciehp: Wait for hotplug command completion where necessary")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215143
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.19+

Thanks a lot, that's a really good catch.

It's a somewhat intricate bug, so I'll try to explain in my own words:

If notification is disabled (HPIE or CCIE not set in the Slot Status
register), we rely on pcie_poll_cmd() to poll for Command Completed.
But once it's signaled, we neglect to clear ctrl->cmd_busy.
(Normally it is cleared by the hardirq handler pciehp_isr() if
notification is enabled.)

The result is that starting with the second Slot Control write,
pciehp will gratuitously wait for a command to finish which has
already finished and it will incorrectly report a timeout.

The bug was originally introduced in 2015 by commit a5dd4b4b0570
("PCI: pciehp: Wait for hotplug command completion where necessary"),
but didn't manifest itself because the first Slot Control Write already
enabled notification and from that point on the hardirq handler would
clear ctrl->cmd_busy.  However I think the bug may have manifested
itself with pciehp_poll_mode=1.

It wasn't until commit 4e6a13356f1c ("PCI: pciehp: Deduplicate presence
check on probe & resume") that multiple consecutive Slot Control writes
were performed on ->probe with notification disabled, so that's the
commit which first exposed the bug with pciehp_poll_mode=0.

Thanks,

Lukas

> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 83a0fa119cae..8698aefc6041 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -98,6 +98,8 @@ static int pcie_poll_cmd(struct controller *ctrl, int timeout)
>  		if (slot_status & PCI_EXP_SLTSTA_CC) {
>  			pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
>  						   PCI_EXP_SLTSTA_CC);
> +			ctrl->cmd_busy = 0;
> +			smp_mb();
>  			return 1;
>  		}
>  		msleep(10);
> -- 
> 2.19.1.6.gb485710b
