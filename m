Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1925E7E53
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiIWP0M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 11:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiIWP0L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 11:26:11 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF25113F737;
        Fri, 23 Sep 2022 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=C81BnwO1LLn7rzdtw/smuBPO9/byip/ucPGw7WJmXyg=; b=EJgXMvWjdf974BGnhZ/H5B5xwv
        NXJvfp4f6oUfUKuWpK1vn1hJDJ0w7XSUyC8/69ObFbcR/PleMfld5liF8hFbsFBeRRknZIjUPWs3X
        yXCrUnVnYpYjPoX7DA9F2T28JKXXJEIV7eTiD4lUYvbR+CyKq571MvlRFoZLyNdx9mPjUl2mvtlUo
        4fENvdIPwCyPgnqLNKCqyCRjsdhyoNHJAHPEzP7urRTm3wzaZDx02UPRrCfibr/1UFAwFMnP9bcfC
        s6eTzyHYgenOqLfahifc1Kx60xlysc8n5Vi/VtS1oTf1H5v275xPlJz5io+LMX8mSVIvh25GxjhUK
        dq0M7DHg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1obkYz-008uiH-2J; Fri, 23 Sep 2022 09:26:01 -0600
Message-ID: <47004362-15ec-5356-6c1e-ba69b1910cef@deltatee.com>
Date:   Fri, 23 Sep 2022 09:25:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220923060123.GA15698@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220923060123.GA15698@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: hch@lst.de, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v10 0/8] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2022-09-23 00:01, Christoph Hellwig wrote:
> Thanks, the entire series looks good to me now:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Given that this is spread all over, what tree do we want to take it
> through?

Yes, while this is ostensibly a feature for NVMe it turns out we didn't
need to touch any NVMe code at all.

The most likely patch in my mind to have conflicts is the iov_iter patch
as there's been a lot of churn there in the last few cycles and there
are continued discussions.

There are 2 PCI patches, but Bjorn's aware of them and has acked them.
I'm also fairly confident this shouldn't conflict with anything in his tree.

Besides that, there is one mm/gup patch which is the next likely to
conflict; one scatterlist patch and three block layer patches which have
largely been stable when I've done rebases.

Logan
