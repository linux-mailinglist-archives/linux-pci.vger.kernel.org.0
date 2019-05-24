Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D90C328F0C
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 04:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfEXCRk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 22:17:40 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40705 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfEXCRk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 22:17:40 -0400
Received: by mail-it1-f196.google.com with SMTP id h11so11546639itf.5;
        Thu, 23 May 2019 19:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/Nf4yTNtClg7IuCwo8+W36SPeNrRBjRlgvW/N6aAPAY=;
        b=YAOLjdkXSIuIN+QSa8TNR0FWvnGA8avygLx/ljmkYPAv07n05ARUdlPCrq0svX2173
         zz9+RqedoWUxbeLadf3yVHU1LubjRvO18lzRgUEsmOfRJKRSjYOqugtvije5s+rIBHIN
         oiQezkmeOVa3NwMu1LOaeGY987IWlw2FONeuwvnh9kwWOa0+2PieD0kADwkOQocTr8Qm
         2Angu20Ym389eMrMz3jQnXPbPKkXpogSJ06WlWrmh8yW0rebzheXuap3HG0RqVIfz2gY
         CQp8tB93JZWbXBLyadNJCVfS324Ou7OAk6OE2PIOm3eZOzoR80157S5GSk5cmuN7dCz4
         iLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/Nf4yTNtClg7IuCwo8+W36SPeNrRBjRlgvW/N6aAPAY=;
        b=p4XbhhQpWrW1GTBjggyCsrf9IKj+ci50G0cyxsyW9ryl38oi0KImglHYrT0qE3zPnC
         Rk0yBAp2jearr9ODb42NDlC9t49hugyVrcQdzkreGwio3jdWfnZtRlEC7EoRfPDI/04C
         LmvRSQR7m3SFzU+1Uu6nhc7IJgB7Nd50y3ibnI5Er4EP0D0W53u4cm+fA7fgCbMeKkGA
         BvOSxCAU8aEUP55lWzfW5PK4wsRq1PU7s7OEF0mCkzyI4uu/24H/kNJc6FyewaIrxAB6
         hfLYJSkeFljsaOxwHE7Ne0W5qYjMnQoR2iykmEMAzNM4Rk35wCJCW+pkYmqrTU7Uxkwg
         Ta+Q==
X-Gm-Message-State: APjAAAXV3PwGut9diD0A8mbhEJyJnSEhXRGmnJZH+uskcXAYUMDJZ+KP
        +3R30Q37faanHd+V756Z43paPRb2k5w+2CZaQMM=
X-Google-Smtp-Source: APXvYqxyJ/vE09fNDb6+pXXj2W2j7vphd32NuVeXdpRsVtHoZJjl6s5aQfjfhV0MhTCmXKapRN4V8fmn6AYa8b46v98=
X-Received: by 2002:a24:278c:: with SMTP id g134mr14184869ita.49.1558664259854;
 Thu, 23 May 2019 19:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <1558664151-2584-1-git-send-email-ley.foon.tan@intel.com>
In-Reply-To: <1558664151-2584-1-git-send-email-ley.foon.tan@intel.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Fri, 24 May 2019 10:17:28 +0800
Message-ID: <CAFiDJ5_HCeY0hf8W-HiEMLFWgjYNspXuH9dBV1kKY-YEvMLAeA@mail.gmail.com>
Subject: Re: [PATCH] PCI: altera: Fix no return warning for altera_pcie_irq_teardown()
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 24, 2019 at 10:15 AM Ley Foon Tan <ley.foon.tan@intel.com> wrot=
e:
>
> Fix compilation warning caused by patch "PCI: altera: Allow building as m=
odule".
>
> drivers/pci/controller/pcie-altera.c: In function =E2=80=98altera_pcie_ir=
q_teardown=E2=80=99:
> drivers/pci/controller/pcie-altera.c:723:1: warning: no return statement =
in function returning non-void [-Wreturn-type]
>  }
>
> Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> ---
>  drivers/pci/controller/pcie-altera.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controlle=
r/pcie-altera.c
> index 6c86bc69ace8..27222071ace7 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -706,7 +706,7 @@ static int altera_pcie_init_irq_domain(struct altera_=
pcie *pcie)
>         return 0;
>  }
>
> -static int altera_pcie_irq_teardown(struct altera_pcie *pcie)
> +static void altera_pcie_irq_teardown(struct altera_pcie *pcie)
>  {
>         irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
>         irq_domain_remove(pcie->irq_domain);
> --
> 2.19.0
>
Hi

You can squash this patch to this https://lkml.org/lkml/2019/4/24/18
"PCI: altera: Allow building as module" if want.

Thanks.

Regards
Ley Foon
