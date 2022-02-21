Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E314BD849
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 09:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiBUIcU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 03:32:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343665AbiBUIcU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 03:32:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94E726E2;
        Mon, 21 Feb 2022 00:31:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6457F610A0;
        Mon, 21 Feb 2022 08:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2433EC340E9;
        Mon, 21 Feb 2022 08:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645432315;
        bh=1OUb5ueXqaPD8ToS2GOvrc3KNL1RMvWCGpfF22Z4Nak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z70eQxS4jkkXz5A6TA6vpAMMDkIxUQrOvESJvOwB6r3yshPsawn6kz4Q53hGjlu81
         iZ1hZjpRtjibX8zmXDT5cSoaqdRC6TRSxSyUu7EoMf4OAhdPxdlNSLcZbnkNKKlueS
         C67osf2oL0WHFplDQ/qML8l44F0S+Rq466R/V4ddjDkkdW9VXzva5EnSaSyHba7xc/
         rgrU1CKNTXy2oOe6V/fqPGeIQ8h9bHrL2piFRAUhHuy+rILEPnEQFS3HjUQGi6JxZh
         vToZMpq+9QIPHmIdrwRDmkMxmsUgbRn5wWiWuAZYZibov+IwaZ4nyE7p4vL6wwG+sK
         KpRnLtwJGvgCg==
Date:   Mon, 21 Feb 2022 16:31:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v4 1/2] ARM: dts: imx6qp-sabresd: Enable PCIe support
Message-ID: <20220221083149.GS2249@dragon>
References: <1645425237-4071-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645425237-4071-1-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 21, 2022 at 02:33:56PM +0800, Richard Zhu wrote:
> In the i.MX6QP sabresd board(sch-28857) design, one external oscillator
> is powered up by vgen3 and used as the PCIe reference clock source by
> the endpoint device.
> 
> If RC uses this oscillator as reference clock too, PLL6(ENET PLL) would
> has to be in bypass mode, and ENET clocks would be messed up.
> 
> To keep things simple, let RC use the internal PLL as reference clock
> and set vgen3 always on to enable the external oscillator for endpoint
> device on i.MX6QP sabresd board.
> 
> NOTE: This reference clock setup is used to pass the GEN2 TX compliance
> tests, and isn't recommended as a setup in the end-user design.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Applied, thanks!
