Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118986638C9
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 06:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjAJFtx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 00:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjAJFss (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 00:48:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11216BF79;
        Mon,  9 Jan 2023 21:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673329724; x=1704865724;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IuHLZ4WVkKQcNvRsuMTjdY+Uf9AX+xfLbFUYiB9ITYM=;
  b=nZ83rCHT0tQ+PAwns/1a7LNqar+/JLs4DWb8GDrRQU9b2Niav+0tkJAB
   z2haFrotRuLr+lxCxQkjv/PPL7Ik+2D2OKGFeKUgGrd8sA/iKQuR9liZb
   Om04O9V5FcT5s0lMjNSDIlXnsEdBBrpp5JXbv/QvJxj0IleSVFNWdy8qY
   I4OYZDU+iNbgdAwJtwyLQdSp+b+ZLhXr28JjOa/mU5d82Fb8EGTSFereD
   5uWItJWq6QzGf2qOMsCOUjQX/bC1qUIrOYNGup3J/5D8RdjZSMaypbTYv
   9X1jhA7H4aS3utNEm/GWV4792QR8t8laFn0pzy1P7YZQbv2T31V1YnOmh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350289026"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="350289026"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:48:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="764601179"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="764601179"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.165]) ([10.254.212.165])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 21:48:41 -0800
Message-ID: <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
Date:   Tue, 10 Jan 2023 13:48:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Vasant Hegde <vasant.hegde@amd.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com> <Y7gs0zYKp/VXACBi@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y7gs0zYKp/VXACBi@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/1/6 22:14, Jason Gunthorpe wrote:
> On Thu, Jan 05, 2023 at 03:57:28PM +0530, Vasant Hegde wrote:
>> Matt,
>>
>> On 1/5/2023 6:39 AM, Matt Fagnani wrote:
>>> I built 6.2-rc2 with the patch applied. The same black screen problem happened
>>> with 6.2-rc2 with the patch. I tried to use early kdump with 6.2-rc2 with the
>>> patch twice by panicking the kernel with sysrq+alt+c after the black screen
>>> happened. The system rebooted after about 10-20 seconds both times, but no kdump
>>> and dmesg files were saved in /var/crash. I'm attaching the lspci -vvv output as
>>> requested.
>>>
>> Thanks for testing. As mentioned earlier I was not expecting this patch to fix
>> the black screen issue. It should fix kernel warnings and IOMMU page fault
>> related call traces. By any chance do you have the kernel boot logs?
>>
>>
>> @Baolu,
>>    Looking into lspci output, it doesn't list ACS feature for Graphics card. So
>> with your fix it didn't enable PASID and hence it failed to boot.
> The ACS checks being done are feature of the path not the end point or
> root port.
> 
> If we are expecting ACS on the end port then it is just a bug in how
> the test was written.. The test should be a NOP because there are no
> switches in this topology.
> 
> Looking at it, this seems to just be because pci_enable_pasid is
> calling pci_acs_path_enabled wrong, the only other user is here:
> 
> 	for (bus = pdev->bus; !pci_is_root_bus(bus); bus = bus->parent) {
> 		if (!bus->self)
> 			continue;
> 
> 		if (pci_acs_path_enabled(bus->self, NULL, REQ_ACS_FLAGS))
> 			break;
> 
> 		pdev = bus->self;
> 
> 		group = iommu_group_get(&pdev->dev);
> 		if (group)
> 			return group;
> 	}
> 
> And notice it is calling it on pdev->bus not on pdev itself which
> naturally excludes the end point from the ACS validation.
> 
> So try something like:
> 
> 	if (!pci_acs_path_enabled(pdev->bus->self, NULL, PCI_ACS_RR | PCI_ACS_UF))
> 
> (and probably need to check for null ?)

Hi Matt,

Do you mind helping to test below change? No other change needed.

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index f9cc2e10b676..48f34cc996e4 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -382,8 +382,15 @@ int pci_enable_pasid(struct pci_dev *pdev, int 
features)
         if (!pasid)
                 return -EINVAL;

-       if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
-               return -EINVAL;
+       if (pdev->multifunction) {
+               if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | 
PCI_ACS_UF))
+                       return -EINVAL;
+       } else {
+               if (!pdev->bus->self ||
+                   !pci_acs_path_enabled(pdev->bus->self, NULL,
+                                         PCI_ACS_RR | PCI_ACS_UF))
+                       return -EINVAL;
+       }

         pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
         supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;

--
Best regards,
baolu
