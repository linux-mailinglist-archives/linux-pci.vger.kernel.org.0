Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066143D7F4D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 22:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhG0Udl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 16:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhG0Udk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jul 2021 16:33:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0769C061757;
        Tue, 27 Jul 2021 13:33:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627418016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7bwL+YWPClOHPAbCYq9eO/M7snV0sY4DJkhl01JPF6I=;
        b=lu/MhhKXofy5wDWE1ihim+/K4hwUXRFNgFLJgNGjat2U3GUn0TAF4do0caQo1HiOOiGAef
        p4r6+evhN7kgXIY3CuYBTvleYP3bA2EHDpa5ABZgT5bv0oE59znznIc8p0S7kTBMOFjXBb
        cNpXmnibW8aMH4ORDakUB6b9eI2Xgui1GpttIU0a1bqB4oIGcSrAmFfPxVZt1OEAJveA7o
        lc1HHmgvkjVl7XrYrmlkL0sFWRoABs7WFg+jYGmNb9eW5PZn+jFbD+sCwlkPnypjBVrjVP
        k0AmbNPpLCYpQeN50HB2pdDlaVZB2GBGQSd6mef2CUyi/h53yml3l87pWfP8Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627418016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7bwL+YWPClOHPAbCYq9eO/M7snV0sY4DJkhl01JPF6I=;
        b=RYbxHGnNV+ydR92vBxc088kQrI124dRVQ7hlX7bIye33Jwt/xbSzwKP8Y6jQWtzI7NQYje
        KjV4RrUsImHYjdDw==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj\, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: Re: [patch 1/8] PCI/MSI: Enable and mask MSIX early
In-Reply-To: <20210722214329.GA349464@bjorn-Precision-5520>
References: <20210722214329.GA349464@bjorn-Precision-5520>
Date:   Tue, 27 Jul 2021 22:33:35 +0200
Message-ID: <87r1fjpkdc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 22 2021 at 16:43, Bjorn Helgaas wrote:
> s/MSIX/MSI-X/ in subject

Sure.

> On Wed, Jul 21, 2021 at 09:11:27PM +0200, Thomas Gleixner wrote:
>> The ordering of MSI-X enable in hardware is disfunctional:
>
> s/disfunctional/dysfunctional/, isn't English wonderful ;)

Yes and I'm never going to master it.

>>  1) MSI-X is disabled in the control register
>>  2) Various setup functions
>>  3) pci_msi_setup_msi_irqs() is invoked which ends up accessing
>>     the MSI-X table entries
>>  4) MSI-X is enabled and masked in the control register with the
>>     comment that enabling is required for some hardware to access
>>     the MSI-X table
>> 
>> #4 obviously contradicts #3. The history of this is an issue with the NIU
>
> Annoyingly, if you "git rebase" and reword this commit log, it drops
> this line and the one a few lines below because they start with "#".
> Should be obvious, but took me a few iterations to see what was
> happening.

Cute.

Thanks,

        tglx
