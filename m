Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0357EEE5E
	for <lists+linux-pci@lfdr.de>; Fri, 17 Nov 2023 10:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjKQJVx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Nov 2023 04:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjKQJVx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Nov 2023 04:21:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92DAB9;
        Fri, 17 Nov 2023 01:21:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C308FC433C7;
        Fri, 17 Nov 2023 09:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700212909;
        bh=2mZX9u29xZfHKgA9s34oDJVqlDQJH00HmsfuuSS5lB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWQCTFJyWPGSBSV4ofhLTBvZnzB95IAD/SVmAXxZ4dpS2nXRQ9ahrSo3WMARDWc4D
         gG/wQJVXuzAhk8wTNf/17jmiT3zOSsorn/WfxJmD0ifJI++5a9HZiUpjHd4EPmU2LH
         4EDrHP9KtqvTTbsb+MUofrS5LKoHtYMzCSGsoj9Thglau+52TURPbp3CK6JETN1uom
         27sUgRZQTtgIFiqPH31LXO92bjcWD/jrATy88MOiWFy/Cjh3NcD9GsefkaLnN4X/Tu
         hLrQTKUPoArMUw2qNZ8LtpKjmqX4zBJqY4/QoZRtGEwgrRACb2ySnfVy0jmjUbGMRt
         nxn3GXmWpuZGg==
Date:   Fri, 17 Nov 2023 14:51:41 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 5/6] PCI: iproc: fix -Wvoid-pointer-to-enum-cast
 warning
Message-ID: <20231117092141.GG250770@thinkpad>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-6-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114055456.2231990-6-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 14, 2023 at 02:54:55PM +0900, Yoshihiro Shimoda wrote:
> From: Justin Stitt <justinstitt@google.com>
> 
> When building with clang 18 I see the following warning:
> |       drivers/pci/controller/pcie-iproc-platform.c:55:15: warning: cast to smaller
> |                integer type 'enum iproc_pcie_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |          55 |         pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);
> 
> This is due to the fact that `of_device_get_match_data` returns a void*
> while `enum iproc_pcie_type` has the size of an int. This leads to
> truncation and possible data loss.
> 

As Geert noted, this statement is wrong as there is no possible data loss in
this driver. Please fix it in next version.

> Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-iproc-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
> index acdc583d2980..83cbc95f4384 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -52,7 +52,7 @@ static int iproc_pltfm_pcie_probe(struct platform_device *pdev)
>  	pcie = pci_host_bridge_priv(bridge);
>  
>  	pcie->dev = dev;
> -	pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);
> +	pcie->type = (uintptr_t) of_device_get_match_data(dev);
>  
>  	ret = of_address_to_resource(np, 0, &reg);
>  	if (ret < 0) {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
