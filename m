Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A873D0F43
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbhGUM37 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 08:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232286AbhGUM37 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 08:29:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 414AF6120A;
        Wed, 21 Jul 2021 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626873035;
        bh=RyTa6MIG32jq2CsXun6DRYMHVllwbaPN2b34PGmMn1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U/z85Hx/5xYT4WlwkQAIuVF+38cUNuHNXFEUE29SkU7anczFwcWnbr6GA7UJLib5+
         aCvcEHN/7cYRm9D4/rV5wi8wUWQ3uSrRGE2AbfL0gPvHlNSAwpbR4CseZRwcnz9Ss5
         z/z1zUwSwvbGXtiRQZOpX0LJnbPRUGu4k6xmqfYs5LWmbU+rYKv3K+G7U+rsgjWyMY
         j8hu8XVRfCIKrlAnCsPlQAIQm0eE2WLnrmxVKdRwTDLe2iWqtc4tjNlEVT/ZWDLxOO
         Pwqw+1HkDZg6rQoTHeDA9XiI0urXuaIaxHYdwkcvP0paJcKs3/P1sbbA+TFLmsJXI9
         lUEKxG8qVGz6w==
Date:   Wed, 21 Jul 2021 15:10:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>,
        Mauro Carvalho Chehab <mauro.chehab@huawei.com>,
        Krzysztof =?UTF-8?B?V2ls?= =?UTF-8?B?Y3p5xYRza2k=?= 
        <kw@linux.com>, Alex Dewar <alex.dewar90@gmail.com>,
        Henry Styles <hes@sifive.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Wesley Sheng <wesley.sheng@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v7 11/10] PCI: kirin: Allow building it as a module
Message-ID: <20210721151029.29c84c57@coco.lan>
In-Reply-To: <CAK8P3a0fB48uES77a+z=OyyV9Rd4HbA4Q7gkVFCtPV5yispGYA@mail.gmail.com>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
        <8dbdde3eda0e5d22020f6a8bf153d7cfb775c980.1626862458.git.mchehab+huawei@kernel.org>
        <CAK8P3a0fB48uES77a+z=OyyV9Rd4HbA4Q7gkVFCtPV5yispGYA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 21 Jul 2021 13:55:07 +0200
Arnd Bergmann <arnd@arndb.de> escreveu:

> On Wed, Jul 21, 2021 at 12:15 PM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > There's nothing preventing this driver to be loaded as a
> > module. So, change its config from bool to tristate.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> No objections from me, but I wonder if you would also consider making the
> module removable. It's currently marked as 'builtin_platform_driver',
> so you can load but not remove it. Rob has done some bug fixes that make
> it possible to remove similar drivers, so it's probably not much work
> here either.

Yeah, I can probably work on a patch to unbind/remove this driver.

Never actually tried to write a patch removing the PCIe BUS, so no
idea if the refcounts for the in-board Ethernet NIC, M.2 and mini-PCIe
slots will be properly handled. If refcount is handled properly, I
guess a patch like that won't be hard, at least for Kirin 970 PHY.

The Kirin 960 PHY will require a small change at the current version,
as it currently misses the power_off logic.

I also need to double-check if devm resources will be freed at the 
driver removal time, as, with some past tests with media devices,
we had some issues with that.

Thanks,
Mauro
