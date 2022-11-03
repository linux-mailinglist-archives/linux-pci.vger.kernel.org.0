Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3737617553
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 04:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiKCD71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Nov 2022 23:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKCD7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Nov 2022 23:59:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5556D1166
        for <linux-pci@vger.kernel.org>; Wed,  2 Nov 2022 20:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667447964; x=1698983964;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TAZc29P8R3rXTNXCUT3dUc7JEoFeSbBvBpgEBmDHVJk=;
  b=Q3h3m4xgFdk0b6CX0F4xpgYBzgjQookxHQTn4Y7gvKMy6EBQwhHs55l8
   Sgw9XxfeOIg3jkkuokbK+3qvNZ6G0Z5nZZ+qKU24XNCVRD5+m1eyRzGPf
   iak9yOoaaphbXBJgafhVq8KPqVKulv/YfyOMNIcL50TvehxbZ2BPnRK9K
   k1pkLiZreAoCQSo1eLi6yNeVLDnVBOBfy70+6hfj4kruindy8VQwsFobu
   SLZLWSjhiKcGZRkAusbvIMeK3ifnC0c91k2VBJyyUT39KAggcLWueJ+tE
   4Nr/E2qSGwSOYuvKIJem6g0KjH+teZSSQtc1f/knfA/dmMnx0k3KX3uDS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="297033971"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="297033971"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 20:59:23 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="740020404"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="740020404"
Received: from fmmunozr-mobl1.amr.corp.intel.com (HELO [10.212.75.165]) ([10.212.75.165])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 20:59:23 -0700
Message-ID: <f4ed9c02-12b2-bd7b-f9e6-6583a082ac77@linux.intel.com>
Date:   Wed, 2 Nov 2022 20:58:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH V2] PCI: vmd: Fix secondary bus reset for Intel bridges
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lorenzo.pieralisi@arm.com, jonathan.derrick@linux.dev,
        linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Myron Stowe <myron.stowe@redhat.com>
References: <20221102234221.GA8153@bhelgaas>
Content-Language: en-US
From:   "Munoz Ruiz, Francisco" <francisco.munoz.ruiz@linux.intel.com>
In-Reply-To: <20221102234221.GA8153@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for including Alex and Myron.

On 11/2/2022 4:42 PM, Bjorn Helgaas wrote:
> [+cc Alex, Myron]
> 
> On Mon, Oct 31, 2022 at 02:45:01PM -0700, francisco.munoz.ruiz@linux.intel.com wrote:
>> From: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
>>
>> The reset was never applied in the current implementation because Intel
>> Bridges owned by VMD are parentless. Internally, pci_reset_bus applies
>> a reset to the parent of the pci device supplied as argument, but in this
>> case it failed because there wasn't a parent.
>>
>> In more detail, this change allows the VMD driver to enumerate NVMe devices
>> in pass-through configurations when host reboots are performed. Commit id
>> “6aab5622296b990024ee67dd7efa7d143e7558d0” attempted to fix this, but
>> later we discovered that the code inside pci_reset_bus wasn’t triggering
>> secondary bus resets.  Therefore, we updated the parameters passed to
>> it, and now NVMe SSDs attached to VMD bridges are properly enumerated in
>> VT-d pass-through scenarios.
> 
> Did you mean "guest reboots" above?  If the *host* reboots, I assume
> everybody (host and guests) starts over, so a reset wouldn't really
> apply.
> 
Correct, I meant guest reboots.
> Is the scenario that the VMD device is passed through to a guest, and
> the guest OS is running vmd_probe() and vmd_enable_domain()?
> 
> I thought VFIO already had something to reset devices between guests.
> But maybe this is different because from the point of view of VFIO,
> the pass-through happens only once, and during that single session,
> the guest OS reboots several times, so you want vmd_probe() to reset
> the downstream devices?
Right, this change just makes sure pci_bus_reset(), introduced in 
6aab5622296b ("PCI: vmd: Clean up domain before enumeration"), is sending
pci_bridge_secondary_bus_reset().

I'll issue a v3 with the suggestions below.
> 
> Should this have a Fixes: tag for 6aab5622296b?
> 
> s/pci/PCI/ above in English text.
> 
> Also add "()" after function names.
> 
> Use the typical 12-char SHA1 + subject citation, e.g., 6aab5622296b
> ("PCI: vmd: Clean up domain before enumeration").
> 
>> Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
>> Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> ---
>>  drivers/pci/controller/vmd.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index e06e9f4fc50f..34d6ba675440 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -859,8 +859,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>  
>>  	pci_scan_child_bus(vmd->bus);
>>  	vmd_domain_reset(vmd);
>> -	list_for_each_entry(child, &vmd->bus->children, node)
>> -		pci_reset_bus(child->self);
>> +
>> +	list_for_each_entry(child, &vmd->bus->children, node) {
>> +		if (!list_empty(&child->devices)) {
>> +			pci_reset_bus(list_first_entry(&child->devices,
>> +						       struct pci_dev,
>> +						       bus_list));
>> +			break;
>> +		}
>> +	}
>> +
>>  	pci_assign_unassigned_bus_resources(vmd->bus);
>>  
>>  	/*
>> -- 
>> 2.25.1
>>
>> Hi Bjorn,
>>
>> I updated the commit message with more details. Hopefully, this will 
>> clarify its purpose.
>>
>> Thanks,
>> Francisco.
Thanks!
