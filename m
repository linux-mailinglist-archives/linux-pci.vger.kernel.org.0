Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912E762317B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 18:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiKIR2X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 12:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiKIR2U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 12:28:20 -0500
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AE4222B5;
        Wed,  9 Nov 2022 09:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=goQlOFtxbQ70s6qs8WyNomLKzg8ycDnIQrZuP0F/u1I=; b=StYuk9GAypb3Q3akkOeGTjtq49
        vtnZhlI+piIoIgt9OpmkR8zQm3tnpHLE3Ljgi7MOfNIP9fqfgGX6wGq/SuqWyIE0SIrUMq+wvM1Ta
        IEZFVo2ZF0I9lAF0gVNZKXJL35f/3JNbUbvtOH81nDK/xsZhDOWn2wBerwFnTzEgjM8jsUc2tXRAH
        5N8TzeSk2ICu3Kmd00L/zM0/Gd87fugyhSLTkk/GLX2jxDfki6RDAw6iKCnrJmuml1RH3hpK7TiUq
        mD9qMMdMy6U6VNIVvZ1v04scxKyQ8GIq5a2Mu2CQ5ZBi6QSIlXUsf3zy9yAFQxFJVxEk2EgnD1gjr
        R+RFVEQg==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1osos1-00BLVo-C7; Wed, 09 Nov 2022 10:28:14 -0700
Message-ID: <ee9f817f-1573-f3f6-9b20-b4b2b2053eb6@deltatee.com>
Date:   Wed, 9 Nov 2022 10:28:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
        Stephen Bates <sbates@raithlin.com>, viro@zeniv.linux.org.uk
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221024150320.GA26731@lst.de>
 <743ad0e5-6936-9287-d093-2ce1c2a3e32d@nvidia.com>
 <20221108065618.GA20283@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20221108065618.GA20283@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: hch@lst.de, jhubbard@nvidia.com, axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com, viro@zeniv.linux.org.uk
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v11 0/9] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

@add Jens

On 2022-11-07 23:56, Christoph Hellwig wrote:
> On Mon, Oct 24, 2022 at 12:15:56PM -0700, John Hubbard wrote:
>> A little earlier, Jens graciously offered [1] to provide a topic branch,
>> such as:
>>
>>     for-6.2/block-gup [2]
>>
>> (I've moved the name forward from 6.1 to 6.2, because that discussion
>> was 7 weeks ago.)
> 
> So what are we going to do with this series?  It would be sad to miss
> the merge window again.

I noticed Jens wasn't copied on this series. I've added him. It would be
nice to get this in someone's tree soon.

Thanks!

Logan
