Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F4641C7DB
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 17:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345039AbhI2PJW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 11:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345023AbhI2PJU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 11:09:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F65261381;
        Wed, 29 Sep 2021 15:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632928059;
        bh=AJdCkz19tywpmnE6ujJZhJvh7reuETtJGcGdRabZHzU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sSi0SwCzz8C8cKBXIeVi1NcyJcpU537ENlt8iQzOUSnqS8+ED615JqakwctIbkSgy
         rZXaUQlzrjdBXkFpBsaHiehZhyH3I2Vb/Tq7yO2jedOSKY6N9B/dzxMrk0o8IiIh5V
         O8f2t9SEgU1GTX763aihLZgzFGicGLLv0x7jntXqh33drGtu5YMw7c1HyiCD/PyC9T
         PuM2yckWmapkQ1NlyzPERhk9NqVhDLC/nUr4ECZjGeRMsnIMoLBaEDGU4NwEsdb3GI
         OYQCV+s7OfNLAdKq0t4LjKHXHkIvz31S6jM0r4JwG6l/s+09GS3T2iGWM2Sj+gJ4EB
         fe9iWjqBF3U1g==
Date:   Wed, 29 Sep 2021 10:07:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 0/7] PCI: ACPI: Get rid of struct pci_platform_pm_ops
 and clean up code
Message-ID: <20210929150737.GA766999@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gr+o_AO7-EGRofU2UN_8aXivh5c-VQ9VKz7o4ZNq=VQw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 02:00:59PM +0200, Rafael J. Wysocki wrote:
> On Wed, Sep 29, 2021 at 1:28 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Ferry]
> >
> > On Mon, Sep 20, 2021 at 08:52:19PM +0200, Rafael J. Wysocki wrote:
> > > Hi All,
> > >
> > > As explained in the changelog of patch [2/7], using struct pci_platform_pm_ops
> > > for ACPI is not particularly beneficial, so it is better to get rid of it and
> > > call the functions pointed to by it directly from the PCI core.
> > >
> > > However, struct pci_platform_pm_ops is also used by the Intel MID support code,
> > > but it is actually better to call the MID PM function directly from the PCI
> > > core either, which is done in patch [1/7].
> > >
> > > After these changes, patch [3/7] removes struct pci_platform_pm_ops and the
> > > rest is just cleanups and some code consolidation on top of that.
> >
> > I like these a lot.  Not sure exactly where everything is after the
> > conversation with Ferry.
> 
> It's mostly OK, the problem was in one of the "tail" patches that was
> not rebased properly.
> 
> There will be a follow-up series to test for Ferry (later today).
> 
> >  Let me know if I should be doing anything.
> 
> I'm going to take this lot if that's not a problem.  If I need
> anything from you, I'll let you know.

Sounds good, thanks, Rafael!

Bjorn
