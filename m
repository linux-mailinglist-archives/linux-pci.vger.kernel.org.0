Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5410F4C4CDF
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 18:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiBYRvy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 12:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiBYRvt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 12:51:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B21622313B;
        Fri, 25 Feb 2022 09:51:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D545861DFA;
        Fri, 25 Feb 2022 17:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26CBC340E7;
        Fri, 25 Feb 2022 17:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645811473;
        bh=4OGwXvj6qG40FpaSoNd3Q08HMEjHMoeogTnv4EWa8cg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ILebw+DPu/ytkCQwojobeXNB8JX0usxgEWR0mD61kJ1R+PoCCL1Tw5MULyNKQzLyX
         g+agQx4t1UaZhZ6KQ2MFvVIVrH9dAzIDGQjdRxdHeAJ+rRFZszmOQeSq9DBlK8aEVq
         KEin/IhXQe1qwzCSGjeB4eN/2DATuH801k1+LJo0brl5DIUBXQ5Dj/g4b4MLmJTRhH
         1Gbf1nE3/YZzIbx83UY01nQbm28MNJK0W+IBYjm6dvtI6K65V4w7cKtJFKufEiJWIu
         OQNN1V6GIhVbX02eL++cq8SEQoP9D86aH2/9MPqi/8RnGSrEpoqGiSyZ8TzSo65/DU
         s4pSYD9Ex+hgQ==
Date:   Fri, 25 Feb 2022 11:51:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
Message-ID: <20220225175111.GA367168@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225182216.2fcf5455@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 25, 2022 at 06:22:16PM +0100, Marek Behún wrote:
> On Fri, 25 Feb 2022 09:37:56 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:

> > Yes, it's a mix.  For some recent additions, I've resisted adding the
> > _SHIFT macros on the theory that they clutter the file, they never
> > change, and the main point of the #defines is readability and so
> > grep/tags/etc can find things.
> > 
> > There are a *few* users of FIELD_PREP() and FIELD_GET():
> > 
> >   git grep -E "FIELD_(GET|PREP)\(PCI_EXP"
> > 
> > and I'm inclined to go that direction in the future.  What do you
> > think?
> 
> I am also pro that direction.
> 
> Would you also like to convert current usages in the .c driver files?
> 
> We can't remove the existing macros since they are in UAPI, but we can
> convert drivers so that they don't use _SHIFT macros.

Certainly not a high priority, but it actually looks like there aren't
*that* many uses in drivers/pci/, so I'd be OK with converting them.

Bjorn
