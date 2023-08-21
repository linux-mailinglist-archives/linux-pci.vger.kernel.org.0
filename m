Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F53782D11
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 17:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbjHUPRG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 11:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbjHUPRF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 11:17:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D86F100
        for <linux-pci@vger.kernel.org>; Mon, 21 Aug 2023 08:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692631022; x=1724167022;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wf5lVtHycXXYff1Ihi/tL+Zkjj8lykOjnE7uNfJO8Uk=;
  b=JY4DJp/mOoQGHYzbgXk2J9VjQVQUhuCKYzi72wSIws2931juBmpFFY2b
   jAyrMV+63575FUgGD4SL6Gmi3bIj27/vOgEPeOYPDl9mFmjyU98PcBa8/
   s1+0fq0DXY4Var+DDvylUiXhsTnvnHHS8piXaqJvb7EfR9lFw/KS5R/gG
   tuMAaLWIGGkDWMvgAScBi62DH9hNJMeAED+wifmb6vDVmFHhawQjNzt+O
   6sXLyAnvZARY2b69Ng8QjqxAogZhy2G+YubqmiFwk6xCbKXY1OBuu/WVM
   EKyLVZSta3gbnYzFG9P44sYtduawoXou8QZKJsJMyp6BFmXxDD84fiXfm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="373587197"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="373587197"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 08:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="801303344"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="801303344"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.209.140.53]) ([10.209.140.53])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 08:16:51 -0700
Message-ID: <7cc7814c-8c5f-4895-b0e6-adf945d14abc@linux.intel.com>
Date:   Mon, 21 Aug 2023 08:16:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: vmd: Do not change the Hotplug setting on VMD
 rootports
Content-Language: en-US
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org
References: <20230725035405.932765-1-nirmal.patel@linux.intel.com>
 <ZOMwgFHc3Ngv204W@lpieralisi>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <ZOMwgFHc3Ngv204W@lpieralisi>
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

On 8/21/2023 2:38 AM, Lorenzo Pieralisi wrote:
> On Mon, Jul 24, 2023 at 11:54:05PM -0400, Nirmal Patel wrote:
>> The hotplug functionality is broken in various combinations of guest
>> OSes i.e. RHEL, SLES and hypervisors i.e. KVM and ESXI.
> What about the configurations that are actually working ?
>
> Will this patch change anything on that front ?

None of the Guest - Host combinations are working. This change with fix all
the scenarios.

>
>> During the VMD rootport creation, VMD honors ACPI settings and assigns
>> respective values to Hotplug, AER, DPC, PM etc which works in case of
>> Host OS. But these have been restored back to the power on default
>> state in Guest OSes, which puts the root port hot plug enable to
>> default OFF.
>>
>> When BIOS boots, all root ports under VMD is inaccessible by BIOS and
>> they maintain their power on default states. The VMD UEFI driver loads
>> and configure all devices under VMD. This is how AER, power management,
>> DPC and hotplug gets enabled in UEFI, since the BIOS pci driver cannot
>> access the root ports. With the absence of VMD UEFI driver in Guest,
>> Hotplug stays Disabled.
>>
>> This change will  cause the hot plug to start working again in guest,
>> as the settings implemented by the UEFI VMD DXE driver will remain in
>> effect in the Guest OS.
> This explanation is unclear to me - in particular the link between
> code changes and the commit log. Please write a commit log that
> explains and justifies the changes you are making below.
>
> Thanks,
> Lorenzo

will do.

>
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

