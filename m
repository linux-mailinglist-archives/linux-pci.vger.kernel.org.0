Return-Path: <linux-pci+bounces-24056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A276EA67845
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 16:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849081892C4D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 15:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D799B20F070;
	Tue, 18 Mar 2025 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SR3g0iWB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8CD20E01F;
	Tue, 18 Mar 2025 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312849; cv=none; b=oxipzf4utS8T+EiJcoXT7JvjUsAQuVUjAxWc1N+ODTrbvnv2tCwmz2nsGFjdOahfUQuYp6mCxqZsKZp84zazn2lsgdny8MnuwoRn8fWSUaE+e8xfBxEEEIsjdNp4X3jhwwUB/Is9l7xlo+geGrjqfBzlYptfR1l1C7SwGdOKdyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312849; c=relaxed/simple;
	bh=WwFxv+wxNiAGCDmcGI7bQdFtcrRDAx7iMQEYQbTXX+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TrrELV2Q26j0HiK2jxAQQ8XcCn41foD6pFBcbrkLUQx1lHguA5ibii5lL5z6LWTDA3BYdlIrZ5vAP6lBm1qo99yqgIJSdrkRbXrudNaFTa1A81c8GDZnvtFqrH+Kb2lb7YTXlFEvMtyrchnyOk2lcLGK9NlaiF5kRKAsrC/T05o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SR3g0iWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0850CC4CEDD;
	Tue, 18 Mar 2025 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742312849;
	bh=WwFxv+wxNiAGCDmcGI7bQdFtcrRDAx7iMQEYQbTXX+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=SR3g0iWB2UTQ7ZQwNKIt0p/H+/5VLJhnRcTRN/t6PU6AVA6Drprp3Kq7B7DcerAXx
	 cgMtg2g06llRue8yQ3ry8A0IP2hBVqAcfBGKk808nruYVvnMhVNPONXe4Cb9CW4kHP
	 rrdmv7AP1KzDIw1DfNYG4i/YEmJ2xS56YxDnYc9VIEKPwkjgNzG23ME7WDW4j9mU6C
	 E7IzkP+sNzTL6M1879F3pu8e3V9tpkszu3a9PxzvygzzrBw3yqM07QQVA7BAid/wP8
	 sMaIviYcUBd3/gTmBzB0sa1RabPWC7WmUGlBGoNKMInJuQu6B5Pv7QA1pL7j8Ux052
	 cFzYKU0g/OsEg==
Date: Tue, 18 Mar 2025 10:47:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com, Kiran K <kiran.k@intel.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Support function level reset
Message-ID: <20250318154727.GA1001403@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJQn4ZYMxLqCkJwA71a_VWhu4QXTkU7vt7wiQXf3bdYdQ@mail.gmail.com>

On Tue, Mar 18, 2025 at 10:55:06AM -0400, Luiz Augusto von Dentz wrote:
> On Fri, Mar 14, 2025 at 3:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Mar 14, 2025 at 12:16:13PM +0200, Chandrashekar Devegowda wrote:
> > > Support function level reset (flr) on hardware exception to recover
> > > controller. Driver also implements the back-off time of 5 seconds and
> > > the maximum number of retries are limited to 5 before giving up.
> >
> > Sort of weird that the commit log mentions FLR, but it's not mentioned
> > in the patch itself except for BTINTEL_PCIE_FLR_RESET_MAX_RETRY.
> > Apparently the assumption is that DSM_SET_RESET_METHOD_PCIE performs
> > an FLR.
> >
> > Since this is an ACPI _DSM, presumably this mechanism only works for
> > devices built into the platform, not for any potential plug-in devices
> > that would not be described via ACPI.  I guess this driver probably
> > already only works for built-in devices because it also uses
> > DSM_SET_WDISABLE2_DELAY and DSM_SET_RESET_METHOD.
> >
> > There is a generic PCI core way to do FLR (pcie_reset_flr()), so I
> > assume the _DSM exists because the device needs some additional
> > device-specific work around the FLR.
> >
> > > +static void btintel_pcie_removal_work(struct work_struct *wk)
> > > +{
> > > +     struct btintel_pcie_removal *removal =
> > > +             container_of(wk, struct btintel_pcie_removal, work);
> > > +     struct pci_dev *pdev = removal->pdev;
> > > +     struct pci_bus *bus;
> > > +     struct btintel_pcie_data *data;
> > > +
> > > +     data = pci_get_drvdata(pdev);
> > > +
> > > +     pci_lock_rescan_remove();
> > > +
> > > +     bus = pdev->bus;
> > > +     if (!bus)
> > > +             goto out;
> > > +
> > > +     btintel_acpi_reset_method(data->hdev);
> > > +     pci_stop_and_remove_bus_device(pdev);
> > > +     pci_dev_put(pdev);
> > > +
> > > +     if (bus->parent)
> > > +             bus = bus->parent;
> > > +     pci_rescan_bus(bus);
> >
> > This remove and rescan by a driver that's bound to the device subverts
> > the driver model.  pci_stop_and_remove_bus_device() detaches the
> > driver from the device.  After the driver is detached, we should not
> > be running any driver code.
> 
> Yeah, this self removal was sort of bugging me as well, although I'm
> not familiar enough with the pci subsystem, having the driver remove
> and continue running code like pci_rescan_bus seems wrong as we may
> end up with multiple instances of the same driver.
> 
> > There are a couple other drivers that remove their own device (ath9k,
> > iwlwifi, asus_wmi, eeepc-laptop), but I think those are broken and
> > it's a mistake to add this pattern to more drivers.
> >
> > What's the reason for doing the remove and rescan?  The PCI core
> > doesn't reset the device when you do this, so it's not a "bigger
> > hammer reset".
> 
> I guess it was more of the expectation of Chandru to have a sort of
> hard reset, driver remove+probe, instead of a soft reset where the
> driver will just need to reinit itself after performing
> pcie_reset_flr.

If the object is just to reinitialize the driver, I think this hack of
removing and rescanning is a bad way to do it.  If you reset the
device, you now know the state of the device and you can make the
driver state match it.  If necessary you can always reuse part or all
of the .remove() and .probe() methods yourself, without this dance of
calling pci_stop_and_remove_bus_device() and pci_rescan_bus().

Bjorn

