Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0441852713B
	for <lists+linux-pci@lfdr.de>; Sat, 14 May 2022 15:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiENNbc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 May 2022 09:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232492AbiENNbU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 14 May 2022 09:31:20 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E1411C16;
        Sat, 14 May 2022 06:31:16 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id E990D102F6762;
        Sat, 14 May 2022 15:31:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id C923D2E6CDA; Sat, 14 May 2022 15:31:14 +0200 (CEST)
Date:   Sat, 14 May 2022 15:31:14 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gavin Hindman <gavin.hindman@intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-cxl@vger.kernel.org, CHUCK_LEVER <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 0/1] DOE usage with pcie/portdrv
Message-ID: <20220514133114.GA14833@wunner.de>
References: <20220503153449.4088-1-Jonathan.Cameron@huawei.com>
 <CAPcyv4geBaTkoJ+Gefgq6RaKHtB3NMh5ruZ-1yV_i0UVaw3SWA@mail.gmail.com>
 <20220507101848.GB31314@wunner.de>
 <20220509104806.00007c61@Huawei.com>
 <20220511191345.GA26623@wunner.de>
 <CAPcyv4idjqiY9CV=sghDbWqQS_PM2Z0xWxr2MsrMxS-XqU1F=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4idjqiY9CV=sghDbWqQS_PM2Z0xWxr2MsrMxS-XqU1F=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 11, 2022 at 12:42:24PM -0700, Dan Williams wrote:
> I think power-management effects relative to IDE is a soft spot of the
> specification.

When resuming from system sleep, the kernel restores a device's
config space in pci_pm_resume_noirq(), then calls the driver's
->resume_noirq() callback.  The driver is free to assume that
the device is accessible und usable at that point.

IDE breaks that contract if establishment of an SPDM session
depends on user space.  We can't call out to user space for
authentication during the resume_noirq phase because interrupts
are still disabled.

Drivers would have to be aware that IDE has not yet been
re-established and refrain from accessing the device.
Any child devices of the PCI device cannot be resumed
until then.

Ideally we'd want IDE to be transparent to drivers.
That's impossible if their access to devices is forbidden
after system sleep for an indefinite amount of time.

Runtime PM has similar issues as system sleep if the device
was in D3cold.

Reliance on user space also entails a risk of deadlocks:
Let's say user space process A accesses a PCI device,
the kernel runtime resumes the device and calls out to
user space process B to authenticate it.  If A is holding
a resource that B requires, the two tasks deadlock and
the device never becomes accessible.

The more I think about it, the more attractive does Jonathan's
in-kernel SPDM approach look.  Performing SPDM authentication and
IDE setup in the kernel would allow us to retain all existing
assumptions and behavior around power management and reset recovery,
avoid driver awareness of IDE and avoid deadlocks.


> > If setting up an SPDM session is dependent on user space, the kernel
> > would have to leave a device in an inoperable state after runtime resume
> > or reset, until user space gets around to initiate SPDM.
> 
> Yes, this seems acceptable from the perspective of server platforms
> that can make the power management vs security tradeoff.

It seems likely that IDE will not only be used on server platforms.

I'll see to to it that I provide more review feedback to Jonathan's RFC
series so that we can move forward with this.

Thanks,

Lukas
