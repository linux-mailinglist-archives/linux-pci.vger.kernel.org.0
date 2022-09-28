Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C883C5ED4F0
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 08:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiI1GgO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 02:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiI1GgN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 02:36:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB881CD69A;
        Tue, 27 Sep 2022 23:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39197B81E8F;
        Wed, 28 Sep 2022 06:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBFEC433C1;
        Wed, 28 Sep 2022 06:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664346969;
        bh=zyljZf82O9R780kV4BUr+vkxsSNpj4mliqNvkk2AMN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=blqPmmcZfGt5aq8gupuU5Bw45sVvMT3y7NepLo6/iRh6fcsCRnZLHt58DYYgcvBQI
         +cjIvujsQF7XSvivj5lunKS+lbnBWvHGsTcqrHMoVKzoEdC7xOawvzlaeett+Hb6Ci
         HTsDLLna6mREWSSUF2N4gciDwUUT6haN9aQCuL2m5G0LVGf70lR10HLqSXGYE6ra3l
         dYMHTWPliFIdAWxp64RdZWl6DdKHJ4BFWD81WIky/VP1zi03GupwqVeHhqspenr7AX
         qO/NUwdLxPWeWk/Mg+UnzeCyue7Yg4le2sE+QX8oVAwVDY1eFoaCYuw/uQQdG3moNm
         10sJoNeZgjnPA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1odQg3-0006qe-Cf; Wed, 28 Sep 2022 08:36:15 +0200
Date:   Wed, 28 Sep 2022 08:36:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Why set .suppress_bind_attrs even though .remove() implemented?
Message-ID: <YzPrX2UBfv/eXyjs@hovoldconsulting.com>
References: <YtqllIHY/R/BbR3V@hovoldconsulting.com>
 <20220722143858.GA1818206@bhelgaas>
 <Yt6Z3cBrVy1lVTp1@hovoldconsulting.com>
 <87czdtxnfn.wl-maz@kernel.org>
 <Yt60WNVNEVHgzSuN@hovoldconsulting.com>
 <87zggxaye8.wl-maz@kernel.org>
 <YzMWbmWWul1AhpuR@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzMWbmWWul1AhpuR@lpieralisi>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 27, 2022 at 05:27:42PM +0200, Lorenzo Pieralisi wrote:
> On Mon, Jul 25, 2022 at 06:35:27PM +0100, Marc Zyngier wrote:
> 
> [...]
> 
> > > That is precisely the way I've been testing it and everything appears
> > > to be tore down as it should.
> > >
> > > And a PCI driver that has been unbound should have released its
> > > resources, or that's a driver bug. Right?
> > 
> > But that's the thing: you can easily remove part of the infrastructure
> > without the endpoint driver even noticing. It may not happen in your
> > particular case if removing the RC driver will also nuke the endpoints
> > in the process, but I can't see this is an absolute guarantee. The
> > crash pointed to by an earlier email is symptomatic of it.
> > 
> > > And for the OF INTx case you mentioned earlier, aren't those mapped by
> > > PCI core and could in theory be released by core as well?
> > 
> > Potentially, though I haven't tried to follow the life cycle of those.
> > The whole thing is pretty fragile, and this sort of resource is rarely
> > expected to be removed...
> 
> This made me notice that we don't undo the actions (ie bridge->map_irq())
> executed in pci_assign_irq() in pci_device_remove(); I don't think this
> can be right and that's already a candidate for a fix.

There's an inherent asymmetry here as a legacy interrupt can be used by
more than one device. It is mapped on first use as each user calls
->map_irq() but can only be disposed when the final user is gone as I
mentioned here:

	https://lore.kernel.org/all/Yt+6azfwd%2FLuMzoG@hovoldconsulting.com/

> It is not necessarily related to this thread topic, though I believe,
> in an _ideal_ world, removing a bridge should guarantee that all
> the downstream devices (ie drivers) had a chance of freeing/disposing
> the resources they allocated. This in theory; I totally understand
> Marc's point of view here and we should make up our mind about what
> we want to do on host bridge removal policy - this will take me more
> time to get to the bottom of it.

Johan
