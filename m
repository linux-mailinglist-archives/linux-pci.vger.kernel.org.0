Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158E5685FA8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 07:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBAGLw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Feb 2023 01:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBAGLv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2023 01:11:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFAC43938;
        Tue, 31 Jan 2023 22:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675231874; x=1706767874;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fM9aVRyfPZVOiEclQoecEGbZD5Hw0zxzcZoALRhhn+Y=;
  b=J4PzpjlIVPrTSI52X3THdTElIzBPZCQHnOR1FR5HAgz/STgTrre6VGsR
   whDYYHDYGbakNMqzqyqBYhkt5lUo21C5q1I4piz9CqSkJFAuoR3jUleNc
   jj/ARrP5I4peZzRrCuShqSNyizcpQPuzFXyZd9H9TQJ4BHVLpeMcjcXgF
   yPW8BP3QNNpqEP/8T3SW9y7v9NA2NKGDHnULM+hJ/oZ+vOLjWhEZhcLMv
   Okcgziam7kbnboBp6dWG7iq3UNQsZ9PMmMbh5BgaZ/YZuLr/jGit256ZT
   k/esBGfqYgeaO0XrjcrpulWZSIudVvHGxSLBOwXRpa3B06T5guypGqhad
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="392632212"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="392632212"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 21:59:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="697110220"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="697110220"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.167]) ([10.254.215.167])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 21:59:34 -0800
Message-ID: <1e01166f-93eb-c49b-3c0e-c7fb7f927b8a@linux.intel.com>
Date:   Wed, 1 Feb 2023 13:59:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Matt Fagnani <matt.fagnani@bell.net>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] PCI: Add translated request only flag for
 pci_enable_pasid()
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20230201001419.GA1776086@bhelgaas>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230201001419.GA1776086@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/2/1 8:14, Bjorn Helgaas wrote:
> On Tue, Jan 31, 2023 at 08:56:13PM +0800, Baolu Lu wrote:
>> On 2023/1/31 2:38, Bjorn Helgaas wrote:
>>>> PCI: Add translated request only flag for pci_enable_pasid()
>>>>
>>>> The PCIe fabric routes Memory Requests based on the TLP address, ignoring
>>>> the PASID. In order to ensure system integrity, commit 201007ef707a ("PCI:
>>>> Enable PASID only when ACS RR & UF enabled on upstream path") requires
>>>> some ACS features being supported on device's upstream path when enabling
>>>> PCI/PASID.
> 
> Looking up 201007ef707a to see what ensuring system integrity means,
> it prevents Memory Requests with PASID, which should always be routed
> to the RC, from being mistakenly routed as peer-to-peer requests.

Yes, exactly. I will update above paragraph like below

The PCIe fabric routes Memory Requests based on the TLP address, ignoring
the PASID. In order to prevent Memory Requests with PASID, which should
always be routed to the RC, from being mistakenly routed as peer-to-peer
requests, commit 201007ef707a ("PCI: Enable PASID only when ACS RR & UF
enabled on upstream path") requires some ACS features being supported on
device's upstream path when enabling PCI/PASID.


> 
>>>> However, above change causes the Linux kernel boots to black screen on a
>>>> system with below graphic device:
>>>
>>> We need a PCIe concept-level description of the issue first, i.e., in
>>> terms of DMA, PASID, ACS, etc.  Then we can mention the AMD GPU issue
>>> as an instance.
>>
>> How about below description?
> 
> Thanks, this is exactly the sort of thing I'm looking for.  But my
> understanding of ATS/PRI/PASID is weak, so I'm still working through
> this.  Tell me when I say something wrong below...
> 
>> PCIe endpoints can use ATS to request DMA remapping hardware to
>> translate an IOVA to its mapped physical address. If the translation is
>> missing or the permissions are insufficient, the PRI is used to trigger
>> an I/O page fault. The IOMMU driver will fill the mapping with desired
>> permissions and return the translated address to the device.
> 
> In PCIe spec language, I think you're saying that a PCIe Function may
> contain an ATC.  If the ATC Capability Enable bit is set, the Function
> can issue Translation Requests.
> 
> The TA (aka IOMMU) will respond with a Translation Completion.  If the
> Completion is a CplD, it contains the translated address and the
> Function can store the entry in its ATC.  I assume the I/O page fault
> case corresponds to a Cpl (with no data) meaning that the TA could not
> translate the address.
> 
> If the TA doesn't have a mapping with the desired permissions, and the
> Function's Page Request Capability Enable bit is set, it may issue a
> Page Request Message.  It's up to the TA/IOMMU to make this message
> visible to the OS, which can make the page resident, create an IOMMU
> mapping, and enable a PRG Response Message.  After the Function
> receives the PRG Response Message, it would issue another Translation
> Request.
> 
>> The translated address is specified by the IOMMU driver. The IOMMU
>> driver ensures that the address is a DMA buffer address instead of any
>> P2P address in the PCI fabric. Therefore, any translated memory request
>> will eventually be routed to IOMMU regardless of whether there is ACS
>> control in the up-streaming path.
> 
> A Memory Request with an address that is not a P2P address, i.e., it
> is not contained in any bridge aperture, will *always* be routed
> toward the RC, won't it?  Isn't that the case regardless of whether
> the address is translated or untranslated, and even regardless of ACS?
> 
> IIUC, ACS basically causes peer-to-peer requests to be routed upstream
> instead of directly to the peer.
> 
> OK, reading this again, I realize that I just restated exactly what
> you had already written, sorry about that.

Never mind. It's really a good chance for me to learn how to describe
this from the perspective of the PCI subsystem.. :-)

> 
>> AMD GPU is one of those devices.
> 
> I guess you mean the AMD GPU has ATS, PRI, and PASID Capabilities?
> And furthermore, that the GPU *always* uses Translated addresses with
> PASID?
> 
> So I guess what's going on here is that if:
> 
>    - A device only uses PASID with Translated addresses, and
>    - those Translated addresses are never P2P addresses, then
>    - those transactions will always be routed to the RC.
> 
> And this applies even if there is no ACS or ACS doesn't support
> PCI_ACS_RR and PCI_ACS_UF.

Yes.

> 
> The black screen happens because ... ?
> 
> What can we include in the commit log to help people find this fix?  I
> see these in the bugzilla:
> 
>    WARNING: CPU: 0 PID: 477 at drivers/pci/ats.c:251 pci_disable_pri+0x75/0x80
>    WARNING: CPU: 0 PID: 477 at drivers/pci/ats.c:419 pci_disable_pasid+0x45/0x50
> 
> (These look like defects in pdev_pri_ats_enable(), so really just
> distractions)
> 
>    kfd kfd: amdgpu: Failed to resume IOMMU for device 1002:9874
>    kfd kfd: amdgpu: device 1002:9874 NOT added due to errors
>    BUG: kernel NULL pointer dereference, address: 0000000000000058
>    RIP: 0010:report_iommu_fault+0x11/0x90
> 
> I couldn't figure out the NULL pointer dereference.  I expected it to
> be from a BUG() or similar in report_iommu_fault(), but I don't see
> that.

Above has been answered by Vasant Hegde in a separated reply.

Best regards,
baolu

