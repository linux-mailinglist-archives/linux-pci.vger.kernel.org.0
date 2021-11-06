Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF6C4470D6
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 23:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhKFWET (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 18:04:19 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:36490 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKFWET (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 18:04:19 -0400
Received: by mail-pf1-f171.google.com with SMTP id m26so12298795pff.3;
        Sat, 06 Nov 2021 15:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cdijwmbE+Gok2D35zYgws7Fn1ESkfBiSMTeCRhjYSyo=;
        b=6Z7+b9Ob8mI2rUy7xwjnYYeWLzuCIJeKRH05sNzdnoliAM/2FUljpbHg137lzA1lgr
         kxiGo7CHfRNrpXUcXs7MjZ7YdSDzK+3m7brdiqhhWlxv+GPoexK3H9+DWxlt2vjAIi/o
         Abi1hay6GBXka5AOfA7AB4C9wlKxZLNZ+HRhjzOkEy5HeTetGA1gUs0cMFUVqfv/igIv
         LCiC8dsgjOxAgLlZCYZgxx8k2k6q8E3FDRpK9GmFnV8StcjRUhyYDqh7K57v0Fu9G5aB
         Af43yTOq9ZdcxY7+4/W/1zQ78BlqHBLmljj2LMO26QI3fGcVKQNyVeskhncfuU2L/boF
         2uMw==
X-Gm-Message-State: AOAM533w0cnfQ//fLjeF0OKa2T7CpCjf8kYBCQ2z2RKJ6li7yyzkAn9Y
        sNo6188Lm+AQwjn7pFu4oMc=
X-Google-Smtp-Source: ABdhPJz9muR0T7/dEWrrsLy+TeL8BzV3LacdWxPLr23AGZVhlOyKjoHnpbWgKNuHc9Iw6l2L6WtFrg==
X-Received: by 2002:a62:3387:0:b0:44d:7ec:906a with SMTP id z129-20020a623387000000b0044d07ec906amr70369382pfz.69.1636236097442;
        Sat, 06 Nov 2021 15:01:37 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y6sm11506784pfi.154.2021.11.06.15.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 15:01:37 -0700 (PDT)
Date:   Sat, 6 Nov 2021 23:01:27 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Use 'bitmap_zalloc()' when applicable
Message-ID: <YYb7NwlYcmsdw8AR@rocinante>
References: <01eba3c86137eb348f8cce69f500222bd7c72c57.1635058203.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01eba3c86137eb348f8cce69f500222bd7c72c57.1635058203.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christophe,

> 'mem->bitmap' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
> improve the semantic and avoid some open-coded arithmetic in allocator
> arguments.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.

Thank you!

> Finally, while at it, axe the useless 'bitmap' variable and use
> 'mem->bitmap' directly.

Personally, I would keep the bitmap variable - this might be what Bjorn
would also prefer, as I believe he prefers not to store what is a "failed"
state of sorts in a target variable directly, if memory serves me right.

[...]
> @@ -49,10 +49,8 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>  			   unsigned int num_windows)
>  {
>  	struct pci_epc_mem *mem = NULL;
> -	unsigned long *bitmap = NULL;
>  	unsigned int page_shift;
>  	size_t page_size;
> -	int bitmap_size;
>  	int pages;
>  	int ret;
>  	int i;
> @@ -72,7 +70,6 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>  			page_size = PAGE_SIZE;
>  		page_shift = ilog2(page_size);
>  		pages = windows[i].size >> page_shift;
> -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
>  
>  		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
>  		if (!mem) {
> @@ -81,8 +78,8 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>  			goto err_mem;
>  		}
>  
> -		bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> -		if (!bitmap) {
> +		mem->bitmap = bitmap_zalloc(pages, GFP_KERNEL);
> +		if (!mem->bitmap) {
>  			ret = -ENOMEM;
>  			kfree(mem);
>  			i--;
> @@ -92,7 +89,6 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>  		mem->window.phys_base = windows[i].phys_base;
>  		mem->window.size = windows[i].size;
>  		mem->window.page_size = page_size;
> -		mem->bitmap = bitmap;
>  		mem->pages = pages;
>  		mutex_init(&mem->lock);
>  		epc->windows[i] = mem;
> @@ -106,7 +102,7 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
>  err_mem:
>  	for (; i >= 0; i--) {
>  		mem = epc->windows[i];
> -		kfree(mem->bitmap);
> +		bitmap_free(mem->bitmap);
>  		kfree(mem);
>  	}
>  	kfree(epc->windows);
> @@ -145,7 +141,7 @@ void pci_epc_mem_exit(struct pci_epc *epc)
>  
>  	for (i = 0; i < epc->num_windows; i++) {
>  		mem = epc->windows[i];
> -		kfree(mem->bitmap);
> +		bitmap_free(mem->bitmap);
>  		kfree(mem);
>  	}
>  	kfree(epc->windows);

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
