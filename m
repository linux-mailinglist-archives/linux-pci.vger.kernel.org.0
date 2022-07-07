Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1967D56AA8F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 20:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbiGGS1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236349AbiGGS1f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 14:27:35 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A0C5A449;
        Thu,  7 Jul 2022 11:27:34 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2ef5380669cso178364897b3.9;
        Thu, 07 Jul 2022 11:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TifmE1HEl56S1YpPiai/weo9z8davOP03Mm+nvK33w0=;
        b=HoTi7lBuHulMxExt8/BO4GExS7PRonz8jEbbAKvg37ZP/YdC3e/2sDIgpY90/zgfMe
         7Y7WW8EBX3NffDKzvalChaVKHhRMvrcCin6CFBogBuTChclA4/tYMdSZdLg9s7JsP6Yj
         0xZnkT6dckig778Sw4nDK7UJGotJ4zD/m9hPjgeHHGWiROPtyjfjxUuvaIHnq7v5ga2o
         ys8jk0FxrZlB3A/38/Nn13QQRyzo4XtbyeAjTHYrPoHWS4Ik83FbFToVwZ1AtHTJhRsM
         25ZOV7l1KZOD/4IM7twNMMyGWDvwOSclNWGaKLjvmRhir5iVobQ+Pa6cXH28ioTXu08R
         iRfw==
X-Gm-Message-State: AJIora/yNqV0kPgFFWHDOL4ofC9mqz+WcPAnDV1azkP2mQhMefVxnGPa
        aGXB0jHMCqpFIp1c4nQ1BRXsvr6YxCk+QwyRk/k=
X-Google-Smtp-Source: AGRyM1u18KUIg7aVkzSwcNaAAAGs6ZxwfqFLtdoXHVaTEu9NZqlRwLy5/vNE50eCPcu7jfT/Yc5CXiH60kImOag/FI0=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr52740543ywb.326.1657218453124; Thu, 07
 Jul 2022 11:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220707172205.3205110-1-rajvi.jingar@linux.intel.com> <20220707172205.3205110-2-rajvi.jingar@linux.intel.com>
In-Reply-To: <20220707172205.3205110-2-rajvi.jingar@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jul 2022 20:27:22 +0200
Message-ID: <CAJZ5v0h02a=puAKY3wp2vqhXCHKxnzWFQvUOjMMtnENz3=39xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/PTM: fix in pci_disable_ptm()
To:     Rajvi Jingar <rajvi.jingar@linux.intel.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Box <david.e.box@linux.intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Thu, Jul 7, 2022 at 7:22 PM Rajvi Jingar
<rajvi.jingar@linux.intel.com> wrote:
>
> Set ptm_enabled from 'struct pci_dev' to 0 in pci_ptm_disable() to

I would set "Clear" here instead of "Set", but moreover ->

> save the disabled PTM state for the device.
>
> Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
> Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> ---
>  drivers/pci/pcie/ptm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 368a254e3124..746e29779c27 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -44,6 +44,7 @@ void pci_disable_ptm(struct pci_dev *dev)
>         pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
>         ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
>         pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> +       dev->ptm_enabled = 0;

-> I don't think that this is going to work without setting
dev->ptm_enabled in pci_restore_ptm_state() if the restored state
turns out to be "enabled".

>  }
>
>  void pci_save_ptm_state(struct pci_dev *dev)
> --
