Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C906DA4E5
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 23:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjDFVwF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 17:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDFVwE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 17:52:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ED583CE;
        Thu,  6 Apr 2023 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680817923; x=1712353923;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tNPAAynz+vXrL7H1irgAX5brh1tfSQb5T0MTPHKNobs=;
  b=WcW20sbG+WaLSSkO1C9ow24J3eYLBlryrjE6wbEUqamXOZ54lfG37sds
   LxHtIM0WXcJOYnC60w0cutFyLxKUptv7Ki+S0qGQy4tUbfwVPFHaiXL5j
   GLHQa+7qDpLgxb2B2gSD50NmHx/fHUBfW8j1jEb+uF4aJ3vyD4z62QY3j
   Gs9k71gTiv4QlSIiPX1WSKeALUJOTNI5WUo8XVrMZ3nGmSqfk5hJhX8Xy
   PA6Oml8leq27CiHqld/3UxAQpgc0QI4CpGg3tDHJegoCeKAVA+tGjgYol
   MS69U1UiJ7Ygbr9Uqg/XBpwOP00OY++OnP0Q5r0bcFzVsMczyWYvdvKjO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407975401"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407975401"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 14:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="751793312"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="751793312"
Received: from iban-mobl1.amr.corp.intel.com (HELO [10.212.231.125]) ([10.212.231.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 14:52:02 -0700
Message-ID: <a4803e7e-bbfe-8925-88e9-935775960e63@linux.intel.com>
Date:   Thu, 6 Apr 2023 14:52:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2] PCI/EDR: Clear PCIe Device Status errors after EDR
 error recovery
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Natu, Mahesh" <mahesh.natu@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230406210722.GA3735581@bhelgaas>
Content-Language: en-US
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230406210722.GA3735581@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Mahesh

On 4/6/23 2:07 PM, Bjorn Helgaas wrote:
> On Wed, Mar 15, 2023 at 04:54:49PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Commit 068c29a248b6 ("PCI/ERR: Clear PCIe Device Status errors only if
>> OS owns AER") adds support to clear error status in the Device Status
>> Register(DEVSTA) only if OS owns the AER support. But this change
>> breaks the requirement of the EDR feature which requires OS to cleanup
>> the error registers even if firmware owns the control of AER support.
>>
>> More details about this requirement can be found in PCIe Firmware
>> specification v3.3, Table 4-6 Interpretation of the _OSC Control Field.
>> If the OS supports the Error Disconnect Recover (EDR) feature and
>> firmware sends the EDR event, then during the EDR recovery window, OS
>> is responsible for the device error recovery and holds the ownership of
>> the following error registers.
>>
>> • Device Status Register
>> • Uncorrectable Error Status Register
>> • Correctable Error Status Register
>> • Root Error Status Register
>> • RP PIO Status Register
>>
>> So call pcie_clear_device_status() in edr_handle_event() if the error
>> recovery is successful.
>>
>> Reported-by: Tsaur Erwin <erwin.tsaur@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>
>> Changes since v1:
>>  * Rebased on top of v6.3-rc1.
>>  * Fixed a typo in pcie_clear_device_status().
>>
>>  drivers/pci/pcie/edr.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>> index a6b9b479b97a..87734e4c3c20 100644
>> --- a/drivers/pci/pcie/edr.c
>> +++ b/drivers/pci/pcie/edr.c
>> @@ -193,6 +193,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>  	 */
>>  	if (estate == PCI_ERS_RESULT_RECOVERED) {
>>  		pci_dbg(edev, "DPC port successfully recovered\n");
>> +		pcie_clear_device_status(edev);
>>  		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
> 
> The implementation note in PCI Firmware r3.3, sec 4.6.12, shows the OS
> clearing error status *after* _OST is evaluated.
> 
> On the other hand, the _OSC DPC control bit in table 4-6 says that if
> the OS does not have DPC control, it can only write the Device Status
> error bits between the EDR Notify and invoking _OST.
> 
> Is one of those wrong, or am I missing something?

Agree. It is conflicting info. IMO, the argument that the OS is allowed to
clear the error registers during the EDR windows makes more sense. If OS
is allowed to touch error registers owned by firmware after that window,
it would lead to race conditions.

Mahesh, let us know your comments. Maybe we need to fix this in the firmware
specification.

> 
> Bjorn

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
