Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF5C5676D5
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 20:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiGESu4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 14:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiGESuz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 14:50:55 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5AC18370;
        Tue,  5 Jul 2022 11:50:54 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 76so7842800ybd.0;
        Tue, 05 Jul 2022 11:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rEEp1avjtVpzd2rsIuvCf8awzg9kogoo/eZ9Po79gdw=;
        b=7nJf6Nr24WQCYtyhTuUjddA2GsQqaAuNQJ0Dt+xvFDy7Th7ZuHAP6NqsbLnGfXe1uz
         zGdg1XdDC3eL1xHXCNu+coKL9TjtzpEIgMsyMnSuG53mReozZyqAk0oximOWg4Y4oSnM
         tmrhl9uyIGTb7xb4HHx+Hnpu7+F+PehbNY73f6SRowfnt5etTjSXHLNBax5ad79APcm2
         rOPVT7vMPRCLVe/sgSn4aotCwJP02gx9OtmVIKNDVDD+HAtK7d3m6TSbSzRnfTM2WCi2
         ijYl1kd7b02CekxddsVkFP2gZNYOR55UeEOW3iSDnfIfJiu+aY3TMm22A22VQReAlIeX
         EygQ==
X-Gm-Message-State: AJIora+27yAA4WGbIf/UQ/XP3Np4pJefReiKP92fd+cDM1aMERoZEihS
        Ve5oJwDlSglWsXtk5hsW2niM9NUNIcGTZTqLJlg=
X-Google-Smtp-Source: AGRyM1s+K+w9syS/4MUthIcayVyD+nAAsBHqrlB9RJMsRRD1+cb3mvFhbUNxWI/P5iK+pcwBsKRnGVi3K9dKqJ8GaC4=
X-Received: by 2002:a25:ab81:0:b0:66e:3dc5:898c with SMTP id
 v1-20020a25ab81000000b0066e3dc5898cmr15271965ybi.81.1657047054027; Tue, 05
 Jul 2022 11:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220607035158.308111-1-helgaas@kernel.org>
In-Reply-To: <20220607035158.308111-1-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 20:50:43 +0200
Message-ID: <CAJZ5v0idEvNRU5vmybRms4aQbBoUUH8CBRtaGT5O1bScND5ZSA@mail.gmail.com>
Subject: Re: [PATCH] PM / wakeup: Unify device_init_wakeup() for PM_SLEEP and !PM_SLEEP
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
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

On Tue, Jun 7, 2022 at 5:52 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previously the CONFIG_PM_SLEEP and !CONFIG_PM_SLEEP device_init_wakeup()
> implementations differed in confusing ways:
>
>   - The PM_SLEEP version checked for a NULL device pointer and returned
>     -EINVAL, while the !PM_SLEEP version did not and would simply
>     dereference a NULL pointer.
>
>   - When called with "false", the !PM_SLEEP version cleared "capable" and
>     "enable" in the opposite order of the PM_SLEEP version.  That was
>     harmless because for !PM_SLEEP they're simple assignments, but it's
>     unnecessary confusion.
>
> Use a simplified version of the PM_SLEEP implementation for both cases.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/base/power/wakeup.c | 30 ------------------------------
>  include/linux/pm_wakeup.h   | 31 +++++++++++++++++++++++--------
>  2 files changed, 23 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 11a4ffe91367..e3befa2c1b66 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -500,36 +500,6 @@ void device_set_wakeup_capable(struct device *dev, bool capable)
>  }
>  EXPORT_SYMBOL_GPL(device_set_wakeup_capable);
>
> -/**
> - * device_init_wakeup - Device wakeup initialization.
> - * @dev: Device to handle.
> - * @enable: Whether or not to enable @dev as a wakeup device.
> - *
> - * By default, most devices should leave wakeup disabled.  The exceptions are
> - * devices that everyone expects to be wakeup sources: keyboards, power buttons,
> - * possibly network interfaces, etc.  Also, devices that don't generate their
> - * own wakeup requests but merely forward requests from one bus to another
> - * (like PCI bridges) should have wakeup enabled by default.
> - */
> -int device_init_wakeup(struct device *dev, bool enable)
> -{
> -       int ret = 0;
> -
> -       if (!dev)
> -               return -EINVAL;
> -
> -       if (enable) {
> -               device_set_wakeup_capable(dev, true);
> -               ret = device_wakeup_enable(dev);
> -       } else {
> -               device_wakeup_disable(dev);
> -               device_set_wakeup_capable(dev, false);
> -       }
> -
> -       return ret;
> -}
> -EXPORT_SYMBOL_GPL(device_init_wakeup);
> -
>  /**
>   * device_set_wakeup_enable - Enable or disable a device to wake up the system.
>   * @dev: Device to handle.
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 196a157456aa..77f4849e3418 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -109,7 +109,6 @@ extern struct wakeup_source *wakeup_sources_walk_next(struct wakeup_source *ws);
>  extern int device_wakeup_enable(struct device *dev);
>  extern int device_wakeup_disable(struct device *dev);
>  extern void device_set_wakeup_capable(struct device *dev, bool capable);
> -extern int device_init_wakeup(struct device *dev, bool val);
>  extern int device_set_wakeup_enable(struct device *dev, bool enable);
>  extern void __pm_stay_awake(struct wakeup_source *ws);
>  extern void pm_stay_awake(struct device *dev);
> @@ -167,13 +166,6 @@ static inline int device_set_wakeup_enable(struct device *dev, bool enable)
>         return 0;
>  }
>
> -static inline int device_init_wakeup(struct device *dev, bool val)
> -{
> -       device_set_wakeup_capable(dev, val);
> -       device_set_wakeup_enable(dev, val);
> -       return 0;
> -}
> -
>  static inline bool device_may_wakeup(struct device *dev)
>  {
>         return dev->power.can_wakeup && dev->power.should_wakeup;
> @@ -217,4 +209,27 @@ static inline void pm_wakeup_hard_event(struct device *dev)
>         return pm_wakeup_dev_event(dev, 0, true);
>  }
>
> +/**
> + * device_init_wakeup - Device wakeup initialization.
> + * @dev: Device to handle.
> + * @enable: Whether or not to enable @dev as a wakeup device.
> + *
> + * By default, most devices should leave wakeup disabled.  The exceptions are
> + * devices that everyone expects to be wakeup sources: keyboards, power buttons,
> + * possibly network interfaces, etc.  Also, devices that don't generate their
> + * own wakeup requests but merely forward requests from one bus to another
> + * (like PCI bridges) should have wakeup enabled by default.
> + */
> +static inline int device_init_wakeup(struct device *dev, bool enable)
> +{
> +       if (enable) {
> +               device_set_wakeup_capable(dev, true);
> +               return device_wakeup_enable(dev);
> +       } else {
> +               device_wakeup_disable(dev);
> +               device_set_wakeup_capable(dev, false);
> +               return 0;
> +       }
> +}
> +
>  #endif /* _LINUX_PM_WAKEUP_H */
> --

Applied as 5.20 material, sorry for the delay.

Thanks!
