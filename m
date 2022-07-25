Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA355800E6
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 16:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiGYOnq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 10:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGYOnp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 10:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339835F59;
        Mon, 25 Jul 2022 07:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C40BD60FDD;
        Mon, 25 Jul 2022 14:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C28CC341C6;
        Mon, 25 Jul 2022 14:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658760223;
        bh=8Ow8ndFqtmlwt5aZuA4SEkZ3g+NuwXbqV18UFENJugQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pZtCDTrzrS4rsVG9Fn5A2FfRHbXq1YocyeKocEW9YOhmFDls6QG/cod8vbt6tdCtB
         nDv/AC0PEMqR8Pnpu6WXsMfFtW61f12qNG+DOqD4zjkLgbN3lgHqPAcUOxFmjcmgRF
         Z+1tMYmou2fFvDZ1spJy4p6fA/QF16lAfbcdeIJa2xAemVN3yaZGcj/Pc3BtyR3qTa
         O1pLewWuc/tXP/U+lTpkSueV86HGBkT06+hMoDfCQcAjHAE8ry1QRQ7hS/jPojLSiX
         eaehtWpZawORM5ASrhMPU7/zstQaOxgG1YVDLRL3kqqBngSLLsL8QLTEfGtImd3rQM
         zel0UiAbu7BYg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oFzJ6-009rHx-LI;
        Mon, 25 Jul 2022 15:43:40 +0100
Date:   Mon, 25 Jul 2022 15:43:40 +0100
Message-ID: <87czdtxnfn.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
In-Reply-To: <Yt6Z3cBrVy1lVTp1@hovoldconsulting.com>
References: <YtqllIHY/R/BbR3V@hovoldconsulting.com>
        <20220722143858.GA1818206@bhelgaas>
        <Yt6Z3cBrVy1lVTp1@hovoldconsulting.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: johan@kernel.org, helgaas@kernel.org, pali@kernel.org, johan+linaro@kernel.org, kishon@ti.com, songxiaowei@hisilicon.com, wangbinghui@hisilicon.com, thierry.reding@gmail.com, ryder.lee@mediatek.com, jianjun.wang@mediatek.com, linux-pci@vger.kernel.org, kw@linux.com, ley.foon.tan@intel.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 25 Jul 2022 14:25:49 +0100,
Johan Hovold <johan@kernel.org> wrote:
> 
> [ +CC: maz ]
> 
> On Fri, Jul 22, 2022 at 09:38:58AM -0500, Bjorn Helgaas wrote:
> > On Fri, Jul 22, 2022 at 03:26:44PM +0200, Johan Hovold wrote:
> > > On Thu, Jul 21, 2022 at 05:21:22PM -0500, Bjorn Helgaas wrote:
> > 
> > > > qcom is a DWC driver, so all the IRQ stuff happens in
> > > > dw_pcie_host_init().  qcom_pcie_remove() does call
> > > > dw_pcie_host_deinit(), which calls irq_domain_remove(), but nobody
> > > > calls irq_dispose_mapping().
> > > > 
> > > > I'm thoroughly confused by all this.  But I suspect that maybe I
> > > > should drop the "make qcom modular" patch because it seems susceptible
> > > > to this problem:
> > > > 
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ctrl/qcom&id=41b68c2d097e
> > > 
> > > That should not be necessary.
> > > 
> > > As you note above, interrupt handling is implemented in dwc core so if
> > > there are any issue here at all, which I doubt, then all of the dwc
> > > drivers that currently can be built as modules would all be broken and
> > > this would need to be fixed in core.
> > 
> > I don't know yet whether there's an issue.  We need a clear argument
> > for why there is or is not.  The fact that others might be broken is
> > not an argument for breaking another one ;)
> 
> It's not breaking anything that is currently working, and if there's
> some corner case during module unload, that's not the end of the world
> either.

It may not be the end of the world for you, but you have absolutely no
idea of what dangling pointers to kernel memory will do on a user
machine, nor how this can be further exploited. Unloading a module
should never result in an unsafe kernel.

> It's a feature useful for developers and no one expects remove code to
> be perfect (e.g. resilient against someone trying to break it by doing
> things in parallel, etc.).

If that's a feature for you while you are developing, then please keep
this change as part of your own hacking toolbox. IMO the upstream
kernel shouldn't be subjected to this.

> 
> > > I've been using the modular pcie-qcom patch for months now, unloading
> > > and reloading the driver repeatedly to test power sequencing, without
> > > noticing any problems whatsoever.
> > 
> > Pali's commit log suggests that unloading the module is not, by
> > itself, enough to trigger the problem:
> > 
> >   https://lore.kernel.org/linux-pci/20220709161858.15031-1-pali@kernel.org/
> > 
> > Can you test the scenario he mentions?
> 
> Turns out the pcie-qcom driver does not support legacy interrupts so
> there's no risk of there being any lingering mappings if I understand
> things correctly.

It still does MSIs, thanks to dw_pcie_host_init(). If you can remove
the driver while devices are up and running with MSIs allocated,
things may get ugly if things align the wrong way (if a driver still
has a reference to an irq_desc or irq_data, for example).

	M.

-- 
Without deviation from the norm, progress is not possible.
