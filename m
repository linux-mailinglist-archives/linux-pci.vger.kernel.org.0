Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32CD380DF3
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 18:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhENQRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 12:17:48 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60786 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhENQRr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 12:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=/+y5cB9Q7a4Pvo8GJ697lhiF+rrko29gkIH4dIcvU3o=; b=MmSRGhUuqxFDvX3OK+OEV4eVpd
        N/zgGKMQXAVlSEVeXQz+yWzkMeG0pfSpIiblq7NLJ0wupnrLMumK0rDjtFfd/FF0Q+C6GEtJn1SLL
        tmGX51BeuLVhgkyvD8B4j7MvaJBIzhzYyfu47Qf9jlfwBgAi4eGOADrfqJPFfdcwm4fLKHriYZkwB
        XWJGNXjx3vL7UZ0Gg4+cLIwWfdX2ukuUFEwI/isOFo7IfVxMrRMdibQR0bWuhrA1ObTZLbU/6JGtF
        NEtN+nFTqspeVtbQ/8atAXDLh7mQFhxOndy17QOrVYpfrcaQ2HCESVb57wBSg9r+wW/N8KqvIGTQ5
        +nUXCXXQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lhaUE-00067v-2Z; Fri, 14 May 2021 10:16:26 -0600
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
 <20210513223203.5542-15-logang@deltatee.com> <20210514135331.GC4715@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9515a7c5-40a0-5411-a3b9-4216b25d63dc@deltatee.com>
Date:   Fri, 14 May 2021 10:16:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514135331.GC4715@lst.de>
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
Subject: Re: [PATCH v2 14/22] PCI/P2PDMA: Introduce helpers for dma_map_sg
 implementations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-14 7:53 a.m., Christoph Hellwig wrote:
> I think helpers for the dma mapping implementation should probably
> go into dma-map-ops.h so that the header for the public API doesn't get
> polluted with them.

Ok. Will do for v3.

Logan
