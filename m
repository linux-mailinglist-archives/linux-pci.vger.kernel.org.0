Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45A87025F3
	for <lists+linux-pci@lfdr.de>; Mon, 15 May 2023 09:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbjEOHUG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 May 2023 03:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjEOHUE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 May 2023 03:20:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698F6E6D
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 00:20:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1aaed87d8bdso87114405ad.3
        for <linux-pci@vger.kernel.org>; Mon, 15 May 2023 00:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684135203; x=1686727203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lncfMMTwbGRpxdM66jyOZHMGDe9OaKkXzVHI9UOTGKU=;
        b=tcLzgDaJTWyOpQepCChhsuHwJpFK8+P5fmDrHeEDS9MAGQ/F3XrXfwhQ81VFinUVyY
         RooepIA9ZIuty/wkztpflRJ+dHCSa9tDBtAsH1Y1CaCMyXNScWQxiy4TRKsN17E9FojQ
         k+B/fgVQ72Tok71hQX1ll8KKoZN0m5La/ExTqyhVOQGxMoOfpZCj5DBvaZXXaxntWqiE
         udVPZMPEKamYmbV3fAigISmRliEi/ogm9UHR8Ppb4tnQBOPqVWNwWTgoxlzDiPJ/mHYF
         +FFvwURP3jMVn3w2Qz5g8uyeZf0TZIfDD6QiH9J+26P5s7Axq0YSDqWeFsNRJjcBMdMw
         FkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684135203; x=1686727203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lncfMMTwbGRpxdM66jyOZHMGDe9OaKkXzVHI9UOTGKU=;
        b=RdoT0VaraleSZ+To5+NCPd3Wq40zbcnirZUweYQxf+jVc5VEvG4R7zPAE202eNAeEn
         R7J8Dl/93w5VPE3IZSBm0ZeeFe3efooDXmW4/7sTpNc0uLMUVg0WJ95UdFTCaui/F9oJ
         N17ZDqBBMhBHuqwHEo9cZF3lDB/n7oYUM5Cwx+ohKr6VhilTzOEmpmMEHQb/t3EUkkD4
         vzrwZZvqacDheFX1ZQklWtE2HlPjtYTNwtVDME1Fg/yTyPMNdAxDbDYZd3l/8KUqLH6x
         87dcNVMtARawjhjPuiGbhrlnxQ3+KsYYlwi70cjIKlorheKEnMubTkSYRiELVr8MiRH+
         GZdw==
X-Gm-Message-State: AC+VfDxUhT8o5HeFxmewLWaHPPBRdc/GLNvjqBXw3P+q+QGnBh9OpR24
        N68Gs4O4eVpIkPPKDU8IhMPg
X-Google-Smtp-Source: ACHHUZ5Aqda8tXQabS34UWDAo2FvBV1b9ref9spuUM7iqZv97okaGSdBSbioo9apOIMVS35AbRwciw==
X-Received: by 2002:a17:902:c952:b0:1ad:ca0e:cf23 with SMTP id i18-20020a170902c95200b001adca0ecf23mr18312601pla.3.1684135202785;
        Mon, 15 May 2023 00:20:02 -0700 (PDT)
Received: from thinkpad ([103.28.246.73])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902740c00b0019a5aa7eab0sm12698690pll.54.2023.05.15.00.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 00:20:02 -0700 (PDT)
Date:   Mon, 15 May 2023 12:49:58 +0530
From:   Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH 1/2] PCI: endpoint: Improve pci_epf_type_add_cfs()
Message-ID: <20230515071958.GA30758@thinkpad>
References: <20230515051500.574127-1-dlemoal@kernel.org>
 <20230515051500.574127-2-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515051500.574127-2-dlemoal@kernel.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 15, 2023 at 02:14:59PM +0900, Damien Le Moal wrote:
> pci_epf_type_add_cfs() should not be called with an unbound EPF device,
> that is, an epf device with epf->driver not set. For such case, replace
> the NULL return in pci_epf_type_add_cfs() with a clear ERR_PTR(-EINVAL)
> error return.
> 

Shouldn't the error code be -ENODEV?

- Mani

> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index 0fb6c376166f..d8a6abe2c31c 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -516,7 +516,7 @@ static struct config_group *pci_epf_type_add_cfs(struct pci_epf *epf,
>  
>  	if (!epf->driver) {
>  		dev_err(&epf->dev, "epf device not bound to driver\n");
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	if (!epf->driver->ops->add_cfs)
> -- 
> 2.40.1
> 

-- 
மணிவண்ணன் சதாசிவம்
