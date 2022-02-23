Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A7C4C13F3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Feb 2022 14:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbiBWNVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Feb 2022 08:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbiBWNVG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Feb 2022 08:21:06 -0500
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE678AA03D;
        Wed, 23 Feb 2022 05:20:38 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id t25so1416119uaa.3;
        Wed, 23 Feb 2022 05:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuR7Va65+Y5mma3TTzgiQBG/Y2rCid4VzfEWWUYwSws=;
        b=LFOuRT4fL8554KN8WFw3zfOKljErM25arQDgLFVGHMo3n+ylabsp6sV0tGbwmXYkUb
         4jbpPkjdi9zPb+fwnrGgmriPdWp5XASmhfTxOzDx1lYNP4p/wqQhy/2g4kXpZZntc9sM
         CNvITRxz7K/wDpakH1+6svnI+KFVaGfHWo+S5CEnL3RbHqx7T6SZDOVRxZzyUChI351A
         rkKNbDokzhPKEtkbP4y6j6r13vyUV9OqtEDHb0EM+nXXjg6S/JWd+spB26YeCqhaQE8f
         Oi5pevEOOTSLGQ10QVr8ENkbf/rCYpzRcgNJH/7jX7bT1Imzh1PImdD8+8vbU/Vmc06a
         eEFQ==
X-Gm-Message-State: AOAM530GnYDp3WJhUfQ65RQQCGKnb4bdXaWyompygYKk52RaaqDxrSQ2
        qrCP4prPssSDXmXRM7/e4GaGkea1omc3ug==
X-Google-Smtp-Source: ABdhPJzgcIumJbv78mkVZpsj2YyXiHZNN9Vaxyi9otEPSEaxmybylXjyyWlGkbhpb1IqgCD5d5GghQ==
X-Received: by 2002:ab0:3046:0:b0:33c:7679:3141 with SMTP id x6-20020ab03046000000b0033c76793141mr11447936ual.15.1645622438032;
        Wed, 23 Feb 2022 05:20:38 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id r6sm877889uar.10.2022.02.23.05.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 05:20:37 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id j12so12255743vkr.0;
        Wed, 23 Feb 2022 05:20:37 -0800 (PST)
X-Received: by 2002:a05:6122:ca1:b0:330:b95b:e048 with SMTP id
 ba33-20020a0561220ca100b00330b95be048mr12743811vkb.39.1645622437036; Wed, 23
 Feb 2022 05:20:37 -0800 (PST)
MIME-Version: 1.0
References: <20220219034604.603656-1-marek.vasut@gmail.com> <20220219034604.603656-2-marek.vasut@gmail.com>
In-Reply-To: <20220219034604.603656-2-marek.vasut@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 23 Feb 2022 14:20:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU7gxmuhOPjh_awCE0XbjatfPEKRUH3=qzvEsmwReDjsQ@mail.gmail.com>
Message-ID: <CAMuHMdU7gxmuhOPjh_awCE0XbjatfPEKRUH3=qzvEsmwReDjsQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI: rcar: Use PCI_SET_ERROR_RESPONSE after read
 which triggered an exception
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
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

On Sat, Feb 19, 2022 at 4:46 AM <marek.vasut@gmail.com> wrote:
> From: Marek Vasut <marek.vasut+renesas@gmail.com>
>
> In case the controller is transitioning to L1 in rcar_pcie_config_access(),
> any read/write access to PCIECDR triggers asynchronous external abort. This
> is because the transition to L1 link state must be manually finished by the
> driver. The PCIe IP can transition back from L1 state to L0 on its own.
>
> The current asynchronous external abort hook implementation restarts
> the instruction which finally triggered the fault, which can be a
> different instruction than the read/write instruction which started
> the faulting access. Usually the instruction which finally triggers
> the fault is one which has some data dependency on the result of the
> read/write. In case of read, the read value after fixup is undefined,
> while a read value of faulting read should be PCI_ERROR_RESPONSE.
>
> It is possible to enforce the fault using 'isb' instruction placed
> right after the read/write instruction which started the faulting
> access. Add custom register accessors which perform the read/write
> followed immediately by 'isb'.
>
> This way, the fault always happens on the 'isb' and in case of read,
> which is located one instruction before the 'isb', it is now possible
> to fix up the return value of the read in the asynchronous external
> abort hook and make that read return PCI_ERROR_RESPONSE.
>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

With this series applied, my koelsch (R-Car M2-W) with Intel 9301CT
Gigabit Ethernet adapter survived 1000 suspend/resume cycles.
Before, it would lock-up after a handful tries.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
