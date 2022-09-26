Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6205EB4E1
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 00:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiIZW5T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 18:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiIZW5S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 18:57:18 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46F1A2208
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 15:57:16 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id y9so5248166qvo.4
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 15:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0oTmPF8OXz/CvwH1nuIdtQazTpalf2fsvzakYLiefMI=;
        b=AAuidSESOdluh22iHoNdq1ialZQHJi8DlKeQnNqP8tWtqZ0iWgOxeNjSwkyHl3UQlo
         EaRAzbnIRBWMdo4nhZwbRFS3a20sJ7mYxHKh7Vc0kXen7QbCUiBzmJEMG/gKmdGxQQt9
         TcfjCa/9U+Ha5Bc3h5TKe+CKna/iYXcCMoCb91DUARCakDg6wnUiVm7MGAuLY0BDZYCN
         J3kDV6FsQud562i1x9eaKHSC/ucw6t+++AJcg8A+pKvW/vp+3q1yUpu1sszuNx3oK8VA
         mZZiklHsIKm1548z2J486iqmDSDhDgGH+oWZ8C1MmRSEkFMnzH98qm2RbCK7u9yUeYB7
         6hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0oTmPF8OXz/CvwH1nuIdtQazTpalf2fsvzakYLiefMI=;
        b=Z1fetzFeBg+x2xql5HrLCevLEJvQiyeI1n30+cBu1zjDYpC7NXZHKVEk5YfMgeiW49
         dIh6Ezu1AdVQ+Xy5DFl1c6KwhRHR6mHOQCKwpiUcCpTCPyDPf2kbBTGQeu5XSjLq7u1l
         3FZQcAn1UHcyBj2bT2nJ4wBlvAjfxPkNTcTaIF0j+PPsJGifS2FLPJTkKmfnI9Bk3K75
         Sxo7f6YsFrVgTgW0HEZABEtqiuSawT+sxCUFc3kcBHmtZuE8IGPrcf0AEfdpB9F2fNL0
         ipVATtfrraFB0YDdX68vZNnvT0BmTi17aIjOEVvptL2YQZgK+jGljhu2YFXAO/p2VJYC
         QJCw==
X-Gm-Message-State: ACrzQf03A2RmYzWYqRZrQc49Cnrj+5PSNUew4+ypW/rjnVk9QiPp7Xs/
        EVzrVC0sMQW6XBaa2YLYljws3w==
X-Google-Smtp-Source: AMsMyM7Fh0JEmgnwt37ZJHit80EZ1xpj8o5VJC2kJp3X5teg4vJeS+eiVLIo84JzglXvNOHGcfPCZQ==
X-Received: by 2002:a05:6214:2686:b0:4af:630c:78f2 with SMTP id gm6-20020a056214268600b004af630c78f2mr9100014qvb.52.1664233035861;
        Mon, 26 Sep 2022 15:57:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id az35-20020a05620a172300b0069fe1dfbeffsm12946809qkb.92.2022.09.26.15.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:57:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ocx2I-000O97-1t;
        Mon, 26 Sep 2022 19:57:14 -0300
Date:   Mon, 26 Sep 2022 19:57:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH v10 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <YzIuSsFpOC+VN1/P@ziepe.ca>
References: <Yy33LUqvDLSOqoKa@ziepe.ca>
 <64f8da81-7803-4db4-73da-a158295cbc9c@deltatee.com>
 <Yy4Ot5MoOhsgYLTQ@ziepe.ca>
 <2327d393-af5c-3f4c-b9b9-6852b9d72f90@deltatee.com>
 <Yy46KbD/PvhaHA6X@ziepe.ca>
 <3840c1c6-3a5c-2286-e577-949f0d4ea7a6@deltatee.com>
 <Yy48GPMdQS/pzNSa@ziepe.ca>
 <aa5d51dd-0b40-29c0-69af-e83043541d3e@deltatee.com>
 <Yy4/f+s1jOCm7dFo@ziepe.ca>
 <980899e1-532a-772b-2f6d-6fb017def50b@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <980899e1-532a-772b-2f6d-6fb017def50b@deltatee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 23, 2022 at 05:51:49PM -0600, Logan Gunthorpe wrote:

> And on further consideration I really think the correct error return is 
> important here. This will be a user facing error that'll be easy enough
> to hit: think code that might be run on any file and if the file is 
> hosted on a block device that doesn't support P2PDMA then the user
> will see the very uninformative "Cannot allocate memory" error.
> 
> Userspace code that's written for purpose can look at the EREMOTEIO error
> and tell the user something useful, if we return the correct error.
> If we return ENOMEM in this case, that is not possible because
> lots of things might have caused that error.

That is reasonable, but I'd still prefer to see it done more
centrally.

>> If we know PIN/GET is not set then we don't even need to call the
>> function because it is a NOP.

> That's not what the documentation for the function says:

> "Either FOLL_PIN or FOLL_GET (or neither) may be set... Return: true for success,
>  or if no action was required (if neither FOLL_PIN nor FOLL_GET was set, nothing
>  is done)."

I mean the way the code is structured is at the top of the call chain
the PIN/GET/0 is decided and then the callchain is run. All the
callsites of try_grab_page() must be safe to call under FOLL_PIN
because their caller is making the decision what flag to use.

Jason
