Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713076B3E9C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 13:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCJMEb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 07:04:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCJMEa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 07:04:30 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F152EA014;
        Fri, 10 Mar 2023 04:04:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g3so19557046eda.1;
        Fri, 10 Mar 2023 04:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678449868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7JxCDIVzx63/0USvlw4b2PiFBo7GGlMiiEoXtp1Amu4=;
        b=kqp/fj0uASTKrAmvf0lTJGWGKD9gFQlxmnqqS5X5AGk2553pxdR8KZp5V0XwHtybS7
         2b3kqVkJThJ2G0PPuq9QoR2dPpVJU0SXpW601F1iydUt1zPutR3O1dinA0F1ADXPlnzF
         ZrZCgfTNa3NwIDI9Bh2JErYh2ah738xo3qxQp6QniFND9su9bS0BQnBE+PEZQTjJdegp
         vB7oKe3w1A5C7f5kKeODVg/B7rkdPJmwespxAUn7x6sHcdVJ35X1LCRoNR4Q7u7MRmIy
         FGAk65pKIkPXaYFDOPNB7yVABgqfXka4n6BF8UEl7BcM2uKqr9Bl0zwsp4FtMcSG+Kru
         P/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678449868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JxCDIVzx63/0USvlw4b2PiFBo7GGlMiiEoXtp1Amu4=;
        b=CDfSGptqgv2Jv9uCJPsi1vnzFqRNTa291cqVWhnfOZIvdKpuKkEnQzmqTHPOVx4Qwx
         Xchb2Ezc1LR8uuilKaeEEpl/IIK/D8d5YAud5NkdpVXKvOoM5jFuwxFHEjFfp/YpylMu
         s6NZA8QWrZSGMFD4UqsAdegchb2huIb0oidsCBuIeJY16DlB1vlWlKmnBzTbfLl/CZ0G
         o+SZlX6SyYb+L93MBuGfVKFmdAzgrMSGdyi79lgkRItFQDr3+7fTkN9EJvNpAlZDQSnE
         olOXI3dYKuVnN1yztuTEYinQUW0KUQVGO3w2nTxIn6sRjme8Gz23DrFKFAsnY/wsTWFm
         vHJQ==
X-Gm-Message-State: AO0yUKU03mWFkJS5VH9lmVF8bf0yeuW/1HLC2TwbVJ0PnMsARc3pctSZ
        5kHvZgm1sQi/OkjSQevzfqIILXj/36YSGmrEmdo=
X-Google-Smtp-Source: AK7set8NexWLnnznp47X6iexl2bquKGhMUmpmcoFxaD97rzeEbBrsEdy4xTtZDpmQ5EjrulWwvs76lPRcjQUNCkG/yg=
X-Received: by 2002:a50:9b53:0:b0:4ae:f648:950b with SMTP id
 a19-20020a509b53000000b004aef648950bmr13917661edj.7.1678449867835; Fri, 10
 Mar 2023 04:04:27 -0800 (PST)
MIME-Version: 1.0
References: <20230310080518.78054-1-lucas.tanure@collabora.com>
 <20230310080518.78054-2-lucas.tanure@collabora.com> <CAMdYzYpL7V6udw=T7ZChTFi0xOj1tb-5CVHb84u1pL4kj3eDZA@mail.gmail.com>
 <86v8j8yg3d.wl-maz@kernel.org>
In-Reply-To: <86v8j8yg3d.wl-maz@kernel.org>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 10 Mar 2023 07:04:16 -0500
Message-ID: <CAMdYzYo5FW6NT8zj8+4meAV-HVve+rVYybibVHy4GONC_PJ-6Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] irqchip/gic-v3: Add a DMA Non-Coherent flag
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lucas Tanure <lucas.tanure@collabora.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, kernel@collabora.com,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 6:57 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 10 Mar 2023 11:41:46 +0000,
> Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > On Fri, Mar 10, 2023 at 3:05 AM Lucas Tanure <lucas.tanure@collabora.com> wrote:
> > >
> > > The GIC600 integration in RK356x, used in rk3588, doesn't support
> > > any of the shareability or cacheability attributes, and requires
> > > both values to be set to 0b00 for all the ITS and Redistributor
> > > tables.
> > >
> > > This is loosely based on prior work from XiaoDong Huang and
> > > Peter Geis fixing this issue specifically for Rockchip 356x.
> >
> > Good Morning,
> >
> > Since the gic is using dma, would it be reasonable to have all memory
> > allocations be requested with the GFP_DMA flag? Otherwise this doesn't
> > fully solve the problem for rk356x, where only the lower 4GB range is
> > DMA capable, but this tends to get allocated in the upper 4GB on 8GB
> > boards.
>
> That's an erratum. Please treat as such.

Good Morning,

Yes, believe me I'm fully aware of how broken rk356x is. I'm asking an
educational question from a kernel standards point of view, absent the
rk356x issues. Would it be reasonable that since the gic uses dma
memory, allocations for the gic should be made with the GFP_DMA flag?
Or is that a misuse of the flag?

Very Respectfully,
Peter Geis

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
