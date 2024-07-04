Return-Path: <linux-pci+bounces-9777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B77926FC3
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 08:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 834C2B21962
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 06:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7081A0B00;
	Thu,  4 Jul 2024 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="BPClduXN"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E581A08DF;
	Thu,  4 Jul 2024 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075253; cv=pass; b=mACBVNH+aeyhAKhmHXv60Z6PO5LyhSkQEIDqEh3ZHsClkHFHLiG/6n65wIj9qQBHHyV8k0vS5ibAu89e/gI2xK8O6JIjAp0BfCxwkanjFVW7y/uAYMVP5wNeVMONekRgh5abV5K3AiBg0y6ldKp/euycMiV1mB4W+iiThIgA1Sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075253; c=relaxed/simple;
	bh=8hFZAidPcDdSv5uZH+SmygHMQQ9j5VWMuPUkSwHgy9M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NSOdHpRU02sUO4DjBYBX4ejPH40HCaIU2nBSiCaQnW3+1W8yTLqWkEBk8uDf6DW4bftbP/uFCOr540rAP4gU/PmbXJMGUg8LRv8AAW20ZUUcoFIpiy4kA7G4HTojFF26TQYpkI03ZNBoRLKRlwZP+Zahw1wEmX9fEdjFjc+3RR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=BPClduXN; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1720075230; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cbsMDJ54XPbGsKgUiQwKU7Ossbnsg8BxvxEELPKGPAuY/PP74KQ1THVR+f+2W9o+ADhwkcIKw/Ctx5zj0k/8FlCiAPC4pXTwZCwo9zH85KIST7mZ4xeHleItb8vlDzhoPD0amRqk+9HrOdhYr4dxCzesUz9s1QbZI5Y8lXXadRU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1720075230; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8hFZAidPcDdSv5uZH+SmygHMQQ9j5VWMuPUkSwHgy9M=; 
	b=aGksZX+N7VCE5DHcZjN5gmSkFCrauOkc3ItXGeXGF8xcbTegqshMq2K92D4c2iwdnrQLgSpoIVYjsw44+pbL62OinZEdvNhpdUHdOhfCSQ5jm8RuaGylhxtXYl+ZQ/DjqrS61LRgO6/AmnsAdtl4cl2V+n9Y/2XajWV05d7kpmw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1720075230;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=8hFZAidPcDdSv5uZH+SmygHMQQ9j5VWMuPUkSwHgy9M=;
	b=BPClduXNj8xNP1fWI91lDWKzZEdUHdscAWayV9vvGrlTnyYXi9iJC9YJ+nu+saxo
	CjtOLXf66Iqa6VfImP7P9rWowH+8uJHhbXhI2mtJXqqdsoR7R8Ub2Y4Mh8GnFKY+k5k
	urMMQ8m4Cb3znWg2Sv3yYplh+Rp0+h2oXH604TfTw7zUCIlM/I1kmchLW3qr63g3CYN
	7RkB1ueWuLspSYOPNbHCrOV/dpdkVOtHLguWI5uWiWu3rIySJBJ/9NALdsiKNFs5j7j
	XVjrC10DVJbjjhW9zfTXDRww3vqTqZKdKmoHqJI4KpUbLrucdGUSmXTQiSn0Widtx47
	N2QEBmh2jg==
Received: by mx.zohomail.com with SMTPS id 1720075227349371.7068907339411;
	Wed, 3 Jul 2024 23:40:27 -0700 (PDT)
Message-ID: <51603213d16493879c85417c0c8cc3f2df0cf7cf.camel@icenowy.me>
Subject: Re: PCIe coherency in spec (was: [RFC PATCH 2/2] drm/ttm: downgrade
 cached to write_combined when snooping not available)
From: Icenowy Zheng <uwu@icenowy.me>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 bhelgaas@google.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Date: Thu, 04 Jul 2024 14:40:16 +0800
In-Reply-To: <ZoY9HZwon3_yiq6F@infradead.org>
References: <20240703210831.GA63958@bhelgaas>
	 <99ff395019901c5c1a7b298481c8261b30fdbd01.camel@icenowy.me>
	 <ZoY9HZwon3_yiq6F@infradead.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2024-07-03=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 23:11 -0700=EF=BC=
=8CChristoph Hellwig=E5=86=99=E9=81=93=EF=BC=9A
> On Thu, Jul 04, 2024 at 10:00:52AM +0800, Icenowy Zheng wrote:
> > So I here want to ask a question as an individual hacker: what's
> > the
> > policy of linux-pci towards these non-coherent PCIe
> > implementations?
> >=20
> > If the sentences of Christian is right, these implementations are
> > just
> > out-of-spec, should them get purged out of the kernel, or at least
> > raising a warning that some HW won't work because of inconformant
> > implementation?
>=20
> Nothing in the PCIe specifications that mandates a programming model.
> Non-coherent DMA is extremely common in lower end devices, and
> despite
> all the issues that it causes well supported in Linux.
>=20
> What are you trying to solve?

Currently the DRM TTM subsystem (and GPU drivers using it) will assume
coherency and fail on these non-coherent systems with cryptic error
messages (like `[drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring gfx
test failed (-110)`) without mentioning coherency issues at all.

My original patchset tries to solve this problem by make the TTM
subsystem sensible of coherency status (and prevent CPU-side cached
mapping when non-coherent), but got argued by TTM maintainer and the
maintainer says TTM's ignorance on non-coherent systems is intentional.

>=20


