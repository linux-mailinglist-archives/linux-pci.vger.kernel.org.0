Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAAC1E08D9
	for <lists+linux-pci@lfdr.de>; Mon, 25 May 2020 10:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgEYIbo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 May 2020 04:31:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34623 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgEYIbo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 May 2020 04:31:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id b18so13311850oti.1;
        Mon, 25 May 2020 01:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BOHOgMSOtvrMttT8QDeSyXiqFQqVxvPloVdz2ZAYSg4=;
        b=kUIj48FwJVJflf9L5yyotJkS4lEvvFkwq/qEMupikdAVcHGvWZVqYHZPiS5RFfVU45
         //GISgykgzlkamgiTNWARuFEQk1L69JMh2Sfev3cosfASJUsjMZ/5UNPUIIzYIMJqVZm
         WEi4GMXdhp1yHVXp0XcQI0vRZLPJw+9RQ22qc9mOtHg01vo2NdakO6pQNHeB8HOdjWNk
         JI6J4Fs9Z3m5yUj+ZH/TT7X+CaGRmito6XzNensZNQGi9pdQa1aFkbxzgR+0te63Leqp
         1dcNHjLOp7SbIGQPbJ1JoNPq/UZ0A7+pw8vpnuHOCJEHNUK3AhAnCzj+O9+bLWGUM39t
         FagQ==
X-Gm-Message-State: AOAM530nc89JBZPmLl3grBlNyccxvg2Gw1jJFZ6oeVe6W3XhRkTTVZDH
        94lV1ZlIIzK3y1/isdIVvgFKVruTsY6aLZqw/z8=
X-Google-Smtp-Source: ABdhPJyoT2hc9i8qo+WU54flh8sYdL01Pv0pgeI/xRdS+cr2nb+efcfjcYB89kxAekLWsC0yEbwE9MWXQt9HqgEGxdM=
X-Received: by 2002:a9d:564:: with SMTP id 91mr20466217otw.250.1590395500493;
 Mon, 25 May 2020 01:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200522234832.954484-1-robh@kernel.org> <20200522234832.954484-13-robh@kernel.org>
In-Reply-To: <20200522234832.954484-13-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 May 2020 10:31:29 +0200
Message-ID: <CAMuHMdX1QCfcxPzpTOEJXYfeAo3=LzuEQxCNFn9VQJa8hN4QxQ@mail.gmail.com>
Subject: Re: [PATCH 12/15] PCI: rcar: Use pci_host_probe() to register host
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Sat, May 23, 2020 at 1:50 AM Rob Herring <robh@kernel.org> wrote:
> The rcar host driver does the same host registration and bus scanning
> calls as pci_host_probe, so let's use it instead.
>
> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Thanks for your patch!

Note that this does have 2 side effects: the "linux,pci-probe-only" DT
property and the "pcie_scan_all" kernel command line option are now taken
into account.

Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
