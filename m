Return-Path: <linux-pci+bounces-27066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BBFAA5FD4
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 16:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93150189996C
	for <lists+linux-pci@lfdr.de>; Thu,  1 May 2025 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549F41F12F6;
	Thu,  1 May 2025 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX1EYALE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF31F0E25;
	Thu,  1 May 2025 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746109301; cv=none; b=bDsuPZDnI5TGdhDf6BRcknXpqfOVaGRzdC86wqgMC1zVWCX3sP1/ED4tH9w3p0PjsWU/LWbfHFOzloJQKFtQn6A47cIjmt2MUZNotaR+gL+c+W190OY85gKdw3aX6KmjOOSLE5FYOvZmO3c8IIQjvgCSMxhA5AeuyuKKqNYlduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746109301; c=relaxed/simple;
	bh=/PfknfpscdqV4dM+Qa2VHQC3DJh8P7ZrGvKsnMyvDz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTMJ8U3C72BiPUbcGpcmPO2U7LAVExuxgdXyUHmpLj4YjUQtfDrCk98hfEShtyQHIpKL1fzintwmfOU/LnQ0YdVDm8yYEH15OcvcmPSNEELwRTu0c7wU1l47vUC/AqiTmMJSHVrlWL/34ygzw/yN+h6sCMIx770hyBfsfcJaQ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX1EYALE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4264C4CEE3;
	Thu,  1 May 2025 14:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746109300;
	bh=/PfknfpscdqV4dM+Qa2VHQC3DJh8P7ZrGvKsnMyvDz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jX1EYALEvIqC0Bxhi9h4V3XLg9t48U8FLNln9Vu7JIwu6TW/EVJvQcDazV5IkNhTZ
	 NJLZP1BWlfp3ZeeTwe4Cq1VLP74ofrPkE8dq0qzIgFFnxXO/Cz/R8zaU5ePkHLeKA9
	 U55mZdhu5Xx4j7M5qiEUU8ABFPpLeulBZxNlLmXbA02ThlxiUMxw5jVRl8sHhxU3yS
	 ln6RxMhPiMHq16s75afSzq7sgF+sr0rXlKVyNsA0LwUgt62nd3xX5EOG4ukh4NL8hh
	 R751sTQd+sUXWzeEy6qAhVBFw+0ei1rW6q+gMKc4vDtLbNLsTdA7Q4MzT8e1hArIZN
	 WpPHOyZenIZNg==
From: Miguel Ojeda <ojeda@kernel.org>
To: dakr@kernel.org
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	acurrid@nvidia.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	bskeggs@nvidia.com,
	chrisi.schrefl@gmail.com,
	cjia@nvidia.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	jhubbard@nvidia.com,
	joelagnelf@nvidia.com,
	kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	ojeda@kernel.org,
	rafael@kernel.org,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu,
	ttabi@nvidia.com,
	zhiw@nvidia.com
Subject: Re: [PATCH v2 1/3] rust: revocable: implement Revocable::access()
Date: Thu,  1 May 2025 16:21:23 +0200
Message-ID: <20250501142123.968745-1-ojeda@kernel.org>
In-Reply-To: <20250428140137.468709-2-dakr@kernel.org>
References: <20250428140137.468709-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Apr 2025 16:00:27 +0200 Danilo Krummrich <dakr@kernel.org> wrote:
>
> Implement an unsafe direct accessor for the data stored within the
> Revocable.
>
> This is useful for cases where we can prove that the data stored within
> the Revocable is not and cannot be revoked for the duration of the
> lifetime of the returned reference.
>
> Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

