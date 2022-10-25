Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1895A60D4E0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 21:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiJYToX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 15:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiJYToW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 15:44:22 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3270EB3B0F;
        Tue, 25 Oct 2022 12:44:22 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id z6so464742qtv.5;
        Tue, 25 Oct 2022 12:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGKKI9J0n8rIfX9oZQEzGX9YCINu+GWwt1TnCnAQ1BI=;
        b=RGO9b1RyvlxzdykVmp+1WwQtBh4Jp+Y7clVN7yDetbyd+VWu/eE6F/wxSIwM6neeDg
         GCLrouykg1qrekal3Iy2RHE1DelVO2iiKlCAQqeP4+nL99Fw78UCcq1zn8kNNTTxM8+n
         RYTAQvfDybDM8fLKEGn6doTDizQhz+nvncc1Wd83oYGWkGd7yONj8yKhO0oaxvBCOLKh
         M8MM5yfyr6OlfLzrqjVQsdEDYceMLjquh8GMmxHZm5S8yK6YSduyfl0gpIUuSsc6evRL
         S5KJVgzM7tWO7fxc4a33PGxsDKGeoVj8ImJcOT6d0xcYYlrBrrFicYXiy+p2C9ZIDPwX
         L2IQ==
X-Gm-Message-State: ACrzQf0Tu/ZAthnj8L5lHvlH55di+4+xVUuP+8umEsopIqUNqnvPGxEU
        PxoAqYunhCtRRGut9/wztXGd2r5pNjy32q3HM1U=
X-Google-Smtp-Source: AMsMyM5ytdS2lcDQqzDLgwIWQq2p+uoveyPZE8UkKxS+0igoe4Zqlk/GW6VpUD0GhIlenQaqje0ZaT1HLvLRYgfLmQo=
X-Received: by 2002:ac8:7d02:0:b0:39c:bbef:178a with SMTP id
 g2-20020ac87d02000000b0039cbbef178amr33243867qtb.357.1666727061344; Tue, 25
 Oct 2022 12:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221025193502.669091-1-helgaas@kernel.org>
In-Reply-To: <20221025193502.669091-1-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Oct 2022 21:44:10 +0200
Message-ID: <CAJZ5v0g-EoVgpC3qot4iBqXp98-Ejt7ib28qxtDJfCjr13EVBg@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Remove unused 'state' parameter to pci_legacy_suspend_late()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 25, 2022 at 9:35 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> 1a1daf097e21 ("PCI/PM: Remove unused pci_driver.suspend_late() hook")
> removed the legacy .suspend_late() hook, which was the only user of the
> "state" parameter to pci_legacy_suspend_late(), but it neglected to remove
> the parameter.
>
> Remove the unused "state" parameter to pci_legacy_suspend_late().
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci-driver.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 107d77f3c846..a2ceeacc33eb 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -646,7 +646,7 @@ static int pci_legacy_suspend(struct device *dev, pm_message_t state)
>         return 0;
>  }
>
> -static int pci_legacy_suspend_late(struct device *dev, pm_message_t state)
> +static int pci_legacy_suspend_late(struct device *dev)
>  {
>         struct pci_dev *pci_dev = to_pci_dev(dev);
>
> @@ -848,7 +848,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
>                 return 0;
>
>         if (pci_has_legacy_pm_support(pci_dev))
> -               return pci_legacy_suspend_late(dev, PMSG_SUSPEND);
> +               return pci_legacy_suspend_late(dev);
>
>         if (!pm) {
>                 pci_save_state(pci_dev);
> @@ -1060,7 +1060,7 @@ static int pci_pm_freeze_noirq(struct device *dev)
>         const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>
>         if (pci_has_legacy_pm_support(pci_dev))
> -               return pci_legacy_suspend_late(dev, PMSG_FREEZE);
> +               return pci_legacy_suspend_late(dev);
>
>         if (pm && pm->freeze_noirq) {
>                 int error;
> @@ -1179,7 +1179,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>                 return 0;
>
>         if (pci_has_legacy_pm_support(pci_dev))
> -               return pci_legacy_suspend_late(dev, PMSG_HIBERNATE);
> +               return pci_legacy_suspend_late(dev);
>
>         if (!pm) {
>                 pci_fixup_device(pci_fixup_suspend_late, pci_dev);
> --
> 2.25.1
>
