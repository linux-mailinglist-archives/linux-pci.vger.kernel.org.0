Return-Path: <linux-pci+bounces-32031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9491CB031E6
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 17:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47313B2032
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 15:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B9728468C;
	Sun, 13 Jul 2025 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Sa6U5ae7"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF827F003;
	Sun, 13 Jul 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752422031; cv=pass; b=tjvWHFKLyBmcn1DAV62LyFnHmzOPWi975Zm61yOLy2BBHRfxxPESXolnwhXayN0mKdP8bz35wdipUc5CvQGAawkr3wRZWTl6hU8LEwUJhxaIyGHIodqxfuVilI49Au+Ugjl3beJldveOJnGl3gZAyYgS1gT1mAJR4aeuVUC7AtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752422031; c=relaxed/simple;
	bh=22FzkDc/5FFEKJ4hKxiC5HFlOTtiICJIaNtii37WxzQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=A7IL/qfdwNz+VV68Q1HZ6yKxbOuNc2+w+Xe/Q/nQGEAP7lF32M+0CmKViEiEuwVppD33w9AcJrH/41BArPDcUDYurfDV0fP4eZXirHnFz5SeUIcSGeMBguKrGgLe1m3iazhFK+ESEAqq6bR0JKmxrtsNngZ283bjVlVccB8UFmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Sa6U5ae7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752422005; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T/LiBbeauDO1VQSA27N9NSBnoMAqhOUpZ+RlJ7zBT/3qaAGeeDsRll6r6P2TwNn7BCHDTFAeWoE7ucVGFmsbiy5RKJEKCP+Ng6A7yt37p2Q+ZgcEHzuyka9+7AIbSvxw8r8W9MgQpkFJqQnRXSN1RW1X16pHYuVw3s98xOJCm2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752422005; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FVGOZz6+i8auJ8frrno2oObXTdz7633Bu+4dk1ToQYM=; 
	b=gYToCsa62Dsw+JfBGbYg+D++QxFvrLUQciXo6qLKBq9aACvixR7ugGEpqNKzPM2RxsVubbPVrc6PYTCeA6EHGDFgGgq6Ei+t0LJJrb2k1cYkx0/Hfj33J5tw//bJCIZb6TnPcTp5STzX+s8S7GSbEZ9WZuG0Wu5EMuTTvSgTn7c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752422005;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=FVGOZz6+i8auJ8frrno2oObXTdz7633Bu+4dk1ToQYM=;
	b=Sa6U5ae7+eAv/GxnEgox/d3jPMzKoqMDCZd8z7rqNvKaPYIRKxLTvYQr7NLp7mKr
	EMXSw+JVbfKXdeZDV7i438rZq0+DyE1lWH8vairk5+SYlsZ4JYcLhlXjY5b/1Q6PzKx
	vjYWLTzav3IMWF5B2Ld7fEbJP692YBOsryEWcqy0=
Received: by mx.zohomail.com with SMTPS id 1752422002319162.3932624833626;
	Sun, 13 Jul 2025 08:53:22 -0700 (PDT)
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
In-Reply-To: <1F0227F0-8554-4DD2-BADE-0184D0824AF8@collabora.com>
Date: Sun, 13 Jul 2025 12:32:27 -0300
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
Message-Id: <AACC99CD-086A-45AB-929C-7F25AABF8B6E@collabora.com>
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
To: Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 13 Jul 2025, at 12:28, Daniel Almeida =
<daniel.almeida@collabora.com> wrote:
>=20
>=20
>=20
>>=20
>> (2) Owning a reference count of a device (i.e. ARef<Device>) does =
*not*
>>     guarantee that the device is bound. You can own a reference count =
to the
>>     device object way beyond it being bound. Instead, the guarantee =
comes from
>>     the scope.
>>=20
>>     In this case, the scope is the IRQ callback, since the =
irq::Registration
>>     guarantees to call and complete free_irq() before the underlying =
bus
>>     device is unbound.
>>=20
>=20
>=20
> Oh, I see. I guess this is where I started to get a bit confused =
indeed.
>=20
> =E2=80=94 Daniel

Fine, I guess I can submit a newer version and test that on Tyr.

Dirk, can you also test the next iteration on your driver? It will =
possibly
solve your use case as well.

=E2=80=94 Daniel=

