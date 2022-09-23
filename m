Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE445E850E
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 23:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiIWVku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 17:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIWVkt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 17:40:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48C41323E9;
        Fri, 23 Sep 2022 14:40:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id y3so3303225ejc.1;
        Fri, 23 Sep 2022 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HrqvrN5bvcBzdENj0EHBWmMJF1ASYbjMi67GCR29JAk=;
        b=gFe6RH8iiTgh4Gb7yv+vrRC8VN+d7zmWLkY58ZaE5oVo92WdWX0qjpCIQTc0ksZ04f
         zUZW0qpREcsoE5KbZ7oPEsOfbgv3E6upxt9TznEYnDnG21uVQ9QEutnSu6oqB6VYKCVQ
         chJ9SuA8nW6/0qAwHHdmjT4k2EszJ+XMyF5GLvtsTU+M5Xbaz2x2c/mfAlf3t83Bwor6
         B+G2/Fi29SHWgbzenJSJEZfsph72C7N2h+LGh+3N38M2Sl83jfOy4AKQQq+bHv+cmoqJ
         ZSRE44vnLtcNnZZBYUXbxg+ZytcgLIt14r3TlgW0Lmb/pYp3nb4VK215kibafh/ZKHFB
         v3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HrqvrN5bvcBzdENj0EHBWmMJF1ASYbjMi67GCR29JAk=;
        b=UtR1NSNealYpZ+nn7Yt1yerCPSnpV1LiGE1yGw/8dPZiFMdyXsTwpGhXPFHEnNLHXv
         WtoF7weTw3xzO9qov3/NP3ajmAImkjFhq7RoDKkWLWEiP/rtrek4jYuqG07+kcsTyXVE
         eh4VNRqpWQPkektq4WmOiabUzzoYEULzJmwGJEwno9oJSC3ajPfQCpxkZZRC4p7VEGLn
         e8obcf19LHQ4s/acKKWaAofBHu9aOdlvbaMWiL/jcUuSXP8yyxqvcucIDxcyyXBNhh5h
         wxBTxJv9B5xAcrl7XpdhGyazjZjn1C7P2vswo1dzaL/9AIB5dIxxzNgUVyCZHe9r2U3z
         EvQQ==
X-Gm-Message-State: ACrzQf0tYH5TGqckl28V/gibDeP0q+/q78b36FpZHRKaTTi9s+q3YcmE
        M7Xqw8wjcNMVwJLWrRzH/LWCI+Hs/xxlZ9TA4pk=
X-Google-Smtp-Source: AMsMyM5NBBOTSRK5zj1mIi0cG8oRBfTjBBHIw2zTvV0uviAPofWwVrMu+2kWHLcO91LaDfHSlPMcx8B+XyAp35CZtdg=
X-Received: by 2002:a17:907:270b:b0:77b:17b3:f446 with SMTP id
 w11-20020a170907270b00b0077b17b3f446mr8658021ejk.415.1663969247215; Fri, 23
 Sep 2022 14:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220919143340.4527-1-vidyas@nvidia.com> <20220919143340.4527-3-vidyas@nvidia.com>
In-Reply-To: <20220919143340.4527-3-vidyas@nvidia.com>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Fri, 23 Sep 2022 14:40:35 -0700
Message-ID: <CAPOBaE5yHsQLQssxRX_XF9OYJfWB=F8bTMjchxUswC4F62-Qmw@mail.gmail.com>
Subject: Re: [PATCH V1 2/2] PCI: designware-ep: Disable PTM capabilities for
 EP mode
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
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

On Mon, Sep 19, 2022, Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Dual mode DesignWare PCIe IP has PTM capability enabled (if supported) even
> in the EP mode. The PCIe compliance for the EP mode expects PTM
> capabilities (ROOT_CAPABLE, RES_CAPABLE, CLK_GRAN) be disabled.
> Hence disable PTM for the EP mode.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7e9529ae3824..dc3057b18f36 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -646,7 +646,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>         struct dw_pcie_ep_func *ep_func;
>         struct device *dev = pci->dev;
>         struct pci_epc *epc = ep->epc;
> -       unsigned int offset;
> +       unsigned int offset, ptm_cap_base;

Is there any reason to mix these 2 variables into 1 line?
If not, please add a new line for ptm_cap_base.

       unsigned int offset;
       unsigned int ptm_cap_base;

Also, it looks ok. When you send a new patch, just add my Acked-by.
Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

>         unsigned int nbars;
>         u8 hdr_type;
>         u8 func_no;
> @@ -698,6 +698,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>         }
>
>         offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> +       ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
>
>         dw_pcie_dbi_ro_wr_en(pci);
>
> @@ -710,6 +711,22 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>                         dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
>         }
>
> +       /*
> +        * PTM responder capability can be disabled only after disabling
> +        * PTM root capability.
> +        */
> +       if (ptm_cap_base) {
> +               dw_pcie_dbi_ro_wr_en(pci);
> +               reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> +               reg &= ~PCI_PTM_CAP_ROOT;
> +               dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> +
> +               reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> +               reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
> +               dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> +               dw_pcie_dbi_ro_wr_dis(pci);
> +       }
> +
>         dw_pcie_setup(pci);
>         dw_pcie_dbi_ro_wr_dis(pci);
>
> --
> 2.17.1
>
