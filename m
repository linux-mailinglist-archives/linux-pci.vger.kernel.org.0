Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B479370616D
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 09:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjEQHlU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 May 2023 03:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjEQHlP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 03:41:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4BC35AB
        for <linux-pci@vger.kernel.org>; Wed, 17 May 2023 00:41:13 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64ab2a37812so11123408b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 17 May 2023 00:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684309273; x=1686901273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V4bcnuH4rJtJgBqr01lPK+xs70SyHiO9bI8F2exjHbE=;
        b=QOacduidkWGR7Y8H/XJBiyG4FWbLDnZIKvm1x2VqSmDmYQtg+xFDcrdU9dk9aS6Da4
         I05AO7pEOF1jbCh90x/JBWkstOKz0m2Z6pDt3jF1BswGdORryqcqKzWiO6Ro/AafzBnO
         YN1mprbu/bm28IehbXVw9ZsdkFnd7nCzJClCpo6CC6K8zC5iUd3T5uXu0kjPYTQyyDMk
         SqydgbAZnRGro99wzVD9rO40bHaIHPB9j9A9RbaZzo0YkmeVrEEW59WsbilVCC6szFMm
         38NUm4wAmS/bP7TRFHCxuIUt8cnXbmeUyxdP8PJ8COMcTqzGId8JoPWSYtn5atsLvjGK
         MehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684309273; x=1686901273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4bcnuH4rJtJgBqr01lPK+xs70SyHiO9bI8F2exjHbE=;
        b=WcA5QiYX/h96DG5YjXu6YuLHeJaKg4lenqi2BRqcoCl5lKUS8avhtPSNiXZuOwUzT9
         2Gc2nMmIle+Vkcwz/UJwvgaeu9SeY1uj2rDPCqdjl56yOsqDmBDXsHVpFqFumI4fsksb
         XwboXjSE38l3hjHY87hsnjrZqCHa3wjUad7xOdRNr/OZ4xz0HpF+4l426sb1D67WfqyE
         cQ/Pc4ELkgKq/BoQcKVOdXq4PeBnLo7g8wfRnba+sMtWJgzQBD/+yD+g9ILSaNDGPh28
         wCLwn/7/FneiWDfBM6t4li8ilj91HF1pVM2qAluQFDRamk2JmZYq6UxqDp5EQziU7iTK
         FHsg==
X-Gm-Message-State: AC+VfDztYLvOAz7bzXZeGUOB8AjSw6GSkn4/mMrgJL6PxvPSGGoDRpVS
        qFdrylQCJm2JguuEa+ciY4fM
X-Google-Smtp-Source: ACHHUZ7JxZpRNqDvfwNdfNoZfO/9KxQIZY5Ncde1GSHFloW3dZJsMEdk5j2nXrAGQr63YljO9BU4Tg==
X-Received: by 2002:a17:902:c943:b0:1ad:1be7:2a76 with SMTP id i3-20020a170902c94300b001ad1be72a76mr1902116pla.10.1684309272737;
        Wed, 17 May 2023 00:41:12 -0700 (PDT)
Received: from thinkpad ([117.207.26.28])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709028ecc00b001ac7ab3e7ecsm9349591plo.210.2023.05.17.00.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 00:41:12 -0700 (PDT)
Date:   Wed, 17 May 2023 13:11:05 +0530
From:   Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: endpoint: Improve pci_epf_type_add_cfs()
Message-ID: <20230517074105.GJ4868@thinkpad>
References: <20230515074348.595704-1-dlemoal@kernel.org>
 <20230515074348.595704-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515074348.595704-2-dlemoal@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 15, 2023 at 04:43:47PM +0900, Damien Le Moal wrote:
> pci_epf_type_add_cfs() should not be called with an unbound EPF device,
> that is, an epf device with epf->driver not set. For such case, replace
> the NULL return in pci_epf_type_add_cfs() with a clear ERR_PTR(-ENODEV)
> pointer error return.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index 0fb6c376166f..0bf5be986e9b 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -516,7 +516,7 @@ static struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
>  
>  	if (!epf->driver) {
>  		dev_err(&epf->dev, "epf device not bound to driver\n");
> -		return NULL;
> +		return ERR_PTR(-ENODEV);
>  	}
>  
>  	if (!epf->driver->ops->add_cfs)
> -- 
> 2.40.1
> 

-- 
மணிவண்ணன் சதாசிவம்
