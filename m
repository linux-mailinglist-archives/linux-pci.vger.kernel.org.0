Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA2C347F37
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 18:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbhCXRWF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 13:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbhCXRWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Mar 2021 13:22:00 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71972C061763
        for <linux-pci@vger.kernel.org>; Wed, 24 Mar 2021 10:22:00 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id i19so2598634qtv.7
        for <linux-pci@vger.kernel.org>; Wed, 24 Mar 2021 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SrdP9ZidSNfCaSucoColh3TxPDb0AtWOwMrzkk0oHMo=;
        b=VqmHlOv5pk7Z6wF8FHX+TfDJjfjh921rYi4eN41NcDt/fq0DBDJOU7rhGSKU6ufyTm
         xgryyJiAucS8WZzz2ViVbQUPuCpXfg7uEEhpPzzprqcXGMGkBwD6G1BUvjJVBTwjUNRd
         pCXxJXPAOu8fNVQE1dmK+28ONbnNOcRwtDtStbIduQNJhqkB9Esrou8G0LfcvJrhW4fe
         ULycH1dWEtxvx55GhkyZoQPGnapSxw7VUycFCKDpkG8+3sa5snIG53zjQV6wfo7BiGMJ
         HJ9PrsuAPOJka52Tqjh77gZ/r2aV/d7R2K1zypTuv24H1EMPdKj6/CNzp7+bL0NdEvhW
         NVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SrdP9ZidSNfCaSucoColh3TxPDb0AtWOwMrzkk0oHMo=;
        b=tCiAD1VcUVMNlAMV9xvt5pTxtC4WSInYeIxPNh9R40FG51A/Sheis2jAPSZX5oY7wN
         fd5Sb+vILD/AjNiCe8jvRP6+LbmRNMW4qBmTlJqTGC7l8Js7GErC6ED/Wii/xNz/jEPe
         1nZz1+fzSXo0EjLh5DdxQd4na7xPnHKGtdS6XKxn2+rGKx3TtMDvB5sQU4A4XbwvV/vb
         T7WTumPa7jvDYaMt2IcqZHoLYtCDn1j1etzxfNv0FZIi9URhqLgYlCO8n4fhLsTsjzEe
         PYNSsoXjrn6HNs9TpUyWsaqEMyDVvfU3WjKxP8pmzTF92urHJ6fuW3G0VsOPBxdoTmlp
         kXKA==
X-Gm-Message-State: AOAM531H1vMywEblYT7sZePFT5a2MgGQM/CvXg3i53Ns2oS39d+HkEKw
        LFjsAkZ+/s4KKvaBgu5AixrAQw==
X-Google-Smtp-Source: ABdhPJyneQA4gaMEWYTu19JnLqKtUSbn29vkpMblQHBkTJsjZw2ELWdLSZfb1xoPTIiUK6qAC7wT3Q==
X-Received: by 2002:ac8:4d02:: with SMTP id w2mr3864955qtv.126.1616606519694;
        Wed, 24 Mar 2021 10:21:59 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id q125sm2144133qkf.68.2021.03.24.10.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:21:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lP7Cf-0025Yq-Vy; Wed, 24 Mar 2021 14:21:58 -0300
Date:   Wed, 24 Mar 2021 14:21:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 04/11] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
Message-ID: <20210324172157.GH2710221@ziepe.ca>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-5-logang@deltatee.com>
 <20210313013856.GA3402637@iweiny-DESK2.sc.intel.com>
 <7509243d-b605-953b-6941-72876a60d527@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7509243d-b605-953b-6941-72876a60d527@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 15, 2021 at 10:27:08AM -0600, Logan Gunthorpe wrote:

> In this case the WARN_ON is just to guard against misuse of the
> function. It should never happen unless a developer changes the code in
> a way that is incorrect. So I think that's the correct use of WARN_ON.
> Though I might change it to WARN and return, that seems safer.

Right, WARN_ON and return is the right pattern for an assertion that
must never happen:

  if (WARN_ON(foo))
      return -1

Linus wants assertions like this to be able to recover. People runing
the 'panic on warn' mode want the kernel to stop if it detects an
internal malfunction.

Jason
