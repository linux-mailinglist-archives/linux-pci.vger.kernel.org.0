Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65C51C0857
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 22:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3Uln convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 30 Apr 2020 16:41:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60299 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgD3Ulm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 16:41:42 -0400
Received: from 1.general.jvosburgh.us.vpn ([10.172.68.206] helo=famine.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <jay.vosburgh@canonical.com>)
        id 1jUG03-0005x7-DF; Thu, 30 Apr 2020 20:41:39 +0000
Received: by famine.localdomain (Postfix, from userid 1000)
        id B0CD8630E4; Thu, 30 Apr 2020 13:41:37 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id A612DAC1DB;
        Thu, 30 Apr 2020 13:41:37 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     "Kuppuswamy\, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ERR: Resolve regression in pcie_do_recovery
In-reply-to: <d72b2b0c-6842-3d76-5b13-2fbb3d25d73f@linux.intel.com>
References: <12115.1588207324@famine> <18897ceb-2263-1101-ae43-918a66794e14@linux.intel.com> <d72b2b0c-6842-3d76-5b13-2fbb3d25d73f@linux.intel.com>
Comments: In-reply-to "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
   message dated "Thu, 30 Apr 2020 12:35:37 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.6; GNU Emacs 27.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Date:   Thu, 30 Apr 2020 13:41:37 -0700
Message-ID: <14682.1588279297@famine>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"Kuppuswamy, Sathyanarayanan" wrote:

>Hi Jay,
>
>On 4/29/20 6:15 PM, Kuppuswamy, Sathyanarayanan wrote:
>>
>>
>> On 4/29/20 5:42 PM, Jay Vosburgh wrote:
>>>     Commit 6d2c89441571 ("PCI/ERR: Update error status after
>>> reset_link()"), introduced a regression, as pcie_do_recovery will
>>> discard the status result from report_frozen_detected.  This can cause a
>>> failure to recover if _NEED_RESET is returned by report_frozen_detected
>>> and report_slot_reset is not invoked.
>>>
>>>     Such an event can be induced for testing purposes by reducing
>>> the Max_Payload_Size of a PCIe bridge to less than that of a device
>>> downstream from the bridge, and then initating I/O through the device,
>>> resulting in oversize transactions.  In the presence of DPC, this
>>> results in a containment event and attempted reset and recovery via
>>> pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not invoked,
>>> and the device does not recover.
>>
>> I think this issue is related to the issue discussed in following
>> thread (DPC non-hotplug support).
>>
>> https://lkml.org/lkml/2020/3/28/328
>>
>> If my assumption is correct, you are dealing with devices which are
>> not hotplug capable. If the devices are hotplug capable then you don't
>> need to proceed to report_slot_reset(), since hotplug handler will
>> remove/re-enumerate the devices correctly.

	Correct, this particular device (a network card) is in a
non-hotplug slot.

>Can you check whether following fix works for you?

	Yes, it does.

	I fixed up the whitespace and made a minor change to add braces
in what look like the correct places around the "if (reset_link)" block;
the patch I tested with is below.  I'll also install this on another
machine with hotplug capable slots to test there as well.

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


	-J

>This includes support for bus_reset in recovery function itself.
>
>index 14bb8f54723e..c9eaab68ab7a 100644
>--- a/drivers/pci/pcie/err.c
>+++ b/drivers/pci/pcie/err.c
>@@ -165,13 +165,23 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>        pci_dbg(dev, "broadcast error_detected message\n");
>        if (state == pci_channel_io_frozen) {
>        if (state == pci_channel_io_frozen) {
>                pci_walk_bus(bus, report_frozen_detected, &status);
>-               status = reset_link(dev);
>-               if (status != PCI_ERS_RESULT_RECOVERED) {
>+               status = PCI_ERS_RESULT_NEED_RESET;
>+       } else {
>+               pci_walk_bus(bus, report_normal_detected, &status);
>+       }
>+
>+       if (status == PCI_ERS_RESULT_NEED_RESET) {
>+               if (reset_link)
>+                       if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED)
>+                               status = PCI_ERS_RESULT_DISCONNECT;
>+               else
>+                       if (pci_bus_error_reset(dev))
>+                               status = PCI_ERS_RESULT_DISCONNECT;
>+
>+               if (status == PCI_ERS_RESULT_DISCONNECT) {
>                        pci_warn(dev, "link reset failed\n");
>                        goto failed;
>                }
>-       } else {
>-               pci_walk_bus(bus, report_normal_detected, &status);
>        }
>
>        if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>
>
>>
>>>
>>>     Inspection shows a similar path is plausible for a return of
>>> _CAN_RECOVER and the invocation of report_mmio_enabled.
>>>
>>>     Resolve this by preserving the result of report_frozen_detected if
>>> reset_link does not return _DISCONNECT.
>>>
>>> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>>> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>>>
>>> ---
>>>   drivers/pci/pcie/err.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>> index 14bb8f54723e..e4274562f3a0 100644
>>> --- a/drivers/pci/pcie/err.c
>>> +++ b/drivers/pci/pcie/err.c
>>> @@ -164,10 +164,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev
>>> *dev,
>>>       pci_dbg(dev, "broadcast error_detected message\n");
>>>       if (state == pci_channel_io_frozen) {
>>> +        pci_ers_result_t status2;
>>> +
>>>           pci_walk_bus(bus, report_frozen_detected, &status);
>>> -        status = reset_link(dev);
>>> -        if (status != PCI_ERS_RESULT_RECOVERED) {
>>> +        /* preserve status from report_frozen_detected to
>>> +         * insure report_mmio_enabled or report_slot_reset are
>>> +         * invoked even if reset_link returns _RECOVERED.
>>> +         */
>>> +        status2 = reset_link(dev);
>>> +        if (status2 != PCI_ERS_RESULT_RECOVERED) {
>>>               pci_warn(dev, "link reset failed\n");
>>> +            status = status2;
>>>               goto failed;
>>>           }
>>>       } else {
>>>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
