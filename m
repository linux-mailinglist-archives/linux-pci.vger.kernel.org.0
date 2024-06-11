Return-Path: <linux-pci+bounces-8592-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9523A903FC8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 17:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94DC41C2313A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 15:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C9F18EB1;
	Tue, 11 Jun 2024 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx52t0bj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DEB1BF53
	for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2024 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718118664; cv=none; b=G7Nmh74oDIZ+T3OUK2poPag1++TjKZqTyd/yJI3TUL68LMYwo62d2O5OPZXH61Bf+myHEhMCYIUJLjWD6cZsRkodwHxkjjxjaEdxLWomTa+JdgdNoFJeC4Rz9JQARiKxsZ7yf2Rf2LJjUM5JQee5rmWRAYVPY8301BbTOJom5sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718118664; c=relaxed/simple;
	bh=1NZJRWQ9ztiFyKhofnjpQUeXbFE1VF+39EKByfjc6Js=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tMIsgKw0exqPIBKSg+HcY3zlOPUSpoTmb0PO+GPAf2oENcavNoUdASWFu23l3ZuCrjwiQ97GM1oy5CbT6UhY2MtTv/CA8o+r+eiEsRh36SKFTPc087j5a0vM28c1bYU8oncftz0RT/fe0bsLGgUxAEMcuua0KUmBvZWSEMX3kJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx52t0bj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A1BC2BD10;
	Tue, 11 Jun 2024 15:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718118664;
	bh=1NZJRWQ9ztiFyKhofnjpQUeXbFE1VF+39EKByfjc6Js=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Zx52t0bj159hG7xUPopUtv14sPnavw5NaztCisFG0qneB/BpaESxogivYUjgWYt+f
	 +WAAYXdZpwjiCJp9IMaIHYg142v5vsbmA2C1MAAAW15S4nZxcxiN4o+ou41ielEzYt
	 /4ZoquvatKK/pZDIW0rRxwLsIaSGrG4wC7VOutYx0IiuXHS2LPuk+/8Uko2z8Wu2zL
	 xilQmp21louw3GhiXKCQ3VY9/8bCCenms/DYxgeJSAmq1bbQRKxaStqqp62oTuRrO0
	 j+4UW0mS24RiNo68gNTSQvgl5CgjALjpm3dQ3c6MkuQpKFa9o8CPtrcRDuozk35OCk
	 8K3MYAplF0yAA==
Date: Tue, 11 Jun 2024 10:11:02 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: Linux warns `Unknown NUMA node; performance will be reduced`
Message-ID: <20240611151102.GA963259@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4dcdc648-e09d-4f43-a53c-bcb4f54ef476@molgen.mpg.de>

On Mon, Jun 10, 2024 at 10:27:37PM +0200, Paul Menzel wrote:
> Am 10.06.24 um 21:42 schrieb Bjorn Helgaas:
> > On Sun, Jun 09, 2024 at 10:31:05AM +0200, Paul Menzel wrote:
> > > On the servers below Linux warns:
> > > 
> > >       Unknown NUMA node; performance will be reduced
> > 
> > This warning was added by ad5086108b9f ("PCI: Warn if no host bridge
> > NUMA node info"), which appeared in v5.5, so I assume this isn't new.
> > 
> > That commit log says:
> > 
> >    In pci_call_probe(), we try to run driver probe functions on the node where
> >    the device is attached.  If we don't know which node the device is attached
> >    to, the driver will likely run on the wrong node.  This will still work,
> >    but performance will not be as good as it could be.
> > 
> >    On NUMA systems, warn if we don't know which node a PCI host bridge is
> >    attached to.  This is likely an indication that ACPI didn't supply a _PXM
> >    method or the DT didn't supply a "numa-node-id" property.
> > 
> > I assume these are all ACPI systems, so likely missing _PXM.  An
> > acpidump could confirm this.
> 
> I created an issue in the Linux Kernel Bugzilla [1] and attached the output
> of `acpidump` on a Dell PowerEdge T630 there. The DSDT contains:
> 
>         Device (PCI1)
>         {
>         […]
>             Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
>             {
>                 If ((CLOD == 0x00))
>                 {
>                     Return (0x01)
>                 }
>                 Else
>                 {
>                     Return (0x02)
>                 }
>             }
>         […]
>         }

This machine (the T630, from your first message) has several PCI host
bridges:

  ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
  pci_bus 0000:ff: root bus resource [bus ff]

  ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
  pci_bus 0000:7f: root bus resource [bus 7f]

  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
  pci_bus 0000:00: root bus resource [io  0x0000-0x03bb window]
  pci_bus 0000:00: root bus resource [io  0x03bc-0x03df window]
  pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
  pci_bus 0000:00: root bus resource [io  0x1000-0x7fff window]
  pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
  pci_bus 0000:00: root bus resource [mem 0x90000000-0xc7ffbfff window]
  pci_bus 0000:00: root bus resource [mem 0x38000000000-0x3bfffffffff window]
  pci_bus 0000:00: root bus resource [bus 00-7e]

  ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
  pci_bus 0000:80: root bus resource [io  0x8000-0xffff window]
  pci_bus 0000:80: root bus resource [mem 0xc8000000-0xfbffbfff window]
  pci_bus 0000:80: root bus resource [mem 0x3c000000000-0x3ffffffffff window]
  pci_bus 0000:80: root bus resource [bus 80-fe]

PCI0 and PCI1 lead to all your normal PCI devices, they both
implement _PXM, and they have all the usual apertures for PCI I/O and
MMIO space where device BARs live.

UNC0 and UNC1 lead to these special chipset devices, they don't
implement _PXM, and they don't have any resources except the bus
number.  The devices on bus 7f and ff can only be used via config
space accesses, and I have no idea what they are used for.

> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218951

