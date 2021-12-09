Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55ADE46E630
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 11:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhLIKKJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 05:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhLIKKH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 05:10:07 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01644C061353
        for <linux-pci@vger.kernel.org>; Thu,  9 Dec 2021 02:06:34 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z8so8134886ljz.9
        for <linux-pci@vger.kernel.org>; Thu, 09 Dec 2021 02:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BKJ6vGqHSwm7BRFptl/55IB7GLQniF1Gw5ceok/cZhg=;
        b=B5Zp2DulMoGXJqx4vc3B7SZL7xVZhj/W5aL+CzKEd9CHd7Xd2LQ5neYf+MiQI+Utk2
         61jh6yKtjiLcidAJsE+wQoQLnDVxYU7ZnriuGOzjVlgyvHWed63kQd7pSu79ynK2yjoG
         2DQz5xLZRdPZdk6dlqB44W8/Q69w/Sfqs9HmAavXYaulF3zTmwYLckFVrlOOTgvUpVVd
         PpEZVh7b6IQFNsw5W2JI6GPayMWHHtB/J0jpQYqJCzpAdJu2nPEM+N1thQ1fUI8cCWhT
         ogrvUp1xK0I2EEQ9jCG7WzV3pzzgFjZUP70ZOLXahKWbuybqYXhHgp46xDCFAeXujY1b
         Pxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BKJ6vGqHSwm7BRFptl/55IB7GLQniF1Gw5ceok/cZhg=;
        b=rXl2wK602TfJsf+3u7FhNtSIYVc6LsAmeIY+fKmbQSIBTESjm+o+XJqUJyoA/x8lqP
         BIx4QecNgExtAcd5TrbsOVJf++S9i9rjbodcyD2N/wwEpExmDMnMrzBn6vQkIOMXBTys
         d43fH9JeJBGNmlNtLcHr3StRlQlk2Ahh2asSf+0PR2BObYCEg8LFJpsMRX6Yc7y+o28b
         GsU0gxuGSeXBb+KO8VJ5KXEerNYYFOUk4nUhJJUtmR2s8igoYwunXaFnemF0CvN/jEI6
         oON9YgLKChkAuGDqZV0NxA+9VexvFNlZobARQVI2h1VNyacX6C098L95ngaWAFClOnME
         +oLg==
X-Gm-Message-State: AOAM533Yri+Qyc/DB3TqZFAJSvJBDEsdiew2uq2syy1ZrGYug5CmI0t3
        5TKuC8ga0nCPinpotqJxV4k2PJPzStvJjS+ty1H8mg==
X-Google-Smtp-Source: ABdhPJxs4MQnQmfxefpgAy8GaEnwIv5pz3ZpFrg3sPEdkngTkbwJ1UYdI+ITuzs4VkkERX/T9pJjkunsgyGpfGxxQiI=
X-Received: by 2002:a2e:7114:: with SMTP id m20mr5180210ljc.229.1639044392212;
 Thu, 09 Dec 2021 02:06:32 -0800 (PST)
MIME-Version: 1.0
References: <20211208000948.487820-1-rajatja@google.com>
In-Reply-To: <20211208000948.487820-1-rajatja@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Dec 2021 11:05:56 +0100
Message-ID: <CAPDyKFqW_ttFxyVixWSuYwQa_SPcecRmf=u9KgMScGn0dd+uCg@mail.gmail.com>
Subject: Re: [PATCH] pci/quirks: Add quirk for Bayhub O2 SD controller
To:     Rajat Jain <rajatja@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        rajatxjain@gmail.com, jsbarnes@google.com, gwendal@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 8 Dec 2021 at 01:09, Rajat Jain <rajatja@google.com> wrote:
>
> This particular SD controller from O2 / Bayhub only allows dword
> accesses to its LTR max latency registers:
> https://github.com/rajatxjain/public_shared/blob/main/OZ711LV2_appnote.pdf
>
> Thus add a quirk that saves and restores these registers
> manually using dword acesses:
> LTR Max Snoop Latency Register
> LTR Max No-Snoop Latency Register
>
> Signed-off-by: Rajat Jain <rajatja@google.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci.h |  1 -
>  drivers/pci/quirks.c         | 39 ++++++++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h      |  1 +
>  3 files changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 5e3193278ff9..d47cc0ba7ca4 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -10,7 +10,6 @@
>  #define PCI_DEVICE_ID_O2_SDS1          0x8421
>  #define PCI_DEVICE_ID_O2_FUJIN2                0x8520
>  #define PCI_DEVICE_ID_O2_SEABIRD0      0x8620
> -#define PCI_DEVICE_ID_O2_SEABIRD1      0x8621
>
>  #define PCI_DEVICE_ID_INTEL_PCH_SDIO0  0x8809
>  #define PCI_DEVICE_ID_INTEL_PCH_SDIO1  0x880a
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 003950c738d2..b7bd19802744 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5857,3 +5857,42 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
>         pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
> +
> +/*
> + * Bayhub OZ711LV2 SD controller has an errata that only allows DWORD accesses
> + * to the LTR max latency registers. Thus need to save and restore these
> + * registers manually.
> + */
> +static void o2_seabird1_save_ltr(struct pci_dev *dev)
> +{
> +       struct pci_cap_saved_state *save_state;
> +       u32 *reg32;
> +
> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> +       if (save_state) {
> +               reg32 = &save_state->cap.data[0];
> +               /* Preserve PCI_LTR_MAX_SNOOP_LAT & PCI_LTR_MAX_NOSNOOP_LAT */
> +               pci_read_config_dword(dev, 0x234, reg32);
> +       } else {
> +               pci_err(dev, "quirk can't save LTR snoop latency\n");
> +       }
> +}
> +
> +static void o2_seabird1_restore_ltr(struct pci_dev *dev)
> +{
> +       struct pci_cap_saved_state *save_state;
> +       u32 *reg32;
> +
> +       save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
> +       if (save_state) {
> +               reg32 = &save_state->cap.data[0];
> +               /* Restore PCI_LTR_MAX_SNOOP_LAT & PCI_LTR_MAX_NOSNOOP_LAT */
> +               pci_write_config_dword(dev, 0x234, *reg32);
> +       } else {
> +               pci_err(dev, "quirk can't restore LTR snoop latency\n");
> +       }
> +}
> +DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_SEABIRD1,
> +                              o2_seabird1_save_ltr);
> +DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_SEABIRD1,
> +                              o2_seabird1_restore_ltr);
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 011f2f1ea5bb..6ed16aa38196 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1717,6 +1717,7 @@
>  #define PCI_DEVICE_ID_O2_8221          0x8221
>  #define PCI_DEVICE_ID_O2_8320          0x8320
>  #define PCI_DEVICE_ID_O2_8321          0x8321
> +#define PCI_DEVICE_ID_O2_SEABIRD1      0x8621
>
>  #define PCI_VENDOR_ID_3DFX             0x121a
>  #define PCI_DEVICE_ID_3DFX_VOODOO      0x0001
> --
> 2.34.1.400.ga245620fadb-goog
>
