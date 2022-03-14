Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D894D8B7B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Mar 2022 19:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiCNSOi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Mar 2022 14:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239399AbiCNSOh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Mar 2022 14:14:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCB61A3AA
        for <linux-pci@vger.kernel.org>; Mon, 14 Mar 2022 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647281607; x=1678817607;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=37KTS9SceHiU4p/n/uXg4nTjR/RFynLyQx20k83cPZ4=;
  b=nZG+vpOc3GKfJwT2hcxRRzcBQaAgqh/f0fIzx/fEDe8yf7rImCPLYq6a
   ongzRCtf4QbBod0sz7oJ6Evwo8uoxR2NkfIDCOjL8iinVi+uRQiXrRy8O
   O0EXKmE+0FYVfZRsloTxAjeDObDxQ7+ivTw4dmUrbcWCSvcnNW0E8FHpY
   tTJuQJAqowAJqpo3gSh+TQvKBPH99+EGHD5TUtb9nimDnr2ANUde5Tx7Q
   GLXLztDpFSuLPR/22xCZk6JQV5+CedUpXz08i0ccb+VaVGQv8Q7LPl5kf
   0cio7xMJPY29Ey2L5w9LWzOqx9rR7OmKw3KAY8K722f0RGZBnDbw8uJWQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="253666739"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="253666739"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 11:13:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="515545476"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.213.161.252]) ([10.213.161.252])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 11:13:27 -0700
Message-ID: <8ba8c3a8-fee6-0451-8a46-e69e3a29f3bb@linux.intel.com>
Date:   Mon, 14 Mar 2022 11:13:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] PCI: vmd: Assign vmd irq domain before enumeration
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
References: <20220302205500.GA753039@bhelgaas>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20220302205500.GA753039@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/2/2022 1:55 PM, Bjorn Helgaas wrote:
> On Wed, Mar 02, 2022 at 12:35:20PM -0700, Jonathan Derrick wrote:
>> Hey Nirmal,
>>
>> Sorry I didn't catch this earlier.
>>
>> On 3/2/2022 10:41 AM, Patel, Nirmal wrote:
>>> On 2/23/2022 12:52 AM, Nirmal Patel wrote:
>>>> vmd creates and assigns separate irq domain only when MSI remapping is
>>>> enabled. For example VMD-MSI. But vmd doesn't assign irq domain when
>>>> MSI remapping is disabled resulting child devices getting default
>>>> PCI-MSI irq domain. Now when Interrupt remapping is enabled all the
>>>> pci devices are assigned INTEL-IR-MSI domain including vmd endpoints.
>>>> But devices behind vmd gets PCI-MSI irq domain when vmd creates root
>>>> bus and configures child devices.
>> can you capitalize VMD for consistency?
> And IRQ, while you're at it.  Both occur several times above (and
> below).  And PCI.
>
> Also, s/Interrupt remapping/interrupt remapping/ above, since
> there's no reason to capitalize "Interrupt" there.
>
> s/behind vmd gets/behind VMD get/
Understood.
>
>>>> As a result DMAR errors were observed when interrupt remapping was
>>>> enabled on Intel Icelake CPUs.
>>>> For instance:
>>>> DMAR: DRHD: handling fault status reg 2
>>>> DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00
>>>> [fault reason 0x25] Blocked a compatibility format interrupt request
> Quote material as in 2565e5b69c44, e.g.,
>
>   As a result DMAR errors were observed ...  For instance:
>
>     DMAR: DRHD: handling fault status reg 2
>     DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request
>
> (Blank line before and after quoted material, indent quote two spaces,
> don't break messages over lines, so they're easy to grep for.)
>
>>>> So make sure vmd assigns proper irq domain. This patch also removes
>>>> a placeholder patch 2565e5b69c44 (PCI: vmd: Do not disable MSI-X
>>>> remapping if interrupt remapping is enabled by IOMMU.)
> Usual commit citation style is
>
>   2565e5b69c44 ("PCI: vmd: Do not disable MSI-X remapping if interrupt
>   remapping is enabled by IOMMU")
>
> Why is this revert part of this patch?  Could it be a separate patch?
> Either way, we should explain why we can now revert it.
I will add some more details.
>
>>>> MSI remapping
>>>> should be enabled or disabled with and without Interrupt remap.
>>>>
>> So this keeps the performance path working with remapping?
>> Great!
>>
>>
>>>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>>>> ---
>>>>   drivers/pci/controller/vmd.c | 7 ++++---
>>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>>> index cc166c683638..c8d73d75a1c0 100644
>>>> --- a/drivers/pci/controller/vmd.c
>>>> +++ b/drivers/pci/controller/vmd.c
>>>> @@ -813,8 +813,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>>>   	 * acceptable because the guest is usually CPU-limited and MSI
>>>>   	 * remapping doesn't become a performance bottleneck.
>>>>   	 */
>>>> -	if (iommu_capable(vmd->dev->dev.bus, IOMMU_CAP_INTR_REMAP) ||
>>>> -	    !(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>>>> +	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
>>>>   	    offset[0] || offset[1]) {
>>>>   		ret = vmd_alloc_irqs(vmd);
>>>>   		if (ret)
>>>> @@ -853,7 +852,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>>>   	vmd_attach_resources(vmd);
>>>>   	if (vmd->irq_domain)
>>>>   		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>>>> -
>>>> +	else
>>>> +		dev_set_msi_domain(&vmd->bus->dev, vmd->dev->dev.msi.domain);
>> how about dev_get_msi_domain(vmd->dev) ?
Good idea.
>>
>>>> +	
>>>>   	vmd_acpi_begin();
>>>>   	pci_scan_child_bus(vmd->bus);
>>> Gentle ping!
>>>
>>> Thanks
>>>
>>> nirmal
>>>

