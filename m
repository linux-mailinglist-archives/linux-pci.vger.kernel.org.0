Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D720604F62
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 20:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJSSNW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 14:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiJSSNW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 14:13:22 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D05C17A96E;
        Wed, 19 Oct 2022 11:13:21 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id a5so11258852qkl.6;
        Wed, 19 Oct 2022 11:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCoElQflh0m8VyNBwlZI+w068x4un5hm0iPhuXR1jfY=;
        b=zHIPRwtMvKzBoqAr3acEc29gTyZ6gX8Z9CjKYPBigEg3Mefv7daCxPJJRuSGAHIIhG
         3710NKKMIwMxndrF8meXGljLB//wN9Qt+wqfADpKHTo7FAS2zje+HmVLTYCtPHgfaWWJ
         5hCbPjgaXF6e6b0r5h90CgHhY2hVhj2iscDY8K6DpCZqDMnMLHlodrVOa3drnEKDir+i
         ZfPUj++6vjU4fLkQEQ+kr/ZIv0nYlyS9hcz3vYHgaBuKf/g+xocgamafyx5nfcp1ANCQ
         J9XXTzM6+LHsRoPg4WPU+NjxkLPOtjgQS3DlQEczyoeN9AXYdsmDET+pI0eXYFqclJKN
         CDnQ==
X-Gm-Message-State: ACrzQf0B4+NjWjQ4SfM7KCZ4hbyRLC66UiaHDnaKDbozSXmnnxYiSH20
        kJIdcRgwM6KB9M6poaLiMdGdoVObL4C33nDZCv4=
X-Google-Smtp-Source: AMsMyM5K1XmBD1f9sP1sQHfGqEEY4qkxh8Dn5jP+eh92s19RLj/5ZBRJf+ZgtzGLjHjJchzavAqfem5bSn6CgYBA7TM=
X-Received: by 2002:a05:620a:2456:b0:6ee:e24f:74f7 with SMTP id
 h22-20020a05620a245600b006eee24f74f7mr6505732qkn.9.1666203200602; Wed, 19 Oct
 2022 11:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221019175931.3941-1-mario.limonciello@amd.com>
In-Reply-To: <20221019175931.3941-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 19 Oct 2022 20:13:09 +0200
Message-ID: <CAJZ5v0hG0YtQ9msqAQ4y1GhEyWjVQmRYxSM6zUFit6tjx720xQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Don't assume D3 support if a device is power manageable
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Oct 19, 2022 at 7:59 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On some firmware configurations where D3 is not supported for
> "AMD Pink Sardine" the PCIe root port for tunneling will still be
> opted into runtime PM since `acpi_pci_bridge_d3` returns true.
>
> This later causes the device link between the USB4 router and the
> PCIe root port for tunneling to misbehave.  The USB4 router may
> enters D3 via runtime PM, but the PCIe root port for tunneling
> remains in D0.  The expectation is the USB4 router should also
> remain in D0 since the PCIe root port for tunneling remained in D0.
>
> `acpi_pci_bridge_d3` has a number of checks, but starts out with an
> assumption that if a device is power manageable introduced from
> commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 if power
> managed by ACPI") that it will support D3.  This is not a valid
> assumption, as the PCIe root port for tunneling has power resources
> but does not support D3hot or D3cold.
>
> Instead of making this assertion from the power resources check
> immediately, move the check to later on, which will have validated
> that D3hot or D3cold can actually be reached.
>
> This fixes the USB4 router going into D3 when the firmware says that
> the PCIe root port for tunneling can't handle it.
>
> Fixes: dff6139015dc6 ("PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci-acpi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index a46fec776ad77..1e774a4645663 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -984,10 +984,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>         if (acpi_pci_disabled || !dev->is_hotplug_bridge)
>                 return false;
>
> -       /* Assume D3 support if the bridge is power-manageable by ACPI. */
> -       if (acpi_pci_power_manageable(dev))
> -               return true;
> -
>         rpdev = pcie_find_root_port(dev);
>         if (!rpdev)
>                 return false;
> @@ -1023,6 +1019,10 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>             obj->integer.value == 1)
>                 return true;
>
> +       /* Assume D3 support if the bridge is power-manageable by ACPI. */
> +       if (acpi_pci_power_manageable(dev))
> +               return true;
> +
>         return false;

return acpi_pci_power_manageable(dev);

would be simpler.

Otherwise it looks OK to me.

>  }
>
> --
> 2.34.1
>
