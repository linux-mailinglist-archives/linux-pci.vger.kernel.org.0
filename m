Return-Path: <linux-pci+bounces-10166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BB992EC6A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 18:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E525285CC1
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 16:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA1E16C862;
	Thu, 11 Jul 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mtz5Oqfx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8519F16C86A;
	Thu, 11 Jul 2024 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714369; cv=none; b=WlM/RvCZH68dBidmLsgPjE6s9qo2SpN67sKdl5va3NsljnNmW20Uss3XrdUOxb9E2aqy87lcwMCq4zQnt9BMhZnt7F8za4fb8C+ogBDa1qcI/5zlUzDeoGzMttoafVO1Sqrvq/Qljy6SxoyYlCOc+qky9qPD3igNISN1agLyADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714369; c=relaxed/simple;
	bh=7mWvZuNwbK/tZKZmGG9Fc+5OqBJtk/2uCg8dn6+VxCs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sPz7U/isDgz5yABAuw34pZZYaLvjFjROvhYSfE9Bl9/IAejUkpr6YQUVm+RjJUBfiQSUP9jwic13mP+UDCYg3XziA3c/cT2FW2g/9sYI/cQlEXaMAQZbp/6PEkL0asg1gTqPxPc88f0MkMzLq7LxsLcxfEH196jzVkog+N/KyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mtz5Oqfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB97BC116B1;
	Thu, 11 Jul 2024 16:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720714369;
	bh=7mWvZuNwbK/tZKZmGG9Fc+5OqBJtk/2uCg8dn6+VxCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Mtz5Oqfx2Ol7a9hd6OZI2WqTNgkKgfQ7sp6Yhj409+Zy/rRC6VzEF9giyZcxV5WVw
	 T56W934LfT7L81pW8EMSmWONHLZwDejku5ia1+3TPxetOR506psyyyR7JmUAtIdUeJ
	 4lStaXHYq4hbIui01CMqPrMnlxTZSv4Y8EEhItdrYdrzDXqDJ9thGPa5RxWZbXgQPF
	 yi/MmV7g4DprxwH9Wj8Ar8NcHzkX6Un0HwkB5EGMSW0+JGtYrbWnMMwMKorjvtk1HV
	 oXmmWTNx9HZ226Z8gU12m9cRV/slufeYElG5zY6qs1wgd7dnD7VSy2+AREkrFDkkdh
	 2/HpnA5pL00Rw==
Date: Thu, 11 Jul 2024 11:12:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiwei Sun <sjiwei@163.com>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
	paul.m.stillwell.jr@intel.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, sunjw10@lenovo.com,
	ahuang12@lenovo.com
Subject: Re: [PATCH v3] PCI: vmd: Create domain symlink before
 pci_bus_add_devices()
Message-ID: <20240711161246.GA285252@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db1d3c1d-de04-401e-a03e-a8bc8cce639e@163.com>

On Thu, Jul 11, 2024 at 09:32:46AM +0800, Jiwei Sun wrote:
> 
> On 7/11/24 06:16, Bjorn Helgaas wrote:
> > [-cc Pawel, Alexey, Tomasz, which all bounced]
> > 
> > On Wed, Jul 10, 2024 at 09:29:25PM +0800, Jiwei Sun wrote:
> >> On 7/10/24 04:59, Bjorn Helgaas wrote:
> >>> [+cc Pawel, Alexey, Tomasz for mdadm history]
> >>> On Wed, Jun 05, 2024 at 08:48:44PM +0800, Jiwei Sun wrote:
> >>>> From: Jiwei Sun <sunjw10@lenovo.com>
> >>>>
> >>>> During booting into the kernel, the following error message appears:
> >>>>
> >>>>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: Unable to get real path for '/sys/bus/pci/drivers/vmd/0000:c7:00.5/domain/device''
> >>>>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: /dev/nvme1n1 is not attached to Intel(R) RAID controller.'
> >>>>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: No OROM/EFI properties for /dev/nvme1n1'
> >>>>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: no RAID superblock on /dev/nvme1n1.'
> >>>>   (udev-worker)[2149]: nvme1n1: Process '/sbin/mdadm -I /dev/nvme1n1' failed with exit code 1.
> >>>>
> >>>> This symptom prevents the OS from booting successfully.
> >>>
> >>> I guess the root filesystem must be on a RAID device, and it's the
> >>> failure to assemble that RAID device that prevents OS boot?  The
> >>> messages are just details about why the assembly failed?
> >>
> >> Yes, you are right, in our test environment, we installed the SLES15SP6
> >> on a VROC RAID 1 device which is set up by two NVME hard drivers. And
> >> there is also a hardware RAID kit on the motherboard with other two NVME 
> >> hard drivers.
> > 
> > OK, thanks for all the details.  What would you think of updating the
> > commit log like this?
> 
> Thanks, I think this commit log is clearer than before. Do I need to 
> send another v4 patch for the changes?

No need, if you think it's OK, I can update the commit log locally.

> >   The vmd driver creates a "domain" symlink in sysfs for each VMD bridge.
> >   Previously this symlink was created after pci_bus_add_devices() added
> >   devices below the VMD bridge and emitted udev events to announce them to
> >   userspace.
> > 
> >   This led to a race between userspace consumers of the udev events and the
> >   kernel creation of the symlink.  One such consumer is mdadm, which
> >   assembles block devices into a RAID array, and for devices below a VMD
> >   bridge, mdadm depends on the "domain" symlink.
> > 
> >   If mdadm loses the race, it may be unable to assemble a RAID array, which
> >   may cause a boot failure or other issues, with complaints like this:
> > 
> >   ...
> > 
> >   Create the VMD "domain" symlink before invoking pci_bus_add_devices() to
> >   avoid this race.
> 

