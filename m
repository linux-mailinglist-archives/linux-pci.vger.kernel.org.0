Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE92C53BC89
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 18:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiFBQbH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 12:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbiFBQbH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 12:31:07 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9405A2AD994
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 09:31:01 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id ew15so3749798qtb.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Jun 2022 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k8kPkxVeNMtdQt55yGN/Nkf+fdNFP4n1eqHNYFzt/EM=;
        b=RBKGIdGVGyENiynuzvWzxsfKrlShOYG7LDNM6zk7j/0cpFAWM0CNoQ/RikC676Zwip
         BMHOMh5FSPCGjY61J1z6G+8c1X+4G/XGBmJ3fum6tDtClMi6od+zOdkcyAAKXb0oiOit
         b12jjL7nGu0mjk8vwPx18er2whDmGOBIM4slv0jp+xyv6iWVZkV8Hkprx2Ft3TnlNr8S
         F3ZKnuaS0udbsMCk0y55d04otKL6PRXBEyvPN62xIots/ndr10XIEf2q5FJvYZj2hwlD
         Ppp12ccOTvvIFXm+WxGW6jlLIOBk5xmPC4ktWEJBo/O94h/wW5jv5ZkhHpnGnc8M8pyV
         u4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k8kPkxVeNMtdQt55yGN/Nkf+fdNFP4n1eqHNYFzt/EM=;
        b=sSDQoJOZMSzNAnoDsyB+JPqt+KljdhqhibVxxoM3QQwIPiRU2g2lUpV7erQBXCMyTR
         qMRtdyGCotaVPlEDiui6MqtZBr0NIn0SPcSSnm4SGKHk3Dcp8rCmaX48iO7c6wzbSc3j
         TE7B4QlDWpPOJJKa/Q/pGl3gojtLukVkVfhesy0kRPdEChUTMWSOymskeopkk+CfuW3e
         RQlGPxHxfy3iPQqzfU4dmjw6l2Zwcdsy3Gvj9HkP732EkBe0MjMVRTfyJK+MQ4BsBDju
         lbUetjpp5hqqbXJ58YMHyGRpsACLnYWAKyLiYO2o8HI+b3+iasuCLLTe/xjLAbKC091H
         vnnA==
X-Gm-Message-State: AOAM530JD7iE0ZVtbnGMvH2f1sbiiGF1GMHrLkA9ktnedPoOBmD9hTKE
        j/U3LhFKVYZ/l/7BF59hWcGeeA==
X-Google-Smtp-Source: ABdhPJzLJBnwcPaBtEw6VCmlLIOgqY/pJrxby5kBrBBtbBNr2VGXxQBgSbsEw14Z2kEr0zlwr/+sfg==
X-Received: by 2002:ac8:5e49:0:b0:304:c7db:6a2f with SMTP id i9-20020ac85e49000000b00304c7db6a2fmr4316676qtx.274.1654187460731;
        Thu, 02 Jun 2022 09:31:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id ci11-20020a05622a260b00b00304bc2acc25sm3261689qtb.6.2022.06.02.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 09:30:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nwnit-00GTLv-7Y; Thu, 02 Jun 2022 13:30:59 -0300
Date:   Thu, 2 Jun 2022 13:30:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
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
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220602163059.GL2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
 <20220602000038.GK2960187@ziepe.ca>
 <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 10:16:10AM -0600, Logan Gunthorpe wrote:

> > Just stuff the pages into the mmap, and your driver unprobe will
> > automatically block until all the mmaps are closed - no different than
> > having an open file descriptor or something.
> 
> Oh is that what we want?

Yes, it is the typical case - eg if you have a sysfs file open unbind
hangs indefinitely. Many drivers can't unbind while they have open file
descriptors/etc.

A couple drivers go out of their way to allow unbinding while a live
userspace exists but this can get complicated. Usually there should be
a good reason.

The module will already be refcounted anyhow because the mmap points
to a char file which holds a module reference - meaning a simple rmmod
of the driver shouldn't work already..

Jason
