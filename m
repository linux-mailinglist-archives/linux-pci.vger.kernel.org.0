Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F2D54312D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 15:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbiFHNQe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbiFHNQd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 09:16:33 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A3A3BA55;
        Wed,  8 Jun 2022 06:16:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s13so22695464ljd.4;
        Wed, 08 Jun 2022 06:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qbE4NOSoSmz8Bk9zM8BJuuluMSrujcIpd2/DIXfe5UE=;
        b=WKyiXeJLu4/8Chr1j17Br1vQyABHDAuyeJzKGzY39Jw+8OqPJ3qhT2ubPdKMKGfXwj
         gUSHE9G1kZASr+rGuEtD9WoBScdzsuW3/Gr50xRGhS+6KCLo6RqDroN4lZIiAC+iSp47
         lBZkd2lQFUs7rPyKCvVYxxOBfIZlKlfyXrLszhmYt+JFoc0PDQwb4gsAqHRX6nbV88ld
         Tw6UIm+iNPu670/IccroXCI6vIL0jCQO2IyDKsveZfbKR7vQYsdS3FU2RlI9GhSeUstA
         m+ehWbazzMRUaINfzdc+1uzlmVr6L9tPKa//kHBr4H9Mvlw8y2kTwNAka2ysUPkYjMTX
         JYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qbE4NOSoSmz8Bk9zM8BJuuluMSrujcIpd2/DIXfe5UE=;
        b=tI84d8nLSI1VLxfjvPlcK9nbV7NgXb/D+NxmrY8gkQHJRHU9jDSZJ5TUBJzqM16LlF
         DOcm6rh6FgpLlsuUOrv4EBqVOlXx0SZisPf7n9uuq/E1TYBeaPewV2HDs93X6Auy4bSb
         789xVPNEjst8DLDS85xgXc2Fe6mdfxcjdLGQNMS2v0/ZrCdEPAwGgk6i+k9QZ5JJWto+
         KfOsZHsiTtKAlcI9xMhWEnyesScya6eyTE8/v5nFNJmIMUNl2r9aIquLJmQAg3h3Kcir
         kyvY0KqTa3mY5P5TP3aLFNqKjzDW/i2KP5EOHj3FM1vFYI8Bb0b1uIyD9+21TP7duCxg
         obnw==
X-Gm-Message-State: AOAM533t5Q/MWfAxsHmKkmzDvexbhYMj65MeugIWiV1xwFmyr2Of4csT
        SpZsU5diZcDZn6aJvjzz505hTjDha/P3TCr/wME6MSitcr0=
X-Google-Smtp-Source: ABdhPJzn8MTbffVX48UnKEU9mHiXPLfWoLfaoZ3pX8/r8S2KVnn+esJ5R3KHSlsIZsTZtkI4RJdQxv5UUg1acGfYt0o=
X-Received: by 2002:a2e:b0c4:0:b0:255:6c75:36b3 with SMTP id
 g4-20020a2eb0c4000000b002556c7536b3mr19893592ljl.212.1654694190646; Wed, 08
 Jun 2022 06:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAGdb+H0qnC4noBa_=N3oQW88+dgXYtA7gqJ5qiD2g7Ywd+2K=Q@mail.gmail.com>
 <20220523171517.32407-1-windy.bi.enflame@gmail.com>
In-Reply-To: <20220523171517.32407-1-windy.bi.enflame@gmail.com>
From:   Sheng Bi <windy.bi.enflame@gmail.com>
Date:   Wed, 8 Jun 2022 21:16:23 +0800
Message-ID: <CAGdb+H29Lw-aUkFuot0Cd0i4KnP9PcnBQhBeJ5DkNymc9RTQ-A@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Fix no-op wait after secondary bus reset
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn, Alex, Lukas,

Is this acceptable or anything needs to be improved?

Thanks
windy

On Tue, May 24, 2022 at 1:15 AM Sheng Bi <windy.bi.enflame@gmail.com> wrote:
>
> pci_bridge_secondary_bus_reset() triggers SBR followed by 1 second sleep,
> and then uses pci_dev_wait() for waiting device ready. The dev parameter
> passes to the wait function is currently the bridge itself, but not the
> device been reset.
>
> If we call pci_bridge_secondary_bus_reset() to trigger SBR to a device,
> there is 1 second sleep but not waiting device ready, since the bridge
> is always ready while resetting downstream devices. pci_dev_wait() here
> is a no-op actually. This would be risky in the case which the device
> becomes ready after more than 1 second, especially while hotplug enabled.
> The late coming hotplug event after 1 second will trigger hotplug module
> to remove/re-insert the device.
>
> Instead of waiting ready of bridge itself, changing to wait all the
> downstream devices become ready with timeout PCIE_RESET_READY_POLL_MS
> after SBR, considering all downstream devices are affected during SBR.
> Once one of the devices doesn't reappear within the timeout, return
> -ENOTTY to indicate SBR doesn't complete successfully.
>
> Fixes: 6b2f1351af56 ("PCI: Wait for device to become ready after secondary bus reset")
> Signed-off-by: Sheng Bi <windy.bi.enflame@gmail.com>
> ---
>  drivers/pci/pci.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index eb7c0a08ff57..4653a9ae6e5b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5049,6 +5049,34 @@ void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev)
>         }
>  }
>
> +static int pci_bridge_secondary_bus_wait(struct pci_dev *bridge, int timeout)
> +{
> +       struct pci_dev *dev;
> +       unsigned long start_jiffies;
> +
> +       down_read(&pci_bus_sem);
> +
> +       if (!bridge->subordinate || list_empty(&bridge->subordinate->devices)) {
> +               up_read(&pci_bus_sem);
> +               return 0;
> +       }
> +
> +       list_for_each_entry(dev, &bridge->subordinate->devices, bus_list) {
> +               start_jiffies = jiffies;
> +
> +               if (timeout < 0 || pci_dev_wait(dev, "bus reset", timeout)) {
> +                       up_read(&pci_bus_sem);
> +                       return -ENOTTY;
> +               }
> +
> +               timeout -= jiffies_to_msecs(jiffies - start_jiffies);
> +       }
> +
> +       up_read(&pci_bus_sem);
> +
> +       return 0;
> +}
> +
>  void pci_reset_secondary_bus(struct pci_dev *dev)
>  {
>         u16 ctrl;
> @@ -5092,7 +5120,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
>  {
>         pcibios_reset_secondary_bus(dev);
>
> -       return pci_dev_wait(dev, "bus reset", PCIE_RESET_READY_POLL_MS);
> +       return pci_bridge_secondary_bus_wait(dev, PCIE_RESET_READY_POLL_MS);
>  }
>  EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
>
>
> base-commit: 617c8a1e527fadaaec3ba5bafceae7a922ebef7e
> --
> 2.36.1
>
