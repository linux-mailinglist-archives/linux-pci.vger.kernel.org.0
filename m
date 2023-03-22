Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3246C54E2
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 20:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjCVT2J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 15:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjCVT2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 15:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D8B19A2;
        Wed, 22 Mar 2023 12:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD7A6622A0;
        Wed, 22 Mar 2023 19:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E40C433EF;
        Wed, 22 Mar 2023 19:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679513286;
        bh=QIwrcxSinbm192yIC5GYq8pmRiEZXatEfhuZCKvaZVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kI7PD7oKOFUaqAGxpAEV1J4pqcq5sYqOlE6tZdI8XvLDftVUW7xBLrIm39EDMCeew
         YbY7ekOsQ8pk2imeaozqedO08eUYORwgATq+PR72VZKK9Z+xSe875Jwime72E5sujt
         OKX3MZ05HrUnh6VUWqiK4KPTgw44b5/A4+dvjU5eUJO6DS6BfQZ05ojXQDveuaCfbR
         6kmoRGkL8zdl0AgEDHh0jZJq5WemnXINfkZV2PRGtY6aFlS4evcy50ZkNqbrgQ5Ywt
         FkmgtOO8ISwsbbhE86dRqqKL+QyXR15+6PMXkOeNiqH/SJXrUqlZdQCXic7R1fgBC0
         vZjopyk7ipwkQ==
Date:   Wed, 22 Mar 2023 14:28:04 -0500
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
Message-ID: <20230322192804.GA2485349@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320131633.61680-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy and Mika,

I really like the improvements here.  They make the code read much
better.

On Mon, Mar 20, 2023 at 03:16:30PM +0200, Andy Shevchenko wrote:
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> ...

>  static void fixup_winbond_82c105(struct pci_dev* dev)
>  {
> -	int i;
> +	struct resource *r;
>  	unsigned int reg;
>  
>  	if (!machine_is(pseries))
> @@ -251,14 +251,14 @@ static void fixup_winbond_82c105(struct pci_dev* dev)
>  	/* Enable LEGIRQ to use INTC instead of ISA interrupts */
>  	pci_write_config_dword(dev, 0x40, reg | (1<<11));
>  
> -	for (i = 0; i < DEVICE_COUNT_RESOURCE; ++i) {
> +	pci_dev_for_each_resource_p(dev, r) {
>  		/* zap the 2nd function of the winbond chip */
> -		if (dev->resource[i].flags & IORESOURCE_IO
> -		    && dev->bus->number == 0 && dev->devfn == 0x81)
> -			dev->resource[i].flags &= ~IORESOURCE_IO;
> -		if (dev->resource[i].start == 0 && dev->resource[i].end) {
> -			dev->resource[i].flags = 0;
> -			dev->resource[i].end = 0;
> +		if (dev->bus->number == 0 && dev->devfn == 0x81 &&
> +		    r->flags & IORESOURCE_IO)

This is a nice literal conversion, but it's kind of lame to test
bus->number and devfn *inside* the loop here, since they can't change
inside the loop.

> +			r->flags &= ~IORESOURCE_IO;
> +		if (r->start == 0 && r->end) {
> +			r->flags = 0;
> +			r->end = 0;
>  		}
>  	}

>  #define pci_resource_len(dev,bar) \
>  	((pci_resource_end((dev), (bar)) == 0) ? 0 :	\
>  							\
> -	 (pci_resource_end((dev), (bar)) -		\
> -	  pci_resource_start((dev), (bar)) + 1))
> +	 resource_size(pci_resource_n((dev), (bar))))

I like this change, but it's unrelated to pci_dev_for_each_resource()
and unmentioned in the commit log.

> +#define __pci_dev_for_each_resource(dev, res, __i, vartype)		\
> +	for (vartype __i = 0;						\
> +	     res = pci_resource_n(dev, __i), __i < PCI_NUM_RESOURCES;	\
> +	     __i++)
> +
> +#define pci_dev_for_each_resource(dev, res, i)				\
> +       __pci_dev_for_each_resource(dev, res, i, )
> +
> +#define pci_dev_for_each_resource_p(dev, res)				\
> +	__pci_dev_for_each_resource(dev, res, __i, unsigned int)

This series converts many cases to drop the iterator variable ("i"),
which is fantastic.

Several of the remaining places need the iterator variable only to
call pci_claim_resource(), which could be converted to take a "struct
resource *" directly without much trouble.

We don't have to do that pci_claim_resource() conversion now, but
since we're converging on the "(dev, res)" style, I think we should
reverse the names so we have something like:

  pci_dev_for_each_resource(dev, res)
  pci_dev_for_each_resource_idx(dev, res, i)

Not sure __pci_dev_for_each_resource() is worthwhile since it only
avoids repeating that single "for" statement, and passing in "vartype"
(sometimes empty to implicitly avoid the declaration) is a little
complicated to read.  I think it'd be easier to read like this:

  #define pci_dev_for_each_resource(dev, res)                      \
    for (unsigned int __i = 0;                                     \
         res = pci_resource_n(dev, __i), __i < PCI_NUM_RESOURCES;  \
         __i++)

  #define pci_dev_for_each_resource_idx(dev, res, idx)             \
    for (idx = 0;                                                  \
         res = pci_resource_n(dev, idx), idx < PCI_NUM_RESOURCES;  \
         idx++)

Bjorn
