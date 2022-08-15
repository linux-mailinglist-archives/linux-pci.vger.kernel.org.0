Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5DF592D45
	for <lists+linux-pci@lfdr.de>; Mon, 15 Aug 2022 12:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbiHOI6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Aug 2022 04:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiHOI6v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2022 04:58:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BE520F53;
        Mon, 15 Aug 2022 01:58:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B91460F7E;
        Mon, 15 Aug 2022 08:58:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B403BC433D7;
        Mon, 15 Aug 2022 08:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660553929;
        bh=BqH/4KtYjxbCwUUl+LU32sSE5MD8q5kMSnS0XBF9Bt4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gEn5jVDeyFy0f1Io+cvIpMoR/lZuNLQOEtYhEh/MsTFrdSQLsgfxtZLyxTXlmjiNf
         JPs985fMu1hoSw0YKEj6UAySKrouzovKRCjqeAS693zmQ42rM1jwm/Rznh6NZH/9a5
         sZ2U3Di0ZbWeTZwegrxUqtaytvG9QiLfFe/Wci/0R/YlZkTwOj0YsrOu8FHwdqS3NX
         7gKm6Q0hnAWni1rZvl4mtCa3Lrqqy01yTc3kKNCMTJvQBHehiWrTSQfZ19OdSmu4XU
         TUFLpUwEta0ZV5WPxkXicDE+gJgLu23iDU7g18gx5brJT7IByoRz+BdqDiJuH91PuR
         OD2Mc8Us324Xw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oNVvr-0032af-A2;
        Mon, 15 Aug 2022 09:58:47 +0100
Date:   Mon, 15 Aug 2022 09:58:46 +0100
Message-ID: <87czd1vq61.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>
Subject: Re: [EXT] Re: [PATCH v4 2/4] irqchip: imx mu worked as msi controller
In-Reply-To: <PAXPR04MB918614DF535DA7FBADC956F988699@PAXPR04MB9186.eurprd04.prod.outlook.com>
References: <20220812215242.2255824-1-Frank.Li@nxp.com>
        <20220812215242.2255824-3-Frank.Li@nxp.com>
        <875yiwsdq2.wl-maz@kernel.org>
        <PAXPR04MB918614DF535DA7FBADC956F988699@PAXPR04MB9186.eurprd04.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: frank.li@nxp.com, tglx@linutronix.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev, lznuaa@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 14 Aug 2022 04:12:01 +0100,
Frank Li <frank.li@nxp.com> wrote:

> > > new file mode 100644
> > > index 0000000000000..bb111412d598f
> > > --- /dev/null
> > > +++ b/drivers/irqchip/irq-imx-mu-msi.c
> > > @@ -0,0 +1,443 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * NXP MU worked as MSI controller
> > 
> > Freescale? Or NXP? Please make up your mind.
> 
> 
> [Frank Li] NXP and freescale is the same thing. 
> It is mux used at many place.

Pick one, and stick to it. Having two names for the same thing is
pointlessly confusing.

> > > +static struct irq_chip imx_mu_msi_irq_chip = {
> > > +     .name = "MU-MSI",
> > > +     .irq_ack = irq_chip_ack_parent,
> > 
> > Crucially, no irq_write_msi_msg callback. So we happily inherit
> > platform_msi_write_msg() and use the per descriptor write_msg()
> > callback. Who sets this? Nobody.
> 
> [Frank Li] when set flag MSI_FLAG_USE_DEF_CHIP_OPS, 
>  irq_write_msi_msg callback will be set at function platform_msi_update_chip_ops();

That wasn't my question. But never mind, I found the call to
platform_msi_domain_alloc_irqs() in patch #4.

> > > +
> > > +     /* Initialize MSI domain parent */
> > > +     msi_data->parent = irq_domain_create_linear(fwnodes,
> > > +                                                 IMX_MU_CHANS,
> > > +                                                 &imx_mu_msi_domain_ops,
> > > +                                                 msi_data);
> > 
> > Consider setting the bus_token attribute for this domain to something
> > that isn't the default, as it otherwise clashes with the following
> > creation.
> 
> [Frank Li] Any suggestion? Which bus_token is good?

DOMAIN_BUS_NEXUS is what other drivers use.

> > > +     priv->pd_a = dev_pm_domain_attach_by_name(dev, "a");
> > 
> > I'm sorry, but you'll have to come up with something slightly more
> > descriptive than "a" or "b". At least add a qualifier to it. Same
> > thing for the DT by the way.
> 
> [Frank Li] MU spec using  term "A side" and "B side".  So I think "a" and "b"
> is enough.

No, it really isn't.

> 
> Or do you think "a-side" is better?

No, I would like something fully descriptive. The DT actually has
"Processor A-facing", which seems like a reasonable description.

	M.

-- 
Without deviation from the norm, progress is not possible.
