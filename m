Return-Path: <linux-pci+bounces-34114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F985B285D9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 20:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7255D1CC7A0F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBFC2882CC;
	Fri, 15 Aug 2025 18:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfWgjMLX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F131771D;
	Fri, 15 Aug 2025 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282776; cv=none; b=cEdSuMNvtMeNQ5xfSIveOsDLR31GebrbfSjaSUrkUNgCqpdHObxcCMM05IXdP+YO71Q6ACU8G9xPHsn54Rd5xLJeff71JMNoeACwtAylFFG7n/gkRy7/R5murm5/ferQRFLyMMQnxQg3EAU7J+XaHAon8hw4f3RQzPQVs0udqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282776; c=relaxed/simple;
	bh=07T+It7VH1Rnm9OWwIJCvQzKK97aMp17mAB9ggKDiqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UQn6U5glhBQmbbYp+ZR9rKDsPgLGO70AcGXXdm7fCuNI/PN667Npuv2cMIoXBY3F5lA6QTnz8M7xQ6lQAIS9WibPNcjLaRbyKGaPL8pqFyrMGDku6ohnhAFcT/sOVfHk19y1B5HIzlh8FxvXEdASkybk8UbRZ0YW4vlantC3h2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfWgjMLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECC5C4CEEB;
	Fri, 15 Aug 2025 18:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755282774;
	bh=07T+It7VH1Rnm9OWwIJCvQzKK97aMp17mAB9ggKDiqA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pfWgjMLX0EfaiRYXdtk2n2uruOtuaY3PNO+bDoyLPzKA2zganLKmPAb90cMiC/E2s
	 14sDfdjnMYqpJ/At6N8YrHi5p4iyr1KPSXhl7izxgSZnaaTKYdQ9uv2eefIozw1l0k
	 aQ46JDN04Ka6ZhRRwyk/0+9mqnD/cii6OZPvB9ORxcnFh61jhRzL86hHfaS+umc002
	 etSnLyVQ4dwCCoRPopSdXgH1i4GlBDwhCw9pdAe03PEBNKHF/SkYH+WgFkqq9I5K4r
	 WytXvzeN0xfuVD+nB0Jwq8Y8M4PlZhnEM/aGNBVW79+7AC0IqtiN9Dp8EdpFb35qBx
	 3c2p8q4j6/Ygw==
Message-ID: <82bbfd71-ac7b-4247-ad63-d6c30951bd13@kernel.org>
Date: Fri, 15 Aug 2025 20:32:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
To: Alistair Popple <apopple@nvidia.com>
Cc: rust-for-linux@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250730013417.640593-1-apopple@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250730013417.640593-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/30/25 3:34 AM, Alistair Popple wrote:
> Update the safety comments to be consistent with other safety comments
> in the PCI bindings. Also add an inline compiler hint.
> 
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Alex Gaynor <alex.gaynor@gmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Cc: Benno Lossin <lossin@kernel.org>
> Cc: Andreas Hindborg <a.hindborg@kernel.org>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Trevor Gross <tmgross@umich.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

Applied to driver-core-testing, thanks!

Alistair, do you mind sending a follow-up patch to replace the raw
bindings:resource_size_t return types on resource_start() and resource_len()
with the Rust ResourceSize type?

