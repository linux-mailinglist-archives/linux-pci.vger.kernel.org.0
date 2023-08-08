Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB617741A0
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 19:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjHHRZp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 13:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbjHHRZY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 13:25:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEF020268;
        Tue,  8 Aug 2023 09:10:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1594624CB;
        Tue,  8 Aug 2023 11:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46A2C433C7;
        Tue,  8 Aug 2023 11:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691493786;
        bh=uf47QcqVVednoTyXP/D1xitpSzvvxXjJ0RJvfi2KsoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qUUbmI60+gD371c+d5N6y7GEIlxhTL0jSQyQgcYZy3sb7K6SacbY+7NvuHjoVNSG1
         WH9DqltMiROF3+twdf6p73ddnb2Hw1KfAOzYZq7P/mUBKFcJRIHAxz5oDTRh6uRDG1
         TPuI/NpY6bBziU+F/N9X+5SEFAHG9X7/3exDlA9fquqR8UEUHsaDjTl5Fd9wohD2fm
         VvyD37kojpCZemPC8cz1YSFCefwhsCxqSgTemzzGGFp8fFIvl22H3vYxRz5t9boOgf
         cMoT5j2g8ZycnSQVVbwH+GIFmJpU8n8pV+3y/uNyXtdfoy9cRqxaxjkaZBDXs2VFs2
         qDtayNRcM9nIg==
Date:   Tue, 8 Aug 2023 13:22:59 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
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
Subject: Re: [PATCH v2] PCI: dwc: Provide deinit callback for i.MX
Message-ID: <ZNIlk8YgUevE7kTH@lpieralisi>
References: <20230712-pci-imx-regulator-cleanup-v2-1-3b1f6e9d26bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712-pci-imx-regulator-cleanup-v2-1-3b1f6e9d26bc@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 12, 2023 at 12:02:57PM +0100, Mark Brown wrote:
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
> ---
> Changes in v2:
> - Rebase onto v6.5-rc1.
> - Link to v1: https://lore.kernel.org/r/20230703-pci-imx-regulator-cleanup-v1-1-b6c050ae2bad@kernel.org
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to controller/dwc, thanks.

Lorenzo

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
