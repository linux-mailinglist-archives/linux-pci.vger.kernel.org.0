Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B21450672
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 15:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhKOOTN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 09:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhKOOSB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 09:18:01 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8D4C061714;
        Mon, 15 Nov 2021 06:15:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x15so72632949edv.1;
        Mon, 15 Nov 2021 06:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t3IGB38yNIMvvVAHrdjMQr2b/VUai/id3/Vj+OgaAcQ=;
        b=aPWxXxNcDn2tOT6fqzeOq9XAJSCvMRYfpRBv90Zv1Rnc2xvVoid6Zy581p3F4QyAVg
         7oBnfq/JGGAITFxzWavXcIBtXQyH/D71zSVCXDyWQBA/fIQS1LLiCnn1Ueyms2N7owc3
         pHJaB5PL1grvdpFDYyG/5QsfLzJ0Qy8ycXyAyd87CsotDYXRwu1cJCJ68EpJza3H4SiK
         tXMsxW+2L4JHRHJknYpU2xuOdED6jREj0tVo1xYzSzCauJJSDvyyJJq2+glQ8KfUALoJ
         Hr1K9XT2oRmV7QlEgYCJ8dgzs6uAt4uWtk+zHgenjVq240X1tGWjxm2CxMoUf9MpU2NT
         fYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t3IGB38yNIMvvVAHrdjMQr2b/VUai/id3/Vj+OgaAcQ=;
        b=EYoymDa8hqrUQFcOJU4VrflXy89N3eUplgDPuWoqiSZLD+S1ez0kwkOxqrQ5ifLTnN
         d3fRlKWJv65i8boYy2g6ztxJ4rO9CPYdg7VvHML6JEo01GzeKRy1LKMU12qihRRkKDle
         HvEYH8x4JrcZEpGt0SaSQV7JD9xVTTArJ2f5JupM8U6I+tEP+i98yYYGCIi+ugqIBbfg
         GdmY+k8Wqgksx0qx2a+4bIlVFGpAM0Ly2EXjg4Wr2Fj1fjfveIxXdcRt10miR5bYkMhR
         lnzQ1eXaKwynZEuOQzyr1xGxjEHZoUdtIAnLRDkwkRxvFk1342xcLqiw2JGAzA/P/HOU
         IzGA==
X-Gm-Message-State: AOAM530dBejOvxyNRqU3ML1cHZIrxqvZIkbmiEpL51zC7bRsIS0b5xVU
        WuTlb4mSJ9UN/TRJxQgQrSuoWErCj5K8F9UfNxw=
X-Google-Smtp-Source: ABdhPJwnmDU1Cgwynrgfx6JVeigLWOC2f9G2oU962i2+072e1fw6/NK+SHGTPwurR8Kv7xwrKaJ+VTzT2sQncnLfgrU=
X-Received: by 2002:aa7:cb09:: with SMTP id s9mr55677908edt.359.1636985703391;
 Mon, 15 Nov 2021 06:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com> <94d3f4e5-a698-134c-8264-55d31d3eafa6@arm.com>
In-Reply-To: <94d3f4e5-a698-134c-8264-55d31d3eafa6@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Nov 2021 16:14:21 +0200
Message-ID: <CAHp75VeJ8ZiD=qQVfeahUjGZduFRJJ5683hn8f4810JYEzsCyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for
 internal use only
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 15, 2021 at 4:01 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2021-11-15 11:20, Andy Shevchenko wrote:
> > Use BIT() as __GENMASK() is for internal use only. The rationale
> > of switching to BIT() is to provide better generated code. The
> > GENMASK() against non-constant numbers may produce an ugly assembler
> > code. On contrary the BIT() is simply converted to corresponding shift
> > operation.
>
> FWIW, If you care about code quality and want the compiler to do the
> obvious thing, why not specify it as the obvious thing:
>
>         u32 val = ~0 << msi->legacy_shift;

Obvious and buggy (from the C standard point of view)? :-)

> Personally I don't think that abusing BIT() in the context of setting
> multiple bits is any better than abusing __GENMASK()...

No, BIT() is not abused here, but __GENMASK().

After all it's up to you, folks, consider that as a bug report.

-- 
With Best Regards,
Andy Shevchenko
