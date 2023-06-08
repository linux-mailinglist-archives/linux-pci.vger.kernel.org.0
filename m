Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6397277F3
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 08:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjFHG7U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 8 Jun 2023 02:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjFHG7S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 02:59:18 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01535269F;
        Wed,  7 Jun 2023 23:59:16 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-bb131cd7c4aso336982276.1;
        Wed, 07 Jun 2023 23:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686207556; x=1688799556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hh8HdpbBUzG5V5+7NZJSYisVZ+jTb47wumgElDr3BM=;
        b=d46ncHxbdZlxc5BHnO9wiUxVOwML9IBKOWWBxOuUQtD1gQPTRKXGtjZou1kU8wBe4b
         Jtaz8tiLM79C31sfltlV8y687X/GkjrlLf9khSnEoItBVAAEpq83vqdS7UhRwS/fsWjW
         WBOzxr2xZ63g5ZrOQ5XK+WamY+RjbZgrC5G7s+AuuX+IQV/UHcfcgTTeUTFjQSyyY/Qv
         b4GJzW2k5Kfhj90DGg6SejAeWVJsGdx1/Pdxf6zroMDDaOnz/+Y6+UMBHIGfbGzqOW72
         RlDAOhG/1GB4k0QvaWWia2GheATnFY9K5a4pl+4bHtI4fTAKst0eF04YCH3pUIdoPo2C
         d0gg==
X-Gm-Message-State: AC+VfDxyD8tQtwNy2+l0n5dZgcUtvNB/0TFB3objBygFdnGxzRfvuzQW
        okgXfxxXxgsyadj7xDj8hTL4HFek+pgfCA==
X-Google-Smtp-Source: ACHHUZ7yUw9Henlrz8C+FLRaDYLB6RKtTvoNd2pMMVVGSIQe7CZs754ud0IcF4iDCX5//jHCNn0Skw==
X-Received: by 2002:a81:92d2:0:b0:55a:52e3:da37 with SMTP id j201-20020a8192d2000000b0055a52e3da37mr8031264ywg.10.1686207556074;
        Wed, 07 Jun 2023 23:59:16 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id d3-20020a816803000000b0054f6ca85641sm206917ywc.99.2023.06.07.23.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 23:59:15 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-bb131cd7c4aso336946276.1;
        Wed, 07 Jun 2023 23:59:14 -0700 (PDT)
X-Received: by 2002:a81:7744:0:b0:55d:820f:11b7 with SMTP id
 s65-20020a817744000000b0055d820f11b7mr7456804ywc.32.1686207553995; Wed, 07
 Jun 2023 23:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230607204750.27837-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230607204750.27837-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Jun 2023 08:59:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUg-vY0uv+U0vEsveF0R90eqCO1=-YNodPTakHNsRZNPg@mail.gmail.com>
Message-ID: <CAMuHMdUg-vY0uv+U0vEsveF0R90eqCO1=-YNodPTakHNsRZNPg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: rcar: use proper naming for R-Car
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 7, 2023 at 10:49 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Neither RCar, nor Rcar, but R-Car.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Change since V1:
> * fix typo in $subject (Thanks, Biju!)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
