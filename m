Return-Path: <linux-pci+bounces-7535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B548C6DA1
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 23:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50AD4281BE7
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 21:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2333F15B12F;
	Wed, 15 May 2024 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck9f3UoZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38FF15B126
	for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807654; cv=none; b=p7BJePNG5bUnajHBSz58DITiPE/jnstGDLbZ3H1oBPAiCrMOkbIIZJU2U7ILlUNpwv0Ig673i2EMjDnToG8SwK1xmt0POcnLkBnx7rhTBOxkt19Nx7Om9Gjd4AMsTLS68RQgZKTtgpPF3NLAHZSDRE9B3l/cu8G6JI3PaC535tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807654; c=relaxed/simple;
	bh=it91atMIvH+S1hh7KTPixQTxjOewGFSIV5K2G3BKGP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dm0ARGUH11Fy0twPt5zOyuD3dzSL1yuUN0FyQWhD4/yu8FspLSuxp9apv1wsc1pBE6HptiGKpXVvG7yam6UWTFWx8a/WSWWyBnJXi2h3/t6xhVadk9zT9kBRgyLe+8VlRjjnvVJ6sGCdnzPuFwY60jpN3bpL5zcrqgVFuEySxFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck9f3UoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593B9C116B1;
	Wed, 15 May 2024 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715807653;
	bh=it91atMIvH+S1hh7KTPixQTxjOewGFSIV5K2G3BKGP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ck9f3UoZ7IOwB+QGO0+yu15XrGwC9cBQEGWnqlv0GwfLTbEH7rufz5R/udo4XPZca
	 CAiykIzMjc9wY3/EdWhe9RSR7bfFLoZ7cTcUTXtkFuKFlSXtCAK9JZXU9DaOetuHgz
	 +Yv3Hqk+1tyy/9LrgvnQ40sNRe+MYrvuqyXeiV1ZhVZKfSUydoCHaT9mhyW5O8/XuJ
	 94xi6F9fbTrpPMhYAwbsFXi/E7NifU8UGa8MUeY1RlFWT/LcPtUJAcAOzAaD6ovi8r
	 jdIBCzkF05zqGGqOkLnexiqvizpSh4K3hRQ/ONhviccFQRKNpSzOta1+/lkJ9yhFsm
	 NRa5EksIpAuaQ==
Date: Wed, 15 May 2024 16:14:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/2] rockchip rk3399 port initialization fixes
Message-ID: <20240515211411.GA2138954@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413004120.1099089-1-dlemoal@kernel.org>

On Sat, Apr 13, 2024 at 09:41:18AM +0900, Damien Le Moal wrote:
> A couple of patches to have the rockchip rk3399 host controller port
> initialization follow the PCI specifications around PERST# signal timing
> handling.
> 
> Changes from v3:
>  - Fixed commit messages as suggested by Bjorn.
> 
> Changes from v2:
>  - Use PCIE_T_PVPERL_MS macro in patch 1 (and remove useless comments).
>  - Split second msleep() addition into patch 2 as suggested by Bjorn.
> 
> Changes from v1:
>  - Add more specification details to the commit message.
>  - Add missing msleep(100) after PERST# is deasserted.
> 
> Damien Le Moal (2):
>   PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST# handling
>   PCI: rockchip-host: Wait 100ms after reset before starting configuration
> 
>  drivers/pci/controller/pcie-rockchip-host.c | 3 +++
>  drivers/pci/pci.h                           | 7 +++++++
>  2 files changed, 10 insertions(+)

Both applied by Krzysztof with Mani's Reviewed-by to
pci/controller/rockchip, but his outgoing mail queue got stuck.  It's
really too late, but trying to squeeze this into v6.10.

