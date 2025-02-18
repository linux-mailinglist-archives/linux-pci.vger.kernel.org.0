Return-Path: <linux-pci+bounces-21773-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BD1A3ABFC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 23:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A04F3AF023
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 22:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F41C1F12;
	Tue, 18 Feb 2025 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAjIEIpf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F22188938;
	Tue, 18 Feb 2025 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739918816; cv=none; b=NeNHO3QwXmTW0OnUvz5sPfTdgyySYtpLxjiKCBCy2jTM+vGM9h1FSpm706QxLHU9viXc0SZlyq8oYfMpCi5CAgzqNi2GA5PTwf1EYEe19nf58VmOVTZIVeCGUnUwUTtSx7CGIlMNODL4vHaVIHarbQIcYchkvuR5I44Oy2XvdeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739918816; c=relaxed/simple;
	bh=in3o55prMcCRL5fwuueC4ZxCYh3nOckxK171+Sid3B4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Exw/oxn7a7wm/Bj6cbWwipsDtpLfDE0QRgED//Y9+5rxzKGugkd0vnhb3B6Db0/22TCx2aTTS9uO1aqZ4fdlScNv32nVx+wbMtMVbMf0/xMU5H25qVovlVHtaIHhWqW64sMEX40YIDWPUJ3gPsekI74Ho5BtnzVtEu9p9rz+Tas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAjIEIpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F615C4CEE2;
	Tue, 18 Feb 2025 22:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739918816;
	bh=in3o55prMcCRL5fwuueC4ZxCYh3nOckxK171+Sid3B4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VAjIEIpffsRcZnsTZC8HLfY61G3ZAbUU0Dwpcn4xmBMfP2+RussNxOvNvmAhD/O6f
	 8N9icu3EanLnuSUKDwco0ywHY4zszdCi89EKTnLXXDoHgy//YF/trOA3WTfktZ8z2h
	 XvyIOwFfG5PgBreN0ILcnB7dgyvXmb9Dr9yutXuhoieuuqqas1ocVxK+36NW/ldXD+
	 6pz2f9kJ8VIZ/rVr0NdfbLbsArAiBHKReGUhQmrqivdlZP9Vm9Jpjv3Jm82Yov8ruQ
	 9fyUuoAoU3crkVJbkQRozLzNO/Usffkptuo+KRSzx+yCAQ1w7JTdwiNyGvkG0NznaY
	 k61qMY0nmnKdQ==
Date: Tue, 18 Feb 2025 16:46:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/2] PCI: Avoid capability searches in save/restore
 state
Message-ID: <20250218224655.GA198400@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250215000301.175097-1-helgaas@kernel.org>

On Fri, Feb 14, 2025 at 06:02:59PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Reduce the number of times we search config space for PCI capabilities when
> saving and restoring device state.
> 
> Bjorn Helgaas (2):
>   PCI: Avoid pointless capability searches
>   PCI: Cache offset of Resizable BAR capability
> 
>  drivers/pci/pci.c       | 36 +++++++++++++++++++++---------------
>  drivers/pci/pci.h       |  1 +
>  drivers/pci/pcie/aspm.c | 15 ++++++++-------
>  drivers/pci/probe.c     |  1 +
>  include/linux/pci.h     |  1 +
>  5 files changed, 32 insertions(+), 22 deletions(-)
> 
> v2 changes:
>   - Drop VC change that broke saving state (thanks, Ilpo)
> 
> v1: https://lore.kernel.org/r/20250208050329.1092214-1-helgaas@kernel.org

Applied to pci/enumeration with Ilpo's reviewed-by for v6.15.

