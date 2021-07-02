Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893E73B9FE7
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 13:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGBLmY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 07:42:24 -0400
Received: from foss.arm.com ([217.140.110.172]:45750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231802AbhGBLmY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Jul 2021 07:42:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 773371FB;
        Fri,  2 Jul 2021 04:39:51 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5E473F718;
        Fri,  2 Jul 2021 04:39:44 -0700 (PDT)
Subject: Re: [PATCH v15 12/12] of: Add plumbing for restricted DMA pool
To:     Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
        peterz@infradead.org, dri-devel@lists.freedesktop.org,
        chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
        mingo@kernel.org, jxgao@google.com, sstabellini@kernel.org,
        Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        bskeggs@redhat.com, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Thierry Reding <treding@nvidia.com>,
        intel-gfx@lists.freedesktop.org, matthew.auld@intel.com,
        linux-devicetree <devicetree@vger.kernel.org>, airlied@linux.ie,
        Nicolas Boichat <drinkcat@chromium.org>,
        rodrigo.vivi@intel.com, bhelgaas@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, quic_qiancai@quicinc.com,
        lkml <linux-kernel@vger.kernel.org>, tfiga@chromium.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        thomas.lendacky@amd.com, linuxppc-dev@lists.ozlabs.org,
        bauerman@linux.ibm.com
References: <20210624155526.2775863-1-tientzu@chromium.org>
 <20210624155526.2775863-13-tientzu@chromium.org>
 <20210702030807.GA2685166@roeck-us.net>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <87ca3ada-22ed-f40c-0089-ca6fffc04f24@arm.com>
Date:   Fri, 2 Jul 2021 12:39:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702030807.GA2685166@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-07-02 04:08, Guenter Roeck wrote:
> Hi,
> 
> On Thu, Jun 24, 2021 at 11:55:26PM +0800, Claire Chang wrote:
>> If a device is not behind an IOMMU, we look up the device node and set
>> up the restricted DMA when the restricted-dma-pool is presented.
>>
>> Signed-off-by: Claire Chang <tientzu@chromium.org>
>> Tested-by: Stefano Stabellini <sstabellini@kernel.org>
>> Tested-by: Will Deacon <will@kernel.org>
> 
> With this patch in place, all sparc and sparc64 qemu emulations
> fail to boot. Symptom is that the root file system is not found.
> Reverting this patch fixes the problem. Bisect log is attached.

Ah, OF_ADDRESS depends on !SPARC, so of_dma_configure_id() is presumably 
returning an unexpected -ENODEV from the of_dma_set_restricted_buffer() 
stub. That should probably be returning 0 instead, since either way it's 
not an error condition for it to simply do nothing.

Robin.

> 
> Guenter
> 
> ---
> # bad: [fb0ca446157a86b75502c1636b0d81e642fe6bf1] Add linux-next specific files for 20210701
> # good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
> git bisect start 'HEAD' 'v5.13'
> # bad: [f63c4fda987a19b1194cc45cb72fd5bf968d9d90] Merge remote-tracking branch 'rdma/for-next'
> git bisect bad f63c4fda987a19b1194cc45cb72fd5bf968d9d90
> # good: [46bb5dd1d2a63e906e374e97dfd4a5e33934b1c4] Merge remote-tracking branch 'ipsec/master'
> git bisect good 46bb5dd1d2a63e906e374e97dfd4a5e33934b1c4
> # good: [43ba6969cfb8185353a7a6fc79070f13b9e3d6d3] Merge remote-tracking branch 'clk/clk-next'
> git bisect good 43ba6969cfb8185353a7a6fc79070f13b9e3d6d3
> # good: [1ca5eddcf8dca1d6345471c6404e7364af0d7019] Merge remote-tracking branch 'fuse/for-next'
> git bisect good 1ca5eddcf8dca1d6345471c6404e7364af0d7019
> # good: [8f6d7b3248705920187263a4e7147b0752ec7dcf] Merge remote-tracking branch 'pci/next'
> git bisect good 8f6d7b3248705920187263a4e7147b0752ec7dcf
> # good: [df1885a755784da3ef285f36d9230c1d090ef186] RDMA/rtrs_clt: Alloc less memory with write path fast memory registration
> git bisect good df1885a755784da3ef285f36d9230c1d090ef186
> # good: [93d31efb58c8ad4a66bbedbc2d082df458c04e45] Merge remote-tracking branch 'cpufreq-arm/cpufreq/arm/linux-next'
> git bisect good 93d31efb58c8ad4a66bbedbc2d082df458c04e45
> # good: [46308965ae6fdc7c25deb2e8c048510ae51bbe66] RDMA/irdma: Check contents of user-space irdma_mem_reg_req object
> git bisect good 46308965ae6fdc7c25deb2e8c048510ae51bbe66
> # good: [6de7a1d006ea9db235492b288312838d6878385f] thermal/drivers/int340x/processor_thermal: Split enumeration and processing part
> git bisect good 6de7a1d006ea9db235492b288312838d6878385f
> # good: [081bec2577cda3d04f6559c60b6f4e2242853520] dt-bindings: of: Add restricted DMA pool
> git bisect good 081bec2577cda3d04f6559c60b6f4e2242853520
> # good: [bf95ac0bcd69979af146852f6a617a60285ebbc1] Merge remote-tracking branch 'thermal/thermal/linux-next'
> git bisect good bf95ac0bcd69979af146852f6a617a60285ebbc1
> # good: [3d8287544223a3d2f37981c1f9ffd94d0b5e9ffc] RDMA/core: Always release restrack object
> git bisect good 3d8287544223a3d2f37981c1f9ffd94d0b5e9ffc
> # bad: [cff1f23fad6e0bd7d671acce0d15285c709f259c] Merge remote-tracking branch 'swiotlb/linux-next'
> git bisect bad cff1f23fad6e0bd7d671acce0d15285c709f259c
> # bad: [b655006619b7bccd0dc1e055bd72de5d613e7b5c] of: Add plumbing for restricted DMA pool
> git bisect bad b655006619b7bccd0dc1e055bd72de5d613e7b5c
> # first bad commit: [b655006619b7bccd0dc1e055bd72de5d613e7b5c] of: Add plumbing for restricted DMA pool
> 
