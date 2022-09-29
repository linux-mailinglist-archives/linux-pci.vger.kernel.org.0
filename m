Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23E65EF36E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiI2K2O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbiI2K2N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 06:28:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C0A3BC7C;
        Thu, 29 Sep 2022 03:28:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED9CD60EDA;
        Thu, 29 Sep 2022 10:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A615AC433D6;
        Thu, 29 Sep 2022 10:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664447291;
        bh=rfQDmY92oDygtIVNdnw+T9euL5h/h39QjZglQEKk1aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s3iOTt3nKWkLfNccQOcTnd4cwRxxHkxONJxjhiKTbJAxYHiQdQysaolZnlsmOOoDK
         tUrMdSq9gLaGnPNQPB2vSFmF2jAXq896t63zvpratx5GEMlsViadx9lK3YmoYXhF1j
         dHrwz+zF+al2DL2VXORXP9e0XxmcobXfAx2sP7fl5eJSLrBJ9FACmd5E04hywPQDHE
         /VMT/FGCsMQAp30l9HcSC3v8NDfN6YaE5P9YE+8ahhnNFkDIfVRQtEKwCgHDpAIPjv
         Buq+WwXlKHtJ9Tka7GK7NYOfRAeAwHUOELwulfVctd3deowfV/91TPB5e8MsU8kt2o
         GWcMfx4maolWw==
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     kishon@ti.com, Lorenzo Pieralisi <lpieralisi@kernel.org>,
        a.fatoum@pengutronix.de, marcel.ziswiler@toradex.com,
        vkoul@kernel.org, l.stach@pengutronix.de,
        Richard Zhu <hongxing.zhu@nxp.com>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3] phy: freescale: imx8m-pcie: Fix the wrong order of phy_init() and phy_power_on()
Date:   Thu, 29 Sep 2022 12:28:04 +0200
Message-Id: <166444726328.174548.10848189569004377274.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1662344583-18874-1-git-send-email-hongxing.zhu@nxp.com>
References: <1662344583-18874-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 5 Sep 2022 10:23:03 +0800, Richard Zhu wrote:
> Refer to phy_core driver, phy_init() must be called before phy_power_on().
> Fix the wrong order of phy_init() and phy_power_on() here.
> 
> 

Applied to pci/dwc, thanks!

[1/1] phy: freescale: imx8m-pcie: Fix the wrong order of phy_init() and phy_power_on()
      https://git.kernel.org/lpieralisi/pci/c/2810b99c95b1

Thanks,
Lorenzo
