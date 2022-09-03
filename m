Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EEB5AC043
	for <lists+linux-pci@lfdr.de>; Sat,  3 Sep 2022 19:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiICRk6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Sep 2022 13:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiICRk5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Sep 2022 13:40:57 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283EF5208A;
        Sat,  3 Sep 2022 10:40:56 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 202so2726194ybe.13;
        Sat, 03 Sep 2022 10:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ADCDZkM9VRAAcy+FPVXNht63Zj+njGChRH3Rklp+Wy8=;
        b=ocEsvxDYyomHlVkffJCXMnkJIRtBjfGDnCnz/K/iZNQA7tq2KiFYPNFn290t6spYfe
         QrafLIyZZMgKxsvaUKBN3iAbQsj5Q2RyoYx1xhlE6KK4IPeE0nYzYcewW8iAgkpr4DWV
         x2GtR4ReouASIjJnp6Li4grSq/TJV6t8Y4jWfLkp/IaII3gYAeiBzZEs2/4336ngiDA+
         brtTAzBG9dP/8eKi6QEwOc7yUhVQdtrMJFrN63lzq6Hg5ia1ERRyUhxPWvTyv8C0BH9x
         Qtotq/vAAHwYvwIMx7Q+XkoVepu/mYppEMoBsKljuKLdtHf05XcfrtKWQYxwT5PjjPPU
         9NVA==
X-Gm-Message-State: ACgBeo0m8KgxFqwaA8/3wCWcwDW7twj3e1ycxZtc8dEJeFj+a09o3sSB
        P+5qRc1mPzvvbJ4Ut1vuCM8DqMBx0iN7p1wcptE=
X-Google-Smtp-Source: AA6agR536TsmH0/J0LAucPibLANU1mbFYloX4jDfE+3oUtt6HXJozc0iRDgfkYk6wbFjQDVKkeXuyTzegMfeoQxoem4=
X-Received: by 2002:a25:b749:0:b0:68f:171f:96bd with SMTP id
 e9-20020a25b749000000b0068f171f96bdmr28745931ybm.137.1662226855380; Sat, 03
 Sep 2022 10:40:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220902233543.390890-1-helgaas@kernel.org> <20220902233543.390890-3-helgaas@kernel.org>
In-Reply-To: <20220902233543.390890-3-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 19:40:44 +0200
Message-ID: <CAJZ5v0jV94TwifmoF2UfiDpXNP_Kgt6qNkQH7zwQjo=ZhyU-4A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI/PTM: Implement pci_enable_ptm() for Root
 Ports, Switch Upstream Ports
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Koba Ko <koba.ko@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 3, 2022 at 1:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/ptm.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index b6a417247ce3..ad283818f37b 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -167,11 +167,11 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>         if (!pos)
>                 return -EINVAL;
>
> -       pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
> -       if (!(cap & PCI_PTM_CAP_REQ))
> -               return -EINVAL;
> -
>         /*
> +        * Root Ports and Switch Upstream Ports have been configured
> +        * by pci_ptm_init(), so preserve their PCI_PTM_CTRL_ROOT and
> +        * granularity.
> +        *
>          * For a PCIe Endpoint, PTM is only useful if the endpoint can
>          * issue PTM requests to upstream devices that have PTM enabled.
>          *
> @@ -179,19 +179,39 @@ int pci_enable_ptm(struct pci_dev *dev, u8 *granularity)
>          * device, so there must be some implementation-specific way to
>          * associate the endpoint with a time source.
>          */
> -       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
> +       if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +           pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) {
> +               if (pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM) {
> +                       ups = pci_upstream_bridge(dev);
> +                       if (!ups || !ups->ptm_enabled)
> +                               return -EINVAL;
> +               }
> +
> +               pci_read_config_dword(dev, pos + PCI_PTM_CTRL, &ctrl);
> +               ctrl |= PCI_PTM_CTRL_ENABLE;
> +       } else if (pci_pcie_type(dev) == PCI_EXP_TYPE_ENDPOINT) {
> +               pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
> +               if (!(cap & PCI_PTM_CAP_REQ))
> +                       return -EINVAL;
> +
>                 ups = pci_upstream_bridge(dev);
>                 if (!ups || !ups->ptm_enabled)
>                         return -EINVAL;
>
>                 dev->ptm_granularity = ups->ptm_granularity;
> +               ctrl = PCI_PTM_CTRL_ENABLE;
> +               ctrl |= dev->ptm_granularity << 8;
>         } else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
> +               pci_read_config_dword(dev, pos + PCI_PTM_CAP, &cap);
> +               if (!(cap & PCI_PTM_CAP_REQ))
> +                       return -EINVAL;
> +
>                 dev->ptm_granularity = 0;
> +               ctrl = PCI_PTM_CTRL_ENABLE;
> +               ctrl |= dev->ptm_granularity << 8;
>         } else
>                 return -EINVAL;

I would do

if ((pci_pcie_type(dev) == PCI_EXP_TYPE_UPSTREAM || pci_pcie_type(dev)
== PCI_EXP_TYPE_ENDPOINT)) {
        ups = pci_upstream_bridge(dev);
        if (!ups || !ups->ptm_enabled)
                return -EINVAL;

        dev->ptm_granularity = ups->ptm_granularity;
}

switch(pci_pcie_type(dev)) {
case PCI_EXP_TYPE_ROOT_PORT:
case PCI_EXP_TYPE_UPSTREAM:
        pci_read_config_dword(dev, pos + PCI_PTM_CTRL, &ctrl);
        ctrl |= PCI_PTM_CTRL_ENABLE;
        break;
case PCI_EXP_TYPE_ENDPOINT:
case PCI_EXP_TYPE_RC_END:
        ctrl = PCI_PTM_CTRL_ENABLE;
        break;
default:
        return -EINVAL;
}

>
> -       ctrl = PCI_PTM_CTRL_ENABLE;
> -       ctrl |= dev->ptm_granularity << 8;

And I wouldn't remove the line above.

Note that for root ports dev->ptm_granularity must be set and reflect
the register setting or else the code wouldn't have worked for
downstream components.

>         pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
>         dev->ptm_enabled = 1;
>
> --
