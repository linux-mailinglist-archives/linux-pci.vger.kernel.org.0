Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC2A6D8812
	for <lists+linux-pci@lfdr.de>; Wed,  5 Apr 2023 22:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjDEUSh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Apr 2023 16:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDEUSg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Apr 2023 16:18:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482372108;
        Wed,  5 Apr 2023 13:18:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7596629BB;
        Wed,  5 Apr 2023 20:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF579C433EF;
        Wed,  5 Apr 2023 20:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680725914;
        bh=nzqjLaTJey3sRM+1TqQcKEYWams7IVp4kAG1Ou4QbaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qSIFfK6lOkdOAB5LY9zLp6kglpMt1j7LNegofExp0NbD3DdGJu2FIQSd9fKDakYSF
         8EdaJODqwbg6kctJMgL0riv0zeo2GlzJNTyce/xBoaGt5wkbyslXtmEQr79jETD5VN
         JkGR/SuDh0S5XNaO9WvVcUE8aLyF+fq2KHagkNoYCPN/ufYZsMFzIEL8TOwxz22rru
         dTfc7KYc7iXQfdVOTiFqncjiOZ6vNACqFFlXmfZkUJ6vh6opIHeXG2F88mLt2+N1/j
         qSW8PkxMlDLNSe4zXOh05GwayXmUNnmLRiK0jPqk3fXDd1WbPKGLoR9/9OHb8FIaNI
         uOrsrDeBHNVGg==
Date:   Wed, 5 Apr 2023 15:18:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
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
Subject: Re: [PATCH v8 0/7] Add pci_dev_for_each_resource() helper and update
 users
Message-ID: <20230405201832.GA3638070@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC0xK4YJrKga7akk@smile.fi.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 05, 2023 at 11:28:27AM +0300, Andy Shevchenko wrote:
> On Tue, Apr 04, 2023 at 11:11:01AM -0500, Bjorn Helgaas wrote:
> > On Thu, Mar 30, 2023 at 07:24:27PM +0300, Andy Shevchenko wrote:
> > > Provide two new helper macros to iterate over PCI device resources and
> > > convert users.
> > > 
> > > Looking at it, refactor existing pci_bus_for_each_resource() and convert
> > > users accordingly.

> > Applied 2-7 to pci/resource for v6.4, thanks, I really like this!
> 
> Btw, can you actually drop patch 7, please?

Done.

> > I omitted
> > 
> >   [1/7] kernel.h: Split out COUNT_ARGS() and CONCATENATE()"
> > 
> > only because it's not essential to this series and has only a trivial
> > one-line impact on include/linux/pci.h.
> 
> I'm not sure I understood what exactly "essentiality" means to you, but
> I included that because it makes the split which can be used later by
> others and not including kernel.h in the header is the objective I want
> to achieve. Without this patch the achievement is going to be deferred.
> Yet, this, as you have noticed, allows to compile and use the macros in
> the rest of the patches.

I haven't followed the kernel.h splitting, and I try to avoid
incidental changes outside of the files I maintain, so I just wanted
to keep this series purely PCI and avoid any possible objections to a
new include file or discussion about how it should be done.
