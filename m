Return-Path: <linux-pci+bounces-30440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6623CAE4C4B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 20:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027DA17E001
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 18:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EFD1C07F6;
	Mon, 23 Jun 2025 18:00:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814474A24;
	Mon, 23 Jun 2025 18:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701640; cv=none; b=fX9X7sc6w+VALqRs/RIq7aPbCcDgrJPPSRC9EvJyCtZwvyTDRjFCtlRHWvZCI/e5KlOgXp7MHYFuHgcMuyqIP+60IiCl3oznsqmOvxKlxbRa+DeFGZxcBq5BR8QSWDLTZicGdger2To605EV+7FUbJgDGntZK/kHKqyrqLOn98Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701640; c=relaxed/simple;
	bh=2Zb/X76hGLMtOvc73fPeJAQeukskv+DbhVHnOwqWSw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4x6VznUkUU4b2lHbYFhRiQ6QmRF6ycFI9I/H+ErO/kS2ZDtUWtKJoogb0VZf0OANZco4ycG9jDpq7lNz04rvNLllTAUU3DOcw33CwvCYBBsMoFa0X3lOR7fDXHOFKkrtBiFNwNWV0Ura4hNzGLD7yjbTeLhuYuQnKpHi3n+zgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 55FE22C0666B;
	Mon, 23 Jun 2025 20:00:35 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 50A523B45B8; Mon, 23 Jun 2025 20:00:35 +0200 (CEST)
Date: Mon, 23 Jun 2025 20:00:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Hongbo Yao <andy.xu@hj-micro.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	peter.du@hj-micro.com, jemma.zhang@hj-micro.com
Subject: Re: [RFC PATCH] PCI: pciehp: Replace fixed delay with polling for
 slot power-off
Message-ID: <aFmWQ4atT8roSr6I@wunner.de>
References: <20250619093228.283171-1-andy.xu@hj-micro.com>
 <aFP598Yyl0el1uKh@wunner.de>
 <b95a60f8-0e1d-4c81-8d5a-e2ea7d083780@hj-micro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b95a60f8-0e1d-4c81-8d5a-e2ea7d083780@hj-micro.com>

On Fri, Jun 20, 2025 at 01:54:05PM +0800, Hongbo Yao wrote:
> The affected hardware configuration:
>  - Host system: Arm Neoverse N2 based server
>  - Multi-host OCP card: Mellanox Technologies MT2910 Family [ConnectX-7]

Thanks for providing context for this patch submission.
When respinning, please make sure to include the information above
(as well as all the information in your e-mail) in the commit message.

Thanks,

Lukas

