Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4971C710D92
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbjEYNs6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 25 May 2023 09:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjEYNs5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 09:48:57 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6F2183;
        Thu, 25 May 2023 06:48:55 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso54103466b.0;
        Thu, 25 May 2023 06:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685022534; x=1687614534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulnPbMasQZ9QdQSKeDVnzi24f6zdyBi+Im7ADEzJMyA=;
        b=XaNcHxhEAmDGuVwxCq70Z5N5u8KfkwQS73atiWfYPhefn6JV4ADb7WoQrv3xAI/YNi
         h6IZgVF98ETL9QckdAImEqjhfviFJJ632RlN9BaAlWm2m39KiFBuOs6FOVrRv05P5Ukf
         f9epoio+RxuQVVcsHIhvxDcfBLCAxb8bytyQWIWpiO3ucqfmhIJj8g2rEuFtuOkPq0Hx
         /HPv97stMP66/V+/BOhFiFcNvrmYHeKYJx/yhag/QohOxQbp3n9CADeRvxOXYAxE+zXH
         lMf6A5Op4UCAn7hPRSmDJWzjfvMuF5iuwfEseX9qjTkM+V84cOwwcFd7W+LN3D6Rg8cR
         Fidw==
X-Gm-Message-State: AC+VfDxLLEj0SR94DJpRdqntoeZZNfLIOz0aysnic49C9PTrl/YoGVog
        hWitHGL8S2AcYk9Ufx1endKO3AngIG5uAw4ufU0=
X-Google-Smtp-Source: ACHHUZ4wqlnjPOCJ8af3d2Nl3n7/PWvdla2xecKePUGzrk4AZjwzkc6IoazM4SzubxM5+y7DNbP8QEf6V2ExJyqunEA=
X-Received: by 2002:a17:906:5350:b0:92e:f520:7762 with SMTP id
 j16-20020a170906535000b0092ef5207762mr19461750ejo.6.1685022533907; Thu, 25
 May 2023 06:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230524190726.17012-1-mario.limonciello@amd.com>
In-Reply-To: <20230524190726.17012-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 May 2023 15:48:42 +0200
Message-ID: <CAJZ5v0hhymQ-MSMOc0kCV4as6UhU0oHq0L0LRj4NC=VdAbrwVA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] PCI: Refactor pci_bridge_d3_possible()
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 24, 2023 at 9:07 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> All of the cases handled by pci_bridge_d3_possible() are specific
> to these branches:
> ```
>         case PCI_EXP_TYPE_ROOT_PORT:
>         case PCI_EXP_TYPE_UPSTREAM:
>         case PCI_EXP_TYPE_DOWNSTREAM:
> ```
> Drop a level of indentation by returning false in the default case
> instead.  No intended functional changes.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> v3->v4:
>  * New patch
> ---
>  drivers/pci/pci.c | 68 +++++++++++++++++++++++------------------------
>  1 file changed, 34 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5ede93222bc1..d1fa040bcea7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2978,48 +2978,48 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>         case PCI_EXP_TYPE_ROOT_PORT:
>         case PCI_EXP_TYPE_UPSTREAM:
>         case PCI_EXP_TYPE_DOWNSTREAM:
> -               if (pci_bridge_d3_disable)
> -                       return false;
> +               break;
> +       default:
> +               return false;
> +       }
>
> -               /*
> -                * Hotplug ports handled by firmware in System Management Mode
> -                * may not be put into D3 by the OS (Thunderbolt on non-Macs).
> -                */
> -               if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
> -                       return false;
> +       if (pci_bridge_d3_disable)
> +               return false;
>
> -               if (pci_bridge_d3_force)
> -                       return true;
> +       /*
> +        * Hotplug ports handled by firmware in System Management Mode
> +        * may not be put into D3 by the OS (Thunderbolt on non-Macs).
> +        */
> +       if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
> +               return false;
>
> -               /* Even the oldest 2010 Thunderbolt controller supports D3. */
> -               if (bridge->is_thunderbolt)
> -                       return true;
> +       if (pci_bridge_d3_force)
> +               return true;
>
> -               /* Platform might know better if the bridge supports D3 */
> -               if (platform_pci_bridge_d3(bridge))
> -                       return true;
> +       /* Even the oldest 2010 Thunderbolt controller supports D3. */
> +       if (bridge->is_thunderbolt)
> +               return true;
>
> -               /*
> -                * Hotplug ports handled natively by the OS were not validated
> -                * by vendors for runtime D3 at least until 2018 because there
> -                * was no OS support.
> -                */
> -               if (bridge->is_hotplug_bridge)
> -                       return false;
> +       /* Platform might know better if the bridge supports D3 */
> +       if (platform_pci_bridge_d3(bridge))
> +               return true;
>
> -               if (dmi_check_system(bridge_d3_blacklist))
> -                       return false;
> +       /*
> +        * Hotplug ports handled natively by the OS were not validated
> +        * by vendors for runtime D3 at least until 2018 because there
> +        * was no OS support.
> +        */
> +       if (bridge->is_hotplug_bridge)
> +               return false;
>
> -               /*
> -                * It should be safe to put PCIe ports from 2015 or newer
> -                * to D3.
> -                */
> -               if (dmi_get_bios_year() >= 2015)
> -                       return true;
> -               break;
> -       }
> +       if (dmi_check_system(bridge_d3_blacklist))
> +               return false;
>
> -       return false;
> +       /*
> +        * It should be safe to put PCIe ports from 2015 or newer
> +        * to D3.
> +        */
> +       return dmi_get_bios_year() >= 2015;
>  }
>
>  static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
> --
> 2.34.1
>
