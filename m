Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F274365D8
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 17:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhJUPVn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 11:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUPVm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Oct 2021 11:21:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE09EC061764;
        Thu, 21 Oct 2021 08:19:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w17so632607plg.9;
        Thu, 21 Oct 2021 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qqnDqCjJmkwkqd0tn31z39TZlTbK4LZW1iNa62QCR2Q=;
        b=M/8LCnv10ewNtUivz51HXcBWK6M0VB9kFf5a+WtqK7XOSKxrr1pryerPOEyB413IAZ
         ExogKFflc0njjFMjEJusTcTGvZg44eISwwxw/J8CSPjR8pI7EOUnPsFNyh6ldXKoVu16
         XH5N6LecXdiYNcMXCTsBc0jHEX8c/O1TvDdthlJhPM5HQk0Xad6fjCrINfY4Ilfy4HgB
         2zeFrHw2ZE+m/QeyDjGF6lW8jx50xlYyyvY1zzjJ1T01JmbUgskTJa8o+OZZvcWQsuZF
         MCvNps4TW4ejZHSBpqsWl2YJvLCpZAjh4lrZVclpLCkCYM+8rHXDL3YshzYFw4wg+hVM
         /9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qqnDqCjJmkwkqd0tn31z39TZlTbK4LZW1iNa62QCR2Q=;
        b=4I/vGw1M624G8uo+DKO2R8Xv7McE795ZKcNB6byzNGO6ZkFB0Xl7/VeM3Lw+A3DJJt
         eKIh8JkXFn0K7ifU/AlzLzARourB5cORfW/nL4tu5heN2HqNoKT2/+Uqf4A7m09GQ18+
         c7ai8D38dCKb7c3pLbN1W8V1xW2e/gSDFfxLfOjFKa797Ikd0ZNXTDV36U+XMlzQJrPd
         S95FD0RL2cEfUbo6yV9PDlRaxHXyLePuNZ6nOCCl3wOj7inlWarJ+1g9S7CANvZGQvY7
         adRvSGzwgUCYZ8B9iB5x6ecjZhFPqV/5vJvp8c+5TDcp1WN9lRhj8ebeD8SoUk+XNRjq
         MZPA==
X-Gm-Message-State: AOAM531Icx738DpiMHs6GS/R25NzBSvH7J9aWBEyUlg3K+7Dol1f6MDq
        aO8XWF7weqAEZKf6GP5FxK0=
X-Google-Smtp-Source: ABdhPJxWG4HWHVbrBkYtNB1WueaH3dHRXvd0ib8tuJTqdS2XP+ju8Dy0G8bIm+dXVb370gRSNoJnnA==
X-Received: by 2002:a17:90a:2acf:: with SMTP id i15mr3194179pjg.91.1634829566382;
        Thu, 21 Oct 2021 08:19:26 -0700 (PDT)
Received: from theprophet ([2406:7400:63:29a4:d874:a949:6890:f95f])
        by smtp.gmail.com with ESMTPSA id a27sm6466171pfl.20.2021.10.21.08.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:19:25 -0700 (PDT)
Date:   Thu, 21 Oct 2021 20:49:13 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v3 17/25] PCI: vmd: Use RESPONSE_IS_PCI_ERROR() to check
 read from hardware
Message-ID: <20211021151913.nmnvfhqnyepnfok2@theprophet>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
 <5be1fdfdcf4b4a453117ef4dea0f71c9555fac24.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be1fdfdcf4b4a453117ef4dea0f71c9555fac24.1634825082.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/10, Naveen Naidu wrote:
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
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  drivers/pci/controller/vmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index a5987e52700e..bfe6b002ffec 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -538,7 +538,7 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
>  		int ret;
>  
>  		ret = pci_read_config_dword(dev, PCI_REG_VMLOCK, &vmlock);
> -		if (ret || vmlock == ~0)
> +		if (ret || RESPONSE_IS_PCI_ERROR(vmlock))
>  			return -ENODEV;
>  
>  		if (MB2_SHADOW_EN(vmlock)) {
> -- 
> 2.25.1
> 

Jonathan, I haven't added your Reviewed-by tag to this patch which you
gave in v1 of the series [1] , because the macro definition of the
RESPONSE_IS_PCI_ERROR changed slightly, and I was not sure if you would
be okay with it. I hope it was right thing to do, if not I apologize for
that.

[1]:
https://lore.kernel.org/linux-pci/f3aca934-7dee-b294-ad3c-264e773eddda@linux.dev/T/#u

Thanks,
Naveen
