Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4845E8662
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 01:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiIWXv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 19:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiIWXv4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 19:51:56 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDB5132D62;
        Fri, 23 Sep 2022 16:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=cUg53KE3fCr2/FM4+1kQkCEVRqSvO20HjqayFNgCRrQ=; b=HQCDu9xSfwPWo2IPeb8laTwEUj
        aojQ22j+YpDB7arOxLtqv/XTjJlXZ14DxoQIoRSdqO2DCxXtXccBs828NSjTpfdIGgdmDgM6+wRgP
        H145SxIcGPfhB3EO80i9LWj9O/Z3rL9Y3orfoCINZt7lo/yVWySkPWiFwacu+xqZWrboA7/l2ZAm5
        MJzV/MqzvOXwjZ/UCNMEpP7LsmnGp//2QHFY4w+PoiSiN6mNCWxR7AWP219xKbRPoGBnONMrFVDNd
        p7X5PblnErvbuQu2sXqwpEGBfpOLMlK/UxRj5Nq2iLzHNBVH35xZckDyFI6l67EYyPdbXRkLcRIdf
        hXRZbR7A==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1obsSW-009191-O4; Fri, 23 Sep 2022 17:51:54 -0600
Message-ID: <980899e1-532a-772b-2f6d-6fb017def50b@deltatee.com>
Date:   Fri, 23 Sep 2022 17:51:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
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
 <20220922163926.7077-2-logang@deltatee.com> <Yy33LUqvDLSOqoKa@ziepe.ca>
 <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
 <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
 <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
 <Yy46KbD/PvhaHA6X@ziepe.ca>
 <3840c1c6-3a5c-2286-e577-949f0d4ea7a6@deltatee.com>
 <Yy48GPMdQS/pzNSa@ziepe.ca>
 <aa5d51dd-0b40-29c0-69af-e83043541d3e@deltatee.com>
 <Yy4/f+s1jOCm7dFo@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <Yy4/f+s1jOCm7dFo@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v10 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting PCI
 P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-09-23 17:21, Jason Gunthorpe wrote:
> On Fri, Sep 23, 2022 at 05:14:11PM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2022-09-23 17:07, Jason Gunthorpe wrote:
>>> On Fri, Sep 23, 2022 at 05:01:26PM -0600, Logan Gunthorpe wrote:
>>>>
>>>>
>>>>
>>>> On 2022-09-23 16:58, Jason Gunthorpe wrote:
>>>>> On Fri, Sep 23, 2022 at 02:11:03PM -0600, Logan Gunthorpe wrote:
>>>>>>
>>>>>>
>>>>>> On 2022-09-23 13:53, Jason Gunthorpe wrote:
>>>>>>> On Fri, Sep 23, 2022 at 01:08:31PM -0600, Logan Gunthorpe wrote:
>>>>>>> I'm encouraging Dan to work on better infrastructure in pgmap core
>>>>>>> because every pgmap implementation has this issue currently.
>>>>>>>
>>>>>>> For that reason it is probably not so relavent to this series.
>>>>>>>
>>>>>>> Perhaps just clarify in the commit message that the FOLL_LONGTERM
>>>>>>> restriction is to copy DAX until the pgmap page refcounts are fixed.
>>>>>>
>>>>>> Ok, I'll add that note.
>>>>>>
>>>>>> Per the fix for the try_grab_page(), to me it doesn't fit well in 
>>>>>> try_grab_page() without doing a bunch of cleanup to change the
>>>>>> error handling, and the same would have to be added to try_grab_folio().
>>>>>> So I think it's better to leave it where it was, but move it below the 
>>>>>> respective grab calls. Does the incremental patch below look correct?
>>>>>
>>>>> Oh? I was thinking of just a very simple thing:
>>>>
>>>> Really would like it to return -EREMOTEIO instead of -ENOMEM as that's the
>>>> error used for bad P2PDMA page everywhere.
>>>
>>> I'd rather not see GUP made more fragile just for that..

And on further consideration I really think the correct error return is 
important here. This will be a user facing error that'll be easy enough
to hit: think code that might be run on any file and if the file is 
hosted on a block device that doesn't support P2PDMA then the user
will see the very uninformative "Cannot allocate memory" error.

Userspace code that's written for purpose can look at the EREMOTEIO error
and tell the user something useful, if we return the correct error.
If we return ENOMEM in this case, that is not possible because
lots of things might have caused that error.

Logan

