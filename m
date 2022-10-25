Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9339B60CED9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 16:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiJYOWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiJYOWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 10:22:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4188E982
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 07:22:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h14so11003820pjv.4
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vZVnPGsAheVchMmW+27sKWAExzhNFnjGwmynQxqPwGo=;
        b=ICUkuoioTTbT4J3PQNG+F2mm8o+HTAEkYCXtGoXB2o+mCQfo7DmlBXq9deAQi2YA0d
         DXO1h6CakTsqFcctttj6fLpfnlvnTCU+vbdOY2r7v6GpUAQchYPKU9hmtIauunE10RLa
         urTKrDuq7mYXhbP5CTE4YzU8j3SlzXpGnWLrlFzHk/sJ4mkKIaubrfsvc016XlPIL+MT
         KtlHDsb1hOofH3vZ0cEhh7FUuXRh/TllJxI4pXhtEcHn0OEuxxCS6UHZ+vzlVniYtvg4
         WQ74Ev0UEg5iRVT9eFFBJhkOmoUuRR+b83dOxu3w3AoKFoQlC6DRm2d/Usk8gRsb9Hip
         RxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZVnPGsAheVchMmW+27sKWAExzhNFnjGwmynQxqPwGo=;
        b=T9DouxkHbdey8cbLmyY0DZD0ycPwRyiJ1mk6Ag16fjewjSFLcvolIk0fVWpdeChF5u
         lPacDSkGQEgtyp3KEnHQw5USDbHeiE03jiXQt6EZY2QAxjQJ+NO3BS1u/1IMLG2BNEgD
         BnIWUHultF7NH6Y9/8QJiR2oKPhGJ8MhEQ+6yOMUdRnupAOcvIVJWeV7vare30PryuqL
         VWy4XdWUXAOdR/u4U5Q8qxECpS/4kgU87Eh93qNc7QmsB7pASzSiEVypjXC2CPtYt3jt
         Z8EdzQrlUX3f4ZMth6n7CQEQ0m/PkreEtgGvdQSJ5k4T+gozQtNnLIgwMEpBSxXqy+9Z
         fRHw==
X-Gm-Message-State: ACrzQf2R5VqbNWHhc7mK/wXEwtPxzCrodZQ/v3bgPKYFwnh3XQkcF/FM
        FXb3F9OVZ1a2sAxl0iklLV7JSaqT9qgH2tZNjg==
X-Google-Smtp-Source: AMsMyM5y60S7QrNea7GsbgN5+3CO8qxmJZ5wOr77JsZm8qxHaKY9g3W64Y1U52K5AOMxzWE1dDdrdw==
X-Received: by 2002:a17:902:9684:b0:17e:71b2:bd16 with SMTP id n4-20020a170902968400b0017e71b2bd16mr38661973plp.163.1666707713299;
        Tue, 25 Oct 2022 07:21:53 -0700 (PDT)
Received: from thinkpad ([117.193.208.236])
        by smtp.gmail.com with ESMTPSA id r17-20020a63ce51000000b0041a6638b357sm1322578pgi.72.2022.10.25.07.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:21:52 -0700 (PDT)
Date:   Tue, 25 Oct 2022 19:51:43 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check for no
 epc alignment constraint
Message-ID: <20221025142143.GA109941@thinkpad>
References: <20220922092357.123732-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922092357.123732-1-mie@igel.co.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 22, 2022 at 06:23:57PM +0900, Shunsuke Mie wrote:
> Some PCI endpoint controllers have no alignment constraints, and the
> epc_features->align becomes 0. In this case, IS_ALIGNED() in
> epf_ntb_config_spad_bar_alloc() doesn't work well. Check for this before
> IS_ALIGNED().
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes in v2:
> * Fix the commit message in phrasings and words.
> ---
> ---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index 9a00448c7e61..f74155ee8d72 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -1021,7 +1021,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
>  	peer_size = peer_epc_features->bar_fixed_size[peer_barno];
>  
>  	/* Check if epc_features is populated incorrectly */
> -	if ((!IS_ALIGNED(size, align)))
> +	if (align && (!IS_ALIGNED(size, align)))
>  		return -EINVAL;
>  
>  	spad_count = ntb->spad_count;
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 0ea85e1d292e..5e346c0a0f05 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -418,7 +418,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	size = epc_features->bar_fixed_size[barno];
>  	align = epc_features->align;
>  
> -	if ((!IS_ALIGNED(size, align)))
> +	if (align && !IS_ALIGNED(size, align))
>  		return -EINVAL;
>  
>  	spad_count = ntb->spad_count;
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
