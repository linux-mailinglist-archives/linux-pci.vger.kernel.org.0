Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D17E4EC8E0
	for <lists+linux-pci@lfdr.de>; Wed, 30 Mar 2022 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348470AbiC3P4J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348452AbiC3P4C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 11:56:02 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8F4F10
        for <linux-pci@vger.kernel.org>; Wed, 30 Mar 2022 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648655656; x=1680191656;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sVm5Ue2RAz56yEjxaLIp4iJJ7slg1TCueqmiBDMpfz4=;
  b=POzDpR2vy2kFSzT1oPF3X1GJPCMYUbQPQaLWLb69RhKWUPdJQ8Vg940z
   g2KogUdQ4lB0nv/4wky1f+A/cnZ3QLZUNba8S7lzcQ0I6hKrxtQNqXeCZ
   989q5SBCInSoyk9nkBe85xA7FPN70TpuaHDfpQnK/TYS4ILlqD5L5mDjS
   IX7WoNHHZBhqR8h5fV/zyQuMyeERmm8DxD7SAXN3cSxMXKWGFyc0F+YBr
   40B5r1VSIMOygtjYZ2y06ZGQKjPwSRbJpqoBHb5Mp1QMyqB3vBhBJUoA/
   4bvVbLcRlP2KUPOubMs1c0d31JbGCvAOwA/r7Hw/KYgj2i14LFJwjgQe/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="320274698"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="320274698"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:54:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="546911809"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.212.117.191]) ([10.212.117.191])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 08:54:16 -0700
Message-ID: <202db6b1-5b66-8f37-ba06-7456326f2cf6@linux.intel.com>
Date:   Wed, 30 Mar 2022 08:54:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] PCI: vmd: Assign VMD IRQ domain before enumeration
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@linux.dev>,
        Nirmal Patel <nirmal.patel@intel.com>
References: <20220316155103.8415-1-nirmal.patel@intel.com>
 <6b2b0c52-4b01-db11-1c89-ab291ae633b3@linux.intel.com>
 <CAPcyv4hUVZEXyEW0C5rU5rkyMwBYbc4-Pq7A7aMz0GQr8d7NoA@mail.gmail.com>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <CAPcyv4hUVZEXyEW0C5rU5rkyMwBYbc4-Pq7A7aMz0GQr8d7NoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/29/2022 4:27 PM, Dan Williams wrote:
> On Tue, Mar 29, 2022 at 3:48 PM Patel, Nirmal
> <nirmal.patel@linux.intel.com> wrote:
>> On 3/16/2022 8:51 AM, Nirmal Patel wrote:
>>> From: Nirmal Patel <nirmal.patel@linux.intel.com>
>>>
>>> VMD creates and assigns a separate IRQ domain only when MSI remapping is
>>> enabled. For example VMD-MSI. But VMD doesn't assign IRQ domain when
>>> MSI remapping is disabled resulting child devices getting default
>>> PCI-MSI IRQ domain. Now when interrupt remapping is enabled by
>>> intel-iommu all the PCI devices are assigned INTEL-IR-MSI domain
>>> including VMD endpoints. But devices behind VMD get PCI-MSI IRQ domain
>>> when VMD create a root bus and configures child devices.
>>>
>>> As a result DMAR errors were observed when interrupt remapping was
>>> enabled on Intel Icelake CPUs. For instance:
>>>
>>>   DMAR: DRHD: handling fault status reg 2
>>>   DMAR: [INTR-REMAP] Request device [0xe2:0x00.0] fault index 0xa00 [fault reason 0x25] Blocked a compatibility format interrupt request
>>>
>>> Acked-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>>> ---
>>>  drivers/pci/controller/vmd.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>> index cc166c683638..3a6570e5b765 100644
>>> --- a/drivers/pci/controller/vmd.c
>>> +++ b/drivers/pci/controller/vmd.c
>>> @@ -853,6 +853,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>>       vmd_attach_resources(vmd);
>>>       if (vmd->irq_domain)
>>>               dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>>> +     else
>>> +             dev_set_msi_domain(&vmd->bus->dev, dev_get_msi_domain(&vmd->dev->dev));
>>>
>>>       vmd_acpi_begin();
>>>
>> Gentle ping!
> It helps to be explicit when you send a patch and a follow-up ping.
> Are you asking Lorenzo to take this? Is this urgent such that Bjorn
> should consider taking it directly? The changelog notes what happens,
> but not the severity of end user visible impact. The merge window is
> presently open so the natural inclination is to just wait until that
> closes to circle back to outstanding patches.

This patch removes a flag that bypasses MSI disable feature of VMD and
improves the performance. So it would be nice if the patch gets accepted
sooner. I tend to send follow-up ping after a week or so if I do not get any
feedback and to allow it to get accepted in time.

Thanks.

