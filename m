Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1881CFE26
	for <lists+linux-pci@lfdr.de>; Tue, 12 May 2020 21:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgELTUo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 12 May 2020 15:20:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48070 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELTUo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 May 2020 15:20:44 -0400
Received: from 1.general.jvosburgh.us.vpn ([10.172.68.206] helo=famine.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <jay.vosburgh@canonical.com>)
        id 1jYaS8-0002XR-Ms; Tue, 12 May 2020 19:20:33 +0000
Received: by famine.localdomain (Postfix, from userid 1000)
        id ED86367BB3; Tue, 12 May 2020 12:20:30 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id E8090AC1DB;
        Tue, 12 May 2020 12:20:30 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        liudongdong 00290354 <liudongdong3@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v1 1/1] PCI/ERR: Handle fatal error recovery for non-hotplug capable devices
In-reply-to: <f4bbacd3af453285271c8fc733652969e11b84f8.1588821160.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <18609.1588812972@famine> <f4bbacd3af453285271c8fc733652969e11b84f8.1588821160.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Comments: In-reply-to sathyanarayanan.kuppuswamy@linux.intel.com
   message dated "Wed, 06 May 2020 20:32:59 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.6; GNU Emacs 27.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9907.1589311230.1@famine>
Content-Transfer-Encoding: 8BIT
Date:   Tue, 12 May 2020 12:20:30 -0700
Message-ID: <9908.1589311230@famine>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

sathyanarayanan.kuppuswamy@linux.intel.com wrote:

>From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
>If there are non-hotplug capable devices connected to a given
>port, then during the fatal error recovery(triggered by DPC or
>AER), after calling reset_link() function, we cannot rely on
>hotplug handler to detach and re-enumerate the device drivers
>in the affected bus. Instead, we will have to let the error
>recovery handler call report_slot_reset() for all devices in
>the bus to notify about the reset operation. Although this is
>only required for non hot-plug capable devices, doing it for
>hotplug capable devices should not affect the functionality.

	Yicong,

	Does the patch below also resolve the issue for you, as with
your changed version of my original patch?

	-J

>Along with above issue, this fix also applicable to following
>issue.
>
>Commit 6d2c89441571 ("PCI/ERR: Update error status after
>reset_link()") added support to store status of reset_link()
>call. Although this fixed the error recovery issue observed if
>the initial value of error status is PCI_ERS_RESULT_DISCONNECT
>or PCI_ERS_RESULT_NO_AER_DRIVER, it also discarded the status
>result from report_frozen_detected. This can cause a failure to
>recover if _NEED_RESET is returned by report_frozen_detected and
>report_slot_reset is not invoked.
>
>Such an event can be induced for testing purposes by reducing the
>Max_Payload_Size of a PCIe bridge to less than that of a device
>downstream from the bridge, and then initiating I/O through the
>device, resulting in oversize transactions.  In the presence of DPC,
>this results in a containment event and attempted reset and recovery
>via pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not
>invoked, and the device does not recover.
>
>[original patch is from jay.vosburgh@canonical.com]
>[original patch link https://lore.kernel.org/linux-pci/18609.1588812972@famine/]
>Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>---
> drivers/pci/pcie/err.c | 19 +++++++++++++++----
> 1 file changed, 15 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>index 14bb8f54723e..db80e1ecb2dc 100644
>--- a/drivers/pci/pcie/err.c
>+++ b/drivers/pci/pcie/err.c
>@@ -165,13 +165,24 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> 	pci_dbg(dev, "broadcast error_detected message\n");
> 	if (state == pci_channel_io_frozen) {
> 		pci_walk_bus(bus, report_frozen_detected, &status);
>-		status = reset_link(dev);
>-		if (status != PCI_ERS_RESULT_RECOVERED) {
>+		status = PCI_ERS_RESULT_NEED_RESET;
>+	} else {
>+		pci_walk_bus(bus, report_normal_detected, &status);
>+	}
>+
>+	if (status == PCI_ERS_RESULT_NEED_RESET) {
>+		if (reset_link) {
>+			if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED)
>+				status = PCI_ERS_RESULT_DISCONNECT;
>+		} else {
>+			if (pci_bus_error_reset(dev))
>+				status = PCI_ERS_RESULT_DISCONNECT;
>+		}
>+
>+		if (status == PCI_ERS_RESULT_DISCONNECT) {
> 			pci_warn(dev, "link reset failed\n");
> 			goto failed;
> 		}
>-	} else {
>-		pci_walk_bus(bus, report_normal_detected, &status);
> 	}
> 
> 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>-- 
>2.17.1
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
