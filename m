Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE196EA6A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2019 19:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfGSR4W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Jul 2019 13:56:22 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46309 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbfGSR4W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Jul 2019 13:56:22 -0400
Received: by mail-vs1-f65.google.com with SMTP id r3so22035685vsr.13
        for <linux-pci@vger.kernel.org>; Fri, 19 Jul 2019 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0XPP+ai2iJ6w5lFmfhgadkVcA0taBAeZKoBO5PwmAU=;
        b=IQjmomt1+qrPxaF9sSiAaTrB5ywEVq5W5SJJk+d1I8cJPTuA1ewqh9KvIJnHG3ZTAK
         yYJb/snRY/hyCX2+5eSkXnx+Naw1eTOS5RDG76y5de+Hj6LONcQoXvrVhmQ+lfGbaHo7
         QLxWb52bU40Tw1lt140YjcYrdWpi5Cr/uXfTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0XPP+ai2iJ6w5lFmfhgadkVcA0taBAeZKoBO5PwmAU=;
        b=JqcBythXC8S05HJfKwgPzb0/Ww60kx+bv4B7Zj2AdXlEAqWaSlxTtBRPg/0wxQicpu
         Y1IH4cPr1IiealAL2PDm4t4gBiEjWbG5I8j3w9sZH2jguGelijx7lk7IAayG7moeDyrT
         P0qGRB0w6J+YCATnn3X7n5iBhmE7fH28BnMRXnE1OojCcnVaFwZkQxKNeIb/sLUZc4+T
         As0bIjdbFkeoNohQ1Qd+lqqWd0NTThIGHJQl5UBjSF8sWlwZgxBA5V5/CYW9tWqJOnRX
         GjvdIhJIISiDzd/F1sjGzSekS+6EYUfsv9HuO51XPlwNObjtlw1JQMLekBUVZbNuSmPV
         dRZQ==
X-Gm-Message-State: APjAAAWYegTz+44PSfTWv1mY8jFj4oJYIpZe20D3FluKCw6X/uVDI5oQ
        a2a1jXlzBF6Nz+XjX+1xAQxVsy75+kjGmLNV/FGh9w==
X-Google-Smtp-Source: APXvYqw63JBpxTfnek6H+7ObIA4NaqC2RA0zOkBKzQkVV+LSqUjIp7hFshxa3zIJkZ7izAtxSW53B//RK8l3RUI+J0U=
X-Received: by 2002:a67:c496:: with SMTP id d22mr34173909vsk.205.1563558981146;
 Fri, 19 Jul 2019 10:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190716180940.17828-1-sumit.saxena@broadcom.com>
In-Reply-To: <20190716180940.17828-1-sumit.saxena@broadcom.com>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Fri, 19 Jul 2019 23:26:09 +0530
Message-ID: <CAL2rwxpc-Ub7ufs1SEEmnNaxtZg2KtY-QAuQnu95kXVPN8Z02Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: set BAR size bits correctly in Resize BAR control register
To:     helgaas@kernel.org, christian.koenig@amd.com
Cc:     linux-pci@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Christian Koenig

On Tue, Jul 16, 2019 at 3:41 PM Sumit Saxena <sumit.saxena@broadcom.com> wrote:
>
> In Resize BAR control register, bits[8:12] represents size of BAR.
> As per PCIe specification, below is encoded values in register bits
> to actual BAR size table:
>
> Bits  BAR size
> 0     1 MB
> 1     2 MB
> 2     4 MB
> 3     8 MB
> --
>
> For 1 MB BAR size, BAR size bits should be set to 0 but incorrectly
> these bits are set to "1f".
> Latest megaraid_sas and mpt3sas adapters which support Resizable BAR
> with 1 MB BAR size fails to initialize during system resume from S3 sleep.
>
> Fix: Correctly set BAR size bits to "0" for 1MB BAR size.
>
> CC: stable@vger.kernel.org # v4.16+
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203939
> Fixes: d3252ace0bc652a1a244455556b6a549f969bf99 ("PCI: Restore resized BAR state on resume")
> Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
> ---
>  drivers/pci/pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8abc843..b651f32 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1417,12 +1417,13 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
>
>         for (i = 0; i < nbars; i++, pos += 8) {
>                 struct resource *res;
> -               int bar_idx, size;
> +               int bar_idx, size, order;
>
>                 pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>                 bar_idx = ctrl & PCI_REBAR_CTRL_BAR_IDX;
>                 res = pdev->resource + bar_idx;
> -               size = order_base_2((resource_size(res) >> 20) | 1) - 1;
> +               order = order_base_2((resource_size(res) >> 20) | 1);
> +               size = order ? order - 1 : 0;
>                 ctrl &= ~PCI_REBAR_CTRL_BAR_SIZE;
>                 ctrl |= size << PCI_REBAR_CTRL_BAR_SHIFT;
>                 pci_write_config_dword(pdev, pos + PCI_REBAR_CTRL, ctrl);
> --
> 1.8.3.1
>
