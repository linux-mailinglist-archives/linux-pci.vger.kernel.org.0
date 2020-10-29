Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F4029ED57
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 14:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgJ2No4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 09:44:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46030 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgJ2No4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 09:44:56 -0400
Received: by mail-oi1-f196.google.com with SMTP id j7so3185891oie.12;
        Thu, 29 Oct 2020 06:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReSkPF12MyEhlqUjtGao8LIpR44K1Tw5NKELj61FW4g=;
        b=L+v2t62rtUsGg2PqPq3b3d6Pqw5iyCM6+aEb3TPN+k4TZGWQ7pBgFDSafCnpWl4tZq
         1twinkfugbamTjiEBjlliDiltfaYS9wm+oXrif5mix0AhFK+cilBMI6IwAb4Z2T3ldDO
         Vk8oPpdwJ+aOxW2JdsmtMz2ZF6XV8WdvlkH9F7QQ3A9OSJoCqoGEc+LXJY4xeHWdd9sP
         ZTQVMMKdO8bfZIfw29+PIP4qKhjKb9v+vtAwNGI9dEe9F7LMNivYrUgp7c62L+sFwq+P
         FQI73T1ETnxFP+fy8c90IiX8yAR7w+tkOXJUQLdsSlx179uKl5nnAGms/sHYadZjZ9Rr
         ECbg==
X-Gm-Message-State: AOAM531gbWZbprQo5Uu0ktt66x9zigycT7uproljIGA9iASEQc26/flF
        1GcI+hr7J/lGfSce609VFyoQYVSu5JEOx59FFcQ=
X-Google-Smtp-Source: ABdhPJyqpn0W41sFWDO/6gczEdbFkpPfGH+buoe9CDdgEG/SHB8wG3k1heG4RwDDWgf7mp2xjGEovvehfcbVQ7iWTYI=
X-Received: by 2002:aca:c490:: with SMTP id u138mr3077334oif.54.1603979095586;
 Thu, 29 Oct 2020 06:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201023162008.967-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201023162008.967-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 29 Oct 2020 14:44:44 +0100
Message-ID: <CAMuHMdUL+f_6Fzcgjkx+9BJfjTGyCGfPmawwt06hihNZgypP+g@mail.gmail.com>
Subject: Re: [PATCH] PCI: pcie-rcar-host: Drop unused members from struct rcar_pcie_host
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 23, 2020 at 6:36 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Drop unused members dev and base from struct rcar_pcie_host.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
