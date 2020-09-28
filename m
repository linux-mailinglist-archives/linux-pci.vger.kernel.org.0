Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A074E27A57E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 04:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgI1Cnu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 22:43:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:38323 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgI1Cnu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 22:43:50 -0400
IronPort-SDR: dxjrFLS65dVYK0Q6Aq8tIsp6iLa/xEls/trp5znuKcQyqHgqAnaebwOT75YPn9DFLg/7z0j2WN
 h7zuEXKzC/Gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="223523004"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="223523004"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 19:43:49 -0700
IronPort-SDR: Cc7YDlVkjOiEgbw62VQp9xD+4Kr3Yb68DpZ5YsJ30Us447fJRmv197/aRCtmQ/7reR+O8jw+/l
 W5mbUDnZHRSQ==
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="338003421"
Received: from thuang10-mobl.amr.corp.intel.com (HELO [10.251.1.32]) ([10.251.1.32])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 19:43:48 -0700
Subject: Re: [PATCH v3 1/1] PCI/ERR: Fix reset logic in pcie_do_recovery()
 call
To:     Sinan Kaya <okaya@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
References: <20200922233333.GA2239404@bjorn-Precision-5520>
 <704c39bf-6f0c-bba3-70b8-91de6a445e43@linux.intel.com>
 <3d27d0a4-2115-fa72-8990-a84910e4215f@kernel.org>
 <d5aa53dc-0c94-e57a-689a-1c1f89787af1@linux.intel.com>
 <526dc846-b12b-3523-4995-966eb972ceb7@kernel.org>
 <1fdcc4a6-53b7-2b5f-8496-f0f09405f561@linux.intel.com>
 <aef0b9aa-59f5-9ec3-adac-5bc366b362e0@kernel.org>
 <a647f485-8db4-db45-f404-940b55117b53@linux.intel.com>
 <aefd8842-90c4-836a-b43a-f21c5428d2ba@kernel.org>
 <95e23cb5-f6e1-b121-0de8-a2066d507d9c@linux.intel.com>
 <65238d0b-0a39-400a-3a18-4f68eb554538@kernel.org>
 <4ae86061-2182-bcf1-ebd7-485acf2d47b9@linux.intel.com>
 <f360165e-5f73-057c-efd1-557b5e5027eb@kernel.org>
 <8beca800-ffb5-c535-6d43-7e750cbf06d0@linux.intel.com>
 <44f0cac5-8deb-1169-eb6d-93ac4889fe7e@kernel.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <3bc0fd23-8ddd-32c5-1dd9-4d5209ea68c3@linux.intel.com>
Date:   Sun, 27 Sep 2020 19:43:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <44f0cac5-8deb-1169-eb6d-93ac4889fe7e@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 9/25/20 11:30 AM, Sinan Kaya wrote:
> On 9/25/2020 2:16 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>
>>> If this is a too involved change, DPC driver should restore state
>>> when hotplug is not supported.
>> Yes. we can add a condition for hotplug capability check.
>>>
>>> DPC driver should be self-sufficient by itself.
>>>
> 
> Sounds good.
> 
>>>> Also for non-fatal errors, if reset is requested then we still need
>>>> some kind of bus reset call here
>>>
>>> DPC should handle both fatal and non-fatal cases
>> Currently DPC is only triggered for FATAL errors.
>>   and cause a bus reset
> 
> Thanks for the heads up.
> This seems to have changed since I looked at the DPC code.
> 
>>> in hardware already before triggering an interrupt.
>> Error recovery is not triggered only DPC driver. AER also uses the
>> same error recovery code. If DPC is not supported, then we still need
>> reset logic.
> 
> It sounds like we are cross-talking two issues.
> 
> 1. no state restore on DPC after FATAL error.
> Let's fix this.
Agree. Few more detail about the above issue is,

There are two cases under FATAL error.

FATAL + hotplug - In this case, link will be reseted. And hotplug handler
will remove the driver state. This case works well with current code.

FATAL + no-hotplug - In this case, link will still be reseted. But
currently driver state is not properly restored. So I attempted
to restore it using pci_reset_bus().

  		status = reset_link(dev);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
+		if (status == PCI_ERS_RESULT_RECOVERED) {
+			status = PCI_ERS_RESULT_NEED_RESET;

...

  	if (status == PCI_ERS_RESULT_NEED_RESET) {
  		/*
-		 * TODO: Should call platform-specific
-		 * functions to reset slot before calling
-		 * drivers' slot_reset callbacks?
+		 * TODO: Optimize the call to pci_reset_bus()
+		 *
+		 * There are two components to pci_reset_bus().
+		 *
+		 * 1. Do platform specific slot/bus reset.
+		 * 2. Save/Restore all devices in the bus.
+		 *
+		 * For hotplug capable devices and fatal errors,
+		 * device is already in reset state due to link
+		 * reset. So repeating platform specific slot/bus
+		 * reset via pci_reset_bus() call is redundant. So
+		 * can optimize this logic and conditionally call
+		 * pci_reset_bus().
  		 */
+		pci_reset_bus(dev);

> 
> 2. no bus reset on NON_FATAL error through AER driver path.
> This already tells me that you need to split your change into
> multiple patches.
> 
> Let's talk about this too. bus reset should be triggered via
> AER driver before informing the recovery.
But as per error recovery documentation, any call to
->error_detected() or ->mmio_enabled() can request
PCI_ERS_RESULT_NEED_RESET. So we need to add code
to do the actual reset before calling ->slot_reset()
callback. So call to pci_reset_bus() fixes this
issue.

  	if (status == PCI_ERS_RESULT_NEED_RESET) {
+		pci_reset_bus(dev);


> 
> 	if (status == PCI_ERS_RESULT_NEED_RESET) {
> 		/*
> 		 * TODO: Should call platform-specific
> 		 * functions to reset slot before calling
> 		 * drivers' slot_reset callbacks?
> 		 */
> 		status = PCI_ERS_RESULT_RECOVERED;
> 		pci_dbg(dev, "broadcast slot_reset message\n");
> 		pci_walk_bus(bus, report_slot_reset, &status);
> 	}
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
