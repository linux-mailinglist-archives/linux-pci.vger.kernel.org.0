Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7FB28E1A
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 01:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbfEWX4V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 19:56:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38951 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388635AbfEWX4T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 19:56:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id a10so7064243ljf.6
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 16:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Rwcv7ftRka+X8HiYdZS3z2oKZ4APHYrkaB4F2nbQq/A=;
        b=AnLJrehX/9SKzLuWRrRIqP+/yUIsQFZcIiCHKFCoKVjJLszzRW631gMNPPgRA8tOP1
         wrqfXWhHRRoqYvBwzWiiheJDTGkKdbcNN+ngCaynpJWye/aRivH1AzTDYkZsRNUu7XfN
         Hzogg9u4Z5W+AR7yKg7u5qHSEeRnmQkCh0b3VhGWXUmBZ+yBgXFGWM1CQrCPUYaKuyHT
         dGVRDU156ornBXx5rdkou5+WPU/hu7WGJdKQ1X81ezANzfm5ub1f9DQNvAR0T+WQUqB4
         8w9RzQRnOTfbvcIe+5gkLnKMB7IZcjZ1IAmhe3nznq8L+Sfaz0nuOiW1V0H+zHcEx/UE
         OWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Rwcv7ftRka+X8HiYdZS3z2oKZ4APHYrkaB4F2nbQq/A=;
        b=CkCTR9AvTyt6Kod2zoKaUSTyZcVdmksBexB0Lxv/9waZswFRdct9zr6CAPAHAM0+rJ
         +JLSccJyIdrDtXe2jtl3cQb4qyHs8R/Tx81NbtXAuDd4B4KeqPqT+MA+mMxQm9tSv7Nz
         bNyIgIub215iCjeAaG9kcTDO8JUBgpCWSZ//7mKKEK8jFpYUvTVWK+njV0e5wDbVUoX6
         p4W4ntQMehcNf0IsZuYYJBjgGq73pl3jDXiWuhsoETltJj8xKO1+2/cop5AbuqYH/kJP
         +wTxah75Azu1caGKNYKQBUMsGV1qt5rFMGAYJA9L+510YsyH7mrVMfhOZ4/E8SHICY83
         ESzQ==
X-Gm-Message-State: APjAAAXmnUZqpWkwVwBA5KyAMnQVmrobSqQ8B8B0CLST9G1NvaRdz2fz
        Aho88NVHqwrK8FWoiFclUwZQ0e+zdNJb33q30obhMJcAuXk=
X-Google-Smtp-Source: APXvYqzYv7m8kDn0KpeHZdh5ZzlR7YUak9Qm+XHYYicHUR74JCz6mwG62iVCuLEISNmZxFqT3y6cpf3pLq0Fp50gAM0=
X-Received: by 2002:a2e:655b:: with SMTP id z88mr46764454ljb.108.1558655777580;
 Thu, 23 May 2019 16:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <1558648079-13893-1-git-send-email-alan.mikhak@sifive.com>
In-Reply-To: <1558648079-13893-1-git-send-email-alan.mikhak@sifive.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Thu, 23 May 2019 16:56:06 -0700
Message-ID: <CABEDWGxMXg7RAgrUL-7W6vgC0BpCj9ys+i7myjxdBgn3vn_P6Q@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: endpoint: Allocate enough space for fixed size BAR
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

On Thu, May 23, 2019 at 2:48 PM Alan Mikhak <alan.mikhak@sifive.com> wrote:
>
> PCI endpoint test function code should honor the .bar_fixed_size parameter
> from underlying endpoint controller drivers or results may be unexpected.
>
> In pci_epf_test_alloc_space(), check if BAR being used for test register
> space is a fixed size BAR. If so, allocate the required fixed size.
>
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 27806987e93b..7d41e6684b87 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -434,10 +434,16 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>         int bar;
>         enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>         const struct pci_epc_features *epc_features;
> +       size_t test_reg_size;
>
>         epc_features = epf_test->epc_features;
>
> -       base = pci_epf_alloc_space(epf, sizeof(struct pci_epf_test_reg),
> +       if (epc_features->bar_fixed_size[test_reg_bar])
> +               test_reg_size = bar_size[test_reg_bar];
> +       else
> +               test_reg_size = sizeof(struct pci_epf_test_reg);
> +
> +       base = pci_epf_alloc_space(epf, test_reg_size,
>                                    test_reg_bar, epc_features->align);
>         if (!base) {
>                 dev_err(dev, "Failed to allocated register space\n");
> --
> 2.7.4
>
