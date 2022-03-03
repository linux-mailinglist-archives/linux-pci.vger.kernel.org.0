Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40354CC47F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 19:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiCCSBH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 13:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiCCSBG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 13:01:06 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE6E1A12A2
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 10:00:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hw13so12306072ejc.9
        for <linux-pci@vger.kernel.org>; Thu, 03 Mar 2022 10:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQxAlfCf+4Q9fzk9NVeztYNuUEiyzoj0uBtK+lVZrFU=;
        b=jv5FQiXDr95KdVjIHXEkI8PwJ89e3H+u2EyeQXb4Yj5Oc+NAk/x7LPZBxO4QzUY7qj
         zdISyTdE7B/ywPJkUPzV5/R7yBzhHoAeDrV3QrgGqn3zTjVgaM27w90EKl7nCqKAqbys
         tpzgom+Gy6bfhSLUNaogsJ8YOCWOZ0yf91jMoGz4edPhRSdN/z5X0nGpgVWc+2ZVTTLG
         qukifGIA/rq+I/W+IzxgRatbZuxCM4P/cf6IsO3fTLlEMdk6Pgc3coZunb2w5fQk3yxI
         w0m3NlXDeOGrZCVw7oTt73rOFuXMXhSLuOmv6gX5KMlSlIDwEBh3u5IHNVCjvvpxYhnM
         I0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQxAlfCf+4Q9fzk9NVeztYNuUEiyzoj0uBtK+lVZrFU=;
        b=0oTDqh+XkdVS4kHkz1YbggPpd6mFD8DupX9Qdfc9bNrD+4MERH3V914YxdubWhEN9g
         JIioEvmRi6NMqMSJxItrIsZb+SvfImNjXmAwOwOGbRdnAD9pfLR8tDxeRjnoCXjK9LZk
         lO5LmxosmJtB0h8X8FC2GkV6g420R1DCLv9ui5WFtHstxk3iTwEov3HJH6xfYJjlx7O0
         d5GjI9dOayG8ZQGw5KHw0pjoHFpVgs7pj4o3eUGX6obiq3kUE475gQiRGGL5SXQ+U6ST
         TUnqrnvMvGiYVZJO/HHN5Qek2mcFkcxb29J7Yw+d7+Iox9KBmGh6pYfKUWXg8REpSLm5
         TNzg==
X-Gm-Message-State: AOAM530GqS9rkIzeDzZ189J/eB8QKvdRMqUH3v86ujOBjlMgg6lFJ5tQ
        L0ZOuwV+tJBMizutPL+qTo3TTNpwZD83uxc4YW+LtKLqPO0=
X-Google-Smtp-Source: ABdhPJyWkebhNA4z5b+/V0macqc0d0pN0e9Kp/wDMtz7zJ1p3EXr28YHKL5hJFpffcGrasX6j31VPp2ER2/q+oF1bDw=
X-Received: by 2002:a17:906:8d8:b0:6d2:131d:be51 with SMTP id
 o24-20020a17090608d800b006d2131dbe51mr28476780eje.564.1646330418099; Thu, 03
 Mar 2022 10:00:18 -0800 (PST)
MIME-Version: 1.0
References: <CAHrpEqSBLMU-RO8moqvSQUcP62N7xqpNyHfH1UERB_qAByK+2Q@mail.gmail.com>
 <20220303174826.GA815663@bhelgaas>
In-Reply-To: <20220303174826.GA815663@bhelgaas>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Thu, 3 Mar 2022 12:00:06 -0600
Message-ID: <CAHrpEqQ3yAvPpaeiGvLBMLMievnMjeo-njvj0UXwz5hcWHc6Cw@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: imx6: add PCIe embedded DMA support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 3, 2022 at 11:48 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Mar 02, 2022 at 03:28:48PM -0600, Zhi Li wrote:
> > On Wed, Mar 2, 2022 at 3:21 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Mar 02, 2022 at 02:49:45PM -0600, Zhi Li wrote:
> > > > On Wed, Mar 2, 2022 at 2:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Tue, Mar 01, 2022 at 09:26:45PM -0600, Frank Li wrote:
> > > > > > ...
>
> > > > > > The DMA can transfer data to any remote address location
> > > > > > regardless PCI address space size.
> > > > >
> > > > > What is this sentence telling us?  Is it merely that the DMA "inbound
> > > > > address space" may be larger than the MMIO "outbound address space"?
> > > > > I think there's no necessary connection between them, and there's no
> > > > > need to call it out as though it's something special.
> > > >
> > > > There are outbound address windows. such as 256M, but RC sides have more
> > > > than 256M ddr memory, such as 16GB. If CPU or external DMA controller,
> > > > only can access 256M
> > > > address space.
> > > >
> > > > But if using an embedded DMA controller,  it can access the whole RC's
> > > > 16G address without
> > > > changing iAtu mapping.
> > > >
> > > > I want to say why I need enable embedded DMA for EP.
> > >
> > > OK, so if IIUC, the DMA controller is embedded in the imx6 host bridge
> > > (of course; that's obvious from what you're doing here).  And unlike
> > > DMA from devices *below* the host bridge, DMAs from the embedded
> > > controller don't go through the iATU, so they are not subject to any
> > > of the iATU limitations.  Right?
> >
> > Yes!
>
> I guess that means the DMA controller is functionally and logically
> sort of a separate device from the PCI host bridge?  Sounds like the
> DMA controller doesn't receive or generate PCI transactions?

It is not a separated DMA controller physically.

LOCAL BUS ->  [ DMA, PCI controller (EP/RC) ]. -> PCI Bus.
DMA Read data from local bus, then convert to PCI TLP transaction sent
out to PCI bus.

It is mainly used for EP mode.  It also works for RC mode, but not commonly.

>
> Bjorn
