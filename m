Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF6637963
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 13:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiKXMzE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 07:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiKXMyu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 07:54:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A871B107E5B;
        Thu, 24 Nov 2022 04:54:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D8D6B827D8;
        Thu, 24 Nov 2022 12:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16E8C433D6;
        Thu, 24 Nov 2022 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669294451;
        bh=V5Ct+9bqvBPWuh076CoHPRE/29NUQNRrG0U/Nm/7Djg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iEvc2wJ4jmANwhSreZ+OukC9UTWTvLrkkG3SW8tkEv5BOeXRhj6MaBorEn9Y9CzGD
         jHIo4Stl3NgtqsQUlELzKHsB+3sP7WZDo0VqG2b3dULPl4e0lU3EPjhg/EKTUqYK5g
         4iEsPvX2jaF/mZWM7EGk/cguiRp1Q2nKIwBWzzHJesad6o+11rTHV/PncR1OxHbs1y
         jmwl8YcnQxElovDYif/7OwqZ4vtrc0R+USTNv4ogPVn31FPkbURUpBhXKiTc/BVkay
         o5+3AFpqiuwP3fSo1AGcKFcmrxxiP0uqiwZSvhEwXu+IVHvG2a3kRK41mp5fXrMwrt
         UDOIDD2WJJSFg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oyBk0-008NOp-Py;
        Thu, 24 Nov 2022 12:54:08 +0000
Date:   Thu, 24 Nov 2022 12:54:08 +0000
Message-ID: <865yf4o6mn.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [patch V2 04/40] irqchip/gic-v2m: Mark a few functions __init
In-Reply-To: <20221121140048.534395323@linutronix.de>
References: <20221121135653.208611233@linutronix.de>
        <20221121140048.534395323@linutronix.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, will@kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com, gregkh@linuxfoundation.org, jgg@mellanox.com, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, ammarfaizi2@gnuweeb.org, robin.murphy@arm.com, lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org, ssantosh@kernel.org, linux-arm-kernel@lists.infradead.org, vkoul@kernel.org, okaya@kernel.org, agross@kernel.org, andersson@kernel.org, mark.rutland@arm.com, shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 21 Nov 2022 14:39:33 +0000,
Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> They are all part of the init sequence.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v2m.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.
