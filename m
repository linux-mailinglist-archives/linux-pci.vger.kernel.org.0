Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23A79DB04
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 23:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjILVf6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Sep 2023 17:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjILVf6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 17:35:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF1F10CA
        for <linux-pci@vger.kernel.org>; Tue, 12 Sep 2023 14:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694554554; x=1726090554;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IhjsNouMETquVZhhguXlo23cAli0ZYnyyjCsbRgSsxY=;
  b=UW59CiF63eID/lmv4xhCwnfViCiOkoLGxcpLVVbNODl/u5HvsOl0evzU
   33llSWTguZShohnvi8HVAhApmFklNXpY0/D6x2kRjKruPBwN+labunZ+A
   c00pJMgcWNWIx1j7EqRnZLq6FFTh5uWRb3Ye9YA4wVbc1eeoz+I5P2VVc
   zWS8OLWQ7LQSVg+9+moLWpvB3zxWeAbvVvUoWmQ9UXeirw5hHo4BGNhFT
   kMhXxVnky/pcgqvPbzZaFa6Kg1Dh+94uSgt80/vpw2ZCu9e6Q4SVCIphK
   FSYe8PkkqEaGlLRLXa7xuRxKErQG3GlYPJ8ezpVmHG3EqzOjz8SMkpp+C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="358771240"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="358771240"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 14:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="990651373"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="990651373"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.78.17.66]) ([10.78.17.66])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 14:35:40 -0700
Message-ID: <df47f7ba-7139-4306-b049-bb0ce28502e3@linux.intel.com>
Date:   Tue, 12 Sep 2023 14:35:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230830165503.GA812174@bhelgaas>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230830165503.GA812174@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/30/2023 9:55 AM, Bjorn Helgaas wrote:
> [+cc Kai-Heng, Lorenzo, Rafael]
>
> On Tue, Aug 29, 2023 at 02:35:36PM -0700, Patel, Nirmal wrote:
>> On 8/29/2023 11:00 AM, Bjorn Helgaas wrote:
>>> On Tue, Aug 29, 2023 at 01:10:22AM -0400, Nirmal Patel wrote:
>>>> Currently during Host boot up, VMD UEFI driver loads and configures
>>>> all the VMD endpoints devices and devices behind VMD. Then during
>>>> VMD rootport creation, VMD driver honors ACPI settings for Hotplug,
>>>> AER, DPC, PM and enables these features based on BIOS settings.
>>>>
>>>> During the Guest boot up, ACPI settings along with VMD UEFI driver are
>>>> not present in Guest BIOS which results in assigning default values to
>>>> Hotplug, AER, DPC, etc. As a result hotplug is disabled on the VMD
>>>> rootports in the Guest OS.
>>>>
>>>> VMD driver in Guest should be able to see the same settings as seen
>>>> by Host VMD driver. Because of the missing implementation of VMD UEFI
>>>> driver in Guest BIOS, the Hotplug is disabled on VMD rootport in
>>>> Guest OS. Hot inserted drives don't show up and hot removed drives
>>>> do not disappear even if VMD supports Hotplug in Guest. This
>>>> behavior is observed in various combinations of guest OSes i.e. RHEL,
>>>> SLES and hypervisors i.e. KVM and ESXI.
>>>>
>>>> This change will make the VMD Host and Guest Driver to keep the settings
>>>> implemented by the UEFI VMD DXE driver and thus honoring the user
>>>> selections for hotplug in the BIOS.
>>> These settings are negotiated between the OS and the BIOS.  The guest
>>> runs a different BIOS than the host, so why should the guest setting
>>> be related to the host setting?
>>>
>>> I'm not a virtualization whiz, and I don't understand all of what's
>>> going on here, so please correct me when I go wrong:
>>>
>>> IIUC you need to change the guest behavior.  The guest currently sees
>>> vmd_bridge->native_pcie_hotplug as FALSE, and you need it to be TRUE?
>> Correct.
>>
>>> Currently this is copied from the guest's
>>> root_bridge->native_pcie_hotplug, so that must also be FALSE.
>>>
>>> I guess the guest sees a fabricated host bridge, which would start
>>> with native_pcie_hotplug as TRUE (from pci_init_host_bridge()), and
>>> then it must be set to FALSE because the guest _OSC didn't grant
>>> ownership to the OS?  (The guest dmesg should show this, right?)
>> This is my understanding too. I don't know much in detail about Guest
>> expectation.
>>
>>> In the guest, vmd_enable_domain() allocates a host bridge via
>>> pci_create_root_bus(), and that would again start with
>>> native_pcie_hotplug as TRUE.  It's not an ACPI host bridge, so I don't
>>> think we do _OSC negotiation for it.  After this patch removes the
>>> copy from the fabricated host bridge, it would be left as TRUE.
>> VMD was not dependent on _OSC settings and is not ACPI Host bridge. It
>> became _OSC dependent after the patch 04b12ef163d1.
>> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/drivers/pci/controller/vmd.c?id=04b12ef163d10e348db664900ae7f611b83c7a0e
>>
>> This patch was added as a quick fix for AER flooding but it could
>> have been avoided by using rate limit for AER.
>>
>> I don't know all the history of VMD driver but does it have to be
>> dependent on root_bridge flags from _OSC? Is reverting 04b12ef163d1
>> a better idea than not allowing just hotplug flags to be copied from
>> root_bridge?
> It seems like the question is who owns AER, hotplug, etc for devices
> below VMD.  AER rate limiting sounds itself like a quick fix without
> addressing the underlying problem.
>
>>> If this is on track, it seems like if we want the guest to own PCIe
>>> hotplug, the guest BIOS _OSC for the fabricated host bridge should
>>> grant ownership of it.
>> I will try to check this option.
> On second thought, this doesn't seem right to me.  An _OSC method
> clearly applies to the hierarchy under that device, e.g., if we have a
> PNP0A03 host bridge with _SEG 0000 and _CRS that includes [bus 00-ff],
> its _OSC clearly applies to any devices in domain 0000, which in this
> case would include the VMD bridge.
>
> But I don't think it should apply to the devices *below* the VMD
> bridge.  Those are in a different domain, and if the platform wants to
> manage AER, hotplug, etc., for those devices, it would have to know
> some alternate config access method in order to read the AER and
> hotplug registers.  I think that config access depends on the setup
> done by the VMD driver, so the platform doesn't know that.
>
> By this argument, I would think the guest _OSC would apply to the VMD
> device itself, but not to the children of the VMD, and the guest could
> retain the default native control of all these services inside the VMD
> domain.
>
> But prior to 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe
> features"), the guest *did* retain native control, so we would have to 
> resolve the issue solved by 04b12ef163d1 in some other way.
>
> Bjorn
Yes, _OSC settings should applied to devices on 0000 domain. VMD
creates its own domain to manage the child devices. So it is against
the VMD design to force _OSC settings and overwrite VMD settings.

The patch 04b12ef163d1 disables AER on VMD rootports by using BIOS system
settings for AER, Hotplug, etc.
The patch 04b12ef163d1 *assumes VMD is a bridge device* and copies
and *imposes system settings* for AER, DPC, Hotplug, PM, etc on VMD.
Borrowing and applying system settings on VMD rootports is
not correct. VMD is *type 0 PCI endpoint device* and all the PCI devices
under VMD are *privately* owned by VMD not by the OS. Also VMD has
its *own Hotplug settings* for its rootports and child devices in BIOS
under VMD settings that are different from BIOS system settings.
It is these settings that give VMD its own unique functionality.

For the above reason, VMD driver should disable AER generation by
devices it owns. There are two possible solutions.

Possible options to fix: There are two possible solutions.

Options 1: VMD driver disables AER by copying AER BIOS system settings
which the patch 04b12ef163d1 does but do not change other settings
including Hotplug. The proposed patch does that.

Option 2: Either disable AER by adding an extra BIOS settings under
VMD settings or disable AER by Linux VMD driver by adding a boot
parameter and remove the patch 04b12ef163d1.

Thanks
nirmal

>
>>>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>>>> ---
>>>> v3->v4: Rewrite the commit log.
>>>> v2->v3: Update the commit log.
>>>> v1->v2: Update the commit log.
>>>> ---
>>>>  drivers/pci/controller/vmd.c | 2 --
>>>>  1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>>> index 769eedeb8802..52c2461b4761 100644
>>>> --- a/drivers/pci/controller/vmd.c
>>>> +++ b/drivers/pci/controller/vmd.c
>>>> @@ -701,8 +701,6 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>>>>  static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>>>>  				       struct pci_host_bridge *vmd_bridge)
>>>>  {
>>>> -	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
>>>> -	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
>>>>  	vmd_bridge->native_aer = root_bridge->native_aer;
>>>>  	vmd_bridge->native_pme = root_bridge->native_pme;
>>>>  	vmd_bridge->native_ltr = root_bridge->native_ltr;
>>>> -- 
>>>> 2.31.1
>>>>

