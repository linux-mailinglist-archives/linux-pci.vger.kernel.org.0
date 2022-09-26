Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955EF5E9795
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 03:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiIZBAE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Sep 2022 21:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiIZBAB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Sep 2022 21:00:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF7718B0F
        for <linux-pci@vger.kernel.org>; Sun, 25 Sep 2022 18:00:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id 13so10973755ejn.3
        for <linux-pci@vger.kernel.org>; Sun, 25 Sep 2022 18:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CklCJNhkPQ2aUgd9nkzbg3bJriRdeJ5r4RoiGqFwpSs=;
        b=SBTdUC6xAJkx4jFAk3n924DRcJWjY+LWXFvTm0a5UINd3dXzT/24UP/lE4Rei8heQR
         VdU1hGztX4ztWJ9i1wXohbOkmekPgpIgW9jNsxposcMBpcJsH/9IfBOBz62m68ivBSZJ
         9I3+h0gxknquWMsMFnXSNHrKticc8lpEoAJVhlQq13h0adncF4GhwndcwG18747Gel0H
         Oh7vKnZMLwUPHWp0dL1v6u8U0NWRxvRqjxcsOLsA9ZCYkqYFKYVh3sE9BAXgN4aLMgPW
         kJKeekraLXNe305tEJmvIFK9n9+EiE0tXoZFAOjy+PM7FwzgmVI9Nk2acpwXbex+EJqO
         ywVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CklCJNhkPQ2aUgd9nkzbg3bJriRdeJ5r4RoiGqFwpSs=;
        b=sB3PaKZV+KRCu1NNtgyFlF7RjEeDcesWY1kzed8qXp8RUAstqMb6R1DUDzSsm/KWdW
         L4BKsdE+v/ltgWmyvBhvQYE01Z4cIdSBFPUAP/VjDPEzQ+qlH1RVeT21FpcHCheR8tyv
         K8RtMiIvxudsMGKRLlgoGiJvpR+cGBvgBfAD04nuL3zb91nUPe3bCRKA0hFy27w+F8Nn
         eUqMnNpm4PIAGq0FoL+Yf74xsV8N9qzQssrDYYL4elvk9TG2/xuZASU784V9GfHXBsMs
         UHKMDH0DjpRIcXm643tQd0kD6AF3pBvCXqp40v9dtV2Vp39AoDPXwqDUDVPasXz4rWPb
         qDJw==
X-Gm-Message-State: ACrzQf1/ohqyHSPmzZgkukB82Dmxo2fMdpbzLFVkIp09yHsSq1B9QOeP
        xmjF30hmo0xbVmtZrUdQfEQFGewkzuqoaNWRSNqkCN9qSck=
X-Google-Smtp-Source: AMsMyM6+xKqZKrbzgaqCGd0cer+u5TDe6cl9iVOPgtaK8AuwTdkOYVIURKlXqm2MQR73bpY2KUqMmwoiEaOH/pL2Lks=
X-Received: by 2002:a17:907:da9:b0:783:a3b4:2cff with SMTP id
 go41-20020a1709070da900b00783a3b42cffmr1014418ejc.51.1664153998751; Sun, 25
 Sep 2022 17:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220602065544.2552771-1-nathan@nathanrossi.com>
In-Reply-To: <20220602065544.2552771-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
Date:   Mon, 26 Sep 2022 10:59:47 +1000
Message-ID: <CA+aJhH3MoR410Df-j44G=byL7rsHyiLwG_5nKXVk48Hfxrb=UA@mail.gmail.com>
Subject: Re: [PATCH] PCI/ASPM: Wait for data link active after retraining
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan.rossi@digi.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2 Jun 2022 at 16:55, Nathan Rossi <nathan@nathanrossi.com> wrote:
>
> From: Nathan Rossi <nathan.rossi@digi.com>
>
> When retraining the link either the child or the parent device may have
> the data link layer state machine of the respective devices move out of
> the active state despite the physical link training being completed.
> Depending on how long is takes for the devices to return to the active
> state, the device may not be ready and any further reads/writes to the
> device can fail.
>
> This issue is present with the pci-mvebu controller paired with a device
> supporting ASPM but without advertising the Slot Clock, where during
> boot the pcie_aspm_cap_init call would cause common clocks to be made
> consistent and then retrain the link. However the data link layer would
> not be active before any device initialization (e.g. ASPM capability
> queries, BAR configuration) causing improper configuration of the device
> without error.
>
> To ensure the child device is accessible, after the link retraining use
> pcie_wait_for_link to perform the associated state checks and any needed
> delays.
>
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> ---

Just pinging this patch, are there any comments or feedback for this change?

Thanks,
Nathan

>  drivers/pci/pcie/aspm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index a96b7424c9..4b8a1810be 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -288,7 +288,8 @@ static void pcie_aspm_configure_common_clock(struct pcie_link_state *link)
>                 reg16 &= ~PCI_EXP_LNKCTL_CCC;
>         pcie_capability_write_word(parent, PCI_EXP_LNKCTL, reg16);
>
> -       if (pcie_retrain_link(link))
> +       /* Retrain link and then wait for the link to become active */
> +       if (pcie_retrain_link(link) && pcie_wait_for_link(parent, true))
>                 return;
>
>         /* Training failed. Restore common clock configurations */
> ---
> 2.36.1
