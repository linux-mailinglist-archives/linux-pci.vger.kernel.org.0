Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DDA6873A6
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 04:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjBBDIn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Feb 2023 22:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBBDIm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2023 22:08:42 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77ED17CF3;
        Wed,  1 Feb 2023 19:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675307320; x=1706843320;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zUY6IOKlXEmYG2uGOi4Zhlu9bmG0tB+UXRTllSX1/r8=;
  b=fu89/azRBl3FxLgYuV+IxLHFb7lAUcqZfDDlFJUXDVhGgO2Hx3Numldk
   9U2GKfLI9wFDkLxrpQpkevVrZYWMxto8qDRYKh5fjxkLEaoCPzyLpgkLv
   mouIfnzPsoBQ5BTQuxrj1Ns83YOJPdCnjFujoXxbt3nMTQ/oODEFfyXMS
   XaBjXNLCJSORN0iYUQJxdh3CZmQ65pM0ZbYk4jrvhgZHvZI4ydqELb/wO
   syOBgulbZeQIWEXx9hYB4mw8pVFv2a2Nvv+egrRRGK1Ozj/mcawtfjbqw
   NZEWUN7HciqDLEJTzNLetO6pt2RTPOmT0zdzMPCEqHFC0FfPkpnYMDdr5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="326038152"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="326038152"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 19:08:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="667138999"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="667138999"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.29.248]) ([10.255.29.248])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 19:08:27 -0800
Message-ID: <b75a5a94-a962-f88e-149e-7d23982a7ad2@linux.intel.com>
Date:   Thu, 2 Feb 2023 11:08:25 +0800
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
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20230201165852.GA1775862@bhelgaas>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230201165852.GA1775862@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/2/2 0:58, Bjorn Helgaas wrote:
> On Tue, Jan 31, 2023 at 08:25:05PM +0800, Baolu Lu wrote:
>> On 2023/1/31 2:38, Bjorn Helgaas wrote:
>>> PCIe r6.0, sec 6.20.1:
>>>
>>>     A Function is not permitted to generate Requests using Translated
>>>     Addresses and a PASID unless both PASID Enable and Translated
>>>     Requests with PASID Enable are Set.
>>>
>>> You want AMD graphics devices to do DMA with translated addresses and
>>> PASID, right?  pci_enable_pasid() sets PASID Enable
>>> (PCI_PASID_CTRL_ENABLE), but I don't see where "Translated Requests
>>> with PASID Enable" is set.  We don't even have a #define for it.
>>>
>>> I would think we should check "Translated Requests with PASID
>>> Supported" before setting "Translated Requests with PASID Enable",
>>> too?
>> This seems to be an ECN for PCIe 5.x:
>>
>> https://members.pcisig.com/wg/PCI-SIG/document/14929
>>
>> What I read from this ECN is that,
>>
>> With this ECN, translated memory requests for PASIDs are not allowed to
>> carry a PASID prefix if "Translated Requests with PASID Enabled" is not
>> set. It does not mean whether the device can generate translated memory
>> requests for PASID, but whether the memory request can carry a PASID
>> prefix.
> My assumption that "you want AMD graphics devices to do DMA with
> translated addresses and PASID" was wrong.
> 
> Per Jason [1], it sounds like the AMD GPU generates Translation
> Requests (sec 10.2.2) with a PASID.  The GPU will cache the translated
> address from the Translation Completion in its local ATC, and will do
> DMA (MemRd/Wr) with that translated address but*without*  PASID
> prefixes.
> 
> That makes sense because (PASID, IOVA) maps to a translated address,
> e.g., a a CPU physical address, and the GPU can DMA to that address
> directly without needing the PASID.

Hi Bjorn and Jason,

According to the discussion so far, I refined the commit message like
below.  How does it look like?

PCI: Add translated request only flag for pci_enable_pasid()

The PCIe fabric routes Memory Requests based on the TLP address, ignoring
the PASID. In order to prevent Memory Requests for PASID, which should
always be routed to the RC, from being mistakenly routed as peer-to-peer
requests, commit 201007ef707a ("PCI: Enable PASID only when ACS RR & UF
enabled on upstream path") requires some ACS features being supported on
device's upstream path when enabling PCI/PASID.

However, above change causes the Linux kernel boots to black screen on a
system with below graphic device:

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
         [AMD/ATI] Wani [Radeon R5/R6/R7 Graphics] (rev ca)
         (prog-if 00 [VGA controller])
         DeviceName: ATI EG BROADWAY
         Subsystem: Hewlett-Packard Company Device 8332

The AMD iommu driver allocates a special domain for above device and
enables its PCI PASID/ATS/PRI before attaching the domain to it. The
failure of pci_enable_pasid() due to lack of ACS causes the domain
to fail to be attached to the device. The GPU device is unable to DMA
normally, resulting in a black screen of the system.

The PCIe spec defines Address Translation Service in its chapter 10.
A PCIe Function may contain an ATC. If the ATC Capability Enable bit
is set, the Function can issue Translation Requests. The TA (aka IOMMU)
will respond with a Translation Completion. If the Completion is a CplD,
it contains the translated address and the Function can store the entry
in its ATC. If the TA doesn't have a mapping with the desired permissions,
and the Function's Page Request Capability Enable bit is set, it may
issue a Page Request Message. It's up to the TA to make this message
visible to the OS, which can make the page resident, create an IOMMU
mapping, and respond with a PRG Response Message.  After the Function
receives the PRG Response Message, it would issue another Translation
Request. The Function can then obtain a translated address and store the
entry in its ATC.

The AMD integrated GPU together with its dedicated IOMMU implements above
functionality. It generates Translation Requests (sec 10.2.2) with a PASID
and caches the translated address from the Translation Completion in its
local ATC, and will do DMA (MemRd/Wr) with that translated address without
PASID prefixes. This capability (using translated address for PASID memory
requests) could be detected by software from AMD IOMMU feature bits (GTSup:
Guest translations supported" and PPRSup: Peripheral page request support).

ACS is unnecessary for the devices that only use translated memory request
for PASID. All translated addresses are granted by the Linux kernel which
ensures that such addresses will never be in a P2P address, i.e., it's not
contained in any bridge aperture, will *always* be routed toward the RC.

Add a flag for pci_enable_pasid(), with which the drivers could opt-in
the fact that device always uses translated memory requests for PASID
hence the ACS is not a necessity. Apply this opt-in for above AMD graphic
device.

At present, it is a common practice to enable/disable PCI PASID in the
iommu drivers. Considering that the device driver knows more about the
specific device, it is recommended to move pci_enable_pasid() into the
specific device drivers.

Fixes: 201007ef707a ("PCI: Enable PASID only when ACS RR & UF enabled on 
upstream path")
Reported-and-tested-by: Matt Fagnani <matt.fagnani@bell.net>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
Link: 
https://lore.kernel.org/r/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

--
Best regards,
baolu
