Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D795A9D2C
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 18:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbiIAQdV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Sep 2022 12:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiIAQdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Sep 2022 12:33:17 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D5896753;
        Thu,  1 Sep 2022 09:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=gWB7AkU129dDdxRryZ2jSpLBk9x3EnCafEtHnrURW1U=; b=tzIU9tkaQtRCXK/eQMdFUjouq/
        OLtnRxLdR21K25rOsuC+rxqm88C8fy+h5QFzqBi5dr+pejTjEcIOtgtfluefiWi8f+Z0TyEsGMkUM
        RDqnH0TVRjgNzHYN+Ijg6jowNK+jo5x3fdGoCdNLzu9SoyK7hAn45jikbhtgsg21e5bnkOkYaJ0yn
        KCfM22nWcOfx7h4G5F8xF93Ds76Ovr1puzkD8KNrduc9/bMuCmkmGfieORAwe4SPRikaF6SE1c1ny
        igT/8FqPdbeNMVjMAsiLVNpvf758gTZlwhapo93t6+wJQ/e5hwMvcYXbMDQ7gQ/58Uu62aFQJ5lO3
        wjlC7nqw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1oTn7x-00DuVQ-Oi; Thu, 01 Sep 2022 10:33:14 -0600
Message-ID: <33207035-17b3-4873-afba-51a0665ca30c@deltatee.com>
Date:   Thu, 1 Sep 2022 10:33:12 -0600
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
 <20220825152425.6296-9-logang@deltatee.com> <YxDbQ3CBlQVvQFIW@kroah.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YxDbQ3CBlQVvQFIW@kroah.com>
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
Subject: Re: [PATCH v9 8/8] ABI: sysfs-bus-pci: add documentation for p2pmem
 allocate
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-09-01 10:18, Greg Kroah-Hartman wrote:
> On Thu, Aug 25, 2022 at 09:24:25AM -0600, Logan Gunthorpe wrote:
>> Add documentation for the p2pmem/allocate binary file which allows
>> for allocating p2pmem buffers in userspace for passing to drivers
>> that support them. (Currently only O_DIRECT to NVMe devices.)
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-pci | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>> index 6fc2c2efe8ab..dca5e032b4fa 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>> @@ -171,7 +171,7 @@ Description:
>>  		binary file containing the Vital Product Data for the
>>  		device.  It should follow the VPD format defined in
>>  		PCI Specification 2.1 or 2.2, but users should consider
>> -		that some devices may have incorrectly formatted data.  
>> +		that some devices may have incorrectly formatted data.
>>  		If the underlying VPD has a writable section then the
>>  		corresponding section of this file will be writable.
>>  
> 
> Not relevant change :(

Oops! Will fix.

Thanks,

Logan
