Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F757EAB5F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Nov 2023 09:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjKNILB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 14 Nov 2023 03:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjKNILA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 03:11:00 -0500
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C68A1B3;
        Tue, 14 Nov 2023 00:10:56 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a7d9d357faso59485697b3.0;
        Tue, 14 Nov 2023 00:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699949455; x=1700554255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQyWvVaaG3YYmj7OkmiIuVD+3WVrgTtuqGcCabyOScU=;
        b=Rn0Z/U9Iy0+3PV8cARa5wLREEDxwo2jdiXdxSmCBlp47/gRCyAiSkcQ4zzwuQQIr0U
         +AFB6FS72U+tusXr2qdeSYjjCeM07vt+GTuElymGjEsz5SpluoElbjZqVM0SAOzR4h+0
         bcvgIAHzW0i3WAHHUEExA8kzd7t75bwk6Y5a7nyGOLwGTODsqLguyWECohojuyGYR639
         lRGZNO3RdGdcPy1jP+y2pYZnY4QhE/0EtMva4ywRrpXr/02OCcbIWLdYNQIeAwwx33F9
         2PReWP45viBFDwvenSK8bdp35WdyM8L4mztfjXlHSpk5588Ee9PG2mqM45QY/pVWb+wJ
         kVlA==
X-Gm-Message-State: AOJu0YzXbX59vNpugXlitA5RQ7/vPv8pCgKs9xMk4Tb+26M2YYddI7Kn
        2xSiqC+JvrE5EbR5LImVX0NTWpw2JX1xeA==
X-Google-Smtp-Source: AGHT+IHAvW/VgBqQp9T86sQdAssMESIZGxc0+n9okpt4otfQrJ8ijbNKto/OTYemuruTJAcmkMvyvg==
X-Received: by 2002:a81:4113:0:b0:5a8:277f:b378 with SMTP id o19-20020a814113000000b005a8277fb378mr6212716ywa.1.1699949455205;
        Tue, 14 Nov 2023 00:10:55 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id v2-20020a0dd302000000b00576c727498dsm2266640ywd.92.2023.11.14.00.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 00:10:54 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-da7238b3eb4so5838478276.1;
        Tue, 14 Nov 2023 00:10:53 -0800 (PST)
X-Received: by 2002:a25:4206:0:b0:da0:c80f:5775 with SMTP id
 p6-20020a254206000000b00da0c80f5775mr8699596yba.61.1699949453644; Tue, 14 Nov
 2023 00:10:53 -0800 (PST)
MIME-Version: 1.0
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com> <20231114055456.2231990-6-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20231114055456.2231990-6-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Nov 2023 09:10:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWAa_9prcF3hVE+4DwtjVDzpQqA+qyMfB4P1U_yAVi9Zg@mail.gmail.com>
Message-ID: <CAMuHMdWAa_9prcF3hVE+4DwtjVDzpQqA+qyMfB4P1U_yAVi9Zg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] PCI: iproc: fix -Wvoid-pointer-to-enum-cast warning
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>,
        Nathan Chancellor <nathan@kernel.org>
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
> From: Justin Stitt <justinstitt@google.com>
>
> When building with clang 18 I see the following warning:
> |       drivers/pci/controller/pcie-iproc-platform.c:55:15: warning: cast to smaller
> |                integer type 'enum iproc_pcie_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
> |          55 |         pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);
>
> This is due to the fact that `of_device_get_match_data` returns a void*
> while `enum iproc_pcie_type` has the size of an int. This leads to
> truncation and possible data loss.

Note that in this case there is no data loss, as the original value
stored is of type enum iproc_pcie_type.

> Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
