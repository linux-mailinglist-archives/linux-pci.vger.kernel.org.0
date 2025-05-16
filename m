Return-Path: <linux-pci+bounces-27857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322BEAB9C60
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 14:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03EA517645F
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF76323FC74;
	Fri, 16 May 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR7z420g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B12023F40E
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 12:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399216; cv=none; b=LMXH9+YvRzPi6m4zCAyyz0iqWGmfh6hf/4guYOlcZ4+FNxTpw9LbVBf+4np+sBt2DJ560bjnWdbCeE930xI16wUpRwgXOO3E1SlNMd5gYFPZxPrt+ExjPbF4eBvKcQKBogkMCgSP5T29Noao2Ncv6l/RNChpwE152KmyQtbFaJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399216; c=relaxed/simple;
	bh=GBrxj6TerclvJbtjzQ7rWkGs+axESewP/qpXnwcBEGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEHRG7RkzGMX9Up8IUqcYp6u+JuWxJHXtEICw68w6iYQClam3CMKDcugyFYCHYe3yGPYC7P61Rdj3wSKDPZmPAsLIXCHTWUDsD7O7+VHHjadure6i/9dDryadDYMixn3IPipoO7g9PcLh3nh1sS4pLHbddiy3U8YeslqMWoCzVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR7z420g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C389AC4CEE4;
	Fri, 16 May 2025 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747399216;
	bh=GBrxj6TerclvJbtjzQ7rWkGs+axESewP/qpXnwcBEGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QR7z420gsUyY202KUrTSUAMm0hU3enAqL9UYe1Puc1zcWhf/Bn5oLDfOhagbyAwPl
	 CqY4/ryaLq4z+flIRpHHG5OQBBmxcZMaqBkjnAICIrfuDLqgcQomrqdJwKrtOWY/Yy
	 3bWC0sy1H9Vs7u4dpZR4I1kc7VjaC6tFbL5ctOHps+K+HzcI35VohVDE84diHAodNy
	 p7dBhJN0IlQfWi02Rd1Omp8ikp5uLHa2+7QsYiwIIB85TPF66shvzxBnBVgdFTvOXB
	 gQC8QUOO6Htzr+QS+zRZIw3E83bKRCoPHVHN50ewa3pRb+NRbddkM1DCGYhjpVW+hS
	 SelJ4t97GZyYQ==
Date: Fri, 16 May 2025 21:40:14 +0900
From: Krzysztof =?utf-8?B?V2lsY3p577+977+9c2tp?= <kwilczynski@kernel.org>
To: Hans Zhang <Hans.Zhang@cixtech.com>
Cc: kernel test robot <lkp@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbcGNpOnNsb3QtcmVz?= =?utf-8?B?ZXRd?= BUILD
 REGRESSION ebf9d2fae99254fc37f49384b769f363e676018d
Message-ID: <20250516124014.GA1271624@rocinante>
References: <202505161941.DgLuz14e-lkp@intel.com>
 <KL1PR0601MB4726D2AB68297F6CA2B73D649D93A@KL1PR0601MB4726.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <KL1PR0601MB4726D2AB68297F6CA2B73D649D93A@KL1PR0601MB4726.apcprd06.prod.outlook.com>

Hello,

> I think we can ignore this compilation error problem. Because it is normal in this branch.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dw-rockchip
> 
> The compilation error caused by Kernel robot not pulling the previous several patches.

This branch no longer exists as of yesterday, so I believe this was queued,
and run in due course.  But, like you said, no action for us to take.

Thank you!

	Krzysztof

