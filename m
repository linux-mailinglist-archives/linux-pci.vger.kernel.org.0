Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D192B0AA4
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 17:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgKLQqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 11:46:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbgKLQqg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Nov 2020 11:46:36 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEAC922201;
        Thu, 12 Nov 2020 16:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605199595;
        bh=LLx0akF5qtEiY5VMQSlszIbWAgpb7UXLGfsyXCRK7Dk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jfNQTQ0hZkzr+YiJs7bsZrYRl7397sjcqsp9yCooKZ2UJqzJHhIozdq1Fg5EsJZ/n
         9UksIUQQKLeTPp/Ugn927wly+H3VPFz3bkcKo6vheC3y4RlOXk5vP7VwtMWyukkVNw
         RUttv7U/0u6I8GHmbbOg4v/PkVLNnT8q6GuxSEPw=
Received: by mail-qt1-f175.google.com with SMTP id z3so824217qtw.9;
        Thu, 12 Nov 2020 08:46:34 -0800 (PST)
X-Gm-Message-State: AOAM531T37UqKnwaGl07ueuWgHSeAMtq2G2DrNZHzg74PnZlu0Q7F22Z
        XGM8O7hX7BSPqCe1CuisDnzLPDQQvRkv3jSaJg==
X-Google-Smtp-Source: ABdhPJxNTJyWMf6+brsvjbuORMB9At5nr5f9ABeu/u5b5DtZBs4UEdwvX6ofCVpyFPU2RsM96RURemzIhbtaljLRQts=
X-Received: by 2002:aed:2aa5:: with SMTP id t34mr13728qtd.31.1605199593992;
 Thu, 12 Nov 2020 08:46:33 -0800 (PST)
MIME-Version: 1.0
References: <20201109170409.4498-1-kishon@ti.com> <20201109170409.4498-2-kishon@ti.com>
 <20201111212857.GA2059063@bogus> <f6d1b886-5c78-842c-c33c-16b5b9325130@ti.com>
In-Reply-To: <f6d1b886-5c78-842c-c33c-16b5b9325130@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Nov 2020 10:46:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com>
Message-ID: <CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: mfd: ti,j721e-system-controller.yaml:
 Document "syscon"
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 11, 2020 at 11:25 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On 12/11/20 2:58 am, Rob Herring wrote:
> > On Mon, Nov 09, 2020 at 10:34:03PM +0530, Kishon Vijay Abraham I wrote:
> >> Add binding documentation for "syscon" which should be a subnode of
> >> the system controller (scm-conf).
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  .../mfd/ti,j721e-system-controller.yaml       | 40 +++++++++++++++++++
> >>  1 file changed, 40 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> >> index 19fcf59fd2fe..0b115b707ab2 100644
> >> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> >> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> >> @@ -50,6 +50,38 @@ patternProperties:
> >>        specified in
> >>        Documentation/devicetree/bindings/mux/reg-mux.txt
> >>
> >> +  "^syscon@[0-9a-f]+$":
> >> +    type: object
> >> +    description: |
> >
> > Don't need '|' if there's no formatting.
>
> Okay, will fix this.
> >
> >> +      This is the system controller configuration required to configure PCIe
> >> +      mode, lane width and speed.
> >> +
> >> +    properties:
> >> +      compatible:
> >> +        items:
> >> +          - enum:
> >> +              - ti,j721e-system-controller
> >> +          - const: syscon
> >> +          - const: simple-mfd
> >
> > Humm, then what are this node's sub-nodes? And the same compatible as
> > the parent?
> >
>
> This node doesn't have sub-nodes.
>
> So one is the parent syscon node which has the entire system control
> region and then sub-nodes for each of the modules. In this case the PCIe
> in system control has only one 4 byte register that has to be configured.
>
> Both the parent node and sub-node are syscon, so given the same
> compatible for both.

'syscon' is just a hint. It doesn't define what any h/w is. IMO, we
never should have added it.

A compatible defines what the programming interface is for the node.
This one should only ever appear more than once if you have multiple
instances of the same block. So different registers, different
compatible. What you have here is just completely broken.

I don't think you even need a child node here. Just have PCIe node
point to the parent with an offset arg.

Rob
