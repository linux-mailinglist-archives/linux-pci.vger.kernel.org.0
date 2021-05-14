Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB37F380E38
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbhENQbs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 12:31:48 -0400
Received: from ale.deltatee.com ([204.191.154.188]:33070 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhENQbs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 12:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=xV6ltS4lNS3Jm/f8TEnktWg1U1xW+UrFzR8b6RAQyww=; b=s//zBlCpwgQ1lLSn3XKJEQOaWd
        rI8rRBGrF3aoC3g+QuDXDug4GzbnkaS6nBtWhDM3pUOjQYKZYx/6iqfRigkJyI290iga8e7o+co0E
        QbXpFJsOWAQw7fOVJWNVDxDk/PaOaE0YGfRnol4IiEjPWjENwy9CRw8DjR6tZ+WmbEC0OTj1tjMV/
        /DRMXbA8j4LTuFwWSHMlTxZaa7XowzY/YiYS5R+3nywlL9wmmsoR+uFEzvV5+oIlKCVP0Tyx8aJlM
        CWWYGc4JPwElN6+U10s+whCtXjoZyIVemlp2K/nOQSPMyhE1NnQR98UkoaVAkuMTzmLnP7RlAicuB
        8O/5DBLg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lhahm-0006Ih-Qz; Fri, 14 May 2021 10:30:27 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
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
        Robin Murphy <robin.murphy@arm.com>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210514140007.GE4715@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <91ce86db-e2f9-85ac-12db-91df72ac4648@deltatee.com>
Date:   Fri, 14 May 2021 10:30:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514140007.GE4715@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v2 00/22] Add new DMA mapping operation for P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-14 8:00 a.m., Christoph Hellwig wrote:
> On Thu, May 13, 2021 at 04:31:41PM -0600, Logan Gunthorpe wrote:
>>  17 files changed, 570 insertions(+), 290 deletions(-)
> 
> I'm a little worried about all this extra code for no new functionality
> at all.

Yes, this series is really just prep work for allowing new
functionality. And a bunch of cleanup has been tacked onto it. It should
make adding P2PDMA in userspace a lot easier and I expect other P2PDMA
use cases will be better enabled by it.

A lot of people don't like the pci_p2pdma_map_sg() special case and
can't use it in their use case because it only accepts homogenous SGLs.
This series gets rid of the special case and allows it to be used more
generally.

Logan
