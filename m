Return-Path: <linux-pci+bounces-31181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB28CAEFE02
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 17:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4822B3AEBF9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3BA2798E6;
	Tue,  1 Jul 2025 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="GBVwu3uk"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E7427935F;
	Tue,  1 Jul 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383430; cv=pass; b=kdnnVwyWt0KNRk4WzmzvsVn2XiCCdqEsq1IozCWIor3eFChbiVSBYZcbECpGQn2QKptHoCq4Ni2brSkPNmkbT+DENoOKK0zuw7526lT3e2P4oZl0NTy8T/U+yMyL0bWXA8946H+hkrPc/tvicVxtz5MGg1r6OhonZtYy8UUedTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383430; c=relaxed/simple;
	bh=u5H7Ki3Uc472xoh1prN9UsQjiNEbTVL8UfwlIfP67qE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=o52IF/4l00TjRID5sszpn3ppd9BVNFtMbfx9Giq5SKShUC27UVSBlk92aHq3T+/cDBa8II4b/sSVJ/NBEULOzCn/NlH2y26Ct3kesSL4A4R2tzKVX0EKRQLWHqETKxt0i8NWAUNQeMcFU77ONCkjKYNueGr6MX+z1LCGQqIcX3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=GBVwu3uk; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751383387; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dh43jjD67eEL8rhJp1dIKSd4AixeF5/p3902K4h9pKcojEGnSeQUjMVjcBdvRSqsDK6v03R+q1gLWJwjDU4SD0JBnsvNxHaQsNnV8kj4ezuw/ZTVOKMEDOlP8CL/HgBc3EoZADExn8OHSfI1fpLJrKHLiQCPsDygkCPPOx4zPy4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751383387; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oMnN5862CUhYGYQHo2feKEf+ebQKDIQoTAibORo62JI=; 
	b=W03P+eSfdfcLI1L1AZfnVqSm14+25iQhjqha2N9ag6ZmRL03WX7aZxKlCvw5Jzt3FmDdkyhhGL7ToPPOtvN5qEniW7bo/PswKVRwcvzsBI/6suA2xce25qKfWk1qoJLemBvImrvjaiLo8laZMGvqwUkUzClW6dEm66F0tzz3xWM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751383387;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=oMnN5862CUhYGYQHo2feKEf+ebQKDIQoTAibORo62JI=;
	b=GBVwu3ukZ+qeVJUuuoKoib95nWm9eSPWKByLlFYErvrUFgsO1Z4Q2bYnwiftsFlv
	FHy2CPxu7JhBeO2cIfNPRraK5vEOklysKBPdRQzwVwle4swS2BfcsAr22KCBFfGc/73
	Y3MKhVlvuW+iBSJ8KkE4zfqCUWkZvmbR5WjM/+Zk=
Received: by mx.zohomail.com with SMTPS id 1751383384665179.9428978034714;
	Tue, 1 Jul 2025 08:23:04 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v5 4/6] rust: irq: add support for threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aF7xlhJeb-t_blHf@pollux>
Date: Tue, 1 Jul 2025 12:22:45 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
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
 Benno Lossin <lossin@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3767EFC5-6BBD-4EC5-8E20-5A9A12A56531@collabora.com>
References: <20250627-topics-tyr-request_irq-v5-0-0545ee4dadf6@collabora.com>
 <20250627-topics-tyr-request_irq-v5-4-0545ee4dadf6@collabora.com>
 <aF7xlhJeb-t_blHf@pollux>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Danilo,

>=20
>> +    fn handle(&self) -> ThreadedIrqReturn;
>> +
>> +    /// The threaded handler function. This function is called from =
the irq
>> +    /// handler thread, which is automatically created by the =
system.
>=20
> /// The threaded IRQ handler.
> ///
> /// This is executed in process context. The kernel creates a =
dedicated
> /// kthread for this purpose.
>=20
>> +    fn handle_on_thread(&self) -> IrqReturn;
>=20
> Personally, I'd prefer `handle_threaded()`.
>=20

Don't you think that handle_on_thread is more expressive? You can derive =
the
semantics from the name itself, i.e.: "handle an interrupt on a separate
thread". Although handle_threaded should be understandable by all kernel
developers, I think it's slightly more obscure.

In any case, if you still prefer handle_threaded then that's fine with =
me.

=E2=80=94 Daniel=

