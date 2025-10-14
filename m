Return-Path: <linux-pci+bounces-38023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E780BD881A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 11:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D5DB4FB37B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 09:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C1D2EAD0D;
	Tue, 14 Oct 2025 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYv0ioYy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5B2EA746;
	Tue, 14 Oct 2025 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435041; cv=none; b=juUCQZu8EwnWk3ZMeXaDK0Vk/FLx5K+UIHXvpcoCQ88fUOc2II5Gn6vVrHT64POkSJ06OSVN64lopEVXZdgs7nTCNaUVhYEKj3C+TTHDt+PIEa4nZYir32XWLgDHcHYTVUACgLbWrEXw0rleArwplsOyWz697nTvnU4TlHEHzo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435041; c=relaxed/simple;
	bh=62DynX5Fht+DyP/QVDKn/evvRtifvlmnihjlLkxrxfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0HYYIB+/YOaBS1Axo4nz0I/uVXfFa4igNCiIfAGgT2So2GrBrrywzYax5fzfoP3dsesqEzBewz5m4lp2ZXL5hNCwIynVQOM6QwiXY5qW3kYlnBeuW5tBXwbiw0lzTvId79N8CmP6MpuS4l7w0EGxKyLTGF0cjwyGTNBSt6Meig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYv0ioYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3F1C4CEE7;
	Tue, 14 Oct 2025 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760435041;
	bh=62DynX5Fht+DyP/QVDKn/evvRtifvlmnihjlLkxrxfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYv0ioYyVYUDNWbhBpxV2Ik86MO0Ueb8AQnNsXonFkoyeF7JcywfD/Fk+h8KezQP/
	 NJRfGcvdAmaqJ8w35uDS1nWteDw5MSoHCPkxaRwsnrLGnQnGu18aSs5WaBaEJeLALL
	 nLUGTxuC0d97AsbCRIHz0vpMg2FjfxXCP/iXdtk0l81+yHpjp3xC+FHEk3M3UoA9Vn
	 mAso3gSByLshjh6KIU1lNqfZTLL0z5NGfB2uDbqzw39D1dxOUTUJiBqAyDncbB+ce3
	 6TfyB1nSVarfBD+t3sp5QNoq4Gh9A3PIP1u/GY8MJJ5h2Jds2MzK7iZ7EYePS0eEuz
	 UzNGKmv+kbc0A==
Date: Tue, 14 Oct 2025 11:43:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alex@ghiti.fr,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
	ben717@andestech.com, inochiama@gmail.com,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	shradha.t@samsung.com, pjw@kernel.org, randolph.sklin@gmail.com,
	tim609@andestech.com
Subject: Re: [PATCH v6 1/5] PCI: dwc: Allow adjusting the number of ob/ib
 windows in glue driver
Message-ID: <aO4bWRqX_4rXud25@ryzen>
References: <20251003023527.3284787-1-randolph@andestech.com>
 <20251003023527.3284787-2-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003023527.3284787-2-randolph@andestech.com>

On Fri, Oct 03, 2025 at 10:35:23AM +0800, Randolph Lin wrote:
> The number of ob/ib windows is determined through write-read loops
> on registers in the core driver. Some glue drivers need to adjust
> the number of ob/ib windows to meet specific requirements,such as

Missing space after comma.


> hardware limitations. This change allows the glue driver to adjust
> the number of ob/ib windows to satisfy platform-specific constraints.
> The glue driver may adjust the number of ob/ib windows, but the values
> must stay within hardware limits.

Could we please get a better explaination than "satisfy platform-specific
constraints" ?

Your PCIe controller is synthesized with a certain number of {in,out}bound
windows, and I assume that dw_pcie_iatu_detect() correctly detects the number
of {in,out}bound windows, and initializes num_ob_windows/num_ib_windows
accordingly.

So, is the problem that because of some errata, you cannot use all the
{in,out}bound windows of the iATU?

Because it is hard to understand what kind of "hardware limit" that would
cause your SoC to not be able to use all the available {in,out}bound windows.

Because it is simply a mapping in the iATU (internal Address Translation Unit).

In fact, in many cases, e.g. the NVMe EPF driver, then number of {in,out}bound
windows is a major limiting factor of how many outstanding I/Os you can have,
so usually, you really want to be able to use the maximum that the hardware
supports.


TL;DR: to modify this common code, I think your reasoning has to be more
detailed.



Kind regards,
Niklas

