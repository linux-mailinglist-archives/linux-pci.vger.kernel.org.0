Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF32B3FB9A0
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 18:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbhH3QBP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 12:01:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237679AbhH3QBP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 12:01:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C3A260F5B;
        Mon, 30 Aug 2021 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630339221;
        bh=z1IEwvfhSjn+56QDeFtNIaSWN2krwLg0dt1UipTWb2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UnnV9s6rIAlqcfmIz9hEBA3/T4ygKXfYYR+Vpr7lbBdHsqJg5muv0OUd3yvmFXM4K
         krNBDm5lpImNxlD+HONTXvBdY8M+5HrlOfqLcIluZHOQBhzbZBDBXFtuH7JkMtYOXb
         /drWK8kE5tiH/xtORwO/K6SJEKdMlncCTDFlmLPOcXu+pbrLfpA/au+keGrKpm7t2c
         6pLIEWtUi55syXW5A0vRHklTeTp8dTgfAZvbPmmj4zY87lxcWKAkGWtKQUgRFMINk5
         ygEtF0rr0EJHcoX+sZuz+NgflJOeIY7RQeHOQxGN6qqbkajtszdJXqul8Qj75dMF+8
         F8Mqjp7rashzQ==
Received: by mail-ej1-f46.google.com with SMTP id h9so32218326ejs.4;
        Mon, 30 Aug 2021 09:00:21 -0700 (PDT)
X-Gm-Message-State: AOAM530Px5YmYdvSMoPUCj90+zsxxwx2pgozw18rvJDKNIxnw2sWySYn
        vx+53mMyF2qeU9/AefBFk3piqMlZ1YOTgzZUbA==
X-Google-Smtp-Source: ABdhPJwctdgaXMfxL0trVc6OLfq0ZI52SZQZ5BEq3QBJ0wZCkNN08fupxNdlfT0sGAqk9wGhVeudcv+VhfmISXJxI2Y=
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr25265053ejb.108.1630339220028;
 Mon, 30 Aug 2021 09:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210811083830.784065-1-nobuhiro1.iwamatsu@toshiba.co.jp> <162998285902.30814.11206633831020646086.b4-ty@arm.com>
In-Reply-To: <162998285902.30814.11206633831020646086.b4-ty@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 30 Aug 2021 11:00:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK=e4cRHXV=ptFTrtt995arOjhNPmTJK8hWg-aDkU4dpQ@mail.gmail.com>
Message-ID: <CAL_JsqK=e4cRHXV=ptFTrtt995arOjhNPmTJK8hWg-aDkU4dpQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Visconti: Add Toshiba Visconti PCIe host
 controller driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 26, 2021 at 8:01 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, 11 Aug 2021 17:38:27 +0900, Nobuhiro Iwamatsu wrote:
> > This series is the PCIe driver for Toshiba's ARM SoC, Visconti[0].
> > This provides DT binding documentation, device driver, MAINTAINER files.
> >
> > Best regards,
> >   Nobuhiro
> >
> > [0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html
> >
> > [...]
>
> Applied to pci/dwc, thanks!
>
> [1/3] dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
>       https://git.kernel.org/lpieralisi/pci/c/a655ce4000

This is already in my tree due to the DW schema conversion.

Rob
