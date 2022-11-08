Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91536206FB
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 03:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiKHCtZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Nov 2022 21:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiKHCtN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Nov 2022 21:49:13 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B442E6B1
        for <linux-pci@vger.kernel.org>; Mon,  7 Nov 2022 18:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667875752; x=1699411752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ve4Xc6OhSSC0BEo8nJrKtv+HOEDmfdqWoYLs3F4P6Bs=;
  b=hJBgJu13wBDp8q3Iqh05UucwahLw+Eslgo6zXyglzJJ3SITDkoHwU7SU
   sltqLBo3mklul+3iraSAYYmIFlcg01tfUW5iMHnsXkkpN83NlvfTE3Aal
   zyd10qsbjKO9i5+HM5Lbld1FkqGZTOkTAccJy7jb1s9bFpaw07okFT+mu
   tU9RFiUSuByhRjpzjXDR67HFH0an6yKSbEBcg2kiu3CPDn8/pNHNi8KVu
   LLsCRp+bxi1i9GClvx5cvpE5CQh0+L3eqY9LuxfMKpB8BvJvFj6m0GK2Y
   GERfZb7xNmV4sNLm6DvIUHZ8SLuswcdOcKD9Alq50vZIU3So2UaMBA81y
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="372725707"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="372725707"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 18:49:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="614109498"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="614109498"
Received: from aquintan-mobl.amr.corp.intel.com (HELO [10.213.168.71]) ([10.213.168.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 18:49:11 -0800
Message-ID: <913cbad5-5d5d-6326-d61e-7c9ea708c236@linux.intel.com>
Date:   Mon, 7 Nov 2022 19:49:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] PCI: vmd: Disable MSI remapping after suspend
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lorenzo.pieralisi@arm.com, jonathan.derrick@linux.dev,
        linux-pci@vger.kernel.org,
        Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
References: <20221107201942.GA415315@bhelgaas>
Content-Language: en-US
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20221107201942.GA415315@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/7/2022 12:19 PM, Bjorn Helgaas wrote:
> On Mon, Nov 07, 2022 at 10:27:35AM -0800, Francisco@vger.kernel.org wrote:
>> From: Nirmal Patel <nirmal.patel@linux.intel.com>
>>
>> MSI remapping is disbaled by VMD driver for intel's icelake and
> disabled
> Intel's
> Ice Lake (at least per intel.com)
ACK
>
>> newer systems in order to improve performance by setting MSI_RMP_DIS
>> bit. By design MSI_RMP_DIS bit of VMCONFIG registers is cleared.
> register is
>
> "MSI_RMP_DIS" doesn't appear in the kernel source.  Is it the same as
> VMCONFIG_MSI_REMAP?

Yes. Using VMCONFIG_MSI_REMAP makes more sense here.

>
>> The same register gets cleared when system is put in S3 power state.
>> VMD driver needs to set this register again in order to avoid
>> interrupt issues with devices behind VMD if MSI remapping was
>> disabled before.
> Should there be a Fixes: tag here?  I guess the failure symptom is
> that a driver doesn't see interrupts it expects?
>
>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> Reviewed-by: Francisco Munoz <francisco.munoz.ruiz@linux.intel.com>
>> ---
>>  drivers/pci/controller/vmd.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index e06e9f4fc50f..247012b343fd 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -980,6 +980,9 @@ static int vmd_resume(struct device *dev)
>>  	struct vmd_dev *vmd = pci_get_drvdata(pdev);
>>  	int err, i;
>>  
>> +	if (!vmd->irq_domain)
>> +		vmd_set_msi_remapping(vmd, false);
> I suppose this is functionally equivalent to this code in
> vmd_enable_domain():
>
>         if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>             offset[0] || offset[1]) {
>                 ret = vmd_create_irq_domain(vmd);
>         } else {
>                 vmd_set_msi_remapping(vmd, false);
>
> because vmd->irq_domain will be NULL if we disabled MSI remapping at
> probe-time.
>
> Maybe the vmd_enable_domain() code could be rearranged a little bit to
> make it obvious that we're doing the same thing both at probe-time and
> resume-time?
>
> Should the vmd_resume() code *enable* MSI remapping in the other case,
> e.g.,
>
>   if (vmd->irq_domain)
>     vmd_set_msi_remapping(vmd, true);
>   else
>     vmd_set_msi_remapping(vmd, false);
>
> I don't know what clears PCI_REG_VMCONFIG (which enabled MSI remapping
> IIUC).  If it's cleared by firmware, the current patch depends on that
> firmware behavior, so maybe it would be good to remove that
> dependency?
Good suggestion. I will make changes for both enabling and disabling MSI
remapping. That will help avoid dependency from firmware. Thanks.
>
>>  	for (i = 0; i < vmd->msix_count; i++) {
>>  		err = devm_request_irq(dev, vmd->irqs[i].virq,
>>  				       vmd_irq, IRQF_NO_THREAD,
>> -- 
>> 2.34.1
>>

