Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D396EB9C2
	for <lists+linux-pci@lfdr.de>; Sat, 22 Apr 2023 16:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjDVOta (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Apr 2023 10:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVOt3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Apr 2023 10:49:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1DB1723;
        Sat, 22 Apr 2023 07:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2543360B5E;
        Sat, 22 Apr 2023 14:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C132AC433D2;
        Sat, 22 Apr 2023 14:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682174967;
        bh=ca7toaHlMk3ObWcjoRRERK0iAtRSRmw4Urgskt6eLeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAK7C2YqAU99LS4EkB6dO4gn4d0G5eRAiSGA024uNJu2mk7ymm+Li+74aGi/p11Ts
         sj0jWVBpodsUk6WVaIZYuulokKO1DqQtsmra7DPBsBfzXmjYn6QfawaD1SlmW4goXd
         JXr5NUMmenG6aC/IXBAK12sSiL7vpUfqrfctjnVWG86WOnvQjXyPhc2hFH+UfSo1LI
         /UqtQwDIkwGro3PprWEgdJm7+h5+ThCyr2jb5todmh7QLCgY7+cWT46bIeog3H2Ewu
         6bpelWpNi958R0HEuXinGzGLQXJyxcelyBaeIKIN75597BJyArWas+3PkQYHA82qU1
         l345Fcki9VSIg==
Date:   Sat, 22 Apr 2023 20:19:18 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        fancer.lancer@gmail.com, lpieralisi@kernel.org, robh+dt@kernel.org,
        kw@linux.com, bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v13 21/22] MAINTAINERS: Update PCI DRIVER FOR RENESAS
 R-CAR for R-Car Gen4
Message-ID: <20230422144918.GR4769@thinkpad>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-22-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418122403.3178462-22-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:24:02PM +0900, Yoshihiro Shimoda wrote:
> Update this entry for R-Car Gen4's source code.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3d50a83738a4..85556bdbf6d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16156,6 +16156,7 @@ L:	linux-renesas-soc@vger.kernel.org
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

-- 
மணிவண்ணன் சதாசிவம்
