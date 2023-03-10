Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4076B540F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 23:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjCJWPu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 17:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjCJWPs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 17:15:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA8E115DE5;
        Fri, 10 Mar 2023 14:15:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC28FB82400;
        Fri, 10 Mar 2023 22:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749CFC433EF;
        Fri, 10 Mar 2023 22:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678486543;
        bh=DBl3XYhVnPnvHREV6khsX0zced8HUvT1CffAKeLd3Ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfS4jME/FTj7znUmYf295mHvCJSGHW15meDAWvWzrPF00ribhkkR54Qzq1xN8JWLo
         4ifTzybHNa9ZODC6VxC42vmMGTVR8rpuWOM6tKK420xu8RHuuxnRruXC7YKzvCsgbR
         u/3W/J52kt+Sw35gEY+GHE+yc90z2JKYQ8ziYt9KjcC+XD8bNVo3dAsYq1L9Dq9Z0P
         F78mqifIRtEWY9l2xPq1eww1JPlj0DytsnzKq9XlcZ3XWB4shMaJ1Gp356DNbpjhAm
         fT6kd6cAHwWNZ9v/mPpirze0bthx/rOXMwvra8reVtn+1Ve3YO1CPCN4cOH1gbnOxg
         +A+CV4nR0FY6w==
Date:   Fri, 10 Mar 2023 15:15:38 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
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
Subject: Re: [PATCH v4 1/4] PCI: Introduce pci_dev_for_each_resource()
Message-ID: <ZAusCnLSXeEcpQs+@kbusch-mbp.dhcp.thefacebook.com>
References: <20230310171416.23356-1-andriy.shevchenko@linux.intel.com>
 <20230310171416.23356-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310171416.23356-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 10, 2023 at 07:14:13PM +0200, Andy Shevchenko wrote:
> +#define __pci_dev_for_each_resource(dev, res, __i, vartype)		\
> +	for (vartype __i = 0;						\
> +		res = &(dev)->resource[__i], __i < PCI_NUM_RESOURCES;	\
> +		__i++)

...

> +#define pci_dev_for_each_resource_p(dev, res)				\
> +	__pci_dev_for_each_resource(dev, res, i, unsigned int)

It looks dangerous to have a macro declare a variable when starting a new
scope. How do you know the name 'i' won't clash with something defined above?
