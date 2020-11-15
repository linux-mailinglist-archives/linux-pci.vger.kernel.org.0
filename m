Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514CE2B3925
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 21:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgKOU1W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 15:27:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727375AbgKOU1W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Nov 2020 15:27:22 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 149ED22370;
        Sun, 15 Nov 2020 20:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605472041;
        bh=DsG/M6wWbYUsYN9gKB8XjsEZ0mTQl+lpn9KqWXW52xY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QwF4vJb4vmikz/QUv2seGm1Zo72ArpksNSgm+9Xk7D5y69JWays3oCtutf+E3Am5k
         UHIqvgC59krEFNkL0ckvZfsDeosQEpzxxOErtwTRXaNv3KXUWpVfGflL6a/ihyP4mN
         uy2NDDF6H9WD8IAcxi/qYnrPTu/MbhuLjE38LiDA=
Date:   Sun, 15 Nov 2020 14:27:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add sysfs attribute for PCI device power state
Message-ID: <20201115202719.GA1239987@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <688dcd74-3acc-bc28-7ba3-55fdedbe6e70@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 15, 2020 at 01:45:18PM +0100, Maximilian Luz wrote:
> On 11/15/20 7:08 AM, Krzysztof Wilczyński wrote:
> > On 20-11-02 15:15:20, Maximilian Luz wrote:
> > > While most PCI power-states can be queried from user-space via lspci,
> > > this has some limits. Specifically, lspci fails to provide an accurate
> > > value when the device is in D3cold as it has to resume the device before
> > > it can access its power state via the configuration space, leading to it
> > > reporting D0 or another on-state. Thus lspci can, for example, not be
> > > used to diagnose power-consumption issues for devices that can enter
> > > D3cold or to ensure that devices properly enter D3cold at all.
> > > 
> > > To alleviate this issue, introduce a new sysfs device attribute for the
> > > PCI power state, showing the current power state as seen by the kernel.
> > 
> > Very nice!  Thank you for adding this.
> > 
> > [...]
> > > +/* PCI power state */
> > > +static ssize_t power_state_show(struct device *dev,
> > > +				struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct pci_dev *pci_dev = to_pci_dev(dev);
> > > +	pci_power_t state = READ_ONCE(pci_dev->current_state);
> > > +
> > > +	return sprintf(buf, "%s\n", pci_power_name(state));
> > > +}
> > > +static DEVICE_ATTR_RO(power_state);
> > [...]
> > 
> > Curious, why did you decide to use the READ_ONCE() macro here?  Some
> > other drivers exposing data through sysfs use, but certainly not all.
> 
> As far as I can tell current_state is normally guarded by the device
> lock, but here we don't hold that lock. I generally prefer to be
> explicit about those kinds of access, if only to document that the value
> can change here.
> 
> In this case it should work fine without it, but this also has the
> benefit that if someone were to add a change like
> 
>   if (state > x)
>           state = y;
> 
> later on (here or even in pci_power_name() due to inlining), things
> wouldn't break as we explicitly forbid the compiler to load
> current_state more than once. Without the READ_ONCE, the compiler would
> be theoretically allowed to do two separate reads then (although
> arguably unlikely it would end up doing that).
> 
> Also there's no downside of marking it as READ_ONCE here as far as I can
> tell, as in that context the value will always have to be loaded from
> memory.

I think something read from sysfs is a snapshot with no guarantee
about how long it will remain valid, so I don't see a problem with the
value being stale by the time userspace consumes it.

If there's a downside to doing two separate reads, we could mention
that in the commit log or a comment.

If there's not a specific reason for using READ_ONCE(), I think we
should omit it because using it in one place but not others suggests
that there's something special about this place.

Bjorn
