Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B3B610287
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 22:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbiJ0USF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 16:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236842AbiJ0USB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 16:18:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B5A8C00C;
        Thu, 27 Oct 2022 13:17:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a13so4827014edj.0;
        Thu, 27 Oct 2022 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d+819bBKV2/hQ0v9OQ2O/TeAoWwLXmcETC4PNPsgypA=;
        b=BunQq78l9VTK1Voqc+Y0JwFPL/g8lhX4GKaIX1Z11ETFNhjfapo0cCtRFr77xIQbDC
         tRyPdhJGzGYK1svZWGPAzfeqzogBi1sy9ARqB/BjAmAyJTgYfPaYfjEAYVM1uvOkxJar
         djulsWBPVbPRs+MinE7gkmWtI/5+B+3x0LQEgB4mHLmzLaAn+Uiwd3R9NJmrRwkqV045
         S9HhTTgndJcAQGgmr00gT0wkN4hH4u+bDushJZiS3+0PmMROXi7F+h7xCkkQV6NWXLF0
         8yyx1zlA8+lcDSGn8hOD5Kmt7NVtdWJwsSNNX5v7EL9xW8BwLjsqJI0aqxopgONpAcZ/
         Bwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+819bBKV2/hQ0v9OQ2O/TeAoWwLXmcETC4PNPsgypA=;
        b=cKQ3w0YG5SdjNl0QtRuVcRjT0eIoraGBfOo114XEL+4zETzp9WztbJzNr5ar6EZDqN
         fUsIrKElZLIegG6kEVpffBlUud6/H26MGCxvKqteRmvlguiry5i9V+X+4j5EUdbDuQIO
         cUQPUeEzF4r3+S/ZATAOdk43Zq71goalMSql0rlAqGMMcMlz0WJxRnaGtctAU9eMBRZx
         hFRKCjkYRRP57UL4KLX0U0kqum8j+XA5zKu70gGdpQuAFYGRGLnhOhRDOLhiU11p3gXk
         lX/esju7+YXKeBidzJYeT5Rl9RKkwQx2yPtexjKkDvHzgOn0j+zAWtW1KpfaYjh3NTWt
         wmBg==
X-Gm-Message-State: ACrzQf3Ure5Fc8yDwwHaU3cMkxjB9HLuaVryrDAISrh75QFHsEa0wMC8
        SthJDv2Ghc+qIfl/I3jY5zYtUKeoYY8eJogJcC8=
X-Google-Smtp-Source: AMsMyM6eH2mwjYQw1tS7MVUj0crMJ4qrvuCQ4XWYhSMgrG7m4Sm0LRtAyG2yx1NsvtjdiEGG8Eh+++3zhE5+OLL9h60=
X-Received: by 2002:a05:6402:3890:b0:45c:2b5:b622 with SMTP id
 fd16-20020a056402389000b0045c02b5b622mr48258784edb.69.1666901878347; Thu, 27
 Oct 2022 13:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220919143340.4527-1-vidyas@nvidia.com> <20220919143340.4527-3-vidyas@nvidia.com>
 <Y1psU2P4uqD2rUub@lpieralisi>
In-Reply-To: <Y1psU2P4uqD2rUub@lpieralisi>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Thu, 27 Oct 2022 13:17:46 -0700
Message-ID: <CAPOBaE4AZCbvvfdxvOTMsRU65yWL-3-zHb4Ki0+UgYkuRQEgzA@mail.gmail.com>
Subject: Re: [PATCH V1 2/2] PCI: designware-ep: Disable PTM capabilities for
 EP mode
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>, gustavo.pimentel@synopsys.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 27, 2022 Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
>
> On Mon, Sep 19, 2022 at 08:03:40PM +0530, Vidya Sagar wrote:
> > Dual mode DesignWare PCIe IP has PTM capability enabled (if supported) even
> > in the EP mode. The PCIe compliance for the EP mode expects PTM
> > capabilities (ROOT_CAPABLE, RES_CAPABLE, CLK_GRAN) be disabled.
> > Hence disable PTM for the EP mode.
>
> "PCIe compliance" - what is this referring to ?

Hi Lorenzo,

You can refer to the following link:
https://pcisig.com/developers/compliance-program

PCIe compliance means 'PCIe Compliance test "Compliance tests allow
for product testing against PCI-SIG test modules". Usually, USB specs
and PCIe specs define compliance tests where product manufacturers
need to pass specific test procedures. For example, in USB cases,
USB.org says that "To qualify for the right to display the certified USB logo
in conjunction with a product, the product must pass USB-IF compliance
testing for product quality."

To Vidiya,
If my understanding is not correct, please let us know what you intended.

>
> Was this reported to Synopsys ?

To Vidiya,
Would you confirm that?

Thank you.

Best regards,
Jingoo Han
>
> Thanks,
> Lorenzo
>
> > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 7e9529ae3824..dc3057b18f36 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -646,7 +646,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >       struct dw_pcie_ep_func *ep_func;
> >       struct device *dev = pci->dev;
> >       struct pci_epc *epc = ep->epc;
> > -     unsigned int offset;
> > +     unsigned int offset, ptm_cap_base;
> >       unsigned int nbars;
> >       u8 hdr_type;
> >       u8 func_no;
> > @@ -698,6 +698,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >       }
> >
> >       offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> > +     ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
> >
> >       dw_pcie_dbi_ro_wr_en(pci);
> >
> > @@ -710,6 +711,22 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> >                       dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> >       }
> >
> > +     /*
> > +      * PTM responder capability can be disabled only after disabling
> > +      * PTM root capability.
> > +      */
> > +     if (ptm_cap_base) {
> > +             dw_pcie_dbi_ro_wr_en(pci);
> > +             reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> > +             reg &= ~PCI_PTM_CAP_ROOT;
> > +             dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> > +
> > +             reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> > +             reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
> > +             dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> > +             dw_pcie_dbi_ro_wr_dis(pci);
> > +     }
> > +
> >       dw_pcie_setup(pci);
> >       dw_pcie_dbi_ro_wr_dis(pci);
> >
> > --
> > 2.17.1
> >
