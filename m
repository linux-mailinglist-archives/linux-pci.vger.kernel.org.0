Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C61673B8F
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 15:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjASOWW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 09:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjASOWT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 09:22:19 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049D23A82
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:22:12 -0800 (PST)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4FF6B41933
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 14:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1674138130;
        bh=cgpSJDuhoHdYNyebTdBDMFK/DhdY7FLUq4k1xDyDUX0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NW+0ytyxk4R7hhM0JakPaXXCh3FAC0GTt8kTSZa2CJ1m0YhljRBgKnr54pOe5Gw94
         lYVUnO14gieEiBSOOMMXLrYsB1ex9X1UVs1ACoOSPSmIglxYbhwYgIGUr9TyFIY4NS
         ZF6VdFQVxvoHJOzd6TnLoldIYrpvVQlv1oqLYtf/xVCFOquYDyKuW91Km4Ja6Cgwi4
         Aw228H97JYcr6jPLIkPEfYfrUv9N2gp7x0TkXMSeoK81ijaFcKy1Zyy6y5wPRanxw1
         Ubiix3qwhx7MD3AKgLL7oFGoabgZ/ona5c2d3Ryq5btwOr5xyFm77x+DGH193mtYUu
         qzYqsot2nkyww==
Received: by mail-pj1-f69.google.com with SMTP id g20-20020a17090adb1400b0022941a246aaso1152588pjv.0
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgpSJDuhoHdYNyebTdBDMFK/DhdY7FLUq4k1xDyDUX0=;
        b=WucezXjBLC8Hw5e0Iy5NOTYbrHQhmQ10e2bq/CNdO4HJ/7vExzNCJci4SYRTihhWoz
         59BDGApVO1shIiTNvbz+bIvNjnJmWy7ArgWNCX1ere6EtEkk4pWSrLQK/QuIMLtGtUZ6
         ZW9jUY/sPyN7icxvZD6BpnWOyWmKaEJKLyvlBYVxQhZt5X2IJl38GDNmcLHfs95EUFqD
         5bV3rhYzpfoKiTBzvwrJ8bk/7QlMM3jN5A6NkpWM1E2L1i+LMrAPpD9PRA9M+7Ri5CQ4
         w/OlvYk1gl81xnKsfXxEKcA+KL1+OGblo8lqcgNlsjROEsvn9S8DZai9CUYInMrKd6lq
         Kvxg==
X-Gm-Message-State: AFqh2koZWtdpQc8WTdgMpPs2BaqJTNQjXCi/YIHCXR3CyzIwVbzci2rV
        foALTS8oyqDPpSF4crPRB4SjZfndeL/+oU4JxI2AMIwPNhirQAxcIL0pZ7Z6OYgAQMWpAgUKYZH
        3mqqnTIQoZxExZkV+sE1nmcglYZXvbbx2kcT3nkQfXh3kEG9su1Sz6g==
X-Received: by 2002:a62:e317:0:b0:588:cb81:9221 with SMTP id g23-20020a62e317000000b00588cb819221mr1089723pfh.69.1674138128685;
        Thu, 19 Jan 2023 06:22:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsC4VqSbP6q7GcLRsSobmOhfD0wGXev/8fvUb7iRmApAcePDZET6T0MXxQUkEqNtvXxMmo3r5VRnX+ZyxXyci8=
X-Received: by 2002:a62:e317:0:b0:588:cb81:9221 with SMTP id
 g23-20020a62e317000000b00588cb819221mr1089712pfh.69.1674138128350; Thu, 19
 Jan 2023 06:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20230119094913.20536-1-vidyas@nvidia.com>
In-Reply-To: <20230119094913.20536-1-vidyas@nvidia.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 19 Jan 2023 22:21:57 +0800
Message-ID: <CAAd53p5R9BHoYpHq6WNgwtUAXmvNQnk6gA=C27JTfqeozRKCzQ@mail.gmail.com>
Subject: Re: [PATCH V1] PCI/ASPM: Skip L1SS save/restore if not already enabled
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        rafael.j.wysocki@intel.com, enriquezmark36@gmail.com,
        tasev.stefanoska@skynet.be, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
        sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya,

On Thu, Jan 19, 2023 at 5:49 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Skip save and restore of ASPM L1 Sub-States specific registers if they
> are not already enabled in the system. This is to avoid issues observed
> on certain platforms during restoration process, particularly when
> restoring the L1SS registers contents.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216782
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/pcie/aspm.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 53a1fa306e1e..5d3f09b0a6a9 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -757,15 +757,29 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>                                 PCI_L1SS_CTL1_L1SS_MASK, val);
>  }
>
> +static bool skip_l1ss_restore;

Maybe move it inside "struct pci_dev"?

Kai-Heng

> +
>  void pci_save_aspm_l1ss_state(struct pci_dev *dev)
>  {
>         struct pci_cap_saved_state *save_state;
>         u16 l1ss = dev->l1ss;
> -       u32 *cap;
> +       u32 *cap, val;
>
>         if (!l1ss)
>                 return;
>
> +       /*
> +        * Skip save and restore of L1 Sub-States registers if they are not
> +        * already enabled in the system
> +        */
> +       pci_read_config_dword(dev, l1ss + PCI_L1SS_CTL1, &val);
> +       if (!(val & PCI_L1SS_CTL1_L1SS_MASK)) {
> +               skip_l1ss_restore = 1;
> +               return;
> +       }
> +
> +       skip_l1ss_restore = 0;
> +
>         save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>         if (!save_state)
>                 return;
> @@ -784,6 +798,9 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
>         if (!l1ss)
>                 return;
>
> +       if (skip_l1ss_restore)
> +               return;
> +
>         save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
>         if (!save_state)
>                 return;
> --
> 2.17.1
>
