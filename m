Return-Path: <linux-pci+bounces-13743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB04998E7C9
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 02:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285591C21147
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 00:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AED4C8E;
	Thu,  3 Oct 2024 00:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="MgG3i8yt"
X-Original-To: linux-pci@vger.kernel.org
Received: from seashell.cherry.relay.mailchannels.net (seashell.cherry.relay.mailchannels.net [23.83.223.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3552F8F40
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 00:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727915750; cv=pass; b=PZEPcvE5vPUmIYVPeR2StTKAhZje1wxILp63KAJswli6fFHIXplTjt1wnRibCTcbQzCkGqGCssQx2tp1bE/RPxYrRVINy3s8/2/Rf0FehV5X1YQdaWyZxCK/+G/4woUlYLYOICbCHkJSsZXteklOlqVRHMwqiUWj9tbdvBX2F3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727915750; c=relaxed/simple;
	bh=FHDq5kRAeHVS8EUnXNz/+vcOLhagvkhIde4vR7vLyJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyB3Sj6yW6j95NZdDqr4NkJeMVX5qXLd0Lz27TAb2602nxcXOHy43i/BsiGXJyLeDcQmlkiAMG80W8Tqg6V9tVc8Ec8LXKenaSd46iEcurgIvYMtMr6xTQMQcJMM11TnDxk6Tf7dL22laegLtzW7Kne6Q5M+UjguLJyGIUIzQKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=MgG3i8yt; arc=pass smtp.client-ip=23.83.223.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A15E2163CB9;
	Thu,  3 Oct 2024 00:35:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (trex-14.trex.outbound.svc.cluster.local [100.99.68.195])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 50BE3163F34;
	Thu,  3 Oct 2024 00:35:48 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1727915748; a=rsa-sha256;
	cv=none;
	b=RBQr8eQ977wIgsi4KD8wdSQ++R3DRWKJnS+ndC3sDC0VDNqjqAXU1TDV93R5FGvcO4NXnJ
	CZtT+Ss2BCtln2nfZa8QJohG6SckP8+H6M+f3nBVb8ooo6N2JtyuztP5Y+dIUq3lfZ781Z
	oEpXE8brphJ3ma1H1A6Dbaa4Z8BqYJGVEkeouz3wnLx3Eg7VoSFjVfw14iIb0tHBee/DTJ
	tGlp+y1Zbe9Vo5dSASoDSH0caGiwsXCo1Frs+FTNVdGiDcXB5DMDIpTtlgDmNicrstVtAR
	TANSojIW1Ccf01qf0wKTpn+KZCtSrl5ANwPx8aoRFlGMkvEX2FtdRTej9EjMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1727915748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FHDq5kRAeHVS8EUnXNz/+vcOLhagvkhIde4vR7vLyJA=;
	b=9+JNb+EGBpFpUCrss4NvG9PrdtJzXMMxt9RG6i+5tFPSwUBdJGZIh5x/5AHi4lC4K9kY8V
	SIKftoUBrDxr2hWjKGnSs8RXi6UyVI4CKZ1WV9nJOIAztlpex+TO99Ubv2KUPLdVgBf9Nz
	nwsXCeI/bN1d0c2FRaPvfzJ0D/AYOY4BXV4wNxhFkbmhd+TOx7ydRESDpe1elXJcAmGe4W
	q44Rl8v2l3ltSvuy6MTvSy5SbwK3SQ3dxMNUJd1NxgVEyfppsgtxTKfEdTfgWCPt2bPuXV
	qNL2aic7Awb9SdRe+iH4mlsuUlNZmlBw5TeDvA97cnB9Qzkz8F/RNYXyNGkJ8A==
ARC-Authentication-Results: i=1;
	rspamd-784544597-cg2hl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Coil-Well-Made: 2d0f9e5a0c5e060e_1727915748568_1067714614
X-MC-Loop-Signature: 1727915748568:3347900354
X-MC-Ingress-Time: 1727915748567
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.68.195 (trex/7.0.2);
	Thu, 03 Oct 2024 00:35:48 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4XJt4z65y8z6Z;
	Wed,  2 Oct 2024 17:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1727915748;
	bh=FHDq5kRAeHVS8EUnXNz/+vcOLhagvkhIde4vR7vLyJA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=MgG3i8ytnTCw6hTXPBirkd6X/xhRu/fh9SQ0rJZwESBMiSCtu4J9koxlW7C2p4Oyp
	 SHWS8VdmKXaC4qQwhEBgoTOR/YGE/MnEBYeq+nPPe+qG9qiaWteuxjyyknDSaljmWx
	 sT3XSs57DR/dDMwy6hfl9Z7A3LQ0g6ZBdI/oNz3ZyIfE8AfKEohGIJWIkz5zJlGLMl
	 KT7p3on5Vz8Ti0xvPU0GLj3hqvcUu+q8iisUI5V0ELUmFlaZupW9JTl0NMI3SDjJ5S
	 ePlhbF1nds1OXEvwqH692Eh7xpwiUoZy+3bwDAJTjuYMmyPPe79Ov63zDaqFl+j0Jk
	 OkIK8bBRljwNw==
Date: Wed, 2 Oct 2024 17:35:44 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	Keith Busch <kbusch@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv2 5/5] pci: unexport pci_walk_bus_locked
Message-ID: <20241003003544.32scol5kzsyejolp@offworld>
References: <20240827192826.710031-1-kbusch@meta.com>
 <20240827192826.710031-6-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240827192826.710031-6-kbusch@meta.com>
User-Agent: NeoMutt/20220429

On Tue, 27 Aug 2024, Keith Busch wrote:

>From: Keith Busch <kbusch@kernel.org>
>
>There's only one user of this, and it's internal, so no need to export
>it.
>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

