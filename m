Return-Path: <linux-pci+bounces-20353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 160BFA1C217
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 08:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF6F1888ADC
	for <lists+linux-pci@lfdr.de>; Sat, 25 Jan 2025 07:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0321D435F;
	Sat, 25 Jan 2025 07:49:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676364A1D
	for <linux-pci@vger.kernel.org>; Sat, 25 Jan 2025 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737791369; cv=none; b=X/RIM1PKHxjASbPlTvQWi7/kNOe3qbM487uML9J2m+2s92BZ22S56qlYnhw/z/Bi3DppYXbUxxnfpH4NW978fAtqNjadXvTJgRlix4kMp4k69f1zKqypVjco4p7XCHKBHQGPosEzm1FKKf8+/MhOXJ574jtuEeIMshXilz2VTPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737791369; c=relaxed/simple;
	bh=/J6Bb8jD3+BTNX+uUC3OloaJizsscXKv4mAlCBgF78k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tRDUrQlL2UTlctEHhEH9aftJ5smlpu4iDhtw1VQNrra/cQ3zdvPQfdCZdF3XgDrxty2Td2MfO1YKdGaMAQR3JSwtTMurmGmT5k+8a82Y2EliIc2uIv4jzMRLDFxshX+7zvGi8gFh5eW9vpVq/r78f+pa5eKKavtzAkPo2ID/Qrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id BF9272800B753;
	Sat, 25 Jan 2025 08:39:35 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A83FA4A5E80; Sat, 25 Jan 2025 08:39:35 +0100 (CET)
Date: Sat, 25 Jan 2025 08:39:35 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 5/8] PCI/AER: Introduce ratelimit for AER IRQs
Message-ID: <Z5SVN8tt-xtCAHph@wunner.de>
References: <20250115074301.3514927-1-pandoh@google.com>
 <20250115074301.3514927-6-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115074301.3514927-6-pandoh@google.com>

On Tue, Jan 14, 2025 at 11:42:57PM -0800, Jon Pan-Doh wrote:
> After ratelimiting logs, spammy devices can still slow execution by
> continued AER IRQ servicing.
> 
> Add higher per-device ratelimits for AER errors to mask out those IRQs.
> Set the default rate to 3x default AER ratelimit (30 per 5s).

Masking errors at the register level feels overzealous,
in particular because it also disables logging via tracepoints.

Is there a concrete device that necessitates this change?
If there is, consider adding a quirk for this particular device
which masks specific errors, but doesn't affect other devices.
If there isn't, consider dropping this change until a buggy device
appears that actually needs it.

Thanks,

Lukas

