Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFCE41F841
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 01:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhJAXgf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 19:36:35 -0400
Received: from ale.deltatee.com ([204.191.154.188]:37552 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhJAXgb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 19:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=1h1Lv0INI1OkG2kBb9PHFlHBKi/1CeW6GebCwGSVCmc=; b=Smqa+CJcH0Wt95tA7+NZxuHH+n
        QUOQh3trTTFGYaKSHuUijP9WcPujSedn7FDstFfsYhuknQTCYJHwhBs9cKWTjKDdAzQkEE7GaX0i6
        8K2pKqN2XF4KMFJY2jPmPQHJB1KnCR+OcKBF37Dhi5yK3QrkpuvO3zcMb+nZC4n1fkUW7p2kM1ndG
        mgaSoULxDn+dkgGi43vCLs4LmlqVzCU99zRkih0sc2y2Phgb6F7/ihLzNisYQt7mmIEzjzZUs89W5
        UlF2030OiaRuSysvpaxMpvCp+kDbWZkzQWzIwXh6tKMgBZS01QvFxj82l74HQjP+NYCDw5mEN5oAh
        IowOY+8g==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mWS2y-0001th-RF; Fri, 01 Oct 2021 17:34:33 -0600
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
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
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca> <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <95ada0ac-08cc-5b77-8675-b955b1b6d488@deltatee.com>
 <20211001221405.GR3544071@ziepe.ca>
 <8871549c-63b5-d062-87ea-9036605984d5@deltatee.com>
 <20211001224605.GS3544071@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ab49e8a7-8e81-29bb-250f-b395942b4da1@deltatee.com>
Date:   Fri, 1 Oct 2021 17:34:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001224605.GS3544071@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, dan.j.williams@intel.com, hch@lst.de, Felix.Kuehling@amd.com, apopple@nvidia.com, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2021-10-01 4:46 p.m., Jason Gunthorpe wrote:
> On Fri, Oct 01, 2021 at 04:22:28PM -0600, Logan Gunthorpe wrote:
> 
>>> It would close this issue, however synchronize_rcu() is very slow
>>> (think > 1second) in some cases and thus cannot be inserted here.
>>
>> It shouldn't be *that* slow, at least not the vast majority of the
>> time... it seems a bit unreasonable that a CPU wouldn't schedule for
>> more than a second. 
> 
> I've seen bug reports on exactly this, it is well known. Loaded
> big multi-cpu systems have high delays here, for whatever reason.
> 
>> But these aren't fast paths and synchronize_rcu() already gets
>> called in the unbind path for p2pdma a of couple times. I'm sure it
>> would also be fine to slow down the vma_close() path as well.
> 
> vma_close is done in a loop destroying vma's and if each synchronize
> costs > 1s it can take forever to close a process. We had to kill a
> similar use of synchronize_rcu in RDMA because users were complaining
> of > 40s process exit times.

Ah, fair. This adds a bit of complexity, but we could do a call_rcu() in
 vma_close to do the page frees.

Logan
