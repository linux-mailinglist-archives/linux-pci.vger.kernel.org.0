Return-Path: <linux-pci+bounces-13731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE7698E476
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 22:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B1AB22246
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 20:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB7A21730B;
	Wed,  2 Oct 2024 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYgeue/r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C018C36;
	Wed,  2 Oct 2024 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727902440; cv=none; b=jcMrIv7lhGe7ytMzNns8zVlxSFpM+9WbteaZwV5IWMSyApZ8CaPV3qJQqhRgRXZUnadR+sIOIsBvd2VSJXz0oseHKO+MPE6rB4vtCBdquk8N5vQxfvspud/cUk1AEOe1MnYkyy5JTmPw6RKz7DsxNaY8FCHKyiRHbsHcF2iSfW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727902440; c=relaxed/simple;
	bh=Cbk7eLvGafkZ65YOugkgBBS/gOaQHBTFdk3jtDpn/+E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gY/qv7IhNqHNslvrYmFMxbqw0C7yjbk9r6wNwMilryflVzswY52XPOzyTGMPr9V/1HKU9DAo+ys7W2vglCgchCh1o9RmvzQxjt9QYx1lHJR6wHtz/ijmemNES5NzyFRAHGSarMNk178aFS8ORABNMktUPY7GD+fxrwPrZ0aDP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYgeue/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FF4C4CEC2;
	Wed,  2 Oct 2024 20:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727902439;
	bh=Cbk7eLvGafkZ65YOugkgBBS/gOaQHBTFdk3jtDpn/+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DYgeue/rovyoP/isHcyks85SPpNB8iOuaHi+RuLLWqZbKPAxFjbMhAy2Iu56XjDlw
	 QyeGpv47ibvB8RU+YHPK0U4bK5h7TtTK92QR9hqW5y5HGWSEmJWYFScnd0nAw/2fG1
	 RhGGjL91z7Nwo+EHnC3Igbq1XKWV7byeW5HLXoXkrYyfj1pEHVjHCFh+bHbVaI0iDc
	 ayYbbLL5QeKXPW+JsksVLQYf4gfKghfEl/mCKa2dKF41RepvR/Zoqhm7oxTPhpYNEt
	 bZiiXVJx2JsIl6FVuadPYgaUFLqZw3xTgMFpiK0x7aeF/5FR4oMNJfN+gPT1kv1TtK
	 EBof+2AxNcjow==
Date: Wed, 2 Oct 2024 15:53:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] PCI: take the rescan lock when adding devices during
 host probe
Message-ID: <20241002205357.GA269768@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7edd665b-274e-4abe-9e96-c29bbc662598@kernel.org>

On Wed, Oct 02, 2024 at 10:31:46PM +0200, Konrad Dybcio wrote:
> On 2.10.2024 10:36 AM, Bartosz Golaszewski wrote:
> > On Tue, Oct 1, 2024 at 11:11 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>
> >> On Thu, Sep 26, 2024 at 03:09:23PM +0200, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>> Since adding the PCI power control code, we may end up with a race
> >>> between the pwrctl platform device rescanning the bus and the host
> >>> controller probe function. The latter needs to take the rescan lock when
> >>> adding devices or may crash.
> >>>
> >>> Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> >>> Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> >>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>> ---
> >>>  drivers/pci/probe.c | 2 ++
> >>>  1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >>> index 4f68414c3086..f1615805f5b0 100644
> >>> --- a/drivers/pci/probe.c
> >>> +++ b/drivers/pci/probe.c
> >>> @@ -3105,7 +3105,9 @@ int pci_host_probe(struct pci_host_bridge *bridge)
> >>>       list_for_each_entry(child, &bus->children, node)
> >>>               pcie_bus_configure_settings(child);
> >>>
> >>> +     pci_lock_rescan_remove();
> >>>       pci_bus_add_devices(bus);
> >>> +     pci_unlock_rescan_remove();
> >>
> >> Seems like we do need locking here, but don't we need a more
> >> comprehensive change?  There are many other callers of
> >> pci_bus_add_devices(), and most of them look similarly unprotected.
> > 
> > From a quick glance it looks like the majority of users are specific
> > drivers (controller, hotplug, etc.). The calls inside pci_rescan_bus()
> > and pci_rescan_bus_bridge_resize() are already protected from what I
> > can tell. I'm not saying that the driver calls shouldn't be fixed but
> > there's no immediate danger. This however fixes an issue we hit with
> > PCI core so I'd send it upstream now and then we can think about the
> > other use-cases.

Agreed that all current callers of pci_rescan_bus() and
pci_rescan_bus_bridge_resize() already do their own locking.  Most of
the hotplug drivers that use pci_bus_add_devices() do their own
locking as well.

pci_host_probe() is used by many controller drivers, but my guess is
that a dozen or so controller drivers that use pci_bus_add_devices()
directly without locking are still at risk.  It's sort of an
unfinished project to convert drivers like this over to using
pci_host_probe().

In the meantime, I wish we had a safer interface that could enforce
the locking internally.

> Probably worth showing an example of how this can manifest:
> 
> removed a device through sysfs and called bus rescan:

Thanks for this; I was about to ask for it!  I don't think we need
*all* the details, but something like the following might help people
recognize if we trip over another instance:

> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Internal error: Oops: 0000000096000004 [#1] SMP
> Call trace:
>  __pi_strlen+0x14/0x150
>  kernfs_find_ns+0x80/0x13c
>  kernfs_remove_by_name_ns+0x54/0xf0
>  sysfs_remove_bin_file+0x24/0x34
>  pci_remove_resource_files+0x3c/0x84
>  pci_remove_sysfs_dev_files+0x28/0x38
>  pci_stop_bus_device+0x8c/0xd8
>  pci_stop_bus_device+0x40/0xd8
>  pci_stop_and_remove_bus_device_locked+0x28/0x48
>  remove_store+0x70/0xb0
>  dev_attr_store+0x20/0x38
>  sysfs_kf_write+0x58/0x78
>  kernfs_fop_write_iter+0xe8/0x184
>  vfs_write+0x2dc/0x308

Bjorn

