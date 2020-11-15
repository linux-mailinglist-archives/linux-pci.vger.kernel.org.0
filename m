Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671E52B39BC
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 22:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgKOVuh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 16:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKOVuh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 16:50:37 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDFBC0613D1
        for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2020 13:50:10 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id d9so14893092qke.8
        for <linux-pci@vger.kernel.org>; Sun, 15 Nov 2020 13:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oIkYPZ0SakzMgHatFR/A8oArAP+zS6YPAV9y4P680qY=;
        b=FLNG5zTW3bB7TMa7M5sjk7ug8FYZJHEySAyfIYjXAwk+acScOiY7tygM4c5dQ6d1fN
         2/RKz2HJGFpvRVMKDR4FXHMDTNqN2z0uGECP89zjF0XboWN/XUAO6D0xdQJvU5s091bu
         hug9Dg1sCHTBTfnszAMuwmpHWegV9vhqUmFYSOcbMoDgnIvRAO4bO5ltBg4o4rnwDPTi
         J/eyfzt0IzTJDuYM9+EtQlk02i48Az/BuHcCMTXQgE0/wJwuG9BATCNDwgDWEnSprJ4p
         nzI3T7FDlAz/G/oUwpqL4EcM3DEzMNz/mJHrCxRPqF+iz3UggQZU9tACDBDsIpVfe/6g
         6HeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oIkYPZ0SakzMgHatFR/A8oArAP+zS6YPAV9y4P680qY=;
        b=AIVJTZngcG+YBVsuiCU7ZyBjJ4adIKF9YP5k6RFmxFh5ul7BcUNZOuQem3d/AZ0dB8
         49r/fbrK4l6wq/lWxgvLDY86CilRTHi66nhuX/xGpO8r2IIoMeiavBoC77V08wnlhCEx
         NU5fORsV7a4j0EASZ/fX2Wo7VQ03SqjdB5JtaENkRoyYrr4vnqoZ8n08njw92Yugubrk
         5Bu+bsDhNOXEo9hqkqNxgSGst70SY40suy2T1az9G1dKq5ugFJJUcWP4eZJTzO1MDVKR
         Gvial5Laq9thYcWVetqwfWDmAQzHlvOWm2y7RY+IUq3KifdQerbiq5eMJOIjTHNDvA7v
         TK4Q==
X-Gm-Message-State: AOAM531yqA/mxoozuGBJG8u8+HU0+6rFIuRfTa7DkaXKVb6yOAxMeiiM
        BzWzKtDtVkTziOqW735aWMNc9y82q2aiONRqCMg=
X-Google-Smtp-Source: ABdhPJwIxQVTRyhVDOCvUufnMLeRZZUJJZJcDhhZHp694WndqxmAwMfJBkbFIpHSl8kt7WWD68HO7O9mRcDt0oIb5y4=
X-Received: by 2002:a05:620a:208b:: with SMTP id e11mr11764486qka.380.1605477009889;
 Sun, 15 Nov 2020 13:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20201022183030.GA513862@bjorn-Precision-5520> <20201024205548.1837770-1-ian.kumlien@gmail.com>
 <20201024205548.1837770-2-ian.kumlien@gmail.com>
In-Reply-To: <20201024205548.1837770-2-ian.kumlien@gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sun, 15 Nov 2020 22:49:59 +0100
Message-ID: <CAA85sZtNO+jD1TZrv+YYzh96z_5wG+zuG-0nEbapMz3RMt+Rvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI/ASPM: Fix L0s max latency check
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

*bump*

On Sat, Oct 24, 2020 at 10:55 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> From what I have been able to figure out, it seems like LOs path latency
> is cumulative, so the max path latency should be the sum of all links
> maximum latency.
>
> Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index c03ead0f1013..dbe3ce60c1ff 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
>
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
> -       u32 latency, l1_max_latency = 0, l1_switch_latency = 0;
> +       u32 latency, l1_max_latency = 0, l1_switch_latency = 0,
> +               l0s_latency_up = 0, l0s_latency_dw = 0;
>         struct aspm_latency *acceptable;
>         struct pcie_link_state *link;
>
> @@ -448,14 +449,18 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>
>         while (link) {
>                 /* Check upstream direction L0s latency */
> -               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> -                   (link->latency_up.l0s > acceptable->l0s))
> -                       link->aspm_capable &= ~ASPM_STATE_L0S_UP;
> +               if (link->aspm_capable & ASPM_STATE_L0S_UP) {
> +                       l0s_latency_up += link->latency_up.l0s;
> +                       if (l0s_latency_up > acceptable->l0s)
> +                               link->aspm_capable &= ~ASPM_STATE_L0S_UP;
> +               }
>
>                 /* Check downstream direction L0s latency */
> -               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> -                   (link->latency_dw.l0s > acceptable->l0s))
> -                       link->aspm_capable &= ~ASPM_STATE_L0S_DW;
> +               if (link->aspm_capable & ASPM_STATE_L0S_DW) {
> +                       l0s_latency_dw += link->latency_dw.l0s;
> +                       if (l0s_latency_dw > acceptable->l0s)
> +                               link->aspm_capable &= ~ASPM_STATE_L0S_DW;
> +               }
>
>                 /*
>                  * Check L1 latency.
> --
> 2.29.1
>
