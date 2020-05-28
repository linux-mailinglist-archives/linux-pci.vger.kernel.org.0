Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA20A1E5807
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 08:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgE1G7E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 02:59:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:50203 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgE1G7E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 02:59:04 -0400
IronPort-SDR: Cv12EPUbqU/9hbxnBmEcuIUNGQasy+mxviEyKlQuMpgEriUL7UgyUxUHr2ZqojUFKNYZwx1Wjz
 EZ6Fiv+e+O0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 23:59:03 -0700
IronPort-SDR: r3uhcUHtN+Unc52bFgwWqmKLrtoPUpmFeeXHBuq20TESLN6GFaH9ys0ak/J+baCfJQerDF+RNU
 55MC0i4pjCow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="442844492"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.30.232]) ([10.255.30.232])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2020 23:59:00 -0700
Cc:     baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v1 1/3] iommu/vt-d: Only clear real DMA device's context
 entries
To:     Jon Derrick <jonathan.derrick@intel.com>,
        iommu@lists.linux-foundation.org
References: <20200527165617.297470-1-jonathan.derrick@intel.com>
 <20200527165617.297470-2-jonathan.derrick@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <199f788c-f00e-6bd9-49fe-9fcc06bef431@linux.intel.com>
Date:   Thu, 28 May 2020 14:59:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527165617.297470-2-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/5/28 0:56, Jon Derrick wrote:
> Domain context mapping can encounter issues with sub-devices of a real
> DMA device. A sub-device cannot have a valid context entry due to it
> potentially aliasing another device's 16-bit ID. It's expected that
> sub-devices of the real DMA device uses the real DMA device's requester
> when context mapping.
> 
> This is an issue when a sub-device is removed where the context entry is
> cleared for all aliases. Other sub-devices are still valid, resulting in
> those sub-devices being stranded without valid context entries.
> 
> The correct approach is to use the real DMA device when programming the
> context entries. The insertion path is correct because device_to_iommu()
> will return the bus and devfn of the real DMA device. The removal path
> needs to only operate on the real DMA device, otherwise the entire
> context entry would be cleared for all sub-devices of the real DMA
> device.
> 
> This patch also adds a helper to determine if a struct device is a
> sub-device of a real DMA device.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Fixes: 2b0140c69637e ("iommu/vt-d: Use pci_real_dma_dev() for mapping")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
