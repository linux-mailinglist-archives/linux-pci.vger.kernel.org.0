Return-Path: <linux-pci+bounces-31625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF190AFB882
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 18:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802AB1899D0F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C619C1DDC18;
	Mon,  7 Jul 2025 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="jbsbNS7T"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D059F1A316E;
	Mon,  7 Jul 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751905185; cv=pass; b=PoVpB3Z7L2DeLQQKCFyJgjmRSsW4bnsez3Y/yz9cggKfpXOZzrL+8waxlDiKkkIg8+Qb5ayx8bEBs1HsHiawTJNsIROmVH008NxGpfnI1gU78C76WpDWtiglZqNEcNAjOUELXDWOIj1Lr58DtIVRyovgR5qqJVkwYr+RFL3toxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751905185; c=relaxed/simple;
	bh=R94avkSZjApSXUNZ0YQ4lxwJ6hTJ8++8l+29QNsZDtY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WAUBVDIDlYfVO2Yh+y/j/lsLZNbUk9tmrG1OqIk8CxeJrW7ZV7/Tkq1RPgrL6ZDKfM4AIJk70+ryHPOXWRAi+nLEe4yp6bGoPnPAH/O5/JRXF1GEvmBiBLYGPezK+Yk4TRDiuzIe6KjpvcVrVUWiJ8BMeFhXadbQeP2h2wuxS3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=jbsbNS7T; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751905144; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HZgmv52LJzlDRI+1GRTwzz6PMhGLJhuRxzJpb0yIdCcPaih8VQ3fweQAXXeOFXzrC2XxvJJBUnTTg49My+drZ0MC8F5uFODrxzexW74seKuoJHRMhGVyr4CXm3QHQarPU4XyfVQqtZF9/X9015gWaWkr2zv29XvBV7HatTjeE+A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751905144; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ETLYFfIfOLg2rNaiX6F+ay4E3ts9u33x29yYCRsWi/Q=; 
	b=QV0n3xPTo4wpnOHZ8/GpbIWmsodmAMsxpnU+Hg4C925qOyQ4s0q0sYnMRlgFrkUUYFRfW5xIdINqrWltAexi+EN6j79x8r+weRtLDw29Fgw5AgcTgeWW3cydX5kbUkuyAX96EFtnXiek7ELv8vRmk+4ejOFosh7z7x0eK9Jb8co=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751905144;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=ETLYFfIfOLg2rNaiX6F+ay4E3ts9u33x29yYCRsWi/Q=;
	b=jbsbNS7T+VebJkTLbe5JY2EU29NdGsT8DyGAXgge+jagX2BQD4mR1vRX/+60vchh
	Oaj3A2+WGZlyPwQWZdBPUfJo6fwKORY9EPpOBKVKD10jmuUle8ai+5z7axDm9/WoSKY
	QK2D2yBxPe6mWcAu6Ev1x/TtGn3tCpaA0TmjLt7c=
Received: by mx.zohomail.com with SMTPS id 1751905142619899.7142083393121;
	Mon, 7 Jul 2025 09:19:02 -0700 (PDT)
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
In-Reply-To: <aGeIF_LcesUM9DHk@google.com>
Date: Mon, 7 Jul 2025 13:18:45 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Benno Lossin <lossin@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3D3BD51-65D8-44BE-9007-FBA556DFB7E5@collabora.com>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <aGeIF_LcesUM9DHk@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Alice,

[=E2=80=A6]

>> +/// The value that can be returned from an IrqHandler or a =
ThreadedIrqHandler.
>> +pub enum IrqReturn {
>> +    /// The interrupt was not from this device or was not handled.
>> +    None,
>> +
>> +    /// The interrupt was handled by this device.
>> +    Handled,
>> +}
>> +
>> +impl IrqReturn {
>> +    fn into_inner(self) -> u32 {
>> +        match self {
>> +            IrqReturn::None =3D> bindings::irqreturn_IRQ_NONE,
>> +            IrqReturn::Handled =3D> bindings::irqreturn_IRQ_HANDLED,
>=20
> One option is to specify these in the enum:
>=20
> /// The value that can be returned from an IrqHandler or a =
ThreadedIrqHandler.
> pub enum IrqReturn {
>    /// The interrupt was not from this device or was not handled.
>    None =3D bindings::irqreturn_IRQ_NONE,
>=20
>    /// The interrupt was handled by this device.
>    Handled =3D bindings::irqreturn_IRQ_HANDLED,
> }

This requires explicitly setting #[repr(u32)], which is something that =
was
reverted at an earlier iteration of the series on Benno=E2=80=99s =
request.

=E2=80=94 Daniel=

