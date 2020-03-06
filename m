Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C63F917C2A1
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 17:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCFQLn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 11:11:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:11194 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgCFQLn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 11:11:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 08:11:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="259595493"
Received: from skuppusw-mobl5.amr.corp.intel.com (HELO [10.251.4.58]) ([10.251.4.58])
  by orsmga002.jf.intel.com with ESMTP; 06 Mar 2020 08:11:42 -0800
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200306160401.GA165033@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ee591afe-f022-9152-9c6f-34fe9987077e@linux.intel.com>
Date:   Fri, 6 Mar 2020 08:11:41 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306160401.GA165033@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/6/2020 8:04 AM, Bjorn Helgaas wrote:
> On Thu, Mar 05, 2020 at 09:45:46PM -0800, Kuppuswamy, Sathyanarayanan wrote:
>> On 3/3/2020 6:36 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>
>>> As per PCI firmware specification r3.2 System Firmware Intermediary
>>> (SFI) _OSC and DPC Updates ECR
>>> (https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled "DPC
>>> Event Handling Implementation Note", page 10, Error Disconnect Recover
>>> (EDR) support allows OS to handle error recovery and clearing Error
>>> Registers even in FF mode. So create new API pci_aer_raw_clear_status()
>>> which allows clearing AER registers without FF mode checks.
>>>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> ---
>>>    drivers/pci/pci.h      |  2 ++
>>>    drivers/pci/pcie/aer.c | 22 ++++++++++++++++++----
>>>    2 files changed, 20 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index e57e78b619f8..c239e6dd2542 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -655,6 +655,7 @@ extern const struct attribute_group aer_stats_attr_group;
>>>    void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>>    void pci_aer_clear_device_status(struct pci_dev *dev);
>>>    int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
>>> +int pci_aer_raw_clear_status(struct pci_dev *dev);
>>>    #else
>>>    static inline void pci_no_aer(void) { }
>>>    static inline void pci_aer_init(struct pci_dev *d) { }
>>> @@ -665,6 +666,7 @@ static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>>>    {
>>>    	return -EINVAL;
>>>    }
>>> +int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
> 
>> It's missing static specifier. It needs to be fixed. I can fix it in
>> next version.  Bjorn, if there is no need for next version, can you
>> please make this change?
> 
> pci_aer_raw_clear_status() is defined in aer.c and called from aer.c
> and edr.c, so I do not think it can be static.  Am I missing
> something?
> 
> I have a review/edr branch that I hope becomes what will be applied.
For kernel configs that does not define CONFIG_PCIEAER, it will create 
redefinition error since pci.h can be included in many files.
> 
> Bjorn
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
