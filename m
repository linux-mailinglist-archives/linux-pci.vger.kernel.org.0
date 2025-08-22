Return-Path: <linux-pci+bounces-34609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E90B0B320BA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 18:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B60622468
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D14A285C8C;
	Fri, 22 Aug 2025 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITh/XnKa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245121858D;
	Fri, 22 Aug 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881201; cv=none; b=RkImi+FBmgIjXtgfU0uGIcLQn9L7HkGVaBNbaaqUmHge42QDeTto3xx177CI8pzMrsDXAKNy8ZXd1wLYY8SBU5NKo3bV0ScR+JdQzruYa46CbPRyu+ANx+iHeAA9mX0I8vX1bkKaABzE0s6uAOIDscXg/qShAxHqMFUI2o+Gwk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881201; c=relaxed/simple;
	bh=dPxj/m4CZ5Tj5I+499kIt/zRVHwkfdttODzZjZjbop0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JnfdqOg97IReyPnmA3zHgnI9v6wHDao9WG5kHT5bPDGqpxeAinOKUIUqE4nK3oDNBEgBJ+YXAc9WG7Bs8mxQzRNSbz6wzoskoyKF4Cx9TCR2Gz0HVUTB3fBfpy01gGfSF//i5x5vdUiG4uRy1175VWHg8ALJod0E6/dDyLsbSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITh/XnKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63763C4CEED;
	Fri, 22 Aug 2025 16:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755881200;
	bh=dPxj/m4CZ5Tj5I+499kIt/zRVHwkfdttODzZjZjbop0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ITh/XnKaeS2UpNYSnqVV1/mAJPnzHT2RTwOpKQj7KPzwefdqyxSExAwrOCmvLUDTQ
	 /MGYLQcBCta9hcsfd3XbIDoPrgbVnWz/WVY0qzAYNkNFPmHYzMZsrmGyxSg+iL27LM
	 SE8OYZBeoZkireZdjlNrxkw1JaDYWiESlLdQ9Bw9NSS24X1YonMPACKRtDPNm/KOw3
	 WRdKdzowVUapWvs6XAlwopRdZfrtG1FSV3SvFwOm+TDk/4lb+yU8jKiWi2CotCn2YC
	 dZySaUBJuS4A9atNiUN+9VeI4oTvJGyMBqELRhN77Oc7HUGQpNoq9x0CC9SVAm6Abt
	 TNCSoNnLrhFjA==
Date: Fri, 22 Aug 2025 11:46:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PCI: Replace short msleep() calls with more
 precise delay functions
Message-ID: <20250822164638.GA687302@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822155908.625553-1-18255117159@163.com>

On Fri, Aug 22, 2025 at 11:59:01PM +0800, Hans Zhang wrote:
> This series replaces short msleep() calls (less than 20ms) with more
> precise delay functions (fsleep() and usleep_range()) throughout the
> PCI subsystem.
> 
> The msleep() function with small values can sleep longer than intended
> due to timer granularity, which can cause unnecessary delays in PCI
> operations such as link status checking, reset handling, and hotplug
> operations.
> 
> These changes:
> - Use fsleep() for delays that require precise timing (1-2ms).
> - Use usleep_range() for delays that can benefit from a small range.
> - Add #defines for all delay values with references to PCIe specifications.
> - Update comments to reference the latest PCIe r7.0 specification.
> 
> This improves the responsiveness of PCI operations while maintaining
> compliance with PCIe specifications.

I would split this a little differently:

  - Add #defines for values from PCIe base spec.  Make the #define
    value match the spec value.  If there's adjustment, e.g.,
    doubling, do it at the sleep site.  Adjustment like this seems a
    little paranoid since the spec should already have some margin
    built into it.

  - Change to fsleep() (or usleep_range()) in separate patch.  There
    might be discussion about these changes, but the #defines are
    desirable regardless.

I'm personally dubious about the places you used usleep_range().
These are low-frequency paths (rcar PHY ready, brcmstb link up,
hotplug command completion, DPC recover) that don't seem critical.  I
think they're all using made-up delays that don't come from any spec
or hardware requirement anyway.  I think it's hard to make an argument
for precision here.

Bjorn

