Return-Path: <linux-pci+bounces-4030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED264867C19
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 17:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DC3293A44
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AAF605A1;
	Mon, 26 Feb 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="th6fRVQ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087321E519;
	Mon, 26 Feb 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965190; cv=none; b=GIn1dS96DEEMkBLhz3M4Ygk8nMdfefeftDbeK2fFcHC4oqEusHbTxUF68eyY9xUjxE0vzdwNVydksFnhWwh+HEys6GZQknkBtOORymCJcrl1OSXl3yths7JVSu5kO7ampebKJMs8oko8iOs/pGahnxe3Cyn6n6aK3pK1VemW69c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965190; c=relaxed/simple;
	bh=yYV+NOkGvP4l7r0h+cUCgge3vZjLcjysa5VuSKBMHg8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G9x0vTv6Pgpelqy0+fMoPJRfT8PCoOsr4qkRrG2WHsmzu/LYGzLl+7++wc1XWH26osbOnP1EqXBZBXxFHBRnVkeBZepCbT/KClb86ioYSOTtdnyzbr4N9pw3RTuzh2ngpk7nyE5QJcOUkuBq1Omrzxul6UCu5k3auHs8b4GgwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=th6fRVQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7F8C433F1;
	Mon, 26 Feb 2024 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708965187;
	bh=yYV+NOkGvP4l7r0h+cUCgge3vZjLcjysa5VuSKBMHg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=th6fRVQ0Rb4Q2YNsbKLVS7GanbHdNDCZDcqWwqnBCz2Ug8QE40TEa87/G9R7j3967
	 OXJ5CkHwRuTC661MYNSw0jkOpwurjfNhR1HFdySBSZLM2VWvOj7IrtX1yGs3VFR+5g
	 FyBnvMvKIRmWM3zoEZr7+KRoVVsiQgFOwpSmcHZHv51r/yRyWUp+ToE5fkvu7rceIL
	 Pl1jXJhHR1P6XvVNt/t4aOKhH+i533BTci1PISSiuQvEpHCdvqOQALiLC7XJynMBVp
	 QFkP45AaLhO8gXjaII30HwFgd0GQIzCpJZNyk1W0QUG9MTrqf7penpnD5gVtZSWcNv
	 Or+VYZ7/Mylsw==
Date: Mon, 26 Feb 2024 10:33:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthew W Carlis <mattc@purestorage.com>,
	Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI/DPC: Request DPC only if also requesting AER
Message-ID: <20240226163305.GA202015@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dfc9692b-1a9a-4d53-9e3e-33b2e88d0d37@linux.intel.com>

On Mon, Feb 26, 2024 at 07:46:05AM -0800, Kuppuswamy Sathyanarayanan wrote:
> 
> On 2/26/24 7:18 AM, Bjorn Helgaas wrote:
> > On Sun, Feb 25, 2024 at 11:46:07AM -0800, Kuppuswamy Sathyanarayanan wrote:
> >> On 2/22/24 2:15 PM, Bjorn Helgaas wrote:
> >>> From: Bjorn Helgaas <bhelgaas@google.com>
> >>>
> >>> When booting with "pci=noaer", we don't request control of AER, but we
> >>> previously *did* request control of DPC, as in the dmesg log attached at
> >>> the bugzilla below:
> >>>
> >>>   Command line: ... pci=noaer
> >>>   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> >>>   acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR DPC]
> >>>
> >>> That's illegal per PCI Firmware Spec, r3.3, sec 4.5.1, table 4-5, which
> >>> says:
> >>>
> >>>   If the operating system sets this bit [OSC_PCI_EXPRESS_DPC_CONTROL], it
> >>>   must also set bit 7 of the Support field (indicating support for Error
> >>>   Disconnect Recover notifications) and bits 3 and 4 of the Control field
> >>>   (requesting control of PCI Express Advanced Error Reporting and the PCI
> >>>   Express Capability Structure).
> >>
> >> IIUC, this dependency is discussed in sec 4.5.2.4. "Dependencies
> >> Between _OSC Control Bits".
> >>
> >> Because handling of Downstream Port Containment has a dependency on
> >> Advanced Error Reporting, the operating system is required to
> >> request control over Advanced Error Reporting (bit 3 of the Control
> >> field) while requesting control over Downstream Port Containment
> >> Configuration (bit 7 of the Control field). If the operating system
> >> attempts to claim control of Downstream Port Containment
> >> Configuration without also claiming control over Advanced Error
> >> Reporting, firmware is required to refuse control of the feature
> >> being illegally claimed and mask the corresponding bit.  Firmware is
> >> required to maintain ownership of Advanced Error Reporting if it
> >> retains ownership of Downstream Port Containment Configuration.  If
> >> the operating system sets bit 7 of the Control field, it must set
> >> bit 7 of the Support field, indicating support for the Error
> >> Disconnect Recover event.
> >
> > So I guess you're suggesting that there are two defects here?
> >
> >   1) Linux requested DPC control without requesting AER control.
> >
> >   2) Platform granted DPC control when it shouldn't have.
> >
> > I do agree with that, but obviously we can only fix 1) in Linux.
> 
> Sorry, maybe my comment was not clear. I was just suggesting to
> change the spec reference from r3.3, sec 4.5.1, table 4-5 to r3.3,
> sec 4.5.2.4 "Dependencies Between _OSC Control Bits".

The requirement that the OS request AER control whenever it requests
DPC control is mentioned in both sec 4.5.1 and sec 4.5.2.4.  IMO sec
4.5.2.4 should not exist because the per-bit table in sec 4.5.1 is a
better place for implementation guidance.  4.5.2.4 is easy to miss,
mostly redundant, and hard to integrate with the 4.5.1 table.

What advantage do you see for citing 4.5.2.4 instead of 4.5.1?  The
only real difference I see is that it also points out a firmware
problem.  I don't think the extra text is worth it since it doesn't
motivate the Linux change.

Bjorn

