Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776C14470B3
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 22:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhKFViu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 Nov 2021 17:38:50 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:38652 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhKFViu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 Nov 2021 17:38:50 -0400
Received: by mail-wm1-f47.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso12172314wmd.3;
        Sat, 06 Nov 2021 14:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CcAJ6ICBKG1IvSjW8O6i+0U5cZl9dElL/6ILKR0KME8=;
        b=tbyK4IOFPe3Ak61dInJibY+7xzJukY6i3GR4Vpkw9agAAc9L+xjxH+oin850z1/DrJ
         Z6bwU6U9n/XVJg5wNkyByaT/XlypWDs+rdUgocyEc9+nf/zUqRlcOA3bgdISHpulnssJ
         V3pkBjI+BPJ37HauLvK/R5N4gAZ+hIh2K5DDbWSPUfqaD3Ui+7nmUemEFNHe8Nk+qe/1
         LNPx0qY0Wd01c0LlgN+1g+zcfAcOdPQnRN0COBoHAScGvRdh55uJ73u/h6O0i37fLhKz
         A88vcGSPqnEiDKGWN+9wmRN/e2kyQ+JiHN6GzY4QNiIegVdqlIJXdIYBphe05UU1ppB2
         Dq2w==
X-Gm-Message-State: AOAM531sR1I5x5cjjtZofGd10aABaCQcJBoedY95r9pWtVEZKyCf6v15
        kxNYPZXAbvxI0i6d8xcGd15THxULMF66Ig==
X-Google-Smtp-Source: ABdhPJxey59H98wTFypO3pooZjHcg9vXtQRDPUqBzPW2ZVcqIN3NYhCFb/IRgmi/HYhKJAJm/beZ2Q==
X-Received: by 2002:a1c:d1:: with SMTP id 200mr41088911wma.86.1636234567164;
        Sat, 06 Nov 2021 14:36:07 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id o8sm11797221wrm.67.2021.11.06.14.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:36:06 -0700 (PDT)
Date:   Sat, 6 Nov 2021 22:36:05 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     toan@os.amperecomputing.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: xgene-msi: Use bitmap_zalloc() when applicable
Message-ID: <YYb1RXjnXSV8xF/0@rocinante>
References: <32f3bc1fbfbd6ee0815e565012904758ca9eff7e.1635019243.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32f3bc1fbfbd6ee0815e565012904758ca9eff7e.1635019243.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christophe!

> 'xgene_msi->bitmap' is a bitmap. So use 'bitmap_zalloc()' to simplify code,
> improve the semantic and avoid some open-coded arithmetic in allocator
> arguments.
> 
> Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> consistency.

I believe, after having a brief look, that we might have a few other
candidates that we could also update:

  drivers/pci/controller/dwc/pcie-designware-ep.c
  717:	ep->ib_window_map = devm_kcalloc(dev,
  724:	ep->ob_window_map = devm_kcalloc(dev,
  
  drivers/pci/controller/pcie-iproc-msi.c
  592:	msi->bitmap = devm_kcalloc(pcie->dev, BITS_TO_LONGS(msi->nr_msi_vecs),
  
  drivers/pci/controller/pcie-xilinx-nwl.c
  470:	bit = bitmap_find_free_region(msi->bitmap, INT_PCI_MSI_NR,
  567:	msi->bitmap = kzalloc(size, GFP_KERNEL);
  637:	msi->bitmap = NULL;
  
  drivers/pci/controller/pcie-iproc-msi.c
  262:	hwirq = bitmap_find_free_region(msi->bitmap, msi->nr_msi_vecs,
  290:	bitmap_release_region(msi->bitmap, hwirq,
  
  drivers/pci/controller/pcie-xilinx-nwl.c
  470:	bit = bitmap_find_free_region(msi->bitmap, INT_PCI_MSI_NR,
  494:	bitmap_release_region(msi->bitmap, data->hwirq,
  
  drivers/pci/controller/pcie-brcmstb.c
  537:	hwirq = bitmap_find_free_region(&msi->used, msi->nr, 0);
  546:	bitmap_release_region(&msi->used, hwirq, 0);
  
  drivers/pci/controller/pcie-xilinx.c
  240:	hwirq = bitmap_find_free_region(port->msi_map, XILINX_NUM_MSI_IRQS, order_base_2(nr_irqs));
  263:	bitmap_release_region(port->msi_map, d->hwirq, order_base_2(nr_irqs));

Some of the above could also potentially benefit from being converted to
use the DECLARE_BITMAP() macro to create the bitmap that is then being
embedded into some struct used to capture details and state, rather than
store a pointer to later allocate memory dynamically.  Some controller
drivers already do this, so we could convert rest where appropriate.

What do you think?

We also have this nudge from Coverity that we could fix, as per:

  532 static int brcm_msi_alloc(struct brcm_msi *msi)
  533 {
  534         int hwirq;
  535
  536         mutex_lock(&msi->lock);
      1. address_of: Taking address with &msi->used yields a singleton pointer.
      CID 1468487 (#1 of 1): Out-of-bounds access (ARRAY_VS_SINGLETON)2. callee_ptr_arith: Passing &msi->used to function bitmap_find_free_region which uses it as an array. This might corrupt or misinterpret adjacent memory locations. [show details]
  537         hwirq = bitmap_find_free_region(&msi->used, msi->nr, 0);
  538         mutex_unlock(&msi->lock);
  539
  540         return hwirq;
  541 }
  
  543 static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq)
  544 {
  545         mutex_lock(&msi->lock);
      1. address_of: Taking address with &msi->used yields a singleton pointer.
      CID 1468424 (#1 of 1): Out-of-bounds access (ARRAY_VS_SINGLETON)2. callee_ptr_arith: Passing &msi->used to function bitmap_release_region which uses it as an array. This might corrupt or misinterpret adjacent memory locations. [show details]
  546         bitmap_release_region(&msi->used, hwirq, 0);
  547         mutex_unlock(&msi->lock);
  548 }

We could look at addressing this too at the same time.

[...]
> -	int size = BITS_TO_LONGS(NR_MSI_VEC) * sizeof(long);
> -
> -	xgene_msi->bitmap = kzalloc(size, GFP_KERNEL);
> +	xgene_msi->bitmap = bitmap_zalloc(NR_MSI_VEC, GFP_KERNEL);
>  	if (!xgene_msi->bitmap)
>  		return -ENOMEM;
>  
> @@ -360,7 +358,7 @@ static int xgene_msi_remove(struct platform_device *pdev)
>  
>  	kfree(msi->msi_groups);
>  
> -	kfree(msi->bitmap);
> +	bitmap_free(msi->bitmap);
>  	msi->bitmap = NULL;
>  
>  	xgene_free_domains(msi);

Thank you!

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

	Krzysztof
