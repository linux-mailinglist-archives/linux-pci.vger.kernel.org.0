Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C240B7857A2
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 14:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjHWMKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 08:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbjHWMKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 08:10:46 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AC810CC;
        Wed, 23 Aug 2023 05:10:24 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4ffa6e25ebbso5698641e87.0;
        Wed, 23 Aug 2023 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692792289; x=1693397089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOtlzFwCZlWFrzNlcJudJuqdCg7UjxskRfwUZppRIts=;
        b=nLRLgywXA85oe4Q5F9kN923CIHdHVthlOdBjRDnsI+nlzosSSj7Ri4KQk5elrYpyJf
         102my7+JkDWe8RCrIZzSxBimeQeMLHCUydvhSINz4psPn/pTtjCPv5HYO1O1+tvihT/v
         PorUsMuitupKyflOeOlEvCwURABZjcq9SONIOXN9nZRAZgN2dvs70pi805MO78dV2Uvh
         BzWUPIupYpOvBXuNO3rya0POfCXR3u6YuhkidAeHd4zxW5ArQsyxz78QlyYmyXnDQ5N/
         OmiNec8ffoHeNKHz8GCbjNU7RYiIv/tALj//7LomW9DONTndToz4AdTQANSPHhCEK7rP
         KEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692792289; x=1693397089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOtlzFwCZlWFrzNlcJudJuqdCg7UjxskRfwUZppRIts=;
        b=Eho7qTmBnOaBspqMcKht80wxvWh0EL82GNlixalFLdrlkezohDsxCA19hu/U1rGIMb
         zfnUsZowu48+iTJd1BwBzpYoRwIWDXis0Jj5atiKe/hP+8Duk0LR10Pzvcihi0skoST4
         FAKH0dpLv+FKDwN2aVkgJNnNvmNjg/QHqax/H5lLSLkOTR076ZmxuG4r2BwAdm/dPbK2
         qR3FGUzjW1nFzlhC6vt/weUpIFxPxHc+ivoru6r92VxQZlTRMR+g7wa1uj1UQ7HejDs2
         mQf4SrlEVylKflEEaLpBXAIUBKqRhOiYLR4Uks3JcPLQoWTNj9fob1buJyyncX0kkEj6
         m8vw==
X-Gm-Message-State: AOJu0YwpiRaHfNSspZ+MooGyKo+sKx1y3LlHyEdDi3yGjsAj1PjrWqh6
        309/fikVz1X5azHmLzRvWsg=
X-Google-Smtp-Source: AGHT+IEfaUBFuQATRm8bIMprdI3Qj5jwwAUAoa0ndKHmapMKw1Do3Wq5rPVJZo5fEAAuow0g/9/BhA==
X-Received: by 2002:a05:6512:3708:b0:4fe:bfa:9d8b with SMTP id z8-20020a056512370800b004fe0bfa9d8bmr3854994lfr.12.1692792288891;
        Wed, 23 Aug 2023 05:04:48 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f16-20020ac251b0000000b004ff92971139sm2606589lfk.95.2023.08.23.05.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 05:04:48 -0700 (PDT)
Date:   Wed, 23 Aug 2023 15:04:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v19 18/19] MAINTAINERS: Update PCI DRIVER FOR RENESAS
 R-CAR for R-Car Gen4
Message-ID: <oqlxa7ajgtdduv4ghawdcrtopafkbrsfghyj5qj2mifpwrxkxp@3wbkuuinnpo4>
References: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
 <20230823091153.2578417-19-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823091153.2578417-19-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 23, 2023 at 06:11:52PM +0900, Yoshihiro Shimoda wrote:
> Update this entry for R-Car Gen4's source code.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 20a0f7411efd..c2e41c52f48c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16374,6 +16374,7 @@ L:	linux-renesas-soc@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/*rcar*
>  F:	drivers/pci/controller/*rcar*
> +F:	drivers/pci/controller/dwc/*rcar*
>  
>  PCI DRIVER FOR SAMSUNG EXYNOS
>  M:	Jingoo Han <jingoohan1@gmail.com>
> -- 
> 2.25.1
> 
