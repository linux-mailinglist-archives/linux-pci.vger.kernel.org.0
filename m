Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D303F7EAB61
	for <lists+linux-pci@lfdr.de>; Tue, 14 Nov 2023 09:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjKNIMD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 14 Nov 2023 03:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjKNIMD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 03:12:03 -0500
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E544D182;
        Tue, 14 Nov 2023 00:11:57 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a84204e7aeso62327757b3.0;
        Tue, 14 Nov 2023 00:11:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699949517; x=1700554317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHG3EGmxTIdYX2e8a6DHgsba/Di0EdWLhT/NZ6xsUZs=;
        b=Myn11gem+mcdqzwev6mby7YL3+tl4xZwPqgRNmqPvaPjkhT1wDARYtunV9F1ajQBEg
         excQKHn5ttfKf4JiGdVTqTmliU3vc5L/NOXJi70ig6LOqf3aD0bbynVqBUEynL3G21H6
         ydjX6s7ML5HUo0Fivto5mgwU6jp8BrSsH83Pxl9bmCJWIHzGdT6IQzx56wdWk/Zr1pPv
         KwL5Y5uQC/RLTzFuoYeW0A0Vr7L46LcXcUERdkBjcMtUYA1LkIOzeWKmXSZe+cdnskge
         NjDpuFzegFIgzt3LTsGKhSn2Ydvam8p8pAHKtc3PycTCeCzYc1ZseU+nBkp9kRXXpJ4T
         68Cg==
X-Gm-Message-State: AOJu0YxgUB9BoLy0uXF1TOEnxRpYpgKZ1EzzAHgBnq+aMz3Z0DDDtbOd
        DB2R315KxActlQ5wUnbaF/Y5IrpaSV08YA==
X-Google-Smtp-Source: AGHT+IEC5AVmKpqc6r8I6fjzb8ldoGwOZT+9khjQ/9VMwgWbdok752EpgE72//VpFEHH2MUJn1YjTA==
X-Received: by 2002:a81:8002:0:b0:5a7:a959:337 with SMTP id q2-20020a818002000000b005a7a9590337mr8492365ywf.27.1699949516993;
        Tue, 14 Nov 2023 00:11:56 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id c68-20020a0df347000000b005a8c392f498sm2263961ywf.82.2023.11.14.00.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 00:11:56 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-da819902678so5439574276.1;
        Tue, 14 Nov 2023 00:11:56 -0800 (PST)
X-Received: by 2002:a25:b381:0:b0:da0:5acf:e5f6 with SMTP id
 m1-20020a25b381000000b00da05acfe5f6mr8305332ybj.61.1699949516109; Tue, 14 Nov
 2023 00:11:56 -0800 (PST)
MIME-Version: 1.0
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com> <20231114055456.2231990-7-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20231114055456.2231990-7-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Nov 2023 09:11:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU_Bb4t2wA86ypegRu6i6gE9dftp3TRtpRP8MOmUD0QXQ@mail.gmail.com>
Message-ID: <CAMuHMdU_Bb4t2wA86ypegRu6i6gE9dftp3TRtpRP8MOmUD0QXQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] PCI: rcar-gen4: fix -Wvoid-pointer-to-enum-cast warning
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
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

On Tue, Nov 14, 2023 at 6:55 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> When building with clang 18 with adding -Wvoid-pointer-to-enum-cast,
> the following error happens:
>
> drivers/pci/controller/dwc/pcie-rcar-gen4.c:439:15: error: cast to smaller integer type 'enum dw_pcie_device_mode' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
>   439 |         rcar->mode = (enum dw_pcie_device_mode)of_device_get_match_data(&rcar->pdev->dev);
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> To fix this issue, use uintptr_t instead.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
