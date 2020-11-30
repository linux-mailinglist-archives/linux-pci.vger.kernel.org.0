Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC9B2C8919
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 17:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgK3QNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 11:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgK3QNo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 11:13:44 -0500
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8EF22087C;
        Mon, 30 Nov 2020 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606752783;
        bh=wuan7nT2b3j/ysuAroybQAZQ8NB/ed1lLmOF9ZpUHhQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fdzM643DQwdapNgIL/8Foi9Rmb5HM+BBBgjOdQutwpztsTTQCu5+nxKdiLubyqXEU
         LW4ZNZFMrTA7AHxizzx8FkkCmdnl7tW+GPI7Obm1Ws6I2qqvd9g/KyoCec44zIarnQ
         ygy7FGFb53obaRZwHl2I/2tcwjVVFUJnjslrRUwU=
Received: by mail-ed1-f46.google.com with SMTP id l5so16871281edq.11;
        Mon, 30 Nov 2020 08:13:02 -0800 (PST)
X-Gm-Message-State: AOAM5324kHn43P7frKY/qU7i1xkHALflRkV4EXQnvnOj8aa16Imyfj74
        fzst/tMe+Pu3og+u6jQQ/u7QCyeXF/Ni6Xd65g==
X-Google-Smtp-Source: ABdhPJylQOreCp8QimYarFnXM0CzQZutwGrXF+ZC9QHOflV9bqRy//RSzC3ueRaJOgroSqkF2n7fEAmlFy9T4oMcBMk=
X-Received: by 2002:aa7:c816:: with SMTP id a22mr5805431edt.373.1606752781185;
 Mon, 30 Nov 2020 08:13:01 -0800 (PST)
MIME-Version: 1.0
References: <20201116173141.31873-1-kishon@ti.com> <20201116173141.31873-2-kishon@ti.com>
 <20201118211139.GA1815279@bogus> <1e9b0b56-a42d-bea0-704b-6209532b1abe@ti.com>
 <1ed82ab5-6171-108d-9b92-a18389044174@ti.com>
In-Reply-To: <1ed82ab5-6171-108d-9b92-a18389044174@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Nov 2020 09:12:49 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKWx2qSjEVFEC4vLASLonHhQfDbHnq+rTeEZ3F-g_LRKA@mail.gmail.com>
Message-ID: <CAL_JsqKWx2qSjEVFEC4vLASLonHhQfDbHnq+rTeEZ3F-g_LRKA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl"
 to take argument
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 26, 2020 at 5:53 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On 20/11/20 10:39 am, Kishon Vijay Abraham I wrote:
> > Hi Rob,
> >
> > On 19/11/20 2:41 am, Rob Herring wrote:
> >> On Mon, Nov 16, 2020 at 11:01:39PM +0530, Kishon Vijay Abraham I wrote:
> >>> Fix binding documentation of "ti,syscon-pcie-ctrl" to take phandle with
> >>> argument. The argument is the register offset within "syscon" used to
> >>> configure PCIe controller.
> >>>
> >>> Link: Link: http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
> >>
> >> Link: Link: ?
> >>
> >> AIUI, 'Link' is supposed to be a link to this patch. I guess more than 1
> >> Link would be okay though.
> >
> > Two Links was a typo, will fix it in the next revision. Nishanth as well
> > was asking about using "Link:" tag for a mailing list discussion.
> >
> > I started using it after Lorenzo had asked me to use Link tag for
> > mailing list discussion here sometime back.
> >
> > https://patchwork.kernel.org/project/linux-pci/patch/20171219083627.7904-1-kishon@ti.com/#21350261
> >
> >>
> >>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>> ---
> >>>  .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml     | 12 ++++++++----
> >>>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml   | 12 ++++++++----
> >>>  2 files changed, 16 insertions(+), 8 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> >>> index 3ae3e1a2d4b0..e9685c0bdc3e 100644
> >>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> >>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> >>> @@ -29,9 +29,13 @@ properties:
> >>>        - const: mem
> >>>
> >>>    ti,syscon-pcie-ctrl:
> >>> -    description: Phandle to the SYSCON entry required for configuring PCIe mode
> >>> -                 and link speed.
> >>> -    $ref: /schemas/types.yaml#/definitions/phandle
> >>> +    allOf:
> >>
> >> You no longer need allOf here.
> >
> > hmm, don't we need it for specifying phandle with fixed cells? FWIW, I
> > was referring
> >
> > https://github.com/devicetree-org/dt-schema/blob/master/test/schemas/good-example.yaml#L187
>
> Can you clarify this please?

We are now using json-schema v2019.09 syntax which doesn't ignore
keywords in addition to a $ref as draft7 and earlier did. The old way
with 'allOf' still works though. I just haven't updated the above test
cases.

Rob
