Return-Path: <linux-pci+bounces-10124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F1B92DBD5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 00:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8AE1F26252
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 22:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5144015E5A2;
	Wed, 10 Jul 2024 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkyArpIz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C414A601;
	Wed, 10 Jul 2024 22:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649822; cv=none; b=Oi+WIL2fwG7JJqBlC4pahgl6UtGKzH73+vxqttkpzhIy8GK//rkFmAdkTBPFDAlpqLYZNGZGImTCiBKGCrpRTboihFXLa4IbtfuE+7bZ4LALN5jtGfo+aMmBaLsKlyUaYIBnWCjer35a0a0m8Z3PB1FMwdfmDNwJVuyIb+wCb10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649822; c=relaxed/simple;
	bh=sl3vX4dbqklexfFxr3u9uz39KIgPv1EQkagg2tLDZDo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=D9g88VbriikyW8hhN11NX/P6nZAiDiwpsG3PNexNnsFYz/nWjx0MZg5Wsgo6cIGj2+mwv+Yg3nPMUViuM57YfIBTLBTOS+pf8LjRxpWlNZaLnqP/yE4TekS1lmZs98TClZvTKLwf0ltmVcmhY1QfqzxDEr3veMGPZ1vQRsVSRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkyArpIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738A9C32781;
	Wed, 10 Jul 2024 22:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720649821;
	bh=sl3vX4dbqklexfFxr3u9uz39KIgPv1EQkagg2tLDZDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=jkyArpIzXh9qd6t1bUcQSy/Eind3lxUvawjeD5uogNZ6lXMrk/ZE8sLXxgBZDmmBX
	 t6APcxqNiCrbjx0/HVEgcDBET16b1jGfdSx/RI9cUM0FdNvb+g8Dk7pXaxwkX6tIZG
	 DP6s6Wyl5xgqRxs10axOvboqxpR0e09M9mPjBv/iC+fmjx1Y6dGo7Qa34y3Cn77WH7
	 TCgiQTQ959IJalNhXiCc04wWq+Meidxw4H/z/HSROdSCeZ0f0s+WtA6OrIEUtn3gCo
	 77yizKLcQJzcddVmDmQmf929wHX8M8KmN7TPdTL6SUoAIcZDYA97CoCgkMmJIZJXT2
	 PpmoQYgXWRhnA==
Date: Wed, 10 Jul 2024 17:16:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiwei Sun <sjiwei@163.com>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
	paul.m.stillwell.jr@intel.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, sunjw10@lenovo.com,
	ahuang12@lenovo.com
Subject: Re: [PATCH v3] PCI: vmd: Create domain symlink before
 pci_bus_add_devices()
Message-ID: <20240710221659.GA262309@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5d99ec8-9e4d-494a-bf62-02b992a042e8@163.com>

[-cc Pawel, Alexey, Tomasz, which all bounced]

On Wed, Jul 10, 2024 at 09:29:25PM +0800, Jiwei Sun wrote:
> On 7/10/24 04:59, Bjorn Helgaas wrote:
> > [+cc Pawel, Alexey, Tomasz for mdadm history]
> > On Wed, Jun 05, 2024 at 08:48:44PM +0800, Jiwei Sun wrote:
> >> From: Jiwei Sun <sunjw10@lenovo.com>
> >>
> >> During booting into the kernel, the following error message appears:
> >>
> >>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: Unable to get real path for '/sys/bus/pci/drivers/vmd/0000:c7:00.5/domain/device''
> >>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: /dev/nvme1n1 is not attached to Intel(R) RAID controller.'
> >>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: No OROM/EFI properties for /dev/nvme1n1'
> >>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: no RAID superblock on /dev/nvme1n1.'
> >>   (udev-worker)[2149]: nvme1n1: Process '/sbin/mdadm -I /dev/nvme1n1' failed with exit code 1.
> >>
> >> This symptom prevents the OS from booting successfully.
> > 
> > I guess the root filesystem must be on a RAID device, and it's the
> > failure to assemble that RAID device that prevents OS boot?  The
> > messages are just details about why the assembly failed?
> 
> Yes, you are right, in our test environment, we installed the SLES15SP6
> on a VROC RAID 1 device which is set up by two NVME hard drivers. And
> there is also a hardware RAID kit on the motherboard with other two NVME 
> hard drivers.

OK, thanks for all the details.  What would you think of updating the
commit log like this?

  The vmd driver creates a "domain" symlink in sysfs for each VMD bridge.
  Previously this symlink was created after pci_bus_add_devices() added
  devices below the VMD bridge and emitted udev events to announce them to
  userspace.

  This led to a race between userspace consumers of the udev events and the
  kernel creation of the symlink.  One such consumer is mdadm, which
  assembles block devices into a RAID array, and for devices below a VMD
  bridge, mdadm depends on the "domain" symlink.

  If mdadm loses the race, it may be unable to assemble a RAID array, which
  may cause a boot failure or other issues, with complaints like this:

  ...

  Create the VMD "domain" symlink before invoking pci_bus_add_devices() to
  avoid this race.

