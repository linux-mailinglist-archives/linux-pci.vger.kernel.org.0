Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910026E6798
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 16:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjDROzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 10:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjDROzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 10:55:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A188BAF1D
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681829689; x=1713365689;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=L0pUtgBS78VC98o2+JRpZi8ia2HzKCrQ1F99P8IxInM=;
  b=e/O6WOt9Fw9/4Y+TMD4a89CiBM3Ux1vOKS43q1mJr0Pmoz5/p1GgQ+Af
   GG7nPcXq6QsBcwtQIH4GbhyxCsRLKhJwB5N8I6ifQFzuOC2UTnSBurZaD
   Q25Xedy76VTGTZKCx4KCSNGMIP7VCLbApAbc/CIoAHD1l6EVH9orJPdnt
   rnlqVyxGfyrUPeecl2sTX80uRio5vL3Ny6E0t6waVEvwvPABqlDjgJQ/7
   +vqOdjzdMGw2Hvj204VJo2EUq0O6irQPRbT4o6hFf8e3Sn9KibnmeaWXP
   MlB7b6B/+ZRenv5JysfWPjRsVlq9NYjr302aeJSP0H7d/VItww5l1CruM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="410417039"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="410417039"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 07:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="815243668"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="815243668"
Received: from mjgonzal-mobl1.amr.corp.intel.com (HELO [10.212.85.238]) ([10.212.85.238])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 07:54:33 -0700
Message-ID: <1858f4fc-ae60-60cf-0e45-f648c563d1a0@linux.intel.com>
Date:   Tue, 18 Apr 2023 07:54:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] PCI: vmd: Reset VMD config register between soft reboots
Content-Language: en-US
To:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-pci@vger.kernel.org
References: <20230224202811.644370-1-nirmal.patel@linux.intel.com>
 <8b5e6130-13c2-8142-6e70-075ba735fe60@linux.intel.com>
 <ef8c77ef-c29a-0a5e-0ba2-33fbd6039700@linux.dev>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <ef8c77ef-c29a-0a5e-0ba2-33fbd6039700@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/17/2023 8:15 PM, Jonathan Derrick wrote:
>
>
> On 3/15/23 3:51 PM, Patel, Nirmal wrote:
>> On 2/24/2023 1:28 PM, Nirmal Patel wrote:
>>> VMD driver can disable or enable MSI remapping by changing
>>> VMCONFIG_MSI_REMAP register. This register needs to be set to the
>>> default value during soft reboots. Drives failed to enumerate
>>> when Windows boots after performing a soft reboot from Linux.
>>> Windows doesn't support MSI remapping disable feature and stale
>>> register value hinders Windows VMD driver initialization process.
>>> Adding vmd_shutdown function to make sure to set the VMCONFIG
>>> register to the default value.
>>>
>>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>>> Fixes: ee81ee84f873 ("PCI: vmd: Disable MSI-X remapping when possible")
>>> ---
>>>   drivers/pci/controller/vmd.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>> index 769eedeb8802..50a187a29a1d 100644
>>> --- a/drivers/pci/controller/vmd.c
>>> +++ b/drivers/pci/controller/vmd.c
>>> @@ -979,6 +979,13 @@ static void vmd_remove(struct pci_dev *dev)
>>>       ida_simple_remove(&vmd_instance_ida, vmd->instance);
>>>   }
>>>   +static void vmd_shutdown(struct pci_dev *dev)
>>> +{
>>> +        struct vmd_dev *vmd = pci_get_drvdata(dev);
>>> +
>>> +        vmd_remove_irq_domain(vmd);
>>> +}
>>> +
>>>   #ifdef CONFIG_PM_SLEEP
>>>   static int vmd_suspend(struct device *dev)
>>>   {
>>> @@ -1056,6 +1063,7 @@ static struct pci_driver vmd_drv = {
>>>       .id_table    = vmd_ids,
>>>       .probe        = vmd_probe,
>>>       .remove        = vmd_remove,
>>> +    .shutdown    = vmd_shutdown,
>>>       .driver        = {
>>>           .pm    = &vmd_dev_pm_ops,
>>>       },
>>
>> Gentle ping.
>>
>> Thanks
>>
>
> LGTM
> Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>

Gentle ping.

Thanks

