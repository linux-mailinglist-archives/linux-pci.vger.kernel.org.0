Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D891769768
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 15:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjGaNXU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 09:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbjGaNXT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 09:23:19 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD63A10E3
        for <linux-pci@vger.kernel.org>; Mon, 31 Jul 2023 06:23:17 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686f94328a4so2527179b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 31 Jul 2023 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690809797; x=1691414597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qWRJRiQjhcIU2rxsvfqdUS+hVCke4c8k+gpJmIwq2XM=;
        b=Gj9CfjZZxP65634Ss1MxYKQeqAb4Qe3HXr46yVI6+wj860qJKhyy9kJ2ijW2riQ/CX
         L8zKpjHJTz7g2mFwmLX2Oq1NsbQ6kc6iA7oK03mJnRWOTrS6kPwF/GwYvz39GhHWACE1
         RWkK/jNANlY5EHHsqjubzBUu4IfGZ6dwrMZpVf/NL+tNsTtlz+/HT7MMwUHX61S7wj7e
         KhIA6uhamwZeSIQgLZAGXa4TsmDhx2eaurdtYraP9QPSnE9gPKeF2+LxtEZ/75oDr1aV
         Q61TfeTrVkg1hiBEfpANsYLu6xewla8AlhXX5dNJ1LOc9Z79k6xrgjO1OsAqu/VnTOVK
         WA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690809797; x=1691414597;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWRJRiQjhcIU2rxsvfqdUS+hVCke4c8k+gpJmIwq2XM=;
        b=ejfbLjvhUNWEw2aZpNqKjLVk2scLSYcK/l4hbrxlAmG8WYVrk9DR2kJ/+dQ72lAEHG
         JA4ZIeGMqqrUaLBg6z/0/h/9HC3GrUxnwLnBgG8MTY9piD5UP3j/C/HfWBrVFprzzC5J
         7CCjrNASQv2Hm0/WM7S5Zh/xIXRwmynXLGosLTxDH0JklkiILOnbXVa7WNXguS51MFjP
         UCRYPYzQbJW/ZqoLDGP5SJliGZGGalL4r0dh9sAhwmKE9tFj7E5zL2lBmxfzAKFtT163
         sBhGSiq059ItWMZsRKxr1Whz+i4fpiqdfrcT68CMuJGWV6FufZm+U1YWi9VVwxOviGe2
         eMDA==
X-Gm-Message-State: ABy/qLaBFj0OJJ/X5ZDGcethEahGXklq6dJaRAkiq/J7tWjJtgOv1Frm
        pnG0By+/Yv3J8AKu550VGoko
X-Google-Smtp-Source: APBJJlEH1aib7CiVu5gcwf4AE0T5Y8leDtplNYz7rYhpebx0GRldV84W89ScmvX7OXBvA1czoT/14A==
X-Received: by 2002:a05:6a00:2e8d:b0:667:d0ff:6a0f with SMTP id fd13-20020a056a002e8d00b00667d0ff6a0fmr11480177pfb.5.1690809797044;
        Mon, 31 Jul 2023 06:23:17 -0700 (PDT)
Received: from thinkpad ([117.193.209.129])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78394000000b0063f1a1e3003sm7624993pfm.166.2023.07.31.06.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 06:23:16 -0700 (PDT)
Date:   Mon, 31 Jul 2023 18:53:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] PCI: dwc: Provide deinit callback for i.MX
Message-ID: <20230731132306.GA6436@thinkpad>
References: <20230731-pci-imx-regulator-cleanup-v2-1-fc8fa5c9893d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230731-pci-imx-regulator-cleanup-v2-1-fc8fa5c9893d@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 31, 2023 at 12:55:01PM +0100, Mark Brown wrote:
> The i.MX integration for the DesignWare PCI controller has a _host_exit()
> operation which undoes everything that the _host_init() operation does but
> does not wire this up as the host_deinit callback for the core, or call it
> in any path other than suspend. This means that if we ever unwind the
> initial probe of the device, for example because it fails, the regulator
> core complains that the regulators for the device were left enabled:
> 
> imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 16G
> imx6q-pcie 33800000.pcie: Phy link never came up
> imx6q-pcie 33800000.pcie: Phy link never came up
> imx6q-pcie: probe of 33800000.pcie failed with error -110
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 46 at drivers/regulator/core.c:2396 _regulator_put+0x110/0x128
> 
> Wire up the callback so that the core can clean up after itself.
> 
> Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> Tested-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes in v2:
> - Rebase onto v6.5-rc1.
> - Link to v1: https://lore.kernel.org/r/20230703-pci-imx-regulator-cleanup-v1-1-b6c050ae2bad@kernel.org
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 27aaa2a6bf39..a18c20085e94 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1040,6 +1040,7 @@ static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
>  
>  static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
>  	.host_init = imx6_pcie_host_init,
> +	.host_deinit = imx6_pcie_host_exit,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> 
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230703-pci-imx-regulator-cleanup-a17c8fd15ec5
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 

-- 
மணிவண்ணன் சதாசிவம்
