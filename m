Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB97B598281
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 13:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239900AbiHRLxZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 07:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiHRLxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 07:53:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B91182F;
        Thu, 18 Aug 2022 04:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660823602; x=1692359602;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2oo9+eUa/OwSNZWYaUh6s8R3NFydHWFrEpTf+pJFEhA=;
  b=H9E6RpE/HaEzJtLqFAP/Uzp2PtDQKpnffJ0ta4Z7Dupdmq4D+SMJXtth
   DCUuTvNKjS8TXM4nJg88F+SFK45zNeNk7bDxls2IgSQaPk4UNHXDPmgYW
   JS+Oaf4Fun9QyKDvc5QZWX3wV1avQVF1+tcPEq4Z2i4hbU9KDEJ1KBg7z
   E6IAS+Blgtp/l60N8FmKE+mvt1bZZifabXyRi1JyIx8nMdfXzx3vFydfQ
   KGqD/ST1IllE5gJCH7cSCJZ4Ln+8Ra5LFCdUR2C4F9ypQ9bBI0d5kLIj0
   cLhH7KMzgGhz+lySMBUgXZkRWY7hyv+AU+EyALpcmVaYj+fZt23H7zo7S
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="279703297"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="279703297"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 04:53:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="668071773"
Received: from gaoshunl-mobl.ccr.corp.intel.com (HELO [10.254.209.211]) ([10.254.209.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 04:53:17 -0700
Message-ID: <cf4399d3-ee71-b209-4996-12e9a5ffe118@linux.intel.com>
Date:   Thu, 18 Aug 2022 19:53:15 +0800
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
References: <20220817211743.GA2274788@bhelgaas>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220817211743.GA2274788@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 2022/8/18 05:17, Bjorn Helgaas wrote:
> On Wed, Aug 17, 2022 at 09:20:15AM +0800, Lu Baolu wrote:
>> Some configurations of the PCI fabric will route device originated TLP
>> packets based on the memory addresses.
> This makes it sound like a few unusual configurations will route TLPs
> based on memory addresses, but address routing is the default for all
> PCIe Memory Requests, and ACS provides a way to override that default.
> 
>> These configurations are incompatible with PASID as the PASID
>> packets form a distinct address space.
> I would say "the Requester ID/PASID combination forms a distinct
> address space."
> 
>> For instance, any configuration where switches are present
>> without ACS enabled is incompatible.
>>
>> This enhances the pci_enable_pasid() interface by requiring the ACS to
>> support Source Validation, Request Redirection, Completer Redirection,
>> and Upstream Forwarding. This effectively means that devices cannot
>> spoof their requester ID, requests and completions cannot be redirected,
>> and all transactions are forwarded upstream, even as it passes through a
>> bridge where the target device is downstream.
> I think your patch actually requires all those features to be not just
> "supported" but actually*enabled*  for the entire path leading to the
> device.
> 
> To use the terms from the spec:
> 
>    "P2P Request Redirect"
>    "P2P Completion Redirect"
>    "Requester ID, Requests, and Completions"
> 
> and maybe something like:
> 
>    ... even if the TLP looks like a P2P Request because its memory
>    address (ignoring the PASID) would fall in a bridge window and would
>    normally be routed downstream.

Thank you for the suggestions. I will rephrase the commit message
accordingly like this:


PCI: Allow PASID only when ACS enforced on upstreaming path

The PCIe fabric routes TLPs based on memory addresses for all PCIe Memory
Requests regardless of whether TLPs have PASID prefixes. This is stated in
section "2.2.10.2 End-End TLP Prefix Processing" of the specification:

   The presence of an End-End TLP Prefix does not alter the routing of a
   TLP. TLPs are routed based on the routing rules covered in Section
   2.2.4 .

As the Requester ID/PASID combination forms a distinct address space. The
memory address based routing is not compatible for PASID TLPs anymore.
Therefore we have to rely on ACS to override that default.

This enhances pci_enable_pasid() interface by requiring the ACS features
to be enabled for the entire path leading to the device. So that even if
the TLP looks like a P2P Request because its memory address (ignoring the
PASID) would fall in a bridge window and would normally be routed
downstream.

Best regards,
baolu
