Return-Path: <linux-pci+bounces-32271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAC0B077DF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 16:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD09584CAD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54962238C11;
	Wed, 16 Jul 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="iWAd8qqd"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD552376F8;
	Wed, 16 Jul 2025 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675665; cv=pass; b=mO2QzKKFW/yMh3USunXARVmFIH5BKYTB/ufflcG/BNfCyRjPVvG24z7ah2mz7co00HmrVwEOe06f6PyXuYqR5fQMFahdd7LhwET8K3FZFdfKaFsPcS9D7ztBUCvAvR28quXkNI5n6/xHR0jJ5cWCq7XwXNFMX2VXfxfSA9/HGOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675665; c=relaxed/simple;
	bh=t2kEWrL7Z21+5Wg+lC+pKpcQZVKT4/nwJ7+Cdd/dCXY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dBw3ENQ6+UhAKEJge8Pl+2X3NEjvUp16riSbUjAX1jdvh/Kjgd4wQIjsEQFegqQNPPMC4q10RaabBG27gDtshoPcPQeC6K7aPn6w+mEv1GDGI4nB37arRMPEi+uF81FYeadZ9ciw2XXPIfrLkbqpXyrrIWBmX/WYuP0bajlDyyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=iWAd8qqd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752675622; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J6EzrWhFQ836OwG72CXKg6do/ZB/cSNVqpDvoS2qId38GbUVF4Ndkv7bBo9GRPft5LDtYUsV9UQbFiiOXqjJkYdQiU9t2SIU01vOvkABUHa60QBt742Rb9uZ7FwqHw0pVSGBuw1NeRmyFOBSxC7kmlxX0gbQuA7wxlo7iiq6EVg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752675622; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YZd+/+ZcLk+Nto3FvsmdoYdErI8uJ/aqjBOB3zurR6Q=; 
	b=h5CzzENAutcg0Q+/EvRPmaQcDsOYDOvxiVzWdoY9QK4opnEYw52cK49q87NqiqsmPPJGaFhNxQiFZcyJDYe1hasXd3vsziTtDazbYLI3iyMWhWmVtxPLkMGxLQ7YAiQDj4W9bTSkCYxD22tE6vqtVdmiX4a2Y98lFuPTtx02aY8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752675621;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=YZd+/+ZcLk+Nto3FvsmdoYdErI8uJ/aqjBOB3zurR6Q=;
	b=iWAd8qqdB3DEQsII2whfksTDbIaj9ilYGHgyADiSJqB4lUUjxtcD7neAKaQR6WRu
	PgtPxFapZKqid9KA7Lxx/O86XJk+abp3pTL+0stGdo6Oi2q6AjgfoZuiR4ku/JKdS9K
	PQSdVyOT4I4E27lrKh6wpX5GAUN9EyN+InwNQm14=
Received: by mx.zohomail.com with SMTPS id 1752675619142309.7472383717627;
	Wed, 16 Jul 2025 07:20:19 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v7 2/6] rust: irq: add flags module
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250715-topics-tyr-request_irq2-v7-2-d469c0f37c07@collabora.com>
Date: Wed, 16 Jul 2025 11:20:01 -0300
Cc: linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <31EA1044-AA9F-41F1-97E7-D3C582C32167@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-2-d469c0f37c07@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Alice,

[=E2=80=A6]

> +
> +    const fn new(value: u32) -> Self {
> +        build_assert!(value as u64 <=3D c_ulong::MAX as u64);
> +        Self(value as c_ulong)
> +    }
> +}

Sanity check here, is this what you meant?

=E2=80=94 Daniel


