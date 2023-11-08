Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0888B7E5C79
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 18:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKHRf2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 12:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjKHRf2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 12:35:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06751FDF;
        Wed,  8 Nov 2023 09:35:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9F9C433C7;
        Wed,  8 Nov 2023 17:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699464925;
        bh=2cawYqnuvzkIcsh1Svh8QomJyD9U+RkekHpokK63Beg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IXhfxJMeJfPQE6LGUyqa8b5iSmYcj86HjQ62wQtViKlkCnaJEX4VCg/hQWr8suJi/
         yFpjUjn09ABuRxq7U8aPB4433u5egy1QezRCoK2srbgTBpWGBx81+PbiJ0owW/QnPK
         SDc3t+ICV6B692LdXF8lcumgtPqL8cQEnMSW2Htm0LpgMoWqIqHO6pXVoeyAK2+ja7
         MYoWoUppgkdrgnCSbJAHFvbuJrDGTlgZqzgunpeGDGRVQe/DWLyXTl3/lnVfK9pNoP
         N47eG14GWhopKkdvfGblB24Pq52/1g0feKd082n0ewPG3CTcnnQToMSGxbM7qwAQmd
         tz3oRZ3pmUY1g==
Date:   Wed, 8 Nov 2023 11:35:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <htejun@gmail.com>, dakr@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>, jeff@garzik.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Implementation details of PCI Managed (devres) Functions
Message-ID: <20231108173522.GA421244@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84be1049e41283cf8a110267646320af9ffe59fe.camel@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 07, 2023 at 08:38:18PM +0100, Philipp Stanner wrote:
> Hi all,
> 
> I'm currently working on porting more drivers in DRM to managed pci-
> functions. During this process I discovered something that might be
> called an inconsistency in the implementation.
> 
> First, there would be the pcim_ functions being scattered across
> several files. Some are implemented in drivers/pci/pci.c, others in
> lib/devres.c, where they are guarded by #ifdef CONFIG_PCI
> – this originates from an old cleanup, done in
> 5ea8176994003483a18c8fed580901e2125f8a83
> 
> Additionally, there is lib/pci_iomap.c, which contains the non-managed
> pci_iomap() functions.
> 
> At first and second glance it's not obvious to me why these pci-
> functions are scattered. Hints?
> 
> 
> Second, it seems there are two competing philosophies behind managed
> resource reservations. Some pci_ functions have pcim_ counterparts,
> such as pci_iomap() <-> pcim_iomap(). So the API-user might expect that
> relevant pci_ functions that do not have a managed counterpart do so
> because no one bothered implementing them so far.
> 
> However, it turns out that for pci_request_region(), there is no
> counterpart because a different mechanism / semantic was used to make
> the function _sometimes_ managed:
> 
>    1. If you use pcim_enable_device(), the member is_managed in struct
>       pci_dev is set to 1.
>    2. This value is then evaluated in pci_request_region()'s call to
>       find_pci_dr()
> 
> Effectively, this makes pci_request_region() sometimes managed.
> Why has it been implemented that way and not as a separate function –
> like, e.g., pcim_iomap()?
> 
> That's where an inconsistency lies. For things like iomappings there
> are separate managed functions, for the region-request there's a
> universal function doing managed or unmanaged, respectively.
> 
> Furthermore, look at pcim_iomap_regions() – that function uses a mix
> between the obviously managed function pcim_iomap() and
> pci_request_region(), which appears unmanaged judging by the name, but,
> nevertheless, is (sometimes) managed below the surface.
> Consequently, pcim_iomap_regions() could even be a little buggy: When
> someone uses pci_enable_device() + pcim_iomap_regions(), wouldn't that
> leak the resource regions?
> 
> The change to pci_request_region() hasn't grown historically but was
> implemented that way in one run with the first set of managed functions
> in commit 9ac7849e35f70. So this implies it has been implemented that
> way on purpose.
> 
> What was that purpose?
> 
> Would be great if someone can give some hints :)

Sorry, I don't know or remember all the history behind this, so can't
give any useful hints.  If the devm functions are mostly wrappers
without interesting content, it might make sense to collect them
together.  If they *do* have interesting content, it probably makes
sense to put them next to their non-devm counterparts.

The pci_request_region() managed/unmanaged thing does seem like it
could be unexpected and lead to issues as you point out.

Bjorn
