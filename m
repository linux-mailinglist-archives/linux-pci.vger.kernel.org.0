Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875842EADF0
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 16:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbhAEPKN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 10:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbhAEPKN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jan 2021 10:10:13 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3578DC061574;
        Tue,  5 Jan 2021 07:09:33 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t22so18515968pfl.3;
        Tue, 05 Jan 2021 07:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B59L1dFJQpmm6U2tlwyxFjjl6hJUIu0OW27SvrE0oos=;
        b=oyOckUZXtx9AQwQBWUKccCcj191MuBzPQolSutSz9Y0Ul6GN0HMi1jPI/YhgvLMVcC
         roCrsWzfLsPny8VDJ4eMsf5jIy1/RHJZtLO1jGQvr8yvrUrvT7O+trHihvOFEufE3feN
         +xcEm8yyOSxtcRzUQ/WVN56XdjvXE+7a7IF/VH4Iav5Y6si4+D8vXRqpg/0XUCaHeoSi
         xvs5ACLF2pQUuF82kYz3VJqUzlzUv/MEaDEa3TVOpLRZ2y4r7m7P439pEmWDQh4kems2
         pI+Yf7F3mill4iq22IrKtL5YDQW8m0DKVONOfQubm/kScpHP78doSKJCBcrIHKxcwQ0s
         PXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B59L1dFJQpmm6U2tlwyxFjjl6hJUIu0OW27SvrE0oos=;
        b=QPFdZP4PFXel36OxqWfrcXXiboDBVVf9p/eAc/xh/OYE3u8CT4jylGLkm8VPbYHsVx
         NXccqNphK5H1ZuZAIZcs5j5gU07x0n3GAoVkzCxO2CdnoRRJgdQEu4TYek/EW4SG4oZc
         M3EsCe5r/7lTTsIF345PMQBN7cN9p0DLQLxarGWkPlAwQxHr6u1IF3XlkF/blNek6/QV
         ZCbZ+jafOghpZCG0fWVEa12gXmo0hW0idY1//q4+uFu/7S9vQ66sF5Y6yML1hLy95xkJ
         HahIQWrgA0H8GLvyetGEZeLJ0gXzcNITXZiASpp9lTXRMD4bKDUsT3mXA+v8+jZf1VZT
         BINA==
X-Gm-Message-State: AOAM533Nojtcc8PascuM2OiIDjJjnVg+V66q1McR1E+VZfidGPQr5qvg
        XFBSvraDJoxi1ZvKib7HSg8pwvCj+ZpccUtXyDg=
X-Google-Smtp-Source: ABdhPJwfp6jodFZyv1Neb9BHMx5OCcTv9aS6Lx3BAZWVHMmeKBXVbLxSxZ012O4y0PyTpRqMolmxj+eTfkMAL9APlp8=
X-Received: by 2002:a62:528c:0:b029:19e:4a39:d9ea with SMTP id
 g134-20020a62528c0000b029019e4a39d9eamr65120pfb.20.1609859372655; Tue, 05 Jan
 2021 07:09:32 -0800 (PST)
MIME-Version: 1.0
References: <20201130211145.3012-1-james.quinlan@broadcom.com>
 <20201130211145.3012-2-james.quinlan@broadcom.com> <20201209140122.GA331678@robh.at.kernel.org>
 <CANCKTBsFALwF8Hy-=orH8D-nd-qyXqFDopATmKCvbqPbUTC7Sw@mail.gmail.com> <20210105140128.GC4487@sirena.org.uk>
In-Reply-To: <20210105140128.GC4487@sirena.org.uk>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Tue, 5 Jan 2021 10:09:21 -0500
Message-ID: <CANCKTBtNgyBTNwwtbtMkR9nFwq+AZyAZmGX9XXfhwf27zwjG_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
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

On Tue, Jan 5, 2021 at 9:01 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jan 04, 2021 at 05:12:11PM -0500, Jim Quinlan wrote:
>
> > For us, the supplies are for the EP chip's power.  We have the PCIe
> > controller turning them "on" for power-on/resume and "off" for
> > power-off/suspend.  We need the "xxx-supply" property in the
> > controller's DT node because of the chicken-and-egg situation: if the
> > property was in the EP's DT node, the RC  will never discover the EP
> > to see that there is a regulator to turn on.   We would be happy with
> > a single supply name, something like "ep-power".  We would be ecstatic
> > to have two (ep0-power, ep1-power).
>
> Why can't the controller look at the nodes describing devices for
> standard properties?
Hi Mark,

It just feels wrong for the driver (RC) of one DT node to be acting on
a property of another driver's (EP) node, even though it is a subnode.
There is also the possibility of the EP driver acting upon the
property simultaneously; we don't really have control of what EP
device and drivers are paired with our SOCs.
In addition, this just pushes the binding name issue down a level --
what should these power supplies be called?  They are not slot power
supplies.  Can the  Broadcom STB PCIe RC driver's binding document
specify and define the properties of EP sub-nodes?

Regards,
Jim Quinlan
Broadcom STB
