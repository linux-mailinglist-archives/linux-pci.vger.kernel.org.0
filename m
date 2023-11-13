Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134507E9AAD
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 12:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjKMLHa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 13 Nov 2023 06:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjKMLH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 06:07:28 -0500
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ACB10E5;
        Mon, 13 Nov 2023 03:07:25 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a84204e7aeso49695277b3.0;
        Mon, 13 Nov 2023 03:07:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699873644; x=1700478444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ljt2pdxD6mQ41IzJFM9voVHvaM5NwwcPFP6Lo8muJps=;
        b=l9vqOKCylWixRFCVs6OQpZPT1nEW+ivmJs6zscStWZL27HKlndyWmScW7MOyOsRfBZ
         pqK9oFoFNA9ySauv+HkmoKwsLlXmHeqBwp31JltHlW+ccXwtU1DtNUDJ9g91BsLOWMAE
         eLBpV2llUSMZFy2KEG7Y/9xKffEfVU+ANAO2MoanfZvWLfJ0b5h1VlcNQFJeftkR+A5W
         l8lJ5Gd60AHLdJIGW6eHKMBWAn/7qPOQIwXUerOmXMcEBkpqpNhC18uXx8m6ysAQsznt
         TpR4lu+99PiBL3f5pBZo/731ebBqrpHVQ/Eot+vNlRkFXwg47ZMiZcHFmjLdn+gWW8RD
         cHkg==
X-Gm-Message-State: AOJu0YxIvhuVwangtgXI7YOI3nwOwdU1axv11dXkaX+MMIFe2b7EqaHE
        4WSU0P1eUK/v6LG8wsnkeXNVxvsLlnbYzA==
X-Google-Smtp-Source: AGHT+IE3qDg+It7J4b/6sqItexT3wp8U2YEWSY8gLqwIBeuZnHNZ2iCC7hCo6snDa7Nb9jH/Wm2S4A==
X-Received: by 2002:a0d:e294:0:b0:5a7:ab51:af5c with SMTP id l142-20020a0de294000000b005a7ab51af5cmr6232068ywe.13.1699873643471;
        Mon, 13 Nov 2023 03:07:23 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id t141-20020a818393000000b005a0f9718a5fsm1703051ywf.78.2023.11.13.03.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 03:07:21 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5c08c47c055so27628477b3.1;
        Mon, 13 Nov 2023 03:07:20 -0800 (PST)
X-Received: by 2002:a81:9141:0:b0:5b3:60c2:5781 with SMTP id
 i62-20020a819141000000b005b360c25781mr6828845ywg.32.1699873640712; Mon, 13
 Nov 2023 03:07:20 -0800 (PST)
MIME-Version: 1.0
References: <20231113013300.2132152-1-yoshihiro.shimoda.uh@renesas.com> <20231113100914.GB1583963@rocinante>
In-Reply-To: <20231113100914.GB1583963@rocinante>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Nov 2023 12:07:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVLmmf12KPQch7fT2iGjfDV--M2Wd0zsxSw6wfqYxUggQ@mail.gmail.com>
Message-ID: <CAMuHMdVLmmf12KPQch7fT2iGjfDV--M2Wd0zsxSw6wfqYxUggQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI: dwc: Improve code readability
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mani@kernel.org, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        roy.zang@nxp.com, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-renesas-soc@vger.kernel.org
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

On Mon, Nov 13, 2023 at 11:09 AM Krzysztof Wilczyński <kw@linux.com> wrote:
> > This patch series is based on the latest pci.git / next branch.
> [...]
>
> Thank you for following up to tidy things up!  Much appreciated.
>
> Now, while you are looking at things, can you also take care about the following:
>
>   drivers/pci/controller/dwc/pcie-rcar-gen4.c:439:15: warning: cast to smaller integer type 'enum dw_pcie_device_mode' from 'const void *' [-Wvoid-pointer-to-enum-cast]
>
> This requires adding structs for each data member of the of_device_id type.

That sounds like overkill to me.
An intermediate cast to uintptr_t should fix the issue as well.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
