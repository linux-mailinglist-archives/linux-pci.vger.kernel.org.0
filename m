Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2901C0693
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 21:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgD3Tfj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 15:35:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:35594 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgD3Tfi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 15:35:38 -0400
IronPort-SDR: p7L2+YjXDnEUv31dKqyg5XPYYu15DXRi0DkTS1mm6gCay/GmPqlIg6X+nzXG/G/TFtUKIxdr4c
 aGMr2+6fK6sw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 12:35:38 -0700
IronPort-SDR: hcn3O9GutZeM8fmQeR3busHSjqWFMb2j3W4kxzR9bDk20bg7zfCMtT7yBlAafeCUdqYHJjpd0b
 Ssaa9eNzwGUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="303368264"
Received: from stallamr-mobl1.amr.corp.intel.com (HELO [10.254.73.127]) ([10.254.73.127])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Apr 2020 12:35:37 -0700
Subject: Re: [PATCH] PCI/ERR: Resolve regression in pcie_do_recovery
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Jay Vosburgh <jay.vosburgh@canonical.com>,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
References: <12115.1588207324@famine>
 <18897ceb-2263-1101-ae43-918a66794e14@linux.intel.com>
Message-ID: <d72b2b0c-6842-3d76-5b13-2fbb3d25d73f@linux.intel.com>
Date:   Thu, 30 Apr 2020 12:35:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <18897ceb-2263-1101-ae43-918a66794e14@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jay,

On 4/29/20 6:15 PM, Kuppuswamy, Sathyanarayanan wrote:
> 
> 
> On 4/29/20 5:42 PM, Jay Vosburgh wrote:
>>     Commit 6d2c89441571 ("PCI/ERR: Update error status after
>> reset_link()"), introduced a regression, as pcie_do_recovery will
>> discard the status result from report_frozen_detected.  This can cause a
>> failure to recover if _NEED_RESET is returned by report_frozen_detected
>> and report_slot_reset is not invoked.
>>
>>     Such an event can be induced for testing purposes by reducing
>> the Max_Payload_Size of a PCIe bridge to less than that of a device
>> downstream from the bridge, and then initating I/O through the device,
>> resulting in oversize transactions.  In the presence of DPC, this
>> results in a containment event and attempted reset and recovery via
>> pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not invoked,
>> and the device does not recover.
> 
> I think this issue is related to the issue discussed in following
> thread (DPC non-hotplug support).
> 
> https://lkml.org/lkml/2020/3/28/328
> 
> If my assumption is correct, you are dealing with devices which are
> not hotplug capable. If the devices are hotplug capable then you don't
> need to proceed to report_slot_reset(), since hotplug handler will
> remove/re-enumerate the devices correctly.

Can you check whether following fix works for you?

This includes support for bus_reset in recovery function itself.

index 14bb8f54723e..c9eaab68ab7a 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -165,13 +165,23 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
         pci_dbg(dev, "broadcast error_detected message\n");
         if (state == pci_channel_io_frozen) {
         if (state == pci_channel_io_frozen) {
                 pci_walk_bus(bus, report_frozen_detected, &status);
-               status = reset_link(dev);
-               if (status != PCI_ERS_RESULT_RECOVERED) {
+               status = PCI_ERS_RESULT_NEED_RESET;
+       } else {
+               pci_walk_bus(bus, report_normal_detected, &status);
+       }
+
+       if (status == PCI_ERS_RESULT_NEED_RESET) {
+               if (reset_link)
+                       if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED)
+                               status = PCI_ERS_RESULT_DISCONNECT;
+               else
+                       if (pci_bus_error_reset(dev))
+                               status = PCI_ERS_RESULT_DISCONNECT;
+
+               if (status == PCI_ERS_RESULT_DISCONNECT) {
                         pci_warn(dev, "link reset failed\n");
                         goto failed;
                 }
-       } else {
-               pci_walk_bus(bus, report_normal_detected, &status);
         }

         if (status == PCI_ERS_RESULT_CAN_RECOVER) {


> 
>>
>>     Inspection shows a similar path is plausible for a return of
>> _CAN_RECOVER and the invocation of report_mmio_enabled.
>>
>>     Resolve this by preserving the result of report_frozen_detected if
>> reset_link does not return _DISCONNECT.
>>
>> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>>
>> ---
>>   drivers/pci/pcie/err.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 14bb8f54723e..e4274562f3a0 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -164,10 +164,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev 
>> *dev,
>>       pci_dbg(dev, "broadcast error_detected message\n");
>>       if (state == pci_channel_io_frozen) {
>> +        pci_ers_result_t status2;
>> +
>>           pci_walk_bus(bus, report_frozen_detected, &status);
>> -        status = reset_link(dev);
>> -        if (status != PCI_ERS_RESULT_RECOVERED) {
>> +        /* preserve status from report_frozen_detected to
>> +         * insure report_mmio_enabled or report_slot_reset are
>> +         * invoked even if reset_link returns _RECOVERED.
>> +         */
>> +        status2 = reset_link(dev);
>> +        if (status2 != PCI_ERS_RESULT_RECOVERED) {
>>               pci_warn(dev, "link reset failed\n");
>> +            status = status2;
>>               goto failed;
>>           }
>>       } else {
>>
