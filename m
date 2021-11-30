Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E80463104
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 11:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhK3KfY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 05:35:24 -0500
Received: from foss.arm.com ([217.140.110.172]:34022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232938AbhK3KfY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Nov 2021 05:35:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E63991063;
        Tue, 30 Nov 2021 02:32:04 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 570C53F694;
        Tue, 30 Nov 2021 02:32:04 -0800 (PST)
Date:   Tue, 30 Nov 2021 10:31:57 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org
Subject: Re: [PATCH 7/7] PCI: aardvark: Reset PCIe card and disable PHY at
 driver unbind
Message-ID: <20211130103157.GA32648@lpieralisi>
References: <20211031181233.9976-1-kabel@kernel.org>
 <20211031181233.9976-8-kabel@kernel.org>
 <20211129164043.GA26244@lpieralisi>
 <20211129181553.41a341bb@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211129181553.41a341bb@thinkpad>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 29, 2021 at 06:15:53PM +0100, Marek Behún wrote:
> On Mon, 29 Nov 2021 16:40:43 +0000
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> > On Sun, Oct 31, 2021 at 07:12:33PM +0100, Marek Behún wrote:
> > > From: Pali Rohár <pali@kernel.org>
> > > 
> > > When unbinding driver, assert PERST# signal which prepares PCIe card for
> > > power down. Then disable link training and PHY.  
> > 
> > This reads as three actions. If we carry them out as a single patch we
> > have to explain why they are related and what problem they are solving
> > as a _single_ commit.
> > 
> > Otherwise we have to split this patch into three and explain each of
> > them as a separate fix.
> > 
> > I understand it is tempting to coalesce missing code in one single
> > change but every commit must implement a single logical change.
> 
> Hi Lorenzo,
> 
> this is a fix for driver remove function. Although each of these things
> could be introduced in separate commits, IMO it doesn't make sense to
> split it. It should have been done this way in the first place when the
> driver removal support was introduced. I guess we could rewrite the
> commit message to:
> 
>   PCI: aardvark: Disable controller entirely at driver unbind

"PCI: aardvark: Fix the controller disabling sequence"

>   Add the following to driver unbind to disable the controller entirely:
>   - asserting PERST# signal
>   - disabling link training
>   - disable PHY
> 
> Would this be okay?

Yes, that's what I meant. I would describe the change in its entirety
not as three fixes - it makes sense to have one single patch as long
as we describe it properly.

Thanks,
Lorenzo
