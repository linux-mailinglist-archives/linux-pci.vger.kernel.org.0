Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF6D5A3DE5
	for <lists+linux-pci@lfdr.de>; Sun, 28 Aug 2022 15:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiH1N53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Aug 2022 09:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiH1N52 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Aug 2022 09:57:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123C032D8A;
        Sun, 28 Aug 2022 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661695048; x=1693231048;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y4cNfjDDXR16p7aBOCe2GLlX4JBhY0BsBXSjUlii/Og=;
  b=RlBichpN+zQhXtoA6F2lMHFyog/ULZw5Lul/UXMaNEkFclETsPS3jRCx
   3F4Fc6/ZLedbQl83gPOBDjyW8k0B/EVB/TM1Ipq7H2taKC9mmn8dNqReL
   aatRPLUcaqnSjk67s5ySd2mF9amEyFfO02zwPVUQB5OrxkEraJl3O4i0H
   ebbu4/n0VnYNf0E04je6v3TJc903FgkLS8lrJzMjNWj18tEAZtjpxjVPI
   zHcesrMfze3G4+KT7lAjI6hdpSRN471YlhOhPDAxHBPceGemLSRRDG34o
   qEB6/jrRaLyGcxD99xMWE+sIzSFe1RMGxVUwsyKkvbs677I9W9Scpn40/
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="296015609"
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="296015609"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 06:57:27 -0700
X-IronPort-AV: E=Sophos;i="5.93,270,1654585200"; 
   d="scan'208";a="672065818"
Received: from cyue-mobl1.ccr.corp.intel.com (HELO [10.254.209.98]) ([10.254.209.98])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 06:57:23 -0700
Message-ID: <fe5c459e-9992-73b6-35b4-59ef815f1f9a@linux.intel.com>
Date:   Sun, 28 Aug 2022 21:57:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v12 12/17] arm-smmu-v3/sva: Add SVA domain support
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-13-baolu.lu@linux.intel.com>
 <YwjfKsvKyXLdCJ/Z@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YwjfKsvKyXLdCJ/Z@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/8/26 22:56, Jason Gunthorpe wrote:
> On Fri, Aug 26, 2022 at 08:11:36PM +0800, Lu Baolu wrote:
> 
>> +static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
>> +	.set_dev_pasid		= arm_smmu_sva_set_dev_pasid,
> Do we want to permit drivers to not allow a SVA domain to be set on a
> RID?
> 
> It seems like a weird restriction to me

Conceptually as long as the page table is compatible and user pages are
pinned (or I/O page fault is supported), the device drivers are valid to
set SVA domain to a RID. But I don't see a real use case as far as I can
see.

A reasonable use case is sharing EPT between KVM and IOMMU. That demands
a new type of domain and implements its own .set_dev for page table
attachment.

Best regards,
baolu
