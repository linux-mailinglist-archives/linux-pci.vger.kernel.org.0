Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C712A60D74E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 00:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJYWnj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 18:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJYWni (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 18:43:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A3AD7E0D;
        Tue, 25 Oct 2022 15:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4027461B89;
        Tue, 25 Oct 2022 22:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A9CC433D6;
        Tue, 25 Oct 2022 22:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666737816;
        bh=VzotCHER+4tJmGewDcfbWpt7XoYpGbd1YkpPo+U5NQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EpHcLnsL+gZtYIDpAyeoyqfxBTPc2AwdkPujIrcind2CrETjd399N1hfJHz5yw2D9
         JjL27F5gKSmyC24qG1JX5qnOJY8OIdrrvd1GjfKDq8PGH5BXxPr6tDybKzGDUJUhu/
         Ew3B2VZcE/NxmscjdbWp15Pv7Mgu+2yWr17g5R9z9AwyH9ccrmW+UlWW86PwTjWrJ1
         uxHWihZp8tJI1D6Y5VF4lwmFHVm/B64n05inTiZeaFBDNtnR8Etrbx8x4D5sDfY12N
         THe/9naax49Z1z8OVpAwvrzxOKY85gEnfFT4U1FayeyZ597/CP2AoTatEfRw4GCpae
         DVfUHgbKwmxhA==
Date:   Tue, 25 Oct 2022 17:43:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        David Airlie <airlied@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 0/8] agp: Convert to generic power management
Message-ID: <20221025224334.GA694255@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9twkfjHh4SR2aQdB9WTRYEhTdWZG4A-f0n8oB8yw=dZgyw@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 26, 2022 at 08:17:47AM +1000, Dave Airlie wrote:
> On Wed, 26 Oct 2022 at 06:39, Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Vaibhav converted several AGP drivers from legacy PCI power management to
> > generic power management [1].  This series converts the rest of them.
> 
> Do you want to merge through the PCI tree?
> 
> Acked-by: Dave Airlie <airlied@redhat.com>

Sure, will be happy to.  Thanks!

> > v1 posted at [2].
> >
> > Changes from v1 to v2:
> >   - Convert from SIMPLE_DEV_PM_OPS() (which is deprecated) to
> >     DEFINE_SIMPLE_DEV_PM_OPS() and remove __maybe_unused annotations.
> >
> > [1] https://lore.kernel.org/all/20210112080924.1038907-1-vaibhavgupta40@gmail.com/#t
> > [2] https://lore.kernel.org/all/20220607034340.307318-1-helgaas@kernel.org/
> >
> > Bjorn Helgaas (8):
> >   agp/efficeon: Convert to generic power management
> >   agp/intel: Convert to generic power management
> >   agp/amd-k7: Convert to generic power management
> >   agp/ati: Convert to generic power management
> >   agp/nvidia: Convert to generic power management
> >   agp/amd64: Update to DEFINE_SIMPLE_DEV_PM_OPS()
> >   agp/sis: Update to DEFINE_SIMPLE_DEV_PM_OPS()
> >   agp/via: Update to DEFINE_SIMPLE_DEV_PM_OPS()
> >
> >  drivers/char/agp/amd-k7-agp.c   | 24 ++++--------------------
> >  drivers/char/agp/amd64-agp.c    |  6 ++----
> >  drivers/char/agp/ati-agp.c      | 22 ++++------------------
> >  drivers/char/agp/efficeon-agp.c | 16 ++++------------
> >  drivers/char/agp/intel-agp.c    | 11 +++++------
> >  drivers/char/agp/nvidia-agp.c   | 24 ++++--------------------
> >  drivers/char/agp/sis-agp.c      |  7 ++-----
> >  drivers/char/agp/via-agp.c      |  6 ++----
> >  8 files changed, 27 insertions(+), 89 deletions(-)
> >
> > --
> > 2.25.1
> >
