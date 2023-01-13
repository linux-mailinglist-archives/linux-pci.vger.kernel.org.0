Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A16766894C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 02:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjAMB40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 20:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjAMB4Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 20:56:25 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E49A62F9;
        Thu, 12 Jan 2023 17:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673574984; x=1705110984;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yvASKDHwILgtst84ENqUbJ1Kti8pnA3VwnnU1NdHEAo=;
  b=jkoJqhpDEQ6vbIiTS4B0XPDZ4nnEU/L+bnfFQkrdkHMwerBqCgvTlmUw
   71Zq3VHSU7THdsI+9/W1VwsLUpbzF14PQ65CsjfFd9m0WL5fPVqjxE9Ze
   PJs6rQG4kRFzvz/pST6gia8l3RclYKLlkH+tC4aP4M3O2nkFG8AqZ+DeA
   TEI8p/MLSv3uiDC068TTnow5Ij9SER2sM9KjzEDIgrkLS8aF7saNhjrwL
   6Wef4vfS6ONsgxp6x3L+2P0nSDjlMYnhLn03nKLQZ4NiFXbWLP2JSBPai
   YGMHFpncdovkol0PO/DxTd/dGv7vtS4crKLPlSS7pl1f1ZMem+DFWiY5B
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="307437823"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="307437823"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 17:56:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="635606264"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="635606264"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.252.189.78]) ([10.252.189.78])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 17:56:19 -0800
Message-ID: <3ae3f5d2-1b58-7498-656d-696182a3589f@linux.intel.com>
Date:   Fri, 13 Jan 2023 09:56:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matt Fagnani <matt.fagnani@bell.net>
Subject: Re: [PATCH 1/1] PCI: Add translated request only opt-in for
 pci_enable_pasid()
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20230112183422.GA1778973@bhelgaas>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230112183422.GA1778973@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/1/13 2:34, Bjorn Helgaas wrote:
> On Thu, Jan 12, 2023 at 09:25:25PM +0800, Baolu Lu wrote:
>> On 2023/1/12 20:38, Jason Gunthorpe wrote:
>>> On Thu, Jan 12, 2023 at 04:46:29PM +0800, Lu Baolu wrote:
>>>
>>>> -int pci_enable_pasid(struct pci_dev *pdev, int features);
>>>> +int pci_enable_pasid(struct pci_dev *pdev, int features, bool
>>>> transled_only);
>        ^^^^^^^^
> 
>> + * @flags: device-specific flags
>> + *   - PCI_PASID_TRANSLED_REQ_ONLY: The PCI device only issues PASID
>> + *                                  memory requests of translated type.
>                      ^^^^^^^^
> 
> I don't like "transled" since it's not a word itself or an obvious
> combination of "translated" and something else.
> 
> Not sure whether you need to abbreviate it, but if you do, "xlate" is
> a common shortening of "translate".

Yes. "xlate" looks better. I will replace with it.

I've updated this patch with a v2.

https://lore.kernel.org/linux-iommu/20230113014409.752405-1-baolu.lu@linux.intel.com/

Thank you both for the comments.

--
Best regards,
baolu
