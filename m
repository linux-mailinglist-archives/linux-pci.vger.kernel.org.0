Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6A86DFB85
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjDLQkj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjDLQkj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 12:40:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6A3268B;
        Wed, 12 Apr 2023 09:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681317631; x=1712853631;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sTLon38OPXbfysSiDd/g82BG8HiU/yv8Ts1Zz5UbszU=;
  b=aVck5hfAS7CW6zV+rb/ZBRFRSGh279y1k/Wrp5g/gLqNQLSynQFPuTqc
   cvOA/UwhfWNv2ETvIGEbKfKlUmRJ5JaJuDUzE6KwSXqA7a3zLgrTsXW48
   kVx5K4Y/XeAKeHb5lAQL3DsOQo40o+CMbjdG2fQaffrJ+mxPoRddTGL1M
   Xky7aZc1araxPItRZHaAxdKK2HdR7mHJC4j5saafE212RgmIQC42QkOeg
   2PRxrixYJv9tqrT2ioj6woAXl4fpDa1ULV+DQQbH2YfkLM1cMb0pWlk8Q
   6a4hrDUDR0tGr4WADOfOUMIdw1qMzTVkOL0tlhu4S3B2IMnXq8WSNo/hD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="324314753"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="324314753"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 09:40:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="863371940"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="863371940"
Received: from wanglish-mobl2.amr.corp.intel.com (HELO [10.212.223.138]) ([10.212.223.138])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 09:40:27 -0700
Message-ID: <292498f7-15ab-7cab-dc3a-ca5a13001e86@linux.intel.com>
Date:   Wed, 12 Apr 2023 09:40:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2 0/5] Parse the PCIe AER and set to relevant registers
Content-Language: en-US
To:     LeoLiuoc <LeoLiu-oc@zhaoxin.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
        ying.huang@intel.com, rdunlap@infradead.org, bhelgaas@google.com,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@acpica.org,
        CobeChen@zhaoxin.com, TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com,
        "Li, Ming" <ming4.li@intel.com>
References: <20230407231821.GA3831711@bhelgaas>
 <433ad19a-8286-ff58-9fd8-d7dd13547032@zhaoxin.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <433ad19a-8286-ff58-9fd8-d7dd13547032@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/12/23 2:11 AM, LeoLiuoc wrote:
> 
> 
> 在 2023/4/8 7:18, Bjorn Helgaas 写道:
>> [+cc Sathy, Ming, since they commented on the previous version]
>>
>> On Tue, Nov 15, 2022 at 11:11:15AM +0800, LeoLiu-oc wrote:
>>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>>
>>> According to the sec 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI r6.5, the
>>> register values form HEST PCI Express AER Structure should be written to
>>> relevant PCIe Device's AER Capabilities. So the purpose of the patch set
>>> is to extract register values from HEST PCI Express AER structures and
>>> program them into AER Capabilities. Refer to the ACPI Spec r6.5 for a more
>>> detailed description.
>>
>> I wasn't involved in this part of the ACPI spec, and I don't
>> understand how this is intended to work.
>>
>> I see that this series extracts AER mask, severity, and control
>> information from the ACPI HEST table and uses it to configure PCIe
>> devices as they are enumerated.
>>
>> What I don't understand is how this relates to ownership of the AER
>> capability as negotiated by the _OSC method.  Firmware can configure
>> the AER capability itself, and if it retains control of the AER
>> capability, the OS can't write to it (with the exception of clearing
>> EDR error status), so this wouldn't be necessary.
> 
> There is no relationship between the ownership of the AER related register and the ownership of the AER capability in the OS or Firmware. The processing here is to initialize the AER related register, not the AER event. If Firmware is configured 

No, the above statement is not correct. Let's assume that if the AER
feature is owned by firmware and OS arbitrarily configures the AER
registers, does it seem right? If firmware or OS owns a feature, after
_OSC negotiation, it assumed that other component will not touch the
relevant registers. There could be exceptions (like EDR), but it needs
to be documented in the spec.

with AER register, it will not be able to handle the runtime hot reset and link retrain cases in addition to the hotplug case you mentioned below.

IIUC, here we are trying to use HEST table to configure AER registers.
Does HEST table override the _OSC based ownership? Can we assume if
HEST table exist, then irrespective who owns the feature (firmware or
OS), OS is allowed to configure the AER registers? Is there a spec
statement confirming the above assumption?

> 
>>
>> If the OS owns the AER capability, I assume it gets to decide for
>> itself how to configure AER, no matter what the ACPI HEST says.
>>
> 
> What information does the OS use to decide how to configure AER? The ACPI Spec has the following description: PCI Express (PCIe) root ports may implement PCIe Advanced Error Reporting (AER) support. This table(HEST) contains  information platform firmware supplies to OSPM for configuring AER support on a given root port. We understand that HEST stands for user to express expectations.
> 
> In the current implementation, the OS already configures a PCIE device based on _HPP/_HPX method when configuring a PCI device inserted into a hot-plug slot or initial configuration of a PCI device at system boot. HEST is just another way to express the desired configuration of the user.
> 
> Yours sincerely,
> Leoliu-oc
> 
>> Maybe this is intended for the case where firmware retains AER
>> ownership but the OS uses native hotplug (pciehp), and this is a way
>> for the OS to configure new devices as the firmware expects?  But in
>> that case, we still have the problem that the OS can't write to the
>> AER capability to do this configuration.
>>
>> Bjorn
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
