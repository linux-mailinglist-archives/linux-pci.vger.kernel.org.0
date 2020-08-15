Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7AA245210
	for <lists+linux-pci@lfdr.de>; Sat, 15 Aug 2020 23:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgHOVks (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Aug 2020 17:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgHOVkm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Aug 2020 17:40:42 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CC0C0045A1
        for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2020 12:39:48 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cs12so5930310qvb.2
        for <linux-pci@vger.kernel.org>; Sat, 15 Aug 2020 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4mocpwJyI2iSrQIooj9pfL6ha3pilCOZ3jcOu0567rU=;
        b=b6hAXtH+j6FX5leoisLZ0MiFc/U0LwoUisJf0PcF10GvYJPturb7sdsq/mO6F2wxIl
         dBy20CJl7IcoWG+XOs+IWot+tvOgbN1X1qgRi5xR7wWzL3hXcza7Cs2ZT5L75ptV6e5n
         plxJok5vbg3cC0OzIw4RNYG/zEmCmU6Bho89hb1/8OvWafBlhyR5oPzIXH6ojrbA0oks
         tTMIvkQ6U89Sov3Vk1f1kHMBJVl+j2YPDZ4ZBgwYEMGYL8lfJDsCnVMrN6BTQnfeqCsC
         Hcf7z2aRP94ieYSCx78oIftvVno4BIJ5RkEnz7h+JQljsM/3/WqB2E6Z35LWAPCnKI+n
         D8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4mocpwJyI2iSrQIooj9pfL6ha3pilCOZ3jcOu0567rU=;
        b=jKu6BZFe+4lvuchGy3SLLKA64LORjFDkKc5td7cm4U8YSLZWZJITWq920OlHfgVPaW
         bu9KZjD7IjpRhBjAQvdNVPmSrY/MJmVk19A5hE2o6B2n/ly21lTEgxvi/dpdrbsJr3y4
         PL5TXZ03JWJFA7wPWUNjs7oZPhI5D8Y+IjZMfo1fYldIJmkzKsG9LgRIH6GXG0wThCyP
         dMdnoOOzaCAUpO2vL6+XL5VW7LzHTRW09g0RejJ5tP0dSObJBchfDKKgaLhk7KWaxFqb
         ITefvVGU9WrdKpy/1x9BHjX1svZEVqr34xdqxYfdpr/GxI6sQceM6FZPzt7xyvWd91+I
         SF6A==
X-Gm-Message-State: AOAM531/Cs1JEtfbz1HKPDlrINeVqczbsYHMBa6DtfOdbpscD3KyKyyN
        rGDA7TESeeGqFBmeKWqAk4hVyCT8gGNn3B/BCP86HHvSzIU=
X-Google-Smtp-Source: ABdhPJyZ8MtT4znJcNhiICl36zGgZUJlhgJX0RvC4xjftN3LpCmXYCFM7DmARbLYxyGfNgwNMR+JiMhzBFZUyhpwKW0=
X-Received: by 2002:ad4:49b4:: with SMTP id u20mr8264175qvx.73.1597520387048;
 Sat, 15 Aug 2020 12:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200729222758.GA1963264@bjorn-Precision-5520> <20200803145832.11234-1-ian.kumlien@gmail.com>
In-Reply-To: <20200803145832.11234-1-ian.kumlien@gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sat, 15 Aug 2020 21:39:35 +0200
Message-ID: <CAA85sZtKSwyjXDK8TK_bpd6GMJkQafA5ur-sC=s_zDKx_0zU7w@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi again,

Just trying to bump and also asking a question ...

That 1 us, could that be related to L0s latency - so should we add a
potential workaround by doing
max_t(u32, 1000, L0s.up + L0s.dw) to ensure that the time is never
greater on any hardware ;)

And also warn about it... =)

On Mon, Aug 3, 2020 at 4:58 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> Changes:
> * Handle L0s correclty as well, making it per direction
> * Moved the switch cost in to the if statement since a non L1 switch has
>   no additional cost.
>
> For L0s:
> We sumarize the entire latency per direction to see if it's acceptable
> for the PCIe endpoint.
>
> If it's not, we clear the link for the path that had too large latency.
>
> For L1:
> Currently we check the maximum latency of upstream and downstream
> per link, not the maximum for the path
>
> This would work if all links have the same latency, but:
> endpoint -> c -> b -> a -> root  (in the order we walk the path)
>
> If c or b has the higest latency, it will not register
>
> Fix this by maintaining the maximum latency value for the path
>
> This change fixes a regression introduced (but not caused) by:
> 66ff14e59e8a (PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges)
>
> Signed-off-by: Ian Kumlien <ian.kumlien@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index b17e5ffd31b1..bc512e217258 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -434,7 +434,8 @@ static void pcie_get_aspm_reg(struct pci_dev *pdev,
>
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
> -       u32 latency, l1_switch_latency = 0;
> +       u32 latency, l1_max_latency = 0, l1_switch_latency = 0,
> +               l0s_latency_up = 0, l0s_latency_dw = 0;
>         struct aspm_latency *acceptable;
>         struct pcie_link_state *link;
>
> @@ -447,15 +448,22 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>         acceptable = &link->acceptable[PCI_FUNC(endpoint->devfn)];
>
>         while (link) {
> -               /* Check upstream direction L0s latency */
> -               if ((link->aspm_capable & ASPM_STATE_L0S_UP) &&
> -                   (link->latency_up.l0s > acceptable->l0s))
> -                       link->aspm_capable &= ~ASPM_STATE_L0S_UP;
> -
> -               /* Check downstream direction L0s latency */
> -               if ((link->aspm_capable & ASPM_STATE_L0S_DW) &&
> -                   (link->latency_dw.l0s > acceptable->l0s))
> -                       link->aspm_capable &= ~ASPM_STATE_L0S_DW;
> +               if (link->aspm_capable & ASPM_STATE_L0S) {
> +                       /* Check upstream direction L0s latency */
> +                       if (link->aspm_capable & ASPM_STATE_L0S_UP) {
> +                               l0s_latency_up += link->latency_up.l0s;
> +                               if (l0s_latency_up > acceptable->l0s)
> +                                       link->aspm_capable &= ~ASPM_STATE_L0S_UP;
> +                       }
> +
> +                       /* Check downstream direction L0s latency */
> +                       if (link->aspm_capable & ASPM_STATE_L0S_DW) {
> +                               l0s_latency_dw += link->latency_dw.l0s;
> +                               if (l0s_latency_dw > acceptable->l0s)
> +                                       link->aspm_capable &= ~ASPM_STATE_L0S_DW;
> +                       }
> +               }
> +
>                 /*
>                  * Check L1 latency.
>                  * Every switch on the path to root complex need 1
> @@ -469,11 +477,14 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>                  * L1 exit latencies advertised by a device include L1
>                  * substate latencies (and hence do not do any check).
>                  */
> -               latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> -               if ((link->aspm_capable & ASPM_STATE_L1) &&
> -                   (latency + l1_switch_latency > acceptable->l1))
> -                       link->aspm_capable &= ~ASPM_STATE_L1;
> -               l1_switch_latency += 1000;
> +               if (link->aspm_capable & ASPM_STATE_L1) {
> +                       latency = max_t(u32, link->latency_up.l1, link->latency_dw.l1);
> +                       l1_max_latency = max_t(u32, latency, l1_max_latency);
> +                       if (l1_max_latency + l1_switch_latency > acceptable->l1)
> +                               link->aspm_capable &= ~ASPM_STATE_L1;
> +
> +                       l1_switch_latency += 1000;
> +               }
>
>                 link = link->parent;
>         }
> --
> 2.28.0
>
