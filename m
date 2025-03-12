Return-Path: <linux-pci+bounces-23532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585D6A5E57E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 21:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262F018977D5
	for <lists+linux-pci@lfdr.de>; Wed, 12 Mar 2025 20:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77471EE00D;
	Wed, 12 Mar 2025 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5T+p++k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3E1C695;
	Wed, 12 Mar 2025 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811989; cv=none; b=FwjHsbARUZmZqE7V/tCnkc10Nx1UvIyZyKDaTJDgpnE00CTgdGWYbq+lPmVM8KGZxIA5+o/ej8iGk33DdLWw1du9jzxTvdqKroYHTKJFkERJITO+Gl8rGaN+5XJE++ST0SHMKuVQbJApSv6Man5MYxr7HsGfGqCqZLxGufi8sBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811989; c=relaxed/simple;
	bh=TmiviA+VcijXjWuW1S0ZGGa5Gg1Nt8JBa1LZFUJnuGk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ojO2P9crYb3p1heShWIMadtSgXYZGIO29fn3tuzA5KDIZz9lTSFajEMzpddib0rQ0NMaAp6N3aUigTSjjNr+qgJxtR/+NSPSqDolu7U1lVh+hBwJGBKmoA3sYRtfAQ5lqE6mo00ng/3mu/qPHehKEWcRsYJQji4IQfDPLK7qAIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5T+p++k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A03C4CEDD;
	Wed, 12 Mar 2025 20:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811989;
	bh=TmiviA+VcijXjWuW1S0ZGGa5Gg1Nt8JBa1LZFUJnuGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W5T+p++k1J69U2YCHpLelDNRWld8kPoDGNaZVyxxWTDaFh0a5EHjxYc2CG/53dChM
	 CBgMxF2AGo9qkOwonv88SdyJpIq5/OQ7sn32ahbi300jvp2r9ujspLeTw8n8qPCYyv
	 dUyoOltoDNrV8h76q60dbI+vWVV8vm1r5RqXeuE/t9pLTUL+m0JTGUnR6PiozMftau
	 VXCQaNCLnMm/lfkMWH9xAiWPp487iDSSX/bTxG36OaExUYob1J2IekKyO9Jk+4r6+k
	 CnOBHaDfIyJlPyO7tyQpwYCSJUj5OlDoTGD3yCfdHSXga/WPqOm5C/f9BPVN0I8EIU
	 7WBYyiHdoAxbA==
Date: Wed, 12 Mar 2025 15:39:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Harden PCI resource array indexing
Message-ID: <20250312203947.GA707250@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312080634.13731-2-phasta@kernel.org>

On Wed, Mar 12, 2025 at 09:06:33AM +0100, Philipp Stanner wrote:
> This is a v3, spiritually successing "v1" the original implementation of
> length checking [1], and "v2", the fix squashed in by Krzyzstof [2].
> 
> Changes in v3:
>   - Use PCI_NUM_RESOURCES as the devres array length and provide that as
>     a bugfix to be backported. (Damien)
> 
> [1] https://lore.kernel.org/linux-pci/20250304143112.104190-2-phasta@kernel.org/
> [2] https://lore.kernel.org/linux-pci/20250305075354.118331-2-phasta@kernel.org/
> 
> Philipp Stanner (2):
>   PCI: Fix wrong length of devres array
>   PCI: Check BAR index for validity
> 
>  drivers/pci/devres.c | 18 +++++++++++++++---
>  drivers/pci/iomap.c  | 29 +++++++++++++++++++++--------
>  drivers/pci/pci.c    |  6 ++++++
>  drivers/pci/pci.h    | 16 ++++++++++++++++
>  4 files changed, 58 insertions(+), 11 deletions(-)

Applied to pci/devres for v6.15, thanks, Philipp!

