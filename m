Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CAD1E74C9
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 06:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgE2EYq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 00:24:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:43978 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgE2EYp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 May 2020 00:24:45 -0400
IronPort-SDR: F8qeEhoXjpH4k2kyQZODUArGHRpbfXVRaVAkBpz9QuVi53UPVhv8QLK41JZgGw5fdrRgUlfMx0
 Ci6L2v0XOFJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 21:24:44 -0700
IronPort-SDR: 1QTdHdi5N1qU8ggSX3uaP4x7ipfP+ZSLJ2AJJ1wvKv4oX3lU/KLFPFM5kkOOj3E34yAcd1T/a1
 kIiw2TjdN0AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="311132938"
Received: from vvhadaga-mobl.amr.corp.intel.com (HELO [10.254.98.146]) ([10.254.98.146])
  by FMSMGA003.fm.intel.com with ESMTP; 28 May 2020 21:24:44 -0700
Subject: Re: [PATCH] PCI: ERR: Don't override the status returned by
 error_detect()
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "sbobroff@linux.ibm.com" <sbobroff@linux.ibm.com>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
References: <20200527083130.4137-1-Zhiqiang.Hou@nxp.com>
 <84a2bc7e-7556-96ff-6cd5-988d432ad8e3@linux.intel.com>
 <AM6PR0402MB3367BCFF5A55D4096CD652FF848F0@AM6PR0402MB3367.eurprd04.prod.outlook.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <29e53d60-0782-7afb-ba8a-b4affb54644f@linux.intel.com>
Date:   Thu, 28 May 2020 21:24:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <AM6PR0402MB3367BCFF5A55D4096CD652FF848F0@AM6PR0402MB3367.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/28/20 9:04 PM, Z.q. Hou wrote:
> Hi Kuppuswamy,
> 
>> -----Original Message-----
>> From: Kuppuswamy, Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Sent: 2020年5月29日 5:19
>> To: Z.q. Hou <zhiqiang.hou@nxp.com>; linux-pci@vger.kernel.org;
>> linux-kernel@vger.kernel.org; ruscur@russell.cc; sbobroff@linux.ibm.com;
>> oohall@gmail.com; bhelgaas@google.com
>> Subject: Re: [PATCH] PCI: ERR: Don't override the status returned by
>> error_detect()
>>
>> Hi,
>>
>> On 5/27/20 1:31 AM, Zhiqiang Hou wrote:
>>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>>
>>> The commit 6d2c89441571 ("PCI/ERR: Update error status after
>>> reset_link()") overrode the 'status' returned by the error_detect()
>>> call back function, which is depended on by the next step. This
>>> overriding makes the Endpoint driver's required info (kept in the var
>>> status) lost, so it results in the fatal errors' recovery failed and then kernel
>> panic.
>> Can you explain why updating status affects the recovery ?
> 
> Take the e1000e as an example:
> Once a fatal error is reported by e1000e, the e1000e's error_detect() will be
> called and it will return PCI_ERS_RESULT_NEED_RESET to request a slot reset,
> the return value is stored in the '&status' of the calling
> pci_walk_bus(bus,report_frozen_detected, &status).
> If you update the 'status' with the reset_link()'s return value
> (PCI_ERS_RESULT_RECOVERED if the reset link succeed), then the 'status' has
> the value PCI_ERS_RESULT_RECOVERED and e1000e's request
> PCI_ERS_RESULT_NEED_RESET lost, then e1000e's callback function .slot_reset()
> will be skipped and directly call the .resume().
I believe you are working with non hotplug capable device. If yes, then
this issue will be addressed by the following patch.
https://lkml.org/lkml/2020/5/6/1545
> 
> So this is how the update of 'status' break the handshake between RC's AER driver
> and the Endpoint's protocol driver error_handlers, then result in the recovery failure.
> 
>>>
>>> In the e1000e case, the error logs:
>>> pcieport 0002:00:00.0: AER: Uncorrected (Fatal) error received:
>>> 0002:01:00.0 e1000e 0002:01:00.0: AER: PCIe Bus Error:
>>> severity=Uncorrected (Fatal), type=Inaccessible, (Unregistered Agent
>>> ID) pcieport 0002:00:00.0: AER: Root Port link has been reset
>> As per above commit log, it looks like link is reset correctly.
> 
> Yes, see my comments above.
> 
> Thanks,
> Zhiqiang
> 
>>> SError Interrupt on CPU0, code 0xbf000002 -- SError
>>> CPU: 0 PID: 111 Comm: irq/76-aerdrv Not tainted
>>> 5.7.0-rc7-next-20200526 #8 Hardware name: LS1046A RDB Board (DT)
>>> pstate: 80000005 (Nzcv daif -PAN -UAO BTYPE=--) pc :
>>> __pci_enable_msix_range+0x4c8/0x5b8
>>> lr : __pci_enable_msix_range+0x480/0x5b8
>>> sp : ffff80001116bb30
>>> x29: ffff80001116bb30 x28: 0000000000000003
>>> x27: 0000000000000003 x26: 0000000000000000
>>> x25: ffff00097243e0a8 x24: 0000000000000001
>>> x23: ffff00097243e2d8 x22: 0000000000000000
>>> x21: 0000000000000003 x20: ffff00095bd46080
>>> x19: ffff00097243e000 x18: ffffffffffffffff
>>> x17: 0000000000000000 x16: 0000000000000000
>>> x15: ffffb958fa0e9948 x14: ffff00095bd46303
>>> x13: ffff00095bd46302 x12: 0000000000000038
>>> x11: 0000000000000040 x10: ffffb958fa101e68
>>> x9 : ffffb958fa101e60 x8 : 0000000000000908
>>> x7 : 0000000000000908 x6 : ffff800011600000
>>> x5 : ffff00095bd46800 x4 : ffff00096e7f6080
>>> x3 : 0000000000000000 x2 : 0000000000000000
>>> x1 : 0000000000000000 x0 : 0000000000000000 Kernel panic - not
>>> syncing: Asynchronous SError Interrupt
>>> CPU: 0 PID: 111 Comm: irq/76-aerdrv Not tainted
>>> 5.7.0-rc7-next-20200526 #8
>>>
>>> I think it's the expected result that "if the initial value of error
>>> status is PCI_ERS_RESULT_DISCONNECT or
>> PCI_ERS_RESULT_NO_AER_DRIVER
>>> then even after successful recovery (using reset_link())
>>> pcie_do_recovery() will report the recovery result as failure" which
>>> is described in commit 6d2c89441571 ("PCI/ERR: Update error status after
>> reset_link()").
>>>
>>> Refer to the Documentation/PCI/pci-error-recovery.rst.
>>> As the error_detect() is mandatory callback if the pci_err_handlers is
>>> implemented, if it return the PCI_ERS_RESULT_DISCONNECT, it means the
>>> driver doesn't want to recover at all; For the case
>>> PCI_ERS_RESULT_NO_AER_DRIVER, if the pci_err_handlers is not
>>> implemented, the failure is more expected.
>>>
>>> Fixes: commit 6d2c89441571 ("PCI/ERR: Update error status after
>>> reset_link()")
>>> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>> ---
>>>    drivers/pci/pcie/err.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c index
>>> 14bb8f54723e..84f72342259c 100644
>>> --- a/drivers/pci/pcie/err.c
>>> +++ b/drivers/pci/pcie/err.c
>>> @@ -165,8 +165,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev
>> *dev,
>>>    	pci_dbg(dev, "broadcast error_detected message\n");
>>>    	if (state == pci_channel_io_frozen) {
>>>    		pci_walk_bus(bus, report_frozen_detected, &status);
>>> -		status = reset_link(dev);
>>> -		if (status != PCI_ERS_RESULT_RECOVERED) {
>>> +		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
>>>    			pci_warn(dev, "link reset failed\n");
>>>    			goto failed;
>>>    		}
>>>
>>
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
