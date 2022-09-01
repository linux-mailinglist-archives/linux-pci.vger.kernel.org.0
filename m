Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850755A9EB9
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 20:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiIASOh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 14:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIASOg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 14:14:36 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE71C4BA7C;
        Thu,  1 Sep 2022 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=sWRKw2yHnva/fkslMEKIBYXYtsFYh9CE67WvtTKYh9o=; b=LUIvBgXNanbwZx0H1YeUvZgz+W
        ul/GPgxn/izyWHImD9lqPZLOeLp2e5DPV9+wMaetQl9lN8rbG69efLBarhCWXjJEqFRIUZ/a89fuP
        J2vlO4iHchGWdU3cW+ChfYCl/ChEYQKScgeFtoa49hZHGEdtT6Y85OqSzoLVMTuBGJioNmnxaH/y4
        UCjYLZRzU+iuvnnVzftig3939k08pTGaZkFTrGdK4tP1yGmwfkBG1jNR1SuDAFuT/Zqv/GQSQO8S7
        EQTKoaT6u/1UuhYU+UA+7NfA+KpWCAmFvy5SIcDH9GOZ2nun6awzVDrZFqUtbfU/RUz0nIA+/OJuT
        aVwiAEMg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oToi1-00Dvye-Mb; Thu, 01 Sep 2022 12:14:34 -0600
Message-ID: <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com>
Date:   Thu, 1 Sep 2022 12:14:25 -0600
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
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YxDhEO9ycZDTnbZm@kroah.com>
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




On 2022-09-01 10:42, Greg Kroah-Hartman wrote:
> On Thu, Sep 01, 2022 at 10:32:55AM -0600, Logan Gunthorpe wrote:
>> On 2022-09-01 10:20, Greg Kroah-Hartman wrote:
>>> On Thu, Aug 25, 2022 at 09:24:24AM -0600, Logan Gunthorpe wrote:
>>>> +	/*
>>>> +	 * Removing the alloc attribute from sysfs will call
>>>> +	 * unmap_mapping_range() on the inode, teardown any existing userspace
>>>> +	 * mappings and prevent new ones from being created.
>>>> +	 */
>>>> +	sysfs_remove_file_from_group(&pdev->dev.kobj, &p2pmem_alloc_attr.attr,
>>>> +				     p2pmem_group.name);
>>>
>>> Wait, why are you manually removing the sysfs file here?  It's part of
>>> the group, if you do this then it is gone for forever, right?  Why
>>> manually do this the sysfs core should handle this for you if the device
>>> is removed.
>>
>> We have to make sure the mappings are all removed before the cleanup of
>> devm_memremap_pages() which will wait for all the pages to be freed.
> 
> Then don't use devm_ functions.  Why not just use the manual functions
> instead as you know when you want to tear this down.

Well we haven't plugged in a remove call into p2pdma, that would be more
work and more interfaces touching the PCI code. Note: this code isn't a
driver but a set of PCI helpers available to other PCI drivers.
Everything that's setup is using the devm interfaces and gets torn down
with the same. So I don't really see the benefit of making the change
you propose.

Logan
