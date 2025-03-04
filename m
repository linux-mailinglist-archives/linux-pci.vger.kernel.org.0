Return-Path: <linux-pci+bounces-22914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88173A4F0A3
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 23:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96413A5EB0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 22:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2D01FDA8D;
	Tue,  4 Mar 2025 22:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXSUmnek"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345B91F03D7;
	Tue,  4 Mar 2025 22:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741128125; cv=none; b=S0P9ZQzYbfaxec4p4AJsxkVH7HhV4N0pieImyi/HZcam/ZfSzQRZcs8Oo91KiiF576qxtNf6vAnHfB2iXrKj2NYD99AZesMh5nSKM8mDwHTxo3RoHqyqBaVIKAVDa3qfiGSHqvQEjHZdTC0+Vdlp2UIIP3gVML7v1g58veBeqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741128125; c=relaxed/simple;
	bh=lVnymA60HmSZG+igOrN6c3CxYLXL85eQGfRLhLo9tU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gPtyrIIgaWLVIwbyPIAjHh4rGAYvCJV/C3gwXb1PbtxIkMIoNSJ9z2xseulzXbNFB0a752f6vkq2yZYt1Wzeej2SOsuIdx/UrF7cFgryz1uo0dSf49JxjQdYU9boV09jZrDffsEUvjUmipzcQ8v/DCPG0DQw9t5BDRwGEX0dQ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXSUmnek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909C6C4CEE5;
	Tue,  4 Mar 2025 22:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741128124;
	bh=lVnymA60HmSZG+igOrN6c3CxYLXL85eQGfRLhLo9tU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LXSUmnek0zRIOQ3Vwq8xRnAnSsU76SfnPjOM9g/zyVE/mZHl45099Sh6ATGV1U6cS
	 0zmvuUEBkqFQZKs6YbBLmi+uNN+rzxeMxMyqKMsa2HZJz38hrhXPG7L2Pp3tyikai0
	 oMV5uv/XBenF1FpDBh90ThH1FFkFH/R4XfS2RE/LX9sjglgl14beqR1zzGtS9b97D7
	 BPcI7EPu8kHkZNxbWRNcG3bnGc3e8eCWQWySeJt46fIbOIiN2Oo9Ln17MDohBmu91B
	 p96J4R+RHP1H1rvPfR4tyYEf3tcn/rEFgkIEwRD5F1ourOiAsSMEpQYDw903H+SEQ6
	 svI03azfAeWuQ==
Date: Tue, 4 Mar 2025 16:42:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bingbu Cao <bingbu.cao@linux.intel.com>
Subject: Re: [PATCH] PCI: Check BAR index for validity
Message-ID: <20250304224203.GA260968@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304143112.104190-2-phasta@kernel.org>

On Tue, Mar 04, 2025 at 03:31:13PM +0100, Philipp Stanner wrote:
> Many functions in PCI use accessor macros such as pci_resource_len(),
> which take a BAR index. That index, however, is never checked for
> validity, potentially resulting in undefined behavior by overflowing the
> array pci_dev.resource in the macro pci_resource_n().
> 
> Since many users of those macros directly assign the accessed value to
> an unsigned integer, the macros cannot be changed easily anymore to
> return -EINVAL for invalid indexes. Consequently, the problem has to be
> mitigated in higher layers.
> 
> Add pci_bar_index_valid(). Use it where appropriate.
> 
> Reported-by: Bingbu Cao <bingbu.cao@linux.intel.com>
> Closes: https://lore.kernel.org/all/adb53b1f-29e1-3d14-0e61-351fd2d3ff0d@linux.intel.com/
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Applied to pci/devres for v6.15, thanks.

I reversed this:

> +static inline bool pci_bar_index_is_valid(int bar)
> +{
> +	if (bar < 0 || bar >= PCI_NUM_RESOURCES)
> +		return false;
> +
> +	return true;
> +}

so the test describes valid indexes, not invalid ones:

  if (bar >= 0 && bar < PCI_NUM_RESOURCES)
    return true;

  return false;

