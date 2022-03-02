Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587594CAECD
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 20:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241512AbiCBTgJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 14:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbiCBTgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 14:36:07 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5930D7609
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 11:35:23 -0800 (PST)
Message-ID: <80ae742a-b958-c141-6c3e-cbdbd671990f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646249719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rbn8WRkyzbvkcsVd7Uo/tfoIdWqx2tKzZfBx59IMvTQ=;
        b=v2udmDkfE1e3cYTHnM56QwRGj9lxQuGlff6ow8vhuh5CVv08a3r3ih3ksmEK2U9ewqH1iA
        /BXnsOOg/DmfOK2vOnKWq3oip4EsZR7KiSJp8ctS090cg0GXKkv4SCMbvPN2ZYsuTQU8/Y
        QPKoTjbNAPGfjUEM/1Mn9GMuG3u6Cx4=
Date:   Wed, 2 Mar 2022 12:35:20 -0700
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: vmd: Assign vmd irq domain before enumeration
Content-Language: en-US
To:     "Patel, Nirmal" <nirmal.patel@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org
References: <20220223075245.17744-1-nirmal.patel@linux.intel.com>
 <358b0673-f90f-78ca-be66-51d5f76cc42b@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <358b0673-f90f-78ca-be66-51d5f76cc42b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey Nirmal,

Sorry I didn't catch this earlier.

On 3/2/2022 10:41 AM, Patel, Nirmal wrote:
> On 2/23/2022 12:52 AM, Nirmal Patel wrote:
>> vmd creates and assigns separate irq domain only when MSI remapping is
>> enabled. For example VMD-MSI. But vmd doesn't assign irq domain when
>> MSI remapping is disabled resulting child devices getting default
>> PCI-MSI irq domain. Now when Interrupt remapping is enabled all the
>> pci devices are assigned INTEL-IR-MSI domain including vmd endpoints.
>> But devices behind vmd gets PCI-MSI irq domain when vmd creates root
>> bus and configures child devices.
can you capitalize VMD for consistency?

>>
>> As a result DMAR errors were observed when interrupt remapping was
>> enabled on Intel Icelake CPUs.
>> For instance:
>> DMAR: DRHD: handling fault status reg 2
>> DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00
>> [fault reason 0x25] Blocked a compatibility format interrupt request
>>
>> So make sure vmd assigns proper irq domain. This patch also removes
>> a placeholder patch 2565e5b69c44 (PCI: vmd: Do not disable MSI-X
>> remapping if interrupt remapping is enabled by IOMMU.) MSI remapping
>> should be enabled or disabled with and without Interrupt remap.
>>
So this keeps the performance path working with remapping?
Great!


>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> ---
>>   drivers/pci/controller/vmd.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index cc166c683638..c8d73d75a1c0 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -813,8 +813,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>   	 * acceptable because the guest is usually CPU-limited and MSI
>>   	 * remapping doesn't become a performance bottleneck.
>>   	 */
>> -	if (iommu_capable(vmd->dev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
>> -	    !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>> +	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>>   	    offset[0] || offset[1]) {
>>   		ret = vmd_alloc_irqs(vmd);
>>   		if (ret)
>> @@ -853,7 +852,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>   	vmd_attach_resources(vmd);
>>   	if (vmd->irq_domain)
>>   		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>> -
>> +	else
>> +		dev_set_msi_domain(&vmd->bus->dev, vmd->dev->dev.msi.domain);
how about dev_get_msi_domain(vmd->dev) ?

>> +	
>>   	vmd_acpi_begin();
>>   
>>   	pci_scan_child_bus(vmd->bus);
> 
> Gentle ping!
> 
> Thanks
> 
> nirmal
> 
