Return-Path: <linux-pci+bounces-33565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16432B1DB46
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 18:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE57A3C9E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B335C273D63;
	Thu,  7 Aug 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZNejh4T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7427381C;
	Thu,  7 Aug 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582583; cv=none; b=dZZuSflDH+zyUEoe2UbxLz+xL3puZfESDP10hgaHb+edsTX7Xm5LSr6/pXMrNpR96GA+UCo84LbaFSmNcLz2Feo3XXNEXDNR5lBlwOdfSP9YHWeU7lgo/V5SSq4n1DATr6yDcYvv2JlcfbjuVCjvmrdCdT9lD45CJkQ1rUS0NfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582583; c=relaxed/simple;
	bh=hcnVu7tDgb/ADY1nYYF8paHUskD2YSfWU7CIZv1TN6o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XEacrmwCwXN6/0xzPTsr0pK9FBcXoTvsZcgqXFjPIVeeQ18v7v3nGU+Q42DJczcZ9FXJZlVgkY5ykaAjwYU+B1BxVoa+c78gODxBOQORiGHdEwRyijFI8Ts4gMKJwPWqscShSWULws8iBRHBFLOj7dcFqmtq8dPwW6rdHfzdCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZNejh4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC465C4CEEB;
	Thu,  7 Aug 2025 16:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754582583;
	bh=hcnVu7tDgb/ADY1nYYF8paHUskD2YSfWU7CIZv1TN6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mZNejh4TyoaZNvB+A3Ma6NgB3CkunSmrXCGpZD3LkXdb/F9gO03Zoqijchx/yfGx8
	 f9U8hfjYmqQIHCkeOkIvP6JuoVsXpJahsDP8PLQ9uQDo9HA5tMwoVWy3oFhcP35ENi
	 oWGNV8cBWSWKUM8QpqhEzj3tNmCGOs0VhKMZYzuIety8yoAMh1+s7x8LUgDSRI8jtQ
	 maCwH0E3luvZn3J1yoZQsvmEnvOKVPFSNuGWbnL9c8jK5xmbMshy1fC7rXnjTwc9xn
	 TekFNyAHWwXvmC9BlVVI9z1lXXyT2nQZ42e2ZUzik55jFOsWNgb+GwK0PrJN/6xfS0
	 cuW2jMfcKkj1Q==
Date: Thu, 7 Aug 2025 11:03:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kenneth Crudup <kenny@panix.com>
Cc: namcao@linutronix.de, mani@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: Commit d7d8ab87e3e ("PCI: vmd: Switch to
 msi_create_parent_irq_domain()") causes early-stage reboots on my Dell
 XPS-9320
Message-ID: <20250807160301.GA50800@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa40e48-8840-4e61-9fda-25cdb3ad81c1@panix.com>

On Wed, Aug 06, 2025 at 04:07:30PM -0700, Kenneth Crudup wrote:
> 
> I'm running Linus' master (as of today, cca7a0aae8958c9b1).
> 
> If I revert the named commit, I can boot OK. Unfortunately there's no real
> output before the machine reboots, to help identify the problem.
> 
> I have a(n enabled) VMD in my Alderlake machine:
> 
> [    0.141952] [      T1] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1280P
> (family: 0x6, model: 0x9a, stepping: 0x3)

#regzbot introduced: d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")

