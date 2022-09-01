Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC0E5A9FBB
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 21:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiIATRG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 15:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiIATRF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 15:17:05 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA1075FCF;
        Thu,  1 Sep 2022 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=mn3VERy0s8rwu2J3nmnzKseb1Xv+6b55gPqcv2R29Do=; b=YzaqHznkMBYAnCSOLqSHdegCox
        YKGC4eoem9/8GT5zgWrOSDaNjktJxP8yRvpJYQxa1Z8TVgSJMiKxRYBzMwVpxfst2k9K0nTOV1HBS
        g+ph5690L3SgBn1e1YgO7JjiEYivUW+H3wpACNHc9roxwPBpKqP9k77Y82r0mkv/FNfPaaPUHfTvB
        p4qZfGw6uCBlrSY263wg1z6zYHA/Re3+5UA8DJ6RvGYmERMmO74bYgDyuhsaCDe3OouNe43APnOcv
        6drCz4JVkp2sBvXA1RP/eGJ/WdeAGxetZaWgUxT+1aOmV3OaCU44xJq4EEu+L4J8FIFcXmhtYUgpU
        1D7gy7Vw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oTpgS-00Dx2S-Se; Thu, 01 Sep 2022 13:17:01 -0600
Message-ID: <fb9d7948-43fe-87c5-5275-70f280181ad1@deltatee.com>
Date:   Thu, 1 Sep 2022 13:16:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
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
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20220825152425.6296-1-logang@deltatee.com>
 <20220825152425.6296-8-logang@deltatee.com> <YxDb2MyRx6o/wDAz@kroah.com>
 <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
 <YxDhEO9ycZDTnbZm@kroah.com>
 <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com>
 <YxD7uZYaV75gJS9d@kroah.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YxD7uZYaV75gJS9d@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v9 7/8] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-09-01 12:36, Greg Kroah-Hartman wrote:
> On Thu, Sep 01, 2022 at 12:14:25PM -0600, Logan Gunthorpe wrote:
>> Well we haven't plugged in a remove call into p2pdma, that would be more
>> work and more interfaces touching the PCI code. Note: this code isn't a
>> driver but a set of PCI helpers available to other PCI drivers.
>> Everything that's setup is using the devm interfaces and gets torn down
>> with the same. So I don't really see the benefit of making the change
>> you propose.
> 
> The issue is the classic one with the devm helpers.  They do not lend
> themselves to resource management issues that require ordering or other
> sort of dependencies.  Please do not use them here, just put in a remove
> callback as you eventually will need it anyway, as you have a strong
> requirement for what gets freed when, and the devm api does not provide
> for that well.

This surprises me. Can you elaborate on this classic issue?

I've definitely seen uses of devm that expect the calls will be torn
down in reverse order they are added. The existing p2pdma code will
certainly fail quite significantly if a devm_kzalloc() releases its
memory before the devm_memmap_pages() cleans up. There's also already an
action that is used to cleanup before the last devm_kzalloc() call
happens. If ordering is not guaranteed, then devm seems fairly broken
and unusable and I'd have to drop all uses from this code and go back to
the error prone method. Also what's the point of
devm_add_action_or_reset() if it doesn't guarantee the ordering or the
release?

But if it's that important I can make the change to these patches for v10.

Logan
