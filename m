Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFB46D801D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjDEOzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 10:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbjDEOzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 10:55:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8412112
        for <linux-pci@vger.kernel.org>; Wed,  5 Apr 2023 07:55:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D353627E1
        for <linux-pci@vger.kernel.org>; Wed,  5 Apr 2023 14:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7053FC433D2;
        Wed,  5 Apr 2023 14:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680706513;
        bh=w7V8m3dZ8kFEvH+QHnOHcq5f9tAoo3EHbxGxTlA7Iwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjM6cVAC+/IhN0nhX7VRkxYB/y2p8sDbIYwwrplzgTJ28OiJquHvXB9e4VozT+Bm9
         UH8ZK6f7EHcVANQPFfaPHnNLXG3EQprlGZQF1tZZLhvoEqKGpquY2J1XLhZJhigQIn
         kYe4dxYWNUuiD/6Y3ToyxpIbhPJeXRviOG2MrK6VihFxhtKcLayRSLd7n/bb5pS9Hc
         vvs1WKDJd2LNL6mmj6MtBcxQC6S8yoNiqxmb3Qx0I0vXPBaBNaDofdNwau8Q0CatMZ
         QnrD8Ax1zKxKHLVmmpRnvN0qmOEebp1gUOxluj6vepmUzzdTeGljOf9KF7OnPMa1Qs
         T9n9rMg+GJLgQ==
Date:   Wed, 5 Apr 2023 16:55:08 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Han Jingoo <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [RESEND PATCH v2] PCI: dwc: Round up num_ctrls if num_vectors is
 less than MAX_MSI_IRQS_PER_CTRL
Message-ID: <ZC2LzJ/WOqdz2bE0@lpieralisi>
References: <1669080013-225314-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPOBaE6KNXn56Gs8DCUg9nMqDPF494OaM58JYHsaKVsFRbvt5A@mail.gmail.com>
 <8b40a27b-8480-dd74-3fd1-6f6493dc0ce1@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b40a27b-8480-dd74-3fd1-6f6493dc0ce1@rock-chips.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 03, 2023 at 04:23:53PM +0800, Shawn Lin wrote:
> On 2022/11/23 6:04, Han Jingoo wrote:
> > On Mon, Nov 21, 2022 Shawn Lin <shawn.lin@rock-chips.com> wrote:
> > > 
> > > Some SoCs may only support 1 RC with a few MSIs support that the total number of MSIs is
> > > less than MAX_MSI_IRQS_PER_CTRL. In this case, num_ctrls will be zero which fails setting
> > > up MSI support. Fix it by rounding up num_ctrls to at least one.
> > > 
> > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > 
> > Acked-by: Jingoo Han <jingoohan1@gmail.com>
> 
> Thanks, Jingoo!
> 
> Hi Lorenzo,
> 
> Is there any chance this patch be applied? :)
> 
> > 
> > Best regards,
> > Jingoo Han
> > 
> > > ---
> > > 
> > > Changes in v2:
> > > - set num_ctrls to 1 if it's less than one
> > > 
> > >   drivers/pci/controller/dwc/pcie-designware-host.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 39f3b37..cfce1e0 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -62,6 +62,8 @@ irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
> > >          struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > 
> > >          num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;

I assume that if pp->num_vectors > MAX_MSI_IRQS_PER_CTRL but not
an exact multiple we would have the same problem right ?

Best to fix it for both cases.

Lorenzo

> > > +       if (num_ctrls < 1)
> > > +               num_ctrls = 1;
> > > 
> > >          for (i = 0; i < num_ctrls; i++) {
> > >                  status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
> > > @@ -343,6 +345,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > >          if (!pp->num_vectors)
> > >                  pp->num_vectors = MSI_DEF_NUM_VECTORS;
> > >          num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> > > +       if (num_ctrls < 1)
> > > +               num_ctrls = 1;
> > > 
> > >          if (!pp->msi_irq[0]) {
> > >                  pp->msi_irq[0] = platform_get_irq_byname_optional(pdev, "msi");
> > > @@ -707,6 +711,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> > > 
> > >          if (pp->has_msi_ctrl) {
> > >                  num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> > > +               if (num_ctrls < 1)
> > > +                       num_ctrls = 1;
> > > 
> > >                  /* Initialize IRQ Status array */
> > >                  for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> > > --
> > > 2.7.4
> > > 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
