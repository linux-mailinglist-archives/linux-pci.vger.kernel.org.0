Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B542378304A
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 20:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjHUSfX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 21 Aug 2023 14:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHUSfX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 14:35:23 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117BA41E5D;
        Mon, 21 Aug 2023 11:35:20 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6bb1133b063so486765a34.1;
        Mon, 21 Aug 2023 11:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692642920; x=1693247720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03epZPgoSBqLoqs55VcIbrAIzSLe1XSwVSLHjIr/5go=;
        b=eXq8IUN3j+ksPfrPG+qHRoW83iWJOQoCCmhyO53MiXlqcDhhPkVifWcyonEyaG87HP
         LOeWuY7Ej7ZXfv8ihsVBF/ByOzlFwFSjkjT/zl5JOrHBghSPVapNdCa3LyE195u2oBQI
         mxMm91/6TmJ7fnZBohXYUxhWMku/qUjkShj08JVyRQP6aRhEifjMCN/NANkOjyPCIREk
         Tsgih5xxLnVTXWztOEU5e0sbX2crs7KBkP95o4vYawIvSZPxvLPl0uHvufoJgpI8okJY
         rcdga2AqnLtT4zOOKX/yDdHT5wbw0YbRc3ZU9DfA6uKJczS3JlGTesMjWFzLdC+GUgVs
         AnIQ==
X-Gm-Message-State: AOJu0YxPgvjW57g9QS3+E8GHqAK9DFzKPW0bUKTUAA9tzPbpriDngT7w
        KaoXhaPwJg12cbGPUdY2HccCbrjd+4YTRd/FjcJxLxFi
X-Google-Smtp-Source: AGHT+IEV5cMwi4Lyeh9FPXP0fH4B4pjAg+sFZZZgVJq9zMIdGYhTtMhugu9JeQWsWgMoMUZUDgRmUPA4m9qFxNkyKsg=
X-Received: by 2002:a4a:e882:0:b0:570:d852:f77f with SMTP id
 g2-20020a4ae882000000b00570d852f77fmr3014293ooe.1.1692642920037; Mon, 21 Aug
 2023 11:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194027.27559-1-mario.limonciello@amd.com> <20230818194027.27559-2-mario.limonciello@amd.com>
In-Reply-To: <20230818194027.27559-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 20:35:04 +0200
Message-ID: <CAJZ5v0hzPPgnUTPcpfebSxBN=e5U6WLA9T=86QDTkyK0uwPq3w@mail.gmail.com>
Subject: Re: [PATCH v14.c 1/4] PCI: ACPI: Add helper functions for converting
 ACPI <-> PCI states
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 9:40 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Several functions do internal mappings in either direction. Add
> helpers for this functionality.  No intended functional changes.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v10->v11:
>  * New patch
> ---
>  drivers/pci/pci-acpi.c | 87 +++++++++++++++++++++++++-----------------
>  1 file changed, 53 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a05350a4e49cb..b5b65cdfa3b8b 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -884,6 +884,56 @@ acpi_status pci_acpi_add_pm_notifier(struct acpi_device *dev,
>         return acpi_add_pm_notifier(dev, &pci_dev->dev, pci_acpi_wake_dev);
>  }
>
> +/**
> + * map_pci_to_acpi - map a PCI power state to an ACPI D-state
> + * @state: PCI power state to map
> + *
> + * Returns: Corresponding ACPI D-state, otherwise ACPI_STATE_UNKNOWN
> + */
> +static u8 map_pci_to_acpi(pci_power_t state)

I would prefer to call this pci_power_state_to_acpi() and analogously
for the other one.

With this addressed, please feel free to add my ACK to the patch.

> +{
> +       switch (state) {
> +       case PCI_D0:
> +               return ACPI_STATE_D0;
> +       case PCI_D1:
> +               return ACPI_STATE_D1;
> +       case PCI_D2:
> +               return ACPI_STATE_D2;
> +       case PCI_D3hot:
> +               return ACPI_STATE_D3_HOT;
> +       case PCI_D3cold:
> +               return ACPI_STATE_D3_COLD;
> +       }
> +
> +       return ACPI_STATE_UNKNOWN;
> +}
> +
> +/**
> + * map_acpi_to_pci - map an ACPI D-state to a PCI power state
> + * @state: ACPI D-state to map
> + *
> + * Returns: Corresponding PCI power state, otherwise PCI_POWER_ERROR.
> + */
> +static pci_power_t map_acpi_to_pci(int state)
> +{
> +       switch (state) {
> +       case ACPI_STATE_D0:
> +               return PCI_D0;
> +       case ACPI_STATE_D1:
> +               return PCI_D1;
> +       case ACPI_STATE_D2:
> +               return PCI_D2;
> +       case ACPI_STATE_D3_HOT:
> +               return PCI_D3hot;
> +       case ACPI_STATE_D3_COLD:
> +               return PCI_D3cold;
> +       case ACPI_STATE_UNKNOWN:
> +               return PCI_UNKNOWN;
> +       }
> +
> +       return PCI_POWER_ERROR;
> +}
> +
>  /*
>   * _SxD returns the D-state with the highest power
>   * (lowest D-state number) supported in the S-state "x".
> @@ -919,19 +969,7 @@ pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>         if (acpi_state < 0)
>                 return PCI_POWER_ERROR;
>
> -       switch (acpi_state) {
> -       case ACPI_STATE_D0:
> -               return PCI_D0;
> -       case ACPI_STATE_D1:
> -               return PCI_D1;
> -       case ACPI_STATE_D2:
> -               return PCI_D2;
> -       case ACPI_STATE_D3_HOT:
> -               return PCI_D3hot;
> -       case ACPI_STATE_D3_COLD:
> -               return PCI_D3cold;
> -       }
> -       return PCI_POWER_ERROR;
> +       return map_acpi_to_pci(acpi_state);
>  }
>
>  static struct acpi_device *acpi_pci_find_companion(struct device *dev);
> @@ -1056,13 +1094,6 @@ static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
>  int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  {
>         struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> -       static const u8 state_conv[] = {
> -               [PCI_D0] = ACPI_STATE_D0,
> -               [PCI_D1] = ACPI_STATE_D1,
> -               [PCI_D2] = ACPI_STATE_D2,
> -               [PCI_D3hot] = ACPI_STATE_D3_HOT,
> -               [PCI_D3cold] = ACPI_STATE_D3_COLD,
> -       };
>         int error;
>
>         /* If the ACPI device has _EJ0, ignore the device */
> @@ -1089,7 +1120,7 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>                 acpi_pci_config_space_access(dev, false);
>         }
>
> -       error = acpi_device_set_power(adev, state_conv[state]);
> +       error = acpi_device_set_power(adev, map_pci_to_acpi(state));
>         if (error)
>                 return error;
>
> @@ -1111,23 +1142,11 @@ int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>  pci_power_t acpi_pci_get_power_state(struct pci_dev *dev)
>  {
>         struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> -       static const pci_power_t state_conv[] = {
> -               [ACPI_STATE_D0]      = PCI_D0,
> -               [ACPI_STATE_D1]      = PCI_D1,
> -               [ACPI_STATE_D2]      = PCI_D2,
> -               [ACPI_STATE_D3_HOT]  = PCI_D3hot,
> -               [ACPI_STATE_D3_COLD] = PCI_D3cold,
> -       };
> -       int state;
>
>         if (!adev || !acpi_device_power_manageable(adev))
>                 return PCI_UNKNOWN;
>
> -       state = adev->power.state;
> -       if (state == ACPI_STATE_UNKNOWN)
> -               return PCI_UNKNOWN;
> -
> -       return state_conv[state];
> +       return map_acpi_to_pci(adev->power.state);
>  }
>
>  void acpi_pci_refresh_power_state(struct pci_dev *dev)
> --
> 2.34.1
>
