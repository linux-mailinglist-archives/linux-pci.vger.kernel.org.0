Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13C1414E59
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbhIVQtg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 12:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhIVQtf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Sep 2021 12:49:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F83260F70;
        Wed, 22 Sep 2021 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632329285;
        bh=MGOe/IwygVJTQbD5FRKLLK+SjQ/qKk4Dwur+p1E8dlk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e3I+D9SbhUyzg6QpOYUoWJY01GEMxcJp52caZaIedt+OVejdQ5GzKwzmTIGSVYKO5
         E9m19/XkCOW2HbhPO+LjLNsiX76UbpdryPV1tCyQyUZPpDwNlDeTmdZj6ijm242/AR
         /9mjPwM87TawsD0VTJ+OMXiHdUoLqS6wFbAB26qugpoZI31PhMpsFzffmLviE3Ifc0
         uF4Pq2SH8SZqU0YgrPpN3NC7LTkrLvcKirv5SAnXTAHIP+U5a1N87qvNWpTOmTaFE8
         Y2T6MA//XlIaKu2t6bpJWNcN+Vvxyfh0epMI0HvfBHADT7sX07h43/kBbVr9y2rLnt
         fINAdcjq+XIgg==
Date:   Wed, 22 Sep 2021 11:48:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Implement re-issuing config requests on
 CRS response
Message-ID: <20210922164803.GA203171@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210922101736.v6qur3qnarccdoqe@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 22, 2021 at 12:17:36PM +0200, Pali Rohár wrote:
> On Thursday 16 September 2021 09:32:57 Bjorn Helgaas wrote:
> > On Wed, Sep 15, 2021 at 12:55:53PM +0200, Pali Rohár wrote:
> > ...

> > > I'm not sure how "legal" it is if userspace / setpci changes some of
> > > these bits. At least on a hardware with a real Root Port device it
> > > should be fully transparent. As hardware handles this re-issue and
> > > kernel then would see (reissued) response.
> > 
> > If setpci changes bits like these, all bets are off.  We can't tell
> > what happened, so we can't rely on any configuration Linux did.  I
> > think we really should taint the kernel when this happens.
> 
> For testing purposes, setpci is still a very good tool.

Yes, absolutely!

> > > Test case: Initialize device, then unbind it from sysfs, reset it (hot
> > > reset or warm reset) and then rescan / reinit it again. Here device is
> > > permitted to send CRS response.
> > > 
> > > We know that more PCIe cards are buggy and sometimes firmware on cards
> > > crashes or resets card logic. Which may put card into initialization
> > > state when it is again permitted to send CRS response.
> > 
> > Yep.  That's a buggy device and normally we would work around it with
> > a quirk.  This particular kind of bug would be hard to work around,
> > but a host bridge driver doesn't seem like the right place to do it
> > because we'd have to do it in *every* such driver.
> 
> This described firmware crashing & card reset logic I saw in more wifi
> cards. Sometimes even wifi drivers itself detects that card does not
> respond and do some its own internal card reset (e.g. iwldvm on laptop).
> So it very common situation.
> 
> But I have not seen that these cards on laptop issue CRS response. Maybe
> because their firmware or PCIe logic bootup too fast (so there is a very
> little window for CRS response) or because CRS response sent to OS did
> not cause any issue.

After a reset, we normally delay 100ms *before* issuing the first
config request to the device, e.g., [1].  I expect that in most cases
the device has completed its initialization in that 100ms and it never
responds with CRS status.

> So no particular workaround is needed for above described scenario.
> 
> 
> But anyway, in case that in future there would be need for disabling CRS
> feature in kernel (e.g. for doing some workaround for endpoint or
> extended pcie switch) then this re-issuing of config request on CRS
> response in pci-aardvark.c would be needed to have similar behavior like
> real HW hen CRS is disabled.

To be pedantic, there's no such thing as "disabling CRS".  CRS is a
required feature with no enable/disable bit.  There is only "enabling
or disabling CRS *Software Visibility*".

The config read of Vendor ID after a reset should be done by the PCI
core, not a device driver.  If we disable CRS SV, the only outcomes of
that read are:

  1) Valid Vendor ID data, or

  2) Failed transaction, typically reported as 0xffff data (and, I
     expect, an Unsupported Request or similar error logged)

In either case there may have been zero or more retries on PCIe.  The
PCI core needs to handle the failure case sensibly even though it has
no idea whether the read has been retried.

> And I like the idea if driver is "feature complete" and prepared also
> for other _valid_ code paths. This is just my opinion.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci.c?id=v5.14#n4651
