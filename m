Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB88765E919
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 11:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjAEKiV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 05:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjAEKh6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 05:37:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2F240846;
        Thu,  5 Jan 2023 02:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672915076; x=1704451076;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gjl8ZM8i09/OJywBgKdXkKMYg3xJWeKujz7bT+uBzmg=;
  b=S04rYYAtV4pD2z2/LbeNS3Zskuif3GqUoeMXfNv//Bg+AvEOaXIu9k3X
   dnsWHTwmBNHI0xM6b7YRS5Din+LI8JOAIEdw5GCoKEXGu50CG+x2rh0eL
   Dt9kXB7tvbcaD3owyCbg+g3FBxJ7Wh4CkQjkCE02//opVhpUW65rhJk+7
   GjYdE5vlMyU2+jWZbomiXnKFo9vS3Gt5kPNYZVhwlfnG9CU8gWIdPea27
   s4WYJqdE+9izbVex4ozobJUb/tdb61bwd+RjzI30BXOVfhaBJMYiWskgB
   7MUlxnGuMx21kqBTCibW+TwlYGCA4TePAAFbYC5L41V11abV4wg4FQj1i
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="323403225"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="323403225"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 02:37:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="686069531"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="686069531"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.114]) ([10.254.211.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 02:37:53 -0800
Message-ID: <6b5baa30-c218-0845-d6c2-32ac21ed6a6d@linux.intel.com>
Date:   Thu, 5 Jan 2023 18:37:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
To:     Vasant Hegde <vasant.hegde@amd.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/1/5 18:27, Vasant Hegde wrote:
> On 1/5/2023 6:39 AM, Matt Fagnani wrote:
>> I built 6.2-rc2 with the patch applied. The same black screen problem happened
>> with 6.2-rc2 with the patch. I tried to use early kdump with 6.2-rc2 with the
>> patch twice by panicking the kernel with sysrq+alt+c after the black screen
>> happened. The system rebooted after about 10-20 seconds both times, but no kdump
>> and dmesg files were saved in /var/crash. I'm attaching the lspci -vvv output as
>> requested.
>>
> Thanks for testing. As mentioned earlier I was not expecting this patch to fix
> the black screen issue. It should fix kernel warnings and IOMMU page fault
> related call traces. By any chance do you have the kernel boot logs?
> 
> 
> @Baolu,
>    Looking into lspci output, it doesn't list ACS feature for Graphics card. So
> with your fix it didn't enable PASID and hence it failed to boot.

So do you mind telling why does the PASID need to be enabled for the
graphic device? Or in another word, what does the graphic driver use the
PASID for?

--
Best regards,
baolu
