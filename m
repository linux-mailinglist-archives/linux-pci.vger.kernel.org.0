Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF46B45F50
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfFNNsh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 09:48:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:35205 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbfFNNsd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 09:48:33 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5EDmIRa016982;
        Fri, 14 Jun 2019 08:48:19 -0500
Message-ID: <fdedfe23250f0dcb49619ed9da1d53ff7e7403d8.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 14 Jun 2019 23:48:18 +1000
In-Reply-To: <20190614131253.GR13533@google.com>
References: <5783e36561bb77a1deb6ba67e5a9824488cc69c6.camel@kernel.crashing.org>
         <20190613190248.GH13533@google.com>
         <e6c7854ae360be513f6f43729ed6d4052e289376.camel@kernel.crashing.org>
         <CAKv+Gu95pQ7_OfLbEXHZ_bhYnqOgTBKCmTgqUY27un-Y708BgQ@mail.gmail.com>
         <d5d3e7b9553438482854c97e09543afb7de23eaa.camel@kernel.crashing.org>
         <20190614095742.GA27188@e121166-lin.cambridge.arm.com>
         <906b2576756e82a54b584c3de2d8362602de07ce.camel@kernel.crashing.org>
         <84320a45ef9395d82bf1c5d4d2d7e6db189cbfda.camel@kernel.crashing.org>
         <20190614131253.GR13533@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2019-06-14 at 08:12 -0500, Bjorn Helgaas wrote:
> On Fri, Jun 14, 2019 at 08:43:19PM +1000, Benjamin Herrenschmidt
> wrote:
> 
> > This least to another conversation we hinted at earlier.. we should
> > probably have a way to do the same at least for BARs on ACPI
> > systems so
> > we don't have to temporarily disable access to a device to size
> > them.
> 
> The PCI Enhanced Allocation capability provides a way to do this.  I
> don't know how widely used it is, but it's theoretically possible.

Ok, I have to read about this. I haven't seen a device with that on
yet, it looks messy at a quick glance.

Can ACPI convey the information ? On powerpc and sparc64 we have ways
to read the BAR values from the device-tree created by OF when it
assigned them.

Cheers,
Ben.


