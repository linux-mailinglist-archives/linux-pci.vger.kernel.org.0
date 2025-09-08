Return-Path: <linux-pci+bounces-35632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 182D7B48425
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 08:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638D1189E942
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 06:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8AE23E35E;
	Mon,  8 Sep 2025 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeWKOgCk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CFE231845;
	Mon,  8 Sep 2025 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757312716; cv=none; b=DraegvgukG1X0yT4z/YRTtsgOYl0Qku8AyoyeCtEvtn28pjTVnKQhAPTP8XDdlgBGIQju5lUcqS5QVynqcfCUXKHUH01EwaniduoZMX2T8gN0UD/qDEK69wcl0t0i2sAHbvRxoRRKHZqg7XDi4JR3ijvJheUEtHjne0iwDGd/Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757312716; c=relaxed/simple;
	bh=6ssuQTpIXE23EK9hqLCqjAZ5FjE1N2R6dC78iHnX3zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+wTPfKantmcDqquYDRR6ycv7sgSCQjJk7YhMqN0aGQUkayzPP3YhvdRXSByxpaN5doWpd5KfN/X2fYN8Y2AVUFH91tIxy+oFy0OmyDa6pt9Y8vF3IEorZuZUz+olfx6aLaeov+NELj3JtRjPsjH6wISh+fF+Cc4mJvcIR9xtN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeWKOgCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495F2C4CEF5;
	Mon,  8 Sep 2025 06:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757312716;
	bh=6ssuQTpIXE23EK9hqLCqjAZ5FjE1N2R6dC78iHnX3zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PeWKOgCkplJY44cOU1qlst0sWthYLy2zKTYxEufc+zvNtkLCQcMta3KpbqOkzfo4x
	 UZzLQ+c9lDk1HWBBRIiUnzApEnVtnpGX+DYOAT/1uY1jhBM4gEgyliHwCG/RIO5vrI
	 uV4sqcZ2utkgbgqb5iDJmoNefehLZG8MwFAIEletU+I/vl+yaPkTeSiNENojdvGFwL
	 YAD78cl2/P8SDOxLpoRdudgEsbH4eDIPVHo9JLvfRzXMf4zk5LK0bohhk9oQivrtZX
	 95t9cPQfeZlWFkRbSzOCktNrXXC09CgnOLC7FPolqqYcvpaS73S9lookl3NBvUdQl/
	 bxoPMsrd1vXug==
Date: Mon, 8 Sep 2025 11:55:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] PCI: Replace short msleep() calls with more
 precise delay functions
Message-ID: <yulkb5stdnirx76ysfbjmcjaxk6bi2skyxfitkrjybs6ogolji@eyrvr7sjfkdd>
References: <20250826170315.721551-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826170315.721551-1-18255117159@163.com>

On Wed, Aug 27, 2025 at 01:03:07AM GMT, Hans Zhang wrote:
> This series improves code readability and maintainability in the PCI
> subsystem by replacing hard-coded delay values with descriptive macros.
> 

For the controller drivers, the added macros do no good and provide no value.
So if you ever respin this series, you can drop them.

- Mani

> The changes include:
> - Adding macros for various delay values used in PCI operations
> - Replacing msleep(2) with fsleep(2000) for precise secondary bus reset
> - Keeping the same delay values but using macros for better documentation
> 
> These changes make the code easier to understand and maintain, while
> ensuring that the timing requirements specified in the PCIe r7.0
> specification are met.
> 
> ---
> Changes for v3:
> https://patchwork.kernel.org/project/linux-pci/cover/20250822155908.625553-1-18255117159@163.com/
> 
> - According to Bjorn's suggestion, split the first patch of v2 and add
>   macro definitions to the remaining patches.
> 
> Changes for v2:
> https://patchwork.kernel.org/project/linux-pci/patch/20250820160944.489061-1-18255117159@163.com/
> 
> - According to the Maintainer's suggestion, it was modified to fsleep,
>   usleep_range, and macro definitions were used instead of hard code. (Bjorn)
> ---
> Hans Zhang (8):
>   PCI: Add macro for secondary bus reset delay
>   PCI: Replace msleep with fsleep for precise secondary bus reset
>   PCI: Add macro for link status check delay
>   PCI: rcar-host: Add macro for speed change monitoring delay
>   PCI: brcmstb: Add macro for link up check delay
>   PCI: rcar: Add macro for PHY ready check delay
>   PCI: pciehp: Add macros for hotplug operation delays
>   PCI/DPC: Add macro for RP busy check delay
> 
>  drivers/pci/controller/pcie-brcmstb.c   |  4 +++-
>  drivers/pci/controller/pcie-rcar-host.c |  4 +++-
>  drivers/pci/controller/pcie-rcar.c      |  4 +++-
>  drivers/pci/hotplug/pciehp_hpc.c        |  7 +++++--
>  drivers/pci/pci.c                       | 11 +++++------
>  drivers/pci/pci.h                       |  3 +++
>  drivers/pci/pcie/dpc.c                  |  4 +++-
>  7 files changed, 25 insertions(+), 12 deletions(-)
> 
> 
> base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
> -- 
> 2.25.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

