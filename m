Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75CD1E584A
	for <lists+linux-pci@lfdr.de>; Thu, 28 May 2020 09:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgE1HO7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 May 2020 03:14:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:33808 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgE1HO6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 May 2020 03:14:58 -0400
IronPort-SDR: rvCwr32w8PjRs41jtkUnZR/LehS6TSKf/6DXMKwzHgDmc/I6ajuEOPzPe1dvAKLDlV3mbm0j+z
 TnUDwBc8eeAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 00:14:58 -0700
IronPort-SDR: iQKMIY9FYMhJzjvuXKfBJnke/aonbJBD0wTMyrY0H5ucO+pQBfNmMjUfqONvHJtWUESPWecEcH
 v4PgGBXtREHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="442848653"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.30.232]) ([10.255.30.232])
  by orsmga005.jf.intel.com with ESMTP; 28 May 2020 00:14:56 -0700
Cc:     baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v1 2/3] iommu/vt-d: Allocate domain info for real DMA
 sub-devices
To:     Jon Derrick <jonathan.derrick@intel.com>,
        iommu@lists.linux-foundation.org
References: <20200527165617.297470-1-jonathan.derrick@intel.com>
 <20200527165617.297470-3-jonathan.derrick@intel.com>
 <fd4b5313-efd0-90bf-5841-80a97ce5f652@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <39342c83-8484-5a42-f16e-fe3cda67c809@linux.intel.com>
Date:   Thu, 28 May 2020 15:14:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <fd4b5313-efd0-90bf-5841-80a97ce5f652@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/5/28 15:01, Lu Baolu wrote:
> On 2020/5/28 0:56, Jon Derrick wrote:
>> Sub-devices of a real DMA device might exist on a separate segment than
>> the real DMA device and its IOMMU. These devices should still have a
>> valid device_domain_info, but the current dma alias model won't
>> allocate info for the subdevice.
>>
>> This patch adds a segment member to struct device_domain_info and uses
>> the sub-device's BDF so that these sub-devices won't alias to other
>> devices.
>>
>> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> 
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

And a fix tag, so that it could be picked up for v5.6+ stable kernel.

Fixes: 2b0140c69637e ("iommu/vt-d: Use pci_real_dma_dev() for mapping")

Best regards,
baolu
