Return-Path: <linux-pci+bounces-30156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DAAADFD7B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 08:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 757857A7ECA
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 06:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8D023F40F;
	Thu, 19 Jun 2025 06:09:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFD214F98
	for <linux-pci@vger.kernel.org>; Thu, 19 Jun 2025 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750313367; cv=none; b=cEjPF4S9Kloa+YEbDshsrSnZwQD62z84coMKUvFesEykfCN2wxNmo8LBZfyrgYor+qi/aPZYycUKfbdG3o8SO6li2snxjF84HPorouOF/GXipiZ1M42bDcMh+ICTv3TOVXqmVNNhVF3tcrOT97SUWtcQrmLv/yvMY15qz5+6/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750313367; c=relaxed/simple;
	bh=xy5LMUpQvHHHxI57aNIsylRjmZAHS7bckyyPaSUiC98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn6aL5WVs5SoYj0Dd3blWjuFdCKgMe/R4HtLvrCSnqnDHZRnUbsE3i1/fxcTh10YquPM3HpFiApkFM14cJaytod2EirgpYfZSiTlckqIb1P3+RL/M2E+qfsquWR/S3lym6HNkIZKIpWZ7+rlxXf+Cxrj49Yc9L70QJDFoT7o+rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id DEDA6200A2B4;
	Thu, 19 Jun 2025 08:09:15 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C5566369F86; Thu, 19 Jun 2025 08:09:15 +0200 (CEST)
Date: Thu, 19 Jun 2025 08:09:15 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Fix runtime PM usage count underflow
Message-ID: <aFOpi9YxuBRp2_zg@wunner.de>
References: <20250616192813.3829124-1-superm1@kernel.org>
 <20250616192813.3829124-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616192813.3829124-3-superm1@kernel.org>

On Mon, Jun 16, 2025 at 02:26:57PM -0500, Mario Limonciello wrote:
> When a USB4 dock is unplugged the PCIe bridge it's connected to will
> remove issue a "Link Down" and "Card not detected event". The PCI core
> will treat this as a surprise hotplug event and unconfigure all downstream
> devices.
> 
> When PCI core gets to the point that the device is removed using
> pci_device_remove() the runtime count has already been decremented and
> so calling pm_runtime_put_sync() will cause an underflow.

Unfortunately this v2 does not address the review comment I provided
earlier:

   "Where has it been decremented?  I think this needs to be identified
    and a Fixes tag added."

   https://lore.kernel.org/r/aEb60TkaaLZ3kKIT@wunner.de/

Thanks,

Lukas

