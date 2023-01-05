Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E7965F47C
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 20:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbjAETbT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 14:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbjAETaj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 14:30:39 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D786B1AD;
        Thu,  5 Jan 2023 11:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672946719; x=1704482719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=17ds322DZ1gBtrZfbyVCluaxkZsYnqX1QIiiGQuNQm4=;
  b=ZNDM4eNWMgsmEm1DuKClShIaWmfxETQMhhxNGqFBtpQplfTE1e81NfOP
   UIQ9JBFo6ON42xu6P4pFSkzigkxVtP51lqD/aB/O+5KVscFQ3Bw95W3/3
   nfPFOrZ1JJtXJCpOit1zEul4gZ74Mf3e69UYDwN3b38Ix7mYXCAvrI94L
   sED2ayX15QUg7A8JdY3FRG/yMIT5etjPCd5dOH+XdYFmqMSy8OIu+iBEf
   IaNBo2aCZrm5WyNnDFn15c9pfV1HUoDccld7Zxp/yhGGnK97qUqNalAx5
   PiPhynhYWPDuM+L3f0MFFb8ITpY/2xBcJlH5U+J0UKmTEfCZZtJ6Ry0iW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="386754163"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="386754163"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 11:23:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="724179316"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="724179316"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2023 11:23:49 -0800
Received: from [10.252.211.52] (kliang2-mobl1.ccr.corp.intel.com [10.252.211.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 91F3A580BE0;
        Thu,  5 Jan 2023 11:23:46 -0800 (PST)
Message-ID: <36dab127-93f9-ad87-26be-cb406fed6212@linux.intel.com>
Date:   Thu, 5 Jan 2023 14:23:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "kernelorg@undead.fr" <kernelorg@undead.fr>,
        "kjhambrick@gmail.com" <kjhambrick@gmail.com>,
        "2lprbe78@duck.com" <2lprbe78@duck.com>,
        "nicholas.johnson-opensource@outlook.com.au" 
        <nicholas.johnson-opensource@outlook.com.au>,
        "benoitg@coeus.ca" <benoitg@coeus.ca>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "wse@tuxedocomputers.com" <wse@tuxedocomputers.com>,
        "mumblingdrunkard@protonmail.com" <mumblingdrunkard@protonmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Box, David E" <david.e.box@intel.com>,
        "Sun, Yunying" <yunying.sun@intel.com>
References: <20230105182950.GA1158496@bhelgaas>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230105182950.GA1158496@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023-01-05 1:29 p.m., Bjorn Helgaas wrote:
> On Thu, Jan 05, 2023 at 06:04:52PM +0000, Luck, Tony wrote:
>>> Hi Tony, can you share a dmesg log?  Does it look like the same thing
>>> Kan reported, where the ECAM space is reported only via an
>>> EfiMemoryMappedIO region and is not otherwise reserved by firmware?
>>
>> Attached are serial logs. "broken" is the one from v6.2-rc2, "revert" is the
>> one with your commit reverted.
>>
>> I don't see the string "ECAM" in either of them.
> 
> Yeah, "ECAM" is what the PCIe spec calls it, but Linux logging uses
> "MMCONFIG".  Probably should change that.
> 
> Anyway, your dmesg log shows the same problem:
> 
>   DMI: Intel Corporation BRICKLAND/BRICKLAND, BIOS BRBDXSD1.86B.0338.V01.1603162127 03/16/2016
>   efi: Remove mem48: MMIO range=[0x80000000-0x8fffffff] (256MB) from e820 map
>   PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x80000000-0x8fffffff] (base 0x80000000)
>   [Firmware Info]: PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
>   PCI: not using MMCONFIG
>   acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended configuration space under this bridge
> 
> Apparently the only mention of [mem 0x80000000-0x8fffffff] in the
> firmware/kernel interface is as an EfiMemoryMappedIO region.
> 
> I think this is a firmware bug, but obviously we're going to have to
> figure out a way around it.
> 

I just want to share that I did more tests on an Ice Lake server (a
different generation from my original report and Tony's machine).

The same problem can be found as well.

[    0.000000] DMI: Intel Corporation M50CYP2SB2U/M50CYP2SB2U, BIOS
SE5C6200.86B.4018.D65.2010201151 10/20/2020
[    0.000000] efi: Remove mem375: MMIO range=[0x80000000-0x8fffffff]
(256MB) from e820 map
[    0.000000] e820: remove [mem 0x80000000-0x8fffffff] reserved

[    1.528341] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0x80000000-0x8fffffff] (base 0x80000000)
[    1.566605] [Firmware Info]: PCI: MMCONFIG at [mem
0x80000000-0x8fffffff] not reserved in ACPI motherboard resources
[    1.566611] PCI: not using MMCONFIG

This firmware implementation should exist on the existing platforms for
a long time.

Thanks,
Kan
