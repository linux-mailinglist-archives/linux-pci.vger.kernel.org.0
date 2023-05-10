Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E486FD814
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 09:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjEJHW3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 10 May 2023 03:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbjEJHW2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 03:22:28 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512411FFE;
        Wed, 10 May 2023 00:22:27 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-559e2051d05so99580817b3.3;
        Wed, 10 May 2023 00:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683703346; x=1686295346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmWJGjObZlpSH7bj175xkXQpLYD079UT8mAA0+fHxwg=;
        b=ARLE56yNrUrqkKZtHeQowvjdwTW1JpAjGEhrAP6UvqQfAwmM2j8HX9rnq6IwmG1Qez
         gnP5gCjWtGXiWzT9GuWEFWblX8nFSblRDspgBaAs5KWQMeNQUrElN211Ul2cZEbwO4Vc
         eR9pLc1xErLJe/yTstLJJzOITqk2vYIc1Z4pS23YuEDR12nhkyO8F/nmvw0xyrW3ZlTT
         7qswi81/v5D+ClLVD+4d2SrH8os28tNK3wHH8sF3PpTRih1g3ALupGELQl5Gb8ElPw6y
         oAzSwElArWfk3m4cbUwoL1i0s3DJj3Sneo86JOlYKRMcGJh6nRM+89vgFwN7xo3+KRYp
         cUsQ==
X-Gm-Message-State: AC+VfDzAbXQROVLZLP9FK0hWoaaJZxuvN5sNAwN2uZRp6/sg5db5R8C9
        b2uO8fNPOyBgboiUkTxetNhXVi5+Nj6V7g==
X-Google-Smtp-Source: ACHHUZ47gAO+JBNowDSgjhLfKoTgickdfiVQRH3uAUaWAIZrrTUpqLjnJmRLRszooJOPB0wCGkAVDQ==
X-Received: by 2002:a0d:df56:0:b0:546:cbe:df90 with SMTP id i83-20020a0ddf56000000b005460cbedf90mr20400617ywe.30.1683703346240;
        Wed, 10 May 2023 00:22:26 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id q66-20020a0dce45000000b0054f03d75882sm3919603ywd.71.2023.05.10.00.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:22:25 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-55a10577911so99710367b3.0;
        Wed, 10 May 2023 00:22:25 -0700 (PDT)
X-Received: by 2002:a81:9e4f:0:b0:54f:b6af:ac15 with SMTP id
 n15-20020a819e4f000000b0054fb6afac15mr19714426ywj.51.1683703345052; Wed, 10
 May 2023 00:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230510065819.3987-1-wsa+renesas@sang-engineering.com> <20230510065819.3987-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230510065819.3987-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 May 2023 09:22:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVvKcRhNsSNP_Y=b3L_y7jyXaOErKmqXgr-r_2TTMn6aA@mail.gmail.com>
Message-ID: <CAMuHMdVvKcRhNsSNP_Y=b3L_y7jyXaOErKmqXgr-r_2TTMn6aA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: rcar-pci-host: add optional regulators
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, May 10, 2023 at 8:59 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Support regulators found on the e.g. KingFisher board for miniPCIe and
> add a 12v regulator while we are here.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Changes since RFC:
> * added 12V supply for completeness
> * use PCIe slot in the example instead of miniPCIe because that is what
>   the Koelsch board offers (just without the regulators ;))

Same for e.g. Salvator-XS.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
