Return-Path: <linux-pci+bounces-8612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8849046F3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 00:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8AA2286A01
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 22:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEF512E48;
	Tue, 11 Jun 2024 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZq+50Mh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7C515539A
	for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2024 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145088; cv=none; b=GHVMfrc122q3ksNTt1eO8A27YxG9XX+qfSaOh1trt0RfZKm17NDvOtCMLRq1jB/h13hWa6URsg+RrfZDV1qphvhmGha01ZKTKVuDdvkHrZ7BKlCiyqtXQ/3fuaUFQO8czWbMqx+y4QnTn2k4jKe/29Msacy9czdV7ujk/BjFet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145088; c=relaxed/simple;
	bh=qAqigLqVvHEfKs19dJx+/GrTKDCRL01Ps7+5Cs3Xuho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dK7iFw0Qf/arKXdf0aB4aHRbED1XZQwQBasSQ9bNgdHjAwCDlx1reqFuLY/H6Xrlco9jqUO/05Z654nATmqkeCMIBToWfQdmMjn6OKi+NvzLquJfyU+C7ceosyHGXuY1ereTkWxjL4t7P6Pvoqat3IOShAS1C3eicoRq9Jobxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZq+50Mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EBFC2BD10;
	Tue, 11 Jun 2024 22:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718145088;
	bh=qAqigLqVvHEfKs19dJx+/GrTKDCRL01Ps7+5Cs3Xuho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EZq+50Mhfy6Qs//DeqhXgjuxUVyUQvD3GIxVfitp6qjNdbwUulZ7vcPbNcv/H05Fm
	 hjvRFY8WsrLYUhrN97Yx8Sb4pdsE0FdnP0fl5ElXK581H/JaNr6O1IryQLMhE8K5oA
	 legmMQTlO1GvGL1TGQvy1GjgmRBQSVz+mQ2tuqkTrOM3TBW9Jt/JB02pwBUbDKhQPU
	 ZdELY8qGJWaWf6e79oq388pPHKz08NfXgd/A99k/prVmN9MmOWZ/LA/Y+6D2uAZab2
	 8bO6Un7UCHFRMYZ/9KDGqPOeTrP/NJKO1G2kMnQlRS6AZfcudjqunxInpAI/UC+BJg
	 Eq1Rx7LV6RK8A==
Date: Tue, 11 Jun 2024 17:31:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: Linux warns `Unknown NUMA node; performance will be reduced`
Message-ID: <20240611223125.GA1004778@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70cf7d8f-63f1-d54a-63f3-7564cdf46ede@huawei.com>

On Tue, Jun 11, 2024 at 11:05:31AM +0800, Yunsheng Lin wrote:
> On 2024/6/11 4:27, Paul Menzel wrote:
> > Am 10.06.24 um 21:42 schrieb Bjorn Helgaas:
> >> [+cc Yunsheng, thread at
> >> https://lore.kernel.org/r/a154f694-c48b-4b3b-809f-4b74ec86a924@molgen.mpg.de]
> >> On Sun, Jun 09, 2024 at 10:31:05AM +0200, Paul Menzel wrote:
> >>> On the servers below Linux warns:
> >>>
> >>>       Unknown NUMA node; performance will be reduced
> >>
> >> This warning was added by ad5086108b9f ("PCI: Warn if no host bridge
> >> NUMA node info"), which appeared in v5.5, so I assume this isn't new.
> >>
> >> That commit log says:
> >>
> >>    In pci_call_probe(), we try to run driver probe functions on the node where
> >>    the device is attached.  If we don't know which node the device is attached
> >>    to, the driver will likely run on the wrong node.  This will still work,
> >>    but performance will not be as good as it could be.
> >>
> >>    On NUMA systems, warn if we don't know which node a PCI host bridge is
> >>    attached to.  This is likely an indication that ACPI didn't supply a _PXM
> >>    method or the DT didn't supply a "numa-node-id" property.
> >>
> >> I assume these are all ACPI systems, so likely missing _PXM.  An
> >> acpidump could confirm this.
> > 
> > I created an issue in the Linux Kernel Bugzilla [1] and attached the output of `acpidump` on a Dell PowerEdge T630 there. The DSDT contains:
> > 
> >         Device (PCI1)
> >         {
> >         […]
> >             Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
> >             {
> >                 If ((CLOD == 0x00))
> >                 {
> >                     Return (0x01)
> >                 }
> >                 Else
> >                 {
> >                     Return (0x02)
> >                 }
> >             }
> >         […]
> >         }
> > 
> >> I think the devices on buses 7f and ff are Intel chipset devices, and
> >> I doubt we have drivers for any of them.  They have vendor/device IDs
> >> of 8086:6fXX, and I didn't see any reference to them:
> >>
> >>    $ git grep -i \<0x6f..\>
> >>    $
> > 
> > Interesting. Any ideas, what these chipset devices do?
> > 
> >> If we *did* have drivers, they would certainly benefit from having
> >> _PXM, but since there are no probe methods, I don't think it matters
> >> that we don't know where they should run.
> >>
> >> Maybe the message should be downgraded from "dev_warn" to "dev_info"
> >> since there's no functional problem, and the user can't really do
> >> anything about it.
> >>
> >> We could also consider moving it to the actual probe path, so we don't
> >> emit a message unless there is an affected driver.
> 
> The problem seems to be how we decide if there is an affected driver?
> do we care about the out-of-tree driver? doesn't the out-of-tree driver
> suffer from the similar problem if BIOS is not providing the correct
> numa info?

I don't care about out-of-tree drivers at all.  This message is only a
hint about maybe not getting the absolute best possible performance
anyway.

> The 'Unknown NUMA node; performance will be reduced' warning seems to
> be added to give the vendor some pressure to fix the BIOS as fast as
> possible, downgrading from "dev_warn" to "dev_info" or moving it to
> the actual probe path does not seems to fix the problem, just alliviate
> the pressure for vendor to fix the BIOS?

True, BIOS vendors *might* care about fixing a warning, and likely
wouldn't even notice a dev_info.

It's possible somebody could add a test case to the firmware test
suite (https://github.com/fwts/fwts.git).  Not sure if vendors care
about that either.

I suspect Linux users might care about the dev_warn because I suspect
it breaks the pretty graphical boot sequence.

As far as the Linux kernel, I think making it dev_info is enough.

Bjorn

