Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FF07601AE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 23:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGXV7w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jul 2023 17:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjGXV7u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jul 2023 17:59:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700481B3
        for <linux-pci@vger.kernel.org>; Mon, 24 Jul 2023 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690235968; x=1721771968;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Flh42j3WcoMCSYpxBWnfFWe3nkViGkzwoww0QZRJ3rw=;
  b=kr7/KMef5qFxKIJr2s+SxdHszh7SmPHBq9fOzYv51ecKNeHxifNVSit/
   3Kjk2BTZkF+2KQGw7fWucZ+TecSpH1HH/crbJdbVJ7qFKgEwcwwr5cwaP
   5Cl/h+vMzjbx9HrkPGiz8N8m5CMhGo9WSbbVOLTLb0jhwd5L2tjU0SqaU
   ZqwO/ZuyNuTOT6oTY20ToJNXQqmw7v7RNd8WNhzUHAXFWeqm23s9iyFBd
   PXRoKC5NkbYZOG0Juto1OGqRE7ZeTKUPlw63hIWbkKNYcY5Riim9c5sz4
   wW8TftcvDprJzttijTKPhcjbSRop9XhpUnrFP62wtiBRV/wzfXQE2t5zv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="431357757"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="431357757"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 14:59:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="839614820"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="839614820"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.209.173.4]) ([10.209.173.4])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 14:59:27 -0700
Message-ID: <426be79d-03a4-722d-bb36-855656b3af61@linux.intel.com>
Date:   Mon, 24 Jul 2023 14:59:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] PCI: vmd: VMD to control Hotplug on its rootports
To:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20230713165856.GA322319@bhelgaas>
 <8768a272-18f8-9569-86f6-25564f8f862b@linux.dev>
Content-Language: en-US
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <8768a272-18f8-9569-86f6-25564f8f862b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/13/2023 12:26 PM, Jonathan Derrick wrote:
>
>
> On 7/13/2023 10:58 AM, Bjorn Helgaas wrote:
>> [+cc Jonathan, Lorenzo, Krzysztof, Rob (from MAINTAINERS)]
>>
>> Can you make the subject line say what the patch does?  Repeating
>> "VMD" is probably unnecessary.
>>
>> On Wed, Jul 05, 2023 at 01:20:38PM -0400, Nirmal Patel wrote:
>>> The hotplug functionality is broken in various combinations of guest
>>> OSes i.e. RHEL, SlES and hypervisors i.e. KVM and ESXI.
>>
>> "SLES"
>>
>>> VMD enabled on Intel ADL cpus caused interrupt storm for smasung
>>> drives due to AER being enabled on VMD controlled root ports.
>>
>> "Samsung"
>>
>> Enabling AER should not cause an interrupt storm.  There must be
>> something else going on in addition.  Are you saying the Samsung
>> drives have some AER-related defect, like generating Correctable
>> Errors when they shouldn't?  It doesn't sound like "Intel ADL" would
>> be relevant here.
>>
>> It's not clear to me if this is directly related to *hotplug* or if
>> it's an AER issue that may happen because of hotplug and possible for
>> other reasons.
>>
>>> The patch 04b12ef163d10e348db664900ae7f611b83c7a0e
>>
>> 12 char SHA1 is sufficient.
>>
>>> ("PCI: vmd: Honor APCI _OSC on PCIe features.") was added to the VMD
>>> driver to correct the issue based on the following assumption:
>>>     “Since VMD is an aperture to regular PCIe root ports, honor ACPI
>>>     _OSC to disable PCIe features accordingly to resolve the issue.”
>>>     Link: https://lore.kernel.org/r/20211203031541.1428904-1-kai.heng.feng@canonical.com
>>>
>>> VMD as a PCIe device is an end point(type 0), not a PCIe aperture
>>> (pcie bridge). In fact VMD is a type 0 raid controller(class code).
>>> When BIOS boots, all root ports under VMD is inaccessible by BIOS, and
>>> as such, they maintain their power on default states. The VMD UEFI DXE
>>> driver loads and configure all devices under VMD. This is how AER,
>>> power management and hotplug gets enabled in UEFI, since the BIOS pci
>>> driver cannot access the root ports.
>>
>> s/pcie/PCIe/
>> s/pci/PCI/
>> s/raid/RAID/
>>
>>> The patch worked around the interrupt storm by assigning the native
>>
>> I assume "the patch" means 04b12ef163d1.  Sometimes people write "the
>> patch does X" in the commit log for the current patch, so it's nice to
>> be specific to avoid confusion.
>>
>>> ACPI states to the  root ports under VMD. It assigns AER, hotplug,
>>> PME, etc. These have been restored back to the power on default state
>>> in guest OS, which says the root port hot plug enable is default OFF.
>>> At most, the work around should have only assigned AER state.
>>> An additional patch should be added to exclude hot plug from the
>>> original patch.
>>
>> Add blank line between paragraphs.
>>
>>> This will cause hot plug to start working again in the guest, as the
>>> settings implemented by the UEFI VMD DXE driver will remain in effect
>>> in Linux.
> So hotplug will work in the guest per UEFI VMD DXE driver, but AER will be determined by the host native_aer state?

Yes. Guest doesn't have UEFI driver to configure rootports as in case of Host.

>
>>
>> This is a lot of description that doesn't seem to say what the actual
>> underlying issue is.  It's basically "if we treat hotplug differently
>> from other negotiated features, things work better."  And it seems
>> like it depends on what the UEFI driver did, and we should try to
>> avoid a dependency there.
>>
>> If the issue is too many Correctable Errors being reported via AER, we
>> have that problem regardless of VMD, and we should handle it by
>> rate-limiting and/or suppressing them completely for particularly
>> offensive devices.  We have some issues like this that are still
>> outstanding:
> I'm curious if Non-VMD root ports on the system see the same CE storm.
> Either way, rate-limiting per device seems like a good idea.

AER is not the issue here and we can leave them as it is.
I added unnecessary description which caused more confusion.
My apologies.

>
>>
>> [1] https://lore.kernel.org/linux-pci/DM6PR04MB6473197DBD89FF4643CC391F8BC19@DM6PR04MB6473.namprd04.prod.outlook.com/
>> [2] https://lore.kernel.org/linux-pci/20230606035256.2886098-2-grundler@chromium.org/
>>
>>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>>> ---
>>>   drivers/pci/controller/vmd.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>> index 769eedeb8802..52c2461b4761 100644
>>> --- a/drivers/pci/controller/vmd.c
>>> +++ b/drivers/pci/controller/vmd.c
>>> @@ -701,8 +701,6 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>>>   static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>>>                          struct pci_host_bridge *vmd_bridge)
>>>   {
>>> -    vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
>>> -    vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
>>>       vmd_bridge->native_aer = root_bridge->native_aer;
>>>       vmd_bridge->native_pme = root_bridge->native_pme;
>>>       vmd_bridge->native_ltr = root_bridge->native_ltr;
>>> -- 
>>> 2.31.1
>>>

