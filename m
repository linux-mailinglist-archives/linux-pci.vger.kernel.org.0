Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ABF5AF72B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 23:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIFVm1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 17:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiIFVmT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 17:42:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC518670C;
        Tue,  6 Sep 2022 14:42:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7029A616ED;
        Tue,  6 Sep 2022 21:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DB0C433C1;
        Tue,  6 Sep 2022 21:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662500537;
        bh=c+ClokW/ttPFEFYMhrFMsQpYEe0Gv0ApefG2N4w/Hcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BWmyNKH/Z14CW9MBaCiaJSG+K6d/MCOjbRYB22GWuqMAWn3PCMnkem/+ob+S9QpQ9
         LBbeMJhQ06JkIGtghTu7Kk9jV/4c0rRw0o669UZV4SSe5aRBl1VrpAq8hRPcwdoUqI
         77zHmUSPpiKizfzZ8yFT4DbRZv2J0M7PyRgd/CQFxcPbFMn9AQONClMLVihax09RMp
         RVHM6YGJAd4gtLKQY39bAZ651bv+DVxtYo8AqOhs9mj70amQaOsCrgrVL3Jytyf8gE
         IiIRw8i6ooiAmA3biX+agc/zSMfAa/NFPO/k3t+K1Bj+nw6+Wy8Y5HehqU/2Xy7WgB
         wZ0JlQwQ1Xa8g==
Received: by pali.im (Postfix)
        id 819C6742; Tue,  6 Sep 2022 23:42:15 +0200 (CEST)
Date:   Tue, 6 Sep 2022 23:42:15 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
Message-ID: <20220906214215.7hmt5vpk2yzxdm2e@pali>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
 <20220906204301.3736813-2-dmitry.torokhov@gmail.com>
 <20220906211628.6u4hbpn4shjcvqel@pali>
 <Yxe7CJnIT5AiUilL@google.com>
 <Yxe+P27mwZQMZK+5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yxe+P27mwZQMZK+5@google.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 06 September 2022 14:40:15 Dmitry Torokhov wrote:
> On Tue, Sep 06, 2022 at 02:26:32PM -0700, Dmitry Torokhov wrote:
> > Hi Pali,
> > 
> > On Tue, Sep 06, 2022 at 11:16:28PM +0200, Pali Rohár wrote:
> > > Hello!
> > > 
> > > On Tuesday 06 September 2022 13:43:01 Dmitry Torokhov wrote:
> > > > This patch switches the driver away from legacy gpio/of_gpio API to
> > > > gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> > > > make private to gpiolib.
> > > 
> > > There are many pending pci-mvebu.c patches waiting for review and merge,
> > > so I would suggest to wait until all other mvebu patches are processed
> > > and then process this one... longer waiting period :-(
> > 
> > OK, it is not super urgent. OTOH it is a very simple patch :)
> 
> By the way, do the pending patches address soft-leaking of reset GPIO
> when the driver fails to acquire clock for a port (I called it
> soft-leaking since devm will free it on unbind)?

I think no, because there is not any patch related to GPIO reset.
