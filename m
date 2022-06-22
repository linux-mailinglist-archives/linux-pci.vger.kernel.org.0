Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F095548A9
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 14:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353508AbiFVLFq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 07:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353598AbiFVLFp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 07:05:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD553BBF6;
        Wed, 22 Jun 2022 04:05:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A084761572;
        Wed, 22 Jun 2022 11:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97AAC34114;
        Wed, 22 Jun 2022 11:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655895944;
        bh=SsDqw6Q8qsjUyD2DTVKU4cBnDr90hLSe04Ro4/AHDhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V6VtdK0OV/fFf31zsPq6axy3qgNG3HgR+ZXXp2HeyKIWYUQvRdIeMk2hoOaYfU3EI
         P7CqEiRdft6I5ytRXz7QwOyEMASGMGXHYofKgN296lpeJ1R2QFtWu1yhAyKQfeqrgt
         ElzYr6YlczCVwGxKPe95I5YXi07xLqKuwNdXZr4G3Ynt5SgJc8W1izbTV0wVaXo5aj
         XXh28yMv41LSU1ie1pVUAWLW/2ggPPY5mDPvIaRy33Apmlh3rHzR4V55ut8aSBst1j
         g7cUOmRT/Iyk/+bS3p4fpcu3BPjSVC8u/xAj6qh0O2SHIKbNIcDC+WBLvMSJV298vL
         +cIf3VJx/Ux7g==
Date:   Wed, 22 Jun 2022 06:05:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Liang He <windhl@126.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: rcar: Resolve of_find_matching_node() reference
 leak
Message-ID: <20220622110542.GA1372130@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUwGLDzOQo_wwSLmzBnJXe-cOw=nqsPbFLsj-c+nHfy_w@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 22, 2022 at 09:45:49AM +0200, Geert Uytterhoeven wrote:
> Hi Bjorn,
> 
> On Wed, Jun 22, 2022 at 4:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Previously, rcar_pcie_init() used of_find_matching_node() to search the
> > entire device tree for compatible strings for which we need to install an
> > abort handler.  If we found one, we got a device_node with refcount
> > incremented, but we discarded the pointer and never released that
> > reference.
> >
> > Extend the struct rcar_variant to indicate whether each variant requires an
> > abort handler.  Install the handler in rcar_pcie_probe() when needed.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Liang He <windhl@126.com>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Thanks for your patch!
> 
> > --- a/drivers/pci/controller/pcie-rcar-host.c
> > +++ b/drivers/pci/controller/pcie-rcar-host.c
> 
> > @@ -964,12 +965,35 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie_host *host)
> >         return err;
> >  }
> >
> > +#ifdef CONFIG_ARM
> > +static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
> > +               unsigned int fsr, struct pt_regs *regs)
> > +{
> > +       return !fixup_exception(regs);
> > +}
> > +#endif
> > +
> > +static void rcar_pcie_hook_aborts(void)
> > +{
> > +#ifdef CONFIG_ARM
> > +#ifdef CONFIG_ARM_LPAE
> > +       hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > +                       "asynchronous external abort");
> > +#else
> > +       hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> > +                       "imprecise external abort");
> > +#endif
> > +#endif
> > +}
> > +
> >  static const struct rcar_variant rcar_h1_data = {
> >         .phy_init_fn = rcar_pcie_phy_init_h1,
> > +       .hook_aborts = true,
> >  };
> >
> >  static const struct rcar_variant rcar_gen2_data = {
> >         .phy_init_fn = rcar_pcie_phy_init_gen2,
> > +       .hook_aborts = true,
> >  };
> >
> >  static const struct rcar_variant rcar_gen3_data = {
> > @@ -1035,6 +1059,9 @@ static int rcar_pcie_probe(struct platform_device *pdev)
> >                 goto err_clk_disable;
> >         }
> >
> > +       if (host->variant->hook_aborts)
> > +               rcar_pcie_hook_aborts();
> 
> I was quite sure there was a good reason why this was not done in
> .probe() before...
> 
> And indeed, the original submission[1] did have a comment explaining
> that:
> 
>     + /*
>     + * Since probe() can be deferred we need to make sure that
>     + * hook_fault_code is not called after __init memory is freed
>     + * by kernel and since rcar_pcie_abort_handler() is a no-op,
>     + * we can install the handler here without risking it
>     + * accessing some uninitialized driver state.
>     + */
> 
> No idea why it was removed in v2 and later, but the point is:
> hook_fault_code() is __init, so you cannot call it from a deferred
> probe.
> And you should have got a section mismatch warning ;-)

Oooh, thanks for that!  I missed the builtin_platform_driver_probe()
vs builtin_platform_driver() difference that explains why doing this
at probe-time works for pci-ixp4xx.c but not here.

Bjorn
