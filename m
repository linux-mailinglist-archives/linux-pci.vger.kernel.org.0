Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A202685F47
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 06:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjBAFvm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Feb 2023 00:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjBAFv2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2023 00:51:28 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EFB5C0C1;
        Tue, 31 Jan 2023 21:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675230672; x=1706766672;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UpSfjG2fNdu4lyj9iOWuaj3VrvjjDLnBYjkh3m1GIYY=;
  b=bDhDx5JL2EYT6kpwcd6cFDytiSiGy1qZT31x0snmB0HJ9fbH+3qIxkAA
   WL854Mp85dLvc1DriAoUmfrddh9tOUSbSSDd0KCCL+ih/UygjCuF0vR6m
   0JXxqqLxiPW7zBiH3sePRpiMa/e7WeY0muof2wyN3d42BH32oQNyyCv7K
   JMM47DI2VnI06+pfEwg/GO+xWkFLk9vY7yhUL/lXKpYygvlgMeptB8TxV
   bsGO80fsQqmUYw50ASgBUgsjtYKAsciX4IVdnAfFjh12sq0AJlDDIkAkP
   HtS/Kv+d/j+YIu75GaqWcgZeU7IckXakYkKS1Cs5RNQj1lvncdhpkakTQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="325754966"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="325754966"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 21:51:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="773302025"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="773302025"
Received: from xduan-mobl1.ccr.corp.intel.com (HELO [10.254.215.167]) ([10.254.215.167])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 21:51:09 -0800
Message-ID: <c15d0137-af02-ab85-70f3-def691d8f81b@linux.intel.com>
Date:   Wed, 1 Feb 2023 13:51:07 +0800
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
References: <20230201001419.GA1776086@bhelgaas>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230201001419.GA1776086@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/2/1 8:14, Bjorn Helgaas wrote:
>> The translated address is specified by the IOMMU driver. The IOMMU
>> driver ensures that the address is a DMA buffer address instead of any
>> P2P address in the PCI fabric. Therefore, any translated memory request
>> will eventually be routed to IOMMU regardless of whether there is ACS
>> control in the up-streaming path.
> A Memory Request with an address that is not a P2P address, i.e., it
> is not contained in any bridge aperture, will*always*  be routed
> toward the RC, won't it? 

Yes.

> Isn't that the case regardless of whether
> the address is translated or untranslated, and even regardless of ACS?

They are different. The translated addresses are approved by the Linux
kernel. But untranslated addresses are not. Malicious or buggy userspace
applications could program the device to DMA to addresses locating in
the P2P aperture.

> IIUC, ACS basically causes peer-to-peer requests to be routed upstream
> instead of directly to the peer.

Yes.

Best regards,
baolu
