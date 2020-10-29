Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F35329ED86
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 14:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgJ2NtM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 09:49:12 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39758 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgJ2NtL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 09:49:11 -0400
Received: by mail-oi1-f195.google.com with SMTP id u127so3225179oib.6;
        Thu, 29 Oct 2020 06:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/PkxtW4lbE3bw7TdrBLMQnlZPKOuOmDD8hftAGjdvI=;
        b=Jv1KKivVwiqEA0GsQseSWaVfe29kq4AUXpi9XNMlG4eBW79ms2X48SQjAPWZ//v3Y8
         AgOOhI8hs38G2Aa69syQBrK0oxfabONhCmjFHUcj38EijUiWbdhjIEXqqD82dBKqdDIM
         NscSDA6PyWNDRGiJlUTQ/4dqApAL0DCDBbV5yMzVMForp4z/D6jtZs6RMNU+wVUuCJPY
         R2ufZBmeojET5f0TGwQRwq4dtn8+wno509YZlbQ4j3Uuoe/e1wZUjFJ4j9JlgfhQf8Bo
         QddeHWFfEhlUWyoglTG4CaLgK5CDkPidf0FIef8jfpxCipyKtUxttnaPBLa3GUKTTvFf
         unbg==
X-Gm-Message-State: AOAM533VUjMLNeoipX++fnTVa8DNSbxT/ndVvTrLkPZSamyZAXyc4AKg
        WgFUY9t4Aq/WrC9YmCK5dKN++H+B+5pePRMfGx4O9PDRWs3a2g==
X-Google-Smtp-Source: ABdhPJxmRcdoWxm1NaLMAUSOxyn4a6MI2KmbXeDRvzKPAhLdGmjGP48bxLTQ3TbbczBcc/E5NCNuLYJuP7qWUctOiw0=
X-Received: by 2002:aca:f40c:: with SMTP id s12mr2821188oih.153.1603979350829;
 Thu, 29 Oct 2020 06:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <1603850751-32762-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1603850751-32762-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1603850751-32762-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 29 Oct 2020 14:48:59 +0100
Message-ID: <CAMuHMdWccCTv=YEyv6EZRbnWxwv_x455+XoTEXQritkHgLebHw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: pci: rcar-pci-host: document r8a77965 bindings
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 28, 2020 at 10:41 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Document the R-Car M3-N (R8A77965) SoC in the R-Car PCIe bindings.
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
