Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D909E456E92
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 13:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhKSMDZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 07:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234785AbhKSMDQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 07:03:16 -0500
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9DDC061574;
        Fri, 19 Nov 2021 04:00:14 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id D0C8E28045D05;
        Fri, 19 Nov 2021 13:00:12 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C2CCD4A8C0; Fri, 19 Nov 2021 13:00:12 +0100 (CET)
Date:   Fri, 19 Nov 2021 13:00:12 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pciehp: clear cmd_busy bit when Command Completed
 in polling mode
Message-ID: <20211119120012.GC9692@wunner.de>
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

The first timeout occurs with the following bits set in ctrl->slot_ctrl:
  PCI_EXP_SLTCTL_PWR_IND_ON | PCI_EXP_SLTCTL_ATTN_IND_OFF

Those bits are set by:
  board_added()
    pciehp_set_indicators()


The second timeout occurs with:
  PCI_EXP_SLTCTL_PWR_IND_ON | PCI_EXP_SLTCTL_ATTN_IND_OFF |
  PCI_EXP_SLTCTL_PWR_OFF

This might be triggered by:
  remove_board()
    pciehp_power_off_slot()


So it seems Command Completed is not signaled when changing the
Power Indicator, Attention Indicator and Power Controller Control
bits in the Slot Control register.  But apparently it works for
the other bits.

We know there are hotplug controllers out there which suffer from
broken Command Completed support.  They support it for the bits
mentioned above but not the others.  So the inverse behavior from
your hotplug controller.  See this code comment in pcie_do_write_cmd():

	/*
	 * Controllers with the Intel CF118 and similar errata advertise
	 * Command Completed support, but they only set Command Completed
	 * if we change the "Control" bits for power, power indicator,
	 * attention indicator, or interlock.  If we only change the
	 * "Enable" bits, they never set the Command Completed bit.
	 */


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

I suspect that this patch merely papers over the problem and that
the real solution would be to either apply quirk_cmd_compl or a
similar quirk to your hotplug controller.

Please open a bug on bugzilla.kernel.org and attach full output
of lspci -vv and dmesg.  Be sure to add the following to the
command line:
  pciehp.pciehp_debug=1 dyndbg="file pciehp* +p"

Once you've done that, please report the bugzilla link here
so that we can analyze the issue properly.

Thanks,

Lukas
