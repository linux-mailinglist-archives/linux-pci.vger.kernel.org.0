Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6279E6E5BCB
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 10:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjDRIOW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 04:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjDRIOO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 04:14:14 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C54E5
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 01:14:06 -0700 (PDT)
X-ASG-Debug-ID: 1681805642-086e237e521b2b0001-0c9NHn
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id CVqYVaUsMbxi6l05 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 18 Apr 2023 16:14:02 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 18 Apr
 2023 16:14:02 +0800
Received: from [10.32.64.2] (10.32.64.2) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 18 Apr
 2023 16:14:00 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <865bd45f-396f-2afd-7206-04f7972e9e0c@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.64.2
Date:   Tue, 18 Apr 2023 16:13:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/5] Parse the PCIe AER and set to relevant registers
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v2 0/5] Parse the PCIe AER and set to relevant registers
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
        <ying.huang@intel.com>, <rdunlap@infradead.org>,
        <bhelgaas@google.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>, <CobeChen@zhaoxin.com>,
        <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
        "Li, Ming" <ming4.li@intel.com>
References: <20230407231821.GA3831711@bhelgaas>
 <433ad19a-8286-ff58-9fd8-d7dd13547032@zhaoxin.com>
 <292498f7-15ab-7cab-dc3a-ca5a13001e86@linux.intel.com>
From:   LeoLiuoc <LeoLiu-oc@zhaoxin.com>
In-Reply-To: <292498f7-15ab-7cab-dc3a-ca5a13001e86@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.32.64.2]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1681805642
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 7386
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107580
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/4/13 0:40, Sathyanarayanan Kuppuswamy 写道:
> 
> 
> On 4/12/23 2:11 AM, LeoLiuoc wrote:
>>
>>
>> 在 2023/4/8 7:18, Bjorn Helgaas 写道:
>>> [+cc Sathy, Ming, since they commented on the previous version]
>>>
>>> On Tue, Nov 15, 2022 at 11:11:15AM +0800, LeoLiu-oc wrote:
>>>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>>>
>>>> According to the sec 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI r6.5, the
>>>> register values form HEST PCI Express AER Structure should be written to
>>>> relevant PCIe Device's AER Capabilities. So the purpose of the patch set
>>>> is to extract register values from HEST PCI Express AER structures and
>>>> program them into AER Capabilities. Refer to the ACPI Spec r6.5 for a more
>>>> detailed description.
>>>
>>> I wasn't involved in this part of the ACPI spec, and I don't
>>> understand how this is intended to work.
>>>
>>> I see that this series extracts AER mask, severity, and control
>>> information from the ACPI HEST table and uses it to configure PCIe
>>> devices as they are enumerated.
>>>
>>> What I don't understand is how this relates to ownership of the AER
>>> capability as negotiated by the _OSC method.  Firmware can configure
>>> the AER capability itself, and if it retains control of the AER
>>> capability, the OS can't write to it (with the exception of clearing
>>> EDR error status), so this wouldn't be necessary.
>>
>> There is no relationship between the ownership of the AER related register and the ownership of the AER capability in the OS or Firmware. The processing here is to initialize the AER related register, not the AER event. If Firmware is configured
> 
> No, the above statement is not correct. Let's assume that if the AER
> feature is owned by firmware and OS arbitrarily configures the AER
> registers, does it seem right? If firmware or OS owns a feature, after
> _OSC negotiation, it assumed that other component will not touch the
> relevant registers. There could be exceptions (like EDR), but it needs
> to be documented in the spec.
> 

I do not find a direct statement from ACPI Spec r6.5 that allows the OS 
to write the value of the HEST AER register to the AER register of the 
corresponding device without AER control but I looked in ACPI Spec for a 
description of the relationship between writing to the AER register 
through the _HPP/_HPX method and whether the OS requires AER control：
The expression are as follows:
1. OSPM uses the information returned by _HPX to determine how ①to 
configure PCI Functions that are hot- plugged into the system, ②to 
configure Functions not configured by the platform firmware during 
initial system boot, ③and to configure Functions any time they lose 
configuration space settings (e.g. OSPM issues a Secondary Bus 
Reset/Function Level Reset or Downstream Port Containment is triggered).

2. _HPX may return multiple types or Record Settings (each setting in a 
single sub-package.) OSPM is responsible for detecting the type of 
Function and for applying the appropriate settings. OSPM is also 
responsible for detecting the device / port type of the PCI Express 
Function and applying the appropriate settings provided. For example, 
the Secondary Uncorrectable Error Severity and Secondary Uncorrectable 
Error Mask settings of Type 2 record are only applicable to PCI Express 
to PCI-X/PCI Bridge whose device / port type is 1000b. Similarly, AER 
settings are only applicable to hot plug PCI Express devices that 
support the optional AER capability.

3. Note: OSPM may override the settings provided by the _HPX object’s 
Type2 record (PCI Express Settings) or Type3 record (PCI Express 
Descriptor Settings) when OSPM has assumed native control of the 
corresponding feature. For example, if OSPM has assumed ownership of AER 
(via _OSC), OSPM may override AER related settings returned by _HPX.

This means that writing the AER register value by _HPX does not require 
the OS to gain control of the AER. Also from the usage description of 
_HPX, I think ownership of AER means who decides the configuration value 
of the AER register rather than who can write the configuration value. 
Even though the OS does not have control or ownership of the AER, it 
should still write the configuration values determined by the firmware 
to the AER register at the request of the firmware. Therefore, 
considering that HEST AER patch is an effective supplement to _HPP/_HPX 
method when the Firmware does not support the _HPP/_HPX method, I think 
the question about whether OS has control of AER to write the 
information in the HEST AER structure to the AER register of the 
corresponding device is similar to the question about _HPX/_HPP method 
to write the AER information to the AER register of the corresponding 
device. Therefore, the ownership of AER is not considered in this patch.

> with AER register, it will not be able to handle the runtime hot reset and link retrain cases in addition to the hotplug case you mentioned below.
> 
> IIUC, here we are trying to use HEST table to configure AER registers.
> Does HEST table override the _OSC based ownership? Can we assume if
> HEST table exist, then irrespective who owns the feature (firmware or
> OS), OS is allowed to configure the AER registers? Is there a spec
> statement confirming the above assumption?
> 

No direct statement to support this view is explicitly found in ACPI 
Spec v6.5. Considering that HEST AER patch is an effective supplement to 
_HPP/_HPX method when the Firmware does not support the _HPP/_HPX 
method, I think the question about whether OS has control of AER to 
write the information in the HEST AER structure to the AER register of 
the corresponding device is similar to the question about _HPX/_HPP 
method to write the AER information to the AER register of the 
corresponding device. Since writing the AER register value by _HPX does 
not require the OS to gain control of the AER, the ownership of AER is 
not considered in this patch.

Your sincerely,
Leoliu-oc

>>
>>>
>>> If the OS owns the AER capability, I assume it gets to decide for
>>> itself how to configure AER, no matter what the ACPI HEST says.
>>>
>>
>> What information does the OS use to decide how to configure AER? The ACPI Spec has the following description: PCI Express (PCIe) root ports may implement PCIe Advanced Error Reporting (AER) support. This table(HEST) contains  information platform firmware supplies to OSPM for configuring AER support on a given root port. We understand that HEST stands for user to express expectations.
>>
>> In the current implementation, the OS already configures a PCIE device based on _HPP/_HPX method when configuring a PCI device inserted into a hot-plug slot or initial configuration of a PCI device at system boot. HEST is just another way to express the desired configuration of the user.
>>
>> Yours sincerely,
>> Leoliu-oc
>>
>>> Maybe this is intended for the case where firmware retains AER
>>> ownership but the OS uses native hotplug (pciehp), and this is a way
>>> for the OS to configure new devices as the firmware expects?  But in
>>> that case, we still have the problem that the OS can't write to the
>>> AER capability to do this configuration.
>>>
>>> Bjorn
>>
> 
