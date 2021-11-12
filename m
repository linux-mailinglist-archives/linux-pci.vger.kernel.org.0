Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA1644EC92
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 19:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhKLS2O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 13:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbhKLS2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Nov 2021 13:28:14 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC4EC061766;
        Fri, 12 Nov 2021 10:25:22 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id bk14so19449137oib.7;
        Fri, 12 Nov 2021 10:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sa0jBA3wpvakD7viFQ8ToAySOGD0WqRf4octMEbtih0=;
        b=kjSyXDtPvbAlccyL7gHYWEEa6qBv/xCU7kJ4Vv0o73t3sx8ohpKywpXvTiDcvx5Ouw
         Rd1O3C5asrJ2KJT+98X41ucEGMX9o1+PxoBIpwrikCIooZNkQwo5SMCuN5ao2zywCM7N
         KGoV+KD21T2A1GH0a4BxgvDDtPkpmjhpMs1oBURvtRMTy0ssMSFrbQYr3pvYFlwbUoK+
         3dZ0C7C9YqmTaxwUDP+mCIkLEa2/SV4XvGT0RSsxqxofCSAmuhoU3U7/KsEQdTpuRHOF
         Fx672TWwXdqprhXnVps7RLUPQd4KBVA6UBVc/B8N3U6MOJ7teH7wxz5RhV9J6LcFW6HX
         FVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sa0jBA3wpvakD7viFQ8ToAySOGD0WqRf4octMEbtih0=;
        b=zLS54n9hGbo2BBgJ4Cww3QHK0yl7frND8+rlAeRK1Bk+UVqVpgknLO+34qJtlUrH0D
         3+0Bi3z3+5UPXe6rNCQSwyF5Fxhh5RdxbbnTP2C/4QkBPj5942PyYa9nAILs/n4K0vg4
         An3sJolFkWmrlpECLyS9xPXs3UP5K+LLXUqETHUvlBmvYAxZsL/1IzQ4pzwvGCKICFiL
         RGcZvz/PiqV8+QCxAZPRGymnWmUTjR2bOviBv5sB/YkWeqXZN8+h0WN4z13Z5GybRaRe
         zFpwANTzNvgoQvnHWQpiFNn1gBwJWoaVyMyoOktdixH2lX6SVudgGmVlSCchX6vboQ52
         /DAw==
X-Gm-Message-State: AOAM532ixGZdrD93Je4H5wbZC6cTu1cukDcWRQy90D66mvoUW+PuzWSx
        CcDLfTmLY6GIIj/JA2C3YP3nJ2eQKcXqlzLwYSs=
X-Google-Smtp-Source: ABdhPJx+m1O3ZfKBTW5vP7GJjq+TTjrXGPwdtitmdl2plac2LYfIgefS40oau5QEX2T48Fa4J+BgWorNYStSrHLKTaU=
X-Received: by 2002:a54:4707:: with SMTP id k7mr27139073oik.163.1636741522427;
 Fri, 12 Nov 2021 10:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20211110221456.11977-4-jim2101024@gmail.com> <20211111221714.GA1354700@bhelgaas>
In-Reply-To: <20211111221714.GA1354700@bhelgaas>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Fri, 12 Nov 2021 13:25:11 -0500
Message-ID: <CANCKTBun0MCiH5QWBMQqP+pxAN=+dX=ziB1ga39kdr5CmK=Gfw@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 11, 2021 at 5:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Nov 10, 2021 at 05:14:43PM -0500, Jim Quinlan wrote:
> > Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> > allows optional regulators to be attached and controlled by the PCIe RC
> > driver.  That being said, this driver searches in the DT subnode (the EP
> > node, eg pci-ep@0,0) for the regulator property.
> >
> > The use of a regulator property in the pcie EP subnode such as
> > "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> > file at
> >
> > https://github.com/devicetree-org/dt-schema/pull/63
>
> Can you use a lore URL here?  github.com is sort of outside the Linux
> ecosystem and this link is more likely to remain useful if it's to
> something in kernel.org.
Hi Bjorn,
I'm afraid I don't know how or if  this github repo transfers
information to Linux.  RobH, what should I be doing here?
>
> The subject says what this patch does, but the commit log doesn't.
> It's OK to repeat the subject in the commit log if that's what makes
> the most sense.
Got it.
Thanks,
Jim Quinlan
Broadcom STB
