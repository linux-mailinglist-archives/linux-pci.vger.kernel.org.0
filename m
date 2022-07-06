Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04D6569460
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 23:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiGFVaw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jul 2022 17:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiGFVas (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jul 2022 17:30:48 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3412A94F;
        Wed,  6 Jul 2022 14:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=8YduW0eS5FyJqaOqaP8Ime9Kxv0Nz0ax91qwOz8aVq0=; b=tJ8pa1OCY41/griklmW+EWfOVD
        GWRX3NjEHhYKoa1dirAXu9tcLaN+qpf0nzpSUt6AE2hSTAMaGkgPgv4NcYCGYPyn5+QpenS+wTnVf
        dzwHgdTgxI67I3CmK0cMnjTb734bjxbjYx7DQA9orlsLZwJnT7/WMP2dzbiZ7YbAQzYQu/y+kd36E
        NWKd/LUDPN2BcSU2j0kYeELLqOgQTg66ewIFq/UnLnPvN5w4UmYxGdTvEJEsZFKMhHTjiXUcAJU+a
        56SmKOp2xezp85myJotIUFWF91GMeRTiTwry5HfRHn7/M0IWeMCxtQww2OKOWXkI2zuBZnUl0FPwc
        DaJoW4Qg==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1o9CbT-008LWu-KY; Wed, 06 Jul 2022 15:30:36 -0600
Message-ID: <e40595f9-f398-d43f-b09d-08d3e88b3950@deltatee.com>
Date:   Wed, 6 Jul 2022 15:30:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
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
References: <20220705161240.GB13721@lst.de>
 <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
 <20220705164315.GB14484@lst.de>
 <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com>
 <20220705165039.GB14566@lst.de> <YsRzNqmZYlgkL7fI@kroah.com>
 <1bd43ef7-0403-bd25-087c-d54d5af677e4@deltatee.com>
 <YsR4CNDgtt4JWonv@kroah.com>
 <b3deacdd-cb76-6ebb-0e29-ef6a5a426a0d@deltatee.com>
 <20220706065127.GA27132@lst.de> <YsU0Cb0rRbW8FGPX@kroah.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YsU0Cb0rRbW8FGPX@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
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



On 2022-07-06 01:04, Greg Kroah-Hartman wrote:
> On Wed, Jul 06, 2022 at 08:51:27AM +0200, Christoph Hellwig wrote:
>> On Tue, Jul 05, 2022 at 12:16:45PM -0600, Logan Gunthorpe wrote:
>>> The current version does it through a char device, but that requires
>>> creating a simple_fs and anon_inode for teardown on driver removal, plus
>>> a bunch of hooks through the driver that exposes it (NVMe, in this case)
>>> to set this all up.
>>>
>>> Christoph is suggesting a sysfs interface which could potentially avoid
>>> the anon_inode and all of the extra hooks. It has some significant
>>> benefits and maybe some small downsides, but I wouldn't describe it as
>>> horrid.
>>
>> Yeah, I don't think is is horrible, it fits in with the resource files
>> for the BARs, and solves a lot of problems.  Greg, can you explain
>> what would be so bad about it?
> 
> As you mention, you will have to pass different things down into sysfs
> in order for that to be possible.  If it matches the resource files like
> we currently have today, that might not be that bad, but it still feels
> odd to me.  Let's see an implementation and a Documentation/ABI/ entry
> first though.

I'll work something up in the coming weeks.

Thanks,

Logan
