Return-Path: <linux-pci+bounces-40542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABC5C3DE0E
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 00:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2415C4E6C95
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 23:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37522FDC23;
	Thu,  6 Nov 2025 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDaJ/5/t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7893D26FDA6;
	Thu,  6 Nov 2025 23:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762472753; cv=none; b=pcl3S0YUhV1E4FdksgUWmAt+ejh/5gADh2LNtOu6MqEqYkk5g0kbRPofQgucslZKFxEkg1k5Lhd40PSpFmmRpvgUkWt5x5t2dvtTG/S6Xl+41zLZNkTJ4DmDmJk/gxz5NKv3uG/AlogYVSENxcD3jw86eMUW1k/Wr9pjNwFafxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762472753; c=relaxed/simple;
	bh=23mhRYspHUO/+Jn5j6UsbhA1co9CDPUsRj1RdkMabQU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PGkXfhPedKRY9ROghYOtJiiyYquFCPOTRIun16IG1bVSZk7sS60vZLcqQx/XxewXcwVFsm3HesB9NkLKG8uVA1QdeIXmG1hH5aHOPp9Nxmhd33vVVxaXXv7cnL/+C4Km/qvSkc33gj3RokK9nfvQ3jwDrtDhbiOKKLPD5r6RdYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDaJ/5/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2545C4CEF7;
	Thu,  6 Nov 2025 23:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762472753;
	bh=23mhRYspHUO/+Jn5j6UsbhA1co9CDPUsRj1RdkMabQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nDaJ/5/t364D5zfSObhgA0ft1VArPTqWeLPFQA2zIvyUNQrfV2m8D9AA6X3c5wRfH
	 Q21Bodv0vO+P2iAZM+d8B129L6ihVGsJdLbnQgXgMWbxJxAKxB9W/Vzpt9ERYKmJRt
	 aPh4IG8/t4b7ih5DeFQIRITz4ez1HnuyE4TWHMhy1rLMvRcLng9ku7ZrAH+AJOoAxT
	 +SnElhanks/y9iRPZtvGOTsNrJWW8mOlltH/yeUnl3icmXwDxMakvBdKh4Ty7d1tei
	 a8n09H4P4KN7mwJUyC1cfXnAir4KE2faeS5B4uxozC0VPQXKcCBLQQM2poCCsk8o7Z
	 9Wg2vPA8Kn0XA==
Date: Thu, 6 Nov 2025 17:45:51 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI/ASPM: Allow quirks to avoid L0s and L1
Message-ID: <20251106234551.GA1976429@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106183643.1963801-1-helgaas@kernel.org>

On Thu, Nov 06, 2025 at 12:36:37PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> We enabled ASPM too aggressively in v6.18-rc1.  f3ac2ff14834 ("PCI/ASPM:
> Enable all ClockPM and ASPM states for devicetree platforms") enabled ASPM
> L0s, L1, and (if advertised) L1 PM Substates.
> 
> L1 PM Substates and Clock PM in particular are a problem because they
> depend on CLKREQ# and sometimes device-specific configuration, and none of
> this is discoverable in a generic way.
> 
> df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> (v6.18-rc3) backed off and omitted Clock PM and L1 Substates.
> 
> L0s and L1 are generically discoverable, but some devices advertise them
> even though they don't work correctly.  This series is a way to avoid L0s
> and L1 in that case.
> 
> Bjorn Helgaas (2):
>   PCI/ASPM: Cache Link Capabilities so quirks can override them
>   PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports
> 
>  drivers/pci/pcie/aspm.c | 42 ++++++++++++++++++++---------------------
>  drivers/pci/probe.c     |  5 ++---
>  drivers/pci/quirks.c    | 12 ++++++++++++
>  include/linux/pci.h     |  1 +
>  4 files changed, 36 insertions(+), 24 deletions(-)

I put these on for-linus, hopefully for v6.18.  I would like to have
some review and testing before asking Linus to pull them, especially
since the first one is not completely trivial and is a change (but
shouldn't be a functional change) for all platforms.

