Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7AD20C81D
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jun 2020 14:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgF1M7F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jun 2020 08:59:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59820 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbgF1M7F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Jun 2020 08:59:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 71F73490504BFFE6F6BC;
        Sun, 28 Jun 2020 20:59:03 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sun, 28 Jun 2020
 20:58:59 +0800
Subject: Re: [PATCH v2 1/2] PCI/ERR: Fix fatal error recovery for non-hotplug
 capable devices
To:     Jay Vosburgh <jay.vosburgh@canonical.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <ce417fbf81a8a46a89535f44b9224ee9fbb55a29.1591307288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <25283.1591332444@famine> <3400.1593024778@famine>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ashok.raj@intel.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <25d4ec0f-71a3-a3d8-a4e8-b44ea4326e82@hisilicon.com>
Date:   Sun, 28 Jun 2020 20:59:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <3400.1593024778@famine>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jay,

I've tested the patches on my board, and they work well.

Thanks,
Yicong


On 2020/6/25 2:52, Jay Vosburgh wrote:
> Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>
>> sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> Fatal (DPC) error recovery is currently broken for non-hotplug
>>> capable devices. With current implementation, after successful
>>> fatal error recovery, non-hotplug capable device state won't be
>>> restored properly. You can find related issues in following links.
>>>
>>> https://lkml.org/lkml/2020/5/27/290
>>> https://lore.kernel.org/linux-pci/12115.1588207324@famine/
>>> https://lkml.org/lkml/2020/3/28/328
>>>
>>> Current fatal error recovery implementation relies on hotplug handler
>>> for detaching/re-enumerating the affected devices/drivers on DLLSC
>>> state changes. So when dealing with non-hotplug capable devices,
>>> recovery code does not restore the state of the affected devices
>>> correctly. Correct implementation should call report_slot_reset()
>>> function after resetting the link to restore the state of the
>>> device/driver.
>>>
>>> So use PCI_ERS_RESULT_NEED_RESET as error status for successful
>>> reset_link() operation and use PCI_ERS_RESULT_DISCONNECT for failure
>>> case. PCI_ERS_RESULT_NEED_RESET error state will ensure slot_reset()
>>> is called after reset link operation which will also fix the above
>>> mentioned issue.
>>>
>>> [original patch is from jay.vosburgh@canonical.com]
>>> [original patch link https://lore.kernel.org/linux-pci/12115.1588207324@famine/]
>>> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>>> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> 	I've tested this patch set on one of our test machines, and it
>> resolves the issue.  I plan to test with other systems tomorrow.
> 	I've done testing on two different systems that exhibit the
> original issue and this patch set appears to behave as expected.
>
> 	Has anyone else (Yicong?) had an opportunity to test this?
>
> 	Can this be considered for acceptance, or is additional feedback
> or review needed?
>
> 	-J
>
>>> ---
>>> drivers/pci/pcie/err.c | 24 ++++++++++++++++++++++--
>>> 1 file changed, 22 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>> index 14bb8f54723e..5fe8561c7185 100644
>>> --- a/drivers/pci/pcie/err.c
>>> +++ b/drivers/pci/pcie/err.c
>>> @@ -165,8 +165,28 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>> 	pci_dbg(dev, "broadcast error_detected message\n");
>>> 	if (state == pci_channel_io_frozen) {
>>> 		pci_walk_bus(bus, report_frozen_detected, &status);
>>> -		status = reset_link(dev);
>>> -		if (status != PCI_ERS_RESULT_RECOVERED) {
>>> +		/*
>>> +		 * After resetting the link using reset_link() call, the
>>> +		 * possible value of error status is either
>>> +		 * PCI_ERS_RESULT_DISCONNECT (failure case) or
>>> +		 * PCI_ERS_RESULT_NEED_RESET (success case).
>>> +		 * So ignore the return value of report_error_detected()
>>> +		 * call for fatal errors. Instead use
>>> +		 * PCI_ERS_RESULT_NEED_RESET as initial status value.
>>> +		 *
>>> +		 * Ignoring the status return value of report_error_detected()
>>> +		 * call will also help in case of EDR mode based error
>>> +		 * recovery. In EDR mode AER and DPC Capabilities are owned by
>>> +		 * firmware and hence report_error_detected() call will possibly
>>> +		 * return PCI_ERS_RESULT_NO_AER_DRIVER. So if we don't ignore
>>> +		 * the return value of report_error_detected() then
>>> +		 * pcie_do_recovery() would report incorrect status after
>>> +		 * successful recovery. Ignoring PCI_ERS_RESULT_NO_AER_DRIVER
>>> +		 * in non EDR case should not have any functional impact.
>>> +		 */
>>> +		status = PCI_ERS_RESULT_NEED_RESET;
>>> +		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
>>> +			status = PCI_ERS_RESULT_DISCONNECT;
>>> 			pci_warn(dev, "link reset failed\n");
>>> 			goto failed;
>>> 		}
>>> -- 
>>> 2.17.1
> ---
> 	-Jay Vosburgh, jay.vosburgh@canonical.com
> .
>

