Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D577D6C6BDB
	for <lists+linux-pci@lfdr.de>; Thu, 23 Mar 2023 16:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjCWPEK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Mar 2023 11:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjCWPEJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Mar 2023 11:04:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E3528E74;
        Thu, 23 Mar 2023 08:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2957B8215E;
        Thu, 23 Mar 2023 15:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7276DC4339E;
        Thu, 23 Mar 2023 15:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679583760;
        bh=A4cz5sAtdGojClghNnzslTTn+0telsrqWPrc7ZEY92A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QZ2KDQiDLNeolamz/rBZXmXKaml10w90GcGwB6l5yO87qYFqQPDIQgKZ80zht8Qsc
         Xeoi/zLrt2EtH3nbngx/R5sYZx0Xwf4JkO9knqHSrKtOYd2+7MSeapV8B/zw9rxmZf
         9UhNHPKZpA1ucTpj/VgulfE/ACFQnVZP8YBw36pan4Gf8wwyvTOnEEDjDM2KPQPTQp
         ZGCnVZCISmiqwx5zKNrKd8Mk7Zh6u/0oYwI8LPRfc1PEUXu67DDtdxfqNx9ryyF1pw
         4cNq1h1H67JIwrFngX1Sl9ypuAP/OCB5kx8wJtxg7nOzQYMGU2gbmFC/O67YEr6JCJ
         aHqE0tG0UVQoQ==
Date:   Thu, 23 Mar 2023 10:02:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Juergen Gross <jgross@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anatolij Gustschin <agust@denx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH v6 1/4] PCI: Introduce pci_dev_for_each_resource()
Message-ID: <20230323150238.GA2550157@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBxiaflGTeK8Jlgx@smile.fi.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 23, 2023 at 04:30:01PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 22, 2023 at 02:28:04PM -0500, Bjorn Helgaas wrote:
> > On Mon, Mar 20, 2023 at 03:16:30PM +0200, Andy Shevchenko wrote:
> ...
> 
> > > +	pci_dev_for_each_resource_p(dev, r) {
> > >  		/* zap the 2nd function of the winbond chip */
> > > -		if (dev->resource[i].flags & IORESOURCE_IO
> > > -		    && dev->bus->number == 0 && dev->devfn == 0x81)
> > > -			dev->resource[i].flags &= ~IORESOURCE_IO;
> > > -		if (dev->resource[i].start == 0 && dev->resource[i].end) {
> > > -			dev->resource[i].flags = 0;
> > > -			dev->resource[i].end = 0;
> > > +		if (dev->bus->number == 0 && dev->devfn == 0x81 &&
> > > +		    r->flags & IORESOURCE_IO)
> > 
> > This is a nice literal conversion, but it's kind of lame to test
> > bus->number and devfn *inside* the loop here, since they can't change
> > inside the loop.
> 
> Hmm... why are you asking me, even if I may agree on that? It's
> in the original code and out of scope of this series.

Yeah, I don't think it would be *unreasonable* to clean this up at the
same time so the maintainers can look at both at the same time (this
is arch/powerpc/platforms/pseries/pci.c, so Michael, et al), but no
need for you to do anything, certainly.  I can post a follow-up patch.

> > but
> > since we're converging on the "(dev, res)" style, I think we should
> > reverse the names so we have something like:
> > 
> >   pci_dev_for_each_resource(dev, res)
> >   pci_dev_for_each_resource_idx(dev, res, i)
> 
> Wouldn't it be more churn, including pci_bus_for_each_resource() correction?

Yes, it definitely is a little more churn because we already have
pci_bus_for_each_resource() that would have to be changed.

I poked around looking for similar patterns elsewhere with:

  git grep "#define.*for_each_.*_p("
  git grep "#define.*for_each_.*_idx("

I didn't find any other "_p" iterators and just a few "_idx" ones, so
my hope is to follow what little precedent there is, as well as
converge on the basic "*_for_each_resource()" iterators and remove the
"_idx()" versions over time by doing things like the
pci_claim_resource() change.

What do you think?  If it seems like excessive churn, we can do it
as-is and still try to reduce the use of the index variable over time.

Bjorn
