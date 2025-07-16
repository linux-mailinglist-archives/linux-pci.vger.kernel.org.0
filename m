Return-Path: <linux-pci+bounces-32308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D98B07C18
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F4C45070E0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4789E2F533A;
	Wed, 16 Jul 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ZnK/T5QT"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C0B276047;
	Wed, 16 Jul 2025 17:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687206; cv=pass; b=Wlh0w/i8Sx5Mx4ZCGppyD1SW93bt4qJTmO00fNg3m6wo/08yvGSnjRVU77b5fnGsE5fnMFAFKL8l18GwUeYaOrUQhd7fTcSIlMhY2szIlDdJegq4wUiyiepLl3o71QfHYmaK9JdQo+FeQbOBx5p5pL1UwwlGgIG5kni1CTNoAi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687206; c=relaxed/simple;
	bh=eKZ8wn2hExMcKFc/E8Fjc9OlvJEeRJBW49Qu4mEqXVU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=f4wvsLzD/UHpgYQ3965+lT6+m0CZZvUm6IUV0vSuV94RBSLrx3E/Dk4mUrwSpSdiqiNJY/YUdLtnmQG0U3gtSFQtuXJkv3Br8MzF3nsXjjTjmlZRIgfiKoj/SV47vejlL+aB4SCxBgEWPsaX+OJT+odUDu404B58qgsI+eyz6w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ZnK/T5QT; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752687188; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eD4WsbtGcm7lioHTOSA2lS57ZO/PvUtTMzNe1m8KFkGEP+093vJHi2H6g5CuAMpOBs4i9fsx7/MCSJtZ/BALzhAeVDx7Laf0OnmEeyNa/er6Pg0vjdNWhKUgMLPeUqcPOG5D320HdJT4wO6FgWHWB9+Y/IngKMo/pdg+UIWrn2s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752687188; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BT5S3SbZ+apZ/3i1VFodYq7WVuVYZYlgHBmKtWIzlKQ=; 
	b=e4wIXY0nECaepeemfBRUzqmUXkXRNugp504kVm5x1PZEJ66VBnbqM7clNPpLl8UvC53IUJqXWJVA1FzJHcw2BrQ4LI1i1hn1/nR55/HmJJ5bTxG9x1wTGCgSMcZwFVBub/mvLMGzJCOU0oeV6ps/m9qJ/u9qDplvZZbzMmw2Zf8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752687188;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=BT5S3SbZ+apZ/3i1VFodYq7WVuVYZYlgHBmKtWIzlKQ=;
	b=ZnK/T5QTOwn2WUE6wImMBlKLdFDTnH9anvgnSsEM/ujcvjz5u+Fo9NcZMsZljClo
	YjWNNP2+KkCLCjD68d/iIOStw4fKNY4xrzWXUL5uyZIOWpKwuE5XjaPESgMviryXBTO
	NnS4axuQ4CNXlLH0S39WS0x1jyuAvixwSW3JVFqg=
Received: by mx.zohomail.com with SMTPS id 1752687186914234.6296756071389;
	Wed, 16 Jul 2025 10:33:06 -0700 (PDT)
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
In-Reply-To: <20250716150354.51081-3-dakr@kernel.org>
Date: Wed, 16 Jul 2025 14:32:50 -0300
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
Message-Id: <0984E8E7-C442-42E6-A8E7-691616304F6F@collabora.com>
References: <20250716150354.51081-1-dakr@kernel.org>
 <20250716150354.51081-3-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Danilo,

> +    #[inline]
> +    pub const fn new(n: usize) -> Result<Self> {
> +        Ok(Self(match n {
> +            0 =3D> 0,
> +            1..=3D64 =3D> u64::MAX >> (64 - n),
> +            _ =3D> return Err(EINVAL),
> +        }))
> +    }
> +

Isn=E2=80=99t this equivalent to genmask_u64(0..=3Dn) ? See [0].

You should also get a compile-time failure if n is out of bounds by =
default using
genmask.

=E2=80=94 Daniel

[0]: =
https://lore.kernel.org/rust-for-linux/20250714-topics-tyr-genmask2-v9-1-9=
e6422cbadb6@collabora.com/#r=

