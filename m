Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B01035B604
	for <lists+linux-pci@lfdr.de>; Sun, 11 Apr 2021 18:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbhDKQFB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Apr 2021 12:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbhDKQFA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Apr 2021 12:05:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DED0C061574;
        Sun, 11 Apr 2021 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=OfYeXEbcZ2dQLXe32NAiMreYt7e+j2YilXYgYD7vcYM=; b=wJnQe9XDsqBi47Cv39rJhU6S8L
        q3CvSKCWWgj/BFOQ1TuwfakZGrXuGlaH8VkKR0jtDZ18aqx/eGe3MGZ8IqS2NdU37GbQDkLu3KTj2
        pi/annc4J68zHWeWKa+zkN1tkviKkW/THTKhpkQalt+4vr0sSoAhPUDyE/FjdrWlrg8/FBOY1zADi
        gXp9BTnp58YalRmnZwApQTf8PvT1eqeyjRhKUF5n/0gpP7l458s96fJnIVtDUP0Sp8IatyhGof8Pe
        84PgfgxcGbSxsA8Tu4RwnKz55gV03FmShQCOFZbzi3D9De9iXx1eRok1CwpKmUzpVWorDlQkUwD7v
        YOxe3RHA==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVcZk-0039xe-EG; Sun, 11 Apr 2021 16:04:42 +0000
Subject: Re: [PATCH] PCI: endpoint: fix incorrect kernel-doc comment syntax
To:     Aditya Srivastava <yashsri421@gmail.com>, bhelgaas@google.com
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210411101508.11065-1-yashsri421@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <42f7fe6e-6f53-5572-f3e0-0dfd0e3d921b@infradead.org>
Date:   Sun, 11 Apr 2021 09:04:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210411101508.11065-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/11/21 3:15 AM, Aditya Srivastava wrote:
> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> There are certain files in include/linux/pci*, which follow this syntax,
> but the content inside does not comply with kernel-doc.
> Such lines were probably not meant for kernel-doc parsing, but are parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warnings from kernel-doc.
> 
> E.g., presence of kernel-doc like comment in include/linux/pci-ep-cfs.h at
> header causes this warnings by kernel-doc:
> "warning: expecting prototype for PCI Endpoint ConfigFS header file(). Prototype was for __LINUX_PCI_EP_CFS_H() instead"
> 
> Similarly for other files too.
> 
> Provide a simple fix by replacing such occurrences with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/pci-ep-cfs.h | 2 +-
>  include/linux/pci-epc.h    | 2 +-
>  include/linux/pci-epf.h    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/pci-ep-cfs.h b/include/linux/pci-ep-cfs.h
> index 662881335c7e..3e2140d7e31d 100644
> --- a/include/linux/pci-ep-cfs.h
> +++ b/include/linux/pci-ep-cfs.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
> -/**
> +/*
>   * PCI Endpoint ConfigFS header file
>   *
>   * Copyright (C) 2017 Texas Instruments
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index b82c9b100e97..80197a6df371 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/**
> +/*
>   * PCI Endpoint *Controller* (EPC) header file
>   *
>   * Copyright (C) 2017 Texas Instruments
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 6833e2160ef1..c43912b1d2d0 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/**
> +/*
>   * PCI Endpoint *Function* (EPF) header file
>   *
>   * Copyright (C) 2017 Texas Instruments
> 


-- 
~Randy

