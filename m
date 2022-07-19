Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99B057A0C3
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 16:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiGSOJs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 10:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbiGSOJJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 10:09:09 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723425E833;
        Tue, 19 Jul 2022 06:25:46 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id v28so9552671qkg.13;
        Tue, 19 Jul 2022 06:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/im0kzyVGziE3zKsgqLb+DjQl4kTj2uzoC+14ZuwX0=;
        b=U4NaTgzqxqvvc2I6QeUzD+mD9HmWGP/CSCueP50PtlCF5DSceh3DaoJG5CLrcugdQ/
         q+hBth61hL2FSCytU08g5Nw1xUZ3jZDy/5O6LVRB7MxAc0eng2Od4bd8brNj4tZR6DD6
         UnvcM3V5QCnBZY8E8s/e+6lRm5PgyRKAeA0JWzURma9ZrrQPb/uBXfkMipzQrGHOmJtV
         BcAf2Pkh4ydHpUBNqbds6OXsyjVOJIWuCdCzJS+AIz4zBgII9KjAzou9MLunskIPUtQt
         e1gOzn/qWJQ3rSVft55jfa9YVA1xZ9IiI1kFZyaNkqHAvDVOtxqVO2uir3F0R6/ZDhxa
         gaYw==
X-Gm-Message-State: AJIora80pfCmSSycObkqoJILWTWpagMvm68OiEMI8vd5P+kn4+QDgfUq
        gDsgxnQl3oKv/MsSa996IIV+fjDIVebGBg==
X-Google-Smtp-Source: AGRyM1vaUAOdgo2mIg4Rr0L0N22J6sB7B3pQqHw4uTEQ1nMPYyoCI05W7cN6K/gkdS6+xGyzgWeEWw==
X-Received: by 2002:a05:620a:4091:b0:6b5:f03f:dd9b with SMTP id f17-20020a05620a409100b006b5f03fdd9bmr5233061qko.357.1658237145079;
        Tue, 19 Jul 2022 06:25:45 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id v3-20020a05620a440300b006a6a4b43c01sm7942771qkp.38.2022.07.19.06.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 06:25:44 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 64so26391321ybt.12;
        Tue, 19 Jul 2022 06:25:44 -0700 (PDT)
X-Received: by 2002:a05:6902:154f:b0:66e:e2d3:ce1 with SMTP id
 r15-20020a056902154f00b0066ee2d30ce1mr29652418ybu.365.1658237144139; Tue, 19
 Jul 2022 06:25:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220701085420.870306-1-yoshihiro.shimoda.uh@renesas.com> <20220701085420.870306-10-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220701085420.870306-10-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Jul 2022 15:25:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWH1XL3PrPc8UujotDwCB+AabvUpS1-V-p7dLKF8N=+SA@mail.gmail.com>
Message-ID: <CAMuHMdWH1XL3PrPc8UujotDwCB+AabvUpS1-V-p7dLKF8N=+SA@mail.gmail.com>
Subject: Re: [PATCH v3 09/13] PCI: renesas: Add R-Car Gen4 PCIe Host support
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shimoda-san,

On Fri, Jul 1, 2022 at 10:55 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add R-Car Gen4 PCIe Host support. This controller is based on
> Synopsys DesignWare PCIe.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for Renesas R-Car Gen4 Series SoCs
> + * Copyright (C) 2022 Renesas Electronics Corporation
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +
> +#include "pcie-rcar-gen4.h"
> +#include "pcie-designware.h"
> +
> +static int rcar_gen4_pcie_host_init(struct pcie_port *pp)

FTR, s/pcie_port/dw_pcie_rp/g since commit 60b3c27fb9b92b8b ("PCI:
dwc: Rename struct pcie_port to dw_pcie_rp") in pci/next.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
