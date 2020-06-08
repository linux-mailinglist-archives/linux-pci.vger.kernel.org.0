Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17E1F1B38
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 16:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgFHOol (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 10:44:41 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:54548 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbgFHOol (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Jun 2020 10:44:41 -0400
Received: from T480.siklu.local (unknown [212.29.212.82])
        by mx.tkos.co.il (Postfix) with ESMTPA id 01B2D44046D;
        Mon,  8 Jun 2020 17:44:37 +0300 (IDT)
From:   Shmuel Hazan <sh@tkos.co.il>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Baruch Siach <baruch@tkos.co.il>,
        Chris ackham <chris.packham@alliedtelesis.co.nz>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Shmuel H <sh@tkos.co.il>
Subject: [RFC PATCH] pci: pci-mvebu: setup BAR0 to internal-regs
Date:   Mon,  8 Jun 2020 17:40:25 +0300
Message-Id: <20200608144024.1161237-1-sh@tkos.co.il>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Shmuel H <sh@tkos.co.il>

Set the port's BAR0 address to the SOC's internal registers address. By default, this register will point to 0xd0000000, which is not correct.

Signed-off-by: Shmuel Hazan <sh@tkos.co.il>
---
Sending again since I forgot to include a number of email addresses. 

Without this patch the wil6210 driver fails on interface up as follows:

# ip link set wlan0 up
[   46.142664] wil6210 0000:01:00.0 wlan0: wil_reset: Use firmware
<wil6210.fw> + board <wil6210.brd>
[   48.244216] wil6210 0000:01:00.0 wlan0: wil_wait_for_fw_ready:
Firmware not ready
ip: SIOCSIFFLAGS: Device timeout

With this patch, interface up succeeds:

# ip link set wlan0 up
[   53.632667] wil6210 0000:01:00.0 wlan0: wil_reset: Use firmware
<wil6210.fw> + board <wil6210.brd>
[   53.666560] wil6210 0000:01:00.0 wlan0: wmi_evt_ready: FW ver.
5.2.0.18(SW 18); MAC 40:0e:85:c0:77:5c; 0 MID's
[   53.676636] wil6210 0000:01:00.0 wlan0: wil_wait_for_fw_ready: FW
ready after 20 ms. HW version 0x00000002
[   53.686478] wil6210 0000:01:00.0 wlan0:
wil_configure_interrupt_moderation: set ITR_TX_CNT_TRSH = 500 usec
[   53.696191] wil6210 0000:01:00.0 wlan0:
wil_configure_interrupt_moderation: set ITR_TX_IDL_CNT_TRSH = 13 usec
[   53.706156] wil6210 0000:01:00.0 wlan0:
wil_configure_interrupt_moderation: set ITR_RX_CNT_TRSH = 500 usec
[   53.715855] wil6210 0000:01:00.0 wlan0:
wil_configure_interrupt_moderation: set ITR_RX_IDL_CNT_TRSH = 13 usec
[   53.725819] wil6210 0000:01:00.0 wlan0: wil_refresh_fw_capabilities:
keep_radio_on_during_sleep (0)

Tested on Armada 38x based system.

Another related bit of information is this U-Boot commit:

  https://gitlab.denx.de/u-boot/u-boot/commit/193a1e9f196b7fb7e913a70936c8a49060a1859c

It looks like some other devices are also affected the BAR0
initialization.
However, by default, u-boot won't initialize any PCI bus. Which
will cause the BAR0 register to stay on its default value. 

Any idea what is the right way to initialize BAR0?
---
 drivers/pci/controller/pci-mvebu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 153a64676bc9..4a00e1b81b4f 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -203,6 +203,11 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(1));
 	mvebu_writel(port, ((size - 1) & 0xffff0000) | 1,
 		     PCIE_BAR_CTRL_OFF(1));
+	
+	/* Point BAR0 to the device's internal registers (internal-regs on 
+	 * a38x, orion and more) */
+	mvebu_writel(port, 0xf1000000, PCIE_BAR_LO_OFF(0));
+	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(0));
 }
 
 static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
-- 
2.27.0

