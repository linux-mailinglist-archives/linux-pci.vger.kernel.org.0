Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 951E51A6199
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 04:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgDMCtA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Apr 2020 22:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbgDMCtA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Apr 2020 22:49:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1072C0A3BE0
        for <linux-pci@vger.kernel.org>; Sun, 12 Apr 2020 19:49:00 -0700 (PDT)
IronPort-SDR: nAu/EyUraFV4PSDm4jOYcxEbkREylvp6he89Mvhj0aF3onawNbaFeVdNwtU/6PcQUKmXXc/lPp
 AgPoQTOx/pZg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 19:49:00 -0700
IronPort-SDR: 8h2kJz9H2xByAm0Ehh0zIvn6ATdAcGQpeq1tHagj9rbqQVoUMOGf47be9xS1Z5eyn7z+wHJA8X
 d3LLcRluFVVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,377,1580803200"; 
   d="scan'208";a="362961161"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.54]) ([10.254.211.54])
  by fmsmga001.fm.intel.com with ESMTP; 12 Apr 2020 19:48:55 -0700
Cc:     baolu.lu@linux.intel.com, Jon Derrick <jonathan.derrick@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and
 subdevices
To:     Daniel Drake <drake@endlessm.com>
References: <20200409191736.6233-1-jonathan.derrick@intel.com>
 <20200409191736.6233-2-jonathan.derrick@intel.com>
 <09c98569-ed22-8886-3372-f5752334f8af@linux.intel.com>
 <CAD8Lp45dJ3-t6qqctiP1a=c44PEWZ-L04yv0r0=1Nrvwfouz1w@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <32cc4809-7029-bc5e-5a74-abbe43596e8d@linux.intel.com>
Date:   Mon, 13 Apr 2020 10:48:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAD8Lp45dJ3-t6qqctiP1a=c44PEWZ-L04yv0r0=1Nrvwfouz1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Daniel,

On 2020/4/13 10:25, Daniel Drake wrote:
> On Fri, Apr 10, 2020 at 9:22 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>> This is caused by the fragile private domain implementation. We are in
>> process of removing it by enhancing the iommu subsystem with per-group
>> default domain.
>>
>> https://www.spinics.net/lists/iommu/msg42976.html
>>
>> So ultimately VMD subdevices should have their own per-device iommu data
>> and support per-device dma ops.
> 
> Interesting. There's also this patchset you posted:
> [PATCH 00/19] [PULL REQUEST] iommu/vt-d: patches for v5.7
> https://lists.linuxfoundation.org/pipermail/iommu/2020-April/042967.html
> (to be pushed out to 5.8)

Both are trying to solve a same problem.

I have sync'ed with Joerg. This patch set will be replaced with Joerg's
proposal due to a race concern between domain switching and driver
binding. I will rebase all vt-d patches in this set on top of Joerg's
change.

Best regards,
baolu

> 
> In there you have:
>> iommu/vt-d: Don't force 32bit devices to uses DMA domain
> which seems to clash with the approach being explored in this thread.
> 
> And:
>> iommu/vt-d: Apply per-device dma_ops
> This effectively solves the trip point that caused me to open these
> discussions, where intel_map_page() -> iommu_need_mapping() would
> incorrectly determine that a intel-iommu DMA mapping was needed for a
> PCI subdevice running in identity mode. After this patch, a PCI
> subdevice in identity mode uses the default system dma_ops and
> completely avoids intel-iommu.
> 
> So that solves the issues I was looking at. Jon, you might want to
> check if the problems you see are likewise solved for you by these
> patches.
> 
> I didn't try Joerg's iommu group rework yet as it conflicts with those
> patches above.
> 
> Daniel
> 
