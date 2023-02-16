Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D552B699BF2
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 19:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBPSMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 13:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBPSMK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 13:12:10 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B455950AD1
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 10:12:06 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ja21so2868907plb.13
        for <linux-pci@vger.kernel.org>; Thu, 16 Feb 2023 10:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hcDgeVfUhfmz8IwQ6VSNlxJydteCF1nqY6zwjGhL1XE=;
        b=audfm7HxgI5GehILPrPovaO73LbLVQeitaSr0EcBMbNptFL+flMw/VkZfxJX5+Y2om
         cM4Ckrg8rOza6E2tD9jcMRz0/zWChTkA+Q0TYnkffDIoPPj+sk2QcftoxuqGNjAtJuTk
         BRbwHFB0YxFXEyvj2W62yj7DHn/RjT3GNzHnOR0xikQqN9ZLRSczxi+Wzh6eVcaL3PtQ
         GO1qF2cirTBriwFxbR0Lk3lLJPVSswKShfEwYkGnNu+LVZNH5yvlvcfXYvMND/50gvZG
         j4bTNk+FWoqejZ3YRHmyf6FiE+mrZUwSV/WLmY79oeL4JPoDF+JJKwSL24CmGaA73roH
         Fqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcDgeVfUhfmz8IwQ6VSNlxJydteCF1nqY6zwjGhL1XE=;
        b=zYUX8wn0jZJwrUby8ew9SJ+eBCabNLTqw5KcwNwvCulG8G+xEhU7PJU1t2szyi8B+8
         r+xoszGbJ3xRW3srHV3TMKX0KCmIc//BuhEFWCW8wUIOBZenujwZa2XXGIaPE1v+sOo4
         uD1oQ3TNo0r8ruDrwIUGJZzfOloEkJ9a1NXk0+dBkkINp7X4nocLLLD3KTxIG5uE2jJb
         6z5x+5m45cfP1ZojVKHOxxhqtJwi/QRtOBcz/MpZ//DfZchsCD3QjmptTq1wnMuH8rOO
         9dYQ0ui4mcrf1OqDd2DUlp2yWdDOIPHoXdooLkdDDD823Bcqp4MKCkFRYFFFHE8Tag7l
         84RA==
X-Gm-Message-State: AO0yUKWcgh1u9/Se7Y2aw2vuiwlpYjgg4uotn0yhtqojix2zuwd1UHmO
        9ow/PJVyqB6PP7oq9NTp2aY6
X-Google-Smtp-Source: AK7set8bOpBs5drLbVaZkaWgHSg1clF1gqoDV9iRWkFEwHuqTROHoJxBIpjAoXHAVe3Qy605P2jlqA==
X-Received: by 2002:a17:902:c944:b0:196:88b8:8616 with SMTP id i4-20020a170902c94400b0019688b88616mr8204787pla.5.1676571126058;
        Thu, 16 Feb 2023 10:12:06 -0800 (PST)
Received: from thinkpad ([117.217.179.87])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902d38d00b0019b4ee071ddsm24352pld.209.2023.02.16.10.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:12:05 -0800 (PST)
Date:   Thu, 16 Feb 2023 23:41:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 4/7] kbuild, PCI: endpoint: remove MODULE_LICENSE in
 non-modules
Message-ID: <20230216181157.GB7015@thinkpad>
References: <20230216152410.4312-1-nick.alcock@oracle.com>
 <20230216152410.4312-5-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230216152410.4312-5-nick.alcock@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 16, 2023 at 03:24:07PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c   | 1 -
>  drivers/pci/endpoint/pci-epc-core.c | 1 -
>  drivers/pci/endpoint/pci-epc-mem.c  | 1 -
>  drivers/pci/endpoint/pci-epf-core.c | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index d4850bdd837f..4b8ac0ac84d5 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -728,4 +728,3 @@ module_exit(pci_ep_cfs_exit);
>  
>  MODULE_DESCRIPTION("PCI EP CONFIGFS");
>  MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 2542196e8c3d..dd750ad29485 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -861,4 +861,3 @@ module_exit(pci_epc_exit);
>  
>  MODULE_DESCRIPTION("PCI EPC Library");
>  MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index a97b56a6d2db..7dcf6f480b82 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -260,4 +260,3 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
>  
>  MODULE_DESCRIPTION("PCI EPC Address Space Management");
>  MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 9ed556936f48..2036e38be093 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -568,4 +568,3 @@ module_exit(pci_epf_exit);
>  
>  MODULE_DESCRIPTION("PCI EPF Library");
>  MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
> -MODULE_LICENSE("GPL v2");
> -- 
> 2.39.1.268.g9de2f9a303
> 

-- 
மணிவண்ணன் சதாசிவம்
