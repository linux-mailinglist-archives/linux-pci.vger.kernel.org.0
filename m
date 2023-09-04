Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198957913B9
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 10:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346226AbjIDIoT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 4 Sep 2023 04:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjIDIoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 04:44:19 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98640126;
        Mon,  4 Sep 2023 01:44:16 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-58d40c2debeso12105677b3.2;
        Mon, 04 Sep 2023 01:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693817055; x=1694421855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g23xSOA/IQ6/Le8QmpjxoM1LPk8BokdgHM13XH+iaP0=;
        b=UxUFdZuNOywnvvzlRvXcDgOR6Jm9Is/13vHnyd1obiQpMEMsDUUBieJLiOMJmMGeFk
         tvuJsSnR8lthR9SIfM9elnOL8cgj3CVL3QSkNT0oxExeqA/L1pXf4X0kIk5kqogFWPWS
         KDK7bASqORP+QWLVlmx6WC9hIZ14WsLdtaFcBnB+bWsscIR1bIpZz5dUqgTie+7rulq0
         oUfPEIBz9E3evqzBjT3CuqrZSd8fptEiRrqo48/8h0kX3FZB+oOH5jO3LgytX9mGDW07
         8k/k04ulYb/4ZUTv2jveu+78IlqcINYZfj0dUn34SRJORmUvhX/V+Y4RPi5M152JesL4
         oO2g==
X-Gm-Message-State: AOJu0Yw2zJ2EpHj+z7qRvA60E28uJnmPK0g99oomcba25ofl3WPn9Lyd
        2cMwKxJvaPJwxrClSbPWUr+kxOeAWWGezA==
X-Google-Smtp-Source: AGHT+IGYwXUOJSO4m/crB//UUmbXphcSujoG7DvDVxLFBb75AnaXJ3hrAfspvo0VKkx7BMUn0VTmEQ==
X-Received: by 2002:a0d:e68d:0:b0:58d:5df8:f61e with SMTP id p135-20020a0de68d000000b0058d5df8f61emr10404625ywe.2.1693817055626;
        Mon, 04 Sep 2023 01:44:15 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id r7-20020a0dcf07000000b0058c4e33b2d6sm2562905ywd.90.2023.09.04.01.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 01:44:15 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-58fc4eaa04fso12161207b3.0;
        Mon, 04 Sep 2023 01:44:15 -0700 (PDT)
X-Received: by 2002:a25:2057:0:b0:d78:15ab:58d3 with SMTP id
 g84-20020a252057000000b00d7815ab58d3mr9483135ybg.0.1693817055032; Mon, 04 Sep
 2023 01:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230901131711.2861283-1-yoshihiro.shimoda.uh@renesas.com> <20230901131711.2861283-3-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20230901131711.2861283-3-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Sep 2023 10:44:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXhXhP8pgkEAmHFnxLxY6G7ib7fsz+5TTQ97gqg-aCK8Q@mail.gmail.com>
Message-ID: <CAMuHMdXhXhP8pgkEAmHFnxLxY6G7ib7fsz+5TTQ97gqg-aCK8Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: PCI: rcar-gen4-pcie: Fix minor issues
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 3, 2023 at 2:35 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Fix minor issues of rcar-gen4-pci-host.yaml.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>
> This patch will be squashed into the following commit on the pci.git /
> controller/rcar branch so that many fixes into a patch:
>
> dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/rcar&id=af285bc39885eaeed434c607a977d664916681a7

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
