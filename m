Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E27C28DAFD
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 10:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgJNITE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 04:19:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:36911 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgJNITE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Oct 2020 04:19:04 -0400
IronPort-SDR: zij75H5Hcsu+PGhkh0SGS1tyqlsbH3i/WcuFnNyilCvIGzzVQQDbZMLpaQRaR0SDKQfcnZ7Djw
 2N7eJrGNwssg==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="145925813"
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="145925813"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 01:19:06 -0700
IronPort-SDR: cyKIQx2D9lZI8x6u64eUwhGge3dI/5O3uX7x5y7Hl9bqqhzFdeNW2EBFaZed2D6/wjof+7f5SY
 7gO7D0W18Mww==
X-IronPort-AV: E=Sophos;i="5.77,374,1596524400"; 
   d="scan'208";a="520297334"
Received: from chamaraj-mobl.amr.corp.intel.com (HELO [10.252.132.113]) ([10.252.132.113])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 01:19:06 -0700
Subject: Re: [PATCH v4 1/2] PCI/ERR: Call pci_bus_reset() before calling
 ->slot_reset() callback
To:     Ethan Zhao <xerces.zhao@gmail.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
        sathyanarayanan.nkuppuswamy@gmail.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20201012210522.GA86612@otc-nc-03>
 <9b7db59d-832c-1c21-90b6-1676ea9058ce@linux.intel.com>
 <CAKF3qh0tykZV9-wrxqg-n1r-m+J1YL2L-s2j+wSPVRPw9k2sPA@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b97c0b1b-0465-66ca-f250-d5f8aa53e114@linux.intel.com>
Date:   Wed, 14 Oct 2020 01:19:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKF3qh0tykZV9-wrxqg-n1r-m+J1YL2L-s2j+wSPVRPw9k2sPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/14/20 1:00 AM, Ethan Zhao wrote:
> Please fix the building issue.
> 
> drivers/pci/pcie/err.c:144:25: error: static declaration of
> ‘pcie_do_fatal_recovery’ follows non-static declaration
>   static pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
>                           ^~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/pci/pcie/err.c:21:
> drivers/pci/pcie/../pci.h:560:18: note: previous declaration of
> ‘pcie_do_fatal_recovery’ was here
>   pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
>                    ^~~~~~~~~~~~~~~~~~~~~~
> drivers/pci/pcie/err.c:144:25: warning: ‘pcie_do_fatal_recovery’
> defined but not used [-Wunused-function]
>   static pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
Fixed in v6. Please use that version.
> 
> 
> Thanks,
> Ethan
> 
> On Tue, Oct 13, 2020 at 10:18 PM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>>
>>
>> On 10/12/20 2:05 PM, Raj, Ashok wrote:
>>> On Sun, Oct 11, 2020 at 10:03:40PM -0700, sathyanarayanan.nkuppuswamy@gmail.com wrote:
>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>
>>>> Currently if report_error_detected() or report_mmio_enabled()
>>>> functions requests PCI_ERS_RESULT_NEED_RESET, current
>>>> pcie_do_recovery() implementation does not do the requested
>>>> explicit device reset, but instead just calls the
>>>> report_slot_reset() on all affected devices. Notifying about the
>>>> reset via report_slot_reset() without doing the actual device
>>>> reset is incorrect. So call pci_bus_reset() before triggering
>>>> ->slot_reset() callback.
>>>>
>>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> ---
>>>>    drivers/pci/pcie/err.c | 6 +-----
>>>>    1 file changed, 1 insertion(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>> index c543f419d8f9..067c58728b88 100644
>>>> --- a/drivers/pci/pcie/err.c
>>>> +++ b/drivers/pci/pcie/err.c
>>>> @@ -181,11 +181,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>>       }
>>>>
>>>>       if (status == PCI_ERS_RESULT_NEED_RESET) {
>>>> -            /*
>>>> -             * TODO: Should call platform-specific
>>>> -             * functions to reset slot before calling
>>>> -             * drivers' slot_reset callbacks?
>>>> -             */
>>>> +            pci_reset_bus(dev);
>>>
>>> pci_reset_bus() returns an error, do you need to consult that before
>>> unconditionally setting PCI_ERS_RESULT_RECOVERED?
>> Good point. I will fix this in next version.
>>>
>>>>               status = PCI_ERS_RESULT_RECOVERED;
>>>>               pci_dbg(dev, "broadcast slot_reset message\n");
>>>>               pci_walk_bus(bus, report_slot_reset, &status);
>>>> --
>>>> 2.17.1
>>>>
>>
>> --
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
