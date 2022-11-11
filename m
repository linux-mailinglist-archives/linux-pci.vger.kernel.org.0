Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B0B6263E7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 22:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiKKVxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 16:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbiKKVxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 16:53:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7396B203
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 13:53:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49352B82801
        for <linux-pci@vger.kernel.org>; Fri, 11 Nov 2022 21:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E3AC433D6;
        Fri, 11 Nov 2022 21:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203583;
        bh=kMpKZ8vLkyFvZZVkqQQnXpiLJNSHatIpPrEvRjjj5ns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bwJWLDCCdsgSDrJogY/ok0QqyUfL8BIS2jmPF8+NOIYulnAlrja6r84ZHTWhwuIGk
         +EwxB1+R0oJTRkvl3PXZrLiNnvNoob/9TWHz4FnOy87D9tgrAcyiqSPj1S2mmWnEeQ
         eiCY3abYH7hX92Y2teY2yi4yEAGuyG8cIJSe+Nwtt0adNqA6jKZ8X9nuPltX2XYFZo
         4S8WG/1MNaPH9mrCyie0uk5U83D5/0l1k/KSYBwt9NxUiZjNftP6ERpRNmW5ld+GXQ
         +sK7zmkX+e75TSKNTMTy1ZafxXJyklwOXlEgro2L35Q6o/ylw+wMMHCKf/WNK4AqEm
         7WbbJQe9xB8Qw==
Date:   Fri, 11 Nov 2022 15:53:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-pci@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] PCI: imx6: Initialize PHY before deasserting core
 reset
Message-ID: <20221111215301.GA749191@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166818222626.230065.5220320291788502712.b4-ty@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 04:57:46PM +0100, Lorenzo Pieralisi wrote:
> On Tue, 1 Nov 2022 10:57:14 +0100, Sascha Hauer wrote:
> > When the PHY is the reference clock provider then it must be initialized
> > and powered on before the reset on the client is deasserted, otherwise
> > the link will never come up. The order was changed in cf236e0c0d59.
> > Restore the correct order to make the driver work again on boards where
> > the PHY provides the reference clock. This also changes the order for
> > boards where the Soc is the PHY reference clock divider, but this
> > shouldn't do any harm.
> > 
> > [...]
> 
> Applied to pci/dwc, thanks!
> 
> [1/1] PCI: imx6: Initialize PHY before deasserting core reset
>       https://git.kernel.org/lpieralisi/pci/c/ae6b9a65af48

cf236e0c0d59 appeared in v6.0; should we add a stable tag to this?
