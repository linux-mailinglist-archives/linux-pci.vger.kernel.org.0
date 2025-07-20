Return-Path: <linux-pci+bounces-32595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97521B0B304
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 02:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FADC189C3EE
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 00:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B07EF507;
	Sun, 20 Jul 2025 00:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="QJ/wvtJv"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0E186A;
	Sun, 20 Jul 2025 00:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752972406; cv=pass; b=pn8rsmt2CAn6LAJ1ryFIinssnIDesBQjF32oiLt3TmMSuShkoPm3lz0w9pOACh23uUeCZHOBEr201y1sZJ3yaXdBSQbxoohgozJ1/7HDuIASytePEYjnU/vy/YjLYTHwer69J55NWQI8kNkDzQmi7Cbdf0sZdRSsnyu9boiPGb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752972406; c=relaxed/simple;
	bh=RCMhaNF73IsXyuAJ+j6RrC60q8zTRTKwzopHxGIjgSY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AA3dHaiTDyFDDol9nMZCGodiBpDA02Phv25KZ5/yg1XOiN3xvuWhm1Ka48d8qeR5mPzEA6zhu+E3xYBZVwRE3ebTBTbyhyqwmWjTlaMBn6rovPlsnDMce+2TeR4WLFFqQbYKtgLxWsM6h0aiaInVdx1F4ebZGGxEgJxllYO0efM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=QJ/wvtJv; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752972362; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g4COvUywzMSeRRyXvcFAnvKY3+hu+MDC6ae9mXd6c8fPl+us9VrDamaq6sC8XHEtJFsBmoY1Hzv4vZBMnc1gfarvsGsgU0DwXAmxSXJt/ijU+z92vQP1uoPNslX2Be7tyu1hatdu8+uzihvTEaOGqh3cOUDLglvij7zquiAubnw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752972362; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lMTx2r8Z+X9Aqblv0RaFBmOLKDhzz5NGNxEUj/Eml3Y=; 
	b=h0bx7tYIXnVtHnMSs3vJSBueufe2O9QqnFm6QJL5Oa1bQ2hvOOB2vBHzAaCL8zkK83ED0jS9MkmmPfWWy9iF94RKpRFNU4NtxesuqJHBMARoDn8ByM2Bb994TSkLEPwO3mBbt6uZjT8kOCcKCVj6iHw6Z9GkjdsIw71aW/eSuwI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752972362;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=lMTx2r8Z+X9Aqblv0RaFBmOLKDhzz5NGNxEUj/Eml3Y=;
	b=QJ/wvtJvq6UH1xOGLLwv+6div3lICXpcQn2gmnJ7CBkmvUrxhOWRmfmMQmgQIjg2
	oFdO47uul6gfLZ3qQFCabDVEkJDj11+fwuoPTjxB8G0o4a/2S0mvmlL6ZzRERSEkfxC
	S7fKehhSYTczceOfdvhCn9e91fFXXklCvWKKyYbk=
Received: by mx.zohomail.com with SMTPS id 1752972361237945.5987989359068;
	Sat, 19 Jul 2025 17:46:01 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <ce656239-08a1-49e8-86b1-b33d0cdfbcd3@gmail.com>
Date: Sat, 19 Jul 2025 21:45:43 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1C5BFA7-9B72-4277-A7E9-BC6F19110AB7@collabora.com>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org>
 <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com>
 <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org>
 <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org>
 <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org>
 <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org>
 <C4A101A7-282D-4A67-A966-CF39850952EA@collabora.com>
 <DBAZRNHGIGL8.3L2NGPCVXLI25@kernel.org>
 <DBAZXDRPYWPC.14RI91KYE16RM@kernel.org>
 <18B23FD3-56E9-4531-A50C-F204616E7D17@collabora.com>
 <DBB0NXU86D6G.2M3WZMS2NUV10@kernel.org>
 <1F0227F0-8554-4DD2-BADE-0184D0824AF8@collabora.com>
 <AACC99CD-086A-45AB-929C-7F25AABF8B6E@collabora.com>
 <ce656239-08a1-49e8-86b1-b33d0cdfbcd3@gmail.com>
To: Dirk Behme <dirk.behme@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Dirk,

>=20
> fn handle(&self) -> IrqReturn {
>  let dev =3D ??;
>  let io =3D self.iomem.access(dev);
>=20
> Thanks,
>=20
> Dirk

FYI, until there is a patch to provide Device<Bound> as an argument, you =
can
resort to the slower try_access().

=E2=80=94 Daniel=

