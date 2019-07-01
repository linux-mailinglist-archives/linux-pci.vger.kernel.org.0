Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA91F44D2A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 22:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfFMUPC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 16:15:02 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59582 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfFMUPC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 16:15:02 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hbW7f-00041s-Vm; Thu, 13 Jun 2019 14:15:00 -0600
To:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, nouveau@lists.freedesktop.org
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-8-hch@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4ff7926e-7021-7b7f-93b4-c745055d06b5@deltatee.com>
Date:   Thu, 13 Jun 2019 14:14:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613094326.24093-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: nouveau@lists.freedesktop.org, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvdimm@lists.01.org, bskeggs@redhat.com, jgg@mellanox.com, jglisse@redhat.com, dan.j.williams@intel.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 07/22] memremap: move dev_pagemap callbacks into a
 separate structure
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-13 3:43 a.m., Christoph Hellwig wrote:
> The dev_pagemap is a growing too many callbacks.  Move them into a
> separate ops structure so that they are not duplicated for multiple
> instances, and an attacker can't easily overwrite them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/device.c              |  6 +++++-
>  drivers/nvdimm/pmem.c             | 18 +++++++++++++-----
>  drivers/pci/p2pdma.c              |  5 ++++-
>  include/linux/memremap.h          | 29 +++++++++++++++--------------
>  kernel/memremap.c                 | 12 ++++++------
>  mm/hmm.c                          |  8 ++++++--
>  tools/testing/nvdimm/test/iomap.c |  2 +-
>  7 files changed, 50 insertions(+), 30 deletions(-)

Looks good to me,

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
