Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC13F57E534
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiGVRRL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbiGVRRK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 13:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B231D0FF;
        Fri, 22 Jul 2022 10:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B823B62247;
        Fri, 22 Jul 2022 17:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E347BC341C6;
        Fri, 22 Jul 2022 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658510228;
        bh=67d/Not1hKY4NVqkbCFOQPdysDFNxNtFZQSnVlf7hIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FVrm0BMwyDx76XrevBFVTwTFxgwtmek+wzL6uG72fFpvDDFabRvskX1aRjQdF/lZt
         jgGX26R/t1gq7tSZNakRPbQGm48CSIsenNxPt0g6djdTpYQVnY4XMUKnxZuNO1CQv7
         B8179KbCc6WaxMR6lwIl3/y/YdFLdmS4V5q87WkUQYfksGYtCrfXagB9xVOq5bnfp5
         VvhUxsmXjMrIvNriprQXp3Sd1Y1xP3/vZpQRwN5oLLBpqO+OQOesOvABz/jhheGLPm
         WgzdZTnpdeNoJmTHGW+NVs6Md8PKpoH0tp1Px3XgJc3ivA3BtxgF+lRTIiqtdrKWKw
         paD+E8y70hMvQ==
Date:   Fri, 22 Jul 2022 12:17:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Message-ID: <20220722171706.GA1911557@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k085xekg.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 22, 2022 at 06:06:07PM +0100, Marc Zyngier wrote:
> On Fri, 22 Jul 2022 15:39:05 +0100,
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > [+cc Marc, can you clarify when we need irq_dispose_mapping()?]
> 
> In general, interrupt controllers should not have to discard mappings
> themselves, just like they rarely create mappings themselves. That's
> usually a different layer that has created it (DT, for example).
> 
> The problem is that these mappings persist even if the interrupt has
> been released by the driver (it called free_irq()), and the IRQ number
> can be further reused. The client driver could dispose of the mapping
> after having released the IRQ, but nobody does that in practice.
> 
> From the point of view of the controller, there is no simple way to
> tell when an interrupt is "unused". And even if a driver was
> overzealous and called irq_dispose_mapping() on all the possible
> mappings (and made sure no mapping could be created in parallel), this
> could result in a bunch of dangling pointers should a client driver
> still have the interrupt requested.
> 
> Fixing this is pretty hard, as IRQ descriptors are leaky (you can
> either have a pointer to one, or just an IRQ number -- they are
> strictly equivalent). So in general, being able to remove an interrupt
> controller driver is at best fragile, and I'm trying not to get more
> of this in the tree.

Thank you!

How do we identify an interrupt controller driver?  Apparently some of
these PCIe controller drivers also include an interrupt controller
driver, but I don't know what to look for to find them.

Bjorn
