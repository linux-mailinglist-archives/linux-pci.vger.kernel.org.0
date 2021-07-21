Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625A03D1A11
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 00:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhGUWSw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 18:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhGUWSt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 18:18:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14EBC061575;
        Wed, 21 Jul 2021 15:59:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626908364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v6GJRKUoMzgvSiSTUwsY+2KWlUD1TE/AvN0sDCIcKo4=;
        b=b6+yMpH9R3GRTFtvVD0jhjmoj9dNvMtRBFd6NWLRpj9maZx+REArebqY7olq4UVRNoUsxc
        N7EwXjo7mVjXc2eeCNVFH9ij1H2KzI2ns0XDwSDpzN4TjjSc5Dn9LyXvYOFRHkmc4jNJjq
        Gl90JM3SbtJveHBUhMvoUaPnH3+8W79eqmYR4gwRZ1Nj9j4lSmpH7oOlFq9Hhaxa55556N
        oXcNFxtXC45TFRRhBjRyQXgSCWeU1lvVMYbkVaSWnrudcMum+6VYr7n01Ar0oQI78HpRSz
        xKbl8hdFfH3xlsHu1hREbWy6JUafHblFWRheCOUYcBUk57aQQvbWIkn1cTCUjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626908364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v6GJRKUoMzgvSiSTUwsY+2KWlUD1TE/AvN0sDCIcKo4=;
        b=BL2dfejZF7NDipWSpn/oKu9kCTeYuUIweHv1GuQHVAxH4bQLkuxoxiwUjGn9BeaHqOLHUv
        qZ9AeQ9x31WsKiBw==
To:     "Raj\, Ashok" <ashok.raj@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 3/8] PCI/MSI: Enforce that MSI-X table entry is masked for update
In-Reply-To: <20210721223238.GD676232@otc-nc-03>
References: <20210721191126.274946280@linutronix.de> <20210721192650.408910288@linutronix.de> <20210721223238.GD676232@otc-nc-03>
Date:   Thu, 22 Jul 2021 00:59:19 +0200
Message-ID: <87wnpjnuig.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ashok,

On Wed, Jul 21 2021 at 15:32, Ashok Raj wrote:
> On Wed, Jul 21, 2021 at 09:11:29PM +0200, Thomas Gleixner wrote:
>> +		/*
>> +		 * The specification mandates that the entry is masked
>> +		 * when the message is modified:
>> +		 *
>> +		 * "If software changes the Address or Data value of an
>> +		 * entry while the entry is unmasked, the result is
>> +		 * undefined."
>> +		 */
>> +		if (unmasked)
>> +			__pci_msix_desc_mask_irq(entry, PCI_MSIX_ENTRY_CTRL_MASKBIT);
>> +
>
> Is there any locking needs here? say during cpu hotplug and some user-space
> setting affinity?

No. Except for suspend/resume this is always serialized by irq_desc::lock().

Thanks,

        tglx
