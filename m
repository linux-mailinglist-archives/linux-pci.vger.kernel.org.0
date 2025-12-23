Return-Path: <linux-pci+bounces-43606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C1CCD9FBF
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 17:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EAE3301619F
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF9B266B72;
	Tue, 23 Dec 2025 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRuj1VOV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525F79CD;
	Tue, 23 Dec 2025 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507726; cv=none; b=NzFH1iXK7vuKiUiiViWCxgJLioNIvjZIL3zdLNqOCQA6I32cxmGXu7TlX4FyjkgJOy/oTNErbC1eSu0g3qR4Em6JAzUvXPgBvK/jfTEj4L1B4BvLGrSDl/3U0/30LWTBBQlc7a8hRt1MrmrvETvfyTGtykwv2qIB41gLEVg3M28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507726; c=relaxed/simple;
	bh=ZESbi+TrkNK4tqxR/bdVx8ZRRP4KnsWOxreowqvBoEA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TBdFO9WknJPplYct88SVXuipD+Tcrd2cAcHhv76VMf++mnDTXEuOP0AiOJZE2kR5Q/L+i2aUuhd/PEeygVGmsKv0dMxgGSGcLk/E+It+s/UO3jFTjTuoRrqkTXwdUryzDtwoZHAeHicJYLSAtgxyHnwkopEulQwv3qUSlBYk98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRuj1VOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E087CC113D0;
	Tue, 23 Dec 2025 16:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766507726;
	bh=ZESbi+TrkNK4tqxR/bdVx8ZRRP4KnsWOxreowqvBoEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RRuj1VOVAlv6/9x9qFFTE3dwLgaMtjP/exe1lzFyrYxUCvMiQLYCME/vamBfNtyOY
	 fgpbHYvbJMa2guehCZm2VwXYa4Q7hbcMoVZ1HZAfQj9S83RPIjs6yDQutFfe+1TF0d
	 79wN4uruka3ZxLgbG+40yZr929oZn/5OT3iBFwobE9fIHzEQq9Ol8yZ5t1CGuy+SV8
	 iOFZ9yKNklR9/vNWucL7QXB2rfZgajtQKNNCCpyso19bmSlDENe7Xt02naUw8qEjHN
	 AZSBA2A9t4aMwo0u6BsVpts2h3WVbuAKlP0EXaXLrWSq/Y6i8REfCOfVkXb3pTOmKk
	 zXQK5hkBwLujg==
Date: Tue, 23 Dec 2025 10:35:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yang Zhang <zhangz@hygon.cn>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, bhelgaas@google.com,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] X86/PCI: Prioritize MMCFG access to hardware registers
Message-ID: <20251223163524.GA4022428@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216111513.7698-1-zhangz@hygon.cn>

On Tue, Dec 16, 2025 at 07:15:13PM +0800, Yang Zhang wrote:
> As CPU performance demands increase, the configuration of some internal CPU
> registers needs to be dynamically configured in the program, such as

This looks like a v2 (but it's not labeled as such and there's no
indication of what changed) and posted only an hour after v1.  Don't
do this.  Often there will be other reviews in a few days, so it's
better to wait and address all the comments at once.  Updates once or
*maybe* twice a week is plenty.

Bjorn

