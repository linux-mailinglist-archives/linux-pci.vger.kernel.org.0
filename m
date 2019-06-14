Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4BC4514F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 03:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFNBr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 21:47:59 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19332 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfFNBr7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 21:47:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d02fcce0000>; Thu, 13 Jun 2019 18:47:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 18:47:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Jun 2019 18:47:58 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 01:47:57 +0000
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
To:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
CC:     <linux-mm@kvack.org>, <nouveau@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-6-hch@lst.de>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <d83280b5-8cca-3b28-1727-58a70648e2b9@nvidia.com>
Date:   Thu, 13 Jun 2019 18:47:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613094326.24093-6-hch@lst.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560476879; bh=W7HIzAAq5sQ4cds9yVoSXH+lwR7EoHWX9W6ILDXWS68=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=I8MPAgx2vYT6KwhZqE7Iz0XmBDUAPkhjJ2muXoBXvyuvRRzqt+N/vYMC8nbdYG25/
         WSlmXfyDpPT5QeLCb+OCPbYjTfqvYqP4DCyLjNUFaxdOx4cGM1afGuLLi0esWZSgMu
         A8GQ9BiCgUF44kc2o88bVgpXE3mC+ZezmwWJQmLHcMqWujgPfAbqMUvlo+s7Iiq7sU
         WHoYSAAnR0/4orH9jeAbwNklddZnxg4UewSkrDUWY6MGnu9yd4bNKuRV1sh4wBzCNg
         U+IAYEyyzX1/h2C96Uiqk0lQ+n/ZSuk409t8qWCUpSU856fphT2d9dv2ddj3jG5GUT
         /1wLT1eB7j1+w==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/13/19 2:43 AM, Christoph Hellwig wrote:
> noveau is currently using this through an odd hmm wrapper, and I plan

  "nouveau"

> to switch it to the real thing later in this series.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: John Hubbard <jhubbard@nvidia.com> 

thanks,
-- 
John Hubbard
NVIDIA

>  mm/mempolicy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 01600d80ae01..f9023b5fba37 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2098,6 +2098,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  out:
>  	return page;
>  }
> +EXPORT_SYMBOL_GPL(alloc_pages_vma);
>  
>  /**
>   * 	alloc_pages_current - Allocate pages.
> 
