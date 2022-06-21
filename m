Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484EA552956
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 04:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbiFUC2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 22:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343906AbiFUC2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 22:28:14 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5905A30F
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 19:28:12 -0700 (PDT)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CB9863FC10
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 02:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1655778489;
        bh=UNuBfXpSXpZ3D5IsIMVi7WSYUlUBrkeS0wvAhdMcGn4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=jXguBKT86q/B6Q4v9zyHg7g5SX3fKhBSbn6+e8ZnPeSxyRyl5szALQUdqg+fuiwjH
         Xnx9SIV4rJwi/ajbBS7jgPAJI120lIwmxYdT5lRRFAft7rjTsmyAXxJgv49Gq0yN96
         As8G2qmyTu9tWam8PUIUFRaPyy70PkS6b60Ucdm98a2cHpvhKglJdaxUR0PMC3vPTk
         iAVyFqpAu1QiuAWngaeK0gVe6iqZyI62FjdkuIvL2Ln0tHH9g+aw1MDARLhxjnvS9P
         2Z9PtqK0xJgUQTcuoVZv5yF4OJgI8py6L/zazk8LiATDue/nSm1o2Z3Lj7LqzuSczc
         PDyB2MjKJYaKg==
Received: by mail-ot1-f70.google.com with SMTP id m28-20020a0568301e7c00b0060bf9048336so6658182otr.7
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 19:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNuBfXpSXpZ3D5IsIMVi7WSYUlUBrkeS0wvAhdMcGn4=;
        b=bxnHofKiFuhgqTuH26NMxjT7XFBPEQqxGZrOS5KMRRmSC+6jKaUkkXkD7cXzUjJhoA
         qBE/A47bxLipk6elx96IQcyOzx0HxV/g17GTe3qTSNivMthXMwmdpF+Y7ykBo2q7P9Xf
         BJxVl5WkUEzjV9+Xp4aaUQ5RmP1FP3/xQNvzroHoQ2EYGcgr2VEeGoHu6WV2aqF7oQ3n
         ayK81UZvDLqtINR1Rfgzcuo9vaPGRd7aEr/G2LL6UMydt1aA4CtD4q1jRpLCoVBdAvmY
         LFv2D0+Wkf7N/rQP8Nj1peBclFKk6tz6oZ98kACtyNByes11x/Hyfm0gVvAls9lojoYX
         tFlw==
X-Gm-Message-State: AJIora8WBDIEcWVuFT4IuPizp3gSviSFDo3md1JRzu1N9oKjb0u7mVWu
        XQmnwu/K4LwMsIrYk1aJRP5N7jRP40t+1EyF7TiEjD5GMkLB37x6aUN/oH0+oMa4A4fRCI+hi74
        dXyVF7ofypn5iXBmPAePZbXkGj1d2gC8L3a9oP7SO6t2YFWJ2luqf+w==
X-Received: by 2002:a9d:6d90:0:b0:60c:757d:1e08 with SMTP id x16-20020a9d6d90000000b0060c757d1e08mr10391489otp.224.1655778488500;
        Mon, 20 Jun 2022 19:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u/qEtWTOcznlFO6/6DzmXZHqIjqZLMEnnAkGj+c5obYAtzAP/o58AuerszAEur2YMurVxQsX1SFQAcL3Ku9a4=
X-Received: by 2002:a9d:6d90:0:b0:60c:757d:1e08 with SMTP id
 x16-20020a9d6d90000000b0060c757d1e08mr10391484otp.224.1655778488235; Mon, 20
 Jun 2022 19:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220509073639.2048236-1-kai.heng.feng@canonical.com>
In-Reply-To: <20220509073639.2048236-1-kai.heng.feng@canonical.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 21 Jun 2022 10:27:56 +0800
Message-ID: <CAAd53p4NZ1Pd0TteMm0=Pcd2s-F+f7--tkiUNQqMRm+NgZtuSQ@mail.gmail.com>
Subject: Re: [PATCH] PCI:ASPM: Remove pcie_aspm_pm_state_change()
To:     bhelgaas@google.com
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 9, 2022 at 3:37 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> pcie_aspm_pm_state_change() was introduced at the inception of PCIe
> ASPM code.
>
> However, it can cause some issues. For instance, when ASPM config is
> changed via sysfs, those changes won't persist across power state change
> because pcie_aspm_pm_state_change() overwrites them.
>
> In addition to that, if the driver is to restore L1ss [1] after system
> resume, the restored states will also be overwritten by
> pcie_aspm_pm_state_change().
>
> So remove pcie_aspm_pm_state_change() for now, if there's any hardware
> really needs it to function, a quirk can be used instead.
>
> [1] https://lore.kernel.org/linux-pci/20220201123536.12962-1-vidyas@nvidia.com/
>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

A gentle ping...

> ---
>  drivers/pci/pci.c       |  3 ---
>  drivers/pci/pci.h       |  2 --
>  drivers/pci/pcie/aspm.c | 19 -------------------
>  3 files changed, 24 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f1..d09f7b60ee4dc 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1181,9 +1181,6 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>         if (need_restore)
>                 pci_restore_bars(dev);
>
> -       if (dev->bus->self)
> -               pcie_aspm_pm_state_change(dev->bus->self);
> -
>         return 0;
>  }
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3d60cabde1a15..86a19f293d4ad 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -560,12 +560,10 @@ bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
>  #ifdef CONFIG_PCIEASPM
>  void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
> -void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
> -static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
>  #endif
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b7424c9bc8..7f76a5875feb4 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1012,25 +1012,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>         up_read(&pci_bus_sem);
>  }
>
> -/* @pdev: the root port or switch downstream port */
> -void pcie_aspm_pm_state_change(struct pci_dev *pdev)
> -{
> -       struct pcie_link_state *link = pdev->link_state;
> -
> -       if (aspm_disabled || !link)
> -               return;
> -       /*
> -        * Devices changed PM state, we should recheck if latency
> -        * meets all functions' requirement
> -        */
> -       down_read(&pci_bus_sem);
> -       mutex_lock(&aspm_lock);
> -       pcie_update_aspm_capable(link->root);
> -       pcie_config_aspm_path(link);
> -       mutex_unlock(&aspm_lock);
> -       up_read(&pci_bus_sem);
> -}
> -
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
>  {
>         struct pcie_link_state *link = pdev->link_state;
> --
> 2.34.1
>
