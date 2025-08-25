Return-Path: <linux-pci+bounces-34632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A76DB3381E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 09:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6D116D0F2
	for <lists+linux-pci@lfdr.de>; Mon, 25 Aug 2025 07:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA5829ACF7;
	Mon, 25 Aug 2025 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="F+CZpcEH"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D355C221578;
	Mon, 25 Aug 2025 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108119; cv=pass; b=F2pwl1kzAZsJcM97E9ZC5+jvbGcOAAp15GIuDOOzDqpPEPeGJyQlbPiE9UJJ5UXCacMjlILdFCENjxFsK5ZCqpp6bVjQy7a90KhsbqwiwCVhNw9HTqoNPr6SzaFe4WFGEBbe8qHiV9uG1AQ0YHBrbenGjspeDBGTu0UJFUmJOTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108119; c=relaxed/simple;
	bh=R5WQhVv7rK8cy7Q4wz4ZKiJYZYoscvA7NtPO3IDhYFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouYBTlir4PXZ+pAsmXmhRwSXSEgx/vtOxBsC8cLtaLakd5iHcsOSHz8OJq8a5FvkS7d/IihkDu75RpQTHsbLl4xO8i00BbK27cSpYB7GkHz3XGKDOv+93v7tZytr+I1IUd4ZciVae/fhWEUGobp5OYUhfMhDoebXrxptzgMyXK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=F+CZpcEH; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756108093; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Mif53jBa6MJhiFA3/aeaKEpanFEPOgAIH7H2ZuUdsrAtRPu/MgbOT3DP6FBY2rj6ePbMjSECj12yIiQqzo9EC3onYNcemMOPA7kexfcK9xKDYPuR6j4sRJVelnLZBLEQG0X38Apa47eBKSzmFFuNz9vrZ2uFGldXO/K346zQY/c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756108093; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=80dzrh8aYZfGg2XUHBNmSgUetz0wp59La7rrflIHLYk=; 
	b=hTrQDB+vFRUoh2TzCLNct7ZH6mA+ZiLxyi08MHJ278n9kJefJSS8W0fZv6yV5vnJvzDAcQZhLzydoq1k/A5PczB6y4tbslyaC/qdgSZhpG/4L25+svqU468G3JXb+BZHKPSOMfmr/+kta3MYdiQArODPHxGvpuzc+7VGFRmUwYk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756108093;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=80dzrh8aYZfGg2XUHBNmSgUetz0wp59La7rrflIHLYk=;
	b=F+CZpcEHNCcVVD5E2eusUhfW3VOUS/ZWUIpDXxI5z5QeKjtOV9RCcGxyZ/bOxE14
	x+XVoB1b6xaPLKM4peUQofBqgx8GIHy0CMMo5WJvpvX22tuJAS78545/+5x34SM4fh0
	HU9zR45BRWmSNqHl8sXRyIGwQroD2o9wsHxVH/9U=
Received: by mx.zohomail.com with SMTPS id 1756108090913704.2939268893988;
	Mon, 25 Aug 2025 00:48:10 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 linux-sound@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 19/20] clk: sp7021: switch to FIELD_PREP_WM16 macro
Date: Mon, 25 Aug 2025 09:48:05 +0200
Message-ID: <2795210.mvXUDI8C0e@workhorse>
In-Reply-To: <175340605069.3513.18204498860033427106@lazor>
References:
 <20250623-byeword-update-v2-0-cf1fc08a2e1f@collabora.com>
 <20250623-byeword-update-v2-19-cf1fc08a2e1f@collabora.com>
 <175340605069.3513.18204498860033427106@lazor>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 25 July 2025 03:14:10 Central European Summer Time Stephen Boyd wrote:
> Quoting Nicolas Frattaroli (2025-06-23 09:05:47)
> > The sp7021 clock driver has its own shifted high word mask macro,
> > similar to the ones many Rockchip drivers have.
> > 
> > Remove it, and replace instances of it with hw_bitfield.h's
> > FIELD_PREP_WM16 macro, which does the same thing except in a common
> > macro that also does compile-time error checking.
> > 
> > This was compile-tested with 32-bit ARM with Clang, no runtime tests
> > were performed as I lack the hardware. However, I verified that fix
> > commit 5c667d5a5a3e ("clk: sp7021: Adjust width of _m in HWM_FIELD_PREP()")
> > is not regressed. No warning is produced.
> 
> Does it generate the same code before and after?
> 

Yes, the generated machine code is exactly the same, at least with
clang, and I'll assume it'll be the same for gcc.

Kind regards,
Nicolas Frattaroli



