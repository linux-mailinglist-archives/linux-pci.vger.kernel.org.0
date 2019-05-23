Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C46F228E16
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 01:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388450AbfEWXzQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 19:55:16 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41930 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388447AbfEWXzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 19:55:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id d8so5668057lfb.8
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 16:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xQh5W0I98+c3oB3ta6aEBLw922/4T4zsrZf/bWTXTzU=;
        b=En6Q2o1SlX3M7Df2OjIoSIT3soWjKBCQy6sPnuSQE+O3wgvYsqwB4X8Q+dyzV1c1Os
         hQ3hDMwcJ11Nxgi1u46gRXLS3CNrO57rKnfi6fe26xHKpb+46ZFXQGl1vnRKpJhcV4RM
         Yq1GO/x+1erGD7xCvZgu/Sw09bbOPn3LrB/2IUDKO3wOv3PvXJUreex0VqicRBjnQHJq
         cP6XZLiRepHxaS9vTHiQaj6NLxsMjmJvPSxihldmZqwb6S5mexNt34YJMhAyRz5leFqY
         QVH76r4prK2EyCQJMHK0ttiGuZC9+vvpOar4qHvWhLyro1jBNnsExMQVV3V+bjOrU7tA
         wBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xQh5W0I98+c3oB3ta6aEBLw922/4T4zsrZf/bWTXTzU=;
        b=lbQOgaebXPp4P4VpEE2QbRpJQXXMTKgr0zOyyGA82bkBIUBOO6Hk0XPvg+nNNqnfLc
         9YzCjuEsLm6jeQSJRvzEUiDdCSCzvfDwobhcHj68mmkgq3AvI6ShlJR8/0jVBa0L/0LT
         vZAHXdAAWWPsbop9HRjHJU3udMKOq0V+YdDdXHhrjJxFYIoXe23YJjzQA7JdD8BCvwft
         WboRwBB1OM3ZnA14BRHQrpgZk+xXEyd7Gu0+jx8DqeXtqKUC/SRWdLXAviqrKFMLWa6r
         TBEzn8Viw8C2o71T5qJUto3mj2HPJ2QGamvxyxQ8cXMOqYPIgNrLtsxlBXNQkTAeB9El
         onrw==
X-Gm-Message-State: APjAAAVp4NTADSlwIgfDAxjxfniLW17JioDJEIwEicD4FmvcwgR39Q6u
        6kumryGDoN5/8ufh5MrEw5MXUn9Y9stH/gFo09oLww6NgfM=
X-Google-Smtp-Source: APXvYqzyqqCKcK5t7puDNsK1zCocIX9J4p9I6yTdwocBXY4iGgsf4JaFzrnH5xYTIkXSMvFPo2rTIdBt4XKx+RgDGJU=
X-Received: by 2002:ac2:4286:: with SMTP id m6mr7504444lfh.150.1558655714383;
 Thu, 23 May 2019 16:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <1558648540-14239-1-git-send-email-alan.mikhak@sifive.com>
In-Reply-To: <1558648540-14239-1-git-send-email-alan.mikhak@sifive.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Thu, 23 May 2019 16:55:03 -0700
Message-ID: <CABEDWGzHkt4p_byEihOAs9g97t450h9-Z0Qu2b2-O1pxCNPX+A@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: endpoint: Skip odd BAR when skipping 64bit BAR
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        gustavo.pimentel@synopsys.com, wen.yang99@zte.com.cn, kjlu@umn.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Bjorn Helgaas, +Gustavo Pimentel, +Wen Yang, +Kangjie Lu

On Thu, May 23, 2019 at 2:55 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>
> Always skip odd bar when skipping 64bit BARs in pci_epf_test_set_bar()
> and pci_epf_test_alloc_space().
>
> Otherwise, pci_epf_test_set_bar() will call pci_epc_set_bar() on odd loop
> index when skipping reserved 64bit BAR. Moreover, pci_epf_test_alloc_space()
> will call pci_epf_alloc_space() on bind for odd loop index when BAR is 64bit
> but leaks on subsequent unbind by not calling pci_epf_free_space().
>
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> Reviewed-by: Paul Walmsley <paul.walmsley@sifive.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 27806987e93b..96156a537922 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -389,7 +389,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
>
>  static int pci_epf_test_set_bar(struct pci_epf *epf)
>  {
> -       int bar;
> +       int bar, add;
>         int ret;
>         struct pci_epf_bar *epf_bar;
>         struct pci_epc *epc = epf->epc;
> @@ -400,8 +400,14 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>
>         epc_features = epf_test->epc_features;
>
> -       for (bar = BAR_0; bar <= BAR_5; bar++) {
> +       for (bar = BAR_0; bar <= BAR_5; bar += add) {
>                 epf_bar = &epf->bar[bar];
> +               /*
> +                * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
> +                * if the specific implementation required a 64-bit BAR,
> +                * even if we only requested a 32-bit BAR.
> +                */
> +               add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
>
>                 if (!!(epc_features->reserved_bar & (1 << bar)))
>                         continue;
> @@ -413,13 +419,6 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>                         if (bar == test_reg_bar)
>                                 return ret;
>                 }
> -               /*
> -                * pci_epc_set_bar() sets PCI_BASE_ADDRESS_MEM_TYPE_64
> -                * if the specific implementation required a 64-bit BAR,
> -                * even if we only requested a 32-bit BAR.
> -                */
> -               if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
> -                       bar++;
>         }
>
>         return 0;
> @@ -431,7 +430,7 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>         struct device *dev = &epf->dev;
>         struct pci_epf_bar *epf_bar;
>         void *base;
> -       int bar;
> +       int bar, add;
>         enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>         const struct pci_epc_features *epc_features;
>
> @@ -445,8 +444,10 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>         }
>         epf_test->reg[test_reg_bar] = base;
>
> -       for (bar = BAR_0; bar <= BAR_5; bar++) {
> +       for (bar = BAR_0; bar <= BAR_5; bar += add) {
>                 epf_bar = &epf->bar[bar];
> +               add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ? 2 : 1;
> +
>                 if (bar == test_reg_bar)
>                         continue;
>
> @@ -459,8 +460,6 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>                         dev_err(dev, "Failed to allocate space for BAR%d\n",
>                                 bar);
>                 epf_test->reg[bar] = base;
> -               if (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
> -                       bar++;
>         }
>
>         return 0;
> --
> 2.7.4
>
