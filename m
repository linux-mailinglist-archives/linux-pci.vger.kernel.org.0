Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279F5365E31
	for <lists+linux-pci@lfdr.de>; Tue, 20 Apr 2021 19:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbhDTRHn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Apr 2021 13:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232913AbhDTRHn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Apr 2021 13:07:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB4FF613AE;
        Tue, 20 Apr 2021 17:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618938431;
        bh=GE4+p/0+TSRy9zrXwA+A3hbFODGJvMZhR/Foyysj8Xk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HFxLz7aoFzH0dK6/RmYz4uKvPbOqqsrjZrNLFT0IJFHa0MGYHmSLVuRUkf6NJfcp2
         xKYJ31miuYE07A0VOVwkFofARekVV5uPsH53TlwnCvLpvAGTuCz47Qo3Dk0Qb6kBqO
         bEjzYiW24Lt7yrxTk8OtCnQkT/PyQdDy0OsDNNWgJbU6LB0Z5T+8vi7ZwOYLMzR4K0
         Jw+g+vqjjmzGPjUzQmz8qO/yeUSA1YZnuxjVNDIUrl/m4/mtN9qOEfyPFy7lsvnZ3o
         me17wq+dO+YMneqYiukxrKqXKJOdGLshp5NDe0HQxB6Je8dtVvJ11HL0YJTctGz0HH
         rf4sI5yfBAR4w==
Date:   Tue, 20 Apr 2021 12:07:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Rajat Jain <rajatja@google.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, rajatxjain@gmail.com
Subject: Re: [PATCH] pci: Rename pci_dev->untrusted to pci_dev->external
Message-ID: <20210420170708.GA2813156@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420061006.GA3523612@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 20, 2021 at 07:10:06AM +0100, Christoph Hellwig wrote:
> On Mon, Apr 19, 2021 at 05:30:49PM -0700, Rajat Jain wrote:
> > The current flag name "untrusted" is not correct as it is populated
> > using the firmware property "external-facing" for the parent ports. In
> > other words, the firmware only says which ports are external facing, so
> > the field really identifies the devices as external (vs internal).
> > 
> > Only field renaming. No functional change intended.
> 
> I don't think this is a good idea.  First the field should have been
> added to the generic struct device as requested multiple times before.

Fair point.  There isn't anything PCI-specific about this idea.  The
ACPI "ExternalFacingPort" and DT "external-facing" are currently only
defined for PCI devices, but could be applied elsewhere.

> Right now this requires horrible hacks in the IOMMU code to get at the
> pci_dev, and also doesn't scale to various other potential users.

Agreed, this is definitely suboptimal.  Do you have other users in
mind?  Maybe they could help inform the plan.

> Second the untrusted is objectively a better name.  Because untrusted
> is how we treat the device, which is what mattes.  External is just
> how we come to that conclusion.

The decision to treat "external" as being "untrusted" is a little bit
of policy that the PCI core really doesn't care about, so I think it
does make some sense to let the places that *do* care decide what to
trust based on "external" and possibly other factors, e.g., whether
the device is a BMC or processes untrusted data, etc.

But I guess it makes sense to wait until we have a better motivation
before renaming it, since we don't gain any functionality here.

Bjorn
