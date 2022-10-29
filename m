Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4A6612190
	for <lists+linux-pci@lfdr.de>; Sat, 29 Oct 2022 10:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJ2Ip2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Oct 2022 04:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ2IpZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Oct 2022 04:45:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540ED1911C1;
        Sat, 29 Oct 2022 01:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33C2360E07;
        Sat, 29 Oct 2022 08:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1953C433C1;
        Sat, 29 Oct 2022 08:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667033122;
        bh=vzWoq0o5W51YIJT+YPewX9yLmMuvgvJek06xaJJrXM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhwA36J/p4M9sV8vr/h/SCpd5u8/AVnPwdLBM72KPlWUFWG3+57xYBuN84p/2jDxR
         QS3WRrwcXiej2e+zmkuDGfNf0fj8W+E8cKm5Rc2E9kpq45vjY3GdtSJ3bW6F9wL8rT
         iRFBHbHW/RcXo5nJPkvoYNh45S2ZCheTXnxPNjbdXqEOX+a/G+Jurfz02K4vcztyT7
         zSAMLyNO6cFL7EeDcib9Mnr0FzsvLvhBV6GLJeVlzItj25GtKsMIgV1VmSwbHkFAc/
         dcOgOf/wT5IBWX+upXFFH9prXBTzKrBiEFMGfQiULKoTAmJKNsfFB9A4vbU9uAiZxF
         mJA85ai6J6Rqg==
Date:   Sat, 29 Oct 2022 16:45:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, marex@denx.de, tharvey@gateworks.com,
        vkoul@kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        alexander.stein@ew.tq-group.com, richard.leitner@linux.dev,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v1] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL
 configurations
Message-ID: <20221029084514.GT125525@dragon>
References: <1666590189-1364-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666590189-1364-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 24, 2022 at 01:43:09PM +0800, Richard Zhu wrote:
> Add PCIe SYSPLL configurations, thus the internal SYSPLL can be used as
> i.MX8MP PCIe reference clock.
> 
> The following properties of PHY dts node should be changed accordingly.
>   - Set 'fsl,refclk-pad-mode' as '<IMX8_PCIE_REFCLK_PAD_OUTPUT>'.
>   - Change 'clocks' to '<&clk IMX8MP_CLK_HSIO_ROOT>'.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Applied, thanks!
