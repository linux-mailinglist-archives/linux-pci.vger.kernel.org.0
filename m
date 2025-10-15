Return-Path: <linux-pci+bounces-38248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D64AFBDFC4D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 18:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83666355046
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D829334397;
	Wed, 15 Oct 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuLepWye"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53667171C9;
	Wed, 15 Oct 2025 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547208; cv=none; b=t3CQcfVaBSpbWkcEvAH71O9ugxYLFbc2dY15MVQWH4QH8f1O9dgaOaQnqtQqHuB560ihGwuYGZaC5eBZdIoeCM+Xc35zMURSwP30p75uCZ3173NNTcGPHMovzWTfgqo9R9RI+7B/eJVv6IYQX/6Xy3HQ79NeaN20ZHnoyjF1Z5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547208; c=relaxed/simple;
	bh=jfLpot06FE2yE/7OOI4eokBahaIFNhBiW5Lzzi2nHW4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nnIcEfC626bM44U+LTjD79Ixoine959rba4vcJevOzY4uehfF3ZEu9DPOIkgKoC+a3Slcpl9Yij2NUc3GqiHaXzklVOQurn/pjwm4Ep+hdJ0fwgQmKkHOKaDNvUMvBSrIL61WucO3ijCv5eMXHbEPuODYsdf3LuiF0bH557mN7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuLepWye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE8DC4CEF8;
	Wed, 15 Oct 2025 16:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760547207;
	bh=jfLpot06FE2yE/7OOI4eokBahaIFNhBiW5Lzzi2nHW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BuLepWyeJxoFyT6eRY/8PHfOCstzfGt0BXhXqufvZttDBIZYUtopb81lvDySN3q8z
	 TQ6y616KKDEnA8rt3EjPsycr+Ker9qK4u82OnRKwnqjuOT0N1qiihnnYBLowuAvTWh
	 Ij5PFEfGGMFou2gn2agC0lRzo/1YmrkAWpS686hODhRwQB8HoKrYyDbzSTfvdCpyIP
	 jUtvuX3LrUJJs5ENelFZ07g2NfmPXp4lmzq1Tkt4xbhNBZBQ3xRPy5mJhCZSfgybQp
	 th1UXDg4vaa7xjhopSoWnlMkvMi0mCLMytfP6InpQg/Njf8+2orpWHCHoOqnbHiH5m
	 eyprbPVMMU9RA==
Date: Wed, 15 Oct 2025 11:53:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vincent Liu <vincent.liu@nutanix.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"dakr@kernel.org" <dakr@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2] driver core: Check drivers_autoprobe for all added
 devices
Message-ID: <20251015165326.GA945703@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7C5EF578-B0CA-4FCB-86F7-470EDD27240D@nutanix.com>

On Wed, Oct 15, 2025 at 10:23:20AM +0000, Vincent Liu wrote:
> On 14 Oct 2025, at 21:07, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> >> In particular for the PCI devices, only
> >> hot-plugged PCIe devices/VFs should be affected as the default value of
> >> pci/drivers_autoprobe remains 1 and can only be cleared from userland.
> > 
> > I'm not sure what this last sentence is telling us.  Does
> > "pci/drivers_autoprobe" refer to struct pci_sriov.drivers_autoprobe?
> > If so, can you elaborate on the connection with struct
> > subsys_private.drivers_autoprobe, which this patch tests?  I don't see
> > anything in this patch related to pci_sriov.
> 
> No this patch has nothing to do with pci_sriov.drivers_autoprobe, this is
> generic for all (pci) devices. pci/drivers_autoprobe refers to the
> drivers_autoprobe sysfs attribute on the pci bus.
> 
> The last sentence is saying that this setting should only affect hot-plugged
> devices because I think there is no way for pci/drivers_autoprobe to be 0 
> for cold plugged devices? But thinking more about this, I don’t think this
> adds much value to the commit message because the drivers_autoprobe
> is not intended for cold-plugged devices anyway. I’ll remove it.
> 
> > As far as I can tell, this patch is generic with respect to
> > conventional PCI vs PCIe.  If so, I'd use "PCI" everywhere instead of
> > a mix of PCI and PCIe.
> 
> Yes you are right, this is generic. I used PCIe purely because of the
> “hot-plugging”, but happy to use PCI everywhere.
> 
> > Add "()" after function names to make them easily recognizable as
> > functions.
> > 
> > s/respsect/respect/
> > s/but this should be the/which is the/  # maybe? not sure what you intend
> 
> Ok.
> 
> Below is a rephrased commit message to incorporate the feedback.
> 
> Thanks,
> Vincent
> 
> -- >8 --
> 
> Subject: [PATCH v2] driver core: Check drivers_autoprobe for all added devices
> 
> When a device is hot-plugged, the drivers_autoprobe sysfs attribute is
> not checked (at least for PCI devices). This means that
> drivers_autoprobe is not working as intended, e.g. hot-plugged PCI
> devices will still be autoprobed and bound to drivers even with
> drivers_autoprobe disabled.
> 
> Make sure all devices check drivers_autoprobe by pushing the
> drivers_autoprobe check into device_initial_probe(). This will only
> affect devices on the PCI bus for now as device_initial_probe() is only
> called by pci_bus_add_device() and bus_probe_device(), but
> bus_probe_device() already checks for autoprobe, so callers of
> bus_probe_device() should not observe changes on autoprobing.
> 
> Any future callers of device_initial_probe() will respect the
> drivers_autoprobe sysfs attribute, which is the intended purpose of
> drivers_autoprobe.
> 
> Signed-off-by: Vincent Liu <vincent.liu@nutanix.com>
> 
> Link: https://lore.kernel.org/20251001151508.1684592-1-vincent.liu@nutanix.com

Thanks, that reads much better to me.

