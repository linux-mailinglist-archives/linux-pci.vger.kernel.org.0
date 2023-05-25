Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FDA710E10
	for <lists+linux-pci@lfdr.de>; Thu, 25 May 2023 16:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbjEYOPq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 25 May 2023 10:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjEYOPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 May 2023 10:15:45 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82422183;
        Thu, 25 May 2023 07:15:43 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-96f44435d92so63296366b.0;
        Thu, 25 May 2023 07:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685024142; x=1687616142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQ2g4elRikyixYIC50RK+Kur2gPh7SkgFNK50sXBtIU=;
        b=ljOzKGF7YfR1iOeq0xMEdkB/yQIaChrCege93rkn+Nr78TUusLUMfJjVSH32sd0H6c
         BEBJ3Nt0wjMEHVw+z116epDyUXu1wgrM1InGac1Ypxq36uvBC/CBCncRxP4WyHZ6/dgL
         E7yHZ1u0TyWB2cXUUMDwz1mmxaZzwmco3NRjVdrH0lwK/ATs53ijImVzeBbv/BQslO0F
         vBk4H5eSF2hRDKMoI9HVBFxB8U+x5JZ5lQmaO6YxPEYNVLSDxZ2e9kp31LiIq9DsGtEA
         KOgc2hiIqrbWc4mYJfR4tKxvm3nNB0I2A6dIkCypwuXzjAWBXrLOL7un0vGwEcI+ktNZ
         9hWQ==
X-Gm-Message-State: AC+VfDxU41QVEVqBcv/YMcrtrKrcnr+g2mm7OzNvoUJkUFfZDNErqQ9b
        Gql7uEK2/IYm0z+Y65hjkeV16/3eQKEkQAB03yU=
X-Google-Smtp-Source: ACHHUZ4hzHl+ujaKW7jGsG5zfh0wu+kzIkGH1M/X2hpn4MzleSBJWnQCYvcE6JgR+CFem1LH+sjTv1jhOvGlHTywx/s=
X-Received: by 2002:a17:906:d3:b0:94f:66af:b1f7 with SMTP id
 19-20020a17090600d300b0094f66afb1f7mr18698786eji.1.1685024141748; Thu, 25 May
 2023 07:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230524190726.17012-1-mario.limonciello@amd.com> <20230524190726.17012-2-mario.limonciello@amd.com>
In-Reply-To: <20230524190726.17012-2-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 May 2023 16:15:30 +0200
Message-ID: <CAJZ5v0j8b78LWiO0UsiXvdf6jLqnQ6yLM4hRgCjyNrDncaZMZQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: Don't assume root ports from > 2015 are power manageable
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        linux-pm@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Iain Lane <iain@orangesquash.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 24, 2023 at 9:07 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Using a USB keyboard or mouse to wakeup the system from s2idle fails when
> that XHCI device is connected to a USB-C port for an AMD USB4 router.
>
> Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> all PCIe ports go into D3 during s2idle.
>
> When specific root ports are put into D3 over s2idle on some AMD platforms
> it is not possible for the platform to properly identify wakeup sources.
> This happens whether the root port goes into D3hot or D3cold.
>
> Comparing registers between Linux and Windows 11 this behavior to put
> these specific root ports into D3 at suspend is unique to Linux. On an
> affected system Windows does not put those specific root ports into D3
> over Modern Standby.
>
> Windows doesn't put the root ports into D3 because root ports are not
> power manageable.
>
> Linux shouldn't assume root ports support D3 just because they're on a
> machine newer than 2015, the ports should also be deemed power manageable.
> Add an extra check explicitly for root ports to ensure D3 isn't selected
> for these ports.

"D3 isn't selected for them if they are not power-manageable through
platform firmware."  Or similar.

With this addressed:

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

>
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v3->v4:
>  * Move after refactor
> ---
>  drivers/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d1fa040bcea7..d293db963327 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3015,6 +3015,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>         if (dmi_check_system(bridge_d3_blacklist))
>                 return false;
>
> +       /*
> +        * It's not safe to put root ports that don't support power
> +        * management into D3.
> +        */
> +       if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
> +           !platform_pci_power_manageable(bridge))
> +               return false;
> +
>         /*
>          * It should be safe to put PCIe ports from 2015 or newer
>          * to D3.
> --
> 2.34.1
>
