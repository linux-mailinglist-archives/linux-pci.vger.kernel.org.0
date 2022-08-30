Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400D55A6257
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiH3LpV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 07:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiH3LpB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 07:45:01 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD80117045;
        Tue, 30 Aug 2022 04:44:59 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-32a09b909f6so266791947b3.0;
        Tue, 30 Aug 2022 04:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=t+B7EEjiqzPV8xaGDoMqoY/YaDST1xRNBrGYIpaQQHw=;
        b=n3Muk6c5rQQNfLmhqHWgu1c6+DX7uhUsgnwiFA8rP+qLeVvCd2OTmZLjg9uHE5im/7
         UWsEOQNfRZyYnG0b23m3ZRItF4BWuGSnfjAwX33GwNYT36lhX5JU+/Kh5noSRGcr2g0F
         IhXod7Mn5wp/+CRjrTLXVg5p1dzdIRaxrmTBs7K4GzkF3q9cv08ojFmRhwuWNPa9HEcT
         glGwFcVAV3OyODO1eNetPAFkhkSg07nYov74fRYFl+OH1jvuqrISidrbtNfmBn2ZLGwP
         b+QgNqF7rTHDuKmC1W3+wQ4UAA8LCzpSZaPdCTBcGYazf5Al5UMLQ5QszTABEhd89nZ9
         jKGg==
X-Gm-Message-State: ACgBeo0Bl64np73F+Irzdr+vzIfV2qxLwujAufdNSLA/tyiAoJyf7v9v
        ziFC9y9tieQLdiSk28bBGmdRduSDO2ptJZBFFK7O76IL
X-Google-Smtp-Source: AA6agR66XPWPElr2vJy1jS/y04moHZWZ4OeZyoKfMtkoepLk8URqaiTBWK5A3TgtuDCn3hqOcqV9GtzlrmL5nteKNo0=
X-Received: by 2002:a0d:da83:0:b0:329:9c04:fe6d with SMTP id
 c125-20020a0dda83000000b003299c04fe6dmr13918409ywe.196.1661859898439; Tue, 30
 Aug 2022 04:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220830104913.1620539-1-rajvi.jingar@linux.intel.com>
In-Reply-To: <20220830104913.1620539-1-rajvi.jingar@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Aug 2022 13:44:43 +0200
Message-ID: <CAJZ5v0hhc+n+WbLCxbJ2VPSWj0RAy4AM+pvqy8eiAJVtBecVWg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] PCI/PM: refactor pci_pm_suspend_noirq()
To:     Rajvi Jingar <rajvi.jingar@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
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

Hi Bjorn,

On Tue, Aug 30, 2022 at 12:49 PM Rajvi Jingar
<rajvi.jingar@linux.intel.com> wrote:
>
> The state of the device is saved during pci_pm_suspend_noirq(), if it
> has not already been saved, regardless of the skip_bus_pm flag value. So
> skip_bus_pm check is removed before saving the device state.
>
> Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I have reviewed this and the [2/2] already and they are clear
improvements to me.

Do you have any concerns regarding any of them?

If not, do you want me to pick them up or do you plan to take care of
them yourself?

> ---
>  v1->v2: no change
>  v2->v3: no change
> ---
>  drivers/pci/pci-driver.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 49238ddd39ee..1f64de3e5280 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -867,20 +867,14 @@ static int pci_pm_suspend_noirq(struct device *dev)
>                 }
>         }
>
> -       if (pci_dev->skip_bus_pm) {
> +       if (!pci_dev->state_saved) {
> +               pci_save_state(pci_dev);
>                 /*
> -                * Either the device is a bridge with a child in D0 below it, or
> -                * the function is running for the second time in a row without
> -                * going through full resume, which is possible only during
> -                * suspend-to-idle in a spurious wakeup case.  The device should
> -                * be in D0 at this point, but if it is a bridge, it may be
> -                * necessary to save its state.
> +                * If the device is a bridge with a child in D0 below it, it needs to
> +                * stay in D0, so check skip_bus_pm to avoid putting it into a
> +                * low-power state in that case.
>                  */
> -               if (!pci_dev->state_saved)
> -                       pci_save_state(pci_dev);
> -       } else if (!pci_dev->state_saved) {
> -               pci_save_state(pci_dev);
> -               if (pci_power_manageable(pci_dev))
> +               if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
>                         pci_prepare_to_sleep(pci_dev);
>         }
>
> --
> 2.25.1
>
