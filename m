Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3832AC158
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 17:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgKIQuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 11:50:16 -0500
Received: from ale.deltatee.com ([204.191.154.188]:33068 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730773AbgKIQuQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2020 11:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JvTSJOBJXMYeKQM3WvNBTHeii6rtMfOVYOuXeE1KNJE=; b=ThtDTaP+0JSTSqxTpv0Wbo5rpZ
        iRui8AXvdDo2GGy2jD+Ihq9bjJnDiDzsI2eDLeMfjQgtCqgG1tvLOdsfhRmNEUO5jfT5M0MI5pI2v
        q2scQ0uSLY0gF95SrT5uiioU6950uU8eKRlO3IC5Z9K0t/8xAxKw/BHncD9WkCSO21vni9bfdfdjX
        Ln7KngxHrH+R5I2NkjQEaqpyQ8667dJ8gO+usI96NSRpENPnyhncaujMAMnPoIfhN4BFg8hdAnZFw
        mUlKnwOWo6dpdcffw7/1fMcc6qlFJ5qgEkOsQqBOUl2OSNvLl4XkpF9pd5ChHmt9ndYzbgPOuwY5t
        OGbul4GA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kcAMk-00013k-Ea; Mon, 09 Nov 2020 09:50:03 -0700
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-16-logang@deltatee.com>
 <20201109150326.GA2221592@dhcp-10-100-145-180.wdc.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e718b81f-9cb8-dfe8-b1a6-ebb79f302732@deltatee.com>
Date:   Mon, 9 Nov 2020 09:50:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201109150326.GA2221592@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [RFC PATCH 15/15] nvme-pci: Allow mmaping the CMB in userspace
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-11-09 8:03 a.m., Keith Busch wrote:
> On Fri, Nov 06, 2020 at 10:00:36AM -0700, Logan Gunthorpe wrote:
>> Allow userspace to obtain CMB memory by mmaping the controller's
>> char device. The mmap call allocates and returns a hunk of CMB memory,
>> (the offset is ignored) so userspace does not have control over the
>> address within the CMB.
>>
>> A VMA allocated in this way will only be usable by drivers that set
>> FOLL_PCI_P2PDMA when calling GUP. And inter-device support will be
>> checked the first time the pages are mapped for DMA.
>>
>> Currently this is only supported by O_DIRECT to an PCI NVMe device
>> or through the NVMe passthrough IOCTL.
> 
> Rather than make this be specific to nvme, could pci p2pdma create an
> mmap'able file for any resource registered with it?

It's certainly possible. However, other people have been arguing that
more of this should be specific to NVMe as some use cases do not want to
use the genalloc inside p2pdma.

Logan
