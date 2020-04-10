Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD001A44C6
	for <lists+linux-pci@lfdr.de>; Fri, 10 Apr 2020 11:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgDJJyv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Apr 2020 05:54:51 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46320 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgDJJyu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Apr 2020 05:54:50 -0400
Received: by mail-oi1-f196.google.com with SMTP id q204so975971oia.13;
        Fri, 10 Apr 2020 02:54:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1d1XLTB/2TtSpI+7NodPBxSgyiEeAYRsnLTIEfHtpg=;
        b=l4ERzHaxnsCJ0VSSoRHZ6qHPC3mhAnNAFHeOIdV2GeEyUiVjlwX5ETeixZpdqD1/tt
         f8pqsrSJgMcIRDwO+giHokCBLdJVb+FqhEpvaRi1E+fIo8s+qkiSJP6z/S0WtB6EHQkY
         WwSgs4c5h38I0O/GXuq3gDMKrDsd5KUaHuqjEFU9UyHfKpjX9R2fd0qZNKl290sgLsgq
         nolsEpPh8ecZit3oMxsyPYIUH/74YaIL3QNIFCAtYunehpyYwQPUfdnBG91wPQjrUXl1
         LWnUbDgFPgASoYsOtv59Ml1GrybI+juY5mZySo/l8GYtFGNjEePDuhboKl4Dh+QQz5rB
         6z8A==
X-Gm-Message-State: AGi0PuZ1hprgwI2sSwZwU1avnMhcLI5hD7L+zteLBufBdWLkh/e0AWNf
        wsArWK+RMiwQ6cro/idqFLPcSmMZL/helHtVW7o=
X-Google-Smtp-Source: APiQypKNQcgqN0bbsABgAUQR2QC8zFhmrvIi1o2rcL+o9N7La3nc7If6nDU0LZ4BXOlgRpw81rRADcWVpteOupYysYk=
X-Received: by 2002:aca:240e:: with SMTP id n14mr2821433oic.54.1586512488782;
 Fri, 10 Apr 2020 02:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <1586511020-31833-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1586511020-31833-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 10 Apr 2020 11:54:37 +0200
Message-ID: <CAMuHMdWgv2KDYNA99g_XUcrQ0FcCX_=smV5fJqhaPxjDWjKAAQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pci: rcar: add r8a77961 support
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 10, 2020 at 11:31 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add support for r8a77961 (R-Car M3-W+).
>
> To avoid confusion between R-Car M3-W (R8A77960) and R-Car M3-W+
> (R8A77961), this patch also updates the comment of
> "renesas,pcie-r8a7796".
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
