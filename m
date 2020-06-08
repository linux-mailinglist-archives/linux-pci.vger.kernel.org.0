Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0BB1F203B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 21:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgFHTnl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 15:43:41 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52999 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgFHTnl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jun 2020 15:43:41 -0400
X-Originating-IP: 86.210.146.109
Received: from windsurf (lfbn-tou-1-915-109.w86-210.abo.wanadoo.fr [86.210.146.109])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 8305660005;
        Mon,  8 Jun 2020 19:43:36 +0000 (UTC)
Date:   Mon, 8 Jun 2020 21:43:35 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Shmuel Hazan <sh@tkos.co.il>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Marek =?UTF-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris ackham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] pci: pci-mvebu: setup BAR0 to internal-regs
Message-ID: <20200608214335.156baaaa@windsurf>
In-Reply-To: <20200608144024.1161237-1-sh@tkos.co.il>
References: <20200608144024.1161237-1-sh@tkos.co.il>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon,  8 Jun 2020 17:40:25 +0300
Shmuel Hazan <sh@tkos.co.il> wrote:

> From: Shmuel H <sh@tkos.co.il>
> 
> Set the port's BAR0 address to the SOC's internal registers address. By default, this register will point to 0xd0000000, which is not correct.
> 
> Signed-off-by: Shmuel Hazan <sh@tkos.co.il>
> ---
> Sending again since I forgot to include a number of email addresses. 
> 
> Without this patch the wil6210 driver fails on interface up as follows:
> 
> # ip link set wlan0 up
> [   46.142664] wil6210 0000:01:00.0 wlan0: wil_reset: Use firmware
> <wil6210.fw> + board <wil6210.brd>
> [   48.244216] wil6210 0000:01:00.0 wlan0: wil_wait_for_fw_ready:
> Firmware not ready
> ip: SIOCSIFFLAGS: Device timeout

Do you have any idea why this particular would not work, while many
other PCIe devices do ?

> 
> With this patch, interface up succeeds:
> 
> # ip link set wlan0 up
> [   53.632667] wil6210 0000:01:00.0 wlan0: wil_reset: Use firmware
> <wil6210.fw> + board <wil6210.brd>
> [   53.666560] wil6210 0000:01:00.0 wlan0: wmi_evt_ready: FW ver.
> 5.2.0.18(SW 18); MAC 40:0e:85:c0:77:5c; 0 MID's
> [   53.676636] wil6210 0000:01:00.0 wlan0: wil_wait_for_fw_ready: FW
> ready after 20 ms. HW version 0x00000002
> [   53.686478] wil6210 0000:01:00.0 wlan0:
> wil_configure_interrupt_moderation: set ITR_TX_CNT_TRSH = 500 usec
> [   53.696191] wil6210 0000:01:00.0 wlan0:
> wil_configure_interrupt_moderation: set ITR_TX_IDL_CNT_TRSH = 13 usec
> [   53.706156] wil6210 0000:01:00.0 wlan0:
> wil_configure_interrupt_moderation: set ITR_RX_CNT_TRSH = 500 usec
> [   53.715855] wil6210 0000:01:00.0 wlan0:
> wil_configure_interrupt_moderation: set ITR_RX_IDL_CNT_TRSH = 13 usec
> [   53.725819] wil6210 0000:01:00.0 wlan0: wil_refresh_fw_capabilities:
> keep_radio_on_during_sleep (0)
> 
> Tested on Armada 38x based system.
> 
> Another related bit of information is this U-Boot commit:
> 
>   https://gitlab.denx.de/u-boot/u-boot/commit/193a1e9f196b7fb7e913a70936c8a49060a1859c
> 
> It looks like some other devices are also affected the BAR0
> initialization.
> However, by default, u-boot won't initialize any PCI bus. Which
> will cause the BAR0 register to stay on its default value. 

Perhaps you want to include more of these details in the commit log.

> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 153a64676bc9..4a00e1b81b4f 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -203,6 +203,11 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
>  	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(1));
>  	mvebu_writel(port, ((size - 1) & 0xffff0000) | 1,
>  		     PCIE_BAR_CTRL_OFF(1));
> +	
> +	/* Point BAR0 to the device's internal registers (internal-regs on 
> +	 * a38x, orion and more) */
> +	mvebu_writel(port, 0xf1000000, PCIE_BAR_LO_OFF(0));

Some Armada 370/XP platforms really do use 0xd0000000 as the base
address of the internal registers. This information is available in the
DT. I think you could simply take the base address of the PCIe
controller, round down to 1 MB (which is the size of the internal
registers window) and that would give you the right address.

However, it would be good to understand this a little bit better.

Is this something you're seeing with mainline U-Boot only ? Or also
with the vendor U-Boot ? Only with this specific PCIe device ?

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
