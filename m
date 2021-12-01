Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D3A4653B4
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 18:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbhLARRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 12:17:48 -0500
Received: from foss.arm.com ([217.140.110.172]:42564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351542AbhLARR0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 12:17:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5279414BF;
        Wed,  1 Dec 2021 09:14:04 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0B623F766;
        Wed,  1 Dec 2021 09:14:02 -0800 (PST)
Date:   Wed, 1 Dec 2021 17:13:56 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for
 internal use only
Message-ID: <20211201171356.GA15686@lpieralisi>
References: <20211115112000.23693-1-andriy.shevchenko@linux.intel.com>
 <163837398126.3058.11030158077196581603.b4-ty@arm.com>
 <YaecakqeoSPoqq4k@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaecakqeoSPoqq4k@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01, 2021 at 06:01:46PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 01, 2021 at 03:53:21PM +0000, Lorenzo Pieralisi wrote:
> > On Mon, 15 Nov 2021 13:20:00 +0200, Andy Shevchenko wrote:
> > > Use BIT() as __GENMASK() is for internal use only. The rationale
> > > of switching to BIT() is to provide better generated code. The
> > > GENMASK() against non-constant numbers may produce an ugly assembler
> > > code. On contrary the BIT() is simply converted to corresponding shift
> > > operation.
> > > 
> > > Note, it's the only user of __GENMASK() in the kernel outside of its own realm.
> > > 
> > > [...]
> > 
> > Applied to pci/brcmstb, thanks!
> > 
> > [1/1] PCI: brcmstb: Use BIT() as __GENMASK() is for internal use only
> >       https://git.kernel.org/lpieralisi/pci/c/6ec6eb949d
> 
> Thanks, but there is another patch which changes the logic a bit and cleans up
> more.
> 
>   From: Florian Fainelli <f.fainelli@gmail.com>
>   Subject: [PATCH] PCI: brcmstb: Do not use __GENMASK

Right,

I pulled that one instead, thanks for the heads-up.

Lorenzo
