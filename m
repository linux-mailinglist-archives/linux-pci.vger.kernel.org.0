Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C470B7E9C82
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 13:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjKMM5v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 13 Nov 2023 07:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMM5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 07:57:50 -0500
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48DBD7E;
        Mon, 13 Nov 2023 04:57:46 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5af6c445e9eso50954797b3.0;
        Mon, 13 Nov 2023 04:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699880266; x=1700485066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70G7gCA85kCqk8BsrysSVq5eVLLC+P3sWPCjl6nhTgo=;
        b=oM65h7o4V47fFCE0QP23gucr7sC9HAo/DflB1SEF2aijdYFBQR8Jz6py9895EshLhY
         GT04fdzGSfpwnsPii7Oz1wna8r9lNqEC751/Cpnwc0ixoawHZnfOaARR/Dxm+BmTXrI1
         haJMs2CMO7d1wng7aNBNg1uMxLoMZmgR7vGaTEVaOX8Xb3RTSzcKiRWs5A9bqRh2doB8
         4IadqTdI0n6XRo650eKuYra6o9yFl3+Gyzg9HvXoWWju/rlzz3NDTFi8BVyf+gMzQlqo
         LphzDsbwA0sdDdhBIietgPSudeS5CXJtSm922ZzrAknqPZMYAH9qXnkNNmtxmdcELZC7
         W8WA==
X-Gm-Message-State: AOJu0Yx7nEHFnzYtHXfVjlNvpmnuRESm7DyOstYj+DajWnYG3HmnkGGY
        qZq4+MM9vJWJWEeGACemqXKceSqQ0ByLaw==
X-Google-Smtp-Source: AGHT+IGVfTEo39pSA+V5umXnR/80/GWAzi2D76eaJj8SJQd97fWR289QlCwPcjyLRe1WEQrLLEs+VQ==
X-Received: by 2002:a25:6ac6:0:b0:d9a:5021:4f34 with SMTP id f189-20020a256ac6000000b00d9a50214f34mr4522494ybc.15.1699880265895;
        Mon, 13 Nov 2023 04:57:45 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id k13-20020a25b28d000000b00d7497467d36sm1548122ybj.45.2023.11.13.04.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 04:57:44 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dafe04717baso140037276.1;
        Mon, 13 Nov 2023 04:57:44 -0800 (PST)
X-Received: by 2002:a25:41d0:0:b0:da0:d0be:ef06 with SMTP id
 o199-20020a2541d0000000b00da0d0beef06mr5385018yba.51.1699880263994; Mon, 13
 Nov 2023 04:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com>
 <20231113100914.GB1583963@rocinante> <CAMuHMdVLmmf12KPQch7fT2iGjfDV--M2Wd0zsxSw6wfqYxUggQ@mail.gmail.com>
 <TYBPR01MB53411530E01A90CB525DF814D8B3A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <20231113122221.GA2418639@rocinante>
In-Reply-To: <20231113122221.GA2418639@rocinante>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Nov 2023 13:57:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX2D-Ui=6Xt_x_yDAYQYoooP51ZwZTmoASwcUeZTcME4g@mail.gmail.com>
Message-ID: <CAMuHMdX2D-Ui=6Xt_x_yDAYQYoooP51ZwZTmoASwcUeZTcME4g@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI: dwc: Improve code readability
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "minghuan.Lian@nxp.com" <minghuan.Lian@nxp.com>,
        "mingkai.hu@nxp.com" <mingkai.hu@nxp.com>,
        "roy.zang@nxp.com" <roy.zang@nxp.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On Mon, Nov 13, 2023 at 1:22 PM Krzysztof Wilczyński <kw@linux.com> wrote:
> > > > Now, while you are looking at things, can you also take care about the following:
> > > >
> > > >   drivers/pci/controller/dwc/pcie-rcar-gen4.c:439:15: warning: cast to smaller integer type 'enum dw_pcie_device_mode'
> > > from 'const void *' [-Wvoid-pointer-to-enum-cast]
> >
> > Thank you for the report!
> >
> > > > This requires adding structs for each data member of the of_device_id type.
> > >
> > > That sounds like overkill to me.
> > > An intermediate cast to uintptr_t should fix the issue as well.
> >
> > I confirmed that the uintptr_t fixed the issue.
>
> We declined a similar fix in the past[1] ...
>
> > I also think that adding a new struct with the mode is overkill.
>
> ... with the hopes that a driver could drop the switch statements in place
> of using the other pattern.  Also, to be consistent with other drivers that
> do this already.

Note that the issue of casting is something we cannot fix easily:
some *_device_id structs use "kernel_ulong_t" for the "data" member,
others use "void *".

git grep -W "_device_id" -- include/linux/mod_devicetable.h | grep data

In addition, several drivers use multiple types of device IDs, so you
cannot settle on one type to avoid casts.

Also, putting enum values in instances of that struct, as suggested,
increases kernel size, for IMHO no additional gain.  If there is more
data to put in the struct, I agree it makes sense to use a struct.

> > So, I would like to fix the issue by using the cast of uintptr_t.
>
> Sure.  I appreciate that this would be more work.  When you send your
> patch, can you include an update to the iproc driver (and credit the
> original author from [1])?  I would appreciate it.
>
> 1. https://lore.kernel.org/linux-pci/20230814230008.GA196797@bhelgaas/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
