Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06F14698D5
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 15:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343622AbhLFO3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 09:29:38 -0500
Received: from foss.arm.com ([217.140.110.172]:58812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343580AbhLFO3h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Dec 2021 09:29:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C566F1FB;
        Mon,  6 Dec 2021 06:26:08 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FCFE3F5A1;
        Mon,  6 Dec 2021 06:26:07 -0800 (PST)
Date:   Mon, 6 Dec 2021 14:26:01 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: pci-bridge-emul: Various fixes
Message-ID: <20211206142601.GA20570@lpieralisi>
References: <20211124155944.1290-1-pali@kernel.org>
 <163879317819.3988.9390653012838076482.b4-ty@arm.com>
 <20211206122451.v4pci63ox3hntsw6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211206122451.v4pci63ox3hntsw6@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 06, 2021 at 01:24:51PM +0100, Pali Rohár wrote:
> On Monday 06 December 2021 12:19:57 Lorenzo Pieralisi wrote:
> > On Wed, 24 Nov 2021 16:59:38 +0100, Pali Rohár wrote:
> > > This patch series contains various fixes for pci-bridge-emul code.
> > > This code is used only by pci-aardvark.c and pci-mvebu.c drivers.
> > > 
> > > Pali Rohár (6):
> > >   PCI: pci-bridge-emul: Make expansion ROM Base Address register
> > >     read-only
> > >   PCI: pci-bridge-emul: Properly mark reserved PCIe bits in PCI config
> > >     space
> > >   PCI: pci-bridge-emul: Add definitions for missing capabilities
> > >     registers
> > >   PCI: pci-bridge-emul: Fix definitions of reserved bits
> > >   PCI: pci-bridge-emul: Correctly set PCIe capabilities
> > >   PCI: pci-bridge-emul: Set PCI_STATUS_CAP_LIST for PCIe device
> > > 
> > > [...]
> > 
> > Applied to pci/bridge-emul, thanks!
> > 
> > [1/6] PCI: pci-bridge-emul: Make expansion ROM Base Address register read-only
> >       https://git.kernel.org/lpieralisi/pci/c/1c1a3b4d3e
> > [2/6] PCI: pci-bridge-emul: Properly mark reserved PCIe bits in PCI config space
> >       https://git.kernel.org/lpieralisi/pci/c/7b067ac63a
> > [3/6] PCI: pci-bridge-emul: Add definitions for missing capabilities registers
> >       https://git.kernel.org/lpieralisi/pci/c/faa3e547f4
> 
> Hello Lorenzo! This patch "PCI: pci-bridge-emul: Add definitions for
> missing capabilities registers" is now in your two different branches:
> pci/bridge-emul and pci/aardvark. Not sure if you want to have this same
> patch on two places... So please check.

Dropped, thanks.

Lorenzo

> > [4/6] PCI: pci-bridge-emul: Fix definitions of reserved bits
> >       https://git.kernel.org/lpieralisi/pci/c/a3ab28a2e3
> > [5/6] PCI: pci-bridge-emul: Correctly set PCIe capabilities
> >       https://git.kernel.org/lpieralisi/pci/c/0f7ba81700
> > [6/6] PCI: pci-bridge-emul: Set PCI_STATUS_CAP_LIST for PCIe device
> >       https://git.kernel.org/lpieralisi/pci/c/32051099e8
> > 
> > Thanks,
> > Lorenzo
