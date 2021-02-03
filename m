Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D478F30DE06
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhBCPX2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 10:23:28 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:55717 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhBCPXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 10:23:20 -0500
Received: by mail-wm1-f53.google.com with SMTP id f16so5915341wmq.5
        for <linux-pci@vger.kernel.org>; Wed, 03 Feb 2021 07:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rimIDR9hlloZkquSv305aB7B6ofN7YdeVfpFlGXOH2w=;
        b=iEjjiJZOF0M3sgbTKPN5S4a0nQeLFEZ0NljR8YLxYZDTM2KorsSbyREzRhy+4FCy7j
         b4CCTRedj80PtENVtfxvmBNrDk3LHzLVx7M2ELpnlR7isviZa8AiEzyRG4zt+o8DO7ta
         Db5l4HJGGo7WzMD1f2u5wdXXz3ZYO6fL3HtSIoWDFGZlLHuKBF6Q3ivgeKdxA/UhSsb4
         O/fpbopDoE27ogYVlkGo8AyriLOLJB32Wx5/hQnbsVOUTJSQneGbqGyiA3f8jfZwCqXB
         l0/OGWWRoTGJ0kGXHX1f9k3RJumoXXpJSKiMi9mfOMXV2aIj9pbtY0gJ0wL1BIjsu4Z9
         mofg==
X-Gm-Message-State: AOAM532C/WPJ/UfvSl/9Xk3nMhXUKlvkzXQr1Wwu8dHDywNJl82ZqUGj
        oFVnhpI985FOSpSP08k0nmo=
X-Google-Smtp-Source: ABdhPJwYO2280YiWe9YND0/bynYKUsNCPdEU+UC6UpZaL90qIKA/DHHrZcvaOOvxNAeTMm625uIh5A==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr3311837wmg.55.1612365758406;
        Wed, 03 Feb 2021 07:22:38 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id n10sm4422549wro.39.2021.02.03.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:22:37 -0800 (PST)
Date:   Wed, 3 Feb 2021 16:22:36 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI/VPD: Remove dead code from sysfs access
 functions
Message-ID: <YBq/vOYUQANn8yHN@rocinante>
References: <305704a7-f1da-a5a0-04e6-ee884be4f6da@gmail.com>
 <267eae86-f8a6-6792-a7f8-2c4fd51beedc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <267eae86-f8a6-6792-a7f8-2c4fd51beedc@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Heiner,

Thank you for cleaning this up!

On 21-02-03 09:48:03, Heiner Kallweit wrote:
> Since 104daa71b396 ("PCI: Determine actual VPD size on first access")
> attribute size is set to 0 (unlimited). So let's remove this now
> dead code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - no changes
> ---
>  drivers/pci/vpd.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> index 35559ead2..2096530ce 100644
> --- a/drivers/pci/vpd.c
> +++ b/drivers/pci/vpd.c
> @@ -403,13 +403,6 @@ static ssize_t read_vpd_attr(struct file *filp, struct kobject *kobj,
>  {
>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
>  
> -	if (bin_attr->size > 0) {
> -		if (off > bin_attr->size)
> -			count = 0;
> -		else if (count > bin_attr->size - off)
> -			count = bin_attr->size - off;
> -	}
> -
>  	return pci_read_vpd(dev, off, count, buf);
>  }
>  
> @@ -419,13 +412,6 @@ static ssize_t write_vpd_attr(struct file *filp, struct kobject *kobj,
>  {
>  	struct pci_dev *dev = to_pci_dev(kobj_to_dev(kobj));
>  
> -	if (bin_attr->size > 0) {
> -		if (off > bin_attr->size)
> -			count = 0;
> -		else if (count > bin_attr->size - off)
> -			count = bin_attr->size - off;
> -	}
> -
>  	return pci_write_vpd(dev, off, count, buf);
>  }
>  
> -- 
> 2.30.0
> 

Reviewed-by: Krzysztof Wilczyński <kw@linux.com>

Krzysztof
