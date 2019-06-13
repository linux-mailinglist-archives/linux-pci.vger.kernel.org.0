Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE5944D54
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 22:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfFMUYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 16:24:30 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59714 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfFMUY3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 16:24:29 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hbWGl-00047r-81; Thu, 13 Jun 2019 14:24:24 -0600
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        nouveau@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Linux MM <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-pci@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190613094326.24093-1-hch@lst.de>
 <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com>
 <283e87e8-20b6-0505-a19b-5d18e057f008@deltatee.com>
 <CAPcyv4hx=ng3SxzAWd8s_8VtAfoiiWhiA5kodi9KPc=jGmnejg@mail.gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d0da4c86-ef52-b981-06af-b37e3e0515ee@deltatee.com>
Date:   Thu, 13 Jun 2019 14:24:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hx=ng3SxzAWd8s_8VtAfoiiWhiA5kodi9KPc=jGmnejg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: akpm@linux-foundation.org, linux-pci@vger.kernel.org, bskeggs@redhat.com, jgg@mellanox.com, jglisse@redhat.com, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, linux-nvdimm@lists.01.org, hch@lst.de, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: dev_pagemap related cleanups
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-13 2:21 p.m., Dan Williams wrote:
> On Thu, Jun 13, 2019 at 1:18 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>>
>> On 2019-06-13 12:27 p.m., Dan Williams wrote:
>>> On Thu, Jun 13, 2019 at 2:43 AM Christoph Hellwig <hch@lst.de> wrote:
>>>>
>>>> Hi Dan, Jérôme and Jason,
>>>>
>>>> below is a series that cleans up the dev_pagemap interface so that
>>>> it is more easily usable, which removes the need to wrap it in hmm
>>>> and thus allowing to kill a lot of code
>>>>
>>>> Diffstat:
>>>>
>>>>  22 files changed, 245 insertions(+), 802 deletions(-)
>>>
>>> Hooray!
>>>
>>>> Git tree:
>>>>
>>>>     git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup
>>>
>>> I just realized this collides with the dev_pagemap release rework in
>>> Andrew's tree (commit ids below are from next.git and are not stable)
>>>
>>> 4422ee8476f0 mm/devm_memremap_pages: fix final page put race
>>> 771f0714d0dc PCI/P2PDMA: track pgmap references per resource, not globally
>>> af37085de906 lib/genalloc: introduce chunk owners
>>> e0047ff8aa77 PCI/P2PDMA: fix the gen_pool_add_virt() failure path
>>> 0315d47d6ae9 mm/devm_memremap_pages: introduce devm_memunmap_pages
>>> 216475c7eaa8 drivers/base/devres: introduce devm_release_action()
>>>
>>> CONFLICT (content): Merge conflict in tools/testing/nvdimm/test/iomap.c
>>> CONFLICT (content): Merge conflict in mm/hmm.c
>>> CONFLICT (content): Merge conflict in kernel/memremap.c
>>> CONFLICT (content): Merge conflict in include/linux/memremap.h
>>> CONFLICT (content): Merge conflict in drivers/pci/p2pdma.c
>>> CONFLICT (content): Merge conflict in drivers/nvdimm/pmem.c
>>> CONFLICT (content): Merge conflict in drivers/dax/device.c
>>> CONFLICT (content): Merge conflict in drivers/dax/dax-private.h
>>>
>>> Perhaps we should pull those out and resend them through hmm.git?
>>
>> Hmm, I've been waiting for those patches to get in for a little while now ;(
> 
> Unless Andrew was going to submit as v5.2-rc fixes I think I should
> rebase / submit them on current hmm.git and then throw these cleanups
> from Christoph on top?

Whatever you feel is best. I'm just hoping they get in sooner rather
than later. They do fix a bug after all. Let me know if you want me to
retest the P2PDMA stuff after the rebase.

Thanks,

Logan
