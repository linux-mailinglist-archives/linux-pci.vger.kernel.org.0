Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D025B36F0
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 14:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIIMIK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 08:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIIMII (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 08:08:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4255212F20F;
        Fri,  9 Sep 2022 05:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BF424CE229E;
        Fri,  9 Sep 2022 12:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ED9C433D6;
        Fri,  9 Sep 2022 12:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662725278;
        bh=Lz2P15vcZ1ZdRM5cHrVBvarPsmfwgCGjAbApIl9rp5A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CCeG8HorK/8vU9xByifGY+FGtLVW8gwjYZY3c3WO1c03uSgOJ5c7qF0/eB61w5nmq
         OQkvU8vMK8tXpNVzi3imL0xTfNainAlCIgs/vEXusT1HDA6sXZDZJaeY9mhydG+ro9
         6kOeARHRaowQglhyOQe8YPwmj5d/mybpRX6r1IvJwL6x8AHtF5LSVvAL/XAMK5q/+G
         rq4Wld9gqMsi2I8MMgRgjQUQp1icUqKHWoprjqmVCcgjULEKoRS+mf2ViN/NXd+PWJ
         iYOn1skbdcD+tVuKYoMleE2RDOaCPqjoFRVaqhs6HGwc+iuHbd2PPdllOGffG+t9mx
         cg8mW+kfIi3cg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=wait-a-minute.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oWcnc-009AnD-1t;
        Fri, 09 Sep 2022 13:07:56 +0100
Date:   Fri, 09 Sep 2022 13:07:55 +0100
Message-ID: <87edwkrbs4.wl-maz@kernel.org>
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        "lznuaa@gmail.com" <lznuaa@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
Subject: Re: [EXT] Re: [PATCH v9 2/4] irqchip: Add IMX MU MSI controller driver
In-Reply-To: <AM9PR04MB8793CE5AAAB281CE628845AC88409@AM9PR04MB8793.eurprd04.prod.outlook.com>
References: <20220907034856.3101570-1-Frank.Li@nxp.com>
        <20220907034856.3101570-3-Frank.Li@nxp.com>
        <87fsh2qpq4.wl-maz@kernel.org>
        <AM9PR04MB879338D6D4B55A74CD002E6D88409@AM9PR04MB8793.eurprd04.prod.outlook.com>
        <877d2dvs0d.wl-maz@kernel.org>
        <AM9PR04MB8793CE5AAAB281CE628845AC88409@AM9PR04MB8793.eurprd04.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: frank.li@nxp.com, tglx@linutronix.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, peng.fan@nxp.com, aisheng.dong@nxp.com, jdmason@kudzu.us, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com, ntb@lists.linux.dev, lznuaa@gmail.com, imx@lists.linux.dev, manivannan.sadhasivam@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 08 Sep 2022 16:35:20 +0100,
Frank Li <frank.li@nxp.com> wrote:

> > > > > +struct imx_mu_msi {
> > > > > +     spinlock_t                      lock;
> > > > > +     raw_spinlock_t                  reglock;
> > > >
> > > > Why two locks? Isn't one enough to protect both MSI allocation (which
> > > > happens once in a blue moon) and register access?
> > >
> > > [Frank Li] Previously your comment, ask me to use raw_spinlock for
> > > read\write register access.  I don't think raw_spinlock is good for
> > > MSI allocation.
> > 
> > Why wouldn't it be good enough? I'd really like to know.[Frank Li] '
> 
> [Frank Li] According to my understand, raw_spinlock skip some lockdep
> /debug feature to get better performance, which should be used when
> Frequently call, such as irq handle\polling thread.

I'm afraid you are terribly misguided. They both have the same debug
features because they are both using the same core implementation, and
the only difference is whether this is preemptible for RT purposes or
not.

> Spinlock have DEBUG feature to check wrong use lock.  Allocate MSI generally
> only is call once when driver probe.

Again, you should really read the code and the documentation and stop
making things up.

> 
> The basic principle,  lock should be used only when necessary.  Access reg and
> Allocate msi is totally independence events.

Independent events that do not occur simultaneously. So no harm in
sharing the same lock.

	M.

-- 
Without deviation from the norm, progress is not possible.
