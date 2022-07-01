Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A0B563645
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 16:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiGAO6C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 10:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiGAO56 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 10:57:58 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D09D396BD;
        Fri,  1 Jul 2022 07:57:55 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id g1so1982205qkl.9;
        Fri, 01 Jul 2022 07:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjqE4fCphVWixLa+7/BY/DDrOMGgn93pjEIoCZKVrr0=;
        b=7uVyi2nt0GkTc3OVRGv56QH5j0EA7qM1IMII0oVUOplf0b0Olb3Eo+P4OgQkT4YYh0
         3oGRQR8DW8AnKpVdPfcGrXijyn0kSyT0KgvnXVVVVckJFmO+Z5aXdTjboHciHSl/UdRo
         M/0dV1fFiDmqRTp1SGLMR0rGoBf6+9X25qzCpmfbOcuJDxZW0xv/RiyJJnb4Fc4VHEQC
         RJRgfjamrfjydbu64ummpiw3HFzsMQAqZussWIQO4vCnhx07VCwpdzFRcrMVY+jKrhOn
         fxjSrMh21ZxT+xg1mhCxPgEd706gUTo3zHq78NFTyw1ac8Q4I32Fg7h8NM1BTuvVDXMO
         TbFQ==
X-Gm-Message-State: AJIora++rTNabBuN8K9PqZlofoHnmWzPUlpCQM+42Qq6oVm9txrzCp4+
        fTrT87kMP+SZQ//E8bcW3H2yaTbtCsEw+A==
X-Google-Smtp-Source: AGRyM1uH83+H90Q9lOfN6LI4o9tQpUKNLfFIlRMMSOVAWbooJoP1m2x39P+7YpW52W02YZWPFyXxHg==
X-Received: by 2002:a05:620a:2682:b0:67e:1a58:c947 with SMTP id c2-20020a05620a268200b0067e1a58c947mr11092226qkp.650.1656687474279;
        Fri, 01 Jul 2022 07:57:54 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 194-20020a370acb000000b006a8b6848556sm17601766qkk.7.2022.07.01.07.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 07:57:53 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id p136so4505926ybg.4;
        Fri, 01 Jul 2022 07:57:53 -0700 (PDT)
X-Received: by 2002:a25:be49:0:b0:64a:2089:f487 with SMTP id
 d9-20020a25be49000000b0064a2089f487mr1499864ybm.202.1656687473352; Fri, 01
 Jul 2022 07:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220701085420.870306-1-yoshihiro.shimoda.uh@renesas.com> <20220701085420.870306-10-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220701085420.870306-10-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Jul 2022 16:57:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVsOuLDbhBGrSO8r5i1WF+8scoLRNReyUW-tg4TQQL3gg@mail.gmail.com>
Message-ID: <CAMuHMdVsOuLDbhBGrSO8r5i1WF+8scoLRNReyUW-tg4TQQL3gg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4-host.c

> +static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> +       { .compatible = "renesas,rcar-gen4-pcie", },
> +       {},

Please drop the comma, as no new entries must be added after the
sentinel.

> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
