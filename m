Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61C92D13C7
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 15:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgLGObe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 09:31:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgLGObd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 09:31:33 -0500
X-Gm-Message-State: AOAM533GKEFmLpk1NWPcloKkZ0Xc+5dXg8uicLBVNaYBAbbI9ptIcn+N
        /mJuwDUH5nnb+BK4lV22KQ3EkbUcMRvmlS14ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607351453;
        bh=s0BKc1MX4tMUWFOMJEiaT3fmxMlBhXypt5B3nf9VsX8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rxsrRlBo0pCQQzriupTDwhPcF7gqp3DnDFK+Dxja4pgc8MvnmWAC5z6++C01gObvH
         rdZN98Fqd7cQbKaGiEhc54yYeKJXmU1AyR/XytEuh8x/5V2KMMSJgpH14Hca/so86T
         I/x6IUzj3fwHq8RufxEagmPf3PJlMP1ifdNP6lrx/XDayIm3X6Yz+Mh+SS8nF9ntc9
         HSAbbiHUIdcUw0cKh5T9JAE0r6FsI3AASg9YnaZLn1q+hSDAx8p0ysBRfZMeFTtdKi
         h28yAPPBNx9P1f+66aLS9UpdxEJXEKM4wRPgVHHw7znz00mOxzbixwAxbAVr97DV0J
         gzhuR7hU78MUw==
X-Google-Smtp-Source: ABdhPJzPVB0hht0v+UqlgKB1RJvp5j98oTOE/jVV5sqaTYTPtRk+nf9lXkc6g3Hm52HxNrQRfu2l9vVgOks1x3Sxn+Q=
X-Received: by 2002:a17:906:d784:: with SMTP id pj4mr14577051ejb.360.1607351451511;
 Mon, 07 Dec 2020 06:30:51 -0800 (PST)
MIME-Version: 1.0
References: <20201204075117.10430-1-kishon@ti.com> <20201204075117.10430-3-kishon@ti.com>
In-Reply-To: <20201204075117.10430-3-kishon@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 7 Dec 2020 08:30:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKQwx2qKJb5eAsutdHH5DevC+XH33yXrCBWE+OCrrQFYg@mail.gmail.com>
Message-ID: <CAL_JsqKQwx2qKJb5eAsutdHH5DevC+XH33yXrCBWE+OCrrQFYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: j721e: Get offset within "syscon" from
 "ti,syscon-pcie-ctrl" phandle arg
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 4, 2020 at 1:52 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Get "syscon" pcie_ctrl offset from the argument of "ti,syscon-pcie-ctrl"
> phandle. Previously a subnode to "syscon" node was added which has the
> exact memory mapped address of pcie_ctrl but now the offset of pcie_ctrl
> within "syscon" is now being passed as argument to "ti,syscon-pcie-ctrl"
> phandle.
>
> If the offset is not provided in "ti,syscon-pcie-ctrl", the
> full memory mapped address of pcie_ctrl is used in order to maintain old
> DT compatibility.
>
> This change is as discussed in [1]
>
> [1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c | 28 +++++++++++++++-------
>  1 file changed, 19 insertions(+), 9 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
