Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F31416255
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 17:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhIWPsf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 11:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241995AbhIWPsU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Sep 2021 11:48:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B531E611C6;
        Thu, 23 Sep 2021 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632411911;
        bh=tRebfobguUkhm+TtIpFBE2sYYMQgs5iL2mj88sXA5Qk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KNQt8u73VmwldWhvgVep8ELnoN0JwHSmjdnNw3TO4lty2kbXYLj1tyOSMpWaXDTWX
         94Fy7aWT+k0fV8rV8a1i+Ompwj4gGr69zEsSC4F6AG/Td5BMA6eL/4UX2ZxddlQ7Oe
         lU5Lxt0eZCTLuIqHSd0/uL6jfr1xYxwxe8BtOLEMmGB1snjVl0hp8exyUhOmv2Pvt5
         RmZag4AwrRNRZ95FpXJNxQQgBGt/SXr8XieXv6vg6BzQcreAxzXYF5/Db94+Vc9Wp1
         282zfY230xmlJ1tpsleDPS24p3eO70gdHmtAbXmKo8PZT8Al2LNW1LlXKKqrPSBaoq
         WxoIVH4xQpEyA==
Received: by mail-ej1-f52.google.com with SMTP id x11so116391ejv.0;
        Thu, 23 Sep 2021 08:45:11 -0700 (PDT)
X-Gm-Message-State: AOAM530vYcgjYdszZ/7VmDVGH9odWUJZZfD7t9uEydCwgWFqNhwYmrD5
        Zau5ImaBLaWQELWaepJ1MALuH6r0W8c8P3CqHQ==
X-Google-Smtp-Source: ABdhPJzW9Q+u1kOp8EsMy8AIW1G+psMo8rKJnH3nfvU4j/Fig0hxqVDbPZLyfZj+snYbimSLZFC2ugeiN1nbnXj1830=
X-Received: by 2002:a17:907:33ce:: with SMTP id zk14mr5810785ejb.84.1632411910279;
 Thu, 23 Sep 2021 08:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210804132912.30685-1-kishon@ti.com> <20210804132912.30685-2-kishon@ti.com>
 <YRapMFNb63MSPJ1E@robh.at.kernel.org> <d0f83129-4c9a-d9ff-380a-cab37a86e29e@ti.com>
 <220bbd3c-304a-ba6a-d20e-634f23f4eed2@ti.com>
In-Reply-To: <220bbd3c-304a-ba6a-d20e-634f23f4eed2@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 23 Sep 2021 10:44:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKTn8G1HiyBySOY-_SvX0NKzbZnpykDAjCpnEdb7GM6Sg@mail.gmail.com>
Message-ID: <CAL_JsqKTn8G1HiyBySOY-_SvX0NKzbZnpykDAjCpnEdb7GM6Sg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: ti,j721e: Add bindings to
 specify legacy interrupts
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 22, 2021 at 11:33 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On 18/08/21 7:28 pm, Kishon Vijay Abraham I wrote:
> > Hi Rob,
> >
> > On 13/08/21 10:47 pm, Rob Herring wrote:
> >> On Wed, Aug 04, 2021 at 06:59:10PM +0530, Kishon Vijay Abraham I wrote:
> >>> Add bindings to specify interrupt controller for legacy interrupts.
> >>>
> >>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >>> ---
> >>>  .../bindings/pci/ti,j721e-pci-host.yaml           | 15 +++++++++++++++
> >>>  1 file changed, 15 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> >>> index cc900202df29..f461d7b4c0cc 100644
> >>> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> >>> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> >>> @@ -74,6 +74,11 @@ properties:
> >>>
> >>>    msi-map: true
> >>>
> >>> +patternProperties:
> >>> +  "interrupt-controller":
> >>
> >> Not a pattern unless you meant for foo-interrupt-controller-bar to be
> >> valid.
> >>
> >> Anything is allowed in the node?
> >
> > It's same as whatever is defined in schemas/interrupt-controller.yaml,
> > just that it should be a subnode of pcie@. Should I add whatever is
> > present in schemas/interrupt-controller.yaml here?
>
> Can you suggest how to include this?

You don't. List the properties you are using. You need to define the
#interrupt-cells value for example. I'm sure there's already examples
in the tree doing this same child node.

Rob
