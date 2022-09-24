Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9445E88B6
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 08:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiIXGSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 02:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiIXGS0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 02:18:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFABEC577;
        Fri, 23 Sep 2022 23:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9081B80E10;
        Sat, 24 Sep 2022 06:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83236C433C1;
        Sat, 24 Sep 2022 06:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664000300;
        bh=N8A1EAkzo8qHknJSPdQjAbz2LO4T4wabU3U9XHAUm94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJjfpE/Y1SKb1ltXgBy50w1iWKjSmQR5abyIDKiBPTsDX8m90GheUVBDEcZctHhmO
         GnNpWCwObfHMx+MpX6VZhrLKgjzKzRM60M8VxYUR7YoV+7bH7EGHLb7hkNlgu4rGff
         azj+Cx0OsUkhbmpA1ciGYZbH7QDKDroFZ1LWUrGqJkKxOKolHAYYlWSL+bSH8kN27l
         DafnX1ilRy0g1pxk2+1biSibaNcc1rK3APk0ayPfGI18QDFKyHa4n9FyNkaV0tC69j
         fWdROvPcH0AiLzvlBvOzMpholuiXqJHnCafaxap3291iu/sduU3JZzKDMc4NLYW4a1
         Iy4ffvonUeRuQ==
Date:   Sat, 24 Sep 2022 11:48:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 1/9] phy: define submodes for PCIe PHYs
Message-ID: <Yy6hJyivbbQ+sI3n@matsya>
References: <20220909091433.3715981-1-dmitry.baryshkov@linaro.org>
 <20220909091433.3715981-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909091433.3715981-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 09-09-22, 12:14, Dmitry Baryshkov wrote:
> Define two submodes to be used for the PCIe PHYs, where required.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  include/linux/phy/phy.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index b1413757fcc3..bd60c1a72988 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -45,6 +45,15 @@ enum phy_mode {
>  	PHY_MODE_DP
>  };
>  
> +/*
> + * Submodes for the PHY_MODE_PCIE, allowing the host to select between RC (Root
> + * Complex) and EP (End Point) PHY modes.
> + */
> +enum {
> +	PHY_SUBMODE_PCIE_RC,
> +	PHY_SUBMODE_PCIE_EP,
> +};

This can be dropped see include/linux/phy/pcie.h


> +
>  enum phy_media {
>  	PHY_MEDIA_DEFAULT,
>  	PHY_MEDIA_SR,
> -- 
> 2.35.1

-- 
~Vinod
