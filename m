Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB09439DA0
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 19:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhJYRdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 13:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhJYRdl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 13:33:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B75160F6F;
        Mon, 25 Oct 2021 17:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635183078;
        bh=qkZQOeS0cb/nrATaDb14tIKP57NnA3qnp3vvYL4sjOU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=l1NMiuxeBVQwVpH01wnfA7OGaHwUjCRV6PsNkDN4sz6DOAk+JiZ6tjjBPKJkPYtyn
         JkJlNCs5P13UleRU+xaC4In5JC7wULI0ePCVgMinQX7xrKQpuExQ0ZvYMmoiJhJrYD
         dyDICkN5u6a9E3IlG/jSrfp9Ujh7ghQ61rejRJh3V2tafYuZ7YvHDIelQjFYHO5xdZ
         Tb4U7KtQ5yDeko4lGwN5zcryqN2U8levJ9n6xRKOI6UjLIXlc/lFX7230wcsDgbhsr
         Do3hf3SpCNO8puhTQS7FTJGfiyT/Y7BvwSmONGB0M25NS75yZuPH3ts9eosM9zyeWR
         KFyVrF1Pg1SDQ==
Date:   Mon, 25 Oct 2021 12:31:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v2 3/3] PCI/ASPM: Add LTR sysfs attributes
Message-ID: <20211025173117.GA7566@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p4L+NGQE_Z8u5MBN4X3-3Jmj+FdWp+hGo8mumqsQNoxNg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 25, 2021 at 06:33:50PM +0800, Kai-Heng Feng wrote:
> On Thu, Oct 21, 2021 at 11:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Thu, Oct 21, 2021 at 11:51:59AM +0800, Kai-Heng Feng wrote:
> > > Sometimes BIOS may not be able to program ASPM and LTR settings, for
> > > instance, the NVMe devices behind Intel VMD bridges. For this case, both
> > > ASPM and LTR have to be enabled to have significant power saving.
> > >
> > > Since we still want POLICY_DEFAULT honor the default BIOS ASPM settings,
> > > introduce LTR sysfs knobs so users can set max snoop and max nosnoop
> > > latency manually or via udev rules.
> >
> > How is the user supposed to figure out what "max snoop" and "max
> > nosnoop" values to program?
> 
> Actually, the only way I know is to get the value from other OS.

I don't see how this can be a workable solution.  IIUC this is
specifically related to ASPM L1.2.  L1.2 depends on LTR (the max
snoop/nosnoop values) and the TPOWER_ON and Common_Mode_Restore_Time
values.  PCIe r5.0, sec 5.5.4, says:

  Prior to setting either or both of the enable bits for L1.2, the
  values for TPOWER_ON, Common_Mode_Restore_Time, and, if the ASPM
  L1.2 Enable bit is to be Set, the LTR_L1.2_THRESHOLD (both Value and
  Scale fields) must be programmed.

  The TPOWER_ON and Common_Mode_Restore_Time fields must be programmed
  to the appropriate values based on the components and AC coupling
  capacitors used in the connection linking the two components. The
  determination of these values is design implementation specific.

I do not think collecting values from some other OS is a reasonable
way to set these.  The values would apparently depend on the
electrical design of the particular machine.

> > If we add this, I'm afraid we'll have people programming random things
> > that seem to work but are not actually reliable.
> 
> IMO users need to take full responsibility for own doings.
> Also, it's already doable by using setpci...

I don't think it currently does, but setpci should taint the kernel.

If users want to write setpci scripts to fiddle with stuff, that's
great, but that moves it outside the supportable realm.  If we provide
a sysfs interface to do this, then it becomes more of *our* problem to
make it work correctly, and I don't think that's practical in this
case.

> If we don't want to add LTR sysfs, what other options do we have to
> enable VMD ASPM and LTR by default since BIOS doesn't do it for us?
> 1) Enable it in the PCI or VMD driver, however this approach violates
> POLICY_DEFAULT.
> 2) Use `setpci` directly in udev rules to enable VMD ASPM and LTR.
> 
> I think 2) is bad, and since 1) isn't so good either, the approach in
> this patch may be the best compromise.

I do not know how to safely enable L1.2.  It's likely that I'm just
missing something, but I don't see enough information in PCI config
space and the PCI Firmware interface (_DSM for Latency Tolerance
Reporting) to enable L1.2.  It's possible that a new firmware
interface is required.

I don't think it's wise to enable L1.2 unless we have good confidence
that we know how to do it correctly.  It's hard enough to debug ASPM
issues as it is.

Bjorn
