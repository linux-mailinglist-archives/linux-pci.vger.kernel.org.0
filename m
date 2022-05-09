Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AFF52036E
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 19:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbiEIRUg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 13:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239495AbiEIRUa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 13:20:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05D1862B1;
        Mon,  9 May 2022 10:16:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABB8F6155C;
        Mon,  9 May 2022 17:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E4DC385B1;
        Mon,  9 May 2022 17:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652116594;
        bh=VSzgCF1Rw8sMVNfysp7EwT6li5M6fLIKaI2QYnijb/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FSTsxsO1k3B5Qc/U+PoXFX+u19YKgFPoHZ0L6LSA5MOtkoPk3Xz548eE1KSBwA/Z+
         MHmjBMYSfqEvDlhzasgnCqpvFxHmd9G+HtPxg/5G+XjW0RF7Cl/GeHZDYmaIZ3Nnmw
         9hO0u7YtUlQFC+8kzyYKRmZUpZF62W4BgIfTlJgJnpbZo825OLTQUfKrBVIfOtmYP+
         me741ygsBkakT00RU6qw02wJTcm6RA6QQelt5YUgt+2NSdWwmkqkwCV1tO/PvtqRqD
         duKQVM/LRdAuRCSsnRlm2IyRUP2rfUb+OJYmSB4OHGnjY1qj0zxDPTnkSWFruEf85t
         2NxGAzNjfwQgg==
Date:   Mon, 9 May 2022 12:16:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, p.zabel@pengutronix.de,
        matthias.bgg@gmail.com, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Subject: Re: [PATCH] PCI: mediatek-gen3: Assert resets to ensure expected
 init state
Message-ID: <20220509171631.GA605998@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9839acf-e334-d73d-a0b3-57d951fb8796@collabora.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 09, 2022 at 02:18:34PM +0200, AngeloGioacchino Del Regno wrote:
> Il 04/04/22 16:48, AngeloGioacchino Del Regno ha scritto:
> > The controller may have been left out of reset by the bootloader,
> > in which case, before the powerup sequence, the controller will be
> > found preconfigured with values that were set before booting the
> > kernel: this produces a controller failure, with the result of
> > a failure during the mtk_pcie_startup_port() sequence as the PCIe
> > link never gets up.
> > 
> > To ensure that we get a clean start in an expected state, assert
> > both the PHY and MAC resets before executing the controller
> > power-up sequence.
> > 
> > Fixes: d3bf75b579b9 ("PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192")
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Friendly ping for an important fix :-)

d3bf75b579b9 appeared in v5.13-rc1 (May 2021, a year ago), so I assume
this is important for v5.19, but not urgent enough to require being in
v5.18.  Right?

> > ---
> >   drivers/pci/controller/pcie-mediatek-gen3.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> > index f7048ea4c020..dccdfce12b1c 100644
> > --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> > +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> > @@ -838,6 +838,14 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
> >   	if (err)
> >   		return err;
> > +	/*
> > +	 * The controller may have been left out of reset by the bootloader
> > +	 * so make sure that we get a clean start by asserting resets here.
> > +	 */
> > +	reset_control_assert(pcie->phy_reset);
> > +	reset_control_assert(pcie->mac_reset);
> > +	usleep_range(10, 20);
> > +
> >   	/* Don't touch the hardware registers before power up */
> >   	err = mtk_pcie_power_up(pcie);
> >   	if (err)
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
