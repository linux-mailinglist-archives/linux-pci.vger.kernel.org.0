Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32FA6C5509
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 20:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCVTf3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 15:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCVTf2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 15:35:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89441689B;
        Wed, 22 Mar 2023 12:35:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82487622AF;
        Wed, 22 Mar 2023 19:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B3CC433D2;
        Wed, 22 Mar 2023 19:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679513726;
        bh=FhntRrT8ocoSuGXxtLHKzHWzymmkrlLBWHmrPDDVUUo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TZXj21NeIUkUZZar7VNMqh3dVSuN3o8smKLoGeKlxFM4u9gfOpaC3kuIEPrC8theJ
         EjPJVc9oufTxzPD7G4Hc8hmuSNFg5ASYHNUqVWj4Pm/PAM0cm4Y0hL/TmGR1vF7cRJ
         ghHYAN2nzfJSugY4ZFFucSttfz82MaXOPTFpw736rSuhY7yG3U/x5krQWe30aNyfH3
         TpCuc9D3+sHvl4qsdpIcmDaIEydMxpzHx8G9wZuc/iInxcv8qZuNxXLKv+GJGD4EfH
         DaiPCrrrg2VbKAwdhc5c78r9UJzE633kYTaRwA7Xko4oXiDWsAIH0RPGJpwYNqkaDa
         lXTFXlUZ+LxhA==
Date:   Wed, 22 Mar 2023 14:35:25 -0500
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
Subject: Re: [PATCH v6 2/4] PCI: Split pci_bus_for_each_resource_p() out of
 pci_bus_for_each_resource()
Message-ID: <20230322193525.GA2487882@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320131633.61680-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 20, 2023 at 03:16:31PM +0200, Andy Shevchenko wrote:
> ...

> -#define pci_bus_for_each_resource(bus, res, i)				\
> -	for (i = 0;							\
> -	    (res = pci_bus_resource_n(bus, i)) || i < PCI_BRIDGE_RESOURCE_NUM; \
> -	     i++)
> +#define __pci_bus_for_each_resource(bus, res, __i, vartype)			\
> +	for (vartype __i = 0;							\
> +	     res = pci_bus_resource_n(bus, __i), __i < PCI_BRIDGE_RESOURCE_NUM;	\
> +	     __i++)
> +
> +#define pci_bus_for_each_resource(bus, res, i)					\
> +	__pci_bus_for_each_resource(bus, res, i, )
> +
> +#define pci_bus_for_each_resource_p(bus, res)					\
> +	__pci_bus_for_each_resource(bus, res, __i, unsigned int)

I like these changes a lot, too!

Same comments about _p vs _idx and __pci_bus_for_each_resource(...,
vartype).

Also would prefer 80 char max instead of 81.
