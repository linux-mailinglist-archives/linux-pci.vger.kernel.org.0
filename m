Return-Path: <linux-pci+bounces-21011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2A1A2D3DF
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 05:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A20416BB8F
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 04:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933E74B5AE;
	Sat,  8 Feb 2025 04:50:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FF6137E
	for <linux-pci@vger.kernel.org>; Sat,  8 Feb 2025 04:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738990217; cv=none; b=ZAGFYSfNXzOHMSXP5Rt15zl54f1f6kuCEFF2R8y2F+hErYFgvqmfQvOV1LRsdyga5zdDABZa1xFrsviyt9JGenLVNsgS6p33tEPSaEGyqbMI62eG0gkspSko3gEF96cB9B/uTmK8MwN5AU7+bMmrd1mdA/x9U0JTlJ8+KRPKp/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738990217; c=relaxed/simple;
	bh=42rJKSyJOMqN9hgGg8yGlDpgDC1Pap6cAo3z2Ma99dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZv8Wxlv0PBCYuUfAL/U8W7MRgLzcdbqe65PkIpnui1d3kALZCJLrk3Dl+FNBYLaP92BIuPytm0FY1jMEorXEBpgt+jr2d/TDyXVbEuLRb/neW27KPJNcEU+rj6+fARuk46SjnqcDV8U0rCmgruTrdRrBDEjXYbAdAIxQraclDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 874BC28008B00;
	Sat,  8 Feb 2025 05:50:04 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 735B714B477; Sat,  8 Feb 2025 05:50:04 +0100 (CET)
Date: Sat, 8 Feb 2025 05:50:04 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <kbusch@meta.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] pci: allow user specifiy a reset wait timeout
Message-ID: <Z6bifFBdh-jfEiXQ@wunner.de>
References: <20250207204310.2546091-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207204310.2546091-1-kbusch@meta.com>

On Fri, Feb 07, 2025 at 12:43:10PM -0800, Keith Busch wrote:
> The spec does not provide any upper limit to how long a device may
> return Request Retry Status. It just says "Some devices require a
> lengthy self-initialization sequence to complete". The kernel
> arbitrarily chose 60 seconds since that really ought to be enough. But
> there are devices where this turns out not to be enough.
> 
> Since any timeout choice would be arbitrary, and 60 seconds is generally
> more than enough for the majority of hardware, let's make this a
> parameter so an admin can adjust it specifically to their needs if the
> default timeout isn't appropriate.

There are d3hot_delay and d3cold_delay members in struct pci_dev.
How about adding a reset_delay which can be set in a device-specific
quirk?  I think I'd prefer that over a command line parameter.

A D3cold -> D0 transition implies a reset, but I'm not sure it's
appropriate to (ab)use d3cold_delay as a reset_delay.

Thanks,

Lukas

