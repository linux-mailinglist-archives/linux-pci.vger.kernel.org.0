Return-Path: <linux-pci+bounces-41994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE94C82B59
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 23:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 978C334B538
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 22:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB8F34402B;
	Mon, 24 Nov 2025 22:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="E9i1SJfs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A7344024;
	Mon, 24 Nov 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023690; cv=none; b=TNsTku8pxFc3mr5EHYxgyL24OyRrC0JNbnzdh6Z9XXxMuQEwuYs+T+/tfvHvNnEzFmr0W5sKdvda/X1JESdTpEDKbkfofbWzbJr110jwpRWdQF1mzdTwfabsf/vKBcaKc0kpcZpOYL2eUsehcDZlbx+LwabgXvxoE+V9+w5ACCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023690; c=relaxed/simple;
	bh=5JpKmTiEKDSXyIugOXFybELiowoSicEntJ8pGkk+Hsw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NhmIGBrXo82bcAM6mWGEzE/fFYZSPUxMU3trzOT3bh8LmCcrd9Lz//Og3dDADak4Yh3b9oAkcpOC9PFX789n0lhgHHNMCFaVtrYMRQdHo5q3gkntif/waXnjXwT13Cz12PHKVcvch9wQblb5cwbYwKXGFmC658ky3d0ct2IAF5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=E9i1SJfs; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1764023679; x=1764628479; i=spasswolf@web.de;
	bh=5JpKmTiEKDSXyIugOXFybELiowoSicEntJ8pGkk+Hsw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=E9i1SJfsMEGXCfZCp66aYBjHVXmB2DtJTapEeLbzQ1MAn/bHGqZH0DV7FoJhx70G
	 +g4urcM0Y0iJ/Co2lh/LXj28QjrTBiTDd6y61BAQZBKnFtCqPVL73oWi1wk70+Ang
	 thGFYQ1V2sOnyL8px23LjmwdZc4dwT1OavpNYFCmKfyfuuXCsEBMsFcmcZUT8JYdX
	 7RsKFiRp6+9ybgObadOkuw878DItEoRS0gSNjcErSaNVqEkcOjRzwadCRyLoaEnLe
	 HgTxxfY4LNpzsnEp2KY/uKrLh0+moBE/PEZUiJBT996e7JpMPvccTHw092bgqDqIT
	 J6VP0UT3UfjnBsME8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZB07-1vb5FG3EDh-00S6L1; Mon, 24
 Nov 2025 23:34:39 +0100
Message-ID: <b1fadb15d1869bde81315be7488c50dbbc9f7dbd.camel@web.de>
Subject: Re: Crash during resume of pcie bridge due to infinite loop in
 ACPICA
From: Bert Karwatzki <spasswolf@web.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "Mario
 Limonciello (AMD) (kernel.org)"	 <superm1@kernel.org>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	regressions@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, 	acpica-devel@lists.linux.dev, Robert Moore
 <robert.moore@intel.com>, Saket Dumbre <saket.dumbre@intel.com>,
 spasswolf@web.de
Date: Mon, 24 Nov 2025 23:34:37 +0100
In-Reply-To: <CAJZ5v0iRaYBU+1S4rqYR7D6XC+rfQ2+0hgbodweV5JsFr8EEnQ@mail.gmail.com>
References: <20251006120944.7880-1-spasswolf@web.de>
	 <8edcc464-c467-4e83-a93b-19b92a2cf193@kernel.org>
	 <4903e7c36adf377bcca289dbd3528055dc6cfb32.camel@web.de>
	 <4a8302a0-209f-446a-9825-36cb267c1718@kernel.org>
	 <25f36fa7-d1d6-4b81-a42f-64c445d6f065@amd.com>
	 <1853e2af7f70cf726df278137b6d2d89d9d9dc82.camel@web.de>
	 <f18bafacbd8316c9623658e2935f8fc3b276af64.camel@web.de>
	 <26bf82303f661cdd34e4e8c16997e33eb21d1ee4.camel@web.de>
	 <635b6cb19b5969bed7432dfd1cd651124e63aebb.camel@web.de>
	 <18e472a0489ee5337465d5dc26685cebaf7c4f8d.camel@web.de>
	 <3772b8f5-6d1a-403e-ad27-99a711e78902@kernel.org>
	 <0cb75fae3a9cdb8dd82ca82348f4df919d34844d.camel@web.de>
	 <ab51bd58919a31107caf8f8753804cb2dbfa791d.camel@web.de>
	 <0719d985-1c09-4039-84c1-8736a1ca5e2d@amd.com>
	 <3f790ee59129e5e49dd875526cb308cc4d97b99d.camel@web.de>
	 <CAJZ5v0iRaYBU+1S4rqYR7D6XC+rfQ2+0hgbodweV5JsFr8EEnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:by/LTxf5+y5On/Iz04FuP/kGdj1rdIi/1LUNrFVYLRAHXIb5Xzg
 k+tKcJ7JcpnwuMCXI4gileIAzN5fFTTm08SoFHR2p8KxIbrjZmPXPkK4JV4bi7H754vEBfk
 xdiJshvCxq5AwkG/NwxznFjPhPeK3sc+FFsM/Fb6wgYHmuT7+WT7FBLuwZOwlX516rgXEqy
 kZVZDwHCHrcYUDjFMPRZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:El3AJWqswxE=;3pIY8KKrr73UIWBzV/FoiUVw+MU
 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
 vqBvaJcrYdCqfCCas=

Am Montag, dem 17.11.2025 um 17:40 +0100 schrieb Rafael J. Wysocki:
>=20
> Well, what you have found appears to be an issue in the AML bytecode
> interpreter which may be one of two things: (1) a bug in the
> interpreter itself or (2) a bytecode issue that causes the interpreter
> to crash (eventually) and the latter is quite a bit more likely.
>=20
> I'd suggest opening a new issue at
> https://github.com/acpica/acpica/issues and attaching the acpidump
> output from the affected system, to start with.

I've reported the bug to ACPICA github:
https://github.com/acpica/acpica/issues/1060

There's no "infinite" loop, but a loop running for 5051 (0x13BB) iteration=
 until its timeout
counter reaches Zero (most likely because the hardware is unresponsive). S=
oon (only a
handfull of iterations in the walk loop in acpi_ps_parse_aml()) the crash =
happens. I think
the crash actually occurs inside acpi_ps_parse_loop(), so I wouldn't rule =
out an interpreter
bug just yet.
 The crash also always happens (if it happens ...) in the 30592th iteratio=
n of the walk loop,
so I'm now monitoring the internal of acpi_ps_parse_loop() only in this it=
eration of the walk
loop. (I've tried to monitor the parse loop before, but that only led to e=
xcessive memory
consumption and an activated OOM killer). The debugging code can be found =
here:
https://gitlab.freedesktop.org/spasswolf/linux-stable/-/commits/amdgpu_sus=
pend_resume?ref_type=3Dheads

So far I've had no crash with this.

Bert Karwatzki

