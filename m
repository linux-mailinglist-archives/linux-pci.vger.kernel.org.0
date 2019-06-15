Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB1B246D7B
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2019 03:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfFOBSV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 21:18:21 -0400
Received: from gate.crashing.org ([63.228.1.57]:49168 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfFOBSV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 21:18:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5F1I7hS012437;
        Fri, 14 Jun 2019 20:18:08 -0500
Message-ID: <f0a14c9b46aa110485ea32cecb57c7c2c04fac43.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 15 Jun 2019 11:18:06 +1000
In-Reply-To: <20190614201318.GT13533@google.com>
References: <5783e36561bb77a1deb6ba67e5a9824488cc69c6.camel@kernel.crashing.org>
         <20190613190248.GH13533@google.com>
         <e6c7854ae360be513f6f43729ed6d4052e289376.camel@kernel.crashing.org>
         <CAKv+Gu95pQ7_OfLbEXHZ_bhYnqOgTBKCmTgqUY27un-Y708BgQ@mail.gmail.com>
         <d5d3e7b9553438482854c97e09543afb7de23eaa.camel@kernel.crashing.org>
         <20190614095742.GA27188@e121166-lin.cambridge.arm.com>
         <906b2576756e82a54b584c3de2d8362602de07ce.camel@kernel.crashing.org>
         <84320a45ef9395d82bf1c5d4d2d7e6db189cbfda.camel@kernel.crashing.org>
         <20190614131253.GR13533@google.com>
         <fdedfe23250f0dcb49619ed9da1d53ff7e7403d8.camel@kernel.crashing.org>
         <20190614201318.GT13533@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2019-06-14 at 15:13 -0500, Bjorn Helgaas wrote:

> Ok, I have to read about this. I haven't seen a device with that on
> > yet, it looks messy at a quick glance.
> > 
> > Can ACPI convey the information ? On powerpc and sparc64 we have ways
> > to read the BAR values from the device-tree created by OF when it
> > assigned them.
> 
> I agree, EA is messy.
> 
> I don't think it's feasible to do this in ACPI.  It's a pretty
> fundamental principle of PCI that you can discover what resources a
> device needs and uses by looking at its config space.  In general PCIe
> requires ECAM, which gives the OS direct access to config space,
> although it does allow exceptions for architecture-specific firmware
> interfaces for accessing config space, e.g., ia64 SAL (PCIe r4.0, sec
> 7.2.2).

So this isn't something I need, but if others do, we can find a
reasonable compromise here and push it to the spec. It's actually
fairly easy:

If a device is used by FW (SMM, SMCCC or whatever other runtime thingy)
to the extent that temporarily disabling it for BAR sizing can cause
random boot failures (if the wrong event happens at the wrong time), it
would be easy for FW to "mark" that device as such (_DSM #5 == 2 ? just
kidding...) and provide some forms of properties/datas that expose the
resources that were assigned. On OF, the properties for that already
exist, so just adding something like "no-bar-sizing" or such in the
node for the device would do.

It's easy because FW only has to "represent" endpoints that have such
properties and leave everything else to the OS. There is no need to
mandate a full representation of all PCI devices.

There are a few details to be careful of, for example, if any bridge in
the parent chain of such an endpoint has BARs (not windows, actual
BARs), then they should have those properties too, otherwise sizing
them will temporarily disable the path to the device since BAR sizing
should be done with memory/io decode off.

But otherwise, it's a pretty trivial thing to specify and implement I
suspect. A lot easier than requiring HW to implement EA is my gut
feeling :-)

As I said, I don't have a pressing need for that now (could have come
in handy back in the powermac days ... oh well). But if enough people
do, I'm happy to help ironing something out.

Cheers,
Ben



