Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5654056258D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 23:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbiF3VuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 17:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiF3VuS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 17:50:18 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C994F195;
        Thu, 30 Jun 2022 14:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:References:Cc:To:From:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=L+x+wtKtqznZ9UO5BN1Gnb22+HteJcnx5QZHLC44n98=; b=Jj488gdvqsV18JMGTmwXJUFoGQ
        CblCro8U0WuAdM8gOpccLKuBiaeJ+nN3Lo/S6X8BXqAFs0cP2r6w1NZevOKPMvgfWS5XPLy+wMGUa
        X+zYUPFryGdBKNeIbU7ImfRISf0kJRkC7KKZTRuIGAssdELHIn3StAJwRXKVpZqhrr2GbIC0v4cSj
        m81Syv7Im4YpQ+9FQT+W6OVo5d0Z4DfA6ixTpruYVv3snPN7jhpB8k0zKK/DECdMRa2sWCkzfd3C8
        phncKnrZB1O0Z7N6doBtnPrjc0e183a4KnhG+K3aYuR1g+umuSg/LOlHXUq4o8YhKeZqbn2ugJtQb
        dzbYLYsA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1o723B-003P1h-K8; Thu, 30 Jun 2022 15:50:14 -0600
Message-ID: <39bf0071-0acf-12fd-3d3e-06dfd87bb409@deltatee.com>
Date:   Thu, 30 Jun 2022 15:50:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
From:   Logan Gunthorpe <logang@deltatee.com>
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
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-17-logang@deltatee.com> <20220629064629.GC17576@lst.de>
 <7da06e08-7dd1-f37c-4382-bc59a1b1e819@deltatee.com>
In-Reply-To: <7da06e08-7dd1-f37c-4382-bc59a1b1e819@deltatee.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: hch@lst.de, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v7 16/21] block: add check when merging zone device pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2022-06-29 10:06, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-06-29 00:46, Christoph Hellwig wrote:
>> On Wed, Jun 15, 2022 at 10:12:28AM -0600, Logan Gunthorpe wrote:
>>> Consecutive zone device pages should not be merged into the same sgl
>>> or bvec segment with other types of pages or if they belong to different
>>> pgmaps. Otherwise getting the pgmap of a given segment is not possible
>>> without scanning the entire segment. This helper returns true either if
>>> both pages are not zone device pages or both pages are zone device
>>> pages with the same pgmap.
>>>
>>> Add a helper to determine if zone device pages are mergeable and use
>>> this helper in page_is_mergeable().
>>
>> Any reason not to simply set REQ_NOMERGE for these requests?  We
>> can't merge for passthrough requests anyway, and genrally don't merge
>> for direct I/O either, so adding all this overhead seems a bit pointless.
> 
> Hmm, I suppose we could also ensure that REQ_NOMERGE is set in a bio
> before setting FOLL_PCI_P2PDMA in bio_map_user_iov() and
> __bio_iov_iter_get_pages(). Assuming it's always set for any direct I/O.
> 

Oh, it turns out this code has nothing to do with REQ_NOMERGE. It's used
indirectly in bio_map_user_iov() and __bio_iov_iter_get_pages() when
adding pages to the bio via page_is_mergeable(). So it's not about
requests being merged it's about pages being merged.

So I'm not sure how we can avoid this, but it only happens when two
adjacent pages are added to the same bio in a row, so I don't think it's
that common, but the check can probably be moved down so it happens
after the same_page check to make it a little less common.

Logan

Logan
