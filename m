Return-Path: <linux-pci+bounces-4533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C402872678
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 19:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF081C267D9
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 18:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4803418645;
	Tue,  5 Mar 2024 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8VaCplE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9A1863C;
	Tue,  5 Mar 2024 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709663003; cv=none; b=FNj5bFADeXhE4C6ktl/CoVZjSIHL4c9/xvVk/ctOJweUH4E9FcZLmNVhZJ63Pxy0lkYeB5tZVQiE5uZbQdymPWVTnvQmBHNVZ1eywnaeOtYLbK4AyTecxa5la6mft66RVikybU0SDKFtytZeXZxaELj3/JVjGXYnGOdn5Gyepec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709663003; c=relaxed/simple;
	bh=GsWX5uNbFBWOb7yRHYDe3Hj7I20tI6lGHveIAeX1x4w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FuHreZITFOPNg4UKBtp0vJwHht3lgDMIKc+seKEfmwM1zQW5TKQ/TLbJNo8d0dJjp8Pir9mEycz+mbXYKHBNFGB6MVD1SkQlCL7BGzFmTkeywJBJ23ibcaAZdOisW4+ZRmB4ucImFf3KfTVvwknt7zHTfDNdBOck2QEzzKRymWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8VaCplE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699EEC433F1;
	Tue,  5 Mar 2024 18:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709663002;
	bh=GsWX5uNbFBWOb7yRHYDe3Hj7I20tI6lGHveIAeX1x4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=K8VaCplEo2vcXxeQ3F7Cq3ZQLNQwZktFuAa9dSZsNxnN3wktJJVgDjoSU9NSL9507
	 kE/eAxdklTDS+q1wyxOCytywkU+BfIbt7h1NV+4mhog4tiSQfPLIln1FBvpx+qNyYV
	 9x2w+U2a7/dbrTi72yB9YzthCzEhnIQcfjmm806O/VEHTKgybzmk8iKIGAE0HSG6Ao
	 e4HTQ5KyTwvnjdhRS8WQgCgRoweDTg9A8s8YUUlBN7GFyCruW4L8wgrWjPlccbuPGw
	 oqpRmQXg01FcaDd8UjBzoylf6wT2htc/1hp2ZR62i+cYy6YHtgY0Is3wBE1dUxtJSa
	 kdVo61RUAoMfg==
Date: Tue, 5 Mar 2024 12:23:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	nvaert1986@hotmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/DPC: Quirk PIO log size for Intel Raptor Lake Root
 Ports
Message-ID: <20240305182320.GA541715@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305113057.56468-1-pmenzel@molgen.mpg.de>

On Tue, Mar 05, 2024 at 12:30:56PM +0100, Paul Menzel wrote:
> Commit 5459c0b70467 ("PCI/DPC: Quirk PIO log size for certain Intel Root
> Ports") and commit 3b8803494a06 ("PCI/DPC: Quirk PIO log size for Intel Ice
> Lake Root Ports") add quirks for Ice, Tiger and Alder Lake Root Ports.
> System firmware for Raptor Lake still has the bug, so Linux logs the
> warning below on several Raptor Lake systems like Dell Precision 3581 with
> Intel Raptor Lake processor (0W18NX) system firmware/BIOS version 1.10.1.
> 
>     pci 0000:00:07.0: [8086:a76e] type 01 class 0x060400
>     pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
>     pci 0000:00:07.0: PTM enabled (root), 4ns granularity
>     pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
>     pci 0000:00:07.1: [8086:a73f] type 01 class 0x060400
>     pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
>     pci 0000:00:07.1: PTM enabled (root), 4ns granularity
>     pci 0000:00:07.1: DPC: RP PIO log size 0 is invalid
> 
> So, apply the quirk for Raptor Lake Root Ports as well.
> 
> This also enables the DPC driver to dump the RP PIO Log registers when DPC
> is triggered.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218560
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: nvaert1986@hotmail.com
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Added stable tag and applied to pci/dpc for v6.9 with tags:

  Reported-by: <nvaert1986@hotmail.com>
  Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218560
  Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
  Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
  Cc: <stable@vger.kernel.org>
  Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
  Cc: <nvaert1986@hotmail.com>

nvaert1986@, thanks very much for your report.  Let me know if you
prefer to omit your email or add your real name.  Happy to do either.

> ---
>  drivers/pci/quirks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d797df6e5f3e..663d838fa861 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6225,6 +6225,8 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa73f, dpc_log_size);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0xa76e, dpc_log_size);
>  #endif
>  
>  /*
> -- 
> 2.43.0
> 

