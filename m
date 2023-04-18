Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DA26E5B13
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 09:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjDRH6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 03:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDRH6a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 03:58:30 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63506448C
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 00:58:28 -0700 (PDT)
X-ASG-Debug-ID: 1681804699-086e237e501b070001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id eORz1bmA4TLqDKLD (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 18 Apr 2023 15:58:19 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 18 Apr
 2023 15:58:19 +0800
Received: from [10.32.64.2] (10.32.64.2) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 18 Apr
 2023 15:58:16 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <b0581bb8-b31d-2841-3d75-cad28d503707@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.64.2
Date:   Tue, 18 Apr 2023 15:58:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/5] Parse the PCIe AER and set to relevant registers
To:     Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v2 0/5] Parse the PCIe AER and set to relevant registers
CC:     <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
        <ying.huang@intel.com>, <rdunlap@infradead.org>,
        <bhelgaas@google.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devel@acpica.org>, <CobeChen@zhaoxin.com>,
        <TonyWWang@zhaoxin.com>, <ErosZhang@zhaoxin.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Li, Ming" <ming4.li@intel.com>, <leoliu@zhaoxin.com>
References: <20230412163201.GA49069@bhelgaas>
From:   LeoLiuoc <LeoLiu-oc@zhaoxin.com>
In-Reply-To: <20230412163201.GA49069@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.32.64.2]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1681804699
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 7685
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107579
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



在 2023/4/13 0:32, Bjorn Helgaas 写道:
> On Wed, Apr 12, 2023 at 05:11:28PM +0800, LeoLiuoc wrote:
>> 在 2023/4/8 7:18, Bjorn Helgaas 写道:
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
>>> capability as negotiated by the _OSC method.  Firmware can configure
>>> the AER capability itself, and if it retains control of the AER
>>> capability, the OS can't write to it (with the exception of clearing
>>> EDR error status), so this wouldn't be necessary.
>>
>> There is no relationship between the ownership of the AER related
>> register and the ownership of the AER capability in the OS or
>> Firmware.
> 
> I don't understand this; can you say it another way?  "Ownership of
> the AER related register" and "ownership of the AER capability" sound
> exactly the same to me.
> 

I would like to state that the operation of writing the AER capability 
register of the relevant PCIe device through the HEST PCI Express AER 
structure has nothing to do with the ownership of the AER.

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

>> The processing here is to initialize the AER related register, not
>> the AER event. If Firmware is configured with AER register, it will
>> not be able to handle the runtime hot reset and link retrain cases
>> in addition to the hotplug case you mentioned below.
>>
>>> If the OS owns the AER capability, I assume it gets to decide for
>>> itself how to configure AER, no matter what the ACPI HEST says.
>>
>> What information does the OS use to decide how to configure AER? The
>> ACPI Spec has the following description: PCI Express (PCIe) root
>> ports may implement PCIe Advanced Error Reporting (AER) support.
>> This table(HEST) contains  information platform firmware supplies to
>> OSPM for configuring AER support on a given root port. We understand
>> that HEST stands for user to express expectations.
>>
>> In the current implementation, the OS already configures a PCIE
>> device based on _HPP/_HPX method when configuring a PCI device
>> inserted into a hot-plug slot or initial configuration of a PCI
>> device at system boot. HEST is just another way to express the
>> desired configuration of the user.
> 
> Why was the HEST mechanism added if the functionality is equivalent
> to the existing _HPP/_HPX?  There must be something that HEST supplies
> that _HPP/_HPX did not.
> 
> I think we need some things in the commit log (and short comments in
> the code) to help maintain this in the future:
> 
>    - What problem does this solve, e.g., is there some bug that happens
>      because we lack this functionality?
> 
>    - How is this HEST mechanism related to _HPP/_HPX?  What are the
>      differences?
> 
>    - How is this related to _OSC AER ownership?
> 

Yes, I'll add explanations of these issues to the commit log in the next 
release.

> I think we ignore _OSC ownership in the existing _HPP/_HPX code, but
> that seems like a potential problem.  The PCI Firmware spec (r3.3, sec
> 4.5.1) is pretty clear:
> 
>    If control of this feature was requested and denied or was not
>    requested, firmware returns this bit set to 0, and the operating
>    system must not modify the Advanced Error Reporting Capability or
>    the other error enable/status bits listed above.
> 

PCI Firmware Spec is not very clear about the relationship between 
configuring the AER register and the ownership of the AER. ACPI Spec 
v6.5 does specify the use of _HPP or _HPX: writing to the AER register 
through the _HPP/HPX method does not require the OS to acquire control 
of the AER.

Your Sincerely,
LeoLiu-oc

>>> Maybe this is intended for the case where firmware retains AER
>>> ownership but the OS uses native hotplug (pciehp), and this is a way
>>> for the OS to configure new devices as the firmware expects?  But in
>>> that case, we still have the problem that the OS can't write to the
>>> AER capability to do this configuration.
>>>
>>> Bjorn
