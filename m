Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D1D49EA54
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 19:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiA0SZi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 13:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiA0SZi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jan 2022 13:25:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F7BC061714;
        Thu, 27 Jan 2022 10:25:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D39D661CE5;
        Thu, 27 Jan 2022 18:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4684DC340E8;
        Thu, 27 Jan 2022 18:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643307937;
        bh=YT9O/J6APcutEaa2IHsPQh9rsIOe8yDex/CtLoUWWTQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=klIU8qgEVLOl3a6jRI5FM6PL7X6BU02KUVW/txCFAN9cElm3ElINcKkUXkZGccPJU
         ZbdmaAjN/picjxZXUk3OH+nsCH3Kz2F/C96g5SxtRDLZJ/YiLRm6hzu+grhIIWUHRu
         CuQfLNfSpfs+/MNQQm+7TCSwojVe/VEs6BvxNx8wMD77jS5bo9mGS335RVBdUmk+LG
         T59slaqO2Qg7yxQeCx2nrFeZFInZO6VXUfUL/KYWcG8+n5AtfZC8R0Szl8wRSPnFH7
         zd3ei4fhU+hVVzUijKhWu/HrXhT0m3ER7ke9iZVBZl86MToPxnuIsHeW5Vw7/ulhY3
         o2W8VKvJhncpg==
Received: by mail-qt1-f169.google.com with SMTP id y8so3212956qtn.8;
        Thu, 27 Jan 2022 10:25:37 -0800 (PST)
X-Gm-Message-State: AOAM532nUQES4KOnfAJrmBopu+MC8A5yzhxepD+lvk9Pj3jb6HACE2fr
        cVHgC2Crd1OChv4A2/IvqbuDVDNeF4zVSxzJKQ==
X-Google-Smtp-Source: ABdhPJzEs26uOUlYxkTLdr9JC10p5n/HWaaR4jaj2RGVfimzOa47NGAkfa4zr1/nKHtA7sG9QxdunJEQTH2PnkqSnu8=
X-Received: by 2002:ac8:7f4d:: with SMTP id g13mr3858178qtk.272.1643307936365;
 Thu, 27 Jan 2022 10:25:36 -0800 (PST)
MIME-Version: 1.0
References: <ab490690-eac2-c714-1359-b4058e2f98ff@ti.com> <20220127152333.GA101708@bhelgaas>
In-Reply-To: <20220127152333.GA101708@bhelgaas>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 27 Jan 2022 12:25:24 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+9aDzexJUaTPCY=SChqC1Ek1xL0qj-CorGjvXk=Sn20w@mail.gmail.com>
Message-ID: <CAL_Jsq+9aDzexJUaTPCY=SChqC1Ek1xL0qj-CorGjvXk=Sn20w@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: ti,j721e: Add device id for J721S2
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 9:24 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Lorenzo, initial post
> https://lore.kernel.org/r/20211130035608.13492-1-a-govindraju@ti.com]
>
> On Tue, Jan 25, 2022 at 12:06:16PM +0530, Aswath Govindraju wrote:
> > On 30/11/21 9:26 am, Aswath Govindraju wrote:
> > > Document the device id of J721S2 SoC.
> > >
> > > Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> > > ---
> > >
> >
> > May I know if this patch can be picked up?
>
> "git log Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml"
> says most changes to this file have been applied by Lorenzo, so I cc'd
> him.

I can take it if there's not other pending changes to this file for 5.18?

Rob
