Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E2F3D94AF
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 19:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhG1Rza (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 13:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231222AbhG1Rz2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 13:55:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C335D61050;
        Wed, 28 Jul 2021 17:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627494926;
        bh=eR8Mb5mftbz5DEwh6BIcjxWxE2NDjLa/HY+rtPuS9Vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NBwah9bZgNw8mAa/hy200SaKVPPUf1pG5zNHfsFuI7DCrIdyePnsfyF2sXrGWm4O5
         BHzg3H5l5A8IKUCzt15r6OYMiPLUSPnfQkAoyp6Bz+VFoas/XkFnd1eigmYIlgTbRs
         cT78xYg68AOSUrm2j6jmU1NMkud+PR/zFJOznMttNDBx8kGW654eekl0zrf6Dis7CB
         aHmylcxM+f/sch4yg1QMBKL9Esh1DEAX22aMJ8/bn4Z9ED9mBAmjlbRZmjcLvROTH/
         wpO++JjkQMyJg7ZM+SIavBU+futcLJfhqud03dX1cswHe9Nz9jmZmjILFXIWUUhbvK
         xW7FIZWiotJDw==
Date:   Wed, 28 Jul 2021 12:55:24 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 8/8] PCI: Change the type of probe argument in reset
 functions
Message-ID: <20210728175524.GA834270@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728173514.77yiv2vjvjpf6ao5@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 28, 2021 at 11:05:14PM +0530, Amey Narkhede wrote:
> On 21/07/27 05:22PM, Bjorn Helgaas wrote:
> > On Fri, Jul 09, 2021 at 06:08:13PM +0530, Amey Narkhede wrote:
> > > Introduce a new enum pci_reset_mode_t to make the context of probe argument
> > > in reset functions clear and the code easier to read.  Change the type of
> > > probe argument in functions which implement reset methods from int to
> > > pci_reset_mode_t to make the intent clear.
> >
> > Not sure adding an enum and a PCI_RESET_MODE_MAX seems worth it to me.
> > It's really a boolean parameter, and I'd be happy to change it to a
> > bool.  But I don't think it's worth checking against
> > PCI_RESET_MODE_MAX unless we need more than two options.
> >
> Is it okay to use PCI_RESET_PROBE and PCI_RESET_DO_RESET as bool.
> That would be less confusing than directly using true/false.

You mean like this?

  #define PCI_RESET_DO_RESET  false
  #define PCI_RESET_PROBE     true

I don't think there's a huge amount of value, but I guess that's OK as
long as it's confined to drivers/pci/, i.e., not exposed via
include/linux/pci.h.
