Return-Path: <linux-pci+bounces-32823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA6CB0F679
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 17:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5CF27BA022
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289E72FC005;
	Wed, 23 Jul 2025 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="kpzOOdKp"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3CF286880;
	Wed, 23 Jul 2025 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282673; cv=pass; b=lSy5DpCoW6PpwhLIvkFcMLBeYsPu0TF5RnuQEijSerVyN3HwqujEGk6iKGBH7TDWjbimsuI9XJ0Tl89trcfrfEcEXJOUdCXKLLnfy+WVtF3Gp7e3EmLm8xK29KlpxwEhbMPjB+FlvGhpVmdpcdixIYiTEySQFr3GS35YgcRM5QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282673; c=relaxed/simple;
	bh=93tYYtpwGCS2CavJKfyj8zfhTq9hJX4RCX5dMS3I4bw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=p9tsRXbEqGQlvV8NQTf8W/uGhmresA7+2DOHhPqTpg+N9XL2RryATyTH0oX9PTNFmCUP+rsy/lq/kFV4eZ/+ze+1nMgk7k0F7BioZdeLtjKBkjNWgfsUzB8vU2Sw4SGAqlmZpVnjHOUoyTR3upQm+otptDtX0El/N/cEmk+ZcwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=kpzOOdKp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753282619; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eAaQE2jKp1gxGdO98JQjDgGFPVe8zalXpPAQI2Ja8Py69P0AaQJccIGqk/bnNDkjEvwYBrjXRnNxRJAYUAqy7ZdL3TunC9xsiv556dQMH8+c/umtC0R76uRp0MoBSBBbvOSupmVTSIJX5glDDYaYsvlycdbysCltyDl3p1hm8lU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753282619; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=93tYYtpwGCS2CavJKfyj8zfhTq9hJX4RCX5dMS3I4bw=; 
	b=c8KaF9uHHh/Nf25tjZbEOipg3AZzNygZCx7b4dqM0ri+1MVlvoBH1Exyt8KWwtxphlDmCHvewCMbRkTv7ijrIYvSICx5d36WcOVXokSgmi/Be1xg3MHiR10Vo1TkiWHvKAmzD+7PAipRg8nboTEnMHehQCkMkY/s0TLlJf0ydtw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753282619;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=93tYYtpwGCS2CavJKfyj8zfhTq9hJX4RCX5dMS3I4bw=;
	b=kpzOOdKpfDWJJl4HlrJH7ghkAmSVNJdUNbR3ZjozbBPvAbl6xb/cze5BxwrEhaaO
	GbpPDtHils3OWXGtwgkcOrinZrNladhzLgtF3l5w5B0zoT6TthvN5YKTlyyL1FukWVx
	kqzUo9/Qo+B0LxuftwdhdQE28Y3z1w6QohAofym0=
Received: by mx.zohomail.com with SMTPS id 1753282617127332.3516121893997;
	Wed, 23 Jul 2025 07:56:57 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <7fa90026-d2ac-4d39-bbd8-4e6c9c935b34@kernel.org>
Date: Wed, 23 Jul 2025 11:56:42 -0300
Cc: Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8742EFD5-1949-4900-ACC6-00B69C23233C@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <aIBl6JPh4MQq-0gu@tardis-2.local>
 <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com>
 <aIDxFoQV_fRLjt3h@tardis-2.local>
 <7fa90026-d2ac-4d39-bbd8-4e6c9c935b34@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 23 Jul 2025, at 11:35, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On 7/23/25 4:26 PM, Boqun Feng wrote:
>> On Wed, Jul 23, 2025 at 10:55:20AM -0300, Daniel Almeida wrote:
>> But sure, this and the handler pinned initializer thing is not a =
blocker
>> issue. However, I would like to see them resolved as soon as possible
>> once merged.
>=20
> I think it would be trivial to make the T an impl PinInit<T, E> and =
use a
> completion as example instead of an atomic. So, we should do it right =
away.
>=20
> - Danilo


I agree that this is a trivial change to make. My point here is not to =
postpone
the work; I am actually somewhat against switching to completions, as =
per the
reasoning I provided in my latest reply to Boqun. My plan is to switch =
directly
to whatever will substitute AtomicU32.

The switch to impl PinInit is fine.

=E2=80=94 Daniel=

