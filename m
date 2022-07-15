Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7C35760CB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 13:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiGOLrB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 07:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGOLrA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 07:47:00 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF556A9EB;
        Fri, 15 Jul 2022 04:46:56 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id l11so7978116ybu.13;
        Fri, 15 Jul 2022 04:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqoOKe5SVWSzGVBe5LzZqUphjZiBkwI10kR9M9RPLG0=;
        b=faZXnEm709nWF062CsgWRkuMtPiYwgJRZhADYAbkSvDhU+cNDQXFc+MHs0qhI5mj3F
         AjAPFtEKeDKDdXgwmBsKA2aG2Ujn4Is/KLpNG78hImXTFJi4x6SddjhuIzddndTPXIyV
         Kach4MebRKuP1cQpwsHcuGSLP2ILWT9FBO0VxxF3KoXvA2sckKj/6OvoQBpZm738uKKy
         57gHW/XAChuDzg1Gl0yywonaEbYLDBialOq7GAe0IbCw30zQbGfh0c7gbCAc6lAdgT1d
         n/0Q53H/Af6ErEun5l2YODsYvLObIGvkdg3xnzrD6JcSDMWy0RqX/oN3hIa37Jw+vVjJ
         mekQ==
X-Gm-Message-State: AJIora+MUP9qkbLBrBHROjL/RuGtYgkWyfqICgfD3htZ2y5iHA/SUCK3
        2KDj6WgrC7fAvFDuJnj+ikWdrTcDfnRVZ1ZYqIk=
X-Google-Smtp-Source: AGRyM1sqsGvLp77687+ihXREWyb60Vyk9yStrYlnFMG8MmY9EaCy0g8z/PVcJl2MmO4vTXXSR0BCEHi4c4qGwWggN+Q=
X-Received: by 2002:a05:6902:154f:b0:66e:e2d3:ce1 with SMTP id
 r15-20020a056902154f00b0066ee2d30ce1mr12620794ybu.365.1657885615913; Fri, 15
 Jul 2022 04:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220714231609.3962051-1-rajvi.jingar@linux.intel.com> <20220714231609.3962051-2-rajvi.jingar@linux.intel.com>
In-Reply-To: <20220714231609.3962051-2-rajvi.jingar@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 13:46:43 +0200
Message-ID: <CAJZ5v0g9XZ+K+C9g0a4MeMe9Ug2qkacSf4DoXR8F82Y0+gW09A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] PCI/PTM: fix to maintain pci_dev->ptm_enabled
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 15, 2022 at 1:16 AM Rajvi Jingar
<rajvi.jingar@linux.intel.com> wrote:
>
> pci_dev->ptm_enabled needs to be maintained to reflect the current PTM
> state of the device. In pci_ptm_disable(), clear ptm_enabled from
> 'struct pci_dev' on disabling PTM state for the device.
> In pci_restore_ptm_state(), set dev->ptm_enabled based on the restored
> PTM state of the device.
>
> Also, perform ptm_enabled check in pci_ptm_disable() to avoid config
> space access in case if PTM is already disabled for the device.
>
> Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> ---
>  v1->v2:
>    - add ptm_enabled check in pci_ptm_disable().
>    - set the dev->ptm_enabled value in pci_restore_ptm_state().
> ---
>  drivers/pci/pcie/ptm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
> index 368a254e3124..8dc7d2285a0d 100644
> --- a/drivers/pci/pcie/ptm.c
> +++ b/drivers/pci/pcie/ptm.c
> @@ -34,6 +34,9 @@ void pci_disable_ptm(struct pci_dev *dev)
>         int ptm;
>         u16 ctrl;
>
> +       if (!dev->ptm_enabled)
> +               return;
> +
>         if (!pci_is_pcie(dev))
>                 return;

After the check you've added this doesn't need to be checked any more,
because ptm_enabled will not be set if pci_is_pcie(dev) is not true
AFAICS.

Otherwise the patch looks good to me, so with the above addressed,
please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it.

Thanks!

>
> @@ -44,6 +47,7 @@ void pci_disable_ptm(struct pci_dev *dev)
>         pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
>         ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
>         pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
> +       dev->ptm_enabled = 0;
>  }
>
>  void pci_save_ptm_state(struct pci_dev *dev)
> @@ -83,6 +87,7 @@ void pci_restore_ptm_state(struct pci_dev *dev)
>
>         cap = (u16 *)&save_state->cap.data[0];
>         pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
> +       dev->ptm_enabled = !!(*cap & PCI_PTM_CTRL_ENABLE);
>  }
>
>  void pci_ptm_init(struct pci_dev *dev)
> --
> 2.25.1
>
