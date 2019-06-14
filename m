Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9458468A0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 22:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbfFNUNd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 16:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfFNUNc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 16:13:32 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC94E2133D;
        Fri, 14 Jun 2019 20:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560543212;
        bh=xAM7mBjDbgUS5XcFtTkGqbwxqhzw2VQJQpfEmS3r5OU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y9B/wKt8iAZmQzcNZMwojsGSPxWD0nlvAJ9fR2Mgc9gCFoXg973sQdjAjVCP/6T1t
         b9gCFz2nYYCVV+dwHCGPAcSHn7aY/9VRZMzyrF48P1GQ4HMlgijZoW0/5QGEf73pu9
         RW4fNguuPDa39W3Az18UKkqM6+czwwa/16ADuqpE=
Date:   Fri, 14 Jun 2019 15:13:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH v2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
Message-ID: <20190614201318.GT13533@google.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdedfe23250f0dcb49619ed9da1d53ff7e7403d8.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 11:48:18PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2019-06-14 at 08:12 -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 14, 2019 at 08:43:19PM +1000, Benjamin Herrenschmidt
> > wrote:
> > 
> > > This least to another conversation we hinted at earlier.. we should
> > > probably have a way to do the same at least for BARs on ACPI
> > > systems so
> > > we don't have to temporarily disable access to a device to size
> > > them.
> > 
> > The PCI Enhanced Allocation capability provides a way to do this.  I
> > don't know how widely used it is, but it's theoretically possible.
> 
> Ok, I have to read about this. I haven't seen a device with that on
> yet, it looks messy at a quick glance.
> 
> Can ACPI convey the information ? On powerpc and sparc64 we have ways
> to read the BAR values from the device-tree created by OF when it
> assigned them.

I agree, EA is messy.

I don't think it's feasible to do this in ACPI.  It's a pretty
fundamental principle of PCI that you can discover what resources a
device needs and uses by looking at its config space.  In general PCIe
requires ECAM, which gives the OS direct access to config space,
although it does allow exceptions for architecture-specific firmware
interfaces for accessing config space, e.g., ia64 SAL (PCIe r4.0, sec
7.2.2).

Bjorn
