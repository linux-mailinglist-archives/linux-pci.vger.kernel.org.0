Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB1F78CDE0
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 22:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbjH2UzM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 16:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbjH2UzI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 16:55:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83761BB
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 13:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693342504; x=1724878504;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qGCuowp3SGa5q1WWc6Os6gVpmqIMdegxnoNYPmLITtk=;
  b=f9mMi3zHsak33jddUWtETIBdaMK4+jTd+33JwbrwvzpPAgq6AxdsPOri
   /8D9ikHHjcOt/aNZGoRln75AFJpECt5XQPJ3yoppjqrQs55WyJQ4J2Ho7
   Hh76K0AgMZRZKpHftM/KnNDIhuk5PEZYuJXtqWnVuwgEvRdq1P+nOl3FM
   9cOqHsU3+UN63B5tMSSu+yvZ0k+jwMCUxb4tVflnULsBBQ2lPWOAhRaL4
   laPEwmEipn1emGYxC1K0eOkPo8upuUKA9bPiCoYt4TGbiPHJcodJFIZeZ
   /WCR68WeQGGRJDYRzsFCeDYJusHPUxf4jy/L/sboZCHTqhKbodvm2TGGQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="374379485"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="374379485"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 13:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="773846226"
X-IronPort-AV: E=Sophos;i="6.02,211,1688454000"; 
   d="scan'208";a="773846226"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.78.16.133]) ([10.78.16.133])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 13:55:03 -0700
Message-ID: <e2b4f720-cc53-4fa6-b205-b4c366b7eb86@linux.intel.com>
Date:   Tue, 29 Aug 2023 13:54:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: vmd: Do not change the BIOS Hotplug setting on
 VMD rootports
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
References: <20230829051022.1328383-1-nirmal.patel@linux.intel.com>
 <ZO4K84tILB5cgixT@lpieralisi>
Content-Language: en-US
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <ZO4K84tILB5cgixT@lpieralisi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/29/2023 8:12 AM, Lorenzo Pieralisi wrote:
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
>>
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
> How is the host bridge probed in the guest if there is no ACPI support ?
>
> I would like to understand this better how this works.
>
>>  	vmd_bridge->native_aer = root_bridge->native_aer;
>>  	vmd_bridge->native_pme = root_bridge->native_pme;
>>  	vmd_bridge->native_ltr = root_bridge->native_ltr;
> I don't get why *only* the hotplug flag should not be copied. Either
> you want to preserve them all or none.
>
> I assume the issue is that in the host, the _OSC method is used to
> probe for flags whereas in the guest you can't rely on it ?

Yes. Guest OSes don't have same _OSC implementation as Host OSes.

>
> Is there a use case where you *do* want to copy the flags from the
> root_bridge to the vmd_bridge ?

VMD wasn't dependent on root_bridge flags until this patch.
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/drivers/pci/controller/vmd.c?id=04b12ef163d10e348db664900ae7f611b83c7a0e

The solution to this patch could have been either using rate limit
for AER or disabling AER from BIOS. I think other flags were added
as part of this fix for AER for the same reason you mentioned above.
Either put all the flags or nothing. Hotplug is broken in Guest OS
after this patch. Is reverting this patch an option?

Thanks

>
> This does not look solid to me.
>
> Thanks,
> Lorenzo


