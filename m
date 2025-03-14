Return-Path: <linux-pci+bounces-23777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 996EAA61ADC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 20:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF86420187
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 19:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B6715A848;
	Fri, 14 Mar 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkNexEeb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C417D2;
	Fri, 14 Mar 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981233; cv=none; b=PNJRTVJzYiHhQ+G/4bB0yK3Hw4gcjilSIVwL+/W/sYWkiDbuSZ5GFmPsry7Mn4a4AAKJaZ6eoTVQZyfmS+d1bgh80hEhWuFtTtzPOWYiRF3iplJhJjr/T3RX2lpbpIIa3NATFAr3G2O4KJzGtJDl/4zJEsJiFy1A0miCEkmpzJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981233; c=relaxed/simple;
	bh=IcViIoyQuIwvjOKTv7xso/ATQXDP/KFmnaBlf6ULPVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cNSfCDvw05CijDSYrwwfC2Dz0QU/L8DVa+Sod5cMsorn78cxH+1ji12WMKgdjXJlFO4hj1hppS5fMWxJ8jakEHpwIoAfP+yo8gOJJTVTYULZ40j4Tv5H4Q7o4ZOBINmrC5maY8N9BXZkGj0LpQVTcjnTDET5eS3NFSN206jOaPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkNexEeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC10C4CEE3;
	Fri, 14 Mar 2025 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741981233;
	bh=IcViIoyQuIwvjOKTv7xso/ATQXDP/KFmnaBlf6ULPVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lkNexEebThSwtdRrPAup8bXMoJER1M9KpLBf3fswA1CsmARAK9TKlnFcOJA/HEBrG
	 VIUtez4QCUJVsdf4/OCMlZEH2jUAE5+lOR5B/4VPLx5ETPmCMoFkFzqrKyEyBWfVT4
	 gdnJHxGT3RmJ41fTmi2kjuZqIaA9oKCmcubKh1/1SLkPxa9xtVthGvf0FCpAVSeIsS
	 mX5pGt/6Y1Qq4InYwiqI6anNLA0l2MPhEDImz6wfEFvfX6rmTSmGhqk2DV3ywXqKWE
	 XC859CiCBaiJ8BKTYbTCEZS2Gi5u2cT7CqwAb2YKLVxRzQ80cEHrI86kHpGhKq6zVk
	 KZ8WcqllXpdfA==
Date: Fri, 14 Mar 2025 14:40:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org,
	bhelgaas@google.com, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com, Kiran K <kiran.k@intel.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Support function level reset
Message-ID: <20250314194031.GA785335@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314101613.3682010-1-chandrashekar.devegowda@intel.com>

On Fri, Mar 14, 2025 at 12:16:13PM +0200, Chandrashekar Devegowda wrote:
> Support function level reset (flr) on hardware exception to recover
> controller. Driver also implements the back-off time of 5 seconds and
> the maximum number of retries are limited to 5 before giving up.

Sort of weird that the commit log mentions FLR, but it's not mentioned
in the patch itself except for BTINTEL_PCIE_FLR_RESET_MAX_RETRY.
Apparently the assumption is that DSM_SET_RESET_METHOD_PCIE performs
an FLR.

Since this is an ACPI _DSM, presumably this mechanism only works for
devices built into the platform, not for any potential plug-in devices
that would not be described via ACPI.  I guess this driver probably
already only works for built-in devices because it also uses
DSM_SET_WDISABLE2_DELAY and DSM_SET_RESET_METHOD.

There is a generic PCI core way to do FLR (pcie_reset_flr()), so I
assume the _DSM exists because the device needs some additional
device-specific work around the FLR.

> +static void btintel_pcie_removal_work(struct work_struct *wk)
> +{
> +	struct btintel_pcie_removal *removal =
> +		container_of(wk, struct btintel_pcie_removal, work);
> +	struct pci_dev *pdev = removal->pdev;
> +	struct pci_bus *bus;
> +	struct btintel_pcie_data *data;
> +
> +	data = pci_get_drvdata(pdev);
> +
> +	pci_lock_rescan_remove();
> +
> +	bus = pdev->bus;
> +	if (!bus)
> +		goto out;
> +
> +	btintel_acpi_reset_method(data->hdev);
> +	pci_stop_and_remove_bus_device(pdev);
> +	pci_dev_put(pdev);
> +
> +	if (bus->parent)
> +		bus = bus->parent;
> +	pci_rescan_bus(bus);

This remove and rescan by a driver that's bound to the device subverts
the driver model.  pci_stop_and_remove_bus_device() detaches the
driver from the device.  After the driver is detached, we should not
be running any driver code.

There are a couple other drivers that remove their own device (ath9k,
iwlwifi, asus_wmi, eeepc-laptop), but I think those are broken and
it's a mistake to add this pattern to more drivers.

What's the reason for doing the remove and rescan?  The PCI core
doesn't reset the device when you do this, so it's not a "bigger
hammer reset".

> +out:
> +	pci_unlock_rescan_remove();
> +	kfree(removal);
> +}

