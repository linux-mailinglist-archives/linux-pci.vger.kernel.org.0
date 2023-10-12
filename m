Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F7B7C6645
	for <lists+linux-pci@lfdr.de>; Thu, 12 Oct 2023 09:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbjJLHQf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 12 Oct 2023 03:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343577AbjJLHQd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 03:16:33 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402F5B8;
        Thu, 12 Oct 2023 00:16:32 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5a7dafb659cso8461097b3.0;
        Thu, 12 Oct 2023 00:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697094991; x=1697699791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMV76IitUmOC19135uZclOhMsXziuDJX/9btFPg+Ek4=;
        b=fGpn9WOAv3MGZGRyBnTL8WqPxJQ5GwB+AdJ+5kd//KWZiFQsQWsX6V60h2sxKntui7
         NBTQthm4xL42jLDYgktuf4SS72BNNz+RckNlJevxMPbFyl3m0i39S4GhLkXBUi4zFWkf
         L3uOprJ4zfSROc9AgCWh0QvmVB1/qcMLyBBdBykxXPzrNOW3PrrcCp8rcc5PjqFS49UX
         l9fXL5N8cbUbw9nfYgUcbsYigmHPehru/I0B9pkq7LILLY7hNUCLmeEpYBVFscy+NO/c
         VXDYunggjOET8oNvQe7bl9Ifpyjb8PDWYOYlbUMGU+4yLS+ONk0oa/zcQ5u+8+uKBGMb
         OzDA==
X-Gm-Message-State: AOJu0Yyc1Aa2JtHd/1KKM54T7N6Qc82jhk6ZBRXFy63NWvZsuFxyKGK9
        Zdq5ebegrslShIz+JHfpYnPQf2V7o+vYsA==
X-Google-Smtp-Source: AGHT+IFLo3fy05vffmN5a7MmDTEe9VUhoAy3CG71VV7D0PA0B+HXOWvycC7OiWUmKjueWamzoC4Aag==
X-Received: by 2002:a0d:ea90:0:b0:5a1:db12:d782 with SMTP id t138-20020a0dea90000000b005a1db12d782mr24099684ywe.44.1697094991241;
        Thu, 12 Oct 2023 00:16:31 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id n193-20020a0dcbca000000b005a7c969137csm1511602ywd.19.2023.10.12.00.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 00:16:31 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a7dafb659cso8461047b3.0;
        Thu, 12 Oct 2023 00:16:31 -0700 (PDT)
X-Received: by 2002:a0d:e943:0:b0:599:da80:e1e6 with SMTP id
 s64-20020a0de943000000b00599da80e1e6mr24874322ywe.34.1697094990851; Thu, 12
 Oct 2023 00:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <87db26af4a30210ab54519b91bb8541e88519185.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <87db26af4a30210ab54519b91bb8541e88519185.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Oct 2023 09:16:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUc33L1GgbRE80RTOW7yS85S9Gxv5z8EYX1EY0UaRUqPA@mail.gmail.com>
Message-ID: <CAMuHMdUc33L1GgbRE80RTOW7yS85S9Gxv5z8EYX1EY0UaRUqPA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/30] drivers/pci: Add SH7751 Host bridge controller
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        linux-pci@vger.kernel.org
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

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:24 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -342,6 +342,15 @@ config PCIE_XILINX_CPM
>           Say 'Y' here if you want kernel support for the
>           Xilinx Versal CPM host bridge.
>
> +config PCI_SH7751
> +       bool "Renesas SH7751 PCI controller"
> +       depends on OF
> +       depends on CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R || COMPILE_TEST
> +       select PCI_HOST_COMMON
> +       help
> +         Say 'Y' here if you want kernel to support the Renesas SH7751 PCI
> +         Host Bridge driver.
> +

When compile-testing:

    drivers/pci/controller/pci-sh7751.c: In function ‘sh7751_pci_probe’:
    drivers/pci/controller/pci-sh7751.c:276:16: error: implicit
declaration of function ‘P2SEGADDR’
[-Werror=implicit-function-declaration]
      276 |         word = P2SEGADDR(wres->start);
          |                ^~~~~~~~~

P2SEGADDR() depends on the SH-specific CONFIG_29BIT.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
