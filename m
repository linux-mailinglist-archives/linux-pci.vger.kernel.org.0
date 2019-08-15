Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5A9E8F744
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 00:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbfHOWzA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 18:55:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:38943 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733225AbfHOWzA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 18:55:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 15:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="206055505"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 15 Aug 2019 15:54:59 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 70DB75806C4;
        Thu, 15 Aug 2019 15:54:59 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 1/9] PCI/ERR: Update error status after reset_link()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
References: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <6be594215ae2ea0935d949537bfb84ff9e656a36.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190815221629.GI253360@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <d2521962-c72b-49b0-3ed0-00d53adba4c2@linux.intel.com>
Date:   Thu, 15 Aug 2019 15:52:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815221629.GI253360@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 8/15/19 3:16 PM, Bjorn Helgaas wrote:
> On Fri, Jul 26, 2019 at 02:43:11PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery") uses
>> reset_link() to recover from fatal errors. But, if the reset is
>> successful there is no need to continue the rest of the error recovery
>> checks. Also, during fatal error recovery, if the initial value of error
>> status is PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER then
>> even after successful recovery (using reset_link()) pcie_do_recovery()
>> will report the recovery result as failure. So update the status of
>> error after reset_link().
>>
>> Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Keith Busch <keith.busch@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/pcie/err.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 773197a12568..aecec124a829 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -204,9 +204,13 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>>   	else
>>   		pci_walk_bus(bus, report_normal_detected, &status);
>>   
>> -	if (state == pci_channel_io_frozen &&
>> -	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
>> -		goto failed;
>> +	if (state == pci_channel_io_frozen) {
>> +		status = reset_link(dev, service);
>> +		if (status != PCI_ERS_RESULT_RECOVERED)
>> +			goto failed;
>> +		else
>> +			goto done;
> This will be easier to read without the negation, i.e.,
>
>                  if (status == PCI_ERS_RESULT_RECOVERED)
>                          goto done;
>                  else
>                          goto failed;
will change it in next version.

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

