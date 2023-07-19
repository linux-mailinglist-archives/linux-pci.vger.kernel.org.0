Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C774758B19
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 04:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjGSCAh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 22:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGSCAg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 22:00:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417D7FC
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 19:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689732035; x=1721268035;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=21dMuWZEaJm9X2MR2awcVrLUIxn03ljtjEkqnTYRbWI=;
  b=fcfo6H1uxPhMc9b9E8Op2Ecs3gKE4mz+/1yEoHjYHhwuS/gfJcoZRZ9i
   xc43wc14LZ6gaW2Xv482E5incVyZdQTSk0s7Ja7dXq1yDgt6hxTTAVppy
   ibMYsKAwKCag0xJGmTcgQXYtCDd1qXr6tOosK8UjI4ElCtxkirfTzNM0f
   cd9yM8k5YHK8UeQod6h6+VMGwnVNrTIePCWktBD7cnAV70ilk5lodQSiu
   JHgKpJVOx3W3KjaT8sR1pzxmrnYQ5mMT7Q6v406vx0f48/98WGMCA6zSr
   gkAju+EslFNtZ0TXVpkJ/vc4x4s/FVjSwF47K3RGFCvcbPxiwb7oAG6oz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="345943212"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="345943212"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 19:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="723832781"
X-IronPort-AV: E=Sophos;i="6.01,215,1684825200"; 
   d="scan'208";a="723832781"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.209.159.171]) ([10.209.159.171])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 19:00:30 -0700
Message-ID: <0e7cc1d0-a4c6-33d4-1f0f-e0b662a73850@linux.intel.com>
Date:   Tue, 18 Jul 2023 19:00:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] PCI: vmd: VMD to control Hotplug on its rootports
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20230713165856.GA322319@bhelgaas>
Content-Language: en-US
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230713165856.GA322319@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/13/2023 9:58 AM, Bjorn Helgaas wrote:
> [+cc Jonathan, Lorenzo, Krzysztof, Rob (from MAINTAINERS)]
>
> Can you make the subject line say what the patch does?  Repeating
> "VMD" is probably unnecessary.
>
> On Wed, Jul 05, 2023 at 01:20:38PM -0400, Nirmal Patel wrote:
>> The hotplug functionality is broken in various combinations of guest
>> OSes i.e. RHEL, SlES and hypervisors i.e. KVM and ESXI.
> "SLES"

Will fix it.

>
>> VMD enabled on Intel ADL cpus caused interrupt storm for smasung
>> drives due to AER being enabled on VMD controlled root ports.
> "Samsung"
Will fix it.
>
> Enabling AER should not cause an interrupt storm.  There must be
> something else going on in addition.  Are you saying the Samsung
> drives have some AER-related defect, like generating Correctable
> Errors when they shouldn't?  It doesn't sound like "Intel ADL" would
> be relevant here.
>
> It's not clear to me if this is directly related to *hotplug* or if
> it's an AER issue that may happen because of hotplug and possible for
> other reasons.
>
>> The patch 04b12ef163d10e348db664900ae7f611b83c7a0e
> 12 char SHA1 is sufficient.
Will fix it.
>
>> ("PCI: vmd: Honor APCI _OSC on PCIe features.") was added to the VMD
>> driver to correct the issue based on the following assumption:
>> 	“Since VMD is an aperture to regular PCIe root ports, honor ACPI
>> 	_OSC to disable PCIe features accordingly to resolve the issue.”
>> 	Link: https://lore.kernel.org/r/20211203031541.1428904-1-kai.heng.feng@canonical.com
>>
>> VMD as a PCIe device is an end point(type 0), not a PCIe aperture
>> (pcie bridge). In fact VMD is a type 0 raid controller(class code).
>> When BIOS boots, all root ports under VMD is inaccessible by BIOS, and
>> as such, they maintain their power on default states. The VMD UEFI DXE
>> driver loads and configure all devices under VMD. This is how AER,
>> power management and hotplug gets enabled in UEFI, since the BIOS pci
>> driver cannot access the root ports.
> s/pcie/PCIe/
> s/pci/PCI/
> s/raid/RAID/
Will fix it.
>
>> The patch worked around the interrupt storm by assigning the native
> I assume "the patch" means 04b12ef163d1.  Sometimes people write "the
> patch does X" in the commit log for the current patch, so it's nice to
> be specific to avoid confusion.
>
>> ACPI states to the  root ports under VMD. It assigns AER, hotplug,
>> PME, etc. These have been restored back to the power on default state
>> in guest OS, which says the root port hot plug enable is default OFF.
>> At most, the work around should have only assigned AER state.
>> An additional patch should be added to exclude hot plug from the
>> original patch.
> Add blank line between paragraphs.
Will fix it.
>
>> This will cause hot plug to start working again in the guest, as the
>> settings implemented by the UEFI VMD DXE driver will remain in effect
>> in Linux.
> This is a lot of description that doesn't seem to say what the actual
> underlying issue is.  It's basically "if we treat hotplug differently
> from other negotiated features, things work better."  And it seems
> like it depends on what the UEFI driver did, and we should try to
> avoid a dependency there.
>
> If the issue is too many Correctable Errors being reported via AER, we
> have that problem regardless of VMD, and we should handle it by
> rate-limiting and/or suppressing them completely for particularly
> offensive devices.  We have some issues like this that are still
> outstanding:
>
> [1] https://lore.kernel.org/linux-pci/DM6PR04MB6473197DBD89FF4643CC391F8BC19@DM6PR04MB6473.namprd04.prod.outlook.com/
> [2] https://lore.kernel.org/linux-pci/20230606035256.2886098-2-grundler@chromium.org/
Sorry for the long description. I think your understanding of treating
hotplug differently from other features is correct. The hotplug issue
is seen only in guest because guest BIOS doesn't know about such
settings nor have an implementation. Ideally, when hotplug is enabled
in Host BIOS, VMD root ports in guest should obtain same values with
the help of direct assign feature. The patch (04b12ef163d1) overwrites
these values and assigns default values(i.e 0h for hotplug) resulting
in hotplug disabled.

Regarding AER, I think we should leave other settings as it is. During
the initialization, AER is enabled on VMD root-port without knowing if
the platform firmware has a handler. Thanks to the patch(04b12ef163d1),
this mistake was corrected.

>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> ---
>>  drivers/pci/controller/vmd.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index 769eedeb8802..52c2461b4761 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -701,8 +701,6 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
>>  static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
>>  				       struct pci_host_bridge *vmd_bridge)
>>  {
>> -	vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
>> -	vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
>>  	vmd_bridge->native_aer = root_bridge->native_aer;
>>  	vmd_bridge->native_pme = root_bridge->native_pme;
>>  	vmd_bridge->native_ltr = root_bridge->native_ltr;
>> -- 
>> 2.31.1
>>

