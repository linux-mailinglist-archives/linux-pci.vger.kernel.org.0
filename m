Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6092B835D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 18:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgKRRtg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 12:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbgKRRtg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 12:49:36 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F9522202;
        Wed, 18 Nov 2020 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605721775;
        bh=V9hoDkikNLt3innAFfk0lqfO39GVuqkZCQSPO7aCGpw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ID7wPFo9iwRjGTcVVkaYzl+dLnC4NkUYQHulrcnywnco7pThZgASeJXUbXAXwTqSw
         I6bhERtcR7btwt9e0TOoDsH6nMVM469Sw9aSmjkj5ddje0F9goZ3I3iVtZKBk02Oii
         xMdaW/TIBWQWqtz5AwqNz9opZA5jjQ/A70Uvbu3A=
Date:   Wed, 18 Nov 2020 11:49:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Add sysfs attribute for PCI device power state
Message-ID: <20201118174933.GA21165@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96da5aa3-a6ff-aeee-430b-bc9958f5aefa@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 15, 2020 at 10:19:22PM +0100, Maximilian Luz wrote:
> On 11/15/20 9:27 PM, Bjorn Helgaas wrote:
> 
> [...]
> 
> > I think something read from sysfs is a snapshot with no guarantee
> > about how long it will remain valid, so I don't see a problem with the
> > value being stale by the time userspace consumes it.
> 
> I agree on this, and the READ_ONCE won't protect against it. The
> READ_ONCE would only protect against future changes, e.g. something like
> 
>     const char *state_names[] = { ... };
> 
>     // check if state is invalid
>     if (READ(pci_dev->current_state) >= ARRAY_SIZE(state_names))
>             return sprintf(..., "invalid");
>     else    // look state up in table
>             return sprintf(..., state_names[READ(pci_dev->current_state)])
> 
> Note that I've explicitly marked the problematic reads here: If those
> are done separately, the invalidity check may pass, but by the time the
> state name is looked up, the value may have changed and may be invalid.
> 
> Note further that if we have something like
> 
>     pci_power_t state = pci_dev->current_state;
> 
> the compiler is, in theory, free to replace each access to "state" with
> a read to pci_dev->current_state. As far as I can tell, the whole point
> of READ_ONCE is to prevent that and ensure that there is only one read.
> 
> Note also that something like this could be easily introduced by
> changing the code in pci_power_name(), as that is likely inlined by the
> compiler. I'm not entirely sure, but I think that the compiler is allowed
> to, at least theoretically, split that into two reads here and inlining
> might be done before further optimization.
> 
> On the other hand, the changes that could lead to issues above are
> fairly unlikely to cause them as the compiler will _probably_ read the
> value only once anyways.

Well, OK, I see your point.  But I'm not convinced it's worth
cluttering the code for this.  There must be dozens of similar cases,
and if we do need to worry about this, I'd like to do it
systematically for all of drivers/pci/ instead of doing it piecemeal.

I do think it's probably worth making sure we can't set
dev->current_state to something that's invalid, and also taking a look
at the PCI core interfaces that take a pci_power_t, i.e., those in
include/linux/pci.h, to make sure they do the right thing if a driver
supplies garbage.

> > If there's a downside to doing two separate reads, we could mention
> > that in the commit log or a comment.
> > 
> > If there's not a specific reason for using READ_ONCE(), I think we
> > should omit it because using it in one place but not others suggests
> > that there's something special about this place.
> 
> I'd argue that there is indeed something special about this place:
> current_state is accessed without holding the device lock (unless I'm
> mistaken and sysfs attributes do acquire the device lock automatically)
> and the state is normally only accessed/changed under it.
> 
> Apart from (hopefully) preventing somewhat unlikely future issues and
> highlighting that it is (somewhat of a) special case, the READ_ONCE does
> not serve any purpose here. As the code is now, omitting it will not
> cause any issues (or really should not make any difference in produced
> code).
> 
> All in all, I'm not entirely sure that it's a good idea to drop the
> READ_ONCE, but I'll defer to you for that judgement.
> 
> Regards,
> Max
