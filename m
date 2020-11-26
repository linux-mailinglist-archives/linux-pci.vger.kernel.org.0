Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06ABF2C526B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 11:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgKZKv3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 05:51:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45938 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgKZKv2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 05:51:28 -0500
Received: by mail-ot1-f67.google.com with SMTP id k3so1486510otp.12;
        Thu, 26 Nov 2020 02:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKsnqNHLPjfzJEz+LOz9b4IyVMWHOQQVeFeqeTFluRM=;
        b=t7UJ+DPZvpjdYgd0jmb1WyZyrlJ3Kcvg62FtGbwxoKhZk2Xy+ir7y43yS7Iq3vb8TE
         7V3+E8sLKwiif4Yo58zw8xzEQedal+6sdjTrlNuHl8aHS7QoC4KZllUp7KdUC98PwCJs
         e/E8dk0sG1BAuGqjTGB5YeYbk1mWYWWYx2yNTYPJBh6AC9leRJOAgnZFOXkfwCOlK1a6
         4hMTPzi5VjGJjsRmz0/vwXHYFNNCAj3GCDBx4SaftCuvGVfjdGIgQfDwUA78fB11oob2
         o0r/5Hiz+Gc2TpfFzQc3X9Nc14fcf73d0r3RDTEHRMbdXs5u36VMeM9/Cv3OWoF5f++s
         peng==
X-Gm-Message-State: AOAM532ameRQCD9k5VLWYIrVrFDfOv5DBGl4JYVknErbIFjGHInzhwXn
        JSRPhfl+6IYTtm4NXgvv60haxjMmM01Zzx6y85s1J0PZYUo=
X-Google-Smtp-Source: ABdhPJxjtblWrr1n26nJp4tQDVTYSnquxSVHhmkmB6z1QxpqadgNFEOGxbonsoJaFaUa3BMwTjR/nUCfuovN7HTCbWM=
X-Received: by 2002:a05:6830:210a:: with SMTP id i10mr1831584otc.145.1606387886190;
 Thu, 26 Nov 2020 02:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20201125073303.19057-1-yuya.hamamachi.sx@renesas.com> <20201125073303.19057-2-yuya.hamamachi.sx@renesas.com>
In-Reply-To: <20201125073303.19057-2-yuya.hamamachi.sx@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Nov 2020 11:51:15 +0100
Message-ID: <CAMuHMdVGMcEPOkofqBmwsHPGvLohYbXQ4KKvVzXd9ty1KR2K8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pci: rcar-pci-ep: Document r8a7795
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

On Wed, Nov 25, 2020 at 8:45 AM Yuya Hamamachi
<yuya.hamamachi.sx@renesas.com> wrote:
> Document the support for R-Car PCIe EP on R8A7795 SoC device.
>
> Signed-off-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
