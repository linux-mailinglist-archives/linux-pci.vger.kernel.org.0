Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921DD36D500
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 11:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbhD1JvV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 05:51:21 -0400
Received: from foss.arm.com ([217.140.110.172]:38346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238070AbhD1JvV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Apr 2021 05:51:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED7FA1042
        for <linux-pci@vger.kernel.org>; Wed, 28 Apr 2021 02:50:35 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 47C643F70D;
        Wed, 28 Apr 2021 02:50:29 -0700 (PDT)
Subject: Re: [PATCH v5 05/16] swiotlb: Add restricted DMA pool initialization
To:     Claire Chang <tientzu@chromium.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Tomasz Figa <tfiga@chromium.org>, bskeggs@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>, chris@chris-wilson.co.uk,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, Jianxiong Gao <jxgao@google.com>,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
References: <20210422081508.3942748-1-tientzu@chromium.org>
 <20210422081508.3942748-6-tientzu@chromium.org>
 <c9abca62-328d-d0d6-a8a6-a67475171f92@arm.com>
 <CALiNf2_tffc65PhLxCr3-+gmVYKGO2HjYiJVkBNa5U5HYdi9pg@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <64137d13-cfa2-5f72-94c1-19b367489c78@arm.com>
Date:   Wed, 28 Apr 2021 10:50:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CALiNf2_tffc65PhLxCr3-+gmVYKGO2HjYiJVkBNa5U5HYdi9pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/04/2021 17:37, Claire Chang wrote:
> On Fri, Apr 23, 2021 at 7:34 PM Steven Price <steven.price@arm.com> wrote:
[...]
>>
>> But even then if it's not and we have the situation where debugfs==NULL
>> then the debugfs_create_dir() here will cause a subsequent attempt in
>> swiotlb_create_debugfs() to fail (directory already exists) leading to
>> mem->debugfs being assigned an error value. I suspect the creation of
>> the debugfs directory needs to be separated from io_tlb_default_mem
>> being set.
> 
> debugfs creation should move into the if (!mem) {...} above to avoid
> duplication.
> I think having a separated struct dentry pointer for the default
> debugfs should be enough?
> 
> if (!debugfs)
>      debugfs = debugfs_create_dir("swiotlb", NULL);
> swiotlb_create_debugfs(mem, rmem->name, debugfs);

Yes that looks like a good solution to me. Although I'd name the 
variable something a bit more descriptive than just "debugfs" e.g. 
"debugfs_dir" or "debugfs_root".

Thanks,

Steve
