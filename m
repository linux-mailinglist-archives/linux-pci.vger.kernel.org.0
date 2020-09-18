Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A15270902
	for <lists+linux-pci@lfdr.de>; Sat, 19 Sep 2020 00:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgIRWrN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 18:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgIRWrN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 18:47:13 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A6C0613CE
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 15:47:13 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id db4so3826727qvb.4
        for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2020 15:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=XuZMGRcF3uXKcqay96ckMECDT+LBEbq1d4YT/NkGsJg=;
        b=F5VwfY9uwDpMJ0BW9HLoB+IN/B3o4HUhfpCJP/YGsOIQQo7Vwu6NOcdV0RnRuU6xBR
         nwXKRvlYglXm3G4SuBerAIAkx2lySv7J0FaeiSlS+OUIAaWMsIGBkV3NhmyfY6XTf8JX
         1u07qRw4yY+MSy4Oa7dcac9liasKnyS1b6RCT8BG5p51DOMBDkiLw7tDgr2UQhshNZuy
         cltydHEHZLo2MzpR2Q1T27u2iAEK7PiUzs+k9MkpkwkVC6BT5E8PCPQn5h5gDLjLXdEZ
         gNNtNK1+k/mbUDxwI9EFiy6zC7tf7GImGxfFb04jCtoqKfcIYDAcvCMmAKAWUpZ3K6Z5
         bZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=XuZMGRcF3uXKcqay96ckMECDT+LBEbq1d4YT/NkGsJg=;
        b=UYfO35sujeHg1GqwS4l1iZ7DMDCQlunVq7RKL0ZFIkmoIViSWk0wkBxD9ilWnTAlgg
         rjtpdxG5SRECI6KkrEAwToR9jHQBVtFdm03hNh33Demwy/I9X+jvaJNd2tprpHmotqpX
         ARkYoHyuJ2K6ql9k7xD7kHMc0Eqm7WKQwbKzTjuEpQJs3MgljfO36U32gfnBUBavKDt8
         aQLLH7TFNcTXxPrxwVY1gkakB4/BUpm5kKDcbupqXHaFflRERLwsI0At+FmeSgb4TV7P
         MOT21pQMdEKwQ1maMVTJhUzlfFm+fIKJ6PkiPuiWxFJb+aVY+f9CwlBu28BYo39yeLZl
         An/A==
X-Gm-Message-State: AOAM533qWVKzPQTAHZ1Eg+64/0vrkOsPaBC22pTIrRBM/aBX1/upW66K
        IYnOhx+cF42uAl9D87EYCAiMD2VhnUsmzo1OFFV1ShaaiLg=
X-Google-Smtp-Source: ABdhPJyxwubYqUxW6/mosOKJdjc+4AggHco8RyUC8B5RdO9nX5+JCJ7YqLpHcG1ohruKLLE0LLHeyHpC0y72dsWKS8o=
X-Received: by 2002:a0c:9e0e:: with SMTP id p14mr18649712qve.25.1600469232143;
 Fri, 18 Sep 2020 15:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200729222758.GA1963264@bjorn-Precision-5520> <20200803145832.11234-1-ian.kumlien@gmail.com>
In-Reply-To: <20200803145832.11234-1-ian.kumlien@gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sat, 19 Sep 2020 00:47:01 +0200
Message-ID: <CAA85sZttK8WUvOEmaGCegd77YEjji_QjTDwAucZstunKegqWGQ@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1/L0s ASPM v2
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Any comments on this? I'm still patching my kernels...

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
