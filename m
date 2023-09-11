Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28C879B24C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 01:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbjIKVij (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjIKJCy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 05:02:54 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFAFCCD
        for <linux-pci@vger.kernel.org>; Mon, 11 Sep 2023 02:02:47 -0700 (PDT)
X-ASG-Debug-ID: 1694422962-086e234a2b484f0001-0c9NHn
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id sMZQdI9jaLiVSJEV (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Mon, 11 Sep 2023 17:02:42 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 17:02:41 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 17:02:40 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Message-ID: <a3a603ef-b813-4798-bb54-62076d53bd3a@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date:   Mon, 11 Sep 2023 17:02:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Parse the PCIe AER and set to relevant registers
To:     Bjorn Helgaas <helgaas@kernel.org>
X-ASG-Orig-Subj: Re: [PATCH v3 0/5] Parse the PCIe AER and set to relevant registers
CC:     <lenb@kernel.org>, <james.morse@arm.com>, <tony.luck@intel.com>,
        <bp@alien8.de>, <bhelgaas@google.com>, <robert.moore@intel.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>,
        <acpica-devel@lists.linuxfoundation.org>, <ErosZhang@zhaoxin.com>
References: <20230810232041.GA50619@bhelgaas>
From:   LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <20230810232041.GA50619@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1694422962
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3840
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.113955
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/8/11 7:20, Bjorn Helgaas 写道:
> On Tue, Jul 04, 2023 at 08:04:53PM +0800, LeoLiu-oc wrote:
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> According to the sec 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI r6.5, the
>> register values form HEST PCI Express AER Structure should be written to
>> relevant PCIe Device's AER Capabilities. So the purpose of the patch set
>> is to extract register values from HEST PCI Express AER structures and
>> program them into AER Capabilities.
>> Refer to the ACPI Spec r6.5 for a more detailed description.
>> Considering that HEST AER patch is an effective supplement to _HPP/_HPX
>> method when the Firmware does not support the _HPP/_HPX method and can be
>> specially configured for the AER register of a specific device.
>> The question about whether OS has control of AER to write the information
>> in the HEST AER structure to the AER register of the corresponding device
>> is similar to the question about _HPX/_HPP method to write the AER
>> information to the AER register of the corresponding device.I looked in
>> ACPI Spec for a description of the relationship between writing to the AER
>> register through the _HPP/_HPX method and whether the OS requires AER
>> control:
>> 1.OSPM uses the information returned by _HPX to determine how to
>> configure PCI Functions that are hot- plugged into the system, to
>> configure Functions not configured by the platform firmware during initial
>> system boot, and to configure Functions any time they lose configuration
>> space settings (e.g. OSPM issues a Secondary Bus Reset/Function Level
>> Reset or Downstream Port Containment is triggered).
>>
>> 2._HPX may return multiple types or Record Settings (each setting in a
>> single sub-package.) OSPM is responsible for detecting the type of
>> Function and for applying the appropriate settings. OSPM is also
>> responsible for detecting the device / port type of the PCI Express
>> Function and applying the appropriate settings provided.
>> For example, the Secondary Uncorrectable Error Severity and Secondary
>> Uncorrectable Error Mask settings of Type 2 record are only applicable to
>> PCI Express to PCI-X/PCI Bridge whose device / port type is 1000b.
>> Similarly, AER settings are only applicable to hot plug PCI Express
>> devices that support the optional AER capability.
>>
>> 3.Note: OSPM may override the settings provided by the _HPX object's Type2
>> record (PCI Express Settings) or Type3 record (PCI Express Descriptor
>> Settings) when OSPM has assumed native control of the corresponding
>> feature. For example, if OSPM has assumed ownership of AER (via _OSC),
>> OSPM may override AER related settings returned by _HPX. This means that
>> writing the AER register value by _HPX does not require the OS to gain
>> control of the AER. Also from the usage description of _HPX, I think
>> ownership of AER means who decides the configuration value of the AER
>> register rather than who can write the configuration value. Even though
>> the OS does not have control or ownership of the AER, it should still
>> write the configuration values determined by the firmware to the AER
>> register at the request of the firmware.
>> Therefore, the ownership of AER is not considered in this patch.
> 
> There's a lot of good information above, but this is the cover letter,
> so it won't make it into the git history.  Can you move this
> information to the relevant patches, where it will help justify the
> need for the patch?
> 
> Also, if at all possible, can you arrange for the patches themselves
> to be sent as *responses* to the cover letter?  This makes the series
> thread nicely and makes it much easier to download and apply it.
> 
> Bjorn

OK. I will modify in next version.

LeoLiu-oc
