Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F64D718BD7
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 23:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjEaVav (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 17:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEaVau (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 17:30:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1A01A2;
        Wed, 31 May 2023 14:30:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5E2E63391;
        Wed, 31 May 2023 21:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7E1C433D2;
        Wed, 31 May 2023 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685568630;
        bh=gW9waI0b8IiYUwk0vfOCM7pXk2nDw1QSAznIy/h3ghs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KtBbCN/ixHzj8ZulEY/5zCSpe/VVKBpSZFDZuNCSDCoNNZ4IeoA+28lWLQWvSlii6
         83BDJpZxFh6HJCKpfPSOLONuS2M6Vumh+ceOlzxWjyrmYHupNvr4DztdjDLJl3iqmN
         E3araGx+1PyOqST2zluz35yOcgzUDjix8glDLTAN/wUxtojSsJeinZtS0BNCLJVOXb
         hkXJLKswE11TqxiL8vaPqm931ggJJ71GILWlC61yGzVhgB56FeGO9+L1ZryEUY7qlP
         EPZxdEvOEEyvpu7VdWJnY4Z4bFlhgqbJcQ6tWlmZqEjiu2TPM90LCU6E74dCFHn04m
         J5aGwHVGTvHag==
Date:   Wed, 31 May 2023 16:30:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Lunn <andrew@lunn.ch>, sparclinux@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Gregory Clement <gregory.clement@bootlin.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-acpi@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        xen-devel@lists.xenproject.org, Matt Turner <mattst88@gmail.com>,
        Anatolij Gustschin <agust@denx.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Juergen Gross <jgross@suse.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        linuxppc-dev@lists.ozlabs.org,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-mips@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-alpha@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v8 0/7] Add pci_dev_for_each_resource() helper and update
 users
Message-ID: <ZHe8dKb3f392MfBO@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOiHx==5YWhDiZP2PyHZiJrmtqRzvqCqoSO59RwuYuR85BezBg@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 31, 2023 at 08:48:35PM +0200, Jonas Gorski wrote:
> ...

> Looking at the code I understand where coverity is coming from:
> 
> #define __pci_dev_for_each_res0(dev, res, ...)                         \
>        for (unsigned int __b = 0;                                      \
>             res = pci_resource_n(dev, __b), __b < PCI_NUM_RESOURCES;   \
>             __b++)
> 
>  res will be assigned before __b is checked for being less than
> PCI_NUM_RESOURCES, making it point to behind the array at the end of
> the last loop iteration.
> 
> Rewriting the test expression as
> 
> __b < PCI_NUM_RESOURCES && (res = pci_resource_n(dev, __b));
> 
> should avoid the (coverity) warning by making use of lazy evaluation.
> 
> It probably makes the code slightly less performant as res will now be
> checked for being not NULL (which will always be true), but I doubt it
> will be significant (or in any hot paths).

Thanks a lot for looking into this!  I think you're right, and I think
the rewritten expression is more logical as well.  Do you want to post
a patch for it?

Bjorn
