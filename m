Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6859D1B8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 09:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiHWHGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 03:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239814AbiHWHGV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 03:06:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E379E6112F;
        Tue, 23 Aug 2022 00:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661238380; x=1692774380;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2adFR0X7/dPlReestSB7DuXWGZcuS9kgjKJkDTUPHG4=;
  b=DGcPlqnloLTUdGedRW+MEi1J7LTMFgpCDrKK8GBIjLWWr/56UXr+NkH7
   8RvbAc19e01YtHPX251fT2czLXW4f046qfb+AmhitGlqYbBtP82uKutMs
   Nbjvx2fNuLEEzbPrr2Az78GNO4UuCMVUi2JRZ8kKy0nd4ZsTZELQ9lFTS
   N2C8wgIIJWGf2caklU9XFFKmsHGE6wO69dJU7b22fDSGYvCTWwh4yeMl6
   OKyxDJ2l6v2fal7KT9iyPvCnRoQEctokJfxnGzeEk2ekdTAh1RSYa1KFx
   d29Lzp+FeEzEcmCDv8nqsQ7n7G6H42FEkXCQaJhuoPLn6m8eLy3lRjChV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="273363442"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="273363442"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:06:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="642336552"
Received: from xujinlon-mobl.ccr.corp.intel.com (HELO [10.254.211.102]) ([10.254.211.102])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 00:05:56 -0700
Message-ID: <35517add-de1c-f62a-aca2-8a627854e296@linux.intel.com>
Date:   Tue, 23 Aug 2022 15:05:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 04/13] PCI: Allow PASID only when ACS enforced on
 upstreaming path
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20220818230020.GA2401272@bhelgaas>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220818230020.GA2401272@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/8/19 07:00, Bjorn Helgaas wrote:
> On Thu, Aug 18, 2022 at 07:53:15PM +0800, Baolu Lu wrote:
>> On 2022/8/18 05:17, Bjorn Helgaas wrote:
>>> On Wed, Aug 17, 2022 at 09:20:15AM +0800, Lu Baolu wrote:
>>>> Some configurations of the PCI fabric will route device originated TLP
>>>> packets based on the memory addresses.
>>> This makes it sound like a few unusual configurations will route TLPs
>>> based on memory addresses, but address routing is the default for all
>>> PCIe Memory Requests, and ACS provides a way to override that default.
>>>
>>>> These configurations are incompatible with PASID as the PASID
>>>> packets form a distinct address space.
>>> I would say "the Requester ID/PASID combination forms a distinct
>>> address space."
>>>
>>>> For instance, any configuration where switches are present
>>>> without ACS enabled is incompatible.
>>>>
>>>> This enhances the pci_enable_pasid() interface by requiring the ACS to
>>>> support Source Validation, Request Redirection, Completer Redirection,
>>>> and Upstream Forwarding. This effectively means that devices cannot
>>>> spoof their requester ID, requests and completions cannot be redirected,
>>>> and all transactions are forwarded upstream, even as it passes through a
>>>> bridge where the target device is downstream.
>>> I think your patch actually requires all those features to be not just
>>> "supported" but actually*enabled*  for the entire path leading to the
>>> device.
>>>
>>> To use the terms from the spec:
>>>
>>>     "P2P Request Redirect"
>>>     "P2P Completion Redirect"
>>>     "Requester ID, Requests, and Completions"
>>>
>>> and maybe something like:
>>>
>>>     ... even if the TLP looks like a P2P Request because its memory
>>>     address (ignoring the PASID) would fall in a bridge window and would
>>>     normally be routed downstream.
>> Thank you for the suggestions. I will rephrase the commit message
>> accordingly like this:
>>
>>
>> PCI: Allow PASID only when ACS enforced on upstreaming path
> PCI: Enable PASID only when ACS RR & UF enabled on upstream path
> 
> The Requester ID/Process Address Space ID (PASID) combination
> identifies an address space distinct from the PCI bus address space,
> e.g., an address space defined by an IOMMU.
> 
> But the PCIe fabric routes Memory Requests based on the TLP address,
> ignoring any PASID (PCIe r6.0, sec 2.2.10.4), so a TLP with PASID that
> *should*  go upstream to the IOMMU may instead be routed as a P2P
> Request if its address falls in a bridge window.
> 
> To ensure that all Memory Requests with PASID are routed upstream,
> only enable PASID if ACS P2P Request Redirect and Upstream Forwarding
> are enabled for the path leading to the device.

Yours is clear and straight-forward. I will update the patch with above.
Thank you and very appreciated!

Best regards,
baolu
