Return-Path: <linux-pci+bounces-25813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AEAA87DE4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D263ABD73
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D0F270EDA;
	Mon, 14 Apr 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lsvzEPqb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8151726FDBC;
	Mon, 14 Apr 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627510; cv=none; b=uzIUx/X2HZyctmlhyHOZP5G5dK1qmBHJSCju6wBmDe8h1O9NeUbUURJR+go93W5RYXLPsTW7X2wa1D0/GnrNRenXu7c9uhDAOYYpqPgrKZWVSS+/31XXNJt83NumlrqqptnIdtoNFWj0Wvb5jbzunNNc0ey0wwHrJAU+Wf4XjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627510; c=relaxed/simple;
	bh=7uy9eMRZuOCBTH6PqULoEGQAQJwZ8+b7lA619PPOscA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mh6+IqYQCYMTwpk6Y1k8q0wLCvV5taQFdGmL/UoCet5kXbNWGLqLDnE1wDhF4rgOPv81+A0sMd9eNmd9jwOX5MHDmc/+adL5GiXJRCen98vN+KcMltJTOICK/Ur5JZAtLqzIQj7nTK2i/FxgiFLE9PyoschvIJDYpZGWAKMzWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lsvzEPqb; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744627506; x=1744886706;
	bh=l4on0qsiLvSF01phmcJm6c7PO9JFxVQRCMj18MT80Ek=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=lsvzEPqbnW1/1NYBY8n2qbEx8kgtqMZ9wyZR9LahgeXzP+QwD/g7ATCycccZAbPcN
	 GpcFP2som6sWVQWiGMV8ySZdoa4Bnym0JcS9btFAzGZKLiK9GBEM9KevcTyEYSVRTM
	 cpj2B5YrMhyZaj74NAjbgGp5TSw6EQGWJTulMKHFPGvIbWJxaFxTy6lLsBTmdiCinJ
	 XUpPBnPpcUfSulJCA79mjwRugZHofNcdxO9sixjuIYfJNDy7Nid9FqhkaFjIgFXdyt
	 ljXOi2GWl4rY39Ri1x8dOn/LsQESwHMKlSmivgWOUUihHCsxyImSLRebaKzKE2bX2z
	 rKndows4dUAWQ==
Date: Mon, 14 Apr 2025 10:44:59 +0000
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, abdiel.janulgue@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, daniel.almeida@collabora.com, robin.murphy@arm.com, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] rust: pci: move iomap_region() to impl Device<Bound>
Message-ID: <D96ATYAP59UZ.NADPINCXEHV3@proton.me>
In-Reply-To: <20250413173758.12068-8-dakr@kernel.org>
References: <20250413173758.12068-1-dakr@kernel.org> <20250413173758.12068-8-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 00d21e9eb1d36935ef14ce79e87d84c07aae7b27
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Apr 13, 2025 at 7:37 PM CEST, Danilo Krummrich wrote:
> Require the Bound device context to be able to call iomap_region() and
> iomap_region_sized(). Creating I/O mapping requires the device to be
> bound.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/pci.rs | 2 ++
>  1 file changed, 2 insertions(+)


