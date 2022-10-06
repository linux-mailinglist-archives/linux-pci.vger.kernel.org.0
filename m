Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA25F6D78
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 20:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiJFS0Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJFS0Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 14:26:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A0DB48A6
        for <linux-pci@vger.kernel.org>; Thu,  6 Oct 2022 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665080783; x=1696616783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7du8rxUBSkwD9BLEmUuaU4LinNKPS1aPbZ7IX9j2Zy4=;
  b=j6G79PM6Ufo32HmhGBH+G+rTpIguQXNsZP7fZEdc0+C3uRXuVSY4Iv/3
   A2lqRutsxcfPq1mT3RBZMoQJEbAAe/ovhZA6E6eSvbdbXKmIGdiLHJa+M
   1Sr7RKng2fxrWwFc03mzBWfCmbg84sBAbFI8BZurkuEoYR5az8Y10iD5s
   WiIqF/gda+egjk2FpqmwvU9h6NdWiX+dDGyxOnmzicvz7c55AmK05w23d
   1+AvixK5EOTS3kyapKoZvirqYBjweHgTBg1MyeSjXNFpRJ8svKLWYJsjg
   cyR1oIFe/20Dh9FcA9u9iCKIG42Dz0cHJn2uhHy+y7Ku8vdDvdGELHyH0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="304527924"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="304527924"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 11:26:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="687544419"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="687544419"
Received: from fmmunozr-mobl1.amr.corp.intel.com (HELO [10.212.103.229]) ([10.212.103.229])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 11:26:18 -0700
Message-ID: <1b1e5bc3-78ab-2ad6-58b8-103bc974a833@linux.intel.com>
Date:   Thu, 6 Oct 2022 11:26:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] PCI: vmd: Fix secondary bus reset for Intel bridges
Content-Language: en-US
To:     helgaas@kernel.org, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
References: <20220923203757.4918-1-francisco.munoz.ruiz@linux.intel.com>
 <6a435b33-b27c-7f56-2dca-6e8964242109@linux.dev>
From:   "Munoz Ruiz, Francisco" <francisco.munoz.ruiz@linux.intel.com>
In-Reply-To: <6a435b33-b27c-7f56-2dca-6e8964242109@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Please let me know if something else is needed.

Thanks,
Francisco.

On 9/26/2022 2:07 PM, Jonathan Derrick wrote:
> 
> 
> On 9/23/2022 2:37 PM, francisco.munoz.ruiz@linux.intel.com wrote:
>> From: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
>>
>> The reset was never applied in the current implementation because Intel
>> Bridges owned by VMD are parentless. Internally, the reset API applies
>> a reset to the parent of the pci device supplied as argument, but in this
>> case it failed because there wasn't a parent. This change feeds a child
>> device of an Intel Bridge to the reset API and internally the reset is
>> applied to its parent.
>>
>> Signed-off-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
>> Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
> 
>> ---
>>   drivers/pci/controller/vmd.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index e06e9f4fc50f..34d6ba675440 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -859,8 +859,16 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>   
>>   	pci_scan_child_bus(vmd->bus);
>>   	vmd_domain_reset(vmd);
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
>>   	pci_assign_unassigned_bus_resources(vmd->bus);
>>   
>>   	/*
