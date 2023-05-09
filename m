Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BD46FCDA4
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 20:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjEISV2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 14:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjEISV1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 14:21:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327EF4C2D;
        Tue,  9 May 2023 11:21:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB6FA6132C;
        Tue,  9 May 2023 18:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE77FC433EF;
        Tue,  9 May 2023 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683656484;
        bh=wTrGWZ/prXac+ksuuHC0df7jUrXSG9zBg0tuZm4eZAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eWEhqVADxc/GqJSwXnOQ3JLmV9EVm67GRKXU/8kCH+e7bYAn4tbjZ8OZRHVaX3ZcO
         S0xv0AhCQd5NINM++YJU/lVWNxRqARJ2JdTZgkf8DKQ/aBVDAb43Y4DpvrsggmiDhc
         VLuK4RypC1++gIMHtYJwDcVU3u+My56Q4IZYK0at1LgOku1qb8yZmqculMrILZXTXZ
         neG8vnzAeERR8/VCvqWmCzd1JtSknWdohvz8yYije8I6fBKpAtZuUigoK/yqxiyRiQ
         4E280Lp7b1rI5aQ6wbmUv7nAdHleWjJ8JY7/fVD00VEW304Ke/w4PCv+lqMsKKDnXi
         XzOdVIUpJ2dRg==
Date:   Tue, 9 May 2023 13:21:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-mips@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
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
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Juergen Gross <jgross@suse.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCH v8 0/7] Add pci_dev_for_each_resource() helper and update
 users
Message-ID: <20230509182122.GA1259567@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404161101.GA3554747@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 04, 2023 at 11:11:01AM -0500, Bjorn Helgaas wrote:
> On Thu, Mar 30, 2023 at 07:24:27PM +0300, Andy Shevchenko wrote:
> > Provide two new helper macros to iterate over PCI device resources and
> > convert users.

> Applied 2-7 to pci/resource for v6.4, thanks, I really like this!

This is 09cc90063240 ("PCI: Introduce pci_dev_for_each_resource()")
upstream now.

Coverity complains about each use, sample below from
drivers/pci/vgaarb.c.  I didn't investigate at all, so it might be a
false positive; just FYI.

	  1. Condition screen_info.capabilities & (2U /* 1 << 1 */), taking true branch.
  556        if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
  557                base |= (u64)screen_info.ext_lfb_base << 32;
  558
  559        limit = base + size;
  560
  561        /* Does firmware framebuffer belong to us? */
	  2. Condition __b < PCI_NUM_RESOURCES, taking true branch.
	  3. Condition (r = &pdev->resource[__b]) , (__b < PCI_NUM_RESOURCES), taking true branch.
	  6. Condition __b < PCI_NUM_RESOURCES, taking true branch.
	  7. cond_at_most: Checking __b < PCI_NUM_RESOURCES implies that __b may be up to 16 on the true branch.
	  8. Condition (r = &pdev->resource[__b]) , (__b < PCI_NUM_RESOURCES), taking true branch.
	  11. incr: Incrementing __b. The value of __b may now be up to 17.
	  12. alias: Assigning: r = &pdev->resource[__b]. r may now point to as high as element 17 of pdev->resource (which consists of 17 64-byte elements).
	  13. Condition __b < PCI_NUM_RESOURCES, taking true branch.
	  14. Condition (r = &pdev->resource[__b]) , (__b < PCI_NUM_RESOURCES), taking true branch.
  562        pci_dev_for_each_resource(pdev, r) {
	  4. Condition resource_type(r) != 512, taking true branch.
	  9. Condition resource_type(r) != 512, taking true branch.

  CID 1529911 (#1 of 1): Out-of-bounds read (OVERRUN)
  15. overrun-local: Overrunning array of 1088 bytes at byte offset 1088 by dereferencing pointer r. [show details]
  563                if (resource_type(r) != IORESOURCE_MEM)
	  5. Continuing loop.
	  10. Continuing loop.
  564                        continue;
