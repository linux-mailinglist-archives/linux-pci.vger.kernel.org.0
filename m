Return-Path: <linux-pci+bounces-16017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509719BC1BD
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 00:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A27E2B21325
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 23:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B92E1FDFAF;
	Mon,  4 Nov 2024 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsHY+mRe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1AD139CFF;
	Mon,  4 Nov 2024 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730764773; cv=none; b=iVgFEtj2BTqvjI5SF32Tu7Erf3f8omfTjgHofi+KEHNIomhTBG4CD90IXU7NayfzbLwJNQ4ZV/7T1247B95oC2/tyr4F3d/8Dvd0OAYWqs3gdS9sJhw9Oz3gGWrjA39nIqshaSSQ2ekfbwjYVj+cJMZTcQVRAv4ynzNXHxHyggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730764773; c=relaxed/simple;
	bh=xS4FlVRvslkC2U0BqdTfNNki8LuVdQ3DTqlvOv6iznQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i2OfrqPJgy8LJtFf6bVpu7vcPVbgEyO1UxMi1ElrpR7modClzkrIfVJf6Yh0A+Lhlq7AuaD9GbL87fY8HUsk3V4K8t5+UPGTHdSRC8nZFfIhxwr0FBt9to0Y1yH3UJt/16BmoPkr1ZVHIjQTCMXm0P7SwvwPbgeC3JJQClpbGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsHY+mRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB35C4CECE;
	Mon,  4 Nov 2024 23:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730764772;
	bh=xS4FlVRvslkC2U0BqdTfNNki8LuVdQ3DTqlvOv6iznQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nsHY+mRe6MOH6ym/mnv8oXQpY6gJNQ5YVwRDm52dWAYhQpzN3i142CZod+EN4Iu5M
	 a0zMbeBDlivxT726udJgCjwJnss3EAXlve/rMwToVSk7ObfphDf4wX35SITJhz6+JV
	 T3xWlLd3dtkd1AZt4utpsDwMQj5RKTxOTQZBr2cC7tYH8kh3Ngv92atvnFo7V5GXdO
	 rq5dFnaqiu4JvOifxgFbM+A1trts6jrXoPWncySR6LwRowHqAdYKcOFTd9BpOTslx7
	 ap0FYQ+G8dbK5r7kqjSWsaH/tzTnNdLLbjbazNOy8sxyWWH9ZaKDtZ2/9zTuNY3FmA
	 0FVoDZ4eTYazA==
Date: Mon, 4 Nov 2024 17:59:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI : Fix pcie_flag_reg in set_pcie_port_type
Message-ID: <20241104235931.GA1447239@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104091627.400120-1-gthiagarajan@marvell.com>

On Mon, Nov 04, 2024 at 02:46:27PM +0530, Gowthami Thiagarajan wrote:
> The port type in set_pcie_port_type is not set proper when an invalid
> topology is detected. Since the port type was not set proper, the child's
> extended config space becomes inaccessible.

Please describe how the topology is invalid.

> [   70.440438] pci 0002:00:00.0: [177d:a002] type 01 class 0x060401
> [   70.463056] pci 0002:00:00.0: reg 0x38: [mem 0x600000000000-0x6000000007ff pref]
> [   71.806936] pci 0002:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [   71.906688] pci (null): claims to be downstream port but is acting as upstream port, correcting type
> [   71.916138] pci 0002:01:00.0: [177d:a002] type 01 class 0x060401
> [   71.935982] pci 0002:01:00.0: reg 0x38: [mem 0x600000000000-0x6000000007ff pref]
> [   72.134703] pci 0002:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [   72.198956] pci_bus 0002:02: extended config space not accessible
> .......
> [   83.762956] pci_bus 0002:03: extended config space not accessible
> [   83.792530] pci 0002:03:00.0: [177d:a065] type 00 class 0x020000
> [   83.813188] pci 0002:03:00.0: reg 0x10: [mem 0x600000000000-0x6003ffffffff 64bit pref]
> [   83.832490] pci 0002:03:00.0: reg 0x18: [mem 0x600000000000-0x600003ffffff 64bit pref]
> [   83.848507] pci 0002:03:00.0: reg 0x20: [mem 0x600000000000-0x60000000ffff 64bit pref]
> [   83.935564] pci_bus 0002:03: busn_res: [bus 03-ff] end is updated to 03
> [   83.998804] pci_bus 0002:04: extended config space not accessible
> [   84.025026] pci 0002:04:00.0: [177d:a063] type 00 class 0x020000
> [   84.055298] pci 0002:04:00.0: reg 0x18: [mem 0x600000000000-0x600003ffffff 64bit pref]
> [   84.147582] pci_bus 0002:04: busn_res: [bus 04-ff] end is updated to 04
> [   84.202778] pci_bus 0002:05: extended config space not accessible
> [   84.228684] pci 0002:05:00.0: [177d:a063] type 00 class 0x020000
> [   84.258887] pci 0002:05:00.0: reg 0x18: [mem 0x600000000000-0x600003ffffff 64bit pref]

Remove timestamps since they don't help to understand the problem.

Also, if this only has to do with the port type, the BAR information
probably doesn't help understand this either, so we can remove it.

I think if you use a current kernel, the dmesg logging should include
the port type (Root Port, Upstream Port, etc), which might make this
more readable.

> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> ---
>  drivers/pci/probe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4f68414c3086..263ec21451d9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1596,7 +1596,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		if (pcie_downstream_port(parent)) {
>  			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
>  			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
> +			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM << 4;
>  		}
>  	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
>  		/*
> @@ -1607,7 +1607,7 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
>  			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
>  			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
> -			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
> +			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM << 4;
>  		}
>  	}
>  }
> -- 
> 2.25.1
> 

