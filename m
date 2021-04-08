Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB0A358A5E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 18:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhDHQ6e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 12:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhDHQ6c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 12:58:32 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00E3C061760;
        Thu,  8 Apr 2021 09:58:18 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso2970514otq.3;
        Thu, 08 Apr 2021 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dLfL6NGDf1LKpWbeCzWAP7jc5FPnwrsHYlt5iXOvOjo=;
        b=BrrTo5jt3fBAewJtfcCj0Dmjc88uaRVXQ+FSh8mXnVcc3MoNZKkk6tUbzUs9/3bnRY
         XMgEePkfUOtiWlD9KMMLS6L14O/zMsTN8x9guGoPoYlAXrPYmOGkgl9fEMFTVHkiXCS8
         O9Cd4pA83aq9m4AB7lwjpgvi8q9Z6ya8Ek5MR1w04qzXHrS6bXfs4gv+XjDsqjtJuzX8
         ytTnEpJKLI8FBNgKG9b/N45eQQru1mxhOZTupz6uI2Pd20mz44FXBDDo5BI1S7Bpz6lc
         tZW054A2vnCkf5VKN3eNUHemoLHvDhSSlH5CErsG8vCIstDIohtlwmTQEHWDcoc531eh
         4lcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLfL6NGDf1LKpWbeCzWAP7jc5FPnwrsHYlt5iXOvOjo=;
        b=IQeP63bFzajyxDXUpwZYY53o16V8HmNDaARM/+mYuwbTIfL/HBLTP9zRud68QB7UKS
         XrlrvhcEivWRg5Dlhcy78BH2vzeRZjvbjt1U8gYfBX4lFWuL1XyI3vkc6YHsJVPgBDKc
         xEXMeVTCHejJTywmCQReAO6qMuj1P/MkeTQafnDw5cmOjdtApOFpalrIsUYqqJ3JpsuZ
         dSs6IqyTEuIE6a0EGD98BSixg3Wo8jRF0sh9pSq6UK+7KrAAKbS2i9Lh9mx8uyJ8bRIF
         taGvPbmVkIgWms8rMjJqs74ZDCFhNVy5jkCplBTZR9r0rKT3Zo3aj5yTnO15pv48pvJv
         NQTw==
X-Gm-Message-State: AOAM531k4nDGwBeIP0rsoPfrwa87ZRG+HTPcqMMZ460NjByJeYIi5M+b
        qTBidmlGKfgD0qwqy1h7ITqq5XFQOn9QZRJBFkE=
X-Google-Smtp-Source: ABdhPJxLWNL9rcfGgrbFaxzZ6Oxk0MHa2Ab+PtbdE+BZlANacJomJj5MGsmfDWVX59T8dm/2ATpOk3vgnlaUtDmlHA8=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr8683363otg.17.1617901098305;
 Thu, 08 Apr 2021 09:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210401212148.47033-1-jim2101024@gmail.com> <20210401212148.47033-3-jim2101024@gmail.com>
 <20210406164708.GM6443@sirena.org.uk> <CANCKTBsiujTkOdh60etBqF_hE8exg6m9TDxkGHVVAGVS2SFCcQ@mail.gmail.com>
 <20210406173211.GP6443@sirena.org.uk> <CANCKTBv63b4bGepZbDp1wmFrOeddiDikoXbheMjHhbguAbR2sA@mail.gmail.com>
 <20210408162016.GA1556444@robh.at.kernel.org>
In-Reply-To: <20210408162016.GA1556444@robh.at.kernel.org>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Thu, 8 Apr 2021 12:58:05 -0400
Message-ID: <CANCKTBv_g9FPcBCOi-JxEDrrQWFhNcdsfDATFBydwnLiebj-HA@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: PCI: Add bindings for Brcmstb
 endpoint device voltage regulators
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
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

On Thu, Apr 8, 2021 at 12:20 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Apr 06, 2021 at 02:25:49PM -0400, Jim Quinlan wrote:
> > On Tue, Apr 6, 2021 at 1:32 PM Mark Brown <broonie@kernel.org> wrote:
> > >
> > > On Tue, Apr 06, 2021 at 01:26:51PM -0400, Jim Quinlan wrote:
> > > > On Tue, Apr 6, 2021 at 12:47 PM Mark Brown <broonie@kernel.org> wrote:
> > >
> > > > > No great problem with having these in the controller node (assming it
> > > > > accurately describes the hardware) but I do think we ought to also be
> > > > > able to describe these per slot.
>
> PCIe is effectively point to point, so there's only 1 slot unless
> there's a PCIe switch in the middle. If that's the case, then it's all
> more complicated.
>
> > > > Can you explain what you think that would look like in the DT?
> > >
> > > I *think* that's just some properties on the nodes for the endpoints,
> > > note that the driver could just ignore them for now.  Not sure where or
> > > if we document any extensions but child nodes are in section 4 of the
> > > v2.1 PCI bus binding.
> >
> > Hi Mark,
> >
> > I'm a little confused -- here is how I remember the chronology of the
> > "DT bindings" commit reviews, please correct me if I'm wrong:
> >
> > o JimQ submitted a pullreq for using voltage regulators in the same
> > style as the existing "rockport" PCIe driver.
> > o After some deliberation, RobH preferred that the voltage regulators
> > should go into the PCIe subnode device's DT node.
>
> IIRC, that's because you said there isn't a standard slot.
Admittedly, I'm not exactly sure what you mean by a "standard slot".
Our PCIIe HW does not support  hotplug or have a presence bit or
anything like that.  Our root complex has one port; it can only
directly connect to a single switch or endpoint. This connection shows
up as slot0.  The voltage regulator(s) involved depend on a GPIO that
turns the power  on/off for the connected device/chip.  The gpio pin
can vary from board to board but this is easily handled in our DT.
Some boards have regulators that are always on and not associated with
a GPIO pin -- these have no representation in our DT.

Regards,
Jim


>
> > o JimQ put the voltage regulators in the subnode device's DT node.
> > o MarkB didn't like the fact that the code did a global search for the
> > regulator since it could not provide the owning struct device* handle.
> > o RobH relented, and said that if it is just two specific and standard
> > voltage regulators, perhaps they can go in the parent DT node after
> > all.
> > o JimQ put the regulators back in the PCIe node.
> > o MarkB now wants the regulators to go back into the child node again?
> >
> > Folks, please advise.
> >
> > Regards,
> > Jim Quinlan
> > Broadcom STB
