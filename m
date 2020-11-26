Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD2F2C5332
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 12:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgKZLoI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 06:44:08 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42640 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgKZLoI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 06:44:08 -0500
Received: by mail-oi1-f195.google.com with SMTP id v202so1960285oia.9;
        Thu, 26 Nov 2020 03:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNWYKGbypDFoap5qLqujfYdysD6Sz9Zm1+agwezrpTA=;
        b=YVxgn0YqIEmg0l/Jz0hVbr9k9SMJhLbSPEkYorzpAQcA4XocGSLx0WGnEtbR33trFm
         ypP3XOQx4PP1EdA6XNoDe9X1Xg5uh9Xwk1blbgbuxOnn1c5FITIS+gTz+uQCbO3BEt3Z
         vp4CwUxaPbjUk34+OEMfCqXksxlX8kjDPPgmAowuGJeUuUVwenO/U9nv6SKUeVX53LU1
         MyJaUKj5RIqoYfnrkz6vs7cLziyf8OR8WDLdgQUDr+sTD6yJqeD+u9tD2E49k8hwwt4p
         qS3uJoDlIrZw/KO3ERbOJV4cfclWn4jswMQdOXZoTFLljuQEKz/NAiRrB1HG6ri32O6k
         5tPQ==
X-Gm-Message-State: AOAM530xKy4ewgE7ocoNC000FTf9yPsIrJmfbMustEhRS9m8E5EQlELK
        +cmUcjY19UyiUv16u9ndZ5tKA8DiA+GoSjAugERW28RPHKg=
X-Google-Smtp-Source: ABdhPJyeMCVnytHUJxvejUca4WmcqCiMZgzdNYmp3MKVcP3J8+Nj7T+G8FqNJBrWgxz0Dw6spFlW8hCGb9byy+IEX6Q=
X-Received: by 2002:aca:4bc3:: with SMTP id y186mr1737668oia.153.1606391047346;
 Thu, 26 Nov 2020 03:44:07 -0800 (PST)
MIME-Version: 1.0
References: <20201125073303.19057-1-yuya.hamamachi.sx@renesas.com> <20201125073303.19057-3-yuya.hamamachi.sx@renesas.com>
In-Reply-To: <20201125073303.19057-3-yuya.hamamachi.sx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Nov 2020 12:43:56 +0100
Message-ID: <CAMuHMdXY5gO=xOvqstUyCje=Et1MjvS5MjkDdL0u0HqDjURxQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: renesas: r8a77951: Add PCIe EP nodes
To:     Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 25, 2020 at 8:43 AM Yuya Hamamachi
<yuya.hamamachi.sx@renesas.com> wrote:
> Add PCIe EP nodes for R8A77951 SoC dtsi.
>
> Signed-off-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.11.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
