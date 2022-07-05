Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE16956763E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 20:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiGESQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 14:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiGESQy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 14:16:54 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E194B13F16;
        Tue,  5 Jul 2022 11:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=3rV+tiVBCGETS+0m1VAyBeVrP084h9ybGuEcnOkL1jA=; b=lfZ2jUE/Pcr0euHS/PfSv8pLp+
        4/PPUzTkxnoApUidHmt7v626OqXgmL9EfNAu2FXDE82dIkZS4evTLlHJEcLA0sTsaZOdUL7sJXe1K
        llHNHqCgIXLxKGdC2EFMJ+uJ5Hokog7lmJrw7QTYdr9sTAhi3Hh9CcwjoJd4Ouhncx4sMJASxJZo5
        Z45htSKhX9sgtg0ghREzgU5ID+skNQqwC9IlBlCgbwMhIXpFTCZpyt8HpOowWyAcZWE8tHzKxRvGy
        MFCCqqfCCaFi3VeOomss+vTbx17EVsq2HRcn8flYVkfHi6Hg6MM5xYspG5eOMY/FjnLQKBs2TXntf
        tmVTSv/w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1o8n6O-007Udo-RE; Tue, 05 Jul 2022 12:16:49 -0600
Message-ID: <b3deacdd-cb76-6ebb-0e29-ef6a5a426a0d@deltatee.com>
Date:   Tue, 5 Jul 2022 12:16:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220629175906.GU23621@ziepe.ca> <20220705075108.GB17451@lst.de>
 <20220705135102.GE23621@ziepe.ca> <20220705161240.GB13721@lst.de>
 <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
 <20220705164315.GB14484@lst.de>
 <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com>
 <20220705165039.GB14566@lst.de> <YsRzNqmZYlgkL7fI@kroah.com>
 <1bd43ef7-0403-bd25-087c-d54d5af677e4@deltatee.com>
 <YsR4CNDgtt4JWonv@kroah.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YsR4CNDgtt4JWonv@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, hch@lst.de, jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-07-05 11:42, Greg Kroah-Hartman wrote:
> On Tue, Jul 05, 2022 at 11:32:23AM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2022-07-05 11:21, Greg Kroah-Hartman wrote:
>>> On Tue, Jul 05, 2022 at 06:50:39PM +0200, Christoph Hellwig wrote:
>>>> [note for the newcomers, this is about allowing mmap()ing the PCIe
>>>> P2P memory from the generic PCI P2P code through sysfs, and more
>>>> importantly how to revoke it on device removal]
>>>
>>> We allow mmap on PCIe config space today, right?  Why is this different
>>> from what pci_create_legacy_files() does today?
>>>
>>>> On Tue, Jul 05, 2022 at 10:44:49AM -0600, Logan Gunthorpe wrote:
>>>>> We might be able to. I'm not sure. I'll have to figure out how to find
>>>>> that inode from the p2pdma code. I haven't found an obvious interface to
>>>>> do that.
>>>>
>>>> I think the right way to approach this would be a new sysfs API
>>>> that internally calls unmap_mapping_range internally instead of
>>>> exposing the inode. I suspect that might actually be the right thing
>>>> to do for iomem_inode as well.
>>>
>>> Why do we need something new and how is this any different from the PCI
>>> binary files I mention above?  We have supported PCI hotplug for a very
>>> long time, do the current PCI binary sysfs files not work properly with
>>> mmap and removing a device?
>>
>> The P2PDMA code allocates and hands out struct pages to userspace that
>> are backed with ZONE_DEVICE memory from a device's BAR. This is quite
>> different from the existing binary files mentioned above which neither
>> support struct pages nor allocation.
> 
> Why would you want to do this through a sysfs interface?  that feels
> horrid...

The current version does it through a char device, but that requires
creating a simple_fs and anon_inode for teardown on driver removal, plus
a bunch of hooks through the driver that exposes it (NVMe, in this case)
to set this all up.

Christoph is suggesting a sysfs interface which could potentially avoid
the anon_inode and all of the extra hooks. It has some significant
benefits and maybe some small downsides, but I wouldn't describe it as
horrid.

Logan
