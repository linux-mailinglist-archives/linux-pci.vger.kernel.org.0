Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CA8513020
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 11:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiD1Jtt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 28 Apr 2022 05:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346585AbiD1J0D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 05:26:03 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB87B55A;
        Thu, 28 Apr 2022 02:22:49 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id a5so2816005qvx.1;
        Thu, 28 Apr 2022 02:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XqlNbfP07/JFH01D+0otUBRM7EY77qBFCn/ld2fGXUk=;
        b=oEZ+F4UIOxbggPbpUd+38Q5RcsS64KEBKvmzSIUP01hIQdxh4ftDWoIUbC7eYTPeDk
         aMuMQy02J6QAJbFDC0BC8xeEfOJC4JRomGUKnYgx/jyAcv6jeNuEMGGMMsXRZFFmUl0s
         ZA67KSd3Or34vRmR7dJvt8OP0Fb0SKHyLXLFQcHE23FEOkybjmueeuf0+eKGvzH5GBQo
         XDBVl6glmg6YsMdwWxyejRC8yp/a4ccln6Z9dhT/ik8Q7K505wywuQ88vBvDIUBDXlCZ
         N5N7rVE+JzIAuKPBm29EpHiM+7wZmYe0zXipPcl+DZ4x7GN/6WOQEoEcPQ25EsHDwMQk
         IGaA==
X-Gm-Message-State: AOAM532YwHdDSVzECnrVS+odxRarZpir6BtB3buK30VX0A4soO6Z7LCr
        Ij4l0zWAo6reu2LQuvlgPXAOjkpqmv++LQ==
X-Google-Smtp-Source: ABdhPJyZVJVTfXghprm+uK544vIooJPyHd/NqYJy555ifKHxac+s/bMU6ua9HBq+/o2o7618xwjcww==
X-Received: by 2002:a05:6214:d86:b0:456:4ae4:d993 with SMTP id e6-20020a0562140d8600b004564ae4d993mr7911694qve.38.1651137768464;
        Thu, 28 Apr 2022 02:22:48 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id n186-20020a37bdc3000000b0069c218173e8sm9372017qkf.112.2022.04.28.02.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:22:48 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id m128so7933688ybm.5;
        Thu, 28 Apr 2022 02:22:47 -0700 (PDT)
X-Received: by 2002:a5b:984:0:b0:63f:8c38:676c with SMTP id
 c4-20020a5b0984000000b0063f8c38676cmr30668590ybq.393.1651137767425; Thu, 28
 Apr 2022 02:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120850.769480-1-herve.codina@bootlin.com>
 <20220422120850.769480-5-herve.codina@bootlin.com> <CAMuHMdWmcBXRxZ_SDLCnimh7GqzkR0_qz178s51EtXsMm39ddg@mail.gmail.com>
 <20220428111535.51833857@bootlin.com>
In-Reply-To: <20220428111535.51833857@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Apr 2022 11:22:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUf6M=ESvSnRoqYkBfvizW-tBzTwUX2Uka-FOGvLFzL=w@mail.gmail.com>
Message-ID: <CAMuHMdUf6M=ESvSnRoqYkBfvizW-tBzTwUX2Uka-FOGvLFzL=w@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] soc: renesas: rzn1: Select PM and
 PM_GENERIC_DOMAINS configs
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hervé,

On Thu, Apr 28, 2022 at 11:15 AM Herve Codina <herve.codina@bootlin.com> wrote:
> On Wed, 27 Apr 2022 16:58:07 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Apr 22, 2022 at 2:09 PM Herve Codina <herve.codina@bootlin.com> wrote:
> > > PM and PM_GENERIC_DOMAINS configs are required for RZ/N1 SOCs.
> > > Without these configs, the clocks used by the PCI bridge are not
> > > enabled and so accessing the devices leads to a kernel crash:
> > >   [    0.832958] Unhandled fault: external abort on non-linefetch (0x1008) at 0x90b5f848
> > >
> > > Select PM and PM_GENERIC_DOMAINS for ARCH_RZN1
> > >
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > i.e. will queue in renesas-devel for v5.19.
>
> I plan to send a v4 of this series.
>
> As this patch (4/8) and the following one (5/8) will be
> queued for v5.19, I plan to remove them from the v4 version
> of the series.
>
> Is that ok for you or do you prefer to still have them
> in v4 ?

As these two patches are not strictly related to adding PCI support,
but they are dependencies, I will queue them separately. Hence you
do not need to include them in v5.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
