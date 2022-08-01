Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0308586C87
	for <lists+linux-pci@lfdr.de>; Mon,  1 Aug 2022 16:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiHAOFH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Aug 2022 10:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHAOFG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Aug 2022 10:05:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84F1E2B260;
        Mon,  1 Aug 2022 07:05:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBF9DED1;
        Mon,  1 Aug 2022 07:05:05 -0700 (PDT)
Received: from [10.57.10.23] (unknown [10.57.10.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 877DA3F73B;
        Mon,  1 Aug 2022 07:05:00 -0700 (PDT)
Message-ID: <57431a71-a71e-472a-9fb4-7acd4f9534cc@arm.com>
Date:   Mon, 1 Aug 2022 15:04:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/13] DMA Mapping P2PDMA Pages
Content-Language: en-GB
To:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        iommu@lists.linux.dev, Stephen Bates <sbates@raithlin.com>,
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
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20220708165104.5005-1-logang@deltatee.com>
 <20220726112906.GA2169@lst.de>
 <a9a1641a-aa5c-ce29-e4a4-c266f4494004@deltatee.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <a9a1641a-aa5c-ce29-e4a4-c266f4494004@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-07-26 16:55, Logan Gunthorpe wrote:
> 
> 
> On 2022-07-26 05:29, Christoph Hellwig wrote:
>> I've applied this to the dma-mapping for-next branch.
>>
>> I'd have liked a review from Robin, but as he seems to be out and the
>> rework was to fit his comments I'd rather have us unblocked before
>> the end of the merge window.
> 
> Great thanks! If Robin has some feedback when he gets back I'd be happy
> to make a couple more cleanup patches.

Indeed I've been taking some (rather overdue) holiday the last couple of 
weeks, sorry I forgot to take a look at this version beforehand. From a 
quick skim, nothing stands out as objectionable; thanks for taking my 
suggestions on board!

At some point once this lands I'll have a go at using the new flags to 
improve iommu-dma bounce buffering, so if I do spot anything else while 
I'm in there I'm sure could clean it up myself.

Cheers,
Robin.
