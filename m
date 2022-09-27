Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4CB5EC7AA
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 17:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiI0P2P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 11:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiI0P2D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 11:28:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F7D1B348F;
        Tue, 27 Sep 2022 08:27:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8635DB81C5B;
        Tue, 27 Sep 2022 15:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BF2C433C1;
        Tue, 27 Sep 2022 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664292474;
        bh=CjW2AN+Ns/4UkIYVLzkQVu05g1VFuqqL8TsZ16gUCiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8pFAzbwfdtfmmaqK33lZ2OGoMucfWPApXvcXYd5qlrohRakBeU2Ajmdvggm7M27M
         33GwSGkmUp4EtQ3Ods9DhloQJfqkvBAy4LayIjSh6rdDTjHfNCK+2Ou8PlEN0NaXlL
         rxI2CPfjrCaB/XvpU3XjaqdY8nGDwYzTye0ooZ0nB4qhKwopg2ETPBz2OHht/YYAHF
         HXG5De57FiNFaCC8oeoIqTM6z+WVOvYMyDuoI24bAUiJkYGh0oVU9eA1GFgjFgSZFC
         raRKWON/qBfQkWIkrTJeEf+WfGjWBz6UK7iEqKnv9RDw/sP4UO5SGc5gr+JoXu8i+c
         qichXszpNcc6w==
Date:   Tue, 27 Sep 2022 17:27:42 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
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
Message-ID: <YzMWbmWWul1AhpuR@lpieralisi>
References: <YtqllIHY/R/BbR3V@hovoldconsulting.com>
 <20220722143858.GA1818206@bhelgaas>
 <Yt6Z3cBrVy1lVTp1@hovoldconsulting.com>
 <87czdtxnfn.wl-maz@kernel.org>
 <Yt60WNVNEVHgzSuN@hovoldconsulting.com>
 <87zggxaye8.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zggxaye8.wl-maz@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 25, 2022 at 06:35:27PM +0100, Marc Zyngier wrote:

[...]

> > That is precisely the way I've been testing it and everything appears
> > to be tore down as it should.
> >
> > And a PCI driver that has been unbound should have released its
> > resources, or that's a driver bug. Right?
> 
> But that's the thing: you can easily remove part of the infrastructure
> without the endpoint driver even noticing. It may not happen in your
> particular case if removing the RC driver will also nuke the endpoints
> in the process, but I can't see this is an absolute guarantee. The
> crash pointed to by an earlier email is symptomatic of it.
> 
> > And for the OF INTx case you mentioned earlier, aren't those mapped by
> > PCI core and could in theory be released by core as well?
> 
> Potentially, though I haven't tried to follow the life cycle of those.
> The whole thing is pretty fragile, and this sort of resource is rarely
> expected to be removed...

This made me notice that we don't undo the actions (ie bridge->map_irq())
executed in pci_assign_irq() in pci_device_remove(); I don't think this
can be right and that's already a candidate for a fix.

It is not necessarily related to this thread topic, though I believe,
in an _ideal_ world, removing a bridge should guarantee that all
the downstream devices (ie drivers) had a chance of freeing/disposing
the resources they allocated. This in theory; I totally understand
Marc's point of view here and we should make up our mind about what
we want to do on host bridge removal policy - this will take me more
time to get to the bottom of it.

Lorenzo
