Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0294834EDB0
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 18:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhC3QYF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 12:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbhC3QXr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 12:23:47 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F53C061574;
        Tue, 30 Mar 2021 09:23:47 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso16081487ott.13;
        Tue, 30 Mar 2021 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8k/R3Z1NvB0DXO6K99UF1wGAXsYisfDguT4FZRHCp1c=;
        b=RJEpI15QZsXpm89FHqBATwZuAP+vcibkzS4tIbzICBo2ZMT3O03knPvcfV41vkqE8J
         9sV1CP4KLKCd44GRPWr3Ftfy6+YmSTtnXIPIPPftUKpAGJxH+CMilF7utCn8ENBC/Exa
         46GfqszzK9aG4SyoLzDjMlHkqoPxIcKaS0y2Tvyv3FJtN/ypakskg+5TUW7hFkIASYjr
         b8WDtYNmTzpfpqboelnuQ+GsY/o/spXtF4u8WJYfJx9DrNyRhCr968qSThsp1xKZZfWx
         d0J9sre6DnG3zG5fTTXXKAvoPWBfk/svvJEd+qn5vCWw7+x8Rkx0WKU135z2n3Zsks9s
         jdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8k/R3Z1NvB0DXO6K99UF1wGAXsYisfDguT4FZRHCp1c=;
        b=KkS5h9MlAu7BeWxKEELLTLXtno2fcjPgqnOV+sv0lSX0gkWItrf9cMvkPU/1b04WJL
         fxTTTxOAUpukGq4okY4hojcvndLGomCik0StaedjaMeuiuqZBx/U3TAqL35VzWS7nMSN
         CSFpzZxJKLu9YWsMWsh9+lThSV9Ys/FUAXNajXSrki8Fte1c/db2L3oSFEZPBFfalKsd
         nbP3lS7+7YoFt0G8Cfbo+/jLZRShc+wSYnbblesdqSKcj4oaNE0LwF3Mtgfd4/A0ibqo
         0znEM2sCtkoO0kWPC/AZpO/FinEHylon3l/VTSbrT3W1FnTMLfwbuc5EoxnXTSZT8avv
         ZTWw==
X-Gm-Message-State: AOAM5316Og7SBhCvpfIdEy6u5a+Lc5h4cb4ZFZhlMFnupcIrD3f++8t9
        0i5u/0y22jbjVSLAF92j5qucdG5cSLCeheiD9a4=
X-Google-Smtp-Source: ABdhPJxxDLiLh8bABF8yNOzeiW0symW5513NoaUkwy5zJnItSU9Kwjrw867zd1DAqcnFUdeY0dHqzy7bq/Jq3XuSe90=
X-Received: by 2002:a05:6830:14a:: with SMTP id j10mr28568308otp.143.1617121427121;
 Tue, 30 Mar 2021 09:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210326191906.43567-1-jim2101024@gmail.com> <20210326191906.43567-2-jim2101024@gmail.com>
 <20210330150816.GA306420@robh.at.kernel.org> <20210330153023.GE4976@sirena.org.uk>
In-Reply-To: <20210330153023.GE4976@sirena.org.uk>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Tue, 30 Mar 2021 12:23:35 -0400
Message-ID: <CANCKTBvDdkLk0o4NboaOTZ26vfwJjPAfnXK3ay4v9E91G2gYOQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
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

On Tue, Mar 30, 2021 at 11:30 AM Mark Brown <broonie@kernel.org> wrote:
>10.22.8.121
> On Tue, Mar 30, 2021 at 10:08:16AM -0500, Rob Herring wrote:
> > On Fri, Mar 26, 2021 at 03:18:59PM -0400, Jim Quinlan wrote:
>
> > > +                    pcie-ep@0,0 {
> > > +                            reg = <0x0 0x0 0x0 0x0 0x0>;
> > > +                            compatible = "pci14e4,1688";
> > > +                            vpcie12v-supply: <&vreg12>;
>
> > For other cases, these properties are in the host bridge node. If these
> > are standard PCI rails, then I think that's where they belong unless we10.22.8.121
> > define slot nodes.
>
> For a soldered down part I'd expect we'd want both (if the host even
> cares) - for anything except a supply that I/O or something else shared
> is referenced off there's no great reason why it has to be physically
> the same supply going to every device on the bus so each device should
> be able to specify separately.
Our developer and reference boards frequently have Mini and half-mini
PCIe sockets (a few exceptions), whereas production boards are mostly
soldered down.

If I resubmit this pullreq  so that it  looks for "vpcie12v-supply"
and "vpcie3v3-supply" in the host node, will that be acceptable for
both of you?

Thanks,
Jim Quinlan
Broadcom STB
