Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A040554444
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 10:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiFVHqF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 03:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiFVHqE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 03:46:04 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FF41EEC3;
        Wed, 22 Jun 2022 00:46:02 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 89so24043138qvc.0;
        Wed, 22 Jun 2022 00:46:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NqzMVPYor30cDFAk/KEthpekJP7tc0FOSV0dYJSBIg=;
        b=2p78/HvsDyERGscXkkDLFEWSXjTHDm1mOm2WrUyHsjmFur5l++hu15U6gw/jNQR3A1
         oVoX9nM6wRXUFZVDuWfrYMHkv2SdlErDrueSD9hiqpWcyfkAOZVuUNnXIHpHlz+bilWN
         k6txD5Fp0sMgLBiZ4Dx1bwXgT2ONnFVgN0eYA91ixp8UwD6EWKny6o673OXpfpfi5nXD
         lUtXe0XNXefuxkwYj4MgH0JfWiQjSj10956uBJqufqwWyssMkGsidgb//LdfgGvj1f3o
         xKkd7NRLgJT/zKXWFLkaUcI+5qHfx0c5nhVhuSfK+BAJyeRo2Ooj2FEcQLf8rciPzGhA
         MzgA==
X-Gm-Message-State: AJIora96B8OQ4QVj6mCWJ5nomWrmAasFWXk+pcbh+thEscozpNNnnCh6
        w6X1zkpp4Ije/qvFnNYwnkpVPmWBUOBcSw==
X-Google-Smtp-Source: AGRyM1ulqpmxj+qEYL0sIiF/lFV4D3kBxb8Z/CSqDxIoDABXopohsN+RJw94iKblFAKohAMPGi+q8g==
X-Received: by 2002:a05:622a:547:b0:305:2dc3:6ecf with SMTP id m7-20020a05622a054700b003052dc36ecfmr1794625qtx.466.1655883961170;
        Wed, 22 Jun 2022 00:46:01 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id b22-20020ac85bd6000000b00304e33f21f7sm15038124qtb.68.2022.06.22.00.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 00:46:00 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id u9so18601206ybq.3;
        Wed, 22 Jun 2022 00:46:00 -0700 (PDT)
X-Received: by 2002:a25:2b48:0:b0:668:3b7d:326c with SMTP id
 r69-20020a252b48000000b006683b7d326cmr2251276ybr.380.1655883960430; Wed, 22
 Jun 2022 00:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220622025732.1359389-1-helgaas@kernel.org> <20220622025732.1359389-3-helgaas@kernel.org>
In-Reply-To: <20220622025732.1359389-3-helgaas@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Jun 2022 09:45:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUwGLDzOQo_wwSLmzBnJXe-cOw=nqsPbFLsj-c+nHfy_w@mail.gmail.com>
Message-ID: <CAMuHMdUwGLDzOQo_wwSLmzBnJXe-cOw=nqsPbFLsj-c+nHfy_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: rcar: Resolve of_find_matching_node() reference leak
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Liang He <windhl@126.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
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

Hi Bjorn,

On Wed, Jun 22, 2022 at 4:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Previously, rcar_pcie_init() used of_find_matching_node() to search the
> entire device tree for compatible strings for which we need to install an
> abort handler.  If we found one, we got a device_node with refcount
> incremented, but we discarded the pointer and never released that
> reference.
>
> Extend the struct rcar_variant to indicate whether each variant requires an
> abort handler.  Install the handler in rcar_pcie_probe() when needed.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Liang He <windhl@126.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks for your patch!

> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c

> @@ -964,12 +965,35 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie_host *host)
>         return err;
>  }
>
> +#ifdef CONFIG_ARM
> +static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
> +               unsigned int fsr, struct pt_regs *regs)
> +{
> +       return !fixup_exception(regs);
> +}
> +#endif
> +
> +static void rcar_pcie_hook_aborts(void)
> +{
> +#ifdef CONFIG_ARM
> +#ifdef CONFIG_ARM_LPAE
> +       hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> +                       "asynchronous external abort");
> +#else
> +       hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
> +                       "imprecise external abort");
> +#endif
> +#endif
> +}
> +
>  static const struct rcar_variant rcar_h1_data = {
>         .phy_init_fn = rcar_pcie_phy_init_h1,
> +       .hook_aborts = true,
>  };
>
>  static const struct rcar_variant rcar_gen2_data = {
>         .phy_init_fn = rcar_pcie_phy_init_gen2,
> +       .hook_aborts = true,
>  };
>
>  static const struct rcar_variant rcar_gen3_data = {
> @@ -1035,6 +1059,9 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>                 goto err_clk_disable;
>         }
>
> +       if (host->variant->hook_aborts)
> +               rcar_pcie_hook_aborts();

I was quite sure there was a good reason why this was not done in
.probe() before...

And indeed, the original submission[1] did have a comment explaining
that:

    + /*
    + * Since probe() can be deferred we need to make sure that
    + * hook_fault_code is not called after __init memory is freed
    + * by kernel and since rcar_pcie_abort_handler() is a no-op,
    + * we can install the handler here without risking it
    + * accessing some uninitialized driver state.
    + */

No idea why it was removed in v2 and later, but the point is:
hook_fault_code() is __init, so you cannot call it from a deferred
probe.
And you should have got a section mismatch warning ;-)

[1] https://lore.kernel.org/all/20200912211853.15321-1-marek.vasut@gmail.com/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
