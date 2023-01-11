Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43830665230
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 04:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjAKDQq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 22:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjAKDQk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 22:16:40 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD60AC769;
        Tue, 10 Jan 2023 19:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673406999; x=1704942999;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eiUGacdelBh6i4MLgLO5PEcQ0q58R3cpUTNNPuRjubk=;
  b=mixy8TKW2cbGVTayGXAHNT5gTiRq6DxI1/WeyORvGUEl6UZNMhGHsm9+
   c7ZAu93nM6Z2lL7fJfg4J16TE7RheVbh3uFs+zPk4qPVA+MBkFW+cXNR/
   Ns+BvGbiqBQ9bakrQ/b/A6MLCy7ij6bInaZtdwu43/42EISq0JydirY/+
   0xHN0vVKD3oSA+kSETX/DfXQHvPUU58mnCCeyB3bHlq96chtLWf3ocQT5
   oYfrQoAqfPOKoYXMRT1eMsuCNGcpa8nEK3rRs0M9v7KY4sV3xula9iVbU
   LsnwY19/a44tKUlkCwN397oiJoxFIn97V+Qb+VtYtz1dEVMXr3azp5RPV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303688159"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303688159"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 19:16:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607206515"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="607206515"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.252.188.177]) ([10.252.188.177])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 19:16:35 -0800
Message-ID: <7c2af186-5868-d962-f810-ef810fbd074c@linux.intel.com>
Date:   Wed, 11 Jan 2023 11:16:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Vasant Hegde <vasant.hegde@amd.com>,
        Matt Fagnani <matt.fagnani@bell.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        amd-gfx@lists.freedesktop.org
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com> <Y7gs0zYKp/VXACBi@nvidia.com>
 <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
 <Y71nZuF5wQp3eqmn@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y71nZuF5wQp3eqmn@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/1/10 21:25, Jason Gunthorpe wrote:
>> +       } else {
>> +               if (!pdev->bus->self ||
>> +                   !pci_acs_path_enabled(pdev->bus->self, NULL,
>> +                                         PCI_ACS_RR | PCI_ACS_UF))
>> +                       return -EINVAL;
>> +       }
> Why would these be exclusive? Both the path and endpoint needs to be
> checked

If the device is not an MFD, do we still need to check the ACS on it?
Perhaps I didn't get your point correctly.

--
Best regards,
baolu
