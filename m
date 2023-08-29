Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F5878C2D6
	for <lists+linux-pci@lfdr.de>; Tue, 29 Aug 2023 12:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjH2K7Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Aug 2023 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjH2K7N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Aug 2023 06:59:13 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 387FECC9
        for <linux-pci@vger.kernel.org>; Tue, 29 Aug 2023 03:58:48 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 63D2592009C; Tue, 29 Aug 2023 12:58:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 5D4E592009B;
        Tue, 29 Aug 2023 11:58:02 +0100 (BST)
Date:   Tue, 29 Aug 2023 11:58:02 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Tim Harvey <tharvey@gateworks.com>
cc:     Bjorn Helgaas <helgaas@kernel.org>, Marek Vasut <marex@denx.de>,
        linux-pci@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: imx8mp pci hang during init
In-Reply-To: <CAJ+vNU0++E+opUnFbmYLv84iQe0oy4y_C8cvp3dix-8XzdETaA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2308291108010.43104@angie.orcam.me.uk>
References: <20230817171242.GA320904@bhelgaas> <alpine.DEB.2.21.2308180051080.8596@angie.orcam.me.uk> <CAJ+vNU3DNgJXWN7KebD89zJvNqr_4QF_vnxFwN7LytNVFc-i-A@mail.gmail.com> <CAJ+vNU0++E+opUnFbmYLv84iQe0oy4y_C8cvp3dix-8XzdETaA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tim,

> It seems to me that pci quirks require knowing the device so don't
> help until you've established a link and can get to config space, or
> perhaps this means the switch needs to be defined in DT so that a dt
> compatible could be used for the quirk?

 This is why I took a different approach with my a89c82249c37 ("PCI: Work 
around PCIe link training failures").  Initially as a regular quirk 
applied to all devices (i.e. matching on PCI_ANY_ID:PCI_ANY_ID) and then, 
following Bjorn's suggestion, invoked directly from `pci_device_add' and 
`pcie_wait_for_link_delay'.

> Does the PCIe specification specify that link training should start
> with the highest possible speed then downgrade? I find that most of
> the other PCI host controller drivers I've looked at all work this
> way. I have only found the force gen2 first behavior in pci-imx6.c and
> pcie-fu740.c. Maybe a dt property to force gen2 first is needed to
> resolve this.

 It works the other way round.  Link is always established at 2.5GT/s and 
once successful the endpoints send each other information, the so called 
"training sets", about their capabilities, including speeds supported.  
Then they switch to the highest speed supported within the Target Link 
Speed (TLS) setting in the Link Control 2 register of both ends.  If there 
are reliability issues at the higher rate, the endpoints are supposed to 
reduce the link speed.  Reducing the speed, both by clamping with TLS and 
in the case of reliability issues, is always done by removing said speed 
from the list reported in the respective device's training set.

 I don't know what's causing some devices to fail to switch to the higher 
speed when unclamped with TLS and yet to switch successfully when first 
clamped with TLS and then the clamping removed.  In principle unclamping 
by hand should just mimic what happens in the unclamped case: the other 
endpoint sees a higher speed advertised, so both endpoints switch to it.  
I suppose the hardware state machine is just tough to get right and doing 
things by hand prevents the broken ones from getting into an odd state due 
to unfortunate timing or whatever.  Unfortunately the device manufacturers 
involved declined to comment.

  Maciej
