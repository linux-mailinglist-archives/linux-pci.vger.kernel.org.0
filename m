Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F465982BE
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 13:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244498AbiHRL4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 07:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244275AbiHRLzs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 07:55:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5AA956A3;
        Thu, 18 Aug 2022 04:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660823746; x=1692359746;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DD+pip86U2bqu7K4Tuuk0WgzgcsZjPfeOIsmlcT149M=;
  b=cFh9pzsCTkgchIZ96O7YPny8ZYHqRe5RektcbWhPBpniuWsCnIpPgdRP
   4E8eYjwlJCExgpAXFxTOPBFxwiIStiQTWJFH1ILbRTBP5ADEk1mRrvzHu
   QzmLBzHjTOrYQHqPODHUnLC2MSUDB865ZwjdDueGxItJDspKeTJ4mhLXb
   bYDvp5X3vFtqOwN9bFZ1KwPYwOOatWjAIy7ArCI+K+cr2ANrWzqklob+R
   z5ttcS+PXOuGxciPZ6VLMiZayT5O5E8CRFTP9lpt9784AV/P2btyzsneW
   i9TIESa9gp1pb92jH6g8sxno/WfQP19zEXup7PgZ9hz/iO5+ilKZPxLlz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="273130053"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="273130053"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 04:55:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="668072477"
Received: from gaoshunl-mobl.ccr.corp.intel.com (HELO [10.254.209.211]) ([10.254.209.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 04:55:29 -0700
Message-ID: <c0de76f1-6b8e-2fc0-a7e7-5d2c29df4509@linux.intel.com>
Date:   Thu, 18 Aug 2022 19:55:28 +0800
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
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>
References: <20220817012024.3251276-5-baolu.lu@linux.intel.com>
 <20220817211743.GA2274788@bhelgaas> <Yv1wVfCWHnTdvPOc@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yv1wVfCWHnTdvPOc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/8/18 06:48, Jason Gunthorpe wrote:
> On Wed, Aug 17, 2022 at 04:17:43PM -0500, Bjorn Helgaas wrote:
> 
>> Does the PCIe spec really allow TLPs with PASID to be routed anywhere
>> except upstream?
> I think yes:
> 
>   2.2.10.2 End-End TLP Prefix Processing:
> 
>   The presence of an End-End TLP Prefix does not alter the routing of a
>   TLP. TLPs are routed based on the routing rules covered in Section
>   2.2.4 .
> 
> Which I read as saying that routing is done after stripping all the
> prefixes. PASID is a prefix.
> 
> Lu, you may want to quote the spec in the commit message to make it
> clear.

Yes. Sure thing. Thank you!

Best regards,
baolu
