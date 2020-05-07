Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD11C7F72
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 02:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgEGA5S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 20:57:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56855 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgEGA5S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 20:57:18 -0400
Received: from 1.general.jvosburgh.us.vpn ([10.172.68.206] helo=famine.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <jay.vosburgh@canonical.com>)
        id 1jWUpi-0002UG-9x; Thu, 07 May 2020 00:56:14 +0000
Received: by famine.localdomain (Postfix, from userid 1000)
        id 8E1326C567; Wed,  6 May 2020 17:56:12 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 88D57AC1DB;
        Wed,  6 May 2020 17:56:12 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Kuppuswamy\, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ERR: Resolve regression in pcie_do_recovery
In-reply-to: <20200506203249.GA453633@bjorn-Precision-5520>
References: <20200506203249.GA453633@bjorn-Precision-5520>
Comments: In-reply-to Bjorn Helgaas <helgaas@kernel.org>
   message dated "Wed, 06 May 2020 15:32:49 -0500."
X-Mailer: MH-E 8.6+git; nmh 1.6; GNU Emacs 27.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <18608.1588812972.1@famine>
Date:   Wed, 06 May 2020 17:56:12 -0700
Message-ID: <18609.1588812972@famine>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> wrote:

>On Wed, May 06, 2020 at 11:08:35AM -0700, Jay Vosburgh wrote:
>> Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>> 
>> >"Kuppuswamy, Sathyanarayanan" wrote:
>> >
>> >>Hi Jay,
>> >>
>> >>On 4/29/20 6:15 PM, Kuppuswamy, Sathyanarayanan wrote:
>> >>>
>> >>>
>> >>> On 4/29/20 5:42 PM, Jay Vosburgh wrote:
[...]
>> >>> I think this issue is related to the issue discussed in following
>> >>> thread (DPC non-hotplug support).
>> >>>
>> >>> https://lkml.org/lkml/2020/3/28/328
>> >>>
>> >>> If my assumption is correct, you are dealing with devices which are
>> >>> not hotplug capable. If the devices are hotplug capable then you don't
>> >>> need to proceed to report_slot_reset(), since hotplug handler will
>> >>> remove/re-enumerate the devices correctly.
>> >
>> >	Correct, this particular device (a network card) is in a
>> >non-hotplug slot.
>> >
>> >>Can you check whether following fix works for you?
>> >
>> >	Yes, it does.
>> >
>> >	I fixed up the whitespace and made a minor change to add braces
>> >in what look like the correct places around the "if (reset_link)" block;
>> >the patch I tested with is below.  I'll also install this on another
>> >machine with hotplug capable slots to test there as well.
>> 
>> 	We've tested the below patch on a couple of different machines
>> and devices (network card, NVMe device) and it appears to solve the
>> recovery issue in our testing.
>> 
>> 	Is there anything further we need to do, or can this be
>> considered for inclusion upstream at this time?
>
>Can somebody please post a clean version of what we should merge?
>There was the initial patch plus a follow-up fix, so it's not clear
>where we ended up.
>
>Bjorn

	Below is the patch we tested, from Sathyanarayanan's test patch
(slightly edited to clarify ambiguous "if else" nesting), along with an
edited version of the commit log from my original patch.  I have not
seen a Signed-off-by from Sathyanarayanan, so I didn't include one here.

	One question I have is that, after the patch is applied, the
"status" filled in by pci_walk_bus(... report_frozen_detected ...) is
discarded regardless of its value.  Is that correct behavior in all
cases?  The original issue I was trying to solve was that the status set
by report_frozen_detected was thrown away starting with 6d2c89441571
("PCI/ERR: Update error status after reset_link()"), causing a
_NEED_RESET to be lost.  With the below patch, all cases of
pci_channel_io_frozen will call reset_link unconditionally.

	-J

Subject: [PATCH] PCI/ERR: Resolve regression in pcie_do_recovery

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
 
	Commit 6d2c89441571 ("PCI/ERR: Update error status after
reset_link()"), introduced a regression, as pcie_do_recovery will
discard the status result from report_frozen_detected.  This can cause a
failure to recover if _NEED_RESET is returned by report_frozen_detected
and report_slot_reset is not invoked.

	Such an event can be induced for testing purposes by reducing
the Max_Payload_Size of a PCIe bridge to less than that of a device
downstream from the bridge, and then initating I/O through the device,
resulting in oversize transactions.  In the presence of DPC, this
results in a containment event and attempted reset and recovery via
pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not invoked,
and the device does not recover.

Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")


diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 14bb8f54723e..db80e1ecb2dc 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -165,13 +165,24 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
+		status = PCI_ERS_RESULT_NEED_RESET;
+	} else {
+		pci_walk_bus(bus, report_normal_detected, &status);
+	}
+
+	if (status == PCI_ERS_RESULT_NEED_RESET) {
+		if (reset_link) {
+			if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED)
+				status = PCI_ERS_RESULT_DISCONNECT;
+		} else {
+			if (pci_bus_error_reset(dev))
+				status = PCI_ERS_RESULT_DISCONNECT;
+		}
+
+		if (status == PCI_ERS_RESULT_DISCONNECT) {
 			pci_warn(dev, "link reset failed\n");
 			goto failed;
 		}
-	} else {
-		pci_walk_bus(bus, report_normal_detected, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {


---
	-Jay Vosburgh, jay.vosburgh@canonical.com
