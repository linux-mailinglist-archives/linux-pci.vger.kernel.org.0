Return-Path: <linux-pci+bounces-42508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2DC9C491
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 17:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D0764E2DBD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 16:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDB029BDA5;
	Tue,  2 Dec 2025 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWEbyYTR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C8729BD82
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694142; cv=none; b=Te6eKPP81/ABd9n9kRZJ/fmOHqAT2fHiATbTNuVMeBtbXjkAxcTWisVT493+zrjxn0Vq+GjRfy2hkbEZirn0UPR4JPY21HBzgA8RtGp1lI3k3FIAUTkRs5OgBZRV2KgFvnnSKGqpQkrMQ22zGE+fAi6LvJJFYfPDGPI7YBsbVw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694142; c=relaxed/simple;
	bh=ndK42A1mHaFrL9IphE/9vDujwBh9vvKZuyRznEtX8kk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=syY4TIRuyOcHKRiKeWW13ZLkHa+eSRjqCvMv4ZMQJA70+CpUNdg0G31xtELnKZNrUDvkXbElpyikMUBwJBrXwT8C9E6paAmpTnkqjhCRFciEwLGM2zeCJVRXIPUZhMD69bmAnHfhi/vwkA/sqf3ZzgsEggEmVrifhNZgsx/i8AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWEbyYTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E38EC4CEF1;
	Tue,  2 Dec 2025 16:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764694141;
	bh=ndK42A1mHaFrL9IphE/9vDujwBh9vvKZuyRznEtX8kk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dWEbyYTR37D0B2CA7rvMKTQGG3jayItI5D7GqygKaQHTlEyceoDy3OnINFnvfGnoE
	 iqgIFgyWXk5pRoJ6jd+LECoJ94DCXwzH1m65o2qJnB4rRdOSWJFZh5SjIO/+kE4tnM
	 GodNZBzg2bA6EpncVpAQqzUXJXTvY4kX8X1QpjorK+8m4AQf9MOr+6baOcmpEZeseD
	 8elvuCY3KreexBXOCgSBn+DJu8A8NJ1D+6GnysmzP1gxJgl9gmUHFXjj8/1djPN6zt
	 Ckv+WO6eDqIZwyWBPM9PZIKHeUPIB/arZX1++BaLWhT3me+CX5aLfFJFt32lR9Hs19
	 vEibpiohF2EWg==
Date: Tue, 2 Dec 2025 10:49:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v4 v4 1/1] PCI: Fix PCIe SBR dev/link wait error
Message-ID: <20251202164900.GA3077274@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202043207.3924714-2-guanghuifeng@linux.alibaba.com>

On Tue, Dec 02, 2025 at 12:32:07PM +0800, Guanghui Feng wrote:
> When executing a PCIe secondary bus reset, all downstream switches and
> endpoints will generate reset events. Simultaneously, all PCIe links
> will undergo retraining, and each link will independently re-execute the
> LTSSM state machine training. Therefore, after executing the SBR, it is
> necessary to wait for all downstream links and devices to complete
> recovery. Otherwise, after the SBR returns, accessing devices with some
> links or endpoints not yet fully recovered may result in driver errors,
> or even trigger device offline issues.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>

Can you please supply the lspci information Lukas requested here?
https://lore.kernel.org/r/aS1oArFHeo9FAuv-@wunner.de

Also, if there is language in the PCIe spec you can cite here about
the need to independently wait for each device, that would be useful.

Bjorn

