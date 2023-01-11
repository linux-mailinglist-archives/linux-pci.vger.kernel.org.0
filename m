Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8455665D1E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 14:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbjAKNyy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 08:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbjAKNyM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 08:54:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E656715731
        for <linux-pci@vger.kernel.org>; Wed, 11 Jan 2023 05:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673445248; x=1704981248;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d0N5efhBe9eZAqc5Mzg+kTtfczo9Bb7/VGtKC5HAupI=;
  b=j/KjplirlSjiMBKtqWTwlrJ/7jnSUiSDxzir5Hem1esoFjUGJhjudtBm
   gZYWpbLQSWOb2CQtTlZZLeValMQvgajsP1cAQzZdwb+CVYrTEvisOwF3O
   NYlifunxfwS6mdjPfrh2482ShkGLaLe48ojwDAtJfiKuoVsx/BYJPElte
   xvnA1j3dCyeufgEiPJjd6fSBvvHd9YIUFhIE1qe430QE3DvxFtRcNM5Ca
   8KaCIOGahAMKDpg/t1wT6jJAwBDPqqwfAEti+8qEsc9KCCpGipdc0Faa9
   SUZeRo6pY+T652KQ+890MXQKjyrlG1paBNJJ4DKlJBNv+6qQ/Kh8CD8i4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303114542"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303114542"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:54:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659379648"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="659379648"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.187.190]) ([10.252.187.190])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:54:05 -0800
Message-ID: <38a7baf4-9b3b-154b-f764-fa8cfa600858@linux.intel.com>
Date:   Wed, 11 Jan 2023 21:54:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-pci@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tony Zhu <tony.zhu@intel.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] PCI: revert "Enable PASID only when ACS RR & UF enabled
 on upstream path"
To:     Jason Gunthorpe <jgg@nvidia.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230111085745.401710-1-christian.koenig@amd.com>
 <Y760hRDQbXRlc2Yz@nvidia.com> <0da0f213-5d6a-c692-b9f7-9babb40adc96@amd.com>
 <Y769WqrbEUPQ3pt7@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y769WqrbEUPQ3pt7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/1/11 21:44, Jason Gunthorpe wrote:
>> iommu_enable_pci_caps() in the Intel IOMMU driver. This also does some
>> handling for ATS, so here we could check the info->ats_supported flag if ACS
>> needs to be checked or not.
> *groan*  this is seems wrong 🙁 Lu why are we doing this inside iommu
> drivers instead of in the device drivers to declare they want to use
> PASID?

Currently it's common to enable pasid in the IOMMU drivers, but device
driver has more knowledge of the device, hence it makes more sense to
move pci_enable_pasid() to the device driver.

--
Best regards,
baolu
