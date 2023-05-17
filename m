Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA807066C6
	for <lists+linux-pci@lfdr.de>; Wed, 17 May 2023 13:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjEQLeG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 17 May 2023 07:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjEQLeE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 May 2023 07:34:04 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183294C11;
        Wed, 17 May 2023 04:34:01 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-504d149839bso152268a12.1;
        Wed, 17 May 2023 04:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684323239; x=1686915239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlEG0hm+m0LqnpRE/YfUbTnxdtj54gtmMkfXrapS7vc=;
        b=NvjXDp6onPwaLKHghhWNrCnp89SplC3P/iIjRpGec122XaLba+oZ8gsUoF4egqEdAR
         XQfNHl8Y7dW3zc4/aeB0MHkdPkQS3sJ6HJqyF8dskx+kLuCwEssoXPAxBAk6gJr9T5rl
         5i7MGSKM2khP/B/69S0ClAh1Oh3b+L8YEKx43CmGn5KxudY4s5oUkF/28wHln0jaLJqx
         DdlgTiC9s9Wcy7VXSuKtoDNjEkSAQ7AuxxX35w+5khqGx1SsBAR2w6ptZcY9jVor9H47
         891+OBBm1pFrve06QpoOPwPa2UrAUfynRWhK54KHx79yHP0u3LEojK+U1OxaXIfoh5yt
         hhTg==
X-Gm-Message-State: AC+VfDwW0JSy+lkuwTPmjhzsJp7MAUAndQUDJCbxbHJsVHMIQFiijDjj
        Pm0R3PnAduy8sutb3ZjFESUtJo/g+ZKWSaFI3DI=
X-Google-Smtp-Source: ACHHUZ7+ObBH8x061XkkaHhi1MDSE/QM63jGlqWY1s8zB1JPk1RyjG+llhRb6SXwezSr+70tDTpE8u9hjyJ5lCARd2Y=
X-Received: by 2002:a05:6402:40c3:b0:502:1f7b:f069 with SMTP id
 z3-20020a05640240c300b005021f7bf069mr2690450edb.2.1684323239338; Wed, 17 May
 2023 04:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230517105235.29176-1-ilpo.jarvinen@linux.intel.com> <20230517105235.29176-4-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20230517105235.29176-4-ilpo.jarvinen@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 May 2023 13:33:48 +0200
Message-ID: <CAJZ5v0hQAsZWECyqHxiB=qX=dNAxuEJaxkiayajYH0ykjXLDtA@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] PCI/ASPM: Use RMW accessors for changing LNKCTL
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Shaohua Li <shaohua.li@intel.com>,
        Thomas Renninger <trenn@suse.de>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-kernel@vger.kernel.org,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 17, 2023 at 12:53 PM Ilpo Järvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Don't assume that the device is fully under the control of ASPM and use
> RMW capability accessors which do proper locking to avoid losing
> concurrent updates to the register values.
>
> If configuration fails in pcie_aspm_configure_common_clock(), the
> function attempts to restore the old PCI_EXP_LNKCTL_CCC settings. Store
> only the old PCI_EXP_LNKCTL_CCC bit for the relevant devices rather
> than the content of the whole LNKCTL registers. It aligns better with
> how pcie_lnkctl_clear_and_set() expects its parameter and makes the
> code more obvious to understand.
>
> Fixes: 4ec73791a64b ("PCI: Work around Pericom PCIe-to-PCI bridge Retrain Link erratum")
> Fixes: 86fa6a344209 ("PCI: Factor out pcie_retrain_link() function")
> Fixes: 2a42d9dba784 ("PCIe: ASPM: Break out of endless loop waiting for PCI config bits to switch")
> Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: stable@vger.kernel.org

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/pci/pcie/aspm.c | 39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index dde1ef13d0d1..426fb0bd8e3a 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -213,7 +213,6 @@ static bool pcie_wait_for_retrain(struct pci_dev *pdev)
>  static bool pcie_retrain_link(struct pcie_link_state *link)
>  {
>         struct pci_dev *parent = link->pdev;
> -       u16 reg16;
>
>         /*
>          * Ensure the updated LNKCTL parameters are used during link
> @@ -224,17 +223,14 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
>         if (!pcie_wait_for_retrain(parent))
>                 return false;
>
> -       pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> -       reg16 |= PCI_EXP_LNKCTL_RL;
> -       pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> +       pcie_capability_set_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
>         if (parent->clear_retrain_link) {
>                 /*
>                  * Due to an erratum in some devices the Retrain Link bit
>                  * needs to be cleared again manually to allow the link
>                  * training to succeed.
>                  */
> -               reg16 &= ~PCI_EXP_LNKCTL_RL;
> -               pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> +               pcie_capability_clear_word(parent, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RL);
>         }
>
>         return pcie_wait_for_retrain(parent);
> @@ -248,7 +244,7 @@ static bool pcie_retrain_link(struct pcie_link_state *link)
>  static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>  {
>         int same_clock = 1;
> -       u16 reg16, parent_reg, child_reg[8];
> +       u16 reg16, parent_old_ccc, child_old_ccc[8];
>         struct pci_dev *child, *parent = link->pdev;
>         struct pci_bus *linkbus = parent->subordinate;
>         /*
> @@ -270,6 +266,7 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>
>         /* Port might be already in common clock mode */
>         pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> +       parent_old_ccc = reg16 & PCI_EXP_LNKCTL_CCC;
>         if (same_clock && (reg16 & PCI_EXP_LNKCTL_CCC)) {
>                 bool consistent = true;
>
> @@ -289,22 +286,16 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>         /* Configure downstream component, all functions */
>         list_for_each_entry(child, &linkbus->devices, bus_list) {
>                 pcie_capability_read_word(child, PCI_EXP_LNKCTL, &reg16);
> -               child_reg[PCI_FUNC(child->devfn)] = reg16;
> -               if (same_clock)
> -                       reg16 |= PCI_EXP_LNKCTL_CCC;
> -               else
> -                       reg16 &= ~PCI_EXP_LNKCTL_CCC;
> -               pcie_capability_write_word(child, PCI_EXP_LNKCTL, reg16);
> +               child_old_ccc[PCI_FUNC(child->devfn)] = reg16 & PCI_EXP_LNKCTL_CCC;
> +               pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
> +                                                  PCI_EXP_LNKCTL_CCC,
> +                                                  same_clock ? PCI_EXP_LNKCTL_CCC : 0);
>         }
>
>         /* Configure upstream component */
> -       pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &reg16);
> -       parent_reg = reg16;
> -       if (same_clock)
> -               reg16 |= PCI_EXP_LNKCTL_CCC;
> -       else
> -               reg16 &= ~PCI_EXP_LNKCTL_CCC;
> -       pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
> +       pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
> +                                          PCI_EXP_LNKCTL_CCC,
> +                                          same_clock ? PCI_EXP_LNKCTL_CCC : 0);
>
>         if (pcie_retrain_link(link))
>                 return;
> @@ -312,9 +303,11 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>         /* Training failed. Restore common clock configurations */
>         pci_err(parent, "ASPM: Could not configure common clock\n");
>         list_for_each_entry(child, &linkbus->devices, bus_list)
> -               pcie_capability_write_word(child, PCI_EXP_LNKCTL,
> -                                          child_reg[PCI_FUNC(child->devfn)]);
> -       pcie_capability_write_word(parent, PCI_EXP_LNKCTL, parent_reg);
> +               pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
> +                                                  PCI_EXP_LNKCTL_CCC,
> +                                                  child_old_ccc[PCI_FUNC(child->devfn)]);
> +       pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
> +                                          PCI_EXP_LNKCTL_CCC, parent_old_ccc);
>  }
>
>  /* Convert L0s latency encoding to ns */
> --
> 2.30.2
>
