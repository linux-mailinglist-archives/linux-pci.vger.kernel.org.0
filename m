Return-Path: <linux-pci+bounces-43129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BDCC36E4
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 15:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ABC03029D1E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 14:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D31365A0A;
	Tue, 16 Dec 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnKgVHt5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52ED364E9A;
	Tue, 16 Dec 2025 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765893784; cv=none; b=THb8dQtg/DdL+paUlUe8IMZuY5qKc7Fk0D2N69J8mPlzpMMauA/P1x+2rvjIZoTPwBhvveoB7gkxieu4500Lq+tX+4Y68rw9z2lsKcWkxO6mLznWnRSwdF5rfWPHNmzc4JIibf0mLB/N4I5mWRskr2p++t3LrV1V637OiBsJ8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765893784; c=relaxed/simple;
	bh=8eMAqHQEv5jBf0/tVMARz1cgWubrUUrBinMSW8ZaF90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMloVqDaOG6xNveoijpDDYZTNLAuGuISuFwHEMMRiSGTWD4zaqKeBKhvJQS0MJi1q+8cuRomCezoTm7tNJ5p7/kED9mwl/lfzXdj17T4JZYc0DFofc0et8BfEFnzW1FM0nr/BSA+6y1W//uPowhzpY6C2w54PJfkuDE2VWqOgfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnKgVHt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591B6C4CEF1;
	Tue, 16 Dec 2025 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765893784;
	bh=8eMAqHQEv5jBf0/tVMARz1cgWubrUUrBinMSW8ZaF90=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KnKgVHt53CRJmMsNCVQqxrpRiYHcyHKzk94nEn5qmtvDUjmGNOZOCQUfUPVf2hSIA
	 ioL6dP4hn1BVStwm5jGscpTKX3kWXFYn4e3xGiJN0Z/LLYb3oi4ffPASJGZ5V8UGO7
	 ijgsya0p+utcvajVUJiOKoSF1eBXF6xaSiAGszRDXwYyoKu47AyfX0LfxN2em2qvlT
	 6uTK42ezbrdgWkz980qaugZRdWEH7aYt/XR+IvnXlnTzZHAZWfdxjLBIfAmV7sC9hG
	 RfUrlz7RyMtIplZ0jHUUo5Cwe08SLsp/zvXcn1QgE60lzQ8TrNP4TPqSFSFMPfLA+U
	 BGIlqQRYIVBHA==
Message-ID: <e019cbdb-5152-40fc-a3c8-76b360fdd6ad@kernel.org>
Date: Tue, 16 Dec 2025 08:03:02 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] ACPI: scan: Handle generic system devices directly
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Chen Yu <yu.c.chen@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Alex Hung <alexhung@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>
References: <7888874.EvYhyI6sBW@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <7888874.EvYhyI6sBW@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/25 7:31 AM, Rafael J. Wysocki wrote:
> Hi All,
> 
> As per the changelog of patch [1/4], there is a long-standing problem with ACPI
> device enumeration that if the given device has a compatible ID which is one of
> the generic system resource device IDs (PNP0C01 and PNP0C02), it will be claimed
> by the PNP scan handler and it will not be represented as a platform device, so
> it cannot be handled by a platform driver.
> 
> Obviously, PNP0C01 and PNP0C02 need to be removed from acpi_pnp_device_ids[] to
> address this problem, but it cannot be done without making any other changes
> due to the way the legacy PNP system driver works (see the changelog of patch
> [1/4] for details) and the approach used in patch [1/4] is to reserve the
> "motherboard resources" directly in the ACPI core without creating platform
> devices for "system" devices (whose _HID is either PNP0C01 or PNP0C02).  The
> new code doing works along the lines of the PNP system driver to avoid
> regressions.
> 
> The remaining patches in the series are simplifications that can be done on
> top of the first one.
> 
> Patches [2-3/4] remove platform device creation code from Intel HID and VBTN
> drivers that don't need to worry about _CID including PNP0C02 any more.
> 
> Patch [4/4] drops acpi_nonpnp_device_ids[] that was added as a workaround for
> the issue at hand in the first place.
> 
> Thanks!
> 
> 
> 
> 

For the series:

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

