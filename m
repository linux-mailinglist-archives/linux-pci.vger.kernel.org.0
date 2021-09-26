Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C443418842
	for <lists+linux-pci@lfdr.de>; Sun, 26 Sep 2021 13:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhIZLO6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Sep 2021 07:14:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230128AbhIZLO6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Sep 2021 07:14:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14D0260F9C;
        Sun, 26 Sep 2021 11:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632654802;
        bh=UNzD+vYlv7wcsplcUiMVUTy0bdIN+262+sQINEJvh2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ke48rWrEhs5GdEgH+SxwytgQPuw+0D9J0v25fBeCSXIJUI0ETfHCWg5QXa6JxJnsj
         ci0sjkxE6tqwXyJ7Je/mqGgn6F6SGi6QzTBw/uQCkTrPNcwcmrYFndc9N/u8yPWDDO
         /7/ImQLHNCg6/KjMlK7hhgiI0l2QtWUQMEdWtlID+t/6Dtq1Lp4aOucmRRumljlwjx
         ikE4uqhxWZ9V9VZCJ+giBjW6E26MkS/kkRIfpI6VaSfZXSPrxlfTZQ86KSgnnVlixu
         aU47P3FSvz0WQho2K3TSWjg/F+xGfWN/Dd/qNcaMVENZA93RErT6A3bCjW0tLeWK9R
         wfGPQWZVjjGrQ==
Received: by pali.im (Postfix)
        id 7FFBA60D; Sun, 26 Sep 2021 13:13:19 +0200 (CEST)
Date:   Sun, 26 Sep 2021 13:13:19 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Implement re-issuing config requests on
 CRS response
Message-ID: <20210926111319.sgtfsjovkhfkh4qs@pali>
References: <20210922101736.v6qur3qnarccdoqe@pali>
 <20210922164803.GA203171@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210922164803.GA203171@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 22 September 2021 11:48:03 Bjorn Helgaas wrote:
> On Wed, Sep 22, 2021 at 12:17:36PM +0200, Pali Rohár wrote:
> > On Thursday 16 September 2021 09:32:57 Bjorn Helgaas wrote:
> > > On Wed, Sep 15, 2021 at 12:55:53PM +0200, Pali Rohár wrote:
> > > ...
> 
> > > > I'm not sure how "legal" it is if userspace / setpci changes some of
> > > > these bits. At least on a hardware with a real Root Port device it
> > > > should be fully transparent. As hardware handles this re-issue and
> > > > kernel then would see (reissued) response.
> > > 
> > > If setpci changes bits like these, all bets are off.  We can't tell
> > > what happened, so we can't rely on any configuration Linux did.  I
> > > think we really should taint the kernel when this happens.
> > 
> > For testing purposes, setpci is still a very good tool.
> 
> Yes, absolutely!
> 
> > > > Test case: Initialize device, then unbind it from sysfs, reset it (hot
> > > > reset or warm reset) and then rescan / reinit it again. Here device is
> > > > permitted to send CRS response.
> > > > 
> > > > We know that more PCIe cards are buggy and sometimes firmware on cards
> > > > crashes or resets card logic. Which may put card into initialization
> > > > state when it is again permitted to send CRS response.
> > > 
> > > Yep.  That's a buggy device and normally we would work around it with
> > > a quirk.  This particular kind of bug would be hard to work around,
> > > but a host bridge driver doesn't seem like the right place to do it
> > > because we'd have to do it in *every* such driver.
> > 
> > This described firmware crashing & card reset logic I saw in more wifi
> > cards. Sometimes even wifi drivers itself detects that card does not
> > respond and do some its own internal card reset (e.g. iwldvm on laptop).
> > So it very common situation.
> > 
> > But I have not seen that these cards on laptop issue CRS response. Maybe
> > because their firmware or PCIe logic bootup too fast (so there is a very
> > little window for CRS response) or because CRS response sent to OS did
> > not cause any issue.
> 
> After a reset, we normally delay 100ms *before* issuing the first
> config request to the device, e.g., [1].  I expect that in most cases
> the device has completed its initialization in that 100ms and it never
> responds with CRS status.
> 
> > So no particular workaround is needed for above described scenario.
> > 
> > 
> > But anyway, in case that in future there would be need for disabling CRS
> > feature in kernel (e.g. for doing some workaround for endpoint or
> > extended pcie switch) then this re-issuing of config request on CRS
> > response in pci-aardvark.c would be needed to have similar behavior like
> > real HW hen CRS is disabled.
> 
> To be pedantic, there's no such thing as "disabling CRS".  CRS is a
> required feature with no enable/disable bit.  There is only "enabling
> or disabling CRS *Software Visibility*".

Of course, I mean that CRSSVE bit.

> The config read of Vendor ID after a reset should be done by the PCI
> core, not a device driver.

Of course. But in case of unexpected reset (which PCI code does not
detect), card driver at the same time could issue some config read/write
request.

> If we disable CRS SV, the only outcomes of
> that read are:
> 
>   1) Valid Vendor ID data, or
> 
>   2) Failed transaction, typically reported as 0xffff data (and, I
>      expect, an Unsupported Request or similar error logged)

Yes. And I think it should apply also for any other config register, not
just vendor id.

In case error reporting or AER functionality is not supported then there
would be no error logged. And PCI core / kernel does not have to know
that such thing happened.

Anyway, there is probably a candidate wifi card with "not ready" issue:
https://lore.kernel.org/linux-wireless/CAHp75Vd5iCLELx8s+Zvcj8ufd2bN6CK26soDMkZyC1CwMO2Qeg@mail.gmail.com/

> In either case there may have been zero or more retries on PCIe.  The
> PCI core needs to handle the failure case sensibly even though it has
> no idea whether the read has been retried.
> 
> > And I like the idea if driver is "feature complete" and prepared also
> > for other _valid_ code paths. This is just my opinion.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci.c?id=v5.14#n4651
