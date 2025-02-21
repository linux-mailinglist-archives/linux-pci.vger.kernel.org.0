Return-Path: <linux-pci+bounces-21966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 234C6A3ECCA
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 07:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AF7A19C292F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 06:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AAB1FBEB6;
	Fri, 21 Feb 2025 06:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D1WBIcDD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164911EEA2D;
	Fri, 21 Feb 2025 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740118959; cv=none; b=nOIyeMGNc0+tj1Mh3u1qfGbCdPR4yaLZIu6pME9LCT9p1fv//BvrZNhKVW3kRI6eGvF6n210k0Qm8l+xD+g5sPZ3oIvGNimYOt3dGlfN7hFi/KBZHhBkx2+HGjs3eaiyvnvI4mHqiFsa9Zc86lwNXwwrVa8GKfdxseRuaKPvOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740118959; c=relaxed/simple;
	bh=pM+GsGVLYy2zClH3fX68+EJPiP55JufWNpcnXKKBK74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgsY2oCFPHscamZ7Hr4zzGBTDKgkZhU5riCVCcoTAJWBkA6i7NeGtO7ATr7LEkgbtoImRDVEJW2QUdlpVAXydKr5axRWCSgNQS+dSABrIGA/KOUIjA4HSKIzndteZD++bjxaQp50E63D1vjsutoF0WEEL2qkfLzuLVTwH9+A2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D1WBIcDD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F0DC4CED6;
	Fri, 21 Feb 2025 06:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740118958;
	bh=pM+GsGVLYy2zClH3fX68+EJPiP55JufWNpcnXKKBK74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1WBIcDDm9wKmC2o2p3ACQIuSK4x0pXAZds/W4V/JmL3O0mGO09ntUlenHPEn/BhM
	 wrzOvl0FF9gBEPqCYq7HnMMBsYCDH1SYrDXGpMomK+AjK6trBFw+7kXJta/UV1Wllv
	 nktXvH+xhuaOEU+DxTz5ZU5Xja2TNHFbUTU6m3oI=
Date: Fri, 21 Feb 2025 07:21:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Joshua Peraza <jperaza@google.com>
Cc: baolu.lu@linux.intel.com, bhelgaas@google.com, dtor@google.com,
	dwmw2@infradead.org, helgaas@kernel.org,
	iommu@lists.linux-foundation.org, jean-philippe@linaro.org,
	joro@8bytes.org, jsbarnes@google.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com,
	oohall@gmail.com, pavel@denx.de, rafael.j.wysocki@intel.com,
	rafael@kernel.org, rajatja@google.com, rajatxjain@gmail.com,
	will@kernel.org
Subject: Re: [v9 PATCH 2/2] PCI: Rename pci_dev->untrusted to
 pci_dev->requires_dma_protection
Message-ID: <2025022123-hacker-skiing-1fda@gregkh>
References: <20250221000943.973221-1-jperaza@google.com>
 <20250221000943.973221-3-jperaza@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221000943.973221-3-jperaza@google.com>

On Fri, Feb 21, 2025 at 12:09:41AM +0000, Joshua Peraza wrote:
> From: Rajat Jain <rajatja@google.com>
> 
> Rename the field to make it more clear, that the device can execute DMA
> attacks on the system, and thus the system may need protection from
> such attacks from this device.

It's not "may", it is "must" as that is what the kernel code does.

Anyway, no objection from me on this now, it makes more sense overall,
thanks for sticking with it.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

