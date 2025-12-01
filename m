Return-Path: <linux-pci+bounces-42384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F5AC98810
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 18:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22223344BF4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856933375CB;
	Mon,  1 Dec 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFyxWPbs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CE7335BDB;
	Mon,  1 Dec 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609793; cv=none; b=LQ503NWrvo/13k+52eTNJrgddIVPlWRVfOZTe7l4IAMkm+iNuZxlAo1vKFSIN4kNUb3WnJHywvoVa5qIP1eZNeNFpE5RerkQ3u21rFktlARHK5YIh21aZK31uULCjvZIt0zxXVM4FDcIA/MXaivV6hHuHqptfO3h1lTRZqY+p9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609793; c=relaxed/simple;
	bh=RJqVXuXdZWxWnmtU+9QZzBV2awZeBUdtgRFh+O6fgH0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=P0AVW2jiCMtr//D46se7XeoUHQcT070tk++vBv8abFK4YprfCqjhiPg9H+LONcLVlTrxK6Oir8MitGIsSRWm8c6zrXKorB4nh/U9YmBYiAkbU6eGXUqGhAPsBepqM9QcdY+G/kmADk7c4UowbZIceVqLvEOW5kxYjBD0vxUd6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFyxWPbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000F7C4CEF1;
	Mon,  1 Dec 2025 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764609793;
	bh=RJqVXuXdZWxWnmtU+9QZzBV2awZeBUdtgRFh+O6fgH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TFyxWPbs2px1Iud+65mS2POX82bsaaYnqJkjRmi3xOWBZ7wALmu9o1wfevS+xXMQe
	 LqyDxEajoCTCeM/SNrpd29LgxJz23eZE9JjB0xQbb496euGav8iP65KR7ZMFDqsJbT
	 wd67r0ewzxvsY/7S+CDRcZI9xgUbRTRjvIaQ+8xKhggDZtEXePjDNpWmLvO7aiSot0
	 jOxUJNXMOc/dweF8EcE/1FmM/Innu4k8IxAytXDZpC+ryU4hvNcY2O5GElqGlwPfMX
	 QInhJqUmdsJzdxQYZVaO9EbQTruezBJUejdPHRkhSFsZp4qkE6ttt4dkkscealv4LU
	 Sx9Jeu9/4QwFA==
Date: Mon, 1 Dec 2025 11:23:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	linux-pci@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: Tree for Nov 28
 (drivers/pci/controller/dwc/pcie-nxp-s32g.o)
Message-ID: <20251201172311.GA3019571@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e1daf7-f9a3-463e-8a1b-e9b72581c7af@infradead.org>

On Sat, Nov 29, 2025 at 07:00:04PM -0800, Randy Dunlap wrote:
> On 11/27/25 9:29 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20251127:
> > 
> 
> on i386 (allmodconfig):
> 
> WARNING: modpost: vmlinux: section mismatch in reference: s32g_init_pcie_controller+0x2b (section: .text) -> memblock_start_of_DRAM (section: .init.text)

Thanks, I'll drop the pci/controller/s32g branch until this is
resolved.

