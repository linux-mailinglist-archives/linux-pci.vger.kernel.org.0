Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E96700275
	for <lists+linux-pci@lfdr.de>; Fri, 12 May 2023 10:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbjELI1z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 12 May 2023 04:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjELI1y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 May 2023 04:27:54 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FEA9013;
        Fri, 12 May 2023 01:27:52 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-55a76ed088aso143439997b3.2;
        Fri, 12 May 2023 01:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683880071; x=1686472071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsh0CzIrWqCG186SiBPK7PDZFJUtrBsuQOICQ+f77wQ=;
        b=cwjLKTrepLU0mCe6XHC0u9tr9xVwW3sMpUFDqvuD4/DW3sNWm914eQ+Bb3ERugk/qF
         pN/W9agCEDq9hD4CIMM3ceXAHymSDbxQXo66ohsVKVzpPMgExyhMVfiufrn4Pb+mM8or
         dKFUVlNodvUVkZehm9aaMYtHBeQXD9HjFoWrLvvoLEoay2ebba87Dz6jy13ah4n6V9du
         pdTDeNC5tWpU7wMXtPS/wsy/l/yShlCSV5hOQ2cGQvEaNirKd0oBLOFpOxj8m1tmR2H1
         HMXvtKkOBjZAuxOeYLPkK/Ge9L52nggob8yzPtMPF4d1Qsp1m3qa4kReeUiViInjM9xD
         T4eg==
X-Gm-Message-State: AC+VfDxvnarVaOEVMR1YqarU9va95BfV2yiPr9oO5xdcGZ8FLCQem4Kg
        HrFgIU/7Vk47E/8p/Hpge2STXGoNMreR5g==
X-Google-Smtp-Source: ACHHUZ5qWnrpBr5JbBlZKBQdoOD3rNfWqGWVLROapUYTwzpN1eQ6Kd2OdQFEAbK3a8bWH4yUgdbc2A==
X-Received: by 2002:a81:a1c9:0:b0:559:f85e:44e8 with SMTP id y192-20020a81a1c9000000b00559f85e44e8mr25289546ywg.29.1683880070837;
        Fri, 12 May 2023 01:27:50 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id w9-20020a0dd409000000b0054f50f71834sm5506505ywd.124.2023.05.12.01.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 01:27:50 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ba71cd7ce7fso422799276.1;
        Fri, 12 May 2023 01:27:50 -0700 (PDT)
X-Received: by 2002:a0d:ccd8:0:b0:55a:9b5a:1d9f with SMTP id
 o207-20020a0dccd8000000b0055a9b5a1d9fmr25268012ywd.11.1683880070312; Fri, 12
 May 2023 01:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230512075241.2770-1-wsa+renesas@sang-engineering.com> <20230512075241.2770-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230512075241.2770-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 May 2023 10:27:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWfUVus7LOfEZCV8=pqFQTC6308eLAsGCvZoJYM3++XSg@mail.gmail.com>
Message-ID: <CAMuHMdWfUVus7LOfEZCV8=pqFQTC6308eLAsGCvZoJYM3++XSg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: rcar-host: add support for optional regulators
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

On Fri, May 12, 2023 at 9:55 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> The KingFisher board has regulators. They just need to be en-/disabled,
> so we can leave the handling to devm. Order variables in reverse-xmas
> while we are here.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Changes since v2:
>
> * return directly with dev_err_probe
> * reworded the error message to avoid repeating 'error'

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
