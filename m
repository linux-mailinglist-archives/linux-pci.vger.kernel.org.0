Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D724ACA3E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 21:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbiBGUSM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 15:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241807AbiBGUNs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 15:13:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF969C0401DA;
        Mon,  7 Feb 2022 12:13:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF9B1B81673;
        Mon,  7 Feb 2022 20:13:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E746C340EE;
        Mon,  7 Feb 2022 20:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644264825;
        bh=plTnq9pejgjpmDCGWtGP8pfnD0zRw1CkgzOlZIUXW+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cCGH/YrbuY0GdCIi582p6XmXwWgBSOhqBYn2V9Oy3z29nvC/AEkgYR8oJ+IBaQo89
         NH6MrrUR6Gd4iGcQaK2NtW6N4k10sovKyCWY27PiZ9jM7VPSXKZsUpWdJhUR3nRYFq
         y738P/ANGIvN8Gdwk7JHHDFo+FEECNI4rgGobNbl8ApAZukXQEPwN1n3NE2t4+ab3O
         bnqVVg3KflfjdcJZSb8dVNuzA0OkG8YHeq9G29zHWUGqyeZrSstPwYcGjStdoZ7Lsz
         EwhbN5U1fziwzU9kHbfuENQiQAOjYzkCIOEueSJfD1Qdf/p1HRn/iovjSwu6YhjeNk
         R7M0VZW4kyV6g==
Date:   Mon, 7 Feb 2022 14:13:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Abhishek Sahu <abhsahu@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI: Fix the ACPI power state during runtime resume
Message-ID: <20220207201343.GA413636@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2249802.ElGaqSPkdT@kreacher>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 07, 2022 at 07:58:13PM +0100, Rafael J. Wysocki wrote:
> On Saturday, February 5, 2022 12:32:19 AM CET Bjorn Helgaas wrote:
> > Wonder if we should add something like this to MAINTAINERS so you get
> > cc'd on power-related things:
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ea3e6c914384..3d9a211cad5d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15422,6 +15422,7 @@ F:	include/linux/pm.h
> >  F:	include/linux/pm_*
> >  F:	include/linux/powercap.h
> >  F:	kernel/configs/nopm.config
> > +K:	pci_[a-z_]*power[a-z_]*\(
> 
> It seems so, but generally PM patches should be CCed to linux-pm anyway.

Definitely.  It's just that running get_maintainer.pl on this patch
currently shows:

  Bjorn Helgaas <bhelgaas@google.com> (supporter:PCI SUBSYSTEM)
  linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
  linux-kernel@vger.kernel.org (open list)

so it's not as helpful as it could be.  The MAINTAINERS patch above
would change it to this:

  Bjorn Helgaas <bhelgaas@google.com> (supporter:PCI SUBSYSTEM)
  "Rafael J. Wysocki" <rafael@kernel.org> (supporter:POWER MANAGEMENT CORE)
  linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM)
  linux-kernel@vger.kernel.org (open list)
  linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE)

Bjorn
