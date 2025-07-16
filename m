Return-Path: <linux-pci+bounces-32310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABB4B07C37
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6CEF1887309
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BC028D841;
	Wed, 16 Jul 2025 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="YlrHRIfO"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785791DE2C9;
	Wed, 16 Jul 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687744; cv=pass; b=qbuMq6EgdnmOhljFky7PDPwL6BKJ5CQ3B8k8roTYrMIRoVojS64Obv63ISFhZOBPYmEH/oCTpe2hKP004OKdIP5YZeV80xjTAwJSv/vm1f4e/Bt3kONLMwdaR9FgOasZZx0b1wj6iscipvzta6uWxZVUYzunWmkm9qXT4FTuChY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687744; c=relaxed/simple;
	bh=3NaBS5nR3S8ssAx7En+nn/Xy5hyxierRXt3SH67RW6k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JId0og0VjxnBjeOjWxMYnhHXWZcyU9UxIsFeeCLXlHXd/PEuGohA36bG1W1ZazZa6oOXlgrfu+nhrJwVKljNd7OIxdpKZILVbXZXzJ+im2tbE4M4gud4+FkFF4d+9c926hf4proHIGQtzptsOZB0982xTpqLTdliNty9269Picg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=YlrHRIfO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752687729; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lyA/GHmkWE40kDOB4nKJrEBmWoglZ7t4QNLkjHb+mq+pSISPzZjynRKYnEPaoNYTZ0rH7RNejtDVSoCJo7/5EEXBYa510V9AbCQpoCSYn0AmmYb+KcTnXlmmkcLmeYFYQCSV0D8xI6nGBGpjKsFolwDdbbWA98SYJCO1qmU9Z2c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752687729; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/gYTl5kVhMQO9K++hvRZK4KJ5v0rKQv1CibnG5rWCuQ=; 
	b=Eu15Ek42EzmiGl9aH0a6IeyrgoJgKR1DsZR2JXxq0u8SA93EGXJ5/l6ZggIjiDIQb76RZ0mn2ILBHgIGq9L5pIMXRQK5StZ3pPVLCYjZboxeveBmsBF8Mzc8YL2TZIYDLn3zPdIg5RI/v628G3pFti4KPgVed3cvZwoffBQnSU4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752687729;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=/gYTl5kVhMQO9K++hvRZK4KJ5v0rKQv1CibnG5rWCuQ=;
	b=YlrHRIfO54vgMBu3JLrRFuMcoZa1PzwPMRdNUQtzNrs/S+AG4LdsB29P33Kaw4Pe
	H2x3XdhpRqR9cjkeI5eAihEJSNnJUrOljxTIhxzcItNGpljG2AlY/L+bspWBJPmzHTR
	e34KXk4sqGlVuP/hc9rANMp1mUUN8WZu4xv+xgqQ=
Received: by mx.zohomail.com with SMTPS id 1752687726329979.7431535109736;
	Wed, 16 Jul 2025 10:42:06 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 2/5] rust: dma: add DMA addressing capabilities
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <0984E8E7-C442-42E6-A8E7-691616304F6F@collabora.com>
Date: Wed, 16 Jul 2025 14:41:50 -0300
Cc: abdiel.janulgue@gmail.com,
 robin.murphy@arm.com,
 a.hindborg@kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 bhelgaas@google.com,
 kwilczynski@kernel.org,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B1BCB6C1-745B-4272-A0AB-8B8D1E444ECD@collabora.com>
References: <20250716150354.51081-1-dakr@kernel.org>
 <20250716150354.51081-3-dakr@kernel.org>
 <0984E8E7-C442-42E6-A8E7-691616304F6F@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 16 Jul 2025, at 14:32, Daniel Almeida =
<daniel.almeida@collabora.com> wrote:
>=20
> Hi Danilo,
>=20
>> +    #[inline]
>> +    pub const fn new(n: usize) -> Result<Self> {
>> +        Ok(Self(match n {
>> +            0 =3D> 0,
>> +            1..=3D64 =3D> u64::MAX >> (64 - n),
>> +            _ =3D> return Err(EINVAL),
>> +        }))
>> +    }
>> +
>=20
> Isn=E2=80=99t this equivalent to genmask_u64(0..=3Dn) ? See [0].
>=20
> You should also get a compile-time failure if n is out of bounds by =
default using
> genmask.
>=20
> =E2=80=94 Daniel
>=20
> [0]: =
https://lore.kernel.org/rust-for-linux/20250714-topics-tyr-genmask2-v9-1-9=
e6422cbadb6@collabora.com/#r

Or genmask_u64(0..=3Dn-1), if we disregard the previous off-by-one error

=E2=80=94 Daniel=

