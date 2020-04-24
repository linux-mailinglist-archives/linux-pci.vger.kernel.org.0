Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA47D1B8261
	for <lists+linux-pci@lfdr.de>; Sat, 25 Apr 2020 01:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDXXPP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 19:15:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:23069 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgDXXPO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 19:15:14 -0400
IronPort-SDR: bb+PCIaZHdiIncOdSGkp9224r3aJdh/2VHi5IUtuhzDLbU9bNpBq5vnPYrp/QG5skmiGvItSd7
 o2hb/S68Ayag==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 16:15:14 -0700
IronPort-SDR: 11QSpfglenwFU03PVL2wJlkoUy/EMBTkDv0HPmJamjlrzcUFrgUCmvYZ1qDRsnPAOK2MhHfxs4
 s7DsvFfPMIzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,313,1583222400"; 
   d="scan'208";a="246751531"
Received: from cmowens-mobl1.amr.corp.intel.com (HELO [10.255.230.147]) ([10.255.230.147])
  by fmsmga007.fm.intel.com with ESMTP; 24 Apr 2020 16:15:14 -0700
Subject: Re: [PATCH v1 1/1] PCI/EDR: Change ACPI event message log level
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200424231002.GA218107@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b50c101e-e603-6602-3fbb-b7b118f61ef8@linux.intel.com>
Date:   Fri, 24 Apr 2020 16:15:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424231002.GA218107@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 4/24/20 4:10 PM, Bjorn Helgaas wrote:
> On Wed, Apr 15, 2020 at 05:38:32PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Currently we have pci_info() message in the beginning of
>> edr_handle_event() function, which will be printing
>> notification details every-time firmware sends ACPI SYSTEM
>> level events. This will pollute the dmesg logs for systems
>> that has lot for ACPI system level notifications. So change
>> the log-level to pci_dbg, and add a new info log for EDR
>> events.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/pcie/edr.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>> index 594622a6cb16..e346c82559fa 100644
>> --- a/drivers/pci/pcie/edr.c
>> +++ b/drivers/pci/pcie/edr.c
>> @@ -148,11 +148,13 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>   	pci_ers_result_t estate = PCI_ERS_RESULT_DISCONNECT;
>>   	u16 status;
>>   
>> -	pci_info(pdev, "ACPI event %#x received\n", event);
>> +	pci_dbg(pdev, "ACPI event %#x received\n", event);
> 
> I agree this looks excessively verbose.  Do we even need a pci_dbg()
> message here?  Maybe a message like that would belong in ACPI?
> There is already an ACPI_DEBUG_PRINT() in
> acpi_ev_queue_notify_request() that would serve a similar purpose.
I tried to keep it here to simplify enabling debug logs  related to
EDR. But as you have mentioned we could get similar message from
ACPI. If you think its excessive we can remove it. You want me to
send next version with this change ?
> 
>>   	if (event != ACPI_NOTIFY_DISCONNECT_RECOVER)
>>   		return;
>>   
>> +	pci_info(pdev, "EDR event received\n");
>> +
>>   	/* Locate the port which issued EDR event */
>>   	edev = acpi_dpc_port_get(pdev);
>>   	if (!edev) {
>> -- 
>> 2.17.1
>>
