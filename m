Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB885E664A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 16:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiIVO6f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 10:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiIVO6b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 10:58:31 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E646D74D7;
        Thu, 22 Sep 2022 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=lIqeYmIYKdZ39Sv7iKx98PZ/aFncvZ/B1l8HysQoIhk=; b=I75dP8r9MX4OiRESuJQ15NM69H
        E7EPt6dmj1RLUSLfLdHSdQgN1mX1Mps+QUyXlvHfee+UqpkHTb6XVDmWWJmc+SsSXElXncswhSea/
        n7ClPcuX8C+GwiXwMt/bA9+YVdTDgHYaqcPfaUTSE2PgJgFZGhE5WKHVUC+x9lJkdalVuklY4Xq8n
        nEI+f/4MSCesrWAsHDl7LEYeD/yhSatwrHa4riE/CQsWfphlfqxmoZ49pmeUh05ZlrdcurIihp0za
        NSFZ6gpSHMV26d1luCPA7bAblBb7vBlDXKICtG6AtRLly1VcBQJPVRZYaHZ6jleuswBvQRteHobdp
        Z4DBeTVg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1obNef-00848L-ST; Thu, 22 Sep 2022 08:58:22 -0600
Message-ID: <0074a009-9ece-6617-b66d-d003593d153e@deltatee.com>
Date:   Thu, 22 Sep 2022 08:58:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
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
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20220825152425.6296-8-logang@deltatee.com>
 <YxDb2MyRx6o/wDAz@kroah.com>
 <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
 <YxDhEO9ycZDTnbZm@kroah.com>
 <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com>
 <YxD7uZYaV75gJS9d@kroah.com>
 <fb9d7948-43fe-87c5-5275-70f280181ad1@deltatee.com>
 <YxGad5h2Nn/Ejslc@kroah.com>
 <db8cd049-c78b-1aa0-dcd0-0feb8c6cb25c@deltatee.com>
 <20220920064613.GB17325@lst.de> <Yywe9rBMB6hlUwqw@kroah.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <Yywe9rBMB6hlUwqw@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, hch@lst.de, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v9 7/8] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-09-22 02:38, Greg Kroah-Hartman wrote:
> On Tue, Sep 20, 2022 at 08:46:13AM +0200, Christoph Hellwig wrote:
>> On Fri, Sep 02, 2022 at 12:46:54PM -0600, Logan Gunthorpe wrote:
>>> See the diff at the bottom of this email. I can apply it on top of this
>>> patch, but IMO it is neither easier to follow nor maintain. Unless you 
>>> have a different suggestion...
>>
>> Greg, can you chime in on this?  Besides this item we just have a few
>> cosmetic bits left I think, and I'd really like to get the series into
>> this merge window.
>>
> 
> I don't seem to have this in my inbox at all anymore, sorry.
> 
> The original should be fine, Logan, thanks for trying to split it out a
> bit more.  So this can be taken as-is for 6.1-rc1.

Thanks Greg,

I'll send a v10 with changes from the other feedback later today.

Logan
