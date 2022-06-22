Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D245543EA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 10:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351798AbiFVHuL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jun 2022 03:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354442AbiFVHtw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Jun 2022 03:49:52 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B1F37BFA;
        Wed, 22 Jun 2022 00:49:37 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id q4so11910928qvq.8;
        Wed, 22 Jun 2022 00:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MiZWM7MxRKqxYWhMwu/FnGq8WJHzbefkWgjumIh+/s4=;
        b=GnT2RBNJbahuJqBR51HTyvoibuQJp7UR2Fy2OLAxFnKhycBBtGKKdvDSbhENFdeQoG
         z6KkWIPuC0eCn7aOpPpklJANr78McSk6WKfrXxf/01xqQ2PpF0ECrMXVL/Lkb+W4AKwU
         rvt21E11/7MRebLX+fbWGZ4GpGLQJR328hrxt7esIKdXntQbtkrGX/pLx76MLJxMJahk
         AtTWyykBJFQue1MmdPTLKjvnq9JUarK0hDfgo8Z7NhSAROC7E2Pt8krAVOkO6e3D09rh
         /AB7+sDOoaQug+Qm9mrGhNOdi0Od0r4f6cLzr3w5dIfRuYBsNftN+RJQuc5hDwr9fCh6
         gH/Q==
X-Gm-Message-State: AJIora/e8bbh80JNY/y5CcHqgwLdo0z87yz2J6l2uGZ04hK8eSpzbp1e
        dnyVs/YZCnmJfs8he/is8pdQSHGG0OMU2Q==
X-Google-Smtp-Source: AGRyM1uzDBfxwFqWmHeknzLMiSphWzydQHEuZv+htjEUdaYeHCPPV83EozPNteAyBZaL8DAvX64/hA==
X-Received: by 2002:a05:622a:60d:b0:305:1ec1:5b01 with SMTP id z13-20020a05622a060d00b003051ec15b01mr1753388qta.491.1655884176941;
        Wed, 22 Jun 2022 00:49:36 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id u15-20020a05620a430f00b006a693e46d5csm16241385qko.11.2022.06.22.00.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 00:49:36 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-3176d94c236so154637327b3.3;
        Wed, 22 Jun 2022 00:49:36 -0700 (PDT)
X-Received: by 2002:a81:2401:0:b0:317:ce48:cf95 with SMTP id
 k1-20020a812401000000b00317ce48cf95mr2587809ywk.502.1655884176233; Wed, 22
 Jun 2022 00:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220621070145.4080147-1-windhl@126.com> <20220621224952.GA1340618@bhelgaas>
In-Reply-To: <20220621224952.GA1340618@bhelgaas>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Jun 2022 09:49:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWJCX93kyjUwKxBgfWfazSgUKC3J=kMDj3EtTViRBJ+=Q@mail.gmail.com>
Message-ID: <CAMuHMdWJCX93kyjUwKxBgfWfazSgUKC3J=kMDj3EtTViRBJ+=Q@mail.gmail.com>
Subject: Re: [PATCH] pci/controller/pcie-rcar-host: Hold the reference
 returned by of_find_matching_node
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Liang He <windhl@126.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
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

Hi Bjorn,

On Wed, Jun 22, 2022 at 12:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jun 21, 2022 at 03:01:45PM +0800, Liang He wrote:
> > In rcar_pcie_init(), we need to hold the reference returned by
> > of_find_matching_node() which is used to call of_node_put() for
> > refcount balance.
> >
> > Signed-off-by: Liang He <windhl@126.com>

> > --- a/drivers/pci/controller/pcie-rcar-host.c
> > +++ b/drivers/pci/controller/pcie-rcar-host.c
> > @@ -1158,7 +1158,10 @@ static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst
> >
> >  static int __init rcar_pcie_init(void)
> >  {
> > -     if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
> > +     struct device_node *np = of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match);
> > +
> > +     if (np) {
> > +             of_node_put(np);
>
> I think this is correct, but it would be nicer to update the way this
> driver uses of_device_get_match_data(), e.g.,
>
>   struct rcar_variant {
>     int (*phy_init_fn)(struct rcar_pcie_host *host);
>     bool hook_abort;
>   };
>
>   struct rcar_pcie_host {
>     ...
>     const struct rcar_variant *variant;
>   };
>
>   static int rcar_pcie_probe(...)
>   {
>     host->variant = of_device_get_match_data(dev);
>     err = host->variant->phy_init_fn(host);
>     ...
>
>   #ifdef CONFIG_ARM
>     if (host->variant->hook_abort) {
>   #ifdef CONFIG_ARM_LPAE
>       hook_fault_code(17, ...);
>   # else
>       hook_fault_code(22, ...);
>   #endif
>     }
>   #endif
>   }
>
> Or keep the hook in a separate function called from rcar_pcie_probe()
> if you think that's cleaner.
>
> I'm not sure hook_fault_code() needs to be called separately as a
> device_initcall().

Yes it doesn, as hook_fault_code() is __init.

> The pci-ixp4xx.c driver does it in
> ixp4xx_pci_probe(), so I assume rcar could do it in probe as well.

The pci-ixp4xx.c driver uses builtin_platform_driver_probe(), and
ixp4xx_pci_probe() is marked __init.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
