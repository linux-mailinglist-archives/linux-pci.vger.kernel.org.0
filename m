Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA14677DE7
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 15:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjAWOYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 09:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjAWOYe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 09:24:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003372410E;
        Mon, 23 Jan 2023 06:24:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ED8C60F1E;
        Mon, 23 Jan 2023 14:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAECFC433EF;
        Mon, 23 Jan 2023 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674483871;
        bh=ebj5u9dzYTnqnlc6aYkM6fkr6bAweecaoU1qF2KA9ow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RgjmabJGqw1ELqa2NhEcYDmnv9A+oZ7Jeoe9tjjYxnArTElg9uV49XTPjcZqKt8x4
         yRq//o7h8iv2Dm1Fa+1LROKmU5jLMf5PVL3QIcYwWhBPYwlTRZzR3x5gQfOF0YAT+K
         S/a0OjPr47JrZFVSXDO5NUsxChgjY/6juNkrn1ZUNmHMtdiRIf6ReWDef2nFqytE6f
         greUtAF/btPyWKuE7k+2j1QR158+15cGvqqqHqIzHzYaLbUbKd5IxqGruJyRWYUM7G
         mZflMGn0ezQ+1YCVcCzo/UCxF4NSip2beVVwmMYk242fZYCwrJ+CelMdttPkXHpj1M
         LHDjhQhortKww==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pJxkK-0003jJ-TX; Mon, 23 Jan 2023 15:24:29 +0100
Date:   Mon, 23 Jan 2023 15:24:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 11/12] arm64: dts: qcom: sm8550: Add PCIe PHYs and
 controllers nodes
Message-ID: <Y86YnAxmTcQTmqwH@hovoldconsulting.com>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
 <20230119140453.3942340-12-abel.vesa@linaro.org>
 <Y85KiKD+iQamchB5@hovoldconsulting.com>
 <Y86AG7ev++wYiza4@linaro.org>
 <Y86WqGW6pj5re3FU@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y86WqGW6pj5re3FU@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 23, 2023 at 03:16:09PM +0100, Johan Hovold wrote:
> On Mon, Jan 23, 2023 at 02:39:55PM +0200, Abel Vesa wrote:
> > On 23-01-23 09:51:20, Johan Hovold wrote:
 
> > > > +		pcie1_phy: phy@1c0e000 {
> > > > +			compatible = "qcom,sm8550-qmp-gen4x2-pcie-phy";
> > > > +			reg = <0x0 0x01c0e000 0x0 0x2000>;
> > > > +
> > > > +			clocks = <&gcc GCC_PCIE_1_PHY_AUX_CLK>,
> > > > +				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> > > > +				 <&tcsr TCSR_PCIE_1_CLKREF_EN>,
> > > > +				 <&gcc GCC_PCIE_1_PHY_RCHNG_CLK>,
> > > > +				 <&gcc GCC_PCIE_1_PIPE_CLK>;
> > > > +			clock-names = "aux", "cfg_ahb", "ref", "rchng",
> > > > +				      "pipe";
> > > > +
> > > > +			resets = <&gcc GCC_PCIE_1_PHY_BCR>,
> > > > +				 <&gcc GCC_PCIE_1_NOCSR_COM_PHY_BCR>;
> > > > +			reset-names = "phy", "nocsr";
> > > 
> > > Do you know why only the second PHY uses two resets here? Did you intend
> > > to add it also for the first PHY?
> > 
> > Please notice that this is a g4x2 phy. The documentation specifically
> > says that both the pciephy_reset and pciephy_nocsr_reset should be
> > asserted on power-up. Now, even the g3x2 has the nocsr reset (at least
> > in GCC) but its documentation doesn't seem to say anything about
> > nocsr needed to be asserted (ever).
> 
> Ok. Thanks for confirming. I did not notice the difference in generation
> at first.
> 
> > > Both of these resets exists also on sc8280xp, and I believe downstream
> > > used the NOCSR_COM variant, which does not reset all registers in the
> > > PHY so you could unknowingly be relying on firmware to setup things up
> > > for you.
> > 
> > That is also the case for the g3x2 phy on sm8550.

One more thing: Shouldn't the second reset be named 'nocsr_com' or
similar?

Johan
