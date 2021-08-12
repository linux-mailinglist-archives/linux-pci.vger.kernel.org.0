Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5283EA769
	for <lists+linux-pci@lfdr.de>; Thu, 12 Aug 2021 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhHLPUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Aug 2021 11:20:14 -0400
Received: from ale.deltatee.com ([204.191.154.188]:37382 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbhHLPUO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Aug 2021 11:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=PKp4W4qwnsg62z2wXCRhtczYMFeb9uAucEAPy5+yRUc=; b=lfGL4sZtOMz/KSu32rwX/F8Vz+
        uvP9Is+dxbnsyP5LEBqi72g0z2SYPz3EcCOTyAmgK4N/RNxXfM8pObUdj8byxvjU5z3jpjeTZh3i3
        g1SVCgxp9PnvNXsIUQp3BLbGAAxIcEgNoEiT1URrAdmm8mCoO1hzD9gLqWjexNPqI1RN9j65xC2Fg
        UExBquvZ6knB4LTnotRCP8IGsQeUlNHQVukclxqyYt6Ne2eIzMUl6FqAatwyOh6dGZ5PLltVyijIg
        T3FmC/7Oq0Pm1ovMBtcq8EzRT0UgKuvG3MRwFHIsRAtUuq6AQmiNrf146DlFGYD4ox72HllpzbMY8
        NEuDraNA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mECUh-0000xt-Fq; Thu, 12 Aug 2021 09:19:48 -0600
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Stephen Bates <sbates@raithlin.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20210812070004.GC31863@kili>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <065519bd-d73c-0d0e-182d-6431914d0e8d@deltatee.com>
Date:   Thu, 12 Aug 2021 09:19:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812070004.GC31863@kili>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org, sbates@raithlin.com, christian.koenig@amd.com, alex.williamson@redhat.com, bhelgaas@google.com, dan.carpenter@oracle.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] PCI: fix a scheduling in atomic bug
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2021-08-12 1:00 a.m., Dan Carpenter wrote:
> This function is often called with a spinlock held so the allocation has
> to be atomic.  The call tree is:
> 
> pci_specified_resource_alignment() <-- takes spin_lock();
>  -> pci_dev_str_match()
>     -> pci_dev_str_match_path()
> 
> Fixes: 07d8d7e57c28 ("PCI: Make specifying PCI devices in kernel parameters reusable")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

This looks good to me, but I think the fixes tag is wrong.
pci_dev_str_match_path() was introduced in this patch:

Fixes: 45db33709ccc ("PCI: Allow specifying devices using a base bus and
path of devfns")

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
