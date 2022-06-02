Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4663C53BC46
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236232AbiFBQQZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 12:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiFBQQY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 12:16:24 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB408AE4C;
        Thu,  2 Jun 2022 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=W4T5PIIcGVVrvnJ3j+rtildRWdfS99SqV9DDMh3z6VA=; b=mFcvfvBdKsB2BJNNUrV2R2TggK
        1Px0GYS7XkvGiTWTnZL/2iur+Kwoi7+M1jX7ntdXKfQJgxbmlrV2IKqir+oid4k4eEGTQLkoy4Ej6
        5ZG9+5TOIBSiRlulo/Z8oASkCGdc8NEe+OT+P7LSZ2mv/eVC6P+tVixruEzq8ynubixg6CxcQoxPy
        F8HWcOevW1q3ZFYm1r8abYAOFD8Od08vH+hmLVbSXTbE3X0tUfar47n3TwHAH5FaK7Pdl9jU28pUr
        /4DQK3TDmrdpP1fNME8UkG4a7Pk0pi6CcP00XrNuudfB9AScd2GS+ujbPOIupoHRYNc++RS2G7b5x
        +U5oZZ4A==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nwnUh-00ENsn-U9; Thu, 02 Jun 2022 10:16:20 -0600
Message-ID: <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
Date:   Thu, 2 Jun 2022 10:16:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-CA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
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
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
 <20220602000038.GK2960187@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220602000038.GK2960187@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-06-01 18:00, Jason Gunthorpe wrote:
> On Fri, May 27, 2022 at 04:41:08PM -0600, Logan Gunthorpe wrote:
>>>
>>> IIRC this is the last part:
>>>
>>> https://lore.kernel.org/linux-mm/20220524190632.3304-1-alex.sierra@amd.com/
>>>
>>> And the earlier bit with Christoph's pieces looks like it might get
>>> merged to v5.19..
>>>
>>> The general idea is once pte_devmap is not set then all the
>>> refcounting works the way it should. This is what all new ZONE_DEVICE
>>> users should do..
>>
>> Ok, I don't actually follow how those patches relate to this.
>>
>> Based on your description I guess I don't need to set PFN_DEV and
> 
> Yes
> 
>> perhaps not use vmf_insert_mixed()? And then just use vm_normal_page()?
> 
> I'm not sure ATM the best function to use, but yes, a function that
> doesn't set PFN_DEV is needed here.
>  
>> But the refcounting of the pages seemed like it was already sane to me,
>> unless you mean that the code no longer has to synchronize_rcu() before
>> returning the pages... 
> 
> Right. It also doesn't need to call unmap range or keep track of the
> inode, or do any of that stuff unless it really needs mmap revokation
> semantics (which I doubt this use case does)
> 
> unmap range was only necessary because the refcounting is wrong -
> since the pte's don't hold a ref on the page in PFN_DEV mode it is
> necessary to wipe all the PTE explicitly before going ahead to
> decrement the refcount on this path.
> 
> Just stuff the pages into the mmap, and your driver unprobe will
> automatically block until all the mmaps are closed - no different than
> having an open file descriptor or something.

Oh is that what we want? With the current method the mmaps are unmapped
on unbind so that it doesn't block indefinitely. It seems more typical
for resources to be dropped quickly on unbind and processes that are
using them will get an error on next use.

Logan
