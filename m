Return-Path: <linux-pci+bounces-32006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E61B02E31
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 01:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F1E27B587F
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 23:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9075E148827;
	Sat, 12 Jul 2025 23:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="RZnQl2yr"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87120B660;
	Sat, 12 Jul 2025 23:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752363198; cv=pass; b=Ek37A5pwXC2VUGcGMM680+4IhqOFPBFMXPHmAqC26SMXSJVPTPRTssLiIemD2giFCxD1tsJR1wjsp/qI8RncC1KEvf21GW7s/jD4oQ6GTya0OJiv/2rPno+YhoopIprn8SUgyN1WrG2KZtX/nvtqWC0yhayZC3nmdJ0QKBqW/PI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752363198; c=relaxed/simple;
	bh=oX0KBa8QcSF1/VTlkNXaw2F1+7wL0jox5K2UeNYpLDU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QDlDbK5t00YNDuz+2b/X7d/GtV05AlbSZ89egMwuclbcp2Tgql4hotYu6NX5+hbOwqIh1ueXqXBUSZpABRd7BqXX2OhfCpDhe5sISZGElbmRxOQrAlJzv/JN6FbnJvqpPvdHVTP9ATPc5crHoxSDPJVXbISTZwFbEMJAR2KzGow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=RZnQl2yr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752363175; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AwEVmKLriLGCswzTfx8op7QW3z9rypXaizpAYWm9g8n+kpbksoQzIJigGGcENqPBnNZWit0vcloD39Qhq7vYjMDj3OfRsjIMx3rCAs5e4+EGsoCXeZ99WLsF9fQAsSFILvsSFCGbcDLa6Bja4Ver1BOl+eQ13XuUOvrtrD9UYc8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752363175; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v1FIws8WLuejVcFHPk2kcrTklHDh2VjZnNxXoePuTq4=; 
	b=cVUMxs3Jq7/1kUjo3kX1jhfdzlzkmwXeRa/XUyqXFXItP61qJWseQwbYdH2hQM6KtkwdJYLboJji/BvIyMckYKkMow+HI1ySEyUv6/b6XrU/lt8kZxSJ/ivFzCoYOZWVcRbg8RlUCVIcxJb6Hf2tcl5ByIQaBbCxiI108x6A96o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752363175;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=v1FIws8WLuejVcFHPk2kcrTklHDh2VjZnNxXoePuTq4=;
	b=RZnQl2yrl//lu6/so+NWHHGdLFR71QRZp/1+/Wq7wzd12CafWym1D+LtGvIUBKhc
	h75w/HDEpD95YPFY6WohX7BiAmegbYGR0YvlXtXjHb3opy6RhbOEZgpZiNy2hemryNI
	EqKhijuKJk5nEPX3RIv2dtAR9Q9Miyu8miNiGq/4=
Received: by mx.zohomail.com with SMTPS id 1752363174056465.42889511897727;
	Sat, 12 Jul 2025 16:32:54 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org>
Date: Sat, 12 Jul 2025 20:32:37 -0300
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
Message-Id: <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 12 Jul 2025, at 18:24, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Thu Jul 3, 2025 at 9:30 PM CEST, Daniel Almeida wrote:
>> +/// Callbacks for an IRQ handler.
>> +pub trait Handler: Sync {
>> +    /// The hard IRQ handler.
>> +    ///
>> +    /// This is executed in interrupt context, hence all =
corresponding
>> +    /// limitations do apply.
>> +    ///
>> +    /// All work that does not necessarily need to be executed from
>> +    /// interrupt context, should be deferred to a threaded handler.
>> +    /// See also [`ThreadedRegistration`].
>> +    fn handle(&self) -> IrqReturn;
>> +}
>=20
> One thing I forgot, the IRQ handlers should have a &Device<Bound> =
argument,
> i.e.:
>=20
> fn handle(&self, dev: &Device<Bound>) -> IrqReturn
>=20
> IRQ registrations naturally give us this guarantee, so we should take =
advantage
> of that.
>=20
> - Danilo

Hi Danilo,

I do not immediately see a way to get a Device<Bound> from here:

unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: =
*mut c_void) -> c_uint {

Refall that we've established `ptr` to be the address of the handler. =
This
came after some back and forth and after the extensive discussion that =
Benno
and Boqun had w.r.t to pinning in request_irq().=

