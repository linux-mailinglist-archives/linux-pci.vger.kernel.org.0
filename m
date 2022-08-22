Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D46359BA70
	for <lists+linux-pci@lfdr.de>; Mon, 22 Aug 2022 09:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbiHVHnb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Aug 2022 03:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiHVHn3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Aug 2022 03:43:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA47559C;
        Mon, 22 Aug 2022 00:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661154206; x=1692690206;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5F+8Hcgg/FkfZnmb7UcC1acSmNGhXhtbTS0JyylKkzQ=;
  b=D2jE3ZaLmlN+Awv2KXIsyVTA6SPRNOvvvYD9aogr89GT8mRwLZNs8NrS
   rphmkEA+un0VIZkeZTUaxwkdMnZ8TwgapHAKgr8CTvT6FlfMAOfLcgSxK
   pm8K47sxRj0GHxCb/HKvcxBBg8+NVsU5roPg1f9DhJEQq0Yxn4bXGDDEY
   XX4WH+pCNs8SOzwNjzkogOUh6SWLZs5oKviM4F3n7STTB+3PYUwgHAz3S
   x0mOdvi8c2vcBERSUrCsyOGDcbiFzelArAQ9jyEq+QNGX/fvD753aXpHd
   zEmLoahIn5twDljiH3fiACWg1YdZTMZ/2fOKw2gevVF2NXwHl9EMf6c18
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="293345348"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="293345348"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 00:43:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="677118580"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.211.156]) ([10.254.211.156])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 00:43:20 -0700
Message-ID: <3751881a-7478-c1cb-4d77-a9483fbeed83@linux.intel.com>
Date:   Mon, 22 Aug 2022 15:43:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v11 04/13] PCI: Allow PASID only when ACS enforced on
 upstreaming path
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
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
References: <20220818230020.GA2401272@bhelgaas>
From:   Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20220818230020.GA2401272@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


在 2022/8/19 7:00, Bjorn Helgaas 写道:
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
> *should* go upstream to the IOMMU may instead be routed as a P2P
> Request if its address falls in a bridge window.
>
> To ensure that all Memory Requests with PASID are routed upstream,
> only enable PASID if ACS P2P Request Redirect and Upstream Forwarding
> are enabled for the path leading to the device.

Seeing these comments, my questions gone.

Thanks Bjorn !

>> The PCIe fabric routes TLPs based on memory addresses for all PCIe Memory
>> Requests regardless of whether TLPs have PASID prefixes. This is stated in
>> section "2.2.10.2 End-End TLP Prefix Processing" of the specification:
>>
>>    The presence of an End-End TLP Prefix does not alter the routing of a
>>    TLP. TLPs are routed based on the routing rules covered in Section
>>    2.2.4 .
>>
>> As the Requester ID/PASID combination forms a distinct address space. The
>> memory address based routing is not compatible for PASID TLPs anymore.
>> Therefore we have to rely on ACS to override that default.
>>
>> This enhances pci_enable_pasid() interface by requiring the ACS features
>> to be enabled for the entire path leading to the device. So that even if
>> the TLP looks like a P2P Request because its memory address (ignoring the
>> PASID) would fall in a bridge window and would normally be routed
>> downstream.
>>
>> Best regards,
>> baolu

-- 
"firm, enduring, strong, and long-lived"

