Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C642F641
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbhJOOyb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbhJOOya (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:54:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED12C061570;
        Fri, 15 Oct 2021 07:52:24 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so7491313pjb.0;
        Fri, 15 Oct 2021 07:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wSBkt9zYHPwlUZ1/2+m7OdxEgpbgJqT9W9WPrNpsTT4=;
        b=cd4+4EBvunAe+muc+Kj5ssmqyR/v1gZu4XoQ6Sfq9tyPLjTs++rfTRLjSaELmun2aG
         i2b1vNDWdhdMIe4twlANpIfG+N1djG5XczwFb7zy0SDUYl8BnoY9yAZR6aXN45UOSihz
         kNmgqw+6cBc3qqIwrJQXbvYq65haGMFePkaDWouycHNRp5eIlji1MDo/FPnc7ltQduvY
         ++o8BVa/VsU+VHZ+rkavg0FfKNu8KjxmzutwKyau3N/OvKJeAUMCarzPZndNMDlDPk7c
         TsCqLExSFpMLC+DW9Njm5d9Y6JG5J9BNO43qFpFeox48Vu3QKziSLticwSfTr2rzRBBd
         TpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wSBkt9zYHPwlUZ1/2+m7OdxEgpbgJqT9W9WPrNpsTT4=;
        b=CDFU6/Sv0P3WwcKuwuc43irz1Hn1ZpEjhI2krW0mIh65PqwKRKUloS+nHrbC3ENXil
         rg+mxQ+ojAOSjNPllgnHQOJ5veorXo75tb1LAwcIocBEs0Dbgl8qh/01NHmC/7YhgZH1
         j8mGM5EhX7vWV00mRSTU7SwDtFPZ7MU4LQXBK42m5EzdHSuYl3Hhj5ZT/EKpPYb6eoOP
         Zt3EQJRWQ78A8yKev2Zy9cmLJOE6pfbWntGIZGtw7OXvTyzIJd2ww8/otrsn3I1/7K9d
         5acFRqCGI71gOl5IQuHbMAlDz+mgtaLuZEyB2fyvuzBuvbmxj9ieZ80Yn8dwQ8I69W0b
         J4uQ==
X-Gm-Message-State: AOAM5313f0Hn5yWBJbID2w5pUNpq5CLs+8G/I12Erna4+0WjnacllRvj
        KlYApGhq7WkUSj/krAV+SDg=
X-Google-Smtp-Source: ABdhPJz9ueCV0j30JfV2DfEN7UWTuCXSeIzgd/QlYR21lkRRHqOiR7AruNUAHVn9UN8FS8XeNsb0wA==
X-Received: by 2002:a17:90a:5d89:: with SMTP id t9mr5655713pji.21.1634309543625;
        Fri, 15 Oct 2021 07:52:23 -0700 (PDT)
Received: from theprophet ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id b8sm5548190pfm.65.2021.10.15.07.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:52:23 -0700 (PDT)
Date:   Fri, 15 Oct 2021 20:22:10 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v2 17/24] PCI: vmd: Use RESPONSE_IS_PCI_ERROR() to check
 read from hardware
Message-ID: <20211015145210.opb72brioa5tcbtw@theprophet>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
 <0da4dfe7642bf89d954c7062a40566bf28d94da1.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0da4dfe7642bf89d954c7062a40566bf28d94da1.1634306198.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/10, Naveen Naidu wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error.  There's no real data to return to satisfy the
> CPU read, so most hardware fabricates ~0 data.
> 
> Use RESPONSE_IS_PCI_ERROR() to check the response we get when we read
> data from hardware.
> 
> This helps unify PCI error response checking and make error checks
> consistent and easier to find.
> 
> Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/controller/vmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a5987e52700e..db81bc4cfe8c 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -538,7 +538,7 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
>  		int ret;
>  
>  		ret = pci_read_config_dword(dev, PCI_REG_VMLOCK, &vmlock);
> -		if (ret || vmlock == ~0)
> +		if (ret || RESPONSE_IS_PCI_ERROR(&vmlock))
>  			return -ENODEV;
>  
>  		if (MB2_SHADOW_EN(vmlock)) {
> -- 
> 2.25.1
> 

Jonathan, I have added your Reviewed-by tag from the first version [1] of
the patch series, since this patch did not change in the version 2. I
hope that's okay. If not, I really apologize for that and can you 
please let me know how to rectify that mistake.

[1]:
https://lore.kernel.org/linux-pci/f3aca934-7dee-b294-ad3c-264e773eddda@linux.dev/T/#u

Thanks,
Naveen

