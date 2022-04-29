Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319A0514459
	for <lists+linux-pci@lfdr.de>; Fri, 29 Apr 2022 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355796AbiD2IkE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Apr 2022 04:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351551AbiD2IkD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Apr 2022 04:40:03 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24927C3EA1;
        Fri, 29 Apr 2022 01:36:46 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id t16so5210721qtr.9;
        Fri, 29 Apr 2022 01:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PfK8sXszOg36I/kRuBNRSs26zAwgaqxfbeahBslodhc=;
        b=EZ3z/C5AmVLr2OLe0NeIrmOUbpUldxpVTDOgjSfaWF/eMKJccvVTgECI4WO+yqRrVz
         HTmd0BikUhF4xMxjeCAY2cdb+F3MCjm/qgChpGYh+Iysva/D2DsUowoQtPCOT+6/s7d8
         IwyBhUNVnq0J1+o/0dE3oBqbznD7+qPcqaZqZaABfgkmvHcHi65+4QQzTUzL8okfnEEz
         LyR5fiuWpDniem9buYkO+7OmJ9rKg+5yDEWCVMu+Vcvzg1rZbMZjWG7eN8X8PXjq5aJl
         OdPgUIRr0mQfbO9kLhlYb/QUoEZsaH0bqEBU9Sn+0UkiXljIqQyDRO9VjRbNadEO5VY2
         zJqg==
X-Gm-Message-State: AOAM532EKIrtzdpgRv72bCOTz9XzbDPeoBVaKB0yTLpoIJma0eMbEUC/
        ilCnhpEKjYEhH2B9ZcH9s64EtF6gougD+BIL
X-Google-Smtp-Source: ABdhPJwjbAXui6VVA1k7m9j4P6AIGRB4OZRu84LhXVkvYpDc5nkmlRDY3Gez7YpW1R402qG22uydYQ==
X-Received: by 2002:ac8:5b03:0:b0:2f3:858a:dd07 with SMTP id m3-20020ac85b03000000b002f3858add07mr8341246qtw.245.1651221405010;
        Fri, 29 Apr 2022 01:36:45 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id y13-20020a05622a164d00b002f1ff52c518sm1433346qtj.28.2022.04.29.01.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 01:36:44 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id j2so13345903ybu.0;
        Fri, 29 Apr 2022 01:36:44 -0700 (PDT)
X-Received: by 2002:a25:d393:0:b0:648:4871:3b91 with SMTP id
 e141-20020a25d393000000b0064848713b91mr25549141ybf.506.1651221403999; Fri, 29
 Apr 2022 01:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220428151630.586009-1-herve.codina@bootlin.com> <20220428151630.586009-4-herve.codina@bootlin.com>
In-Reply-To: <20220428151630.586009-4-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Apr 2022 10:36:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXj_mQhkovm38ik_fKyWcrh3aSVNRVydqDuLYX_Nw2p=g@mail.gmail.com>
Message-ID: <CAMuHMdXj_mQhkovm38ik_fKyWcrh3aSVNRVydqDuLYX_Nw2p=g@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] PCI: rcar-gen2: Add RZ/N1 SOCs family compatible string
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 28, 2022 at 5:16 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Add the Renesas RZ/N1 SOCs family support to the Renesas R-Car Gen2
> PCI bridge driver.
>
> The Renesas RZ/N1 SOCs internal PCI bridge is compatible with the one
> available in the R-Car Gen2 family.
>
> Tested with the RZ/N1D (R9A06G032) SOC.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
