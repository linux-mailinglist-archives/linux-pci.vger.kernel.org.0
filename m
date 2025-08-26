Return-Path: <linux-pci+bounces-34793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D060B37429
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA91768490B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 21:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422392853EA;
	Tue, 26 Aug 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aqw4MJ2D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C231DA21;
	Tue, 26 Aug 2025 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756242060; cv=none; b=Jo8J8X3ZytqbvSTsIOdgonRRm17eWdW7Byp8NYmMZt9y3GxobTRtIEyMhQHD1NWDjWptHe6ziwiu6hR0B36Ct3a7d3+4PhxZpeljNUA0XxFfR8KhoBOheeFDzhHFYX4m8NfjppR9Fa2addwH7fUwfurG8+vgXoGum4YWhT8XTZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756242060; c=relaxed/simple;
	bh=AM4QTX/jnq7zICEFB4XveBjYV48d+rGYsnq2fA0OB8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=am537Z8MimCHTmz3OQ7vLKQt2CP5QLwyuJGL+tiibSPGrrhwLfOMdqiQX3z8JTcuNZNnhK7AsWgrkdt8iRTnLKD/6QbS6fzb1lbYul//0gK5Sgz4mBNQBnmOMuAzIy0UNDHAAGqK98q6T3A8StshWZwbbhdlDHbFO91idZbHvNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aqw4MJ2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6923EC4CEF1;
	Tue, 26 Aug 2025 21:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756242059;
	bh=AM4QTX/jnq7zICEFB4XveBjYV48d+rGYsnq2fA0OB8U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Aqw4MJ2DDarCJ1O1tCb8L6v0hXZJ+4VHRWm4wm/lGRwbWrHUjbFshW3LPhJdzQtNY
	 /r476FNwV/e4XP/n7684z75FTRl69CgL3STtnKJfaa3dc2+Fkdf27hihxPO0/eLHhn
	 aNjqxiib4MgUZcMVcyocZZTjoUqHftnSQnptw2Y2F3nv/Z7UhQ6yw/2S7PvpZJtVp7
	 RRCam6pPs6LnqB1DRJGKWlgdCgoRbr2v9+cOOxl39kY89MbOSrMWhadb7lUKTzU8G6
	 M137S8d6p6ZFGoczaDU3G2nVoRVUEK/aqdS6XZs/JuPSlEd+DHBgQHosmB/vqyxEgk
	 EGV10uodY4cfg==
Message-ID: <c137a383-6dec-4031-af45-0da821574f38@kernel.org>
Date: Tue, 26 Aug 2025 23:00:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] rust: pci: provide access to PCI Vendor values
To: John Hubbard <jhubbard@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Elle Rhumsaa <elle@weathered-steel.dev>
References: <20250822020354.357406-1-jhubbard@nvidia.com>
 <20250822020354.357406-3-jhubbard@nvidia.com>
 <DCBIF83RP6G8.1B97Z24RQ0T24@nvidia.com>
 <DCBIPY9UJTT4.ETBXLTRGJWHO@kernel.org>
 <b1cbdc99-317e-454c-bf03-d6793be5b13c@nvidia.com>
 <54b19bdc-5d88-4f71-ad8e-886847ccee8a@kernel.org>
 <65072e90-a1cd-43bb-bc31-04b16947113f@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <65072e90-a1cd-43bb-bc31-04b16947113f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 10:58 PM, John Hubbard wrote:
> I have no idea "where appropriate" is, here. These are not hot paths, and
> the existing pci.rs methods such as Device::vendor_id() are not inlined,
> and so my initial approach is to just not inline any of this...

I think we can inline those functions that only consist out of a single 
constructor (i.e. Self {...}) or a single function call either way.

