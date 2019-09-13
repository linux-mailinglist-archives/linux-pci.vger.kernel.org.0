Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABD3B2797
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 23:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfIMV5h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 17:57:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46633 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731186AbfIMV5h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Sep 2019 17:57:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id i8so28204017edn.13
        for <linux-pci@vger.kernel.org>; Fri, 13 Sep 2019 14:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lXBmtndFJEiSa/yuibypv1aaQRLxwTUng1HNafafXIY=;
        b=k6NvvxGL20jhmIbQNZHUehQSfjwxafrfGKMF+7Mszkt2KZeb4LPp0Qqy1S5zFk0q2g
         W6ia+WdiQXO0gCeeGWwHmfghLR7pCB7YngFyIumjsinbmjC4BXPxsslVr5ZiqPTNoBTs
         bgG+9M9HwwMQbSp38i5i1GVBel+ddoouQXqL2Y3Se+UftarnUzjcavmSfgACwzE3qvY1
         rc1p3phfC5r/lTr5tMmJjop4Dr8eq3CwItaBifLeW2tIkNr3J7ulrfUiEJ1dBY6aD/Qy
         kzLa1aIt4bO38Yj9rVet++7TvFTf55KnSeVY9lBRG67Vhc1UphXi+blm2RdyfoUXY81N
         pr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXBmtndFJEiSa/yuibypv1aaQRLxwTUng1HNafafXIY=;
        b=A2UVZ85x4F16+fx9PnJ+6PEQIvKIAFbK5+ohVNPUrT3z91uCNSDGiLr9kNxMIq5VUS
         VcFiiRHoOjt+qgLnpVB38xUql3MkG0yIKU5kYujwS47PlwTXV7haXKDkkqTwCzxhRIsv
         YnxxUqhb2miz6A1v6m1U3V7hkVPOKvJXQvk0HvMzTVcnG1TL8rvYAUbEIa6i0JOWW3+D
         fkhnvsWGoydRwqGyzgu7UeTJhTZbEvog2b7y2MHV4s/foLqqjXN+p63n9sGZKjuNhCbK
         5G7s6Rege3BbY0FgBIeD4Hje2rWxFGkifo3UUqA7KYppjfCq5k+/HXu5AGVts1cW2cCi
         OJmA==
X-Gm-Message-State: APjAAAVaAfaA8iWWBMeI16/nu+JIe5wHNvqXu3tFu1fpvDTIF/vsWYOM
        fOLAD8cnW2EkQxINwF21fhf9vRZ1YxM2kckjZ/wnHA==
X-Google-Smtp-Source: APXvYqyNOjOgrj3kaKKwB1QlWHXqQvBx4UDlJrb7HS+QDlZNVYw6g1q/V0tb1aYTJy5+4lGg4Xvm/wSth0HRmECmTt0=
X-Received: by 2002:a50:9512:: with SMTP id u18mr49332377eda.182.1568411853796;
 Fri, 13 Sep 2019 14:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190904160339.2800-1-niklas.cassel@linaro.org>
In-Reply-To: <20190904160339.2800-1-niklas.cassel@linaro.org>
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Fri, 13 Sep 2019 14:57:23 -0700
Message-ID: <CAOCOHw7+0t-HPY5t8EA+vZ_A-CTt1m8V1KNUvTS7zz_3wFwhNw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: fix find_next_bit() usage
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 4, 2019 at 9:03 AM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> find_next_bit() takes a parameter of size long, and performs arithmetic
> that assumes that the argument is of size long.
>
> Therefore we cannot pass a u32, since this will cause find_next_bit()
> to read outside the stack buffer and will produce the following print:
> BUG: KASAN: stack-out-of-bounds in find_next_bit+0x38/0xb0
>
> Fixes: 1b497e6493c4 ("PCI: dwc: Fix uninitialized variable in dw_handle_msi_irq()")
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d3156446ff27..45f21640c977 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -78,7 +78,8 @@ static struct msi_domain_info dw_pcie_msi_domain_info = {
>  irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>  {
>         int i, pos, irq;
> -       u32 val, num_ctrls;
> +       unsigned long val;
> +       u32 status, num_ctrls;
>         irqreturn_t ret = IRQ_NONE;
>
>         num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> @@ -86,14 +87,14 @@ irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
>         for (i = 0; i < num_ctrls; i++) {
>                 dw_pcie_rd_own_conf(pp, PCIE_MSI_INTR0_STATUS +
>                                         (i * MSI_REG_CTRL_BLOCK_SIZE),
> -                                   4, &val);
> -               if (!val)
> +                                   4, &status);
> +               if (!status)
>                         continue;
>
>                 ret = IRQ_HANDLED;
> +               val = status;
>                 pos = 0;
> -               while ((pos = find_next_bit((unsigned long *) &val,
> -                                           MAX_MSI_IRQS_PER_CTRL,
> +               while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
>                                             pos)) != MAX_MSI_IRQS_PER_CTRL) {
>                         irq = irq_find_mapping(pp->irq_domain,
>                                                (i * MAX_MSI_IRQS_PER_CTRL) +
> --
> 2.21.0
>
