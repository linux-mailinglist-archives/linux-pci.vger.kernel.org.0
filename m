Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367E86DF03F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 11:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDLJ0D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 05:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjDLJ0C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 05:26:02 -0400
X-Greylist: delayed 866 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Apr 2023 02:26:00 PDT
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4626599
        for <linux-pci@vger.kernel.org>; Wed, 12 Apr 2023 02:26:00 -0700 (PDT)
X-ASG-Debug-ID: 1681290690-1eb14e6d796f090001-0c9NHn
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id 07ib5wqwrvL7hREm (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 12 Apr 2023 17:11:30 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 12 Apr
 2023 17:11:30 +0800
Received: from [10.32.64.2] (10.32.64.2) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 12 Apr
 2023 17:11:28 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <433ad19a-8286-ff58-9fd8-d7dd13547032@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.64.2
Date:   Wed, 12 Apr 2023 17:11:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
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
        "Li, Ming" <ming4.li@intel.com>
References: <20230407231821.GA3831711@bhelgaas>
From:   LeoLiuoc <LeoLiu-oc@zhaoxin.com>
In-Reply-To: <20230407231821.GA3831711@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.32.64.2]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1681290690
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2887
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.107308
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



在 2023/4/8 7:18, Bjorn Helgaas 写道:
> [+cc Sathy, Ming, since they commented on the previous version]
> 
> On Tue, Nov 15, 2022 at 11:11:15AM +0800, LeoLiu-oc wrote:
>> From: leoliu-oc <leoliu-oc@zhaoxin.com>
>>
>> According to the sec 18.3.2.4, 18.3.2.5 and 18.3.2.6 in ACPI r6.5, the
>> register values form HEST PCI Express AER Structure should be written to
>> relevant PCIe Device's AER Capabilities. So the purpose of the patch set
>> is to extract register values from HEST PCI Express AER structures and
>> program them into AER Capabilities. Refer to the ACPI Spec r6.5 for a more
>> detailed description.
> 
> I wasn't involved in this part of the ACPI spec, and I don't
> understand how this is intended to work.
> 
> I see that this series extracts AER mask, severity, and control
> information from the ACPI HEST table and uses it to configure PCIe
> devices as they are enumerated.
> 
> What I don't understand is how this relates to ownership of the AER
> capability as negotiated by the _OSC method.  Firmware can configure
> the AER capability itself, and if it retains control of the AER
> capability, the OS can't write to it (with the exception of clearing
> EDR error status), so this wouldn't be necessary.

There is no relationship between the ownership of the AER related 
register and the ownership of the AER capability in the OS or Firmware. 
The processing here is to initialize the AER related register, not the 
AER event. If Firmware is configured with AER register, it will not be 
able to handle the runtime hot reset and link retrain cases in addition 
to the hotplug case you mentioned below.

> 
> If the OS owns the AER capability, I assume it gets to decide for
> itself how to configure AER, no matter what the ACPI HEST says.
> 

What information does the OS use to decide how to configure AER? The 
ACPI Spec has the following description: PCI Express (PCIe) root ports 
may implement PCIe Advanced Error Reporting (AER) support. This 
table(HEST) contains  information platform firmware supplies to OSPM for 
configuring AER support on a given root port. We understand that HEST 
stands for user to express expectations.

In the current implementation, the OS already configures a PCIE device 
based on _HPP/_HPX method when configuring a PCI device inserted into a 
hot-plug slot or initial configuration of a PCI device at system boot. 
HEST is just another way to express the desired configuration of the user.

Yours sincerely,
Leoliu-oc

> Maybe this is intended for the case where firmware retains AER
> ownership but the OS uses native hotplug (pciehp), and this is a way
> for the OS to configure new devices as the firmware expects?  But in
> that case, we still have the problem that the OS can't write to the
> AER capability to do this configuration.
> 
> Bjorn

