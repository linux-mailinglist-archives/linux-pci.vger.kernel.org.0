Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FB44ECB5D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 20:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349732AbiC3SJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349701AbiC3SIr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 14:08:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6B03EB88
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648663615; x=1680199615;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Byn5ixYNjz9cLAkR9IUJI/on5TvfX5/uv+9WR6spqeU=;
  b=UzQ+gwvbomFWQC59CzRB4e6ZZ1aSmwbQjaWpCiu1O6U+6xeToAG5rigu
   kZQ55c3zlMoe99hQ9+BqW0lKTQCNnG9S6h9xM4LkrrWsDEiLcYrR9ihPo
   kFeVLlvQAF3pIFobWLU3j3HKg5x9yTMrHI+SzBeHzju/r3k0X3khCE0T5
   yhSOX+iD23S5LYzhukerUMlSOHyV11uSknHnH+kIy9Szs/XbbGM7TvT48
   Z6/bVYfdFhyYHEl0XtveoVL70e7KJRQDv/8Ktc+8vqQqdtiZGVseVHEf4
   UUZmpBfAkIe7eiXoWJBAeruiqALfKO/Qd7YE8xnVr3pgSKKCVIZ3Yn0oY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="258440324"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="258440324"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 11:06:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="546960615"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.117.191]) ([10.212.117.191])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 11:06:44 -0700
Message-ID: <28c964fc-6392-c42a-fd85-7238da07ecfc@linux.intel.com>
Date:   Wed, 30 Mar 2022 11:06:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@linux.dev>,
        Nirmal Patel <nirmal.patel@linux.intel.com>
References: <20220330175453.GA1694874@bhelgaas>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20220330175453.GA1694874@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/30/2022 10:54 AM, Bjorn Helgaas wrote:
> On Wed, Mar 30, 2022 at 08:54:15AM -0700, Patel, Nirmal wrote:
>> On 3/29/2022 4:27 PM, Dan Williams wrote:
>>> On Tue, Mar 29, 2022 at 3:48 PM Patel, Nirmal
>>> <nirmal.patel@linux.intel.com> wrote:
>>>> On 3/16/2022 8:51 AM, Nirmal Patel wrote:
>>>>> From: Nirmal Patel <nirmal.patel@linux.intel.com>
>>>>>
>>>>> VMD creates and assigns a separate IRQ domain only when MSI remapping is
>>>>> enabled. For example VMD-MSI. But VMD doesn't assign IRQ domain when
>>>>> MSI remapping is disabled resulting child devices getting default
>>>>> PCI-MSI IRQ domain. Now when interrupt remapping is enabled by
>>>>> intel-iommu all the PCI devices are assigned INTEL-IR-MSI domain
>>>>> including VMD endpoints. But devices behind VMD get PCI-MSI IRQ domain
>>>>> when VMD create a root bus and configures child devices.
>>>>>
>>>>> As a result DMAR errors were observed when interrupt remapping was
>>>>> enabled on Intel Icelake CPUs. For instance:
>>>>>
>>>>>   DMAR: DRHD: handling fault status reg 2
>>>>>   DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request
>>>>>
>>>>> Acked-by: Dan Williams <dan.j.williams@intel.com>
>>>>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>>>>> ---
>>>>>  drivers/pci/controller/vmd.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>>>> index cc166c683638..3a6570e5b765 100644
>>>>> --- a/drivers/pci/controller/vmd.c
>>>>> +++ b/drivers/pci/controller/vmd.c
>>>>> @@ -853,6 +853,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>>>>       vmd_attach_resources(vmd);
>>>>>       if (vmd->irq_domain)
>>>>>               dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>>>>> +     else
>>>>> +             dev_set_msi_domain(&vmd->bus->dev, dev_get_msi_domain(&vmd->dev->dev));
>>>>>
>>>>>       vmd_acpi_begin();
>>>>>
>>>> Gentle ping!
>>> It helps to be explicit when you send a patch and a follow-up ping.
>>> Are you asking Lorenzo to take this? Is this urgent such that Bjorn
>>> should consider taking it directly? The changelog notes what happens,
>>> but not the severity of end user visible impact. The merge window is
>>> presently open so the natural inclination is to just wait until that
>>> closes to circle back to outstanding patches.
>> This patch removes a flag that bypasses MSI disable feature of VMD and
>> improves the performance. So it would be nice if the patch gets accepted
>> sooner. I tend to send follow-up ping after a week or so if I do not get any
>> feedback and to allow it to get accepted in time.
> There are only a few days left in the v5.18 merge window, so unless
> it's an emergency, this would be v5.19 material.
>
> This claims to be a v2, but I missed the v1, and the lore archives [1]
> seem incomplete.  Maybe the v1 (and maybe the cover letter?) were HTML
> or got lost for some other reason?
>
> Bjorn
>
> [1] https://lore.kernel.org/all/?q=f%3Anirmal.patel

Initially I created one patch [1] and I was advised to create two separate patches.

[1] https://lore.kernel.org/all/358b0673-f90f-78ca-be66-51d5f76cc42b@linux.intel.com/

