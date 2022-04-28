Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F55130A1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 12:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbiD1KG0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 06:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiD1KF6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 06:05:58 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667EB37BE8;
        Thu, 28 Apr 2022 02:52:26 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id fu47so3026649qtb.5;
        Thu, 28 Apr 2022 02:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ovyC5u95bHx0r6PJ7f5pXU0Bk1RoDto4j+E9S46SA34=;
        b=CWrfDjPjWgMaiRpepK9/7Rx0RLkFeNsBAdf01ocar3dOkZ+h6txl4HVYN0/Kkvug/H
         DrhhiO5ZqsKRx3i0kEKU/faB+Vn++CBZ4bdkVekIYQ6OJD4rTHBb723JqPj9cLg/qhnk
         SOO/2Vav9s1WryweqPKCTeYZDV/2mRAdfP010yAUUCBtx+8bQbQWifUAIBHxFcq7RqmE
         FaXd8gMtJf3U+I0T0jN5ukbNw+yDhhH9zQFk9W+DJLoLHKt8iDuhHkBDRXkDmusPy3Ei
         mCEdO1XII+W5dnNELenrdE3X1Bk3uzl4NNyv6ZfeWPWjOIkQG/ru5P6pf+LefEpJ6KFA
         KDxg==
X-Gm-Message-State: AOAM530vKHoYEulvOoDTdKq9eDxq95nD3ToYPAKGFSqMfyaHNN6GpSJj
        52VSJkeltROvA8cLkGNLQWBCsWvd/9N9mw==
X-Google-Smtp-Source: ABdhPJwXLoOVe81bLQNY6/MlRjxxV0Xk4RN2RWldQdZqwCuAL3Pl46w+XrxBplVM6RocYexn93YVrQ==
X-Received: by 2002:a05:622a:510:b0:2f3:81aa:cac2 with SMTP id l16-20020a05622a051000b002f381aacac2mr7033369qtx.679.1651139545346;
        Thu, 28 Apr 2022 02:52:25 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id cr24-20020a05622a429800b002ed12cea2cdsm10387353qtb.96.2022.04.28.02.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:52:24 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id m128so8050863ybm.5;
        Thu, 28 Apr 2022 02:52:24 -0700 (PDT)
X-Received: by 2002:a25:d393:0:b0:648:4871:3b91 with SMTP id
 e141-20020a25d393000000b0064848713b91mr20928967ybf.506.1651139543993; Thu, 28
 Apr 2022 02:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120850.769480-1-herve.codina@bootlin.com> <20220422120850.769480-9-herve.codina@bootlin.com>
In-Reply-To: <20220422120850.769480-9-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Apr 2022 11:52:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJBG9kv7rYNy+Ej5jrLcGckZHfydgmxmtHa1U9uy_bwg@mail.gmail.com>
Message-ID: <CAMuHMdXJBG9kv7rYNy+Ej5jrLcGckZHfydgmxmtHa1U9uy_bwg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] ARM: dts: r9a06g032: Link the PCI USB devices to
 the USB PHY
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

On Fri, Apr 22, 2022 at 2:09 PM Herve Codina <herve.codina@bootlin.com> wrote:
> Describe the PCI USB devices that are behind the PCI bridge, adding
> necessary links to the USB PHY device.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
