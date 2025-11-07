Return-Path: <linux-pci+bounces-40557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAFEC3E882
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 06:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8A3B4EA059
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 05:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C3C21C16A;
	Fri,  7 Nov 2025 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuMf+jrW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC871482E8;
	Fri,  7 Nov 2025 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762494022; cv=none; b=p84dhdmADrJQU5m2qshrmyupYdAPbBxk3ntWEBtprdBz1Ful2VhxVScRcOG4pudwFOf2jIpLytsFOvNB96z4yw+OrLOgtqnFE7MnkOalrmfatbhv4LNleJxSTBk1w65ML/BHZ+i4+SuNXc9yUE8u1PqxtspPSZWC6AHij0b7g6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762494022; c=relaxed/simple;
	bh=ceGgv8K81IVqsAHEgTkbu6ASQqAG7y9+ejl8bi9wq80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOK/Y8InXrxfeRbEFKV5wadIcM4IzzvH0WvhKaEx483NCSB6bcsPBifNOQRwH2cBfAurBAm00p0N0OD7uCu+yHIjqjMiwOcylgAaXHbis5VZj9GO6/1ziZYzDyAF/DtZKcSDC3LMwPUIQJmjtVl04DHWZ3YdeTJmzbGRnuBfBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuMf+jrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36899C4CEF8;
	Fri,  7 Nov 2025 05:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762494022;
	bh=ceGgv8K81IVqsAHEgTkbu6ASQqAG7y9+ejl8bi9wq80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TuMf+jrWo2PHK9xSv9izysbZmqH9adQi6j+5C4WnVmhail9Rk8637uliSrOuoUSMs
	 w5WqkphbBsnEaPJYNJs4vVh1DdiukiUTiRW9BHB7zUAFRerR/2zh+THjnsXniWVBXP
	 IzKS4/tLjYagocanwtqYFh3VJfqFJ6GyO6cUEyQMZ5YKaBQ8DOwIuZ8kSVT2aDfoz4
	 lZ3nUvicT+9F5s8e+dkD8TNqPMllRtUnOS1fLIW0RKBlAuQcu2KrV+KUrSvzWtiZ4T
	 YzrFoHWagRwMbq1+q1Zm60IUf/5/QJlcW6a9ojM78vBVRGZGFtAMU1/5OrYad+/oxs
	 FUMqOOAiNUO/w==
Date: Fri, 7 Nov 2025 11:10:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>, 
	mad skateman <madskateman@gmail.com>, "R . T . Dickinson" <rtd2@xtra.co.nz>, 
	Darren Stevens <darren@stevens-zone.net>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Lukas Wunner <lukas@wunner.de>, luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>, 
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>, hypexed@yahoo.com.au, 
	linuxppc-dev@lists.ozlabs.org, debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] PCI/ASPM: Allow quirks to avoid L0s and L1
Message-ID: <ahhrvcqpwd3ilti5fzakaojzlkfqil6vscrqgpqt7hia3igszl@vykbk65y73fj>
References: <20251106183643.1963801-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Manivannan Sadhasivam <mani@kernel.org> # T14s

- Mani

> Bjorn Helgaas (2):
>   PCI/ASPM: Cache Link Capabilities so quirks can override them
>   PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports
> 
>  drivers/pci/pcie/aspm.c | 42 ++++++++++++++++++++---------------------
>  drivers/pci/probe.c     |  5 ++---
>  drivers/pci/quirks.c    | 12 ++++++++++++
>  include/linux/pci.h     |  1 +
>  4 files changed, 36 insertions(+), 24 deletions(-)
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

