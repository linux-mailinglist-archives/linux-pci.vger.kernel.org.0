Return-Path: <linux-pci+bounces-30294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BA0AE298F
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 16:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9A33B8296
	for <lists+linux-pci@lfdr.de>; Sat, 21 Jun 2025 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69DC1A0B0E;
	Sat, 21 Jun 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1RpMfqw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C070824;
	Sat, 21 Jun 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517418; cv=none; b=DX03F0UAFvkQxq3sRGCeLY8HCv2WM4M+TvVHfsIzuKn/91Z5B8VJJFveoQha2Dy/vJoSBMd+W8JNt6N0SErmDwUAh7fuVRxoNiQX3nTJ/EAKAhkLlpYTB64ChjXQEsS7hVo1gxgKcRRKYd/t9+pfMkAVXtfoFlZkLf/atX0jHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517418; c=relaxed/simple;
	bh=5BWvViw9dbca0AR0nVo9L5I118Dul+39uN9JX6M2uaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zf6jJTZRuxb3csq8vbbRGI5FPtsBoOZNH3Iu1ED6D5NRGZ+4Rrs0CkYjwBWnzRWj5Z0DkQaOJlOGvZDbfMEzrPD+lcSJXJd1VS6o3xl4bjXCn05myd9aHpcbBWphGNlt3WWnXUwds8qqnlJPijEpxe1YqITVJ2zMHceNRTc9b4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1RpMfqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFDCC4CEE7;
	Sat, 21 Jun 2025 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750517418;
	bh=5BWvViw9dbca0AR0nVo9L5I118Dul+39uN9JX6M2uaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1RpMfqwHAu3tGMI2+gGQ5tCL63uj9Th8WZYlQ1qhOQnyrAKpHDjA6bdvtxNjuFiO
	 5g22Hw4/2LLmHRhRynm+235QVKFheB50+QLPOSGsypv8+SVOpkRbK267KyYu8yeepx
	 AcwfD5YqeqlsA/GCmbNHKkPSQ5MXml33dm+GRhCt0KFGeFfu1KDCks5xyrWnvu4ugG
	 r4zwZrc7NKG42aKveezmi/HpjreRrbQY/lP85PFxkz6W0ZRtLzqAMEVmPsw+cCWYJ0
	 Ftr4cfhdc5zPOHtKbrWG9sC5/18S2giYHvcz+VAxP1xUUcMivS9MS33psuhhC3+7NZ
	 AyfmPV/58UhpQ==
Received: by pali.im (Postfix)
	id DAE4A3D2; Sat, 21 Jun 2025 16:50:15 +0200 (CEST)
Date: Sat, 21 Jun 2025 16:50:15 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Rostyslav Khudolii <ros@qtec.com>
Cc: Ingo Molnar <mingo@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Filip =?utf-8?B?xaB0xJtkcm9uc2vDvQ==?= <p@regnarg.cz>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: PCI IO ECS access is no longer possible for AMD family 17h
Message-ID: <20250621145015.v7vrlckn6jqtfnb3@pali>
References: <CAJDH93s25fD+iaPJ1By=HFOs_M4Hc8LawPDy3n_-VFy04X4N5w@mail.gmail.com>
 <20241219112125.GAZ2QBteug3I1Sb46q@fat_crate.local>
 <20241219164408.GA1454146@yaz-khff2.amd.com>
 <CAJDH93vm0buJn5vZEz9k9GRC3Kr6H7=0MSJpFtdpy_dSsUMDCQ@mail.gmail.com>
 <Z78uOaPESGXWN46M@gmail.com>
 <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com>
User-Agent: NeoMutt/20180716

Hello Rostyslav, you sent an email addressed to me, but you forgot to
put my email address into recipients. So I have not received it.
But luckily, today I found your email by a chance in lkml archive:
https://lore.kernel.org/lkml/CAJDH93uE+foFfRAXVJ48-PYvEUsbpEu_-BVoG-5HsDG66yY7AQ@mail.gmail.com/

On Monday 03 March 2025 10:21:25 Rostyslav Khudolii wrote:
> Hi,
> 
> > Rostyslav, I would like to ask you, do you have patches / updates for
> > enabling the EnableCf8ExtCfg bit for AMD 17h+ family? I could try to
> > adjust my lspci changes for new machines.
> 
> Pali, sorry for the late reply. Do I understand correctly, that even
> though you have access to the ECS via
> the MMCFG you still want the legacy (direct IO) to work for the
> debugging purposes? I can prepare a
> simple patch that will allow you to do so if that's the case.

Yes, I would like to get access to ECS via CF8/CFC direct IO for
debugging purposes, even though MMCFG is enabled and used.

If you can send me a simple patch or any sample / idea how to do it,
I would be very happy. I was not able to figure out how to enable ECS
over CF8/CFC.

Pali

