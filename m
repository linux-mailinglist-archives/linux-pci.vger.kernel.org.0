Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9DE78CED0
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 23:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbjH2VgF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 17:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239227AbjH2Vf4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 17:35:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7749B1BC
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 14:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693344953; x=1724880953;
  h=message-id:date:mime-version:subject:to:references:from:
   cc:in-reply-to:content-transfer-encoding;
  bh=GOwehU8MkVh+l56Y0/vuHOlZpjFJVdFCJZAXgNjhYbY=;
  b=lV0kWuG9z317HuaIvKcLFykhNK3V+fFGxwxuT6iX2K5zvaJ6rvPsTpE/
   7tcV5xh0194OorZ0EBePKd0JIqIVfkIQZeQzlOMGmJwII+sfamRxIwCiV
   3nWT/sRT0UXBuP4SDyz9RKXqyAHUeQOJ08nuIc9svYabpYV+UfIHG8xcg
   iAJd1pN0ykiimrX5+kgwOVrVCrRxQguk413LPsFCdgwjrJgFD7ItiJE8C
   p6Gadggan9Rp2t0qoHNTAjA91fYi6mllvO36lT+x9iTFmKkS6d1l7/1aw
   WbdEAS+/6JQfxk+3GgME1wtktogiZG0nJ1yfrWBV6g+bXBiV9rVBytLMS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="372895346"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="372895346"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 14:35:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="1069617617"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="1069617617"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.78.16.133]) ([10.78.16.133])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 14:35:36 -0700
Message-ID: <3f7046d5-2e2c-4a6b-9e3d-507717528567@linux.intel.com>
Date:   Tue, 29 Aug 2023 14:35:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20230829180045.GA800434@bhelgaas>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
In-Reply-To: <20230829180045.GA800434@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/29/2023 11:00 AM, Bjorn Helgaas wrote:
> On Tue, Aug 29, 2023 at 01:10:22AM -0400, Nirmal Patel wrote:
>> Currently during Host boot up, VMD UEFI driver loads and configures
>> all the VMD endpoints devices and devices behind VMD. Then during
>> VMD rootport creation, VMD driver honors ACPI settings for Hotplug,
>> AER, DPC, PM and enables these features based on BIOS settings.
>>
>> During the Guest boot up, ACPI settings along with VMD UEFI driver are
>> not present in Guest BIOS which results in assigning default values to
>> Hotplug, AER, DPC, etc. As a result hotplug is disabled on the VMD
>> rootports in the Guest OS.
>>
>> VMD driver in Guest should be able to see the same settings as seen
>> by Host VMD driver. Because of the missing implementation of VMD UEFI
>> driver in Guest BIOS, the Hotplug is disabled on VMD rootport in
>> Guest OS. Hot inserted drives don't show up and hot removed drives
>> do not disappear even if VMD supports Hotplug in Guest. This
>> behavior is observed in various combinations of guest OSes i.e. RHEL,
>> SLES and hypervisors i.e. KVM and ESXI.
>>
>> This change will make the VMD Host and Guest Driver to keep the settings
>> implemented by the UEFI VMD DXE driver and thus honoring the user
>> selections for hotplug in the BIOS.
> These settings are negotiated between the OS and the BIOS.  The guest
> runs a different BIOS than the host, so why should the guest setting
> be related to the host setting?
>
> I'm not a virtualization whiz, and I don't understand all of what's
> going on here, so please correct me when I go wrong:
>
> IIUC you need to change the guest behavior.  The guest currently sees
> vmd_bridge->native_pcie_hotplug as FALSE, and you need it to be TRUE?

Correct.

> Currently this is copied from the guest's
> root_bridge->native_pcie_hotplug, so that must also be FALSE.
>
> I guess the guest sees a fabricated host bridge, which would start
> with native_pcie_hotplug as TRUE (from pci_init_host_bridge()), and
> then it must be set to FALSE because the guest _OSC didn't grant
> ownership to the OS?  (The guest dmesg should show this, right?)

This is my understanding too. I don't know much in detail about Guest
expectation.

>
> In the guest, vmd_enable_domain() allocates a host bridge via
> pci_create_root_bus(), and that would again start with
> native_pcie_hotplug as TRUE.  It's not an ACPI host bridge, so I don't
> think we do _OSC negotiation for it.  After this patch removes the
> copy from the fabricated host bridge, it would be left as TRUE.

VMD was not dependent on _OSC settings and is not ACPI Host bridge. It
became _OSC dependent after the patch 04b12ef163d1.
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/drivers/pci/controller/vmd.c?id=04b12ef163d10e348db664900ae7f611b83c7a0e

This patch was added as a quick fix for AER flooding but it could
have been avoided by using rate limit for AER.

I don't know all the history of VMD driver but does it have to be
dependent on root_bridge flags from _OSC? Is reverting 04b12ef163d1
a better idea than not allowing just hotplug flags to be copied from
root_bridge?

Thanks.

>
> If this is on track, it seems like if we want the guest to own PCIe
> hotplug, the guest BIOS _OSC for the fabricated host bridge should
> grant ownership of it.

I will try to check this option.

>
>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> ---
>> v3->v4: Rewrite the commit log.
>> v2->v3: Update the commit log.
>> v1->v2: Update the commit log.
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

